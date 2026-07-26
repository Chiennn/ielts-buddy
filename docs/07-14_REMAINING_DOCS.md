# 📚 07-14_REMAINING_DOCS.md

**All Remaining Documentation Files (Summary Format)**

---

## 🤖 **07_AI_DESIGN.md**

### **Ollama Integration**

**Model:** `qwen2.5:14b`

```
URL:        http://localhost:11434/api/generate
Timeout:    30 seconds
Temperature: 0.7 (balanced creativity + accuracy)
Max tokens: 200 (for responses)
```

### **Scoring Logic**

```
MCQ (Auto-score):
  └─ Compare answer == correctAnswer
  └─ Result: 0 (wrong) or 100 (correct)
  └─ Time: <1ms per question

Writing/Speaking (Ollama):
  └─ Send text to Ollama
  └─ Prompt: "Score English writing..."
  └─ Parse JSON response
  └─ Band (1-9) → Scale (10-90): band * 10
  └─ Time: 5-10s per response

CEFR Calculation:
  └─ avg = (reading + grammar + listening + speaking + writing) / 5
  └─ 0-20 → A1, 21-40 → A2, 41-60 → B1, 61-70 → B1+
  └─ 71-80 → B2, 81-85 → B2+, 86-95 → C1, 96+ → C2
```

### **Fallback Logic**

```
IF Ollama offline:
  ├─ Return MCQ scores only
  ├─ Writing/Speaking = null
  ├─ Status = "partial"
  └─ Retry in background every 5 minutes

IF Ollama timeout:
  └─ Estimated score based on word count
  └─ Mark as estimated
```

### **Prompt Engineering**

```
Writing Prompt:
"You are an IELTS examiner. Score this writing.
Return ONLY JSON:
{
  "band": <1-9>,
  "feedback": "<1 sentence in Vietnamese>"
}
Writing: """${text}"""

Speaking Prompt:
"Score this English speaking transcript.
Return JSON: { "band": <1-9>, "feedback": "..." }
Transcript: """${text}"""
```

---

## 💻 **08_TECH_STACK.md**

### **Frontend Stack**

```
React:              18.2.0    (UI framework)
Vite:               4.4.0     (Build tool, super fast)
React Router:       6.14.0    (Navigation)
Axios:              1.4.0     (HTTP client)
Be Vietnam Pro:     Google Fonts (typography)
CSS/Tailwind:       (optional, inline for MVP)
```

**Why React over Vue/Angular?**
- Large community, tons of libraries
- Easy to learn curve
- Job market demand
- Vite super fast (HMR <100ms)

**Why Vite over CRA?**
- 10x faster build (ES modules)
- Out-of-box TypeScript support
- Smaller bundle size

### **Backend Stack**

```
Node.js:            16+ (runtime)
Express.js:         4.18.2 (REST framework)
Prisma ORM:         5.0.0  (Database abstraction)
PostgreSQL:         12+    (Database)
Bcrypt:             5.1.0  (Password hashing)
JWT:                jsonwebtoken (Auth tokens)
CORS:               2.8.5  (Cross-origin requests)
Dotenv:             16.0.3 (Environment variables)
```

**Why Express?**
- Lightweight, flexible
- Great middleware ecosystem
- Excellent for REST APIs
- Low learning curve

**Why Prisma?**
- Type-safe queries
- Auto-generated migrations
- Excellent DX
- Works with PostgreSQL perfectly

**Why PostgreSQL?**
- Reliable, production-ready
- JSONB support (for flexible data)
- Free, open-source
- Scales well

### **AI Stack**

```
Ollama:             Local LLM server
qwen2.5:14b:        Model (14B params, ~8GB VRAM)
HTTP API:           JSON over HTTP
```

**Why Ollama + qwen2.5?**
- No API costs (local)
- Privacy (data never leaves)
- Fast (local inference)
- Good performance for scoring

### **DevOps (Future)**

