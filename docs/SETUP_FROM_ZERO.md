# 🚀 SETUP_FROM_ZERO.md

**Complete Setup Guide - From Zero to Development Ready**

---

## 📋 **Table of Contents**

1. Prerequisites & Installation
2. Project Folder Setup
3. Git Configuration
4. Backend Setup
5. Frontend Setup
6. Database Setup
7. Ollama Setup
8. Running Everything
9. Troubleshooting
10. Verification Checklist

---

## ✅ **Part 1: Prerequisites & Installation**

### **Step 1.1: Install Required Software**

#### **Windows Users:**

**Node.js (v16+)**
```bash
# Download & install from https://nodejs.org/
# Verify installation
node --version    # Should show v16 or higher
npm --version     # Should show 8 or higher
```

**Git**
```bash
# Download & install from https://git-scm.com/
# Verify
git --version
```

**PostgreSQL (Option A: Direct Install)**
```bash
# Download from https://www.postgresql.org/download/windows/
# During installation:
#   - Set password for 'postgres' user: (remember it!)
#   - Port: 5432 (default)
#   - Install pgAdmin (optional, helpful for management)

# Verify
psql --version
```

**PostgreSQL (Option B: Docker - Recommended)**
```bash
# Install Docker Desktop from https://www.docker.com/
# Then run:
docker run -e POSTGRES_PASSWORD=password -p 5432:5432 postgres:15
# Keep running in background
```

**Ollama**
```bash
# Download from https://ollama.ai/
# Run installer

# Verify
ollama --version

# Pull model (one time, ~10GB)
ollama pull qwen2.5:14b   # Large, ~30 min
# OR smaller model for testing:
ollama pull qwen2.5:7b    # ~4GB, faster
```

**VS Code + Continue**
```bash
# Download VS Code from https://code.visualstudio.com/
# Open VS Code
# Extensions → Search "Continue" → Install
```

### **Step 1.2: Verify Everything Works**

```bash
# Test Node
node -e "console.log('Node works')"

# Test Git
git --version

# Test PostgreSQL (if direct install)
psql -U postgres -c "SELECT 1"   # Enter password when prompted

# Test Ollama
ollama list   # Should show qwen2.5:14b

# Test Docker (if using Docker for Postgres)
docker ps
```

---

## 📂 **Part 2: Project Folder Setup**

### **Step 2.1: Create Main Project Folder**

```bash
# Open PowerShell or Command Prompt

# Navigate to D: drive
D:

# Create folder
mkdir AppStudyLanguage
cd AppStudyLanguage

# Verify
pwd    # Should show D:\AppStudyLanguage
```

### **Step 2.2: Create Subfolders**

```bash
# Create structure
mkdir docs
mkdir apps
mkdir apps\frontend
mkdir apps\backend
mkdir scripts

# Create gitignore
cat > .gitignore << 'EOF'
node_modules/
.env
.env.local
.DS_Store
dist/
build/
*.log
.vscode/
.idea/
.next/
.cache/
dist/
coverage/
EOF

# Create README
cat > README.md << 'EOF'
# IELTS Buddy

AI-powered English learning app.

## Quick Start

```bash
cd apps/backend
npm install
npx prisma migrate dev
npm run seed
npm run dev

# In another terminal
cd apps/frontend
npm install
npm run dev
```

## Docs

All documentation in `docs/` folder.

See `docs/00_PROJECT_CONTEXT.md` to start.
EOF

# Create main .env template
cat > .env.example << 'EOF'
# Database
DATABASE_URL="postgresql://postgres:password@localhost:5432/ielts_buddy"

# Ollama
OLLAMA_API="http://localhost:11434"

# Node Environment
NODE_ENV="development"
PORT=5000

# API
REACT_APP_API_URL="http://localhost:5000/api"
EOF

# Verify structure
ls -la    # Should show: docs, apps, scripts, .gitignore, README.md, .env.example
```

---

## 🔧 **Part 3: Git Configuration**

### **Step 3.1: Initialize Git**

