# 📋 99_RELEASE_CRITERIA.md

**MVP Release Checklist - Quality Gates Before v1.0.0**

---

## 🎯 **Purpose**

This document defines the **Final Quality Gate** before releasing IELTS Buddy v1.0.

All items must be **✅ PASS** before release.

---

## ✅ **MVP Release Checklist**

### **1. Build & Deployment (Critical)**

```
☐ Build succeeds without errors
  └─ npm run build (frontend)
  └─ No TypeScript errors
  └─ No console errors in browser DevTools

☐ Application starts without issues
  └─ Frontend: npm run dev → localhost:3000 loads
  └─ Backend: npm run dev → localhost:5000 API responds
  └─ PostgreSQL connects successfully
  └─ Ollama service runs (qwen2.5:14b available)

☐ No critical bugs (Blocker)
  └─ app doesn't crash on any user flow
  └─ No unhandled exceptions in console
  └─ All error messages are user-friendly
```

### **2. Core Features (Must Have)**

```
☐ Authentication Works
  └─ User can register with email/password
  └─ User can login successfully
  └─ Password validation enforced (min 8 chars)
  └─ Session persists across page reload
  └─ Logout clears session

☐ Learner Management Works
  └─ User can create child profile(s)
  └─ Can switch between children without re-login
  └─ Child name, grade stored correctly
  └─ Edit child info works
  └─ Delete child (with confirmation) works

☐ Placement Test Works (Adaptive 15-20 questions)
  └─ Test starts from welcome screen
  └─ Questions display correctly (MCQ + text input)
  └─ Progress bar shows accurate progress (1/15 → 20/20)
  └─ Navigation (Prev/Next) works correctly
  └─ Submit only enabled on last question
  └─ All answers saved to database
  └─ Adaptive difficulty changes based on answers
  └─ Test completion time is reasonable (~10-15 min)

☐ AI Scoring Works
  └─ MCQ auto-scores correctly (100% accuracy)
  └─ Writing/Speaking scores via Ollama API
  └─ Score calculation produces correct CEFR level (A1-C2)
  └─ Scoring completes in reasonable time (<5 seconds per answer)
  └─ No timeout errors during scoring

☐ Result Display Works
  └─ CEFR level displays correctly
  └─ 4 skill scores (Reading, Grammar, Listening, Writing) shown
  └─ Learning path generated based on CEFR
  └─ Result can be viewed multiple times without re-scoring

☐ Dashboard Works
  └─ Dashboard loads without errors
  └─ Shows learner info correctly
  └─ Progress bars update correctly
  └─ Today's tasks displayed
  └─ Overall progress tracked
  └─ Data persists after page reload

☐ Learning Path Works
  └─ 3 learning stages visible (Foundation / Intermediate / Exam Prep)
  └─ Stage recommendations match CEFR level
  └─ Users can navigate through stages
  └─ Learning path data stored correctly
```

### **3. Data Integrity (Critical)**

```
☐ Database Schema Correct
  └─ Learner table structure correct
  └─ Question table populated with 20+ questions
  └─ TestAttempt records saved properly
  └─ Relationships (foreign keys) work

☐ Data Persistence
  └─ All user data persists after logout/login
  └─ Test attempts saved correctly
  └─ Scores not lost on page refresh
  └─ CEFR level remains consistent

☐ Data Validation
  └─ Invalid inputs rejected (email, password, text length)
  └─ No SQL injection vulnerabilities
  └─ No XSS vulnerabilities
  └─ File uploads sanitized (if applicable)
```

### **4. API Endpoints (Critical)**

```
☐ All Endpoints Respond Correctly
  └─ POST /api/auth/register → 201 (success) or 400 (validation error)
  └─ POST /api/auth/login → 200 (token) or 401 (invalid)
  └─ GET /api/learners → 200 (learners list)
  └─ POST /api/learners → 201 (created)
  └─ GET /api/questions?skill=X → 200 (questions)
  └─ POST /api/attempts → 201 (created)
  └─ POST /api/attempts/:id/score → 200 (scored)
  └─ GET /api/attempts/:id/result → 200 (result)
  └─ GET /api/dashboard/:learnerId → 200 (dashboard data)

☐ API Response Format Standardized
  └─ All responses follow format:
     {
       "success": true,
       "message": "Success message",
       "data": { ... }
     }
  └─ Error responses include clear error message
  └─ No inconsistent response structures

☐ API Performance
  └─ API responses < 1 second (90th percentile)
  └─ No timeout issues
  └─ Concurrent requests handled correctly
```

### **5. UI/UX (Important)**

```
☐ Responsive Design
  └─ Mobile (375px): All content visible, no horizontal scroll
  └─ Tablet (768px): Layout adapts properly
  └─ Desktop (1024px+): Optimal experience
  └─ No layout shifts or broken elements

☐ User Experience
  └─ Navigation intuitive and clear
  └─ Loading states visible (spinners, skeletons)
  └─ Error messages helpful and actionable
  └─ Success messages clear and encouraging
  └─ Button states (disabled, loading) visible
  └─ Forms include input validation feedback

☐ Accessibility
  └─ All buttons have appropriate labels
  └─ Form fields properly associated with labels
  └─ Color contrast meets WCAG AA standards
  └─ Keyboard navigation works
  └─ Focus indicators visible
```

