# README

## Overview
This application gathers NBA stats from various sources and uses a formula with predicted minutes to project a player's performance outcome.

## How to Use
Once the app is running, you can project player stats through the following steps:

1. **Player Stats Upload**  
   - Navigate to the `/players` route and click **Upload** (no file upload required).

2. **Defense vs. Position (DVP) Upload**  
   - Visit the `/dvp` route and click **Upload**.

3. **Import DraftKings Salary Sheet**  
   - Go to the `/salaries` route.
   - Import a **CSV DraftKings salary sheet** downloaded from the player selection in a DraftKings contest.

4. **Upload Predicted Minutes**  
   - Navigate to the `/upload_minutes` route.
   - Click **Upload** to use predicted minutes from Sportsline.com to generate results.

5. **Position-Based Projections**  
   - Click on a player position (for players with multiple positions) to generate projections for the selected position.

---
