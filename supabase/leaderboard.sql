create table public.grand_line_scores (
 id bigint generated always as identity primary key,
 username text not null check (username = btrim(username) and char_length(username) between 1 and 20 and username !~ '[[:cntrl:]]'),
 username_key text generated always as (lower(username)) stored,
 highest_round integer not null check (highest_round between 1 and 100000),
 marine_kills integer not null check (marine_kills between 0 and 10000000),
 submitted_at timestamptz not null default now()
);
alter table public.grand_line_scores enable row level security;
revoke all on public.grand_line_scores from anon, authenticated;
grant select on public.grand_line_scores to anon, authenticated;
grant insert (username,highest_round,marine_kills) on public.grand_line_scores to anon, authenticated;
grant usage on sequence public.grand_line_scores_id_seq to anon, authenticated;
create policy "Anyone can read game scores" on public.grand_line_scores for select to anon, authenticated using (true);
create policy "Anyone can submit a validated game score" on public.grand_line_scores for insert to anon, authenticated with check (true);
create index grand_line_scores_ranking on public.grand_line_scores (username_key, highest_round desc, marine_kills desc, id);
create function public.grand_line_leaderboard(page_offset integer default 0)
returns table (rank bigint, username text, highest_round integer, marine_kills integer)
language sql stable security invoker set search_path = '' as $$
 with best as (
 select distinct on (s.username_key) s.username_key, s.username, s.highest_round, s.marine_kills
 from public.grand_line_scores s
 order by s.username_key, s.highest_round desc, s.marine_kills desc, s.id
 ), ranked as (
 select row_number() over (order by b.highest_round desc,b.marine_kills desc,b.username_key) as rank,
 b.username,b.highest_round,b.marine_kills from best b
 )
 select * from ranked order by rank limit 100 offset greatest(0,least(page_offset,10000000));
$$;
revoke all on function public.grand_line_leaderboard(integer) from public;
grant execute on function public.grand_line_leaderboard(integer) to anon, authenticated;