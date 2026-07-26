# 🐛 18_KNOWN_ISSUES.md

**Known Issues, Bugs & Limitations Tracker**

---

## 📋 **Format**

```
## [Issue ID] - [Summary]
Status: [Open | In Progress | Blocked | Closed]
Priority: [P0-Critical | P1-High | P2-Medium | P3-Low]
Assigned: [Owner]
Workaround: [If available]
Fix ETA: [When it will be fixed]
```

---

## 🔴 **CRITICAL (P0) - BLOCK DEPLOYMENT**

### [ISSUE-001] Ollama Timeout on High Concurrent Load
**Status:** Open
**Priority:** P0
**Assigned:** Backend Team
**Description:** When 5+ users submit tests simultaneously, Ollama times out (30s limit).
**Root Cause:** qwen2.5:14b is single-threaded; needs queue system.
**Workaround:** Current: Retry after 2 seconds (exponential backoff). User sees "Please wait..." message.
**Fix:** Implement job queue (Bull + Redis) to serialize scoring tasks.
**Fix ETA:** Sprint 4
**Test Case:** Submit 5 tests simultaneously, expect all complete within 2 min.

---

### [ISSUE-002] Database Migration Lock on PostgreSQL
**Status:** Open
**Priority:** P0
**Assigned:** DevOps
**Description:** Running `prisma migrate deploy` locks entire database during schema changes.
**Root Cause:** Prisma locks whole schema; PostgreSQL doesn't support zero-downtime migrations out of box.
**Workaround:** Run migrations during maintenance window (low traffic hours).
**Fix:** Implement Prisma zero-downtime migrations using liquibase or custom strategy.
**Fix ETA:** Sprint 5
**Test Case:** Deploy schema change without downtime during user activity.

---

### [ISSUE-003] AI Scoring Inconsistency
**Status:** Open
**Priority:** P0
**Assigned:** AI Team
**Description:** Same question answered identically gives different scores on different days (qwen2.5 temperature variation).
**Root Cause:** Ollama default temperature=0.7 introduces randomness in scoring.
**Workaround:** Set temperature=0 for deterministic scoring (but less natural responses).
**Fix:** Implement scoring with temperature=0 + human spot-checks.
**Fix ETA:** Sprint 3
**Test Case:** Score same test 10 times, check confidence interval is <±2 points.

---

## 🟠 **HIGH (P1) - FIX BEFORE PUBLIC**

### [ISSUE-004] Empty State Not Shown on First Load
**Status:** In Progress (Developer: Frontend)
**Priority:** P1
**Assigned:** Frontend Lead
**Description:** Dashboard shows loading state forever if learner has zero lessons.
**Root Cause:** Missing null check in `LearningPath` query response.
**Workaround:** Refresh page (F5) forces refetch.
**Fix:** Add fallback empty state when `learningPath === null`.
**Fix ETA:** Sprint 2 (2 days)
**Test Case:** New user → complete test → check dashboard shows empty state CTA.

---

### [ISSUE-005] JWT Token Not Refreshed on Close/Reopen
**Status:** Open
**Priority:** P1
**Assigned:** Backend
**Description:** Close browser → reopen app → token still valid (7 days!). Stolen token = 7 days of access.
**Root Cause:** No refresh token mechanism; JWT is long-lived.
**Workaround:** Manually clear localStorage + sign in again.
**Fix:** Implement access token (15 min) + refresh token (7 days) pattern.
**Fix ETA:** Sprint 4 (v1.1)
**Test Case:** Steal token from localStorage → can access API for full 7 days (expected; improved in v1.1).

---

### [ISSUE-006] Ollama Model Not Auto-Downloaded on Startup
**Status:** Open
**Priority:** P1
**Assigned:** DevOps
**Description:** If qwen2.5:14b not cached locally, API fails with "Model not found".
**Root Cause:** Docker setup doesn't guarantee model download before app starts.
**Workaround:** Run `ollama pull qwen2.5:14b` manually in container.
**Fix:** Add entrypoint script that blocks until model available.
**Fix ETA:** Sprint 2
**Test Case:** Fresh Docker container → app starts → API ready in <1 min.

---

### [ISSUE-007] No Pagination for Question Bank (Will Slow Down Later)
**Status:** Open
**Priority:** P1
**Assigned:** Backend
**Description:** API returns all 50 questions at once. If we grow to 1000 questions, API times out.
**Root Cause:** No pagination implemented on `GET /questions`.
**Workaround:** Limit to 50 questions for MVP (acceptable).
**Fix:** Add offset/limit pagination (or cursor-based).
**Fix ETA:** Sprint 5 (when question bank grows)
**Test Case:** GET /questions with 1000 items → returns 50 at a time + next cursor.

---

## 🟡 **MEDIUM (P2) - FIX IN NEXT SPRINT**

