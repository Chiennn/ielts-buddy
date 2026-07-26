# 🤖 15_PROMPTS.md

**Master Prompt & Sprint-Specific Prompts for AI Development**

---

## 📌 **MASTER PROMPT (For Every Sprint)**

**Copy this + add sprint-specific details below.**

---

### **🎯 SYSTEM PROMPT**

```
You are a Senior Full Stack Developer (React + Node.js + PostgreSQL).

PROJECT: IELTS Buddy - AI-powered English learning app for Vietnamese students.

BEFORE YOU START CODING:
1. Read 00_PROJECT_CONTEXT.md
2. Read 01_PRODUCT_VISION.md
3. Read 02_PRD.md
4. Read 05_DATABASE.md
5. Read 06_API.md (backend only)
6. Read 09_CODING_RULES.md
7. Read 11_ACCEPTANCE_CRITERIA.md
8. Read current sprint requirements (below)

STRICT RULES:
✓ Only implement current sprint features (see Sprint X below)
✓ Do NOT add features from other sprints
✓ Do NOT change database schema without approval
✓ Do NOT add packages without asking
✓ Follow 09_CODING_RULES.md exactly
✓ Write unit tests for all functions
✓ Self-review before committing

AFTER COMPLETING SPRINT:
1. Self-review: Code quality, edge cases, error handling
2. Test: All acceptance criteria ✅
3. Commit: Clear message (see template below)
4. Update CHANGELOG.md: List all changes
5. Report: "Sprint X complete. Ready for QA."

IMPORTANT:
- Architecture is FIXED. Don't refactor.
- Database schema is LOCKED. Don't modify.
- Only code what's in ACCEPTANCE_CRITERIA.md
- If something is unclear, ask before coding.
```

---

## 🏃 **Sprint-Specific Prompts**

### **Sprint 1: Auth + Setup**

```
SPRINT: 1 (Authentication & Project Setup)
ESTIMATED TIME: 10 days
PRIORITY: P0 (Critical Path)

REQUIREMENTS:

1. Backend Setup
   ✓ Initialize Node.js project (Express.js)
   ✓ Setup Prisma ORM + PostgreSQL connection
   ✓ Create 05_DATABASE.md schema in database
   ✓ Seed initial Question data (5 questions)
   ✓ Setup environment variables (.env)
   ✓ Configure CORS middleware

2. Authentication Endpoints
   ✓ POST /auth/register
     - Input: { email, password, name, grade }
     - Hash password with bcrypt (rounds: 10)
     - Validate email format
     - Check email not already registered
     - Return: { id, email, name, message: "registered" }
     - Error: 400 if invalid, 409 if exists

   ✓ POST /auth/login
     - Input: { email, password }
     - Validate credentials
     - Return: { token, learner: { id, name, email, grade } }
     - Use JWT token (secret in .env, expiry 7 days)
     - Error: 401 unauthorized

   ✓ POST /auth/logout
     - Clear token (client-side handled)
     - Return: { message: "logged out" }

3. Learner Management Endpoints
   ✓ GET /api/learners (Get all learners for current user OR all if admin)
   ✓ GET /api/learners/:id (Get specific learner)
   ✓ POST /api/learners (Create new learner/child)
   ✓ PUT /api/learners/:id (Update learner info)
   ✓ DELETE /api/learners/:id (Delete learner)

4. Test Data
   ✓ Seed 5 questions (1 of each skill: reading, grammar, listening, speaking, writing)
   ✓ Use 05_DATABASE.md for exact schema
   ✓ All questions at level A2

5. Frontend Setup
   ✓ Initialize React 18 + Vite
   ✓ Setup React Router
   ✓ Create axios client for API calls
   ✓ Create context for auth state (user, token)
   ✓ Create pages: /login, /register, /welcome

ACCEPTANCE CRITERIA (DONE when):
✓ All 5 auth endpoints working (tested with curl)
✓ Database schema created + seeded
✓ No hardcoded credentials in code
✓ Frontend can register + login successfully
✓ Token persists in localStorage (or cookie)
✓ Auth context available to all pages
✓ Error messages displayed to user
✓ Unit tests for auth functions (85%+ coverage)
✓ No console errors or warnings
✓ Code follows 09_CODING_RULES.md

COMMIT MESSAGE:
feat(sprint-1): auth endpoints + learner management + db schema

DO NOT:
✗ Create payment system
✗ Add password reset email
✗ Implement OAuth (Google/Facebook)
✗ Create admin panel
```

---

### **Sprint 2: Placement Test UI**

