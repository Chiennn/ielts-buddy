# 🚀 Automated Setup Scripts

**Two scripts to automate the entire project setup in minutes!**

---

## 📋 **Available Scripts**

### **1. setup.sh** (macOS, Linux, Git Bash on Windows)
```bash
bash setup.sh
```

### **2. setup-windows.ps1** (Windows PowerShell)
```powershell
powershell -ExecutionPolicy Bypass -File setup-windows.ps1
```

---

## ✅ **What These Scripts Do**

Both scripts automatically:

1. ✅ **Check Prerequisites**
   - Node.js v16+
   - npm
   - Git
   - PostgreSQL (or Docker)
   - Ollama + qwen2.5 model

2. ✅ **Create Project Structure**
   ```
   D:\AppStudyLanguage\
   ├─ docs/
   ├─ apps/
   │  ├─ frontend/
   │  └─ backend/
   ├─ scripts/
   ├─ .gitignore
   ├─ README.md
   └─ .env.example
   ```

3. ✅ **Initialize Git**
   - `git init`
   - Configure user
   - Ready for GitHub

4. ✅ **Setup Backend**
   - Create `apps/backend/package.json`
   - Install npm dependencies
   - Create `.env` from template
   - Initialize Prisma

5. ✅ **Setup Frontend**
   - Create `apps/frontend/package.json`
   - Install npm dependencies
   - Create `vite.config.js`
   - Create `index.html`
   - Create `src/` folder structure
   - Create `App.jsx`, `Welcome.jsx`, API client

6. ✅ **Database Setup** (Optional)
   - Create Prisma schema
   - Run migrations
   - Seed initial data

7. ✅ **Initial Git Commit**
   - Commit all files
   - Ready to push to GitHub

---

## 🎯 **Quick Start**

### **Option 1: Using Git Bash (Recommended for Windows)**

```bash
# 1. Navigate to folder
cd D:\AppStudyLanguage

# 2. Run setup script
bash setup.sh

# 3. Wait for completion (2-5 minutes)

# 4. Follow on-screen instructions
```

### **Option 2: Using PowerShell (Windows)**

```powershell
# 1. Navigate to folder
cd D:\AppStudyLanguage

# 2. Run setup script
powershell -ExecutionPolicy Bypass -File setup-windows.ps1

# 3. Wait for completion (2-5 minutes)

# 4. Follow on-screen instructions
```

### **Option 3: Using macOS/Linux Terminal**

```bash
# 1. Navigate to folder
cd ~/AppStudyLanguage

# 2. Make script executable
chmod +x setup.sh

# 3. Run setup script
bash setup.sh

# 4. Wait for completion (2-5 minutes)

# 5. Follow on-screen instructions
```

---

## 📋 **Manual Steps After Running Script**

After the script completes, you need to do a few manual things:

### **Step 1: Update Backend .env**

```bash
cd apps/backend
cat .env
# Update DATABASE_URL with your PostgreSQL credentials
# Example: postgresql://postgres:YOUR_PASSWORD@localhost:5432/ielts_buddy
```

### **Step 2: Create Prisma Schema**

The script initializes Prisma but doesn't create the schema (to avoid errors).

You need to:
```bash
# 1. Copy content from docs/05_DATABASE.md
# 2. Paste into apps/backend/prisma/schema.prisma
# 3. Save file
```

### **Step 3: Create Seed File**

```bash
# 1. Copy content from docs/SETUP_FROM_ZERO.md (Part 4.6)
# 2. Create apps/backend/prisma/seed.js
# 3. Save file
```

### **Step 4: Run Migrations & Seed**

```bash
cd apps/backend

# Create database and tables
npx prisma migrate dev --name init

# Seed initial data
npm run seed
```

### **Step 5: Connect to GitHub**

```bash
# In root folder (D:\AppStudyLanguage)
git remote add origin https://github.com/YOUR_USERNAME/ielts-buddy.git
git push -u origin main
```

---

## 🐛 **Troubleshooting**

### **Script Doesn't Run - PowerShell Permission Error**

```powershell
# Change execution policy
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser

# Then run script
powershell -File setup-windows.ps1
```

### **Script Doesn't Run - Git Bash Not Installed**

Download from: https://git-scm.com/download/win

