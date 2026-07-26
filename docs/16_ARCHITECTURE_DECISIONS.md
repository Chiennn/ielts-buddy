# 📋 16_ARCHITECTURE_DECISIONS.md

**Architecture Decision Records (ADR) - Why We Made These Choices**

---

## 🎯 **Purpose**

This document captures the "why" behind major technical decisions. When the team changes in future (new AI, new engineers, etc.), this explains the reasoning so decisions aren't reversed.

---

## 📌 **ADR-001: Why React for Frontend?**

**Decision:** React 18 (or 19)

**Alternatives Considered:**
- Vue.js (simpler but less AI-friendly)
- Angular (overkill for MVP)
- Svelte (smaller community, less AI training data)

**Chosen Because:**
- ✅ Largest community (best AI support)
- ✅ Excellent tooling (Vite, TypeScript)
- ✅ Mobile-to-web scaling (React Native later)
- ✅ Claude/Codex generate React code fluently

**Trade-offs:**
- Larger bundle size (acceptable for MVP)
- More boilerplate (accepted for team consistency)

**Reviewed:** Yes
**Status:** FINAL ✅

---

## 📌 **ADR-002: Why Node.js + Express?**

**Decision:** Node.js 22 LTS (minimum 20 LTS), Express.js

**Alternatives Considered:**
- Python + FastAPI (slower deployment, harder scaling)
- Go (steeper learning curve)
- Java (overkill for MVP)

**Chosen Because:**
- ✅ Same team can work frontend + backend
- ✅ npm ecosystem matches React
- ✅ Express is lightweight, not over-engineered
- ✅ AI generates Node.js code excellently
- ✅ LTS support until 2027 (long-term stability)

**Trade-offs:**
- Node 22 is very recent (stable, but less adoption)
- Single-threaded (acceptable for MVP scale)

**Version Timeline:**
- Node 20 LTS: Supported until April 2026
- Node 22 LTS: Supported until October 2027 (choose this)

**Reviewed:** Yes
**Status:** FINAL ✅

---

## 📌 **ADR-003: Why PostgreSQL?**

**Decision:** PostgreSQL 15+

