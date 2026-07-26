# 📚 01_PRODUCT_VISION.md

**"Tại sao chúng ta xây dựng dự án này? Có gì đặc biệt?"**

---

## 🎯 **Product Vision**

**"English Learning Platform - AI-powered placement testing & personalized learning paths for Vietnamese students"**

**Why English Learning Platform (not IELTS-only)?**
- Framework designed for scaling to multiple languages (Japanese, Chinese, etc.)
- IELTS is the first module, not the entire product
- Allows expansion to conversational English, TOEIC, or other certifications
- More flexible for long-term growth

---

## 🔍 **Problem Statement**

### **Vấn đề Hiện Tại:**

1. **Làm sao biết con học ở mức nào?**
   - Duolingo: Không có kiểm tra trình độ thực sự
   - ELSA: Đắt (subscription hàng tháng)
   - Teacher riêng: Rất đắt

2. **Làm sao biết con cần học gì tiếp theo?**
   - App hiện tại: Generic learning path
   - Không cá nhân hóa theo trình độ thực tế
   - Bố mẹ không biết tiến độ

3. **Feedback chậm, không tức thì**
   - Speaking/Writing cần người chấm
   - AI scoring chưa phổ biến + đắt tiền

---

## ✨ **Giải Pháp của IELTS Buddy**

```
1. Placement Test (Adaptive 15-20 câu, ~10-15 phút)
   - AI điều chỉnh độ khó sau mỗi câu
   - Đánh giá đáng tin cậy hơn 5 câu
   ↓
2. AI chấm + định cấp (CEFR: A1-C2)
   ↓
3. Learning Path cá nhân (3 giai đoạn)
   ↓
4. Dashboard cho bố mẹ + con
   ↓
5. Học hằng ngày + Track tiến độ
```

---

## 📌 **Product Principles (Kim Chỉ Nam)**

Những nguyên tắc này hướng dẫn mọi quyết định thiết kế:

1. **AI First** → Ưu tiên AI-powered features (scoring, personalization)
2. **Learning First** → Lợi ích học tập là chính, không gimmick
3. **Mobile First** → Thiết kế từ mobile 375px trở lên
4. **Keep It Simple** → MVP với features tối thiểu, không bloat
5. **Ship Fast** → Hoàn thành MVP trong 1 tháng
6. **Personalization** → Cá nhân hóa > one-size-fits-all

---

## ❌ **Out of Scope (MVP Không Làm)**

Để tránh scope creep, những điều này **KHÔNG** trong MVP:

```
- Chat giữa học sinh
- Thanh toán & subscription
- Leaderboard & ranking
- Mobile app native (iOS/Android)
- Giáo viên quản lý lớp
- Marketplace
- Social features
- Certificates & badges
- Advanced analytics
- Speaking/Writing ở mức chuyên sâu
```

**Lý do:** Focus vào core value = placement test + learning path

---

| Segment | Chi Tiết |
|---------|---------|
| **Chính** | Học sinh lớp 6-9 (12-15 tuổi) muốn ôn IELTS |
| **Secondary** | Học sinh lớp 4-5 muốn nền tảng bền vững |
| **Quyết định mua** | Bố mẹ (decision maker) |
| **Pain point** | Không biết con học ở đâu, cần học gì |

---

## 🏆 **Khác Biệt vs Competitor**

### **vs Duolingo**
| IELTS Buddy | Duolingo |
|------------|----------|
| ✅ Kiểm tra CEFR chính xác | ❌ Không CEFR level |
| ✅ Learning path cá nhân | ❌ Generic path |
| ✅ Focusing IELTS | ❌ General English |
| ✅ Reading/Grammar/Listening scoring tự động | ❌ Chỉ listening + reading |
| ✅ Writing scoring cơ bản (MVP) | ❌ Không scoring |
| ❌ Bắt đầu từ 0 | ✅ 500M+ users |

### **vs ELSA**
| IELTS Buddy | ELSA |
|-----------|------|
| ✅ Rẻ (free → freemium) | ❌ $10/tháng |
| ✅ Designed for Vietnam | ❌ Global |
| ✅ Ollama (local) | ❌ Cloud (expensive) |
| ✅ Portfolio showcase | ❌ Competitor's product |
| ❌ Vừa bắt đầu | ✅ Mature product |

### **vs Học với Teacher**
| IELTS Buddy | Teacher |
|------------|---------|
| ✅ Available 24/7 | ❌ Fixed schedule |
| ✅ Instant feedback | ❌ Delayed feedback |
| ✅ Rẻ | ❌ Đắt (500K+/giờ) |
| ❌ Không có "nhân cảm" | ✅ Human touch |
| ✅ Measurable progress | ❌ Subjective |

---

## 🎯 **Key Objectives (3 năm)**

### **Year 1 (MVP)**
```
✓ MVP: Placement test + Learning path + Dashboard
✓ 100 users beta
✓ Get feedback + iterate
✓ Break even or near break-even
```

### **Year 2 (Growth)**
```
✓ Add more features (speaking, writing practice)
✓ 1,000 active users (from word-of-mouth)
✓ Monetization: Start freemium model
✓ Expansion: Beta with 1–2 schools/centers
```

### **Year 3 (Sustainability)**
```
✓ 5,000+ active users
✓ First revenue stream (freemium model)
✓ B2B partnerships: 3–5 schools using platform
✓ Framework proven: Ready to build Japanese/other language modules
✓ Consider expansion (TOEIC, conversational English)
```

