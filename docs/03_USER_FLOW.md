# 👥 03_USER_FLOW.md

**User Flow - Complete Journey from Sign-up to Learning**

---

## 🎬 **Main User Flow (Happy Path)**

```
START
  ↓
┌─────────────────────────────┐
│  1. WELCOME SCREEN          │
│  - New user or returning?   │
└─────────────────────────────┘
  ↓                          ↓
[NEW USER]            [RETURNING USER]
  ↓                          ↓
┌──────────────────┐   ┌──────────────────┐
│ REGISTER         │   │ LOGIN            │
│ Email+Password   │   │ Email+Password   │
│ Create account   │   │ Authenticate     │
└──────────────────┘   └──────────────────┘
  ↓                          ↓
┌─────────────────────────────┐
│ 2. LEARNER SELECTION        │
│ - Select child from list    │
│ - Or create new child       │
│   (Name, Grade, Target IELTS)
└─────────────────────────────┘
  ↓
┌─────────────────────────────┐
│ 3. WELCOME SCREEN (Main)    │
│ - Show learner name         │
│ - Explain 3-step process    │
│ - "Get Started" button      │
└─────────────────────────────┘
  ↓
┌─────────────────────────────┐
│ 4. PLACEMENT TEST           │
│ - Adaptive 15-20 questions  │
│ - Reading, Grammar,         │
│   Listening, Speaking,      │
│   Writing (1-2 each)        │
│ - Navigate: Prev/Next       │
│ - Submit on last Q          │
│ - Can Resume if interrupted │
└─────────────────────────────┘
  ↓
┌─────────────────────────────┐
│ 5. ANALYZING SCREEN         │
│ - "AI is scoring..."        │
│ - Loading animation         │
│ - Poll backend every 2s     │
└─────────────────────────────┘
  ↓
┌─────────────────────────────┐
│ 6. RESULT SCREEN            │
│ - CEFR level (A1-C2)        │
│ - 4 skill bars              │
│ - Learning path (3 stages)  │
│ - Suggested resources       │
└─────────────────────────────┘
  ↓
┌─────────────────────────────┐
│ 7. DASHBOARD                │
│ - Progress tracking         │
│ - Today's tasks             │
│ - Activity chart (7 days)   │
│ - "Retake Test" or "Learn"  │
└─────────────────────────────┘
  ↓
END (Loop: Learn → Dashboard or Retake Test)
```

---

## 🔐 **User Flow 1: Registration**

```
NEW USER clicks "Create Account"
  ↓
REGISTER PAGE
  ├─ Input: Email
  ├─ Input: Password (min 8 chars)
  ├─ Input: Confirm Password
  └─ Button: "Sign Up"
  ↓
VALIDATION
  ├─ Email format valid? (RFC 5322)
  ├─ Password length >= 8?
  ├─ Passwords match?
  └─ Email not already used?
  ↓
IF VALID
  └─→ API: POST /auth/register
      ├─ Hash password (bcrypt)
      ├─ Store in database
      └─ Return: { token, user }
      
  └─→ Auto-login
  
  └─→ Redirect: /learner-selection
      (or /welcome if first time)

IF ERROR
  └─→ Show error message
  └─→ Stay on register page
  └─→ Examples:
      - "Email already registered"
      - "Password too short"
      - "Passwords don't match"
```

---

## 🔓 **User Flow 2: Login**

```
RETURNING USER clicks "Sign In"
  ↓
LOGIN PAGE
  ├─ Input: Email
  ├─ Input: Password
  └─ Button: "Sign In"
  ↓
VALIDATION
  ├─ Email not empty?
  └─ Password not empty?
  ↓
API: POST /auth/login
  ├─ Find user by email
  ├─ Compare password (bcrypt)
  └─ Return: { token, user }
  ↓
IF SUCCESS
  └─→ Store token (localStorage)
  └─→ Set auth context
  └─→ Redirect: /learner-selection
  
IF FAILED
  └─→ Show: "Invalid email or password"
  └─→ Stay on login page
  └─→ Offer: "Forgot password?" (v2.0)
```

---

## 👶 **User Flow 3: Learner Selection/Creation**

```
LOGGED IN USER → /learner-selection
  ↓
FETCH /api/learners (for current user)
  ├─ No learners found?
  │  └─→ Show: "Create your first child"
  └─ Learners found?
     └─→ Show dropdown/list
  ↓
OPTION A: Select Existing Learner
  ├─ Click learner name
  └─→ Redirect: /welcome
     (with learnerId in URL/context)
  ↓
OPTION B: Create New Learner
  ├─ Click: "+ Add Child"
  ├─ Form:
  │  ├─ Name: [text input]
  │  ├─ Grade: [dropdown 4-9]
  │  └─ Target IELTS: [dropdown 5.0-8.5]
  │
  ├─ Validate: All fields filled
  ├─ Submit: POST /api/learners
  │
  └─→ Redirect: /welcome
     (with new learnerId)
```

