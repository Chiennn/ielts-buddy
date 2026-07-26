# IELTS Buddy — Tài liệu bàn giao cho AI code (Ollama / Codex)

> Mục tiêu: từ prototype giao diện `Test đầu vào.dc.html`, dựng app thật **100% free**:
> React (web) + Node.js + PostgreSQL + Ollama (qwen2.5) chấm bài.

---

## 0. Cách đưa cho AI local thực thi (quy trình đề xuất)

Prototype hiện là 1 file HTML (React runtime nội bộ) — **dùng làm bản tham chiếu hình ảnh**, không phải code sản phẩm. Đừng bảo AI "chạy file này"; thay vào đó nạp tài liệu này + ảnh chụp màn hình và để AI sinh code React/Node thật.

**Trình tự thực tế:**
1. Mở prototype, chụp 5 màn (Welcome / Test / Analyzing / Result / Dashboard) → lưu vào `docs/screens/`.
2. Tạo repo GitHub, cấu trúc như mục 4.
3. Trong VS Code + Codex/Continue, nạp file `HANDOFF.md` này vào context.
4. Chạy lần lượt các **PROMPT** ở mục 7 — mỗi prompt sinh 1 mảng (DB → API → UI → AI service). Làm nhỏ từng bước, review rồi commit.
5. Ollama chạy nền cung cấp `/api/generate` cho backend gọi để chấm Writing/Speaking.

> Mẹo: model local (qwen2.5-coder) làm tốt từng file/hàm, kém khi sinh cả app một lần. Luôn chia nhỏ yêu cầu.

---

## 1. Tổng quan sản phẩm

App giúp con học tiếng Anh / ôn IELTS. Luồng lõi:

`Kiểm tra đầu vào → AI chấm & xác định CEFR → Lộ trình + nguồn học → Dashboard học hằng ngày`

Người dùng: 2 hồ sơ con (lớp 6 target IELTS, lớp 2 foundation). Ưu tiên **web responsive** trước; PWA sau.

---

## 2. Màn hình (khớp prototype)

| # | Màn | Nội dung chính |
|---|-----|----------------|
| 1 | Welcome | Chọn người làm bài, giới thiệu 3 bước, nút Bắt đầu |
| 2 | Test | 5 câu / 4 kỹ năng: Reading, Grammar, Listening (audio), Speaking (ghi âm), Writing (textarea). Thanh tiến độ, nút Câu tiếp / Nộp bài |
| 3 | Analyzing | Màn chờ khi backend gọi Ollama chấm |
| 4 | Result | Level CEFR, 4 thanh kỹ năng, lộ trình 3 giai đoạn, nguồn học |
| 5 | Dashboard | Header (level/target/XP/streak), tiến độ giai đoạn, nhiệm vụ hôm nay, hoạt động tuần |

---

## 3. Kỹ thuật & phong cách

- **Frontend:** React + Vite, React Router. Styling: giữ inline/CSS như prototype hoặc chuyển Tailwind (tùy chọn).
- **Font:** Be Vietnam Pro. **Màu chủ đạo:** gradient `#6366f1 → #8b5cf6`, nền `#eef0f7`, text `#1e293b`, muted `#64748b`, success `#10b981`.
- **Backend:** Node.js (Express hoặc Fastify) + Prisma ORM.
- **DB:** PostgreSQL.
- **AI:** Ollama local, gọi HTTP `http://localhost:11434/api/generate`, model `qwen2.5:14b` (chấm nội dung), `qwen2.5-coder` để dev.
- **Speaking giai đoạn 1:** chấm qua transcript (STT để sau — Whisper local). MVP có thể cho nhập/đọc text.

---

## 4. Cấu trúc thư mục đề xuất

```
ielts-buddy/
├─ frontend/            # React + Vite
│  ├─ src/
│  │  ├─ pages/         # Welcome, Test, Analyzing, Result, Dashboard
│  │  ├─ components/    # OptionCard, SkillBar, RoadmapItem, TodoCard...
│  │  ├─ api/           # gọi backend
│  │  └─ App.jsx
├─ backend/             # Node + Express + Prisma
│  ├─ src/
│  │  ├─ routes/        # tests, results, learners, ai
│  │  ├─ services/      # ollamaService.js (chấm bài)
│  │  └─ index.js
│  └─ prisma/schema.prisma
└─ docs/screens/        # ảnh prototype tham chiếu
```

---

