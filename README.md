# 🎵 VibeVault — Music Streaming Analytics Platform

A complete data analytics solution combining a relational MySQL database backend with an interactive Power BI dashboard. Models users, artists, songs, and listening behaviour with advanced analytics and visualization.

---

## 📌 Project Overview

| Detail | Info |
|---|---|
| **Database** | MySQL (15 tables) |
| **Analytical Queries** | 10 |
| **Views** | 2 |
| **Indexes** | 5 |
| **Visualization** | Power BI Dashboard |
| **Dashboard Visuals** | 6 (KPI Cards, Bar Charts, Donut, Stacked Bar, Map) |
| **Domain** | Music / Entertainment / Analytics |

---

## 🗂️ Database Schema Design

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

## 📊 Power BI Analytics Dashboard

### Key Performance Indicators

| Metric | Value | Business Context |
|--------|-------|------------------|
| Active Users | 200 | Platform user base |
| Avg. Session Duration | 3.16 min | User engagement indicator |
| Total Streams | 2,000 | Content consumption metric |
| Premium Conversion Rate | 33% | Revenue stream indicator |

### Dashboard Components

**KPI Cards (Row 1)**
- Total Users: 200
- Avg Listening Time: 3.16 min
- Total Streams: 2,000
- Premium Users: 33%

**Analytical Visualizations (Rows 2-3)**

**Top Songs Chart**
- Horizontal bar chart ranked by stream count
- Free Blue Vibes leads with 21 streams
- Data labels for precise values

**Top Artists Chart**
- Artist ranking by follower count
- BTS dominates with 25 followers
- Green color scheme for distinction

**Subscription Mix (Donut Chart)**
- Free: 55.65%
- Premium: 32.5%
- Family: 11.85%
- Percentage labels for clarity

**Streams by Device (Stacked Bar)**
- Mobile: 54% (804 streams)
- Desktop: 39% (584 streams)
- Smart TV: 21% (306 streams)
- Subscription type breakdown within each device

**Geographic Distribution (Bubble Map)**
- North America: 450 streams
- Europe: 380 streams
- Asia-Pacific: 320 streams
- Interactive zoom capability

### Dashboard Features

- **Professional Design:** Dark blue header, white backgrounds, light gray borders
- **Consistent Coloring:** Blue for songs/premium, green for artists, amber/cyan/purple for subscriptions
- **Data Accuracy:** All values pulled directly from MySQL database via Power BI
- **Interactive Filtering:** Optional slicers for date range, subscription type, and device type
- **Quick Insights:** Numbers visible on all charts, no need for legend lookups

---

## 💡 Key Design Decisions

**Database Layer:**
- Listening sessions stored as individual events rather than aggregates — enabling flexible time-based and device-based analysis
- Song features (featured artists) separated from primary artist to avoid redundancy and support many-to-many querying
- Privacy settings on playlists enable access-control simulation similar to real platforms
- Audio formats stored as a separate table to support multiple formats per song without denormalization

**Analytics Layer:**
- Aggregations performed in Power BI for flexibility and maintainability
- Color scheme standardized across all charts for visual consistency
- KPI cards placed prominently for quick decision support
- Geographic analysis included to identify market opportunities

---

## 🚀 Setup Instructions

### Database Setup

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

### Power BI Configuration

1. Open `vibevault.pbix` in Power BI Desktop
2. Configure MySQL connection:
   - Server: localhost (or your MySQL server)
   - Database: VibeVault
   - Username: your MySQL user
3. Refresh all data to populate the dashboard
4. Interact with visualizations and explore insights

---

## 📁 Repository Structure

```
vibeVault/
├── VibeVault.sql              # Full database script (schema + data + queries)
├── ER DIAGRAM.png             # Entity-Relationship diagram
├── vibevault.pbix             # Power BI dashboard file
├── Dashboard_Preview.png      # Static dashboard screenshot
└── README.md
```

---

## 🛠️ Tech Stack

![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)

---
