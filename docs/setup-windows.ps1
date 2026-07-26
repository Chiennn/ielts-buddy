# ====================================================================
# IELTS BUDDY - Automated Setup for Windows PowerShell
# ====================================================================
#
# Usage: powershell -ExecutionPolicy Bypass -File setup-windows.ps1
#
# Prerequisites:
# - Node.js v16+ installed
# - PostgreSQL running (or Docker)
# - Git installed  
# - Ollama installed with qwen2.5 model
#
# ====================================================================

# Set error action
$ErrorActionPreference = "Continue"

# Color functions
function Write-Header {
    Write-Host "`n========================================" -ForegroundColor Blue
    Write-Host $args[0] -ForegroundColor Blue
    Write-Host "========================================`n" -ForegroundColor Blue
}

function Write-Success {
    Write-Host "✅ $($args[0])" -ForegroundColor Green
}

function Write-Error-Custom {
    Write-Host "❌ $($args[0])" -ForegroundColor Red
}

function Write-Warning-Custom {
    Write-Host "⚠️  $($args[0])" -ForegroundColor Yellow
}

# Check prerequisites
function Check-Prerequisites {
    Write-Header "Checking Prerequisites"

    # Check Node
    $nodeVersion = node --version 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Success "Node.js $nodeVersion"
    } else {
        Write-Error-Custom "Node.js not found. Install from https://nodejs.org/"
        exit 1
    }

    # Check npm
    $npmVersion = npm --version 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Success "npm $npmVersion"
    } else {
        Write-Error-Custom "npm not found"
        exit 1
    }

    # Check Git
    $gitVersion = git --version 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Success "Git found"
    } else {
        Write-Error-Custom "Git not found. Install from https://git-scm.com/"
        exit 1
    }

    # Check Ollama
    $ollamaVersion = ollama --version 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Success "Ollama found"
    } else {
        Write-Error-Custom "Ollama not found. Install from https://ollama.ai/"
        exit 1
    }

    # Check Ollama model
    $modelCheck = ollama list 2>$null | Select-String "qwen2.5"
    if ($modelCheck) {
        Write-Success "qwen2.5 model available"
    } else {
        Write-Warning-Custom "qwen2.5 model not found. Downloading..."
        Write-Warning-Custom "This may take 10-30 minutes (~9GB)..."
        ollama pull qwen2.5:14b
    }
}

# Create project structure
function Create-Structure {
    Write-Header "Creating Project Structure"

    # Check if already initialized
    if ((Test-Path "README.md") -and (Test-Path "docs")) {
        Write-Warning-Custom "Project already initialized. Skipping structure creation."
        return
    }

    # Create folders
    New-Item -ItemType Directory -Path "docs" -Force > $null
    New-Item -ItemType Directory -Path "apps/frontend" -Force > $null
    New-Item -ItemType Directory -Path "apps/backend" -Force > $null
    New-Item -ItemType Directory -Path "scripts" -Force > $null

    Write-Success "Folders created"

    # Create .gitignore
    if (!(Test-Path ".gitignore")) {
        @"
node_modules/
.env
.env.local
.DS_Store
dist/
build/
*.log
.vscode/settings.json
.idea/
.next/
.cache/
coverage/
"@ | Out-File -FilePath ".gitignore" -Encoding UTF8
        Write-Success ".gitignore created"
    }

    # Create README.md
    if (!(Test-Path "README.md")) {
        @"
# IELTS Buddy

AI-powered English learning app for Vietnamese students.

## Quick Start

``````bash
# Backend
cd apps/backend
npm install
npx prisma migrate dev
npm run seed
npm run dev

# Frontend (in another terminal)
cd apps/frontend
npm install
npm run dev
``````

## Documentation

See `docs/00_PROJECT_CONTEXT.md` to start.

## Setup

Run ``setup-windows.ps1`` to automate setup, or follow `docs/SETUP_FROM_ZERO.md`.
"@ | Out-File -FilePath "README.md" -Encoding UTF8
        Write-Success "README.md created"
    }

    # Create .env.example
    if (!(Test-Path ".env.example")) {
        @"
DATABASE_URL="postgresql://postgres:password@localhost:5432/ielts_buddy"
OLLAMA_API="http://localhost:11434"
NODE_ENV=development
PORT=5000
REACT_APP_API_URL="http://localhost:5000/api"
"@ | Out-File -FilePath ".env.example" -Encoding UTF8
        Write-Success ".env.example created"
    }
}