## 5. Data model (PostgreSQL / Prisma)

```prisma
model Learner {
  id        String   @id @default(cuid())
  name      String
  grade     Int
  cefrLevel String?  // A1, A2, B1...
  targetIelts String?
  xp        Int      @default(0)
  createdAt DateTime @default(now())
  attempts  TestAttempt[]
}

model Question {
  id       String @id @default(cuid())
  skill    String // reading|grammar|listening|speaking|writing
  type     String // mcq|speaking|writing
  prompt   String
  sub      String?
  audioUrl String?
  options  Json?  // ["go","goes",...]
  answer   Int?   // index đáp án đúng (mcq)
  level    String // A1..C1  (độ khó, phục vụ adaptive)
}

model TestAttempt {
  id         String   @id @default(cuid())
  learnerId  String
  learner    Learner  @relation(fields: [learnerId], references: [id])
  answers    Json     // { questionId: answer }
  scores     Json?    // { listening: 55, reading: 60, speaking: 38, writing: 45 }
  cefrResult String?
  createdAt  DateTime @default(now())
}
```

---

## 6. API endpoints (backend)

```
GET  /api/questions?level=A2      -> danh sách câu test (adaptive theo level)
POST /api/attempts                -> nộp bài { learnerId, answers } -> tạo attempt
POST /api/attempts/:id/score      -> gọi Ollama chấm writing/speaking + tính CEFR
GET  /api/attempts/:id/result     -> { cefr, scores, roadmap, sources }
GET  /api/learners  POST /api/learners
GET  /api/dashboard/:learnerId    -> tiến độ, nhiệm vụ hôm nay, hoạt động tuần
```

### Gọi Ollama chấm bài (services/ollamaService.js)

```js
export async function scoreWriting(text) {
  const prompt = `You are an IELTS examiner. Score this writing for a young learner.
Return ONLY JSON: {"band": number, "cefr": "A1|A2|B1...", "feedback": "short vi text"}.
Writing: """${text}"""`;
  const r = await fetch('http://localhost:11434/api/generate', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ model: 'qwen2.5:14b', prompt, stream: false, format: 'json' }),
  });
  const data = await r.json();
  return JSON.parse(data.response); // { band, cefr, feedback }
}
```

MCQ (reading/grammar/listening) chấm bằng so khớp `answer` trong DB — không cần AI, tiết kiệm tài nguyên.

---

## 7. PROMPT mẫu để nạp cho Codex / qwen2.5-coder

Chạy từng prompt một, review rồi mới sang bước sau.

**Prompt 1 — DB:**
> Dùng nội dung mục 5 trong HANDOFF.md. Tạo `backend/prisma/schema.prisma` và file seed `prisma/seed.js` chèn 5 câu test (Reading, Grammar, Listening, Speaking, Writing) đúng như prototype.

**Prompt 2 — Backend:**
> Tạo backend Node + Express + Prisma với các endpoint ở mục 6. Viết `services/ollamaService.js` gọi Ollama như ví dụ. MCQ chấm bằng so khớp answer; writing/speaking gọi Ollama. CEFR = tổng hợp điểm 4 kỹ năng.

**Prompt 3 — Frontend khung:**
> Tạo React + Vite app với React Router, 5 route: /welcome /test /analyzing /result /dashboard. Dùng font Be Vietnam Pro, palette và style giống ảnh trong docs/screens/. Tạm dùng dữ liệu mock.

**Prompt 4 — Nối API:**
> Thay mock bằng gọi backend thật: /test lấy câu hỏi, nộp bài -> /attempts -> /score -> hiển thị /result và /dashboard.

**Prompt 5 — Chi tiết từng màn:**
> Dựng lại chính xác màn <tên màn> theo ảnh docs/screens/<file>.png: layout, spacing, màu, trạng thái chọn đáp án, thanh tiến độ.

---

## 8. Lưu ý chi phí / vận hành (giữ 100% free)

- Dev & dùng nội bộ: chạy localhost — 0đ.
- Ollama cần máy ≥16GB RAM (GPU càng tốt) cho qwen2.5:14b. Máy con học có thể không đủ → chạy AI trên 1 máy ở nhà.
- Tách `ollamaService.js` riêng để sau này đổi sang API cloud khi thương mại hóa mà không sửa phần còn lại.
- Deploy free (khi cần chia sẻ): Vercel (frontend), Render/Railway free tier (backend + Postgres).
