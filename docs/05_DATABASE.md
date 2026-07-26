# 🗄️ 05_DATABASE.md

**Database Design - PostgreSQL Schema for IELTS Buddy**

---

## 📊 **Architecture: 2 Phases**

### **Phase 1: Placement Testing (MVP Sprint 1-3)**
```
Learner → TestAttempt → Question
                ↓
         AI Scoring (Ollama)
                ↓
         CEFR Level Assigned
```

### **Phase 2: Learning & Progress (Sprint 4+)**
```
Learner → LearningPath → Lesson → Progress
                ↓
         Dashboard & Daily Tasks
```

---

## 📊 **ER Diagram (All Entities)**

```
┌──────────────┐
│   Learner    │ (1) ──────(M) ┌─────────────┐
│              │               │ TestAttempt │
├──────────────┤               ├─────────────┤
│ id           │               │ id          │
│ email        │               │ learnerId   │
│ name         │               │ answers     │
│ cefrLevel    │               │ scores      │
│ createdAt    │               │ cefrResult  │
└──────────────┘               └─────────────┘

┌──────────────┐
│   Question   │ (M) ←── (1) TestAttempt
├──────────────┤
│ id           │
│ skill        │
│ level        │
│ difficulty   │
│ stage        │
│ category     │
│ isActive     │
└──────────────┘

┌──────────────┐
│LearningPath  │ (1) ──────(M) ┌──────────────┐
│              │               │LearningProgress
├──────────────┤               ├──────────────┤
│ id           │               │ id           │
│ learnerId    │               │ pathId       │
│ currentStage │               │ currentLesson│
│ cefrLevel    │               │ completed    │
└──────────────┘               └──────────────┘
```

---

## 📋 **Schema Definition (Prisma)**