### **6. Testing (Critical)**

```
☐ Unit Tests Pass
  └─ Frontend tests: 80%+ coverage
  └─ Backend tests: 85%+ coverage
  └─ All critical functions tested
  └─ Tests run: npm test passes

☐ Integration Tests Pass
  └─ End-to-end workflow tested:
     Register → Create learner → Take test → Score → View result
  └─ All API endpoints tested
  └─ Database interactions tested

☐ Manual QA Testing
  └─ Per 12_TEST_PLAN.md: 60+ test cases
  └─ ≥95% test cases pass
  └─ No showstopper bugs
  └─ Browser compatibility verified (Chrome, Firefox, Edge latest)

☐ No Critical Bugs
  └─ 0 P0 (Critical/Blocker) bugs remaining
  └─ ≤3 P1 (High) bugs (if none = ideal)
  └─ P2 (Medium) bugs acceptable for v1.0 (can be v1.1)
```

### **7. Ollama Integration (Critical)**

```
☐ Ollama Model Loads
  └─ qwen2.5:14b successfully loaded
  └─ Model responds to API calls
  └─ No out-of-memory errors

☐ Scoring Accuracy
  └─ MCQ scoring 100% accurate
  └─ Writing scoring reasonable (basic evaluation)
  └─ CEFR calculations correct
  └─ No timeout issues (< 5 seconds per request)

☐ Fallback Handling
  └─ If Ollama unavailable, graceful error message
  └─ User instructed to check Ollama service
  └─ App doesn't crash
```

### **8. Performance (Important)**

```
☐ Page Load Time
  └─ Homepage loads in < 3 seconds
  └─ No excessive JavaScript bundles
  └─ Images optimized (< 50KB average)

☐ API Response Time
  └─ 95th percentile < 1 second
  └─ No N+1 query issues
  └─ Database queries optimized

☐ No Memory Leaks
  └─ Long session (30+ min) doesn't cause slowdown
  └─ Component unmounting cleans up resources
  └─ No console memory warnings
```

### **9. Documentation (Important)**

```
☐ README Updated
  └─ Installation instructions current
  └─ Setup guide matches actual steps
  └─ Troubleshooting section included
  └─ Example usage provided

☐ CHANGELOG Updated
  └─ All features listed under v1.0.0
  └─ Bug fixes documented
  └─ Known limitations listed

☐ Code Comments
  └─ Complex logic documented
  └─ API documentation complete
  └─ Database schema documented
  └─ Environment variables documented (.env.example)

☐ API Documentation
  └─ All endpoints documented (from 06_API.md)
  └─ Request/response examples provided
  └─ Error codes explained
```

### **10. Security (Critical)**

```
☐ Basic Security Checklist
  └─ No hardcoded secrets in code
  └─ Environment variables used for sensitive data
  └─ SQL injection prevented (parameterized queries)
  └─ XSS prevention (input sanitization)
  └─ CSRF tokens on forms (if applicable)
  └─ Password hashed (bcrypt or similar)
  └─ No sensitive data in console logs

☐ HTTPS Ready
  └─ Code compatible with HTTPS
  └─ No mixed content warnings
  └─ Ready for production deployment
```

### **11. Deployment Readiness (Important)**

```
☐ Environment Configuration
  └─ .env.example provided
  └─ All required variables documented
  └─ Database migration scripts provided
  └─ Seed data available for demo

☐ Build & Run Instructions Clear
  └─ Deployment guide written
  └─ Dependencies listed
  └─ System requirements documented
  └─ Troubleshooting guide provided

☐ Monitoring Capability
  └─ Logs are accessible (not lost on restart)
  └─ Error tracking set up (if applicable)
  └─ Performance monitoring in place
```

---

## 📊 **Release Sign-Off**

### **Required Approvals**

```
☐ Product Owner: Confirms MVP meets vision
☐ QA Lead: Confirms test coverage ≥95%
☐ Tech Lead: Confirms code quality and performance
☐ Security: Confirms no critical security issues
```

### **Go/No-Go Decision**

```
GO → Release v1.0.0 when:
     ✅ All Critical items PASS
     ✅ All Must-Have features working
     ✅ ≤3 P1 bugs (or 0 if possible)
     ✅ 0 P0 (Critical) bugs
     ✅ All approvals signed off

NO-GO → Stop and fix if:
        ❌ Any Critical item FAILS
        ❌ Core feature broken
        ❌ ≥5 P1 bugs
        ❌ Security vulnerability found
        ❌ Test coverage < 80%
```

---

## 🎉 **Post-Release**

### **v1.0.0 Released When:**

```
✅ Build deployed to production
✅ All systems operational
✅ Monitoring active
✅ Documentation accessible
✅ User feedback channel open
```

### **Track Issues for v1.1:**

```
□ Log all P2/P3 bugs reported
□ Collect user feedback
□ Plan improvements
□ Schedule v1.1 sprint
```

---

## 📝 **Version History**

```
v1.0.0 - MVP Release
  Release Date: [DATE]
  Sign-off: Product Owner _____ Tech Lead _____ QA _____
```

---

**This checklist ensures IELTS Buddy v1.0 is ready for users! ✨**