# Initialize Git
function Initialize-Git {
    Write-Header "Initializing Git"

    $gitDir = git rev-parse --git-dir 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Warning-Custom "Git already initialized"
        return
    }

    git init
    git config user.name "IELTS Buddy Developer"
    git config user.email "dev@ielts-buddy.local"

    Write-Success "Git initialized"
    Write-Warning-Custom "Remember to run: git remote add origin <YOUR_GITHUB_URL>"
}

# Setup Backend
function Setup-Backend {
    Write-Header "Setting Up Backend"

    Push-Location "apps/backend"

    # Create package.json
    if (!(Test-Path "package.json")) {
        @"
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
    "prisma": "^5.0.0"
  }
}
"@ | Out-File -FilePath "package.json" -Encoding UTF8
        Write-Success "Backend package.json created"
    }

    # Install dependencies
    if (!(Test-Path "node_modules")) {
        Write-Warning-Custom "Installing backend dependencies (this may take a minute)..."
        npm install
        Write-Success "Dependencies installed"
    } else {
        Write-Warning-Custom "node_modules already exists, skipping npm install"
    }

    # Copy .env
    if (!(Test-Path ".env")) {
        Copy-Item "..\..\\.env.example" ".env"
        Write-Success ".env created (update DATABASE_URL with your credentials)"
    }

    # Initialize Prisma
    if (!(Test-Path "prisma")) {
        npx prisma init 2>$null
        Write-Success "Prisma initialized"
    }

    Pop-Location
}

# Setup Frontend
function Setup-Frontend {
    Write-Header "Setting Up Frontend"

    Push-Location "apps/frontend"

    # Create package.json
    if (!(Test-Path "package.json")) {
        @"
{
  "name": "ielts-buddy-frontend",
  "version": "1.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview"
  },
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "react-router-dom": "^6.14.0",
    "axios": "^1.4.0"
  },
  "devDependencies": {
    "@vitejs/plugin-react": "^4.0.0",
    "vite": "^4.4.0"
  }
}
"@ | Out-File -FilePath "package.json" -Encoding UTF8
        Write-Success "Frontend package.json created"
    }

    # Install dependencies
    if (!(Test-Path "node_modules")) {
        Write-Warning-Custom "Installing frontend dependencies (this may take a minute)..."
        npm install
        Write-Success "Dependencies installed"
    } else {
        Write-Warning-Custom "node_modules already exists, skipping npm install"
    }

    # Create vite.config.js
    if (!(Test-Path "vite.config.js")) {
        @"
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
"@ | Out-File -FilePath "vite.config.js" -Encoding UTF8
        Write-Success "vite.config.js created"
    }

    # Create index.html
    if (!(Test-Path "index.html")) {
        @"
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <link rel="icon" type="image/svg+xml" href="/vite.svg" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>IELTS Buddy</title>
    <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }
      body {
        font-family: 'Be Vietnam Pro', sans-serif;
        background: #eef0f7;
      }
    </style>
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/main.jsx"></script>
  </body>
</html>
"@ | Out-File -FilePath "index.html" -Encoding UTF8
        Write-Success "index.html created"
    }

    # Create src structure
    if (!(Test-Path "src")) {
        New-Item -ItemType Directory -Path "src\pages" -Force > $null
        New-Item -ItemType Directory -Path "src\components" -Force > $null
        New-Item -ItemType Directory -Path "src\api" -Force > $null

        # Create main.jsx
        @"
import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App'

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
)
"@ | Out-File -FilePath "src\main.jsx" -Encoding UTF8

        # Create App.jsx
        @"
import { BrowserRouter, Routes, Route } from 'react-router-dom'
import Welcome from './pages/Welcome'