```prisma
// This will be in backend/prisma/schema.prisma

datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

generator client {
  provider = "prisma-client-js"
}

// ========== PHASE 1: PLACEMENT ==========

// ========== MODEL: Learner ==========
// Represents a student/child account
// Supports: email/password OR external auth (Google, Supabase, etc.)

model Learner {
  // Primary Key
  id        String   @id @default(cuid()) @db.VarChar(255)
  
  // Identity
  email     String   @unique @db.VarChar(255)
  password  String?  @db.VarChar(255)  // Optional: null if using external auth
  name      String   @db.VarChar(100)
  grade     Int      @db.SmallInt      // 4, 5, 6, 7, 8, 9
  
  // Learning Progress
  cefrLevel String?  @db.VarChar(10)   // A1, A2, B1, B1+, B2, B2+, C1, C2
  targetIelts String? @db.VarChar(50)  // "IELTS 6.0", "IELTS 7.0"
  xp        Int      @default(0)       // Will move to LearningProgress later
  
  // Timestamps & Audit
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt
  createdBy String?  @db.VarChar(255)  // For future audit logging
  
  // Relations
  attempts         TestAttempt[]
  learningPath     LearningPath?
  learningProgress LearningProgress[]
  
  // Indexes
  @@index([grade])
  @@index([cefrLevel])
  @@index([email])
}

// ========== MODEL: Question ==========
// Stores all test questions with support for adaptive testing

model Question {
  // Primary Key
  id        String @id @default(cuid()) @db.VarChar(255)
  
  // Question Content
  skill     String @db.VarChar(50)  // reading|grammar|listening|speaking|writing
  type      String @db.VarChar(50)  // mcq|speaking|writing
  prompt    String @db.Text          // Question text
  sub       String? @db.Text         // Sub-instruction
  
  // Learning Structure
  category  String @db.VarChar(100) // vocabulary|grammar|listening|reading|writing
  stage     String @db.VarChar(50)  // foundation|intermediate|examprep
  lesson    Int    @default(1)      // Lesson number within stage
  order     Int    @default(1)      // Question order in lesson
  
  // Difficulty (for adaptive testing)
  level     String @db.VarChar(10)  // A1, A2, B1, B1+, B2, B2+, C1, C2
  difficulty Int   @db.SmallInt     // 1=Easy, 2=Medium, 3=Hard
  
  // Media
  audioUrl  String? @db.VarChar(500) // For listening questions
  
  // MCQ Options
  options   Json?                     // ["Option A", "Option B", "Option C", "Option D"]
  answer    Int?                      // Index of correct answer (0-3)
  
  // Status & Audit
  isActive  Boolean @default(true)   // Soft delete support
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt
  createdBy String   @db.VarChar(255) // AI-generated or admin
  
  // Indexes
  @@index([skill])
  @@index([level])
  @@index([difficulty])
  @@index([stage])
  @@index([category])
  @@index([isActive])
}

// ========== MODEL: TestAttempt ==========
// Stores user test submissions & results

model TestAttempt {
  // Primary Key
  id              String   @id @default(cuid()) @db.VarChar(255)
  
  // Foreign Key
  learnerId       String   @db.VarChar(255)
  learner         Learner  @relation(fields: [learnerId], references: [id], onDelete: Cascade)
  
  // Test Metadata
  questionSetVersion String @default("v1") @db.VarChar(50) // Track which version of questions used
  
  // Answers (JSON format)
  answers         Json     // { "q1": "0", "q2": "1", "q4": "My text answer...", ... }
  
  // Scores (null until computed)
  scores          Json?    // { "reading": 100, "grammar": 70, "listening": 50, "speaking": 65, "writing": 72 }
  cefrResult      String?  @db.VarChar(10)  // A1, A2, B1, B1+, B2, B2+, C1, C2
  
  // Feedback
  feedback        String?  @db.Text         // AI feedback
  
  // Status
  status          String   @default("pending") @db.VarChar(50) // pending|scoring|completed
  
  // Timestamps
  createdAt       DateTime @default(now())
  updatedAt       DateTime @updatedAt
  
  // Indexes
  @@index([learnerId])
  @@index([createdAt])
  @@index([status])
  @@index([questionSetVersion])
}

// ========== PHASE 2: LEARNING & PROGRESS ==========

// ========== MODEL: LearningPath ==========
// Tracks learner's personalized learning journey

model LearningPath {
  // Primary Key
  id              String   @id @default(cuid()) @db.VarChar(255)
  
  // Foreign Key
  learnerId       String   @unique @db.VarChar(255)
  learner         Learner  @relation(fields: [learnerId], references: [id], onDelete: Cascade)
  
  // Current Status
  currentStage    String   @db.VarChar(50)  // foundation|intermediate|examprep
  currentLesson   Int      @default(1)      // Lesson number in current stage
  currentCEFR     String   @db.VarChar(10)  // Last assessed CEFR level
  targetCEFR      String?  @db.VarChar(10)  // Target CEFR level
  
  // Progress Tracking
  totalLessonsCompleted Int @default(0)
  estimatedCompletion   DateTime? // When is this path expected to complete?
  nextReviewDate        DateTime?
  
  // Timestamps
  createdAt       DateTime @default(now())
  updatedAt       DateTime @updatedAt
  
  // Relations
  progress        LearningProgress[]
  
  // Indexes
  @@index([learnerId])
  @@index([currentStage])
}

// ========== MODEL: LearningProgress ==========
// Track completion of individual lessons/missions

model LearningProgress {
  // Primary Key
  id              String   @id @default(cuid()) @db.VarChar(255)
  
  // Foreign Keys
  learnerId       String   @db.VarChar(255)
  learner         Learner  @relation(fields: [learnerId], references: [id], onDelete: Cascade)
  
  pathId          String   @db.VarChar(255)
  path            LearningPath @relation(fields: [pathId], references: [id], onDelete: Cascade)
  
  // Lesson Info
  stage           String   @db.VarChar(50)  // foundation|intermediate|examprep
  lessonNumber    Int                       // Lesson 1, 2, 3... in stage
  
  // Completion Status
  isCompleted     Boolean  @default(false)
  completedAt     DateTime?
  
  // Performance
  score           Int?                      // 0-100
  xpEarned        Int      @default(0)
  
  // Timestamps
  createdAt       DateTime @default(now())
  updatedAt       DateTime @updatedAt
  
  // Indexes
  @@index([learnerId])
  @@index([pathId])
  @@index([stage])
  @@unique([learnerId, pathId, stage, lessonNumber]) // Prevent duplicates
}
```

