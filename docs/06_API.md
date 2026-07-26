# 🔌 06_API.md

**Backend API Specification - IELTS Buddy**

---

## 📋 **API Overview**

```
Base URL (Dev):    http://localhost:5000/api
Base URL (Prod):   https://api.ielts-buddy.com/api
Protocol:          REST JSON
Authentication:    JWT Bearer Token
Content-Type:      application/json
Response Format:   Unified JSON (see below)
Timeout:           30 seconds
Version Header:    X-API-Version
```

---

## 🎯 **Important: User vs Learner Model (Clarification)**

**Current MVP Model:** One login account = One learner profile

For MVP Phase 1:
- `POST /auth/register` creates both User account AND Learner profile
- User and Learner are **1:1 relationship** in MVP
- `POST /learners` is NOT used in MVP v1.0
- Future Phase 2: Can support 1 parent account → multiple child learners

**Database Alignment:**
- Keep `Learner` table as primary entity
- No separate `User` table for MVP
- Auth is based on Learner email/password

**If MVP changes to support multiple learners per parent:**
- Need to refactor auth + add User table
- Decide NOW before coding to avoid refactoring

---

## 📝 **Unified Response Format**

**ALL API responses must follow this format:**

### **Success Response (200, 201, etc.)**
```json
{
  "success": true,
  "message": "Operation completed",
  "data": {
    "id": "...",
    "name": "...",
    "other_fields": "..."
  }
}
```

### **Error Response (4xx, 5xx)**
```json
{
  "success": false,
  "message": "Human-readable error message",
  "errorCode": "ERROR_CODE_CONSTANT",
  "details": {} // Optional: additional context
}
```

### **Response Headers**
```
X-API-Version: 1.0
Content-Type: application/json
```

### **Examples**

Success:
```json
{
  "success": true,
  "message": "Learner created successfully",
  "data": {
    "id": "learner-123",
    "email": "student@example.com",
    "name": "Nguyễn Hồng Ngọc",
    "cefrLevel": null,
    "token": "eyJhbGc...",
    "expiresIn": 604800
  }
}
```

Error:
```json
{
  "success": false,
  "message": "Email already registered",
  "errorCode": "EMAIL_ALREADY_EXISTS"
}
```

---

## 🔐 **Authentication**

### **Headers**

```
Authorization: Bearer [JWT_TOKEN]
Content-Type: application/json
Accept: application/json
```

### **JWT Token**

**Current (MVP):**
```
Secret:   Stored in .env (NEVER in code)
Expiry:   7 days
Algorithm: HS256
Claims:   { sub: learnerId, iat, exp }
Payload:  { learnerId, email }
```

**Future (v1.1 Roadmap):**
- Access Token: 15-60 minutes (short-lived, API calls)
- Refresh Token: 7-30 days (long-lived, get new access token)
- Implementation: No changes needed now, just note for later
```

---

## 🔑 **Auth Endpoints**

### **POST /auth/register**

**Create new user account**

```
Request:
{
  "email": "student@example.com",
  "password": "SecurePass123",
  "name": "Nguyễn Hồng Ngọc"
}

Response (201):
{
  "id": "user-123",
  "email": "student@example.com",
  "name": "Nguyễn Hồng Ngọc",
  "token": "eyJhbGc...",
  "expiresIn": 604800
}

Errors:
  400: { error: "Invalid email format" }
  409: { error: "Email already registered" }
  422: { error: "Password too short (min 8)" }
```

### **POST /auth/login**

**Authenticate and get token**

```
Request:
{
  "email": "student@example.com",
  "password": "SecurePass123"
}

Response (200):
{
  "token": "eyJhbGc...",
  "expiresIn": 604800,
  "user": {
    "id": "user-123",
    "email": "student@example.com",
    "name": "Nguyễn Hồng Ngọc"
  }
}

Errors:
  401: { error: "Invalid email or password" }
  400: { error: "Email and password required" }
```

### **POST /auth/logout**

**Invalidate token (client-side handled)**

```
Request: (POST, no body needed, just send token)

Response (200):
{
  "message": "Logged out successfully"
}
```

---

## 👨‍🎓 **Learner Endpoints**

### **GET /learners**

**Get all learners for current user**

```
Query Params: (none for MVP)

Response (200):
[
  {
    "id": "learner-1",
    "name": "Ngọc",
    "grade": 7,
    "cefrLevel": "A2",
    "targetIelts": "IELTS 5.5",
    "xp": 100,
    "createdAt": "2024-01-15T10:30:00Z"
  },
  {
    "id": "learner-2",
    "name": "Đức",
    "grade": 8,
    "cefrLevel": "B1",
    "targetIelts": "IELTS 6.0",
    "xp": 250,
    "createdAt": "2024-01-20T14:15:00Z"
  }
]

