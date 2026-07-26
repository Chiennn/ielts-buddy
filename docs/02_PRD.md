# 📋 02_PRD.md

**Product Requirements Document - IELTS Buddy MVP**

---

## 📑 **Table of Contents**

1. Introduction
2. Features List
3. User Stories
4. Feature Details
5. Out of Scope (MVP)
6. Constraints & Assumptions

---

## 1. Introduction

**Product:** IELTS Buddy v1.0  
**Version:** MVP  
**Release Date:** TBD (28 days / ~4 weeks)  
**Timeline:** Sprint 1 (3 days) + Sprint 2-6 (5 days each) = 28 days total  
**Platforms:** Web (Responsive: Mobile 375px → Desktop 1920px)

---

## 2. Features List (MVP)

### **Core Features**

| # | Feature | Sprint | Priority |
|---|---------|--------|----------|
| 1 | Authentication (Register/Login) | S1 | P0 |
| 2 | Learner Management | S1 | P0 |
| 3 | Placement Test (Adaptive 15-20 câu) | S2 | P0 |
| 4 | AI Scoring (MCQ auto + Ollama) | S3 | P0 |
| 5 | Result Display (CEFR + Skills) | S4 | P0 |
| 6 | Dashboard (Progress + Tasks) | S4 | P1 |
| 7 | Learning Path (3 stages) | S4 | P1 |
| 8 | Responsive UI | S5 | P0 |
| 9 | Testing & Bug Fixes | S6 | P0 |

---

## 2.5 **Definition of Ready (When AI Can Code)**

Before AI starts coding any task, the following must be complete:

```
✓ PRD finalized and documented
✓ API specification complete (endpoints, request/response)
✓ Database schema finalized (Prisma models)
✓ UI/UX design complete (wireframes/mockups for the feature)
✓ Acceptance Criteria defined and clear
✓ Related documents reviewed (this PRD + API + DB + UI docs)
✓ No contradictions in documentation
✓ Task scope is clear and isolated (1 feature per sprint)
```

**If any of above is missing:** AI MUST STOP and report to Product Owner.

---

## 3. User Stories

### **US-001: Register & Create Profile**

```
AS A           Student or Parent
I WANT TO      Register with email/password
SO THAT        I can save my progress

ACCEPTANCE CRITERIA
□ Email validation (RFC 5322)
□ Password minimum 8 chars
□ Error messages clear
□ Auto-login after registration
□ Redirect to welcome page
```

### **US-002: Select/Manage Learners**

```
AS A           Parent
I WANT TO      Create multiple child profiles
SO THAT        I can track each child separately

ACCEPTANCE CRITERIA
□ Add up to 5 children
□ Edit name, grade, target IELTS
□ Delete child (with confirmation)
□ Switch between children without re-login
```

### **US-003: Start Placement Test (Adaptive)**

```
AS A           Student
I WANT TO      Take an adaptive placement test
SO THAT        I can determine my CEFR level (15-20 questions, ~10-15 min)

PLACEMENT TEST STRUCTURE
✓ Adaptive: AI increases/decreases difficulty based on answers
✓ MCQ questions: 12-14 questions (Reading, Grammar, Listening)
✓ Speaking: 1 question (text input)
✓ Writing: 1-2 questions (optional for MVP)
✓ Total: 15-20 questions adaptive

ACCEPTANCE CRITERIA
□ Welcome screen with 3-step explanation
□ "Get Started" button → Test page
□ Display 1 question at a time
□ Progress bar (1/15, 2/15... up to 20/20)
□ Can navigate: Previous / Next / Submit
□ Submit button only on last question
□ Save answers to database
□ Adaptive difficulty: based on previous answers
□ Time tracking (optional: show elapsed time)
```

### **US-004: Answer Different Question Types**

```
AS A           Student
I WANT TO      Answer different question types
SO THAT        All 4 skills are assessed fairly

QUESTION TYPE DISTRIBUTION
✓ Reading (MCQ)      → 4-5 questions, choose 1 of 4 options
✓ Grammar (MCQ)      → 4-5 questions, choose 1 of 4 options
✓ Listening (MCQ)    → 4-5 questions, choose 1 of 4 options
✓ Speaking (Text)    → 1 question, type what I would say
✓ Writing (Textarea) → 1-2 questions, write 80-150 words

ADAPTIVE DIFFICULTY
✓ Easy (A1-A2): Simple vocabulary, short text
✓ Medium (B1-B2): Standard vocabulary, medium text
✓ Hard (C1-C2): Advanced vocabulary, complex structures

ACCEPTANCE CRITERIA
□ Each type has appropriate UI
□ Input validation (e.g., writing min 50 words)
□ Real-time character count for writing
□ Audio placeholder for listening (MVP: text description)
□ Difficulty adjusts based on correctness
□ Question randomization (same type, different content)
```
□ Answers auto-saved on every change
□ Can go back and edit
```

### **US-005: Auto-Score & Analyze**

```
AS A           System
I WANT TO      Score the test and determine CEFR
SO THAT        User sees their level

