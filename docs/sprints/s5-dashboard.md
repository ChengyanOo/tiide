# Sprint 5 — Dashboard + Trigger Analysis

**Goal**: surface patterns from ≥10 sessions.
**Duration**: 2 weeks.

## Tasks

### S5.1 Dashboard home
- [ ] Weekly session count
- [ ] Total sit-time (minutes)
- [ ] Streak ("days sat with it")
- **DoD**: numbers update reactively.

### S5.2 Charts
- [ ] Sessions per tag (bar)
- [ ] Time-of-day heatmap (7×24)
- [ ] Duration distribution
- **DoD**: `fl_chart` renders on both platforms.

### S5.3 Geo clustering
- [ ] DBSCAN over session start points (ε ≈ 150 m)
- [ ] Persist `geo_clusters`; assign sessions
- [ ] User-rename clusters ("home", "office")
- **DoD**: stable clusters across app restarts.

### S5.4 Trigger insights
- [ ] Rule-based v1:
  - most-frequent day × time-band
  - tag-correlated HRV drop
  - cluster-correlated session count
- [ ] Insight card list on dashboard
- **DoD**: ≥3 insight types render when data sufficient.

### S5.5 Session detail
- [ ] Tags, note, map pin, biometric chart
- [ ] Calming-visual replay scaled to actual duration
- **DoD**: detail reachable from list + dashboard.

## Deliverables
- Full analytics surface.
- Insight engine wired to live data.