Select "Use Git and optional Unix tools"

### **Script Fails - Node.js Not Found**

```bash
# Verify Node is installed
node --version

# If not, install from https://nodejs.org/

# After installing, close and reopen terminal
# Then run script again
```

### **Script Fails - PostgreSQL Not Running**

Option A: Start PostgreSQL service
```bash
# Windows Services:
# Open Services → Find PostgreSQL → Start
```

Option B: Use Docker
```bash
docker run -e POSTGRES_PASSWORD=password -p 5432:5432 postgres:15
# Keep running in separate terminal
```

### **Script Fails - Ollama Not Running**

```bash
# Start Ollama server
ollama serve

# Keep running in separate terminal
# Then run setup script in different terminal
```

### **Script Partially Completes**

Re-run the script - it skips already-created items:
```bash
bash setup.sh    # or setup-windows.ps1
```

---

## 📊 **Script Execution Time**

```
Prerequisites check:    1-2 min
Create structure:       <1 min
Setup backend:          2-3 min (npm install)
Setup frontend:         2-3 min (npm install)
Database setup:         1-2 min
Total:                  ~7-11 minutes
```

Largest bottleneck: `npm install` (downloading dependencies)

---

## ✨ **What You Get After Script**

```
D:\AppStudyLanguage/
│
├── docs/                          (Documentation files)
│   ├── 00_PROJECT_CONTEXT.md
│   ├── 01_PRODUCT_VISION.md
│   ├── ... (15 files)
│   └── 15_PROMPTS.md
│
├── apps/
│   ├── backend/
│   │   ├── node_modules/          ✅ (npm packages)
│   │   ├── prisma/
│   │   │   ├── schema.prisma      (You need to add this)
│   │   │   └── seed.js            (You need to add this)
│   │   ├── src/
│   │   │   └── index.js           ✅ (Basic server)
│   │   ├── .env                   ✅ (Database config)
│   │   └── package.json           ✅
│   │
│   └── frontend/
│       ├── node_modules/          ✅ (npm packages)
│       ├── src/
│       │   ├── pages/
│       │   │   └── Welcome.jsx    ✅
│       │   ├── components/
│       │   ├── api/
│       │   │   └── client.js      ✅
│       │   ├── App.jsx            ✅
│       │   └── main.jsx           ✅
│       ├── index.html             ✅
│       ├── vite.config.js         ✅
│       └── package.json           ✅
│
├── .git/                          ✅ (Git repository)
├── .gitignore                     ✅
├── README.md                      ✅
├── .env.example                   ✅
└── scripts/                       (Empty, for future scripts)
```

**✅ = Auto-created by script**

---

## 🎯 **Next: After Setup Script**

```
1. Manually add Prisma schema + seed file (from docs)
2. Run: npx prisma migrate dev --name init
3. Run: npm run seed
4. Connect to GitHub: git remote add origin ...
5. Push to GitHub: git push -u origin main
6. Start servers:
   - Backend:  cd apps/backend && npm run dev
   - Frontend: cd apps/frontend && npm run dev
7. Open http://localhost:3000
8. Copy Sprint 1 prompt from docs/15_PROMPTS.md
9. Paste into Continue chat
10. AI starts coding! 🚀
```

---

## 📖 **For More Details**

- Setup guide: `docs/SETUP_FROM_ZERO.md`
- Project context: `docs/00_PROJECT_CONTEXT.md`
- Sprint 1 prompt: `docs/15_PROMPTS.md`

---

## ✅ **Verification Checklist**

After script completes:

```bash
# Check Node
node --version        # Should be v16+

# Check npm
npm --version         # Should be 8+

# Check Git
git --version         # Should show version

# Check folders
ls -la               # Should show docs/, apps/, .git/

# Check backend
cd apps/backend
ls -la               # Should show node_modules/, .env, package.json

# Check frontend
cd apps/frontend
ls -la               # Should show node_modules/, src/, vite.config.js
```

---

## 🎉 **You're Done!**

The hardest part is over. Now you just need to:

1. Add Prisma schema file
2. Run migrations
3. Start the servers
4. Begin Sprint 1 with AI

**Total setup time: ~15-20 minutes including manual steps**

Enjoy building! 🚀
