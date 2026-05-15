# 🎵 VibeVault — Music Streaming Database (SQL)

A relational database system designed to simulate the backend of a music streaming platform — modelling users, artists, songs, playlists, and listening behaviour. Built entirely in MySQL with a focus on schema design, business-driven queries, and performance optimization.

---

## 📌 Project Overview

| Detail | Info |
|---|---|
| **Database** | MySQL |
| **Tables** | 15 |
| **Analytical Queries** | 10 |
| **Views** | 2 |
| **Indexes** | 5 |
| **Domain** | Music / Entertainment |

---

## 🗂️ Schema Design

The database models a complete music streaming ecosystem across 15 tables:

| Table | Description |
|---|---|
| `Users` | User profiles with subscription type (free / premium / family) and location |
| `Artists` | Artist records with stage name and real name |
| `Songs` | Song catalogue with duration, release date, and primary artist |
| `Albums` | Album records linked to artists |
| `Album_Songs` | Junction table mapping songs to albums with track numbers |
| `Playlists` | User-created playlists with public/private privacy settings |
| `Playlist_Songs` | Songs within each playlist with position ordering |
| `Listening_Sessions` | Every stream event — user, song, device, timestamp, and duration |
| `Song_Features` | Featured artists on a song (many-to-many) |
| `User_Follows_Artist` | Artist follow relationships |
| `User_Follows_Playlist` | Playlist follow relationships |
| `Artist_Genre` | Genre tags per artist |
| `Song_Formats` | Audio format availability per song (MP3, FLAC, WAV, AAC) |
| `Artist_Social_Links` | Social media links per artist |
| `User_Devices` | Registered devices per user |

> 📎 See the full ER diagram: [`ER DIAGRAM.png`](./ER%20DIAGRAM.png)

---

## 🔍 Business Queries

10 analytical queries answering real streaming platform business questions:

| # | Question |
|---|---|
| Q1 | What are the top 5 most streamed songs? |
| Q2 | How do streams and session duration vary by subscription type? |
| Q3 | Which artists have the most followers? |
| Q4 | Which device type drives the most streams? |
| Q5 | Who are the top 5 users by total listening time? |
| Q6 | Which songs have never been streamed? |
| Q7 | What is the average song duration by genre? |
| Q8 | Which countries generate the most streams? |
| Q9 | Which artists have no streams on any of their songs? |
| Q10 | What is the stream share split between premium and free users? |

---

## ⚙️ Database Features

- **Views** — `vw_premium_users` and `vw_song_details` for reusable query logic
- **Indexes** — on `Songs.title`, `Artists.stage_name`, `Listening_Sessions.user_id`, `Listening_Sessions.song_id`, and `Users.email` for query performance
- **Foreign key constraints** — enforced across all relationships
- **ENUM types** — used for subscription type, device type, and audio format to maintain data integrity
- **Sample data** — 15 users, 15 artists, 15 songs, 10 playlists, and 30 listening sessions included

---

## 🚀 How to Run

1. Open MySQL Workbench or any MySQL client
2. Run the full `VibeVault.sql` file:

```sql
SOURCE VibeVault.sql;
```

3. The script will:
   - Create the `VibeVault` database
   - Build all 15 tables
   - Insert sample data
   - Execute the 10 analytical queries
   - Create views and indexes

---

## 🛠️ Tech Stack

![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)

---

## 📁 Repository Structure

```
vibeVault/
├── VibeVault.sql       # Full database script (schema + data + queries)
├── ER DIAGRAM.png      # Entity-Relationship diagram
└── README.md
```

---

## 💡 Key Design Decisions

- Listening sessions are stored as individual events rather than aggregates — enabling flexible time-based and device-based analysis
- Song features (featured artists) are separated from primary artist to avoid redundancy and support many-to-many querying
- Privacy settings on playlists enable access-control simulation similar to real platforms
- Audio formats are stored as a separate table to support multiple formats per song without denormalization
