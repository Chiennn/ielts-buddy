# 🎨 04_UI_UX.md

**Design System & UI Specifications**

---

## 🎯 **Design Philosophy**

- **Mobile First:** Design starts at 375px, scales up to desktop
- **Modern & Clean:** Minimalist design, focus on content
- **Friendly & Encouraging:** Colors, language, feedback
- **Accessible:** WCAG AA compliant, keyboard navigation
- **Responsive:** Works on mobile, tablet, desktop
- **Fast:** Quick interactions, smooth transitions

---

## 🎨 **Design Tokens**

### **Colors**

```
PRIMARY           #6366F1  (Indigo) - Main actions, highlights
ACCENT            #8B5CF6  (Purple) - Secondary actions, hover
BACKGROUND        #EEF0F7  (Light Blue) - Page background
SURFACE           #FFFFFF  (White) - Cards, input
TEXT_PRIMARY      #1E293B  (Dark Slate) - Main text
TEXT_SECONDARY    #64748B  (Gray) - Secondary text
TEXT_MUTED        #94A3B8  (Light Gray) - Disabled, hints
SUCCESS           #10B981  (Green) - Success messages
WARNING           #F59E0B  (Amber) - Warnings
DANGER            #EF4444  (Red) - Errors
BORDER            #E2E8F0  (Light Gray) - Dividers

GRADIENT_PRIMARY  linear-gradient(135deg, #6366F1, #8B5CF6)
```

### **Typography**

```
Font Family       Be Vietnam Pro (Google Fonts)

Sizes:
  H1              2.5rem (40px)   font-weight: 700
  H2              2rem (32px)     font-weight: 700
  H3              1.5rem (24px)   font-weight: 600
  Body Large      1.1rem (18px)   font-weight: 400
  Body            1rem (16px)     font-weight: 400
  Small           0.875rem (14px) font-weight: 400
  Tiny            0.75rem (12px)  font-weight: 400

Line Height       1.5 (comfortable reading)
```

### **Spacing (8px Grid)**

```
xs    4px
sm    8px
md    16px
lg    24px
xl    32px
2xl   48px
```

### **Border Radius**

```
sm    4px   (inputs, small elements)
md    8px   (buttons, cards)
lg    12px  (larger cards, sections)
xl    16px  (hero sections)
```

### **Shadows**

```
SUBTLE    0 4px 12px rgba(0, 0, 0, 0.1)
MEDIUM    0 8px 24px rgba(0, 0, 0, 0.15)
LARGE     0 16px 48px rgba(0, 0, 0, 0.2)

Usage:
  Cards: SUBTLE
  Modals: MEDIUM
  Dropdowns: SUBTLE
  Elevated: LARGE
```

### **Transitions**

```
Fast      150ms (micro-interactions)
Normal    300ms (standard transitions)
Slow      500ms (modals, loading)

Easing: ease-in-out
```

---

## 🎭 **Component Library (Reusable Components)**

AI must use these components to maintain consistency. Don't create custom variants.

```
Core Components:
  ✓ Button (Primary, Secondary, Outlined, Danger)
  ✓ Card (with shadow, padding, border)
  ✓ Badge (CEFR level A1-C2, color-coded)
  ✓ ProgressBar (horizontal, with percentage)
  ✓ Input (text, email, password with validation)
  ✓ Select (dropdown with options)
  ✓ Modal (centered dialog with backdrop)
  ✓ Alert (success, warning, error, info)
  ✓ Loading (Skeleton, Spinner, Progress indicator)
  ✓ EmptyState (icon + message + CTA button)
  ✓ ErrorState (error icon + message + retry button)

Page-Specific Components:
  ✓ QuestionCard (displays question + options/input)
  ✓ CEFRBadge (displays A1-C2 with color)
  ✓ MissionCard (today's task card)
  ✓ ProgressRing (circular progress indicator)
  ✓ SkillBar (reading, grammar, listening, writing, speaking)
  ✓ LessonCard (lesson preview)
  ✓ SpeakingRecorder (audio input component)
  ✓ WritingEditor (textarea with character count)
```

**Rule:** Before creating a new component, check this list.

---

## ⏳ **Loading States**

Show loading UI while waiting for:
- Ollama scoring (2-5 seconds)
- Placement Test submission
- Dashboard data fetch
- Learning Path generation

