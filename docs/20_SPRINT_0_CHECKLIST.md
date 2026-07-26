# ✅ 20_SPRINT_0_CHECKLIST.md

**Pre-Coding Readiness Checklist - MANDATORY Before Sprint 1**

---

## 🎯 **Purpose**

This checklist ensures:
- ✅ All documentation is consistent
- ✅ No contradictions between docs
- ✅ AI can code without ambiguity
- ✅ Team is aligned on scope
- ✅ Environment is ready for development

**Duration:** 0.5-1 day (before ANY coding starts)

---

## 📋 **SECTION 1: DOCUMENTATION CONSISTENCY**

### **1.1 User vs Learner Model** ⭐ CRITICAL

- [ ] **Decision Made:** MVP uses 1:1 relationship (one account = one learner)
  - Location: 06_API.md - "User vs Learner Clarification" section
  - Status: ✅ LOCKED for MVP

- [ ] **05_DATABASE.md aligned:**
  - [ ] No separate `User` table (only `Learner`)
  - [ ] `Learner` has email + password
  - [ ] Future refactor path documented for v1.1

- [ ] **06_API.md aligned:**
  - [ ] `/auth/register` creates Learner (not separate User)
  - [ ] No `/learners` POST endpoint in MVP
  - [ ] All auth endpoints use Learner model

- [ ] **15_PROMPTS.md aligned:**
  - [ ] AI prompts assume 1:1 model
  - [ ] No code generation for parent → children

**Verification:** All 3 files say same thing about User/Learner

---

### **1.2 Placement Test Scope** ⭐ CRITICAL

- [ ] **Question Count: 15-20 (NOT 5)**
  - Location: 02_PRD.md, 03_USER_FLOW.md, 06_API.md
  - Verified in all 3: ✅

- [ ] **Question Distribution:**
  - [ ] Reading: 4-5
  - [ ] Grammar: 4-5
  - [ ] Listening: 4-5
  - [ ] Speaking: 1
  - [ ] Writing: 1-2
  - Total: 15-20 questions

- [ ] **Adaptive Difficulty:**
  - [ ] Questions have difficulty level (1-3)
  - [ ] Test adjusts difficulty based on answers
  - [ ] Database schema supports this

**Verification:** All docs say 15-20, all skill distributions match

---

### **1.3 Prisma Syntax Errors** ⭐ CRITICAL

- [ ] **05_DATABASE.md - Question Model:**
  - [ ] `createdAt DateTime @default(now())` ✅ (not `created AtDateTime`)
  - [ ] `updatedAt DateTime @updatedAt` ✅ (not `updated At DateTime`)
  - [ ] `difficulty Int` exists ✅
  - [ ] `isActive Boolean @default(true)` exists ✅

- [ ] **05_DATABASE.md - All Models:**
  - [ ] All timestamps use `createdAt` / `updatedAt`
  - [ ] All have `@default(now())` for createdAt
  - [ ] All have `@updatedAt` for updatedAt
  - [ ] No syntax errors in Prisma schema

**Verification:** Run `prisma validate` → no errors

---

### **1.4 Tech Stack Versions** ⭐ HIGH PRIORITY

| Tech | Current | Required | Status |
|------|---------|----------|--------|
| Node.js | 16 | 22 LTS (min 20) | ❌ FIX |
| React | 18 | 18+ (or 19) | ✅ OK |
| PostgreSQL | 15+ | 15+ | ✅ OK |
| Prisma | 5+ | 5+ | ✅ OK |
| TailwindCSS | Specified | Mandatory | ✅ OK |

- [ ] **08_TECH_STACK.md updated:**
  - [ ] Node: 22 LTS (or minimum 20 LTS)
  - [ ] TailwindCSS: Mandatory (not optional)
  - [ ] React: 18 (or 19) ✅
  - [ ] All dependencies pinned to exact versions

**Verification:** 08_TECH_STACK.md says Node 22 LTS

---

### **1.5 API ↔ Database Alignment** ⭐ HIGH PRIORITY

- [ ] **06_API.md endpoints match 05_DATABASE.md models:**
  - [ ] POST /auth/register → Creates Learner row
  - [ ] POST /auth/login → Reads from Learner
  - [ ] GET /dashboard/:learnerId → Reads LearningPath
  - [ ] POST /attempts → Creates TestAttempt
  - [ ] GET /attempts/:id/result → Reads TestAttempt + scores