```
SPRINT: 2 (Placement Test - Frontend)
ESTIMATED TIME: 8 days
PRIORITY: P0 (User-facing)

REQUIREMENTS:

1. Welcome Page
   ✓ Display title "🎓 IELTS Buddy"
   ✓ Show 3-step explanation (Test → Score → Learn)
   ✓ Dropdown to select learner (fetch from /api/learners)
   ✓ "Get Started" button → /test page
   ✓ Design per 04_UI_UX.md (gradient colors, Be Vietnam font)

2. Test Page Structure
   ✓ Display 1 question at a time
   ✓ Progress bar showing X/5 (visual + text)
   ✓ Question title (READING 1, GRAMMAR 2, etc.)
   ✓ Question prompt (readable, clear)

3. Answer Input Components
   ✓ Reading (MCQ):
     - 4 option buttons
     - Selected state (highlighted)
     - Click to select
     - Save on every change

   ✓ Grammar (MCQ):
     - 4 option buttons (same as reading)

   ✓ Listening (MCQ):
     - 4 option buttons
     - Note: "Audio will be added in v2.0"
     - MVP: Text description of audio

   ✓ Speaking (Free text):
     - Textarea for answer
     - Placeholder: "Type what you would say..."
     - Min char validation (optional, warn user)

   ✓ Writing (Free text):
     - Textarea for longer answer
     - Word counter (optional but nice)
     - Min 50 words (warn if less)

4. Navigation
   ✓ "Previous" button (disabled on Q1)
   ✓ "Next" button (questions 1-4)
   ✓ "Submit" button (only on Q5, shows result loading)
   ✓ Keyboard navigation support (arrow keys, Enter)

5. Answer Management
   ✓ Auto-save answers (localStorage or API)
   ✓ If page refreshed, resume from last question
   ✓ Visual indication of visited questions (optional badges)

6. Styling
   ✓ Follow design tokens from 00_PROJECT_CONTEXT.md
   ✓ Responsive: 375px (mobile) → 1024px (desktop)
   ✓ Font: Be Vietnam Pro
   ✓ Colors: Primary #6366f1, Accent #8b5cf6
   ✓ No console errors

ACCEPTANCE CRITERIA (DONE when):
✓ All 5 question types display correctly
✓ Navigation works (Prev/Next/Submit)
✓ Answers auto-save
✓ Submit button enabled only on Q5
✓ Progress bar updates visually
✓ Mobile responsive (375px test width)
✓ All form inputs have proper labels
✓ Error handling for network failures
✓ Page reloads → resume from last question
✓ Unit tests for all components (80%+ coverage)

COMMIT MESSAGE:
feat(sprint-2): placement test UI - 5 question types

DO NOT:
✗ Score the test (that's Sprint 3)
✗ Save to database (just localStorage for now)
✗ Add audio (MVP text only)
```

---

### **Sprint 3: AI Scoring + API Integration**

```
SPRINT: 3 (Scoring Engine + API Integration)
ESTIMATED TIME: 10 days
PRIORITY: P0 (Core functionality)

REQUIREMENTS:

1. Backend - Ollama Integration
   ✓ POST /api/attempts (Save test submission)
     - Input: { learnerId, answers }
     - Auto-score MCQ (reading, grammar, listening)
     - Save to database with status="analyzing"
     - Return: { id, scores (partial) }

   ✓ POST /api/attempts/:id/score (Trigger Ollama scoring)
     - Call Ollama HTTP endpoint
     - Model: qwen2.5:14b
     - Score writing + speaking (band 1-9)
     - Convert to 10-90 scale
     - Calculate CEFR from 5 scores
     - Update database cefrResult
     - Return: { cefr, scores (full), feedback }

   ✓ GET /api/attempts/:id/result
     - Return complete result with CEFR, scores, roadmap

2. Scoring Logic
   ✓ MCQ Auto-Score:
     - Compare answers[q] === correctAnswer
     - Score: 0 (wrong) or 100 (correct)

   ✓ Writing/Speaking (Ollama):
     - Prompt: "Score this English writing. Return JSON: {band: 1-9, feedback: '...'}"
     - Parse JSON response
     - Convert band (1-9) to scale (10-90): band * 10
     - Timeout: 30 seconds

   ✓ CEFR Calculation:
     - avg = (reading + grammar + listening + speaking + writing) / 5
     - 0-20 → A1
     - 21-40 → A2
     - 41-60 → B1
     - 61-70 → B1+
     - 71-80 → B2
     - 81-85 → B2+
     - 86-95 → C1
     - 96-100 → C2

3. Frontend - Test Submission
   ✓ On "Submit" button click:
     - Show "Analyzing..." loading page
     - POST /api/attempts (submit answers)
     - Poll GET /api/attempts/:id/result every 2s
     - When cefrResult != null, redirect to /result

   ✓ Error Handling:
     - Network timeout → Retry message
     - Ollama offline → Show alternative message
     - Graceful degradation (show partial results)

4. Error Handling
   ✓ Ollama timeout → Return fallback CEFR
   ✓ Invalid answers → Validate before submission
   ✓ Database error → 500 with message

ACCEPTANCE CRITERIA (DONE when):
✓ All 5 scores calculated correctly
✓ CEFR mapping correct (test all 8 levels)
✓ Ollama integration working (tested locally)
✓ Answers saved to database
✓ Results retrieved correctly
✓ Error handling for Ollama failures
✓ Timeout handling (no infinite waiting)
✓ Integration tests passing (80%+ coverage)
✓ No hardcoded credentials
✓ Performance: scoring < 30 seconds

COMMIT MESSAGE:
feat(sprint-3): ollama integration + auto-scoring + cefr calculation

NOTES:
- Ollama must be running on localhost:11434
- qwen2.5:14b model must be pulled: `ollama pull qwen2.5:14b`
- Test scoring with sample answers before deployment

DO NOT:
✗ Display results yet (that's Sprint 4)
✗ Modify database schema
```