```
Docker:             Containerization
Docker Compose:     Local dev environment
GitHub Actions:     CI/CD
Vercel:             Frontend deployment
Railway:            Backend deployment (PostgreSQL included)
```

### **Deployment Overview**

```
┌─ Frontend (Vercel, CDN)
├─ Backend (Railway or similar)
├─ Database (Railway PostgreSQL)
└─ Ollama (On dedicated server or user's machine)
```

---

## 🎨 **09_CODING_RULES.md**

### **Frontend (React)**

```
Naming:
  Components:       PascalCase (Welcome, TestPage)
  Functions:        camelCase (handleSubmit, getScore)
  Constants:        UPPER_SNAKE_CASE (API_BASE_URL)
  Variables:        camelCase (currentQuestion, isLoading)
  Props:            camelCase (onClick, className)

File Structure:
  pages/
    Welcome.jsx
    Test.jsx
    Dashboard.jsx
  components/
    SkillBar.jsx
    OptionCard.jsx
  api/
    client.js
    endpoints.js
  context/
    AuthContext.jsx

Imports:
  1. React imports
  2. External packages
  3. Internal components
  4. Styles last

Exports:
  Use named exports for components
  Use default export for page components

Code Style:
  ✓ Use functional components + hooks
  ✓ Use const for variables (avoid let/var)
  ✓ Arrow functions for callbacks
  ✓ Destructure props early
  ✓ One component per file
  ✓ Max 300 lines per component
  ✓ Comments for complex logic only

Errors:
  ✓ Try-catch for async operations
  ✓ Show user-friendly error messages
  ✓ Log errors to console (dev) / monitoring (prod)

Performance:
  ✓ Use React.memo for expensive components
  ✓ useCallback for stable function refs
  ✓ Lazy load pages with React.lazy
```

### **Backend (Node.js)**

```
Naming:
  Routes:           lowercase-with-dashes (POST /api/attempts)
  Controllers:      camelCase (authController.register)
  Models:           PascalCase (User, Question)
  Database:         snake_case (created_at, learner_id)
  Constants:        UPPER_SNAKE_CASE

File Structure:
  src/
    routes/
      auth.js
      learners.js
      attempts.js
    controllers/
      authController.js
    services/
      ollamaService.js
    middleware/
      auth.js
      errorHandler.js
    models/         (Prisma schema)
    utils/
      bcrypt.js
      jwt.js
    index.js        (server entry point)

Database:
  ✓ Use Prisma migrations (npm run migrate)
  ✓ Seed data with seed.js (npm run seed)
  ✓ Never modify raw SQL

Error Handling:
  ✓ Always catch errors in async functions
  ✓ Pass to global error handler
  ✓ Return appropriate HTTP status codes
  ✓ Never leak sensitive info in errors

Security:
  ✓ Hash passwords (bcrypt 10 rounds)
  ✓ Validate all inputs
  ✓ Use JWT for stateless auth
  ✓ Rate limiting on auth endpoints
  ✓ HTTPS in production (enforce)
  ✓ CORS configured properly
```

### **Git Conventions**

```
Branch Naming:
  feature/sprint-1-auth
  fix/jwt-token-parsing
  docs/update-readme

Commit Messages:
  feat(sprint-1): add auth endpoints
  fix(scoring): cefr calculation error
  docs(api): update endpoint docs
  refactor(components): optimize button rendering
  test(auth): add login tests
  chore(deps): bump react version

Template:
  <type>(<scope>): <subject>
  
  <body (optional)>
  
  <footer (optional)>

Example:
  feat(sprint-2): add placement test UI
  
  - Create Test.jsx component
  - Add MCQ option cards
  - Implement answer auto-save
  
  Closes #42
```

### **Testing**

```
Frontend:
  ✓ React Testing Library (components)
  ✓ Jest (utilities)
  ✓ E2E: Cypress or Playwright (future)

Backend:
  ✓ Jest (unit tests)
  ✓ Supertest (API tests)
  ✓ Test database (separate DB for tests)

Coverage:
  ✓ Target: 80%+ critical paths
  ✓ Run: npm test (all tests pass)
  ✓ CI: Fail if coverage < 80%
```