- [ ] **Response format unified:**
  - [ ] All success: `{ success: true, message, data }`
  - [ ] All errors: `{ success: false, message, errorCode }`
  - [ ] No mixed formats

- [ ] **Status codes consistent:**
  - [ ] 200: Success
  - [ ] 201: Created
  - [ ] 202: Accepted (async operations)
  - [ ] 400: Bad request
  - [ ] 401: Unauthorized
  - [ ] 404: Not found
  - [ ] 409: Conflict

**Verification:** Review 05_DATABASE.md + 06_API.md side-by-side

---

### **1.6 User Flow ↔ API Endpoints** ⭐ HIGH PRIORITY

- [ ] **03_USER_FLOW.md flows exist in 06_API.md:**
  - [ ] Register flow → POST /auth/register ✅
  - [ ] Login flow → POST /auth/login ✅
  - [ ] Take test → POST /attempts ✅
  - [ ] Submit test → POST /attempts/:id/score (async) ✅
  - [ ] Get result → GET /attempts/:id/result (polling) ✅

- [ ] **Error flows in API documentation:**
  - [ ] Ollama offline → 503 response ✅
  - [ ] Network error → Retry logic ✅
  - [ ] Invalid input → 400 response ✅
  - [ ] Session expired → 401 response ✅

**Verification:** Every user flow step has matching API endpoint

---

### **1.7 Acceptance Criteria ↔ Test Plan** ⭐ HIGH PRIORITY

- [ ] **11_ACCEPTANCE_CRITERIA.md matches 12_TEST_PLAN.md:**
  - [ ] All AC have test cases
  - [ ] All test cases match AC
  - [ ] Performance criteria defined
  - [ ] Security criteria defined
  - [ ] Accessibility criteria defined

- [ ] **Each story has clear done criteria:**
  - [ ] Acceptance Criteria listed
  - [ ] Test cases specified
  - [ ] Definition of Done checkbox

**Verification:** For each story, AC = Test Plan entry

---

### **1.8 AI Design ↔ Prompts** ⭐ HIGH PRIORITY

- [ ] **07_AI_DESIGN.md prompt examples:**
  - [ ] Match actual prompts in 15_PROMPTS.md
  - [ ] Temperature, max tokens specified
  - [ ] Fallback behavior defined
  - [ ] Timeout handling documented

- [ ] **Response format in prompts matches API schema:**
  - [ ] Scoring returns JSON with all required fields
  - [ ] Feedback is multilingual (EN + VI)
  - [ ] Confidence score included
  - [ ] Next actions specified

**Verification:** Run sample prompt → output matches expected schema

---

## 🔧 **SECTION 2: CONSISTENCY FIXES**

### **Issue Tracking**

As you find inconsistencies, log them:

```markdown
| Issue | Location | Status | Fix |
|-------|----------|--------|-----|
| User/Learner unclear | 05, 06 | FOUND | Clarified 1:1 |
| Prisma syntax | 05 | FOUND | Fixed createdAt |
| Node 16 too old | 08 | FOUND | Updated to 22 |
| AC ↔ Test mismatch | 11, 12 | FOUND | Aligned |
```

- [ ] **No inconsistencies remaining**
- [ ] **All issues listed above resolved**
- [ ] **Verification: Re-read each section**

---

## 📍 **SECTION 3: SCOPE LOCK**

### **MVP Phase 1 (Sprint 1-3): What's IN**

- [ ] User Registration + Login
- [ ] Learner Profile
- [ ] Placement Test (15-20 questions)
- [ ] AI Scoring via Ollama
- [ ] CEFR Level Assignment
- [ ] Test Result Display
- [ ] API + Database

### **MVP Phase 1: What's OUT** (Goes to BACKLOG)

- [ ] ❌ Learning Path
- [ ] ❌ Dashboard
- [ ] ❌ Parent accounts
- [ ] ❌ Flashcards
- [ ] ❌ Leaderboard
- [ ] ❌ Speaking/Writing advanced feedback
- [ ] ❌ Mobile app

- [ ] **BACKLOG.md created** with all deferred features
- [ ] **Team alignment:** Everyone knows Phase 1 scope
- [ ] **No scope creep:** New ideas go to BACKLOG, not Sprint

---

## 📦 **SECTION 4: ENVIRONMENT SETUP**

### **Project Structure**