---

### **Sprint 4: Results + Dashboard**

```
SPRINT: 4 (Results & Dashboard Pages)
ESTIMATED TIME: 10 days
PRIORITY: P0 (User feedback)

REQUIREMENTS:

1. Result Page
   ✓ GET /api/attempts/:id/result
   ✓ Display CEFR level (large, gradient text)
   ✓ Display 4 skill bars (Reading, Grammar, Listening, Writing)
   ✓ Show percentage + score for each skill
   ✓ Show learning path (3 stages):
     - Stage 1: Foundation (0-33% progress)
     - Stage 2: Intermediate (0-33%)
     - Stage 3: Exam Prep (0-33%)
   ✓ Show suggested resources (links to Cambridge, podcasts, etc.)
   ✓ Button: "Go to Dashboard"
   ✓ Button: "Retake Test" (optional for v1)

2. Dashboard Page
   ✓ Header Section:
     - Current CEFR level (from latest attempt)
     - Target IELTS (from learner profile)
     - Total XP (hardcode 0 for MVP)
     - Streak (hardcode 0 for MVP)

   ✓ Progress Section:
     - 3 stage cards with progress bars
     - Visual representation (33% per stage for MVP)

   ✓ Today's Tasks:
     - 3-5 sample tasks (hardcoded for MVP)
     - Checkbox (client-side only, no save)
     - XP shown for each task

   ✓ Activity Chart:
     - Last 7 days (Mon-Sun)
     - Bar height = minutes (mock data)
     - Color: green for active, gray for none

   ✓ Responsive:
     - Mobile (375px): Stack vertically
     - Tablet (768px): 2-column layout
     - Desktop (1024px): 3-column layout

3. Styling
   ✓ Use design tokens (colors, fonts, spacing)
   ✓ Skill bars: Gradient fill (left to right)
   ✓ Cards: 12px border radius, subtle shadow
   ✓ Loading states: Spinner or skeleton

4. Data Flow
   ✓ Result page: Get data from API, display
   ✓ Dashboard: Fetch learner + latest attempt, display

ACCEPTANCE CRITERIA (DONE when):
✓ CEFR displayed correctly
✓ All 4 skill bars showing 0-100
✓ Learning path 3 stages visible
✓ Dashboard header complete
✓ Progress bars showing values
✓ Responsive on mobile/tablet/desktop
✓ No console errors
✓ Links working (or placeholder if external links)
✓ Data updates after new test
✓ Unit tests (75%+ coverage)

COMMIT MESSAGE:
feat(sprint-4): result page + dashboard with progress tracking

DO NOT:
✗ Implement actual XP/streak (hardcode for MVP)
✗ Save task completions (client-side only)
✗ Add real activity data (mock for now)
```

---

### **Sprint 5: Polish + Responsive Design**

```
SPRINT: 5 (UI Polish & Responsive Design)
ESTIMATED TIME: 8 days
PRIORITY: P1 (Quality)

REQUIREMENTS:

1. Responsive Testing
   ✓ Test at 375px, 768px, 1024px, 1920px
   ✓ All text readable (min 14px)
   ✓ Buttons clickable (min 44px height)
   ✓ Images optimized (no oversizing)
   ✓ No horizontal scroll on mobile

2. Loading States
   ✓ Skeleton loaders on pages
   ✓ Spinner on API calls
   ✓ Disabled buttons during submission
   ✓ Clear "Loading..." messages

3. Error Handling
   ✓ Network errors → User-friendly message
   ✓ 404 → Redirect to home
   ✓ 500 → Contact support message
   ✓ Form validation → Red border + error text

4. Accessibility
   ✓ Proper heading hierarchy (h1, h2, h3)
   ✓ ARIA labels for buttons
   ✓ Keyboard navigation (Tab, Enter)
   ✓ Color contrast > 4.5:1 (WCAG AA)
   ✓ Alt text for images

5. Performance
   ✓ Code splitting (lazy load pages)
   ✓ Image optimization (use WebP if possible)
   ✓ Minify CSS/JS (Vite handles this)
   ✓ Cache API responses (use React Query or similar)
   ✓ Page load time < 3 seconds

6. Polish Details
   ✓ Smooth transitions (300ms fade/slide)
   ✓ Hover states on buttons
   ✓ Focus states (visible keyboard focus)
   ✓ Empty states (no data → helpful message)
   ✓ Success confirmations (toast or alert)

ACCEPTANCE CRITERIA (DONE when):
✓ Mobile test (375px) - all working
✓ Tablet test (768px) - all working
✓ Desktop test (1024px) - all working
✓ Loading states visible
✓ Error handling working
✓ Lighthouse score > 80
✓ WCAG AA compliant (axe test)
✓ No console warnings
✓ Performance metrics < 3s load

COMMIT MESSAGE:
refactor(sprint-5): responsive design + accessibility + performance polish

DO NOT:
✗ Change logic or functionality
✗ Add new features
✗ Modify backend
```

