# 📋 19_BACKLOG.md

**Product Backlog - Feature Prioritization**

---

## 🎯 **Backlog Philosophy**

This backlog prevents scope creep. Any feature request goes HERE first, not directly into Sprint.

**Rule:** If it's not in Sprint Plan → it goes in Backlog.

---

## 📊 **Backlog Structure**

```
P0: MVP (Must-Have)
P1: v0.2 (High-Value)
P2: v1.0 (Nice-to-Have)
P3: v2.0+ (Future)
```

---

## 🔴 **P0: MVP (Sprint 1-3 + 4-6)**

**Status:** In Active Development

```
✅ PHASE 1: PLACEMENT TESTING (Sprint 1-3)

[ ] User Registration & Login
[ ] Learner Profile Management
[ ] Placement Test (15-20 adaptive questions)
[ ] Question Bank (50+ questions)
[ ] Ollama AI Scoring
[ ] CEFR Level Calculation
[ ] Test Result Display
[ ] Error Recovery (Ollama timeout, network)
[ ] Health Check Endpoint
[ ] API Documentation (Swagger)

✅ PHASE 2: LEARNING PATH (Sprint 4-6)

[ ] Learning Path Generation
[ ] Dashboard (main hub)
[ ] Lesson Management
[ ] Daily Mission System
[ ] Progress Tracking
[ ] Activity Chart
[ ] Notifications
[ ] Responsive Design (mobile-first)
[ ] Accessibility (WCAG AA)
[ ] Offline Support (PWA basics)

✅ DEPLOYMENT & POLISH (Sprint 6)

[ ] Performance Optimization
[ ] Security Hardening
[ ] CI/CD Pipeline
[ ] Docker Support
[ ] Monitoring & Logging
[ ] Release Documentation
```

---

## 🟠 **P1: v0.2 (High-Value, Post-MVP)**

**Status:** Ready for Implementation (after v0.1 MVP)
**Timeline:** v0.2 (2-3 weeks after MVP launch)

### **P1.1: Flashcard Learning**
```
Description: Users create/study flashcards per lesson
Value: Gamify learning, increase retention
Effort: 3-5 days
Depends on: Phase 2 (dashboard)
Sprint: Q2 2024

Tasks:
- Create Flashcard model
- Flashcard CRUD UI
- Study mode (flip card)
- Spaced repetition algorithm
- Progress tracking
```

### **P1.2: AI Conversation (Chatbot)**
```
Description: AI tutor for conversational English
Value: Personalized feedback, engagement
Effort: 5-7 days
Depends on: Phase 2 + Ollama integration
Sprint: Q2 2024

Tasks:
- WebSocket server for real-time chat
- Conversation prompt engineering
- AI response streaming
- Conversation history
- Feedback generation
- Safety guards (appropriate responses)
```

### **P1.3: Speaking Assessment**
```
Description: Audio recording + AI evaluation
Value: Complete 5-skill assessment
Effort: 4-5 days
Depends on: Audio handling + Ollama
Sprint: Q2 2024

Tasks:
- Audio recording component (WebAPI)
- Audio processing (convert to text)
- Speaking prompt engineering
- Fluency/accent evaluation
- Score calculation
- Speech-to-text integration
```

### **P1.4: Email Notifications**
```
Description: Daily reminders, achievement alerts
Value: Engagement + retention
Effort: 2-3 days
Depends on: Backend email service

Tasks:
- Email service (SendGrid/Resend)
- Notification templates
- Scheduling (daily at user time)
- Unsubscribe support
- Analytics tracking
```

### **P1.5: Analytics Dashboard**
```
Description: Track user engagement, retention, cohort analysis
Value: Understand user behavior
Effort: 3-4 days
Depends on: Event tracking infrastructure

Tasks:
- Event tracking (frontend + backend)
- Analytics aggregation
- Dashboard charts (DAU, MAU, retention)
- Cohort analysis
- Export functionality
```

---

## 🟡 **P2: v1.0 (Nice-to-Have, Production Release)**

**Status:** Planned for v1.0 (3-6 months)
**Timeline:** Q3 2024

### **P2.1: Parent Account Support**
```
Description: One parent account → multiple child profiles
Value: Family learning, school adoption
Effort: 8-10 days
Breaks: Auth system (requires refactor)

Tasks:
- User table (separate from Learner)
- Parent-Child relationship
- Parent dashboard (monitor all children)
- Child switching UI
- Database migration
```

