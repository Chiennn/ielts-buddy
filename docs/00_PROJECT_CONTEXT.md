# 📌 PROJECT_CONTEXT.md

**Dành cho mọi AI tham gia dự án: đây là file đầu tiên cần đọc.**

---

## 🎯 **Dự Án Là Gì?**

| Thông Tin | Chi Tiết |
|-----------|---------|
| **Tên** | IELTS Buddy |
| **Loại** | Web application học tiếng Anh + AI scoring |
| **Đối tượng** | Học sinh lớp 6-9 (6-15 tuổi) |
| **Mục tiêu** | Kiểm tra CEFR level + cung cấp learning path cá nhân hóa |
| **Thời gian** | MVP: 6 sprints (~1-2 tháng) |

---

## 💻 **Tech Stack**

```
Frontend     → React 18 + Vite + React Router
Backend      → Node.js (Express/Fastify) + Prisma ORM
Database     → PostgreSQL
AI           → Ollama (qwen2.5:14b cho scoring)
Deployment   → Local first, sau này: Vercel + Railway
```

---

## 📂 **Folder Structure**

```
AppStudyLanguage/
│
├── docs/                     ← "Bộ nhớ dự án" (15 files)
├── apps/
│   ├── frontend/
│   ├── backend/
│   └── shared/               (nếu có)
├── scripts/                  (setup, migration...)
├── docker-compose.yml        (local development)
├── .github/workflows/        (CI/CD - sau này)
└── README.md
```

---

## 🎬 **User Flow (MVP)**

```
1. Welcome         → Chọn học sinh
2. Placement Test  → Adaptive Test (15-25 câu, ~10-20 phút)
                     • Reading, Grammar, Listening, Speaking, Writing
                     • AI tự tăng/giảm độ khó theo kết quả
3. Analyzing       → AI chấm (2-5 phút)
4. Result          → Thấy CEFR + 4 skill scores + learning path
5. Dashboard       → Xem lộ trình + nhiệm vụ hôm nay
```

---

## 🧠 **AI's Role in Project**

| Bạn (Product Owner) | AI (Developer) |
|-------------------|----------------|
| Viết tài liệu (docs/) | Code theo docs/ |
| Định nghĩa features | Implement features |
| Thiết kế UX | Code UI/API |
| Test & QA | Self-review & unit tests |
| Review & approve | Update CHANGELOG |

**Quy tắc:** AI **không được code** nếu chưa đọc:
- `01_PRODUCT_VISION.md`
- `02_PRD.md`
- `05_DATABASE.md`
- `06_API.md`
- `11_ACCEPTANCE_CRITERIA.md`

---

## 📋 **Bộ Tài Liệu (15 Files)**

| # | File | Mục Đích |
|---|------|---------|
| 00 | PROJECT_CONTEXT.md | Quick ref (file này) |
| 01 | PRODUCT_VISION.md | Tầm nhìn, khác biệt competitor |
| 02 | PRD.md | Danh sách features |
| 03 | USER_FLOW.md | Luồng người dùng chi tiết |
| 04 | UI_UX.md | Wireframe, design token |
| 05 | DATABASE.md | Schema, relations, indexing |
| 06 | API.md | Endpoints, request/response |
| 07 | AI_DESIGN.md | Ollama, scoring algorithm |
| 08 | TECH_STACK.md | Tech choices + rationale |
| 09 | CODING_RULES.md | Convention, eslint, naming |
| 10 | SPRINT_PLAN.md | 6 sprints breakdown |
| 11 | ACCEPTANCE_CRITERIA.md | DONE definition per feature |
| 12 | TEST_PLAN.md | Test cases + QA checklist |
| 13 | DEPLOYMENT.md | Deploy to production |
| 14 | HANDOFF.md | Sprint coordinator |
| 15 | PROMPTS.md | Master + Sprint prompts |

---

## 🚀 **Lộ Trình Phát Triển (6 Sprints - Feature Based)**

```
Sprint 1  → Project Setup + Authentication + Learner Management
            (User can register, login, create child profiles)

Sprint 2  → Placement Test UI + Question Management
            (User can take adaptive test, 15-25 questions)

Sprint 3  → AI Scoring + Ollama Integration + CEFR Calculation
            (Auto-scoring + Ollama scoring + CEFR result)

Sprint 4  → Result Page + Dashboard + Learning Path
            (Display CEFR, skill bars, learning stages, today's tasks)

Sprint 5  → Vocabulary Learning + Responsive Design
            (Introduce vocabulary lessons, polish UI for all devices)

Sprint 6  → Testing + Bug Fixes + Deployment + Polish
            (Unit tests, QA, deployment to production)
```