---

## 📝 **User Flow 4: Placement Test**

```
/welcome page
  ↓
DISPLAY:
  ├─ "🎓 IELTS Buddy"
  ├─ "Hi [Learner Name]!"
  ├─ 3-step explanation:
  │  ├─ 📝 Take a quick test
  │  ├─ 🤖 AI scores your answers
  │  └─ 🎯 Get personalized learning path
  │
  └─ Button: "Get Started"
  ↓
FETCH /api/questions (skill=reading, grammar, listening, speaking, writing; level=A2)
  ↓
/test page
  ├─ Display Q1 (Reading MCQ)
  │  ├─ Question text
  │  ├─ 4 option buttons
  │  └─ "Next" button
  │
  ├─ Progress bar: 1/5
  │
  ├─ User selects option → Auto-save answer
  │
  └─→ Click "Next"
  ↓
REPEAT for Q2, Q3, Q4 (same structure)
  ↓
Q5 (Writing)
  ├─ Different: Textarea instead of MCQ
  ├─ Placeholder: "Write 80-100 words..."
  ├─ Word counter (optional)
  │
  └─ Button: "Submit" (not "Next")
  ↓
USER CLICKS SUBMIT
  ├─ Validate: All answers provided?
  │  ├─ If not: Show "Please answer all questions"
  │  └─ Stay on Q5
  │
  ├─ POST /api/attempts
  │  ├─ Body: { learnerId, answers }
  │  └─ Response: { attemptId, status: "analyzing" }
  │
  └─→ Redirect: /analyzing?id=[attemptId]
```

---

## ⏳ **User Flow 5: Analyzing Screen**

```
/analyzing?id=[attemptId]
  ↓
DISPLAY:
  ├─ Loading spinner
  ├─ "AI is scoring your test..."
  └─ "Please wait..."
  ↓
POLL BACKEND (every 2 seconds)
  ├─ GET /api/attempts/[attemptId]/result
  │
  ├─ IF status == "pending"
  │  └─→ Keep polling
  │
  ├─ IF status == "completed" && cefrResult != null
  │  └─→ Redirect: /result?id=[attemptId]
  │
  └─ IF error (network, timeout)
     └─→ Show: "Connection issue. Retrying..."
        └─→ Retry logic (exponential backoff)
```

---

## 🏆 **User Flow 6: Result Screen**

```
/result?id=[attemptId]
  ↓
FETCH /api/attempts/[attemptId]/result
  ├─ cefrResult: "B1"
  ├─ scores: { reading: 100, grammar: 70, ... }
  ├─ feedback: "Great job!"
  └─ roadmap: [...]
  ↓
DISPLAY:
  ├─ CEFR LEVEL (large, gradient)
  │  └─ "B1"
  │
  ├─ 4 SKILL BARS
  │  ├─ Reading: ████████░░ 100%
  │  ├─ Grammar: ███░░░░░░░  70%
  │  ├─ Listening: █░░░░░░░░░  10%
  │  └─ Writing: █████░░░░░  50%
  │
  ├─ LEARNING PATH
  │  ├─ Stage 1: Foundation
  │  │  ├─ Vocabulary
  │  │  ├─ Grammar basics
  │  │  └─ Pronunciation
  │  │
  │  ├─ Stage 2: Intermediate
  │  │  ├─ Advanced grammar
  │  │  ├─ Conversation
  │  │  └─ Listening skills
  │  │
  │  └─ Stage 3: Exam Prep
  │     ├─ IELTS strategies
  │     ├─ Practice tests
  │     └─ Fluency building
  │
  ├─ RESOURCES
  │  ├─ Cambridge English (link)
  │  ├─ BBC Learning English (link)
  │  └─ More...
  │
  └─ BUTTONS
     ├─ "Go to Dashboard"
     └─ "Retake Test" (optional)
```

---

## 📊 **User Flow 7: Dashboard**