```bash
# From D:\AppStudyLanguage

git init
git config user.name "Your Name"
git config user.email "your.email@example.com"

# Verify
git config --list | grep user
```

### **Step 3.2: Create GitHub Repository**

**On GitHub.com:**
```
1. Go to https://github.com/new
2. Repository name: "ielts-buddy" or "app-study-language"
3. Description: "AI-powered English learning app"
4. Private or Public (your choice)
5. Do NOT add README or .gitignore (we have them)
6. Create repository
```

### **Step 3.3: Connect Local to GitHub**

```bash
# Copy the SSH or HTTPS URL from GitHub
# Example: https://github.com/YOUR_USERNAME/ielts-buddy.git

# Run (replace URL):
git remote add origin https://github.com/YOUR_USERNAME/ielts-buddy.git

# Verify
git remote -v   # Should show origin

# Initial commit
git add .
git commit -m "chore: initial project setup - docs, folders, config"
git branch -M main
git push -u origin main

# Verify on GitHub.com (refresh page)
```

---

## 🗄️ **Part 4: Backend Setup**

### **Step 4.1: Create Backend Project**

```bash
# From D:\AppStudyLanguage

cd apps\backend

# Create package.json
cat > package.json << 'EOF'
{
  "name": "ielts-buddy-backend",
  "version": "1.0.0",
  "main": "src/index.js",
  "type": "module",
  "scripts": {
    "dev": "nodemon src/index.js",
    "start": "node src/index.js",
    "migrate": "prisma migrate dev",
    "seed": "node prisma/seed.js",
    "test": "jest --coverage"
  },
  "dependencies": {
    "express": "^4.18.2",
    "cors": "^2.8.5",
    "@prisma/client": "^5.0.0",
    "axios": "^1.4.0",
    "dotenv": "^16.0.3",
    "bcryptjs": "^2.4.3",
    "jsonwebtoken": "^9.0.0"
  },
  "devDependencies": {
    "nodemon": "^3.0.1",
    "prisma": "^5.0.0",
    "jest": "^29.0.0",
    "supertest": "^6.3.0"
  }
}
EOF

# Install dependencies
npm install

# Wait for install to complete...
```

### **Step 4.2: Setup Prisma**

```bash
# Initialize Prisma
npx prisma init

# This creates:
# - prisma/schema.prisma
# - .env (with DATABASE_URL placeholder)
```

### **Step 4.3: Create Prisma Schema**

```bash
# Create/update prisma/schema.prisma
# Copy entire content from 05_DATABASE.md into this file
# (Or paste below)

cat > prisma/schema.prisma << 'EOF'
datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

generator client {
  provider = "prisma-client-js"
}

model Learner {
  id        String   @id @default(cuid())
  email     String   @unique
  password  String
  name      String
  grade     Int
  cefrLevel String?
  targetIelts String?
  xp        Int      @default(0)
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt
  
  attempts  TestAttempt[]
  
  @@index([grade])
  @@index([cefrLevel])
}

model Question {
  id       String @id @default(cuid())
  skill    String
  type     String
  prompt   String
  sub      String?
  audioUrl String?
  options  Json?
  answer   Int?
  level    String
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt
  
  @@index([skill])
  @@index([level])
}

model TestAttempt {
  id         String   @id @default(cuid())
  learnerId  String
  learner    Learner  @relation(fields: [learnerId], references: [id], onDelete: Cascade)
  
  answers    Json
  scores     Json?
  cefrResult String?
  feedback   String?
  
  status     String   @default("pending")
  createdAt  DateTime @default(now())
  updatedAt  DateTime @updatedAt
  
  @@index([learnerId])
  @@index([status])
  @@index([createdAt])
}
EOF

# Verify
cat prisma/schema.prisma
```

### **Step 4.4: Create .env File**