SCORING LOGIC
✓ Reading (MCQ)  → 0 or 100 points (correct answer)
✓ Grammar (MCQ)  → 0 or 100 points
✓ Listening (MCQ) → 0 or 100 points
✓ Writing (Text) → Ollama scores 1-9 band → convert to 10-90 scale
✓ Speaking (Text) → Ollama scores 1-9 band → convert to 10-90 scale

CEFR CALCULATION
Average of 5 scores:
  0-20    → A1
  21-40   → A2
  41-60   → B1
  61-70   → B1+
  71-80   → B2
  81-85   → B2+
  86-95   → C1
  96-100  → C2

ACCEPTANCE CRITERIA
□ MCQ auto-score immediately
□ Ollama call for Writing/Speaking (async)
□ Final CEFR calculated correctly
□ All 5 scores display (even if 0)
□ Result saved to database
```

### **US-006: Display Result**

```
AS A           Student
I WANT TO      See my CEFR level and 4 skill scores
SO THAT        I understand my strengths/weaknesses

ACCEPTANCE CRITERIA
□ CEFR level displayed large (A1, A2, B1, B1+, B2, B2+, C1, C2)
□ 4 skill bars (Reading, Grammar, Listening, Writing) with percentages
□ Visual progress bar for each skill
□ Learning path recommendations (3 stages)
□ Suggested resources (e.g., Cambridge, podcasts)
□ Button "Go to Dashboard" → Dashboard page
□ Can retake test (if allowed)
```

### **US-007: Dashboard**

```
AS A           Student/Parent
I WANT TO      See dashboard with progress and tasks
SO THAT        I can track learning journey

DASHBOARD SECTIONS

1. HEADER
   □ Current CEFR level
   □ Target IELTS (if set)
   □ Total XP (points accumulated)
   □ Learning streak (consecutive days)

2. PROGRESS
   □ Stage 1 (Foundation): 0-33% complete
   □ Stage 2 (Advanced): 0-33% complete
   □ Stage 3 (Exam Prep): 0-33% complete

3. TODAY'S TASKS
   □ 3-5 daily quests (e.g., "Learn 10 vocabulary words")
   □ Each task: title, description, checkbox
   □ Completed tasks struck through
   □ XP reward shown

4. ACTIVITY CHART
   □ Last 7 days bar chart
   □ X-axis: Days (Mon-Sun)
   □ Y-axis: Minutes learned
   □ Color: Green (active), gray (no activity)

5. ACTIONS
   □ "Take Test Again" button
   □ "Start Learning Stage" button
   □ "View Resources" link

ACCEPTANCE CRITERIA
□ All sections responsive
□ Data accurate from database
□ Real-time update (no refresh needed for new tasks)
```

### **US-008: Learning Path**

```
AS A           Student
I WANT TO      See a clear learning path with 3 stages
SO THAT        I know what to study next

LEARNING PATH

Stage 1: Foundation (A1 learners)
  ✓ Basic vocabulary (100 words)
  ✓ Simple grammar (tenses, pronouns)
  ✓ Listening: Slow English
  ✓ Speaking: Self-introduction
  ✓ Writing: Simple sentences

Stage 2: Intermediate (A2-B1 learners)
  ✓ Expanded vocabulary (500 words)
  ✓ Complex grammar (conditionals, passive)
  ✓ Listening: Podcast / YouTube
  ✓ Speaking: Conversations
  ✓ Writing: Paragraphs

Stage 3: Exam Prep (B2+ learners)
  ✓ Advanced vocabulary (2000 words)
  ✓ IELTS-specific strategies
  ✓ Practice tests
  ✓ Speaking: Fluency
  ✓ Writing: Essays

