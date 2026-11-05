-- PROFILES (extends auth.users)
create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  username text unique not null,
  display_name text,
  avatar_url text,
  created_at timestamptz default now()
);

-- SONGS
create table if not exists public.songs (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  artist text not null,
  album text,
  duration_seconds int,
  cover_url text,
  audio_url text not null,          -- Supabase Storage public URL
  created_at timestamptz default now()
);

-- PLAYLISTS
create table if not exists public.playlists (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references public.profiles(id) on delete cascade,
  name text not null,
  description text,
  cover_url text,
  is_public boolean default false,
  created_at timestamptz default now()
);

-- PLAYLIST_SONGS
create table if not exists public.playlist_songs (
  playlist_id uuid references public.playlists(id) on delete cascade,
  song_id uuid references public.songs(id) on delete cascade,
  position int not null default 0,
  added_at timestamptz default now(),
  primary key (playlist_id, song_id)
);

-- FAVORITES
create table if not exists public.favorites (
  user_id uuid references public.profiles(id) on delete cascade,
  song_id uuid references public.songs(id) on delete cascade,
  created_at timestamptz default now(),
  primary key (user_id, song_id)
);

-- RECENTLY_PLAYED
create table if not exists public.recently_played (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references public.profiles(id) on delete cascade,
  song_id uuid references public.songs(id) on delete cascade,
  played_at timestamptz default now()
);

-- LYRICS
create table if not exists public.lyrics (
  song_id uuid primary key references public.songs(id) on delete cascade,
  content text not null,
  synced_lrc text
);