```bash
# Copy .env.example to .env
cp ..\..\\.env.example .env

# Edit .env with your actual database URL
# Using PostgreSQL locally:
# DATABASE_URL="postgresql://postgres:password@localhost:5432/ielts_buddy"
# 
# Replace:
#   - password: your postgres password (from installation)
#   - ielts_buddy: database name (will be created)

# On Windows, use double backslash or forward slash in paths
# DATABASE_URL="postgresql://postgres:YOUR_PASSWORD@localhost:5432/ielts_buddy"

# Verify content
cat .env
```

### **Step 4.5: Create Database**

```bash
# Option A: Using psql directly
psql -U postgres -c "CREATE DATABASE ielts_buddy;"

# Option B: Prisma will create it
npx prisma migrate dev --name init
# This will:
# 1. Create database
# 2. Create schema
# 3. Generate Prisma client
# 4. You may see "Do you want to create it? (Y/n)" → Type Y

# Verify
psql -U postgres -d ielts_buddy -c "\\dt"   # Should be empty for now
```

### **Step 4.6: Seed Database**

```bash
# Create prisma/seed.js
cat > prisma/seed.js << 'EOF'
import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

async function main() {
  console.log("Seeding questions...");

  const questions = [
    {
      skill: "reading",
      type: "mcq",
      prompt: "The Amazon rainforest is the largest tropical forest in the world. What is the Amazon?",
      options: ["Tropical forest", "Desert", "Mountain", "Ocean"],
      answer: 0,
      level: "A2"
    },
    {
      skill: "grammar",
      type: "mcq",
      prompt: "She ___ to school every day.",
      options: ["go", "goes", "going", "gone"],
      answer: 1,
      level: "A2"
    },
    {
      skill: "listening",
      type: "mcq",
      prompt: "Listen to the audio and answer: What time is the meeting?",
      options: ["9:00 AM", "10:00 AM", "2:00 PM", "3:00 PM"],
      answer: 1,
      level: "A2"
    },
    {
      skill: "speaking",
      type: "speaking",
      prompt: "Talk about your favorite hobby.",
      sub: "Describe what you like to do in your free time.",
      level: "A2"
    },
    {
      skill: "writing",
      type: "writing",
      prompt: "Write about your daily routine.",
      sub: "Write 80-100 words describing what you do from morning to evening.",
      level: "A2"
    }
  ];

  for (const q of questions) {
    await prisma.question.create({ data: q });
  }

  console.log("✅ Seeded 5 questions");
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
EOF

# Run seed
npm run seed

# Verify
psql -U postgres -d ielts_buddy -c "SELECT COUNT(*) FROM \"Question\";"  # Should show 5
```

### **Step 4.7: Create Basic Server**

```bash
# Create src/index.js
mkdir -p src

cat > src/index.js << 'EOF'
import express from "express";
import cors from "cors";
import dotenv from "dotenv";

dotenv.config();

const app = express();
app.use(cors());
app.use(express.json());

// Health check
app.get("/health", (req, res) => {
  res.json({ status: "ok", timestamp: new Date().toISOString() });
});

// Placeholder routes
app.get("/api/questions", (req, res) => {
  res.json([{ id: "q1", skill: "reading", prompt: "Test" }]);
});

// Error handler
app.use((err, req, res, next) => {
  console.error(err);
  res.status(500).json({ error: "Internal Server Error" });
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`✅ Server running at http://localhost:${PORT}`);
});
EOF

# Test
npm run dev
# Should see: "✅ Server running at http://localhost:5000"
# Press Ctrl+C to stop
```

---

## ⚛️ **Part 5: Frontend Setup**

### **Step 5.1: Create React App**

```bash
# From D:\AppStudyLanguage\apps\frontend

# Create Vite React project
npm create vite@latest . -- --template react

# Select when prompted:
# - Framework: React
# - Variant: JavaScript (or TypeScript if you prefer)

# Install dependencies
npm install

# Verify structure
ls -la
# Should have: src/, public/, index.html, vite.config.js, package.json
```

### **Step 5.2: Add Required Dependencies**

```bash
# Install axios for API calls and react-router
npm install axios react-router-dom