---

## 🔑 **Primary Keys & Indexing**

### **Primary Keys (PK)**
```
Learner     → id (cuid: collision-resistant)
Question    → id (cuid)
TestAttempt → id (cuid)
```

### **Indexes (Performance)**
```
Learner
  ├─ grade          (filter by grade level)
  ├─ cefrLevel      (filter by CEFR)
  └─ email          (uniqueness + search)

Question
  ├─ skill          (filter questions by skill)
  ├─ level          (adaptive difficulty)
  └─ type           (MCQ vs open-ended)

TestAttempt
  ├─ learnerId      (find attempts by learner)
  ├─ createdAt      (sort by time)
  └─ status         (find pending scoring)
```

---

## 📝 **Sample Data (Seed)**

### **Learner**
```sql
INSERT INTO "Learner" (id, email, password, name, grade, cefrLevel, targetIelts, xp, createdAt)
VALUES
  ('learner-1', 'ngoc@example.com', '$2b$10$...hashed...', 'Nguyễn Hồng Ngọc', 7, 'A2', 'IELTS 5.5', 100, NOW()),
  ('learner-2', 'duc@example.com', '$2b$10$...hashed...', 'Trần Hữu Đức', 8, 'B1', 'IELTS 6.0', 250, NOW());
```

### **Question**
```sql
INSERT INTO "Question" (id, skill, type, prompt, sub, options, answer, level)
VALUES
  ('q1', 'reading', 'mcq', 'The Amazon rainforest...', NULL, '["Tropical forest","Desert","Mountain","Ocean"]', 0, 'A2'),
  ('q2', 'grammar', 'mcq', 'She ___ every day.', NULL, '["go","goes","going","gone"]', 1, 'A2'),
  ('q5', 'writing', 'writing', 'Write about your hobby', 'Write 80-100 words', NULL, NULL, 'A2');
```

### **TestAttempt**
```sql
INSERT INTO "TestAttempt" (id, learnerId, answers, scores, cefrResult, status)
VALUES
  ('attempt-1', 'learner-1', 
   '{"q1":"0","q2":"1","q3":"2","q4":"I love reading books","q5":"My hobby is..."}',
   '{"reading":100,"grammar":100,"listening":0,"speaking":65,"writing":72}',
   'B1', 'completed');
```

---

## 🔐 **Data Types & Constraints**

| Column | Type | Constraint | Reason |
|--------|------|-----------|--------|
| email | VARCHAR(255) | UNIQUE | No duplicate accounts |
| password | VARCHAR(255) | NOT NULL | Mandatory auth |
| grade | SMALLINT | 4-9 | Small range (saves space) |
| options | JSON | MCQ only | Flexible structure |
| answers | JSON | NOT NULL | Stores any answer type |
| scores | JSON | Nullable | Computed after scoring |
| cefrResult | VARCHAR(10) | Nullable | Computed last |

---

## 🔄 **Relationships**

### **Learner → TestAttempt**
```
Type: 1-to-Many (1 learner can have many attempts)
FK: learnerId in TestAttempt references Learner.id
Cascade: DELETE learner → DELETE all their attempts
```

### **Question (Implicit)**
```
Questions are independent
Not directly linked to TestAttempt
Answers store question IDs as keys in JSON
```

---

## 📊 **Query Examples**

### **Find all attempts by a learner**
```sql
SELECT * FROM "TestAttempt"
WHERE learnerId = 'learner-1'
ORDER BY createdAt DESC;
```

