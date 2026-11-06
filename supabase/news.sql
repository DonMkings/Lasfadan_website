begin;

create table public.lasfadan_news (
  id uuid primary key default gen_random_uuid(),
  tag text not null default 'News',
  title text not null check (btrim(title) <> ''),
  body text not null check (btrim(body) <> ''),
  display_order integer not null default 0,
  published boolean not null default false
);

alter table public.lasfadan_news enable row level security;
revoke all on public.lasfadan_news from public, anon, authenticated;
grant select on public.lasfadan_news to anon, authenticated;

create policy "Read published Lasfadan news"
  on public.lasfadan_news for select to anon, authenticated
  using (published);

-- Carry over articles currently displayed on the website.
insert into public.lasfadan_news (tag, title, body, display_order, published)
values
  ('Partnership', 'LASTFADAN partners with the Ministry of Wealth Creation', 'A new arrangement will bring subsidised training slots to registered members across Lagos State in the coming year.', 1, true),
  ('Community', 'Members shine at this year’s Lagos Fashion Week', 'Several LASTFADAN designers showed collections on the runway, drawing strong interest from buyers and press.', 2, true),
  ('Membership', 'Registration now open for the new membership year', 'Renewals and new applications are open. Visit the secretariat or contact us to complete your registration.', 3, true);

commit;