```
/dashboard
  ↓
FETCH:
  ├─ GET /api/learners/[learnerId]
  ├─ GET /api/attempts?learnerId=[learnerId] (latest)
  └─ GET /api/dashboard/[learnerId]
  ↓
DISPLAY:

HEADER
  ├─ Level: B1
  ├─ Target: IELTS 6.0
  ├─ XP: 1,250 points
  └─ Streak: 7 days

PROGRESS SECTION
  ├─ Stage 1: Foundation
  │  └─ ██████░░░░ 30% complete
  │
  ├─ Stage 2: Intermediate
  │  └─ ░░░░░░░░░░  0% complete
  │
  └─ Stage 3: Exam Prep
     └─ ░░░░░░░░░░  0% complete

TODAY'S TASKS
  ├─ ☐ Learn 10 new words (+50 XP)
  ├─ ☑ Practice reading (completed)
  └─ ☐ Write 100 words (+100 XP)

ACTIVITY CHART (Last 7 days)
  │
  │  ██
  │  ██ ██
  │  ██ ██ ██
  └──────────────
     Mon Tue Wed Thu Fri Sat Sun

ACTIONS
  ├─ "Start Learning Stage 1"
  └─ "Retake Test"
```

---

## ❌ **Error Flows**

### **Network Disconnected During Test**

```
User filling test + network drops
  ↓
Auto-save stops working
  ↓
Show: "No internet connection"
  ↓
User can:
  ├─ Continue offline (answers saved locally)
  └─ Reconnect + sync when online
  ↓
On reconnect:
  └─ Sync localStorage → API
```

### **Ollama Offline During Scoring**

```
POST /api/attempts/:id/score
  ├─ Ollama not responding (timeout 30s)
  ├─ Fallback: Return partial scores
  │  └─ MCQ auto-scored
  │  └─ Writing/Speaking: null
  │
  └─ Show user: "AI scoring delayed. Check back in 5 min."
  ↓
Backend retry (background job)
  ├─ Retry every 5 minutes
  └─ When Ollama back → Complete scoring
```

### **Invalid Answer Submission**

```
User clicks "Submit" without answering all
  ↓
Frontend validation:
  ├─ Check: All questions answered?
  └─ If NO: Show red border + "Please answer all questions"
  ↓
User cannot submit until ALL answered
```

---

## 🔄 **Repeat/Retake Flow**

```
User on Dashboard
  ↓
Click "Retake Test"
  ↓
Redirect: /welcome
  ├─ Same learner already selected
  ├─ Show: "Retaking test..."
  └─ → /test page
  ↓
NEW test attempt starts
  ├─ Different questions (random from pool)
  ├─ Same 5 skills, A2 level
  └─ Repeat scoring flow
  ↓
Compare results:
  ├─ Previous: B1 (70 avg)
  └─ New: B1+ (73 avg) ← Progress!
```

---

## 🏠 **Navigation Between Pages**

```
/login          ← Entry point
  ↓ (submit)
/learner-selection
  ↓ (select)
/welcome
  ↓ (start test)
/test
  ↓ (submit)
/analyzing
  ↓ (polling complete)
/result
  ↓ (go dashboard)
/dashboard
  ↓ (retake or learn)
  ├─→ /test (retake)
  └─→ /learning (future)
```

---

## 📱 **Mobile-Specific Flows**

### **Navigation**
- Desktop: Sidebar navigation
- Mobile: Bottom tab bar or hamburger menu
- Responsive: Stack flows vertically

### **Timeout Handling**
- Desktop: Show loading modal
- Mobile: Full-screen loading (no confusion)

### **Question Cards**
- Desktop: Side-by-side (question + options)
- Mobile: Stacked (question above options)

---

## 🔄 **Resume Placement Test Flow**

Nếu user bị interrupt giữa test (mất điện, đóng trình duyệt, mất mạng):

```
User làm đến câu 12/20
  ↓
Browser closes / Internet lost
  ↓
Next session: User logs back in
  ↓
Dashboard shows:
┌─────────────────────────────┐
│ "You have an incomplete     │
│  placement test"            │
│                             │
│ [Resume] [Start Over]       │
└─────────────────────────────┘
  ↓
Click "Resume"
  ↓
/test page loads with:
  ├─ Progress: 12/20 (from before)
  ├─ Previous answers cached
  ├─ Continue from Q13
  └─ Can still Prev/Next
  ↓
Complete test (Q13-20)
  ↓
Score as normal (include all 20 answers)
```

**Tech Notes:**
- Save test session ID + question index every 30 seconds
- Cache answers in localStorage (backup to DB)
- Test expires after 7 days incomplete

---

## 🎨 **Empty State Flows**