**Alternatives Considered:**
- MongoDB (schema-less, but painful for relational data like learning paths)
- MySQL (older, less feature-rich)
- SQLite (file-based, doesn't scale)

**Chosen Because:**
- ✅ ACID compliance (no data loss on scoring)
- ✅ Full-text search (future leaderboard, analytics)
- ✅ JSON support (flexible schema)
- ✅ Prisma ORM support (type-safe)
- ✅ Excellent AI code generation

**Trade-offs:**
- More complex than MongoDB (worth it for data integrity)
- Need to manage migrations (handled by Prisma)

**Reviewed:** Yes
**Status:** FINAL ✅

---

## 📌 **ADR-004: Why Prisma ORM?**

**Decision:** Prisma v5+

**Alternatives Considered:**
- TypeORM (verbose, boilerplate-heavy)
- Sequelize (less intuitive for AI)
- Raw SQL queries (dangerous, no type safety)

**Chosen Because:**
- ✅ Type-safe database access
- ✅ Auto-generated migrations
- ✅ Clear schema definition (DSL)
- ✅ AI loves Prisma (super clear syntax)
- ✅ Built-in PostgreSQL support

**Trade-offs:**
- Smaller community than TypeORM (but growing fast)
- Pay for Prisma Cloud (optional, not needed for MVP)

**Reviewed:** Yes
**Status:** FINAL ✅

---

## 📌 **ADR-005: Why Ollama for AI Scoring?**

**Decision:** Ollama + qwen2.5:14b (local, not API)

**Alternatives Considered:**
- OpenAI API (costs $$, external dependency)
- Anthropic Claude API (same, external)
- Open-source local models (chose this)

**Chosen Because:**
- ✅ NO monthly API costs (qwen2.5 is free)
- ✅ Full control over responses (no rate limits)
- ✅ Privacy (no data sent to third parties)
- ✅ Works offline (important feature)
- ✅ Fast iteration on prompts

**Trade-offs:**
- Need GPU (but qwen2.5:14b fits on 16GB GPU/CPU)
- Slower than OpenAI (acceptable 15-30s per test)
- Model quality varies (qwen2.5 is excellent, sufficient for MVP)

**When to Reconsider:**
- If scaling to 10k+ users → may need OpenAI
- If need better writing feedback → may upgrade model
- If need multilingual → keep Ollama, try larger models

**Reviewed:** Yes
**Status:** FINAL ✅

---

## 📌 **ADR-006: Why JWT (not Sessions)?**

**Decision:** JWT (7 days for MVP, upgrade to Access+Refresh in v1.1)

**Alternatives Considered:**
- Session-based (server-side sessions, harder to scale)
- OAuth2 (overkill for MVP, may add v1.1)

**Chosen Because:**
- ✅ Stateless (easier to scale horizontally)
- ✅ Works with mobile + web
- ✅ No database lookup on every request
- ✅ Supports future multi-device login

**Trade-offs:**
- Can't revoke instantly (acceptable, JWT expires in 7 days)
- Larger cookies (still under 8KB limit)

**Future Plan (v1.1+):**
- Add Refresh Token (7-30 days, low privilege)
- Shorten Access Token (15-60 minutes)
- Enables logout + device management

**Reviewed:** Yes
**Status:** FINAL ✅

---

## 📌 **ADR-007: Why TailwindCSS (not inline/styled-components)?**

**Decision:** TailwindCSS + custom utility classes

**Alternatives Considered:**
- Inline CSS (cluttered components)
- Styled-components (JavaScript overhead)
- SASS/BEM (traditional, but AI struggles)
- CSS-in-JS (runtime cost)

**Chosen Because:**
- ✅ AI generates Tailwind exceptionally well
- ✅ Consistent design system (no ad-hoc styles)
- ✅ Fast iteration (change class = instant change)
- ✅ Small bundle when minified
- ✅ Great mobile-first utilities

**Trade-offs:**
- Learning curve (Tailwind classes vs traditional CSS)
- Class names can get long (acceptable, readable)
- Need Tailwind LSP for IDE autocomplete (worth setup)

**Reviewed:** Yes
**Status:** FINAL ✅

---

## 📌 **ADR-008: Why REST API (not GraphQL)?**

**Decision:** REST with JSON + polling for async operations

**Alternatives Considered:**
- GraphQL (complex for MVP, harder AI integration)
- Webhooks (stateful, harder to debug)
- WebSockets (overkill, can add v1.1)

**Chosen Because:**
- ✅ Simple, everyone understands
- ✅ Easy to test and mock
- ✅ Stateless (matches our design)
- ✅ AI codes REST naturally
- ✅ Can add WebSockets in v1.1 without redesign

**Trade-offs:**
- Over-fetching some responses (acceptable for MVP)
- No real-time updates yet (polling is fine)

**Future Plan (v1.1+):**
- Add WebSocket for real-time notifications
- Add Server-Sent Events (SSE) as fallback

**Reviewed:** Yes
**Status:** FINAL ✅

---

## 📌 **ADR-009: Why 2-Phase Architecture (Placement + Learning)?**

**Decision:** Split database into Phase 1 (Placement) and Phase 2 (Learning)

**Alternatives Considered:**
- Single unified schema (risky, harder to refactor)
- Microservices (overkill for MVP)

**Chosen Because:**
- ✅ MVP can launch with just Phase 1
- ✅ Phase 2 can be added without refactoring
- ✅ Reduces risk (Phase 1 is stable before Phase 2)
- ✅ Allows parallel development

**Implications:**
- Sprint 1-3: Build Phase 1 (Auth + Test + Scoring)
- Sprint 4-6: Build Phase 2 (Learning + Dashboard)
- Can launch after Sprint 3 if Phase 2 delays

**Reviewed:** Yes
**Status:** FINAL ✅

---

## 📌 **ADR-010: Why User = Learner (1:1 for MVP)?**

**Decision:** One login account = One learner profile (no separate User table)

**Alternatives Considered:**
- One parent → Multiple children (1:many relationship)
- Separate User + Learner tables (more complex)

**Chosen Because:**
- ✅ Simplest for MVP (1:1 relationship)
- ✅ Faster development (single entity)
- ✅ Easier to test

**Future Refactor (v1.1+):**
- If parent accounts → children needed
- Add User table (parent)
- Learner becomes child of User
- Auth stays with User, learning stays with Learner
- Migration: backfill all current Learners with User

**Current Scope:**
- MVP: One person = One account = One learning journey
- Feature Flag: Can disable parent feature in settings

**Reviewed:** Yes
**Status:** FINAL (with v1.1 refactor path) ✅

---

## ✅ **Sign-Off**

**ADR Owner:** Product Owner
**Last Reviewed:** [Today]
**Version:** 1.0
**Status:** FROZEN - Changes require Change Request

---

**Made with ❤️ for Decision Transparency**