Errors:
  401: { error: "Unauthorized" }
```

### **GET /learners/:id**

**Get specific learner**

```
URL: /learners/learner-1

Response (200):
{
  "id": "learner-1",
  "name": "Ngọc",
  "grade": 7,
  "cefrLevel": "A2",
  "targetIelts": "IELTS 5.5",
  "xp": 100,
  "createdAt": "2024-01-15T10:30:00Z",
  "lastAttempt": {
    "id": "attempt-5",
    "cefrResult": "A2",
    "createdAt": "2024-01-25T09:00:00Z"
  }
}

Errors:
  404: { error: "Learner not found" }
  401: { error: "Unauthorized" }
```

### **POST /learners**

**Create new learner/child profile**

```
Request:
{
  "name": "Lan",
  "grade": 6,
  "targetIelts": "IELTS 5.0"
}

Response (201):
{
  "id": "learner-3",
  "name": "Lan",
  "grade": 6,
  "cefrLevel": null,
  "targetIelts": "IELTS 5.0",
  "xp": 0,
  "createdAt": "2024-01-26T10:00:00Z"
}

Errors:
  400: { error: "Name required" }
  422: { error: "Grade must be 4-9" }
```

### **PUT /learners/:id**

**Update learner profile**

```
URL: /learners/learner-1

Request:
{
  "targetIelts": "IELTS 6.0"
}

Response (200):
{
  "id": "learner-1",
  "name": "Ngọc",
  "grade": 7,
  "targetIelts": "IELTS 6.0",  // ← Updated
  "cefrLevel": "A2",
  "xp": 100,
  "updatedAt": "2024-01-26T11:00:00Z"
}

Errors:
  404: { error: "Learner not found" }
  400: { error: "Invalid target IELTS format" }
```

### **DELETE /learners/:id**

**Delete learner (soft delete recommended)**

```
URL: /learners/learner-3

Response (204): (No content)

Errors:
  404: { error: "Learner not found" }
  403: { error: "Cannot delete" }
```

---

## ❓ **Question Endpoints**

### **GET /questions**

**Get questions for adaptive test**

```
Query Params:
  ?skill=reading          (filter by skill)
  ?level=A2              (filter by level)
  ?limit=1               (number of questions)

Example:
  GET /questions?skill=reading&level=A2&limit=1

Response (200):
[
  {
    "id": "q1",
    "skill": "reading",
    "type": "mcq",
    "prompt": "The Amazon rainforest is the largest tropical forest...",
    "options": ["Tropical forest", "Desert", "Mountain", "Ocean"],
    "level": "A2",
    "audioUrl": null
  }
]

Errors:
  400: { error: "Invalid skill or level" }
```

### **GET /questions/:id** (Optional)

**Get single question details**

```
Response (200):
{
  "id": "q1",
  "skill": "reading",
  "type": "mcq",
  "prompt": "...",
  "options": [...],
  "level": "A2"
}
```

---

## 📝 **Test Attempt Endpoints**

### **POST /attempts**

**Submit test answers**

```
Request:
{
  "learnerId": "learner-1",
  "answers": {
    "q1": "0",              // MCQ: option index
    "q2": "1",
    "q3": "3",
    "q4": "I like reading",    // Speaking: text
    "q5": "My hobby is..."     // Writing: text
  }
}

Response (201):
{
  "id": "attempt-1",
  "learnerId": "learner-1",
  "answers": { ... },
  "scores": {
    "reading": 100,
    "grammar": 100,
    "listening": 0,
    "speaking": null,       // Pending Ollama
    "writing": null
  },
  "cefrResult": null,        // Pending
  "status": "pending",
  "createdAt": "2024-01-26T12:00:00Z"
}

Errors:
  400: { error: "All answers required" }
  404: { error: "Learner not found" }
```

### **POST /attempts/:id/score**

**Trigger async scoring (Ollama) and learning path generation**

**Note:** This is ASYNC. Returns 202 Accepted, scoring happens in background.

```
URL: /attempts/attempt-1/score

Request: 
{
  "requestId": "req-unique-123"  // Optional: idempotency key
}

Response (202 Accepted):
{
  "success": true,
  "message": "Scoring started in background",
  "data": {
    "id": "attempt-1",
    "status": "scoring",
    "statusMessage": "AI is analyzing your test...",
    "estimatedTime": 15  // seconds
  }
}

Frontend Action:
  → Poll GET /attempts/:id/result every 2-3 seconds
  → Or wait for WebSocket notification (v1.1+)

Error Cases:
  400: { success: false, message: "Attempt already scored", errorCode: "ALREADY_SCORED" }
  409: { success: false, message: "Invalid attempt state", errorCode: "INVALID_STATE" }
  404: { success: false, message: "Attempt not found", errorCode: "NOT_FOUND" }