### [ISSUE-008] Mobile UI: Button Text Overflow
**Status:** Open
**Priority:** P2
**Assigned:** Frontend
**Description:** "Start Placement Test" button text overflows on iPhone SE (375px).
**Root Cause:** Button text not wrapped; button width fixed.
**Workaround:** Rotate phone to landscape (text fits).
**Fix:** Use flex-wrap + responsive font size.
**Fix ETA:** Sprint 2
**Test Case:** iPhone SE (375px) → all button text readable without overflow.

---

### [ISSUE-009] Ollama Response Time > 30 seconds for Complex Writing Prompts
**Status:** Open
**Priority:** P2
**Assigned:** AI Team
**Description:** Writing questions (500+ tokens) take 30-50 seconds to score.
**Root Cause:** qwen2.5:14b slower on complex reasoning; no response caching.
**Workaround:** Show progress bar + "AI is analyzing..." message to manage expectations.
**Fix:** Implement response caching (Redis) + consider faster model.
**Fix ETA:** Sprint 4
**Test Case:** Writing question → score time < 20 seconds.

---

### [ISSUE-010] No Offline Mode Yet
**Status:** Open
**Priority:** P2
**Assigned:** Frontend
**Description:** App requires internet. Taking test without WiFi = data loss.
**Root Cause:** No Service Worker; no local caching strategy.
**Workaround:** Ensure WiFi connection before taking test.
**Fix:** Implement PWA + offline sync.
**Fix ETA:** v0.3.0 (Sprint 6)
**Test Case:** Turn off WiFi → can view dashboard + take test → turn on WiFi → auto-sync.

---

## 🔵 **LOW (P3) - NICE TO HAVE**

### [ISSUE-011] Lighthouse Performance Score 87 (Goal: 95)
**Status:** Open
**Priority:** P3
**Assigned:** Frontend Performance
**Description:** Lighthouse score is 87 due to unused CSS in TailwindCSS bundle.
**Workaround:** Works fine; just not optimal.
**Fix:** Enable TailwindCSS PurgeCSS for production builds.
**Fix ETA:** Sprint 3 (nice-to-have)
**Test Case:** npm run build → Lighthouse score > 95.

---

### [ISSUE-012] No Analytics Events Yet
**Status:** Open
**Priority:** P3
**Assigned:** Analytics Team
**Description:** Can't track user behavior (funnel analysis, retention, etc.).
**Workaround:** None; accept blind MVP.
**Fix:** Add event tracking (Google Analytics or Mixpanel).
**Fix ETA:** v1.0 (post-MVP analysis)
**Test Case:** Can view dashboard with daily active users, retention curves.

---

### [ISSUE-013] CEFR Level Display Not Localized (Vietnamese)
**Status:** Open
**Priority:** P3
**Assigned:** Frontend i18n
**Description:** CEFR explanation (A1 = Beginner) is in English only.
**Workaround:** Users understand A1-C2 meaning.
**Fix:** Add Vietnamese translations in language file.
**Fix ETA:** v0.2.0 (Phase 2)

---

## ✅ **RESOLVED (CLOSED)**

### [ISSUE-000] Prisma Syntax Error in Question Model
**Status:** Closed (Fixed in v6)
**Priority:** P0
**Assigned:** Database Team
**Description:** `createdAt DateTime` should be `createdAt DateTime @default(now())`.
**Root Cause:** Copy-paste error in 05_DATABASE.md.
**Fix:** Updated schema in v6 of docs.
**Fix Commit:** `docs: fix prisma syntax in question model`
**Resolved Date:** [Today]

---

## 📊 **Issue Summary**

| Priority | Count | Status |
|----------|-------|--------|
| P0 (Critical) | 3 | Must fix before deploy |
| P1 (High) | 4 | Fix in Sprint 2-4 |
| P2 (Medium) | 3 | Fix in next sprint |
| P3 (Low) | 3 | Nice-to-have |
| **Total** | **13** | - |

---

## 🎯 **How to Use This Document**

1. **Before Sprint Planning:** Check P0 + P1 issues
2. **When Bug Found:** Add new issue with template
3. **When Fixing Bug:** Update status + link commit
4. **When Releasing:** Close resolved issues
5. **QA Testing:** Use as test case reference

---

## 📝 **Adding New Issues**

```markdown
### [ISSUE-XXX] - [Summary]
**Status:** Open
**Priority:** [P0-P3]
**Assigned:** [Name]
**Description:** What's the problem?
**Root Cause:** Why does it happen?
**Workaround:** How to avoid it now?
**Fix:** How will we solve it?
**Fix ETA:** When will we fix it?
**Test Case:** How to verify it's fixed?
```

---

## ✅ **Sign-Off**

**Document Owner:** QA Lead
**Last Updated:** [Today]
**Review Frequency:** Weekly (every Sprint Planning)
**Version:** 1.0

---

**Remember: Known issues are not problems; hidden issues are!**