### **P2.2: Leaderboard**
```
Description: School/class leaderboard competitions
Value: Gamification, engagement
Effort: 4-5 days

Tasks:
- Leaderboard scoring
- Weekly/monthly rankings
- Leaderboard UI
- Achievement badges
- Social sharing
```

### **P2.3: Certificates**
```
Description: Downloadable CEFR certificates
Value: Motivation, shareable proof
Effort: 2-3 days

Tasks:
- Certificate template design
- PDF generation
- Personalization
- Download/email option
```

### **P2.4: Gamification**
```
Description: Streaks, achievements, rewards
Value: Habit formation, engagement
Effort: 5-7 days

Tasks:
- Streak tracking
- Achievement system
- XP/point allocation
- Reward animations
- Progress visualization
```

### **P2.5: Advanced Writing Feedback**
```
Description: Essay evaluation with detailed feedback
Value: Complete writing assessment
Effort: 6-8 days
Depends on: Better AI model

Tasks:
- Writing rubric definition
- Grammar checking
- Structure analysis
- Vocabulary feedback
- Score breakdown
```

---

## 🔵 **P3: v2.0+ (Future Vision, 6+ months)**

**Status:** Exploratory
**Timeline:** 2025+

### **P3.1: Mobile App (Native)**
```
Description: iOS/Android native app (not just web)
Value: App store presence, offline-first
Effort: 20-30 days (per platform)
Tech: React Native or Flutter

Depends on: v1.0 stable MVP
```

### **P3.2: Multi-Language Support**
```
Description: Vietnamese, Chinese, Japanese, etc.
Value: International market
Effort: 10-15 days (per language)

Tasks:
- i18n framework (next-i18n)
- Translation management
- RTL support (Arabic)
- Language switching UI
```

### **P3.3: Teacher Portal**
```
Description: Teachers manage classes, assign tests
Value: School adoption
Effort: 20-25 days

Tasks:
- Teacher authentication
- Class management
- Student roster
- Assignment creation
- Grade book
- Report generation
```

### **P3.4: Integration with LMS**
```
Description: Connect to Moodle, Canvas, Google Classroom
Value: Enterprise adoption
Effort: 15-20 days

Tasks:
- LTI (Learning Tools Interoperability)
- Grade sync
- User provisioning
- SSO support
```

### **P3.5: Advanced Analytics**
```
Description: Learning outcomes, cohort analysis, retention
Value: Data-driven decisions
Effort: 15-20 days

Tasks:
- Cohort analysis
- Learning path optimization
- Predictive analytics (who will drop out?)
- Custom reports
```

### **P3.6: AI Tutor (Conversational)**
```
Description: Full conversational AI tutor, not just chatbot
Value: Personalized 1-on-1 instruction
Effort: 25-30 days
Tech: Advanced prompting, multi-turn conversations

Tasks:
- Dialog management
- Student modeling
- Adaptive difficulty
- Misconception detection
- Hints and scaffolding
```

### **P3.7: API for Third-Parties**
```
Description: Public API for schools/partners
Value: Ecosystem
Effort: 10-15 days

Tasks:
- API authentication (OAuth2)
- Rate limiting
- Documentation
- SDK generation
- Support
```

---

## 📈 **Backlog Voting Board**

When proposing a feature, consider:

| Factor | Weight | Questions |
|--------|--------|-----------|
| **User Value** | 40% | Will users love this? |
| **Implementation Effort** | 30% | How much work? |
| **Strategic Fit** | 20% | Aligns with roadmap? |
| **Dependencies** | 10% | Blocks other features? |

---

## 🔄 **Backlog Management Rules**

1. **New Feature Request** → Add to appropriate P-level
2. **Weekly Refinement** → Discuss with team (30 min)
3. **Sprint Planning** → Pull top items into Sprint
4. **No Direct Sprint Changes** → All changes via backlog
5. **Quarterly Review** → Re-prioritize based on learning

---

## 📝 **How to Add New Feature**

Template:
```markdown
### [Feature Name]
Description: One sentence
Value: Why users want this
Effort: XL (in days)
Dependencies: Other features needed first

Tasks:
- Task 1
- Task 2
```

---

## ✅ **Sign-Off**

**Product Owner:** [Name]
**Last Updated:** [Date]
**Version:** 1.0
**Status:** ACTIVE - Reviewed weekly

---

**Remember: Backlog is not "all features". It's "features we'll do, just not NOW."**