**Key:** Mỗi sprint kết thúc với 1 feature hoàn chỉnh (không giới hạn "5 câu")

---

## 📌 **Product Principles**

Những nguyên tắc này giúp AI & Bạn quyết định khi có lựa chọn thiết kế:

1. **Mobile First** → Thiết kế từ mobile 375px, sau scale up
2. **AI First** → Ưu tiên AI-powered features (scoring, personalization)
3. **Offline Friendly** → App hoạt động khi không internet (sync sau)
4. **Keep It Simple** → MVP với features tối thiểu, không thêm thừa
5. **Personalization** → Learning path cá nhân hóa, không one-size-fits-all
6. **Fast MVP First** → Hoàn thành MVP trong 1 tháng, improvement sau

---

## ❌ **Out of Scope (MVP)**

Những tính năng **KHÔNG** làm ở MVP để giữ deadline:

```
- Mobile app native (iOS/Android)
- Payment & subscription
- Multiplayer / Competition
- Chat giữa học sinh
- Leaderboard & points
- Phát hiện gian lận
- Giáo viên quản lý lớp
- Social sharing
- Certificates & badges (MVP)
- Advanced analytics
```

**→ Lưu ý:** Khi Codex đọc mục này, nó sẽ không tự sinh thêm features ngoài scope

---

## ✅ **Definition of MVP - Khi Nào Hoàn Thành?**

MVP coi như xong khi **TẤT CẢ** điều sau đây làm được:

```
✓ Người dùng đăng ký & đăng nhập
✓ Tạo được học sinh profile (learner)
✓ Làm được Placement Test (15-25 câu adaptive)
✓ AI auto-score MCQ + Ollama score Writing/Speaking
✓ Calculate & display CEFR level (A1-C2)
✓ Display learning path (3 stages)
✓ Dashboard hoạt động (progress + today's tasks)
✓ Có thể bắt đầu stage 1 bài học
✓ Responsive trên mobile, tablet, desktop
✓ All unit tests pass
✓ 0 critical bugs
```

**→ Không cần thêm bất kỳ feature nào khác.**

---

## 🏗️ **System Architecture (Simple Overview)**

```
┌─────────────────────────────────────────────┐
│           Browser (User)                     │
│        http://localhost:3000                 │
└──────────────────┬──────────────────────────┘
                   │
                   ↓
┌─────────────────────────────────────────────┐
│        React + Vite (Frontend)              │
│      src/pages, src/components              │
│      • Welcome, Test, Result, Dashboard     │
└──────────────────┬──────────────────────────┘
                   │ HTTP API calls
                   ↓
┌─────────────────────────────────────────────┐
│     Node.js + Express (Backend API)         │
│      http://localhost:5000/api              │
│      • Auth, Learners, Questions, Attempts  │
└──────────────────┬──────────────────────────┘
                   │
        ┌──────────┼──────────┐
        ↓          ↓          ↓
   PostgreSQL   Ollama    (Logs)
   Database    (Scoring)
   (Data)
```

**Data Flow:**
1. User submits test (Frontend) → Backend API
2. Backend saves answers (PostgreSQL)
3. Backend calls Ollama for Writing/Speaking score
4. Backend calculates CEFR
5. Frontend displays Result

---

## ⚠️ **Conflict Resolution (For AI)**

Nếu phát hiện **tài liệu mâu thuẫn** hoặc **không rõ**, AI sẽ:

```
1. DỪNG code ngay lập tức

2. Báo Product Owner (Bạn):
   "Tôi phát hiện mâu thuẫn ở [tài liệu X] [dòng N]"
   "Có thể hiểu là [version A] hay [version B]?"

3. Đề xuất giải pháp:
   "Tôi recommend: [lý do]"

4. CHỈ code sau khi được xác nhận
   (Product Owner phê duyệt hoặc update tài liệu)
```

**→ Điều này giúp tránh lãng phí thời gian code sai.**

---

## ✅ **Quy Tắc Làm Việc**


1. Bạn viết/update tài liệu
2. Bạn assign Sprint hiện tại
3. AI đọc 01-02-05-06-11 + Sprint
4. AI báo lại: "Tôi hiểu, bắt đầu?"
5. Bạn approve → AI code

### **Khi AI Hoàn Thành:**
1. AI self-review code
2. AI update CHANGELOG
3. AI commit: `feat: sprint-X-feature-name`
4. Bạn QA theo 12_TEST_PLAN.md
5. Bạn approve/request changes
6. Merge main branch

---

## 🎨 **Design Tokens (Sử Dụng Toàn Dự Án)**