# Verify package.json has these dependencies
cat package.json | grep -A 5 "dependencies"
```

### **Step 5.3: Setup Vite Config**

```bash
# Update vite.config.js to proxy API calls
cat > vite.config.js << 'EOF'
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  server: {
    port: 3000,
    proxy: {
      '/api': {
        target: 'http://localhost:5000',
        changeOrigin: true
      }
    }
  }
})
EOF
```

### **Step 5.4: Create Basic App Structure**

```bash
# Create folders
mkdir -p src/pages
mkdir -p src/components
mkdir -p src/api

# Create API client
cat > src/api/client.js << 'EOF'
import axios from 'axios';

const client = axios.create({
  baseURL: '/api',
  timeout: 30000,
  headers: {
    'Content-Type': 'application/json'
  }
});

export default client;
EOF

# Create Welcome page
cat > src/pages/Welcome.jsx << 'EOF'
export default function Welcome() {
  return (
    <div style={{ padding: '40px', textAlign: 'center' }}>
      <h1>🎓 IELTS Buddy</h1>
      <p>Welcome to your English learning journey!</p>
      <button style={{ padding: '10px 20px', fontSize: '1rem' }}>
        Get Started
      </button>
    </div>
  );
}
EOF

# Create App.jsx
cat > src/App.jsx << 'EOF'
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Welcome from './pages/Welcome';

export default function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Welcome />} />
      </Routes>
    </Router>
  );
}
EOF

# Verify src/ structure
ls -la src/
```

### **Step 5.5: Test Frontend**

```bash
# Start dev server
npm run dev

# You should see:
# VITE v4.x.x  ready in xxx ms
# ➜  Local:   http://localhost:3000/

# Open http://localhost:3000 in browser
# Should see "🎓 IELTS Buddy" page
```

---

## 🤖 **Part 6: Ollama Setup**

### **Step 6.1: Start Ollama Server**

```bash
# Open a NEW PowerShell/Command Prompt window

# Run Ollama server
ollama serve

# You should see:
# listening on 127.0.0.1:11434
# This window should keep running in background
```

### **Step 6.2: Verify Ollama**

```bash
# Open ANOTHER new PowerShell window (keep server running in previous)

# Test Ollama
ollama list
# Should show: qwen2.5:14b (or whatever model you pulled)

# Test API
curl http://localhost:11434/api/tags
# Should return JSON with models
```

### **Step 6.3: (If qwen2.5:14b Not Downloaded)**

```bash
# If model not already downloaded
ollama pull qwen2.5:14b

# This will:
# - Download ~9GB model (could take 30 min)
# - Store locally
# - You only need to do this once

# Check progress
ollama list   # Shows available models
```

---

## 🚀 **Part 7: Running Everything Together**

### **Step 7.1: Setup Multiple Terminals**

You need 4 terminal windows running simultaneously:

**Terminal 1: Ollama Server**
```bash
ollama serve
# Keep running
```

**Terminal 2: PostgreSQL (if Docker)**
```bash
docker run -e POSTGRES_PASSWORD=password -p 5432:5432 postgres:15
# Keep running
# (Skip if using direct PostgreSQL installation)
```

**Terminal 3: Backend Server**
```bash
cd D:\AppStudyLanguage\apps\backend
npm run dev

# Should see: ✅ Server running at http://localhost:5000
```

**Terminal 4: Frontend Dev Server**
```bash
cd D:\AppStudyLanguage\apps\frontend
npm run dev

# Should see: ➜  Local:   http://localhost:3000/
```

### **Step 7.2: Test Integration**

Open browser: `http://localhost:3000`

Should see:
- Welcome page loads ✅
- Console no errors ✅

Test API call in browser console:
```javascript
// Open DevTools (F12) → Console
fetch('/api/health')
  .then(r => r.json())
  .then(d => console.log(d))

// Should log: { status: 'ok', timestamp: '...' }
```

---

## 🧪 **Part 8: Troubleshooting**

### **Issue: Port 5000 Already in Use**