Idempotency:
  If request with same `requestId` is sent twice:
    → Return same result, don't re-score
    → Prevents double-scoring if network retries
```

### **GET /attempts/:id/result**

**Poll for scoring results (call this every 2-3 seconds)**

```
URL: /attempts/attempt-1/result

Response (200 - Still Scoring):
{
  "success": true,
  "message": "Still scoring...",
  "data": {
    "status": "scoring",
    "progress": 65  // 0-100
  }
}

Response (200 - Complete):
{
  "success": true,
  "message": "Scoring complete",
  "data": {
    "id": "attempt-1",
    "status": "completed",
    "cefrResult": "B1",
    "scores": {
      "reading": 100,
      "grammar": 100,
      "listening": 0,
      "speaking": 65,
      "writing": 72
    },
    "feedback": "Excellent reading skills! Work on listening.",
    "learningPath": {
      "currentStage": "foundation",
      "nextLesson": 1,
      "estimatedCompletionDate": "2024-03-15"
    }
  }
}

Error (Scoring Failed):
{
  "success": false,
  "message": "Ollama service unavailable",
  "errorCode": "OLLAMA_OFFLINE"
}
```

**Old Endpoint (DEPRECATED - Do Not Use):**
  503: { error: "Ollama service unavailable" }  // Fallback scores returned
```

### **GET /attempts/:id/result**

**Get test result**

```
URL: /attempts/attempt-1/result

Response (200):
{
  "id": "attempt-1",
  "learnerId": "learner-1",
  "cefr": "B1",
  "scores": {
    "reading": 100,
    "grammar": 100,
    "listening": 0,
    "speaking": 65,
    "writing": 72
  },
  "feedback": "Excellent reading skills...",
  "roadmap": [...],
  "resources": [...],
  "createdAt": "2024-01-26T12:00:00Z",
  "completedAt": "2024-01-26T12:05:00Z"
}

Errors:
  404: { error: "Attempt not found" }
```

### **GET /attempts?learnerId=:id**

**Get all attempts for a learner**

```
Query:
  ?learnerId=learner-1
  ?limit=10              (pagination)
  ?offset=0

Response (200):
[
  {
    "id": "attempt-5",
    "cefrResult": "B1",
    "scores": {...},
    "createdAt": "2024-01-26T12:00:00Z"
  },
  {
    "id": "attempt-4",
    "cefrResult": "A2",
    "scores": {...},
    "createdAt": "2024-01-20T10:00:00Z"
  }
]
```

---

## 📊 **Dashboard Endpoint**

### **GET /dashboard/:learnerId**

**Get dashboard data (main hub for learner)**

**Future Scalability:** Can split into separate endpoints later (/missions, /progress, /activity), but MVP returns combined data.

```
URL: /dashboard/learner-1

Response (200):
{
  "success": true,
  "message": "Dashboard loaded",
  "data": {
    "learner": {
      "id": "learner-1",
      "name": "Ngọc",
      "cefrLevel": "B1",
      "targetIelts": "IELTS 6.0",
      "xp": 1250,
      "streak": 7  // consecutive days of activity
    },
    
    "todayMission": {
      "id": "mission-123",
      "title": "Learn 10 Vocabulary Words",
      "description": "Foundation stage vocabulary",
      "xpReward": 50,
      "estimatedMinutes": 15,
      "completed": false,
      "deadline": "2024-01-26T23:59:59Z"
    },
    
    "nextLesson": {
      "id": "lesson-5",
      "stage": "foundation",
      "title": "Basic Greetings",
      "description": "Learn common English greetings",
      "duration": 20,  // minutes
      "difficulty": 1  // 1=easy, 2=medium, 3=hard
    },
    
    "latestAttempt": {
      "cefrResult": "B1",
      "createdAt": "2024-01-26T12:00:00Z",
      "id": "attempt-5"
    },
    
    "progress": {
      "foundation": {
        "percentage": 50,
        "lessonsCompleted": 5,
        "lessonsTotal": 10
      },
      "intermediate": {
        "percentage": 0,
        "lessonsCompleted": 0,
        "lessonsTotal": 15
      },
      "examprep": {
        "percentage": 0,
        "lessonsCompleted": 0,
        "lessonsTotal": 10
      }
    },
    
    "activity": {
      "mon": 45,   // minutes
      "tue": 60,
      "wed": 30,
      "thu": 0,
      "fri": 90,
      "sat": 0,
      "sun": 0,
      "totalThisWeek": 225
    },
    
    "notifications": [
      {
        "id": "notif-1",
        "type": "milestone",
        "message": "Great! You completed Foundation stage!",
        "createdAt": "2024-01-25T10:00:00Z",
        "read": false
      }
    ]
  }
}
```