---

## 📅 **10_SPRINT_PLAN.md**

```
Sprint 1 (Days 1-3): Auth + DB Setup
  ├─ User registration (email + password)
  ├─ User login + JWT
  ├─ Learner CRUD endpoints
  ├─ Database schema created
  ├─ Seed 5 questions
  └─ Estimated: 3 days

Sprint 2 (Days 4-6): Placement Test UI
  ├─ Welcome page
  ├─ Test page (5 questions)
  ├─ Navigation (Prev/Next/Submit)
  ├─ Answer auto-save
  ├─ Mobile responsive
  └─ Estimated: 3 days

Sprint 3 (Days 7-10): AI Scoring
  ├─ Ollama integration
  ├─ MCQ auto-scoring
  ├─ Writing/Speaking scoring
  ├─ CEFR calculation
  ├─ Analyzing page
  └─ Estimated: 4 days

Sprint 4 (Days 11-14): Results + Dashboard
  ├─ Result page (CEFR + skill bars)
  ├─ Learning path display
  ├─ Dashboard page
  ├─ Progress tracking
  ├─ Tasks display
  └─ Estimated: 4 days

Sprint 5 (Days 15-17): Polish + Testing
  ├─ Mobile responsiveness
  ├─ Loading states
  ├─ Error handling
  ├─ Accessibility
  ├─ Performance optimization
  └─ Estimated: 3 days

Sprint 6 (Days 18-20): QA + Deployment
  ├─ Unit tests
  ├─ Integration tests
  ├─ Manual QA (12_TEST_PLAN.md)
  ├─ Bug fixes
  ├─ Documentation
  ├─ Deployment prep
  └─ Estimated: 3 days

Total: ~20 days (4 weeks) for MVP
```

---

## ✅ **11_ACCEPTANCE_CRITERIA.md**

```
FEATURE: Authentication

DONE when:
✓ User can register (email + password)
✓ User can login (email + password)
✓ Token persists in localStorage
✓ Token expires after 7 days
✓ Invalid credentials show error
✓ Password hashed (bcrypt)
✓ All validation working
✓ Unit tests passing (85%+ coverage)

---

FEATURE: Placement Test

DONE when:
✓ Display 5 questions (1 each skill)
✓ Answer all question types (MCQ, text)
✓ Navigate with Prev/Next/Submit
✓ Auto-save answers
✓ Progress bar updates
✓ Submit button enabled on Q5 only
✓ Answers saved to database
✓ Responsive on mobile/tablet/desktop
✓ Unit tests passing

---

FEATURE: AI Scoring

DONE when:
✓ MCQ auto-scored correctly
✓ Ollama called for Writing
✓ Ollama called for Speaking
✓ CEFR calculated (A1-C2)
✓ All 5 scores computed
✓ Result displayed to user
✓ Timeout handled (30s)
✓ Fallback if Ollama offline
✓ Integration tests passing

---

FEATURE: Dashboard

DONE when:
✓ Current CEFR level displayed
✓ 4 skill bars showing scores
✓ Learning path 3 stages visible
✓ Progress bars accurate
✓ Today's tasks listed (3-5)
✓ Activity chart showing 7 days
✓ "Retake Test" button works
✓ Responsive design
✓ Unit tests passing
```

---

## 🧪 **12_TEST_PLAN.md**

**Your QA Expertise Area - Test Cases Per Feature**