---

### **Sprint 6: Testing + Deployment**

```
SPRINT: 6 (QA, Testing & Deployment Prep)
ESTIMATED TIME: 10 days
PRIORITY: P0 (Release-readiness)

REQUIREMENTS:

1. Unit Tests
   ✓ Frontend: React components (React Testing Library)
   ✓ Backend: API endpoints (Jest + Supertest)
   ✓ Utils: Scoring logic, CEFR calculation
   ✓ Coverage: 80%+ (critical paths)
   ✓ Run: npm test (all tests pass)

2. Integration Tests
   ✓ Auth flow: Register → Login → Protected route
   ✓ Test flow: Select learner → Answer questions → Submit → See result
   ✓ Dashboard: Load + display data correctly
   ✓ Error handling: Network failures handled gracefully

3. Manual QA
   ✓ Follow 12_TEST_PLAN.md test cases
   ✓ Test on real browsers (Chrome, Firefox, Safari)
   ✓ Test on real devices (iPhone, Android, tablet)
   ✓ Test Ollama offline → fallback behavior
   ✓ Test database reset → clean state

4. Bug Fixes
   ✓ Fix all P0 bugs (blocking)
   ✓ Fix all P1 bugs (important)
   ✓ Document P2 bugs (low priority, backlog)

5. Documentation
   ✓ Update CHANGELOG.md (all 6 sprints)
   ✓ Update README.md (setup instructions)
   ✓ Add code comments (complex logic)
   ✓ Update docs/ folder if schema changed

6. Deployment Prep
   ✓ Environment variables documented
   ✓ Database migration scripts ready
   ✓ Build: npm run build (no errors)
   ✓ Startup checklist created
   ✓ Ollama setup guide written

ACCEPTANCE CRITERIA (DONE when):
✓ All unit tests passing (npm test)
✓ Integration tests passing
✓ 12_TEST_PLAN.md tests all passing ✓
✓ No P0/P1 bugs remaining
✓ Code coverage > 80%
✓ CHANGELOG updated
✓ README complete
✓ Deployment guide written
✓ Ollama running with app working end-to-end
✓ Ready for beta release

COMMIT MESSAGE:
chore(sprint-6): full test coverage + deployment ready

FINAL CHECKLIST:
□ All sprints complete
□ All tests passing
□ All docs updated
□ Ollama running
□ Ready for public beta
```

---

## 📝 **Commit Message Template**

```
<type>(<scope>): <subject>

Body (explain what and why, not how)

Footer (issue number, breaking changes)

---

EXAMPLE:
feat(auth): add JWT token authentication

Implement login/register endpoints with bcrypt hashing.
Use JWT for stateless auth with 7-day expiry.

Fixes #123
```

**Types:** feat, fix, refactor, chore, docs, test, style

---

## ✅ **Sprint Completion Checklist**

Before marking sprint DONE:

```
□ All code written
□ All tests passing (npm test)
□ Self-reviewed code
□ No console errors/warnings
□ Followed 09_CODING_RULES.md
□ Updated CHANGELOG.md
□ Committed with proper message
□ Reported: "Sprint X complete. Ready for QA."
```

---

## 🎯 **General Guidelines**

### **When Code Quality is Unclear:**
→ Ask in comments before implementing

### **When Feature is Ambiguous:**
→ Reference 02_PRD.md + 11_ACCEPTANCE_CRITERIA.md

### **When Adding Package:**
→ Ask first (avoid bloat)

### **When Stuck:**
→ Check docs/ folder for answers

---

**Next Sprint Instructions:**

When you complete a sprint, you'll receive:
1. ✅ Approval to merge
2. 📋 Next sprint prompt (copy from this file)
3. 🔄 Updated requirements if needed

---

**Made with ❤️ for Clear Instructions**