```bash
# Find process using port 5000
netstat -ano | findstr :5000

# Or use different port
# Edit backend/src/index.js: PORT = 5001
npm run dev -- --port 5001
```

### **Issue: PostgreSQL Connection Error**

```bash
# Verify PostgreSQL running
psql -U postgres -c "SELECT 1"

# If error, check password
# Edit .env → DATABASE_URL with correct password
# Password set during PostgreSQL installation

# Alternative: Create new user
psql -U postgres -c "CREATE USER ielts_user WITH PASSWORD 'password';"
psql -U postgres -c "ALTER USER ielts_user CREATEDB;"
# Update DATABASE_URL with ielts_user:password
```

### **Issue: Ollama Connection Error**

```bash
# Verify Ollama running
ollama list

# Verify API accessible
curl http://localhost:11434/api/tags

# If error, start Ollama server:
ollama serve
```

### **Issue: npm install Fails**

```bash
# Clear cache
npm cache clean --force

# Delete node_modules and package-lock.json
rm -r node_modules
rm package-lock.json

# Reinstall
npm install
```

### **Issue: Prisma Migration Error**

```bash
# Reset database
npx prisma migrate reset

# Or manually:
psql -U postgres -c "DROP DATABASE ielts_buddy;"
psql -U postgres -c "CREATE DATABASE ielts_buddy;"
npx prisma migrate dev --name init
npm run seed
```

---

## ✅ **Part 9: Verification Checklist**

Run this to verify everything works:

```bash
# Terminal: Check Node
node --version       # v16+
npm --version       # 8+

# Terminal: Check Git
git --version       # 2.30+

# Terminal: Check PostgreSQL
psql -U postgres -c "SELECT 1"    # Should return: 1

# Terminal: Check Ollama
ollama list                        # Should show qwen2.5:14b

# Browser: Check Backend
curl http://localhost:5000/health  # Should return: { status: 'ok' }

# Browser: Check Frontend
# Visit http://localhost:3000
# Should see "🎓 IELTS Buddy" page

# Browser: Check API Proxy
# Open DevTools Console (F12)
# Run: fetch('/api/health').then(r => r.json()).then(console.log)
# Should log the health response
```

---

## 📋 **Final Checklist**

Before starting development:

- [ ] Node.js installed (v16+)
- [ ] PostgreSQL installed/running
- [ ] Git configured
- [ ] GitHub repo created
- [ ] Backend folder setup with package.json
- [ ] Frontend folder setup with Vite
- [ ] Database created (ielts_buddy)
- [ ] Prisma schema created
- [ ] Database seeded with 5 questions
- [ ] Ollama installed + qwen2.5 model downloaded
- [ ] All 4 servers running (Ollama, PostgreSQL, Backend, Frontend)
- [ ] Frontend loads on http://localhost:3000
- [ ] Backend responds on http://localhost:5000/health
- [ ] API proxy working (/api calls work from frontend)

---

## 🎯 **Next Steps**

Once everything verified:

1. **Stop all servers** (Ctrl+C in each terminal)
2. **Commit to GitHub:**
   ```bash
   git add apps/
   git commit -m "chore: setup frontend and backend skeletons"
   git push
   ```
3. **Review Sprint 1 prompt** in `15_PROMPTS.md`
4. **Ready for Sprint 1** with AI in Continue chat!

---

## 📚 **Quick Reference Commands**

```bash
# Start all servers (in 4 different terminals)
ollama serve
docker run -e POSTGRES_PASSWORD=password -p 5432:5432 postgres:15  # if using docker
cd apps/backend && npm run dev
cd apps/frontend && npm run dev

# Run migrations
cd apps/backend && npx prisma migrate dev

# Seed database
cd apps/backend && npm run seed

# Reset database (careful!)
cd apps/backend && npx prisma migrate reset

# Check everything running
curl http://localhost:5000/health
curl http://localhost:3000
ollama list
```

---

**Selesai! You're Ready for Development! 🚀**

Next: Run Sprint 1 prompt in Continue chat.