```
TEST SUITE: Authentication

TC-001: Register Happy Path
  Given: New user with valid email + password
  When:  User submits registration form
  Then:  Account created + auto-login
  Expected: Redirect to /learner-selection

TC-002: Register Invalid Email
  Given: User enters invalid email
  When:  User submits
  Then:  Error: "Invalid email format"
  Expected: Stay on register page

TC-003: Register Duplicate Email
  Given: Email already exists
  When:  User submits
  Then:  Error: "Email already registered"
  Expected: Stay on register page

TC-004: Login Happy Path
  Given: Valid email + password
  When:  User submits
  Then:  Token stored, user authenticated
  Expected: Redirect to learner selection

TC-005: Login Wrong Password
  Given: Correct email, wrong password
  When:  User submits
  Then:  Error: "Invalid email or password"
  Expected: Stay on login page

---

TEST SUITE: Placement Test

TC-101: Display Q1 Reading
  Given: User starts test
  When:  Page loads
  Then:  Q1 (Reading MCQ) displayed
  Expected: 4 options visible + "Next" button

TC-102: Select Option
  Given: Q1 displayed
  When:  User clicks option
  Then:  Option highlighted
  Expected: Answer auto-saved

TC-103: Navigate Questions
  Given: On Q2
  When:  User clicks "Previous"
  Then:  Back to Q1
  Expected: Q1 answer preserved

TC-104: Submit Test
  Given: On Q5 (Writing)
  When:  User clicks "Submit"
  Then:  Answers sent to API
  Expected: Redirect to /analyzing

TC-105: Incomplete Test
  Given: On Q3
  When:  User closes page
  Then:  (Depends on auto-save)
  Expected: Can resume from Q3 on return

---

TEST SUITE: AI Scoring

TC-201: Auto-Score MCQ
  Given: User answered Q1 with correct option
  When:  Scoring happens
  Then:  Reading score = 100
  Expected: Correct

TC-202: Ollama Timeout
  Given: Ollama not responding
  When:  Scoring triggered
  Then:  Show: "Scoring delayed"
  Expected: Graceful fallback

TC-203: CEFR Calculation
  Given: Scores = [100, 70, 0, 65, 72]
  When:  CEFR calculated
  Then:  avg = 61.4 → B1
  Expected: Correct mapping

---

TEST SUITE: Dashboard

TC-301: Display CEFR
  Given: User has taken test
  When:  Dashboard loads
  Then:  CEFR displayed (e.g., "B1")
  Expected: Correct

TC-302: Display Skill Bars
  Given: Scores exist
  When:  Dashboard loads
  Then:  4 bars showing (Reading, Grammar, etc.)
  Expected: Correct percentages

TC-303: Click Retake Test
  Given: On Dashboard
  When:  User clicks "Retake Test"
  Then:  Redirect to /test
  Expected: New attempt starts

---

TEST SUITE: Responsive Design

TC-401: Mobile (375px)
  Given: Any page
  When:  Viewport = 375px
  Then:  All content visible + readable
  Expected: No horizontal scroll

TC-402: Tablet (768px)
  Given: Any page
  When:  Viewport = 768px
  Then:  2-column layout where applicable
  Expected: Optimized for tablet

TC-403: Desktop (1024px)
  Given: Any page
  When:  Viewport = 1024px+
  Then:  Full layout
  Expected: Desktop optimized

---

TEST SUITE: Network Issues

TC-501: No Internet During Test
  Given: User filling test
  When:  Network drops
  Then:  Show: "No connection"
  Expected: Offline mode or retry

TC-502: API Timeout
  Given: Submit test
  When:  API doesn't respond in 30s
  Then:  Show error
  Expected: Retry or fallback

---

TEST SUITE: Edge Cases

TC-601: Empty Input
  Given: User submits test without answering
  When:  User clicks Submit
  Then:  Error: "Please answer all questions"
  Expected: Cannot submit

TC-602: Very Long Writing
  Given: User writes 5000 words
  When:  Submit
  Then:  Truncate or show warning
  Expected: Reasonable behavior

TC-603: Browser Close
  Given: User closes browser during test
  When:  User reopens after 5 minutes
  Then:  Resume from same question
  Expected: No data loss
```

---

## 🚀 **13_DEPLOYMENT.md**