```
Font           → Be Vietnam Pro (Google Fonts)
Primary        → #6366f1 (Indigo)
Accent         → #8b5cf6 (Purple)
Background     → #eef0f7 (Light)
Text           → #1e293b (Dark slate)
Muted          → #64748b (Gray)
Success        → #10b981 (Green)
Warning        → #f59e0b (Amber)
Danger         → #ef4444 (Red)

Radius         → 8px (small), 12px (medium)
Spacing        → 8px grid (p-1, p-2, p-4, p-6...)
Shadow         → Subtle (0 4px 12px rgba(0,0,0,0.1))
```

---

## 📊 **Database Overview**

**3 Models chính:**
1. **Learner** - Thông tin học sinh (name, grade, cefrLevel, xp...)
2. **Question** - Câu hỏi test (skill, type, prompt, options...)
3. **TestAttempt** - Kết quả làm bài (answers, scores, cefrResult...)

Chi tiết: Xem `05_DATABASE.md`

---

## 🔌 **API Overview**

**Endpoints chính:**
```
GET  /api/learners                    → Danh sách HS
POST /api/learners                    → Tạo HS mới
GET  /api/questions?skill=X&level=Y  → Câu hỏi
POST /api/attempts                    → Nộp bài
POST /api/attempts/:id/score          → Chấm (gọi Ollama)
GET  /api/attempts/:id/result         → Xem kết quả
GET  /api/dashboard/:learnerId        → Dashboard
```

Chi tiết: Xem `06_API.md`

---

## 🤖 **Ollama Integration**

**Model:** `qwen2.5:14b`

**Scoring:**
- **MCQ** (Reading, Grammar, Listening) → Auto-score (so khớp answer)
- **Writing** → Call Ollama API, return band + CEFR + feedback
- **Speaking** → Placeholder (transcript → Ollama scoring)

**CEFR Calculation:** Trung bình 5 kỹ năng → A1..C2

Chi tiết: Xem `07_AI_DESIGN.md`

---

## 🎯 **Acceptance Criteria (Định Nghĩa "DONE")**

Ví dụ cho "Placement Test" Sprint:

```
✓ 5 câu hỏi display đúng (Reading, Grammar, Listening, Speaking, Writing)
✓ Save answers vào database
✓ Auto-score MCQ + call Ollama cho Writing
✓ Calculate CEFR từ 5 scores
✓ Show result page với CEFR + skill bars
✓ All tests pass (unit + integration)
```

Chi tiết: Xem `11_ACCEPTANCE_CRITERIA.md`

---

## 📱 **Responsive Design Target**

```
Mobile    → 375px (iPhone SE)
Tablet    → 768px (iPad)
Desktop   → 1024px+
```

Tất cả component phải responsive first.

---

## 🔐 **Important Rules for AI**

1. **📖 Read before code** → Tài liệu là source of truth
2. **🎯 Only this Sprint** → Không thêm feature khác
3. **📝 Self-review always** → Tự check code trước commit
4. **🔄 Update CHANGELOG** → Ghi nhật ký mỗi thay đổi
5. **❌ No random packages** → Hỏi trước thêm dependency
6. **✅ Test everything** → Viết unit tests

---

## 💬 **How to Communicate**

**AI asks:**
> "Tôi đã đọc docs. Hiểu rồi. Bắt đầu Sprint 2?"

**You respond:**
> "Đọc thêm 04_UI_UX.md rồi bắt đầu."

**AI completes:**
> "Xong Sprint 2. Commit: ... Test cases: ... Ready QA."

**You QA:**
> "Tất cả pass. Merge main."

---

## 🎓 **For Future Developers (Scalability)**

Cấu trúc này dùng lại được cho:
- App học tiếng Nhật, Trung, Pháp
- App quản lý lớp học
- App bán hàng online
- Bất kỳ web app nào

Chỉ cần thay `02_PRD.md` + `04_UI_UX.md`, còn lại framework tái sử dụng.

---

## 📞 **Contact & Status**

- **Repository:** GitHub (todo)
- **Current Sprint:** (to be assigned)
- **Last Updated:** [date]
- **Next Review:** [date]

---

## ✨ **TL;DR - If You're An AI**

1. **Đây là gì?** → IELTS learning app với Ollama AI
2. **Tôi làm gì?** → Code theo 6 sprints
3. **Trước khi code?** → Đọc docs/ folder
4. **Xong rồi?** → Self-review → Commit → Update CHANGELOG
5. **Có câu hỏi?** → Hỏi "Tôi" (chatbot owner) hoặc đọc docs tương ứng

**→ Ngay bây giờ:** Hãy đọc `01_PRODUCT_VISION.md`

---

**Made with ❤️ for AI-Driven Development**
