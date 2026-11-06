begin;

create table public.lasfadan_gallery (
  id uuid primary key default gen_random_uuid(),
  caption text not null check (btrim(caption) <> ''),
  photo_path text not null check (btrim(photo_path) <> ''),
  display_order integer not null default 0,
  published boolean not null default false
);

alter table public.lasfadan_gallery enable row level security;
revoke all on public.lasfadan_gallery from public, anon, authenticated;
grant select on public.lasfadan_gallery to anon, authenticated;

create policy "Read published Lasfadan gallery photos"
  on public.lasfadan_gallery
  for select to anon, authenticated
  using (published);

commit;