- [ ] Git repository created
- [ ] .gitignore configured
- [ ] README.md written
- [ ] INSTALLATION.md written
- [ ] Folder structure:
  ```
  project/
    docs/          (all 20 MD files)
    apps/
      frontend/    (React + Vite)
      backend/     (Node + Express)
    scripts/
    docker/
    .github/
      workflows/   (CI/CD)
  ```

### **Development Tools**

- [ ] Node.js 22 LTS installed
- [ ] npm/yarn configured
- [ ] PostgreSQL running locally
- [ ] Ollama running locally (qwen2.5:14b)
- [ ] VS Code extensions installed

### **Repository Setup**

- [ ] Git initialized
- [ ] GitHub/GitLab repo created
- [ ] Branch strategy defined (main, develop, feature/*)
- [ ] Git hooks configured (pre-commit lint)
- [ ] CI/CD pipeline configured (.github/workflows)

---

## ✍️ **SECTION 5: DOCUMENTATION FREEZING**

### **Before Freezing**

- [ ] **Final read-through:**
  - [ ] 00_PROJECT_CONTEXT.md - Makes sense?
  - [ ] 01_PRODUCT_VISION.md - Agrees with reality?
  - [ ] 02_PRD.md - Achievable in 4 weeks?
  - [ ] 03_USER_FLOW.md - Covers all paths?
  - [ ] 04_UI_UX.md - Design system complete?
  - [ ] 05_DATABASE.md - Schema ready?
  - [ ] 06_API.md - All endpoints specified?
  - [ ] 07-14_REMAINING_DOCS - Consistent?
  - [ ] 15_PROMPTS.md - AI instructions clear?
  - [ ] 16_ARCHITECTURE_DECISIONS - Decisions final?
  - [ ] 17_CHANGELOG.md - Version strategy clear?
  - [ ] 18_KNOWN_ISSUES.md - Issues captured?
  - [ ] 19_BACKLOG.md - Scope locked?
  - [ ] 20_SPRINT_0_CHECKLIST.md - This document!

- [ ] **All docs read and approved by:**
  - [ ] Product Owner (you)
  - [ ] Tech Lead (ChatGPT/GPT-5.5)
  - [ ] (Optional) Team members

### **Freezing Action**

- [ ] **Create Git Tag:**
  ```bash
  git tag -a v1.0-docs-frozen -m "Documentation v1.0 - Ready for coding"
  git push origin --tags
  ```

- [ ] **Update README.md:**
  ```markdown
  ## Documentation Status
  
  - **Current Version:** v1.0 (FROZEN)
  - **Last Updated:** [Date]
  - **Status:** Ready for Sprint 1 coding
  - **Change Process:** All changes via Change Request
  ```

- [ ] **Create CHANGE_REQUEST_TEMPLATE.md:**
  ```markdown
  # Change Request for Docs
  
  ## What document?
  ## What changed?
  ## Why?
  ## Impact on code?
  ```

- [ ] **Announce to team:**
  > "Documentation v1.0 is FROZEN. All coding proceeds from these specs. Questions? Create a Change Request."

---

## 🚀 **SECTION 6: SIGN-OFF**

### **Checklist Completion**

- [ ] **All 5 sections reviewed**
- [ ] **No critical inconsistencies**
- [ ] **Scope is locked**
- [ ] **Environment is ready**
- [ ] **Docs are frozen**

### **Approval Sign-Off**

```
Product Owner: ________________  Date: ________
Tech Lead:     ________________  Date: ________
Team Lead:     ________________  Date: ________
```

### **Status Declaration**

- [ ] **SPRINT 0 COMPLETE**
- [ ] **READY FOR SPRINT 1**
- [ ] **AI CAN START CODING NOW**

---

## 📝 **After Sprint 0 Sign-Off**

You are now authorized to:

1. ✅ Hand docs to AI
2. ✅ Assign Sprint 1 tasks
3. ✅ Start development
4. ✅ Run QA tests

You are NOT authorized to:

1. ❌ Change docs without Change Request
2. ❌ Expand scope
3. ❌ Modify architecture decisions
4. ❌ Add new dependencies

---

**Document Owner:** Product Owner  
**Review Frequency:** One-time (before Sprint 1)  
**Status:** CRITICAL - Complete before coding starts  

**Good luck! You've built an excellent foundation. Now let's execute. 🚀**