---

## 💡 **Core Value Propositions**

### **Cho Học Sinh:**
- ✅ Biết trình độ thực tế (CEFR)
- ✅ Có lộ trình rõ ràng (3 giai đoạn)
- ✅ Feedback tức thì từ AI
- ✅ Game-ification (XP, streak, level)

### **Cho Bố Mẹ:**
- ✅ Theo dõi tiến độ con (dashboard)
- ✅ Biết con cần học gì (learning path)
- ✅ Tận dụng thời gian rảnh (ngắn gọn, hiệu quả)
- ✅ Rẻ hơn teacher hoặc app premium

### **Cho Chúng Tôi:**
- ✅ Portfolio project: AI-driven app
- ✅ Reusable framework: Dùng cho app khác
- ✅ Potential revenue: Freemium model
- ✅ Giải quyết bài toán thực tế

---

## 🌟 **Unique Selling Points (USP)**

### **1. Placement Test Adaptive + Chính Xác**
```
Adaptive 15-20 câu → 10-15 phút → Có CEFR level đáng tin cậy
(Duolingo: không có CEFR; Teacher: 1 tiếng + đắt)
```

### **2. Ollama Local (Cost Effective)**
```
Không phải pay API → qwen2.5 local free
(ELSA: $$$; Copilot: $20/month)
```

### **3. Learning Path Cá Nhân**
```
3 giai đoạn dựa trên CEFR của từng HS
(Duolingo: generic; Teacher: flexible nhưng vague)
```

### **4. AI Scoring (Reading/Grammar/Listening tự động + Writing cơ bản)**
```
MCQ: auto-score
Writing: Basic feedback from Ollama (MVP)
Speaking: Placeholder (future enhancement)
(Teacher: chậm; App khác: không scoring)
```

### **5. Design Cho Việt Nam**
```
Vietnamese UI, context, examples, local CEFR standards
(Duolingo: global; bất phù hợp local context)
```

---

## 📊 **Success Metrics**

### **Engagement:**
- Daily Active Users (DAU): 100 → 1K → 10K
- Session duration: avg 15 min/day
- Completion rate: % users finish placement test

### **Learning Outcome:**
- CEFR improvement: avg +1 level / 3 months
- Vocabulary retention: 70%+
- User satisfaction: 4.5/5 stars

### **Business:**
- Cost per user: <$1
- Retention rate: 40% MAU
- Revenue (Y2+): Freemium, $5/month

---

## 🎨 **Brand Identity**

**Tone:** Friendly, encouraging, professional
**Color:** Indigo + Purple gradient (modern, trustworthy)
**Mascot:** (Optional) Cute AI character
**Tagline:** "Trở thành thạo tiếng Anh, từng bước nhỏ mỗi ngày"

---

## 🚀 **Go-to-Market Strategy**

### **Phase 1: Bootstrap MVP (Month 0-1)**
- Build for free (side project)
- **Release to 10-20 real users FIRST:**
  - Your child + their friends (5-10 users)
  - Parents around your area (5-10 users)
  - English teachers you know (2-5 users)
- Get real feedback via direct conversation + usage analytics
- Iterate based on actual user behavior

### **Phase 2: Organic Growth (Month 2-3, Year 1)**
- After 10-20 users validate product
- Launch on ProductHunt + Hacker News
- Facebook groups (parents, students)
- Referral program (10% discount for referrer)
- Target: 100-200 users by end of Y1

### **Phase 3: Freemium Model (Year 2)**
- Free: Placement test + basic learning
- Pro ($5/mo): All features + no ads
- Family plan ($10/mo): 3 kids
- Target: 1,000 active users

### **Phase 4: B2B Partnerships (Year 3)**
- Approach 3-5 schools/tutoring centers
- Offer pilot program (free for 3 months)
- Discounted bulk pricing for schools
- Target: 5,000+ total users

---

## ⚠️ **Risks & Mitigation**

| Risk | Probability | Mitigation |
|------|------------|-----------|
| AI scoring not accurate | Medium | Test with real users, iterate |
| Duolingo add IELTS | High | Focus on speed + personalization |
| Local Ollama slow | Low | Use GPU, offload to cloud if needed |
| Data privacy issues | Low | No payment info, GDPR compliance |
| Not monetizable | Medium | Start free, freemium model proven |

---

## 📌 **Lâu Dài: Framework Reusability**

Mục tiêu không chỉ là 1 dự án, mà là 1 **framework** có thể dùng cho:

```
✓ App học tiếng Nhật (Japanese Buddy)
✓ App học lập trình (Coding Buddy)
✓ App quản lý lớp học (Class Buddy)
✓ Bất kỳ learning app nào
```

**Điều này = asset có giá trị cao hơn rất nhiều.**

---

## 🎯 **Decision Criteria**

Khi có conflict:
1. **Giúp học sinh học tốt hơn?** → YES
2. **Có thể build trong 6 sprints?** → YES
3. **Sustainable (không quá complex)?** → YES
4. **Reusable cho app khác?** → BONUS

---

## ✅ **Stakeholders & Approval**

- **Product Owner:** Bạn (Chien)
- **Developer:** AI (Follow framework này)
- **QA:** Bạn (Use 12_TEST_PLAN.md)
- **Approver:** Bạn (Final call on features)

---

**Next:** Đọc `02_PRD.md` để thấy danh sách features chi tiết.

---

**Made with ❤️ for Student Success**
