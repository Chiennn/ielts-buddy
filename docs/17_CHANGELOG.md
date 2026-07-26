# 📝 17_CHANGELOG.md

**Version History & Release Notes - IELTS Buddy**

---

## 📌 **Format: [Version] - YYYY-MM-DD**

```
[Version]
Added: New features
Fixed: Bug fixes
Changed: Behavior changes
Deprecated: Soon-to-be removed
Removed: Deleted features
Security: Security fixes
Performance: Performance improvements
```

---

## **[v0.1.0] - 2024-02-09 (MVP Sprint 1-3: Placement Testing)**

### **Added**
- ✅ User Registration + Login (JWT auth)
- ✅ Learner Profile Management
- ✅ Placement Test (Adaptive 15-20 questions)
- ✅ Question Bank (50+ questions, 5 skills)
- ✅ Ollama AI Scoring (qwen2.5:14b)
- ✅ CEFR Level Calculation (A1-C2)
- ✅ Test Result Display
- ✅ Health Check Endpoint
- ✅ API Documentation (OpenAPI 3.0)

### **Technical**
- React 18 + Vite frontend
- Node.js 22 + Express backend
- PostgreSQL 15 + Prisma ORM
- Ollama + qwen2.5:14b
- TailwindCSS for styling
- JWT for authentication
- Docker support

### **Known Limitations**
- Phase 2 (Learning Path) not yet implemented
- No parent account support (1:1 user model)
- Offline mode not yet available
- Speaking/Writing feedback is basic
- No leaderboard or social features

---

## **[v0.2.0] - 2024-02-23 (MVP Sprint 4-5: Learning Path)**

### **Added**
- ✅ Learning Path Generation (personalized based on CEFR)
- ✅ Dashboard (main hub with progress, today's mission)
- ✅ Lesson Management (Foundation → Intermediate → ExamPrep)
- ✅ Daily Mission System (XP rewards)
- ✅ Progress Tracking (per stage)
- ✅ Activity Chart (7-day history)
- ✅ Notifications System
- ✅ Email Notifications (lesson reminders)

### **Fixed**
- User-Learner relationship clarity
- Dashboard response time optimization
- Pagination for large question sets

### **Changed**
- Test attempt state machine (pending → scoring → completed)
- Learning path auto-generation (now async)

### **Deprecated**
- Synchronous scoring endpoint (use async polling instead)

---

## **[v0.3.0] - 2024-03-07 (MVP Sprint 6: Polish + Deployment)**

### **Added**
- ✅ Responsive UI (mobile, tablet, desktop)
- ✅ Accessibility (WCAG AA compliance)
- ✅ Error Recovery (retry logic, graceful degradation)
- ✅ Offline Support (progressive web app features)
- ✅ Performance Optimization (lazy loading, code splitting)
- ✅ Analytics (event tracking, DAU/MAU)
- ✅ Admin Dashboard (user management, question bank)
- ✅ Deployment (Docker, GitHub Actions CI/CD)
- ✅ Monitoring (health checks, logging, alerting)

### **Fixed**
- Font loading (lazy load Be Vietnam Pro)
- Layout shift (CLS optimization)
- Empty state UX (all edge cases covered)
- Error message clarity

### **Security**
- CORS configuration hardened
- SQL injection prevention (Prisma params)
- XSS prevention (React's built-in escaping)
- CSRF tokens for state-changing ops

### **Performance**
- API response time: <100ms (p95)
- First Contentful Paint: <1.5s
- Lighthouse Score: >90
- Bundle size: <150KB (gzipped)

---

## **[v1.0.0] - 2024-03-21 (General Availability)**

### **Added**
- ✅ Parent Account Support (1:many relationship)
- ✅ Multiple Child Profiles (per parent)
- ✅ Parent Dashboard (monitor all children)
- ✅ Certificates (custom CEFR certificates)
- ✅ Leaderboard (school-level competitions)
- ✅ Social Features (friend connections, group learning)
- ✅ Advanced Writing Feedback (AI-powered essay evaluation)
- ✅ Speaking Assessment (audio recording + feedback)
- ✅ Mobile App (React Native - iOS/Android)

### **Changed**
- Auth refactored (separate User + Learner tables)
- API versioning (v1 → v2 endpoints)
- Database schema (v1.0 migration required)

### **Fixed**
- Ollama timeout issues (increased retry logic)
- JWT expiration edge cases
- Learning path progression bugs

### **Security**
- Rate limiting per IP (prevent API abuse)
- Device fingerprinting (prevent account takeover)
- Refresh token rotation (security best practice)

---

## **Roadmap (v2.0+)**

### **v1.1 (Q2 2024)**
- [ ] Refresh Token support (Access + Refresh)
- [ ] WebSocket for real-time notifications
- [ ] Advanced AI Scoring (Claude API integration)
- [ ] Teacher Portal (class management)

### **v2.0 (Q3 2024)**
- [ ] Multilingual Support (Vietnamese, Chinese, Japanese)
- [ ] Mobile App (iOS/Android native)
- [ ] Integration with LMS (Moodle, Canvas)
- [ ] Advanced Analytics (learning outcomes, cohort analysis)

### **v3.0+ (2025+)**
- [ ] AI Tutor (conversational AI for lessons)
- [ ] Gamification (badges, achievements, streaks)
- [ ] API for Third-party Integrations
- [ ] B2B SaaS (school subscription model)

---

## **Git Tagging**

```bash
# MVP Release
git tag -a v0.1.0 -m "MVP: Placement Testing" commit-hash

# Learning Path Release
git tag -a v0.2.0 -m "Learning Path + Dashboard" commit-hash

# Production Release
git tag -a v0.3.0 -m "MVP: Production Ready" commit-hash

git tag -a v1.0.0 -m "General Availability" commit-hash

# View all tags
git tag -l

# Push tags to remote
git push origin --tags
```

---

## **How AI Developers Use This**

1. Read this file before writing code
2. Check current version from package.json
3. When implementing feature → reference target version
4. When fixing bug → mention in commit message which version it affects
5. When changing behavior → update this file first (document before code)

---

## ✅ **Sign-Off**

**Maintainer:** Product Owner
**Last Updated:** [Today]
**Status:** LIVING DOCUMENT (updated after each release)

---

**Keep this file updated. It's your map!**