### **Get learner's latest CEFR level**
```sql
SELECT learnerId, cefrResult
FROM "TestAttempt"
WHERE learnerId = 'learner-1' AND cefrResult IS NOT NULL
ORDER BY createdAt DESC
LIMIT 1;
```

### **Get questions for adaptive test (A2 level, reading)**
```sql
SELECT * FROM "Question"
WHERE level = 'A2' AND skill = 'reading'
ORDER BY RANDOM()
LIMIT 1;
```

### **Count completed vs pending attempts**
```sql
SELECT status, COUNT(*) as count
FROM "TestAttempt"
GROUP BY status;
```

---

## 🚀 **Database Migrations (Prisma)**

```bash
# Create database
createdb ielts_buddy

# Push schema to database
npx prisma migrate dev --name init

# Generate Prisma client
npx prisma generate

# Seed database (optional)
npm run seed
```

---

## 🛡️ **Security Considerations**

### **Password Storage**
```
✓ Hash with bcrypt (salt rounds: 10)
✗ NEVER store plaintext passwords
```

### **Data Privacy**
```
✓ No payment data stored
✓ Email + learning data only
✓ Comply with GDPR (right to deletion)
✓ No cookies for PII
```

### **SQL Injection Prevention**
```
✓ Use Prisma ORM (parameterized queries)
✓ Never use string concatenation for queries
```

---

## 📈 **Scalability Notes**

### **For 1,000 users:**
```
✓ Current schema sufficient
✓ Indexes cover common queries
✓ No sharding needed
```

### **For 100,000+ users:**
```
✓ Consider partitioning TestAttempt by date
✓ Archive old attempts to cold storage
✓ Cache CEFR scores in Redis
✓ Denormalize Learner.cefrLevel for fast lookup
```

---

## 📚 **Relationships Diagram (Text)**

```
Learner (1)
    ↓ (M)
    └─→ TestAttempt
           ├─ answers JSON  (references Question.id as keys)
           ├─ scores JSON
           └─ cefrResult

Question (referenced in TestAttempt.answers JSON)

Learner (1)
    ├─→ LearningPath (1)
    │     └─→ LearningProgress (M)
    └─→ LearningProgress (M)
```

---

## 🏗️ **Architecture Decision Records (ADR)**

### **ADR-1: Phase 1 vs Phase 2 Separation**
**Decision:** Split into Placement (Phase 1) and Learning (Phase 2) models.
**Why:** MVP launches with just Phase 1; Phase 2 added later without refactoring.

### **ADR-2: Optional Password (External Auth Ready)**
**Decision:** `Learner.password` is optional (`String?`).
**Why:** Prepare for Firebase/Supabase migration; schema ready without changes.

### **ADR-3: JSON for Answers & Scores**
**Decision:** Store as JSON, not normalized tables.
**Why:** Simpler queries, flexible structure, faster for test results.

### **ADR-4: Soft Delete for Questions**
**Decision:** Use `isActive` flag instead of deleting.
**Why:** Preserve historical test results; re-enable without data loss.

### **ADR-5: XP Refactor (Future)**
**Status:** Currently in `Learner.xp` for MVP; move to `LearningProgress.xpEarned` in v1.1+

### **ADR-6: Question Version Tracking**
**Decision:** Add `TestAttempt.questionSetVersion`.
**Why:** Track which question version was used; enable A/B testing.

---

## 🔄 **Migration Timeline**

**Phase 1 (Sprint 1-3):** Create Learner, Question, TestAttempt tables + seed data.

**Phase 2 (Sprint 4+):** Add LearningPath, LearningProgress + backfill learner data.

---

## ✅ **Sign-Off**

- **Database Architect:** AI
- **Reviewed by:** ChatGPT (9.2/10 → 9.6/10 after ADR)
- **Schema Version:** 1.1 (Updated per ADR)
- **Status:** Ready for Prisma migration

---

**Next:** Đọc `06_API.md` để biết endpoints chi tiết.

---

**Made with ❤️ for Data Integrity**