```
LOCAL DEPLOYMENT (Dev)

Requirements:
  ✓ Node.js 16+
  ✓ PostgreSQL 12+
  ✓ Ollama + qwen2.5:14b model
  ✓ 8GB RAM (for Ollama)

Setup:
  1. Clone repo
  2. cp .env.example .env
  3. Update DATABASE_URL
  4. npm install (both frontend + backend)
  5. cd backend && npx prisma migrate dev
  6. npm run seed (both)
  7. npm run dev (separate terminals)

PRODUCTION DEPLOYMENT

Frontend (Vercel):
  1. Push to GitHub
  2. Connect Vercel
  3. Env vars: REACT_APP_API_URL
  4. Auto-deploys on push

Backend (Railway):
  1. Create Railway account
  2. Connect GitHub
  3. Add PostgreSQL plugin
  4. Env vars: DATABASE_URL, OLLAMA_API, etc.
  5. Deploy

Ollama Setup:
  ✓ Run on dedicated server OR user's machine
  ✓ Expose via HTTP: ollama serve
  ✓ Firewall: Restrict port 11434

Health Checks:
  ✓ Frontend: Lighthouse score > 80
  ✓ Backend: /health endpoint responding
  ✓ Ollama: API responding to test request

Monitoring:
  ✓ Error tracking (Sentry)
  ✓ Analytics (Plausible)
  ✓ Uptime monitoring (Uptime Robot)

Backups:
  ✓ Database: Daily automated backups
  ✓ Code: GitHub repository
```

---

## 🤝 **14_HANDOFF.md**

```
SPRINT HANDOFF CHECKLIST

Before AI Starts:
  ☐ Current sprint documented in 02_PRD.md
  ☐ Acceptance criteria clear (11_ACCEPTANCE_CRITERIA.md)
  ☐ Design finalized (04_UI_UX.md)
  ☐ API contracts ready (06_API.md)
  ☐ AI has read all docs (00, 01, 02, 05, 06, 09, 11)

During Sprint:
  ☐ AI codes incrementally (not all at once)
  ☐ Self-reviews before committing
  ☐ Updates CHANGELOG.md
  ☐ Writes unit tests (80%+ coverage)

After AI Completes:
  ☐ AI reports: "Sprint X done. Ready for QA."
  ☐ You QA using 12_TEST_PLAN.md
  ☐ Any issues → AI fixes
  ☐ When all pass → Approve for merge

Merge to Main:
  ☐ Code reviewed ✓
  ☐ Tests passing ✓
  ☐ Documentation updated ✓
  ☐ Merge to main branch
  ☐ Tag release: v1.0-sprint-1

Next Sprint:
  ☐ Copy Sprint 2 prompt from 15_PROMPTS.md
  ☐ Paste to Continue chat
  ☐ Repeat process

Communication Template:

AI: "I've read docs. Starting Sprint 1. Estimated 3 days."

You: "Go ahead. I'll be ready for QA."

AI: "Sprint 1 done. All tests pass. Commit: [hash]. Ready for QA."

You: "Testing... Found 2 small bugs."

AI: "Fixing now. Tests updated. Ready again."

You: "Perfect. Merged to main. Sprint 2?"

AI: "Reading Sprint 2 docs... Starting now."
```

---

## ✅ **Summary**

All 15 documents complete:
```
✅ 00_PROJECT_CONTEXT.md
✅ 01_PRODUCT_VISION.md
✅ 02_PRD.md
✅ 03_USER_FLOW.md
✅ 04_UI_UX.md
✅ 05_DATABASE.md
✅ 06_API.md
✅ 07_AI_DESIGN.md (this file)
✅ 08_TECH_STACK.md (this file)
✅ 09_CODING_RULES.md (this file)
✅ 10_SPRINT_PLAN.md (this file)
✅ 11_ACCEPTANCE_CRITERIA.md (this file)
✅ 12_TEST_PLAN.md (this file)
✅ 13_DEPLOYMENT.md (this file)
✅ 14_HANDOFF.md (this file)
✅ 15_PROMPTS.md (already created)
```

---

**Ready for Day 2 (Sprint 1)?** ✅

All documentation complete. AI can now start coding.