### **Empty Dashboard (First Time)**
```
User completes test
  ↓
Redirects to Dashboard
  ↓
Dashboard shows:
┌──────────────────────────────┐
│                              │
│  📚 No Learning Started Yet  │
│                              │
│  "You just finished the      │
│   placement test!"           │
│                              │
│  [Start Learning] →          │
│                              │
│  Your Level: B1              │
│  Next Stage: Foundation      │
└──────────────────────────────┘
```

### **Empty Learning Path (No Lessons)**
```
If database has 0 lessons:

┌──────────────────────────────┐
│                              │
│  🚀 Coming Soon!             │
│                              │
│  We're preparing your        │
│  personalized lessons...     │
│                              │
│  [Retake Test] or            │
│  [Check Back Later]          │
│                              │
└──────────────────────────────┘
```

### **Empty Activity (No History)**
```
If user has 0 learning sessions:

┌──────────────────────────────┐
│ Activity (Last 7 Days)       │
│                              │
│  ○ ○ ○ ○ ○ ○ ○              │
│  (No activity yet)           │
│                              │
│  Start your first lesson!    │
│  [Get Started]               │
└──────────────────────────────┘
```

---

## ⚠️ **Error Flows**

### **Error Flow 1: Ollama Service Offline**

```
User submits test answers
  ↓
POST /api/attempts/:id/score
  ↓
Backend tries to call Ollama
  ↓
Ollama not responding (timeout after 5s)
  ↓
Backend returns:
{
  "success": false,
  "message": "Scoring service temporarily unavailable",
  "error": "OLLAMA_OFFLINE"
}
  ↓
Frontend shows:
┌──────────────────────────────┐
│ ⚠️  Unable to Score Test      │
│                              │
│ Our AI service is having     │
│ trouble. Please try again    │
│ in a moment.                 │
│                              │
│ [Retry] [Save & Return]      │
└──────────────────────────────┘
  ↓
User options:
  - Click "Retry" → Call API again (5s timeout)
  - Click "Save & Return" → Save answers, 
    come back later to score
```

### **Error Flow 2: Network Disconnected**

```
User answering question on /test
  ↓
Internet connection lost
  ↓
User clicks "Next" or "Submit"
  ↓
Frontend detects no network
  ↓
Show alert:
┌──────────────────────────────┐
│ 📡 No Internet Connection     │
│                              │
│ Your answers are saved       │
│ locally. Try again when      │
│ you're back online.          │
│                              │
│ [Continue Offline] [Retry]   │
└──────────────────────────────┘
  ↓
"Continue Offline":
  - Allow user to keep answering
  - Answers saved to localStorage
  - Sync to server when back online

"Retry":
  - Try connecting again immediately
```

### **Error Flow 3: Validation Error**

```
User on /test, Question 5 is Writing
  ↓
User types 20 words (min required: 50)
  ↓
User clicks "Next"
  ↓
Frontend validates:
  "Writing answer < 50 words"
  ↓
Show inline error:
┌──────────────────────────────┐
│ Your answer (20 words)       │
│                              │
│ ⚠️  Minimum 50 words required│
│     You have 30 more to go   │
│                              │
│ [Continue Writing]           │
└──────────────────────────────┘
  ↓
User continues typing
  ↓
Error clears automatically when ≥50 words
```

### **Error Flow 4: Server Error (500)**

```
User submitting answers
  ↓
POST /api/attempts fails (500 error)
  ↓
Backend logs error
  ↓
Frontend shows:
┌──────────────────────────────┐
│ ❌ Something Went Wrong      │
│                              │
│ We're sorry! An error        │
│ occurred. Your answers are   │
│ saved locally.               │
│                              │
│ [Retry] [Contact Support]    │
│ Error Code: ERR_500_001      │
└──────────────────────────────┘
  ↓
"Retry" → Call API again (exponential backoff)
"Contact Support" → Email form with error code
```

### **Error Flow 5: Session Expired**

```
User logged in for > 2 hours
  ↓
Token expires
  ↓
User tries to access /test
  ↓
API returns 401 (Unauthorized)
  ↓
Frontend redirects to /login
  ↓
Show message:
┌──────────────────────────────┐
│ Session Expired              │
│                              │
│ You were logged out due to   │
│ inactivity. Please log in    │
│ again.                       │
│                              │
│ [Login]                      │
└──────────────────────────────┘
  ↓
User logs in
  ↓
If test incomplete:
  - Show Resume option
  - Otherwise → Dashboard
```

---

## ✅ **Sign-Off**

- **Approved by:** Chien
- **Date:** [TBD]
- **Version:** 1.0

---

**Next:** Đọc `04_UI_UX.md` cho wireframes + design tokens.