---

## ⚠️ **Error Response Format**

```
All errors return JSON:
{
  "error": "Error message",
  "code": "ERROR_CODE",
  "status": 400,
  "timestamp": "2024-01-26T12:00:00Z"
}

Common Status Codes:
  200  OK
  201  Created
  204  No Content
  400  Bad Request (validation error)
  401  Unauthorized (missing/invalid token)
  403  Forbidden (not allowed)
  404  Not Found
  422  Unprocessable Entity (business logic error)
  500  Internal Server Error
  503  Service Unavailable (Ollama down)
```

---

## 🔄 **Rate Limiting**

```
Endpoint:             Limit
POST /auth/login      5 per minute per IP
POST /auth/register   3 per hour per IP
POST /attempts        10 per day per learner
GET /*                1000 per hour per token
```

---

## 📚 **Pagination**

```
Query Parameters:
  ?limit=10   (default: 10, max: 100)
  ?offset=0   (default: 0)

Response includes:
{
  "data": [...],
  "pagination": {
    "total": 50,
    "limit": 10,
    "offset": 0,
    "nextOffset": 10,
    "hasMore": true
  }
}
```

---

## 🧪 **Testing Endpoints**

### **GET /health**

**Health check - Detailed system status (no auth required)**

```
Response (200 - All Healthy):
{
  "success": true,
  "message": "System operational",
  "data": {
    "status": "ok",
    "timestamp": "2024-01-26T12:00:00Z",
    "version": "1.0.0",
    "uptime": 864000,  // seconds since startup
    "services": {
      "api": {
        "status": "ok",
        "responseTime": 45  // ms
      },
      "database": {
        "status": "ok",
        "queryTime": 15  // ms
      },
      "ollama": {
        "status": "ok",
        "model": "qwen2.5:14b",
        "responseTime": 2500  // ms
      }
    }
  }
}

Response (503 - Ollama Down):
{
  "success": false,
  "message": "Ollama service unavailable",
  "errorCode": "OLLAMA_OFFLINE",
  "data": {
    "status": "degraded",
    "services": {
      "api": { "status": "ok" },
      "database": { "status": "ok" },
      "ollama": { "status": "offline" }
    }
  }
}
```

**Usage:** For monitoring dashboards, load balancers, and alerting systems.

---

## 📚 **API Documentation & Code Generation**

### **OpenAPI 3.0 Specification**

For better tooling and code generation:
- Location: `/backend/openapi.yaml` (or auto-generated from code)
- Tools: Swagger UI, Redoc, OpenAPI Generator
- Benefits:
  - AI can auto-generate Controller stubs from spec
  - Frontend can mock API using Prism
  - TypeScript types auto-generated
  - Client SDK auto-generated

### **Usage for Development:**
```
POST /attempts → Auto-generates:
  ├─ Express controller handler
  ├─ Request/Response TypeScript types
  ├─ API client SDK for frontend
  └─ Mock server for testing
```

**Implement in Sprint 2+**, not MVP. For now, follow the format in this document.

---

```
Current:  v1.0
Endpoint: /api/v1/... (for future versioning)
```

---

**Version:** 1.0
**Last Updated:** [Date]
**Status:** APPROVED

---

## 🏗️ **API Architecture Decision Records (ADR)**

### **ADR-1: Unified Response Format**
**Decision:** All responses use `{ success, message, data, errorCode }` format.
**Why:** Frontend can handle errors consistently; AI code generation easier.

### **ADR-2: Async Scoring (202 Accepted)**
**Decision:** POST /attempts/:id/score returns 202, use GET /attempts/:id/result to poll.
**Why:** Prevents blocking on long Ollama operations; better UX with progress feedback.

### **ADR-3: User = Learner (MVP 1:1 Relationship)**
**Decision:** One login account = One learner profile (no separate User table).
**Why:** MVP simplicity. Refactor to 1:many (parent→children) in v1.1 if needed.

### **ADR-4: RESTful Resource Design**
**Decision:** Use `/resource` endpoints, not action verbs (`/doLogin`, `/saveQuestion`).
**Why:** Follows REST conventions; scales to mobile + AI clients without confusion.

### **ADR-5: Version Header**
**Decision:** Responses include `X-API-Version: 1.0` header.
**Why:** Easier debugging when multiple API versions coexist; better logging.

---

## ✅ **Sign-Off**

- **API Architect:** AI
- **Reviewed by:** ChatGPT (9.9/10)
- **API Version:** 1.0
- **Status:** Ready for Backend implementation
- **Design Pattern:** REST + Async processing
- **Response Format:** Unified JSON with `{ success, message, data }` envelope