```
UI Pattern Options:

1. Skeleton Loading
   ├─ Gray placeholder boxes
   ├─ Shimmer animation (light to dark)
   └─ Use for: Cards, text blocks, lists

2. Spinner
   ├─ Centered animated circle
   ├─ With "Loading..." text
   └─ Use for: Modal actions, page transitions

3. Progress Bar
   ├─ Linear progress with percentage
   ├─ Show when progress is measurable (e.g., 3/20 questions)
   └─ Use for: Question progress in test

4. Progress Ring
   ├─ Circular progress indicator
   ├─ Show percentage inside
   └─ Use for: Scoring results calculation

Examples:
- "Analyzing your test..." (Spinner + text)
- Skeleton loader for Dashboard (on first load)
- Progress bar during Placement Test
- Progress ring during Ollama scoring
```

---

## 🎨 **Empty States**

When there's no data, show helpful UI instead of blank screen.

```
Empty Dashboard (First Time):
┌──────────────────────────────┐
│      📚 No Data Yet          │
│                              │
│  You haven't taken a test.   │
│  Start your journey now!     │
│                              │
│  [Start Placement Test]      │
└──────────────────────────────┘

Empty Learning Progress:
┌──────────────────────────────┐
│    🎓 No Lessons Yet         │
│                              │
│  Your learning path is       │
│  being prepared...           │
│                              │
│  [Retake Test] [Check Back]  │
└──────────────────────────────┘

Empty Activity (No History):
┌──────────────────────────────┐
│   📈 Activity (Last 7 Days)  │
│                              │
│  Start learning to see       │
│  your progress here.         │
│                              │
│  [Get Started]               │
└──────────────────────────────┘

Components:
  ├─ Icon (large, 64px+)
  ├─ Title (friendly, encouraging)
  ├─ Description (explain why it's empty)
  └─ CTA Button (next action)
```

---

## ♿ **Accessibility (WCAG AA)**

All UI must be accessible to all users.

```
Typography:
  ✓ Minimum font size: 16px (mobile), 14px (desktop)
  ✓ Line height: ≥1.5 (comfortable reading)
  ✓ Color contrast: ≥4.5:1 for text on background

Colors:
  ✓ Don't rely on color alone (use icons + text)
  ✓ Test color contrast (use WebAIM contrast checker)
  ✓ CEFR badges use: color + icon + text label

Buttons & Interactive:
  ✓ Minimum size: 44x44px (tap targets on mobile)
  ✓ Focus indicator: visible outline or highlight
  ✓ Active/disabled states: clear visual difference
  ✓ Keyboard navigation: Tab through all interactive elements

Forms:
  ✓ Every input has associated <label>
  ✓ Error messages linked to inputs
  ✓ Placeholder ≠ label (both required)

Images & Icons:
  ✓ All images have alt text
  ✓ Icons have text labels or aria-label
  ✓ SVG icons are focusable with keyboard

Testing:
  ✓ Test with keyboard only (no mouse)
  ✓ Test with screen reader (NVDA, JAWS)
  ✓ Check contrast with browser tools
```

---

```
Mobile      375px (iPhone SE)
Tablet      768px (iPad)
Desktop     1024px (MacBook)
Large       1280px+ (Desktop monitors)

Approach: Mobile-first (min-width)
```

---

## 🧩 **Core Components**

### **1. Button**

```
States:
  Primary   Background: #6366F1, Text: white
  Secondary Background: #F1F5F9, Text: #1E293B
  Danger    Background: #EF4444, Text: white
  Disabled  Background: #E2E8F0, Text: #94A3B8

Sizes:
  SM        12px padding, 14px text
  MD        12px 20px padding (default)
  LG        16px 24px padding

Hover:
  Opacity: 0.9
  Shadow: SUBTLE
  Transform: scale(1.02)
```

### **2. Card**

```
Structure:
  Padding: 24px (md)
  Border: none
  Border-radius: 12px (lg)
  Background: white
  Shadow: SUBTLE
  Border: 1px solid #E2E8F0 (optional)

Hover:
  Shadow: MEDIUM (subtle lift)
  Transform: translateY(-2px)
```

### **3. Input / Textarea**

```
Border:     1px solid #E2E8F0
Padding:    12px (md)
Radius:     8px (md)
Font:       Be Vietnam Pro, 16px
Focus:      Border #6366F1 (2px), Outline: none
Error:      Border #EF4444 (2px)
Disabled:   Background #F1F5F9, Color #94A3B8
```

### **4. Progress Bar**

```
Background:  #E2E8F0
Fill:        linear-gradient(90deg, #6366F1, #8B5CF6)
Height:      8px
Radius:      4px
Animation:   Smooth transition 0.3s
```

### **5. Skill Bar (Reading, Grammar, etc.)**