export default function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Welcome />} />
      </Routes>
    </BrowserRouter>
  )
}
"@ | Out-File -FilePath "src\App.jsx" -Encoding UTF8

        # Create Welcome page
        @"
export default function Welcome() {
  return (
    <div style={{ padding: '40px', textAlign: 'center', minHeight: '100vh', background: '#eef0f7' }}>
      <h1 style={{ fontSize: '2.5rem', marginBottom: '20px', background: 'linear-gradient(135deg, #6366f1, #8b5cf6)', backgroundClip: 'text', WebkitBackgroundClip: 'text', color: 'transparent' }}>
        🎓 IELTS Buddy
      </h1>
      <p style={{ fontSize: '1.1rem', marginBottom: '40px', color: '#64748b' }}>
        Welcome to your English learning journey!
      </p>
      <button style={{ padding: '12px 24px', fontSize: '1rem', background: 'linear-gradient(135deg, #6366f1, #8b5cf6)', color: 'white', border: 'none', borderRadius: '8px', cursor: 'pointer', fontWeight: 'bold' }}>
        Get Started
      </button>
    </div>
  )
}
"@ | Out-File -FilePath "src\pages\Welcome.jsx" -Encoding UTF8

        # Create API client
        @"
import axios from 'axios'

const client = axios.create({
  baseURL: '/api',
  timeout: 30000,
  headers: {
    'Content-Type': 'application/json'
  }
})

export default client
"@ | Out-File -FilePath "src\api\client.js" -Encoding UTF8

        Write-Success "Frontend src structure created"
    }

    Pop-Location
}

# Print summary
function Print-Summary {
    Write-Header "Setup Complete! 🎉"

    Write-Host "Next Steps:" -ForegroundColor Green
    Write-Host ""
    Write-Host "1. Update .env files with your credentials:"
    Write-Host "   - apps\backend\.env (DATABASE_URL)"
    Write-Host "   - apps\frontend\.env (REACT_APP_API_URL)"
    Write-Host ""
    Write-Host "2. Make sure PostgreSQL is running:"
    Write-Host "   - PostgreSQL service, OR"
    Write-Host "   - docker run -e POSTGRES_PASSWORD=password -p 5432:5432 postgres:15"
    Write-Host ""
    Write-Host "3. Make sure Ollama is running:"
    Write-Host "   - ollama serve (in separate terminal)"
    Write-Host ""
    Write-Host "4. Create database and run migrations:"
    Write-Host "   - cd apps\backend"
    Write-Host "   - Copy 05_DATABASE.md content to prisma\schema.prisma"
    Write-Host "   - npx prisma migrate dev --name init"
    Write-Host "   - npm run seed"
    Write-Host ""
    Write-Host "5. Start development servers:"
    Write-Host "   - Backend:  cd apps\backend && npm run dev"
    Write-Host "   - Frontend: cd apps\frontend && npm run dev"
    Write-Host ""
    Write-Host "6. Open browser:"
    Write-Host "   - http://localhost:3000"
    Write-Host ""
    Write-Host "7. Start Sprint 1:"
    Write-Host "   - Copy Sprint 1 prompt from docs\15_PROMPTS.md"
    Write-Host "   - Paste into Continue chat (Ctrl+Shift+L)"
    Write-Host ""
    Write-Host "For detailed instructions, see: docs\SETUP_FROM_ZERO.md" -ForegroundColor Yellow
    Write-Host ""
}

# Main execution
Write-Host "" -ForegroundColor Blue
Write-Host "╔════════════════════════════════════════╗" -ForegroundColor Blue
Write-Host "║   IELTS BUDDY - Automated Setup        ║" -ForegroundColor Blue
Write-Host "║   (From Zero to Development Ready)     ║" -ForegroundColor Blue
Write-Host "╚════════════════════════════════════════╝" -ForegroundColor Blue
Write-Host "" -ForegroundColor Blue

Check-Prerequisites
Create-Structure
Initialize-Git
Setup-Backend
Setup-Frontend
Print-Summary

Write-Host ""
