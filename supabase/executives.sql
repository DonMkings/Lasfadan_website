begin;

create table public.lasfadan_executives (
  id uuid primary key default gen_random_uuid(),
  name text not null check (length(btrim(name)) > 0),
  office text not null check (length(btrim(office)) > 0),
  title text not null default '',
  photo_path text,
  display_order integer not null default 0,
  published boolean not null default false
);

alter table public.lasfadan_executives enable row level security;
revoke all on public.lasfadan_executives from public, anon, authenticated;
grant select on public.lasfadan_executives to anon, authenticated;

create policy "Read published Lasfadan executives"
  on public.lasfadan_executives
  for select to anon, authenticated
  using (published);

commit;