```
Layout:
  └─ Label (left)
  └─ Percentage (right)
  └─ Bar (100% width below)

Colors:
  - Green (70-100%):  #10B981
  - Yellow (40-69%): #F59E0B
  - Red (0-39%):     #EF4444

Height: 12px
Radius: 6px
Animation: Bounce on page load
```

---

## 📱 **Page Wireframes**

### **Page 1: Login / Register**

```
┌─────────────────────────────┐
│                             │
│      🎓 IELTS Buddy         │  (H1, centered)
│                             │
│  Email                      │  (Input)
│  [________________]         │
│                             │
│  Password                   │  (Input)
│  [________________]         │
│                             │
│  [ Sign In Button ]         │  (Primary button, full width)
│                             │
│  Create account? Sign up →  │  (Link)
│                             │
└─────────────────────────────┘

Mobile: Same, full width padding 16px
Desktop: Max-width 400px, centered
```

### **Page 2: Learner Selection**

```
┌─────────────────────────────┐
│                             │
│  Select Child               │  (H2)
│                             │
│  ┌───────────────────────┐  │
│  │ 📚 Ngọc (Grade 7)     │  │  (Card, clickable)
│  │ Current: A2           │  │
│  └───────────────────────┘  │
│                             │
│  ┌───────────────────────┐  │
│  │ 📚 Đức (Grade 8)      │  │  (Card, clickable)
│  │ Current: B1           │  │
│  └───────────────────────┘  │
│                             │
│  [ + Add New Child ]        │  (Secondary button)
│                             │
└─────────────────────────────┘
```

### **Page 3: Welcome Screen**

```
┌─────────────────────────────┐
│                             │
│  🎓 IELTS Buddy             │  (H1)
│  Hi, Ngọc!                 │  (Friendly greeting)
│                             │
│  Hôm nay bạn sẽ...         │  (Subtitle)
│                             │
│  📝 Làm bài kiểm tra        │  (Step 1, icon + text)
│  Chỉ mất 5 phút             │
│                             │
│  🤖 AI chấm bài             │  (Step 2)
│  Biết điểm ngay             │
│                             │
│  🎯 Nhận lộ trình cá nhân   │  (Step 3)
│  Học hiệu quả               │
│                             │
│  [ Get Started Button ]     │  (Primary, full width)
│                             │
└─────────────────────────────┘
```

### **Page 4: Test Question (Q1 - MCQ)**

```
┌─────────────────────────────┐
│ ████░░░░░░░  1/5            │  (Progress bar)
├─────────────────────────────┤
│                             │
│ READING 1                   │  (Skill label)
│                             │
│ The Amazon rainforest...    │  (Question text)
│ (longer text here)          │
│                             │
│ ┌─────────────────────────┐ │
│ │ A. Tropical forest      │ │  (Option 1 - unselected)
│ └─────────────────────────┘ │
│                             │
│ ┌─────────────────────────┐ │
│ │ B. Desert               │ │  (Option 2 - selected)
│ └─────────────────────────┘ │
│                             │
│ ┌─────────────────────────┐ │
│ │ C. Mountain             │ │  (Option 3)
│ └─────────────────────────┘ │
│                             │
│ ┌─────────────────────────┐ │
│ │ D. Ocean                │ │  (Option 4)
│ └─────────────────────────┘ │
│                             │
├─────────────────────────────┤
│ [ Previous ] [ Next ]       │  (Navigation buttons)
└─────────────────────────────┘
```

### **Page 5: Test Question (Q5 - Writing)**

```
┌─────────────────────────────┐
│ █████████░░░░░░░  5/5       │  (Full progress)
├─────────────────────────────┤
│                             │
│ WRITING 5                   │
│                             │
│ Write about your daily      │  (Question)
│ routine. (80-100 words)     │
│                             │
│ ┌─────────────────────────┐ │
│ │ I wake up at 6 AM...    │ │  (Textarea)
│ │                         │ │
│ │                         │ │
│ │ Word count: 35/80       │ │  (Counter, bottom right)
│ └─────────────────────────┘ │
│                             │
├─────────────────────────────┤
│ [ Previous ] [ Submit ]     │  (Submit instead of Next)
└─────────────────────────────┘
```

### **Page 6: Analyzing**

```
┌─────────────────────────────┐
│                             │
│          🤖                 │  (Large emoji)
│        (rotating)           │
│                             │
│  Đang chấm bài...           │  (H2)
│                             │
│  AI đang phân tích kết quả  │  (Subtitle)
│  của bạn                    │
│                             │
│  Please wait...             │  (Subtext)
│                             │
└─────────────────────────────┘
```

### **Page 7: Result**