ACCEPTANCE CRITERIA
□ Each stage has 5-10 sub-topics
□ Sub-topics have resources (links, books, videos)
□ Progress tracked (% complete)
□ Milestone badges (optional, future)
```

---

## 4. Feature Details (by Sprint)

### **Sprint 1: Auth + Setup**
- [ ] User registration (email + password)
- [ ] Login / Logout
- [ ] Create learner profile (name, grade, target IELTS)
- [ ] Database schema + ORM setup
- [ ] API endpoints for auth + learner management

### **Sprint 2: Placement Test UI**
- [ ] Welcome page
- [ ] Test question display (1 at a time)
- [ ] MCQ options (4 buttons)
- [ ] Writing/Speaking textarea
- [ ] Progress bar
- [ ] Previous/Next/Submit navigation
- [ ] Answer persistence (localStorage or API)

### **Sprint 3: AI Scoring**
- [ ] Ollama integration (POST /api/attempts/:id/score)
- [ ] MCQ auto-scoring logic
- [ ] Writing scoring via Ollama
- [ ] Speaking scoring via Ollama
- [ ] CEFR calculation
- [ ] Database update (scores + cefrResult)

### **Sprint 4: Results + Dashboard**
- [ ] Result page UI (CEFR + skill bars)
- [ ] Dashboard page (header + progress + tasks)
- [ ] Learning path display (3 stages)
- [ ] Fetch + display data from API

### **Sprint 5: Polish + Responsive**
- [ ] Mobile responsiveness (375px test)
- [ ] Tablet responsiveness (768px test)
- [ ] Desktop optimization
- [ ] Loading states, error handling
- [ ] Accessibility (WCAG AA)
- [ ] Performance optimization

### **Sprint 6: Testing + Deploy**
- [ ] Unit tests (frontend + backend)
- [ ] Integration tests
- [ ] End-to-end tests
- [ ] QA testing (per 12_TEST_PLAN.md)
- [ ] Bug fixes
- [ ] Documentation update
- [ ] Deployment preparation

---

## 5. Out of Scope (MVP)

### **Features NOT Included (v1.0):**

| Feature | Reason | Possible v2.0 |
|---------|--------|---|
| Payment/Subscription | Complex for MVP | Freemium model |
| Speech-to-text (STT) | Requires Whisper API | Local Whisper.cpp |
| Multiple tests (retake) | Single test sufficient | v2.0 progression system |
| Gamification (badges, leaderboard) | MVP focus: basic path | v2.0 engagement |
| Community (forums, discussions) | Complexity + moderation | v2.0 social features |
| Parent email notifications | Can use manual for now | v2.0 notifications system |
| Mobile app (iOS/Android) | Web responsive first | v3.0 native apps |
| Offline mode (PWA) | Web-first MVP | v2.0 PWA + service worker |
| Advanced analytics | Basic tracking enough | v2.0 analytics dashboard |
| AI Voice Conversation | Complex NLP + ASR | v2.0 with Whisper |
| AI Teacher (chat-based tutoring) | Out of MVP scope | v2.0 chatbot |
| Push Notifications | Not essential for MVP | v2.0 notification system |

---

## 6. Constraints & Assumptions

### **Technical Constraints**

```
✓ Must run locally (Ollama)
✓ PostgreSQL as database
✓ React 18+ for frontend
✓ Node.js 16+ for backend
✓ qwen2.5:14b model (not fine-tuned)
✓ No external AI API calls (cost reason)
```

### **Business Constraints**

```
✓ Budget: $0 (bootstrap)
✓ Timeline: 6 sprints (~6-8 weeks)
✓ Team: 1 AI developer + 1 PO (you)
✓ Target: 100 beta users
✓ No B2B sales in v1.0
```

### **Assumptions**

```
✓ Users have stable internet (Ollama needs connection)
✓ Ollama runs on a server (not on user's device)
✓ CEFR scoring algorithm is "good enough" for MVP
✓ Writing/Speaking scoring uses Ollama, not perfect but acceptable
✓ Initial user base: friends & family, not public marketing
✓ Will pivot/iterate based on user feedback
```

---

## 7. API Response Examples

### **POST /api/attempts (Submit test)**

```json
Request:
{
  "learnerId": "user-123",
  "answers": {
    "q1": "0",              // MCQ: option index
    "q2": "1",
    "q3": "2",
    "q4": "I like reading books",      // Speaking: text
    "q5": "My hobby is..."  // Writing: text
  }
}

Response:
{
  "id": "attempt-456",
  "learnerId": "user-123",
  "scores": {
    "reading": 100,
    "grammar": 100,
    "listening": 0,
    "speaking": null,    // Pending Ollama
    "writing": null
  },
  "status": "analyzing"
}
```

### **POST /api/attempts/:id/score (Get final result)**

```json
Response:
{
  "id": "attempt-456",
  "cefr": "B1",
  "scores": {
    "reading": 100,
    "grammar": 100,
    "listening": 0,
    "speaking": 65,
    "writing": 72
  },
  "feedback": "Great reading skills! Work on listening.",
  "roadmap": [
    {
      "stage": 1,
      "title": "Foundation",
      "progress": 50,
      "items": ["Vocabulary", "Grammar", "Pronunciation"]
    },
    ...
  ]
}
```

---

## ✅ **Sign-Off**

- **Product Owner:** Chien (你)
- **Requirements Version:** 1.0
- **Date:** [TBD]
- **Status:** ✅ APPROVED

---

**Next:** Đọc `03_USER_FLOW.md` để chi tiết luồng người dùng.

---

**Made with ❤️ for Clear Requirements**