```
┌─────────────────────────────┐
│                             │
│  Trình độ của bạn           │  (H1)
│                             │
│         B1                  │  (CEFR, huge gradient text)
│                             │
├─────────────────────────────┤
│                             │
│  Reading                    │  (Skill label)
│  ████████░░  100%          │  (Skill bar)
│                             │
│  Grammar                    │
│  ███░░░░░░   70%           │
│                             │
│  Listening                  │
│  █░░░░░░░░   10%           │
│                             │
│  Writing                    │
│  █████░░░░   50%           │
│                             │
├─────────────────────────────┤
│                             │
│  Lộ trình học của bạn       │  (H2)
│                             │
│  ┌─────────────────────────┐ │
│  │ Giai đoạn 1: Nền tảng   │ │  (Card)
│  │ ███░░░░░░░  30%        │ │
│  │ - Từ vựng cơ bản       │ │
│  │ - Ngữ pháp A1          │ │
│  └─────────────────────────┘ │
│                             │
│  ┌─────────────────────────┐ │
│  │ Giai đoạn 2: Nâng cao   │ │
│  │ ░░░░░░░░░░ 0%         │ │
│  └─────────────────────────┘ │
│                             │
│  ┌─────────────────────────┐ │
│  │ Giai đoạn 3: Luyện thi  │ │
│  │ ░░░░░░░░░░ 0%         │ │
│  └─────────────────────────┘ │
│                             │
├─────────────────────────────┤
│                             │
│  [ Dashboard Button ]       │  (Primary)
│  [ Retake Test ]           │  (Secondary)
│                             │
└─────────────────────────────┘
```

### **Page 8: Dashboard**

```
┌─────────────────────────────┐
│ HEADER (sticky)             │
│ ───────────────────────────│
│ Level: B1 | Target: 6.0 ✈ │  (Gradient bg)
│ XP: 1,250 | Streak: 7 🔥   │
└─────────────────────────────┘

┌─────────────────────────────┐
│                             │
│  Tiến độ                    │  (H2)
│                             │
│  Giai đoạn 1: Nền tảng      │  (Progress card)
│  ███████░░░░  30%           │
│                             │
│  Giai đoạn 2: Nâng cao      │
│  ░░░░░░░░░░   0%           │
│                             │
│  Giai đoạn 3: Luyện thi     │
│  ░░░░░░░░░░   0%           │
│                             │
├─────────────────────────────┤
│                             │
│  Nhiệm vụ hôm nay           │  (H2)
│                             │
│  ☐ Học 10 từ vựng (+50XP)  │  (Task)
│  ☑ Luyện reading (complete) │  (Task - checked)
│  ☐ Viết essay (+100XP)     │  (Task)
│                             │
├─────────────────────────────┤
│                             │
│  Hoạt động tuần này         │  (H2)
│                             │
│  │                          │  (Chart)
│  │  ██                      │
│  │  ██ ██                   │
│  │  ██ ██ ██                │
│  └──────────────────────    │
│  T2 T3 T4 T5 T6 T7 CN      │
│                             │
├─────────────────────────────┤
│                             │
│  [ Start Stage 1 ]          │  (Primary)
│  [ Retake Test ]            │  (Secondary)
│                             │
└─────────────────────────────┘
```

---

## 🎨 **Color Usage Guidelines**

| Element | Color | Usage |
|---------|-------|-------|
| Primary button | #6366F1 | Key actions (Start, Submit, Go) |
| Secondary button | #F1F5F9 + #1E293B | Alternative actions |
| Success feedback | #10B981 | Progress, completion |
| Error message | #EF4444 | Validation, errors |
| Warning | #F59E0B | Timeouts, alerts |
| Skill bars | Green/Yellow/Red | Performance visualization |
| Text | #1E293B | Main content |
| Text secondary | #64748B | Hints, labels |
| Background | #EEF0F7 | Page background |

---

## ✅ **Accessibility**

```
✓ Color contrast > 4.5:1 (WCAG AA)
✓ Font size minimum 14px
✓ Buttons minimum 44px height
✓ Keyboard navigation (Tab, Enter, Arrow keys)
✓ Focus indicators (visible)
✓ ARIA labels for icons
✓ Alt text for images
✓ Semantic HTML (h1-h6, buttons, form elements)
```

---

## 📱 **Mobile Optimization**

```
✓ Touch targets: 44px × 44px minimum
✓ Spacing: Increased padding on small screens
✓ Text size: Readable without zoom
✓ Orientation: Support both portrait & landscape
✓ Gestures: Swipe support (future)
```

---

**Version:** 1.0
**Last Updated:** [Date]
