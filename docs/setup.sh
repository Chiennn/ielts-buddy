#!/bin/bash

# ====================================================================
# IELTS BUDDY - Automated Project Setup Script
# ====================================================================
# 
# Usage: bash setup.sh
# 
# This script automatically:
# 1. Creates folder structure
# 2. Initializes Git
# 3. Sets up Backend (Node + Prisma)
# 4. Sets up Frontend (React + Vite)
# 5. Creates Database
# 6. Seeds initial data
#
# Prerequisites:
# - Node.js v16+ installed
# - PostgreSQL running (or Docker)
# - Git installed
# - Ollama installed with qwen2.5 model
#
# ====================================================================

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
print_header() {
    echo -e "\n${BLUE}========================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}========================================${NC}\n"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

# Check prerequisites
check_prerequisites() {
    print_header "Checking Prerequisites"

    # Check Node
    if ! command -v node &> /dev/null; then
        print_error "Node.js not found. Install from https://nodejs.org/"
        exit 1
    fi
    print_success "Node.js $(node --version)"

    # Check npm
    if ! command -v npm &> /dev/null; then
        print_error "npm not found"
        exit 1
    fi
    print_success "npm $(npm --version)"

    # Check Git
    if ! command -v git &> /dev/null; then
        print_error "Git not found. Install from https://git-scm.com/"
        exit 1
    fi
    print_success "Git $(git --version)"

    # Check PostgreSQL (optional if using Docker)
    if ! command -v psql &> /dev/null; then
        print_warning "PostgreSQL not found in PATH"
        print_warning "Make sure PostgreSQL is running or use Docker:"
        print_warning "  docker run -e POSTGRES_PASSWORD=password -p 5432:5432 postgres:15"
    else
        print_success "PostgreSQL $(psql --version)"
    fi

    # Check Ollama
    if ! command -v ollama &> /dev/null; then
        print_error "Ollama not found. Install from https://ollama.ai/"
        exit 1
    fi
    print_success "Ollama installed"

    # Check if model is downloaded
    if ! ollama list | grep -q "qwen2.5"; then
        print_warning "qwen2.5 model not found. Downloading..."
        print_warning "This may take 10-30 minutes (~9GB)..."
        ollama pull qwen2.5:14b
    else
        print_success "qwen2.5 model available"
    fi
}

# Create project structure
create_structure() {
    print_header "Creating Project Structure"

    # Check if already in AppStudyLanguage folder
    if [ -f "README.md" ] && [ -d "docs" ]; then
        print_warning "Project already initialized. Skipping structure creation."
        return
    fi

    # Create folders
    mkdir -p docs
    mkdir -p apps/frontend
    mkdir -p apps/backend
    mkdir -p scripts

    print_success "Folders created"

    # Create .gitignore if not exists
    if [ ! -f ".gitignore" ]; then
        cat > .gitignore << 'EOF'
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
EOF
        print_success ".gitignore created"
    fi

    # Create README if not exists
    if [ ! -f "README.md" ]; then
        cat > README.md << 'EOF'
# IELTS Buddy

AI-powered English learning app for Vietnamese students.

## Quick Start

```bash
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
```

## Documentation

See `docs/00_PROJECT_CONTEXT.md` to start.

## Setup

Run `bash setup.sh` to automate setup, or follow `docs/SETUP_FROM_ZERO.md`.
EOF
        print_success "README.md created"
    fi

    # Create .env.example if not exists
    if [ ! -f ".env.example" ]; then
        cat > .env.example << 'EOF'
DATABASE_URL="postgresql://postgres:password@localhost:5432/ielts_buddy"
OLLAMA_API="http://localhost:11434"
NODE_ENV=development
PORT=5000
REACT_APP_API_URL="http://localhost:5000/api"
EOF
        print_success ".env.example created"
    fi
}

# Initialize Git
init_git() {
    print_header "Initializing Git"

    if git rev-parse --git-dir > /dev/null 2>&1; then
        print_warning "Git already initialized"
        return
    fi

    git init
    git config user.name "IELTS Buddy Developer"
    git config user.email "dev@ielts-buddy.local"

    print_success "Git initialized"
    print_warning "Remember to run: git remote add origin <YOUR_GITHUB_URL>"
}

# Setup Backend
setup_backend() {
    print_header "Setting Up Backend"

    cd apps/backend

    # Create package.json if not exists
    if [ ! -f "package.json" ]; then
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
    "prisma": "^5.0.0"
  }
}
EOF
        print_success "Backend package.json created"
    fi

    # Install dependencies
    if [ ! -d "node_modules" ]; then
        print_warning "Installing backend dependencies (this may take a minute)..."
        npm install
        print_success "Dependencies installed"
    else
        print_warning "node_modules already exists, skipping npm install"
    fi

    # Copy .env if not exists
    if [ ! -f ".env" ]; then
        cp ../../.env.example .env
        print_success ".env created (update DATABASE_URL with your credentials)"
    fi

    # Initialize Prisma if not exists
    if [ ! -d "prisma" ]; then
        npx prisma init
        print_success "Prisma initialized"
    fi

    cd ../..
}

# Setup Frontend
setup_frontend() {
    print_header "Setting Up Frontend"

    cd apps/frontend

    # Create package.json for Vite if not exists
    if [ ! -f "package.json" ]; then
        cat > package.json << 'EOF'
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
EOF
        print_success "Frontend package.json created"
    fi

    # Install dependencies
    if [ ! -d "node_modules" ]; then
        print_warning "Installing frontend dependencies (this may take a minute)..."
        npm install
        print_success "Dependencies installed"
    else
        print_warning "node_modules already exists, skipping npm install"
    fi

    # Create vite.config.js
    if [ ! -f "vite.config.js" ]; then
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
        print_success "vite.config.js created"
    fi

    # Create index.html
    if [ ! -f "index.html" ]; then
        cat > index.html << 'EOF'
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
EOF
        print_success "index.html created"
    fi

    # Create src structure if not exists
    if [ ! -d "src" ]; then
        mkdir -p src/{pages,components,api}
        
        # Create main.jsx
        cat > src/main.jsx << 'EOF'
import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App'

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
)
EOF

        # Create App.jsx
        cat > src/App.jsx << 'EOF'
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
EOF

        # Create Welcome page
        cat > src/pages/Welcome.jsx << 'EOF'
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
EOF

        # Create API client
        cat > src/api/client.js << 'EOF'
import axios from 'axios'

const client = axios.create({
  baseURL: '/api',
  timeout: 30000,
  headers: {
    'Content-Type': 'application/json'
  }
})

export default client
EOF

        print_success "Frontend src structure created"
    fi

    cd ../..
}

# Create database
create_database() {
    print_header "Creating Database"

    # Check if .env exists in backend
    if [ ! -f "apps/backend/.env" ]; then
        print_error ".env not found in backend"
        print_warning "Please update apps/backend/.env with your PostgreSQL credentials"
        return
    fi

    cd apps/backend

    # Check if Prisma schema exists
    if [ ! -f "prisma/schema.prisma" ]; then
        print_warning "Prisma schema not found. You need to create prisma/schema.prisma"
        print_warning "Copy content from docs/05_DATABASE.md"
        cd ../..
        return
    fi

    # Run migrations
    print_warning "Running Prisma migrations..."
    npx prisma migrate dev --name init 2>/dev/null || {
        print_warning "Could not auto-create database. You may need to:"
        print_warning "  1. Create database: createdb -U postgres ielts_buddy"
        print_warning "  2. Run: npx prisma migrate dev --name init"
    }

    print_success "Database migrations complete"

    cd ../..
}

# Seed database
seed_database() {
    print_header "Seeding Database"

    if [ ! -f "apps/backend/prisma/seed.js" ]; then
        print_warning "Seed file not found. Skipping."
        print_warning "Create apps/backend/prisma/seed.js from SETUP_FROM_ZERO.md"
        return
    fi

    cd apps/backend
    npm run seed 2>/dev/null || {
        print_warning "Could not run seed. Run manually: npm run seed"
    }
    cd ../..

    print_success "Database seeded"
}

# Initial Git commit
initial_commit() {
    print_header "Creating Initial Git Commit"

    if [ -d ".git" ]; then
        git add .
        git commit -m "chore: initial project setup - docs, frontend, backend structure" 2>/dev/null || {
            print_warning "Could not create commit (may already exist)"
        }
        print_success "Initial commit created"
        print_warning "Push to GitHub: git push -u origin main"
    fi
}

# Print summary
print_summary() {
    print_header "Setup Complete! 🎉"

    echo -e "${GREEN}Next Steps:${NC}\n"
    echo "1. Update .env files with your credentials:"
    echo "   - apps/backend/.env (DATABASE_URL)"
    echo "   - apps/frontend/.env (REACT_APP_API_URL)"
    echo ""
    echo "2. Make sure PostgreSQL is running:"
    echo "   - PostgreSQL service, OR"
    echo "   - docker run -e POSTGRES_PASSWORD=password -p 5432:5432 postgres:15"
    echo ""
    echo "3. Make sure Ollama is running:"
    echo "   - ollama serve (in separate terminal)"
    echo ""
    echo "4. Create database and run migrations:"
    echo "   - cd apps/backend"
    echo "   - Copy 05_DATABASE.md content to prisma/schema.prisma"
    echo "   - npx prisma migrate dev --name init"
    echo "   - npm run seed"
    echo ""
    echo "5. Start development servers:"
    echo "   - Backend:  cd apps/backend && npm run dev"
    echo "   - Frontend: cd apps/frontend && npm run dev"
    echo ""
    echo "6. Open browser:"
    echo "   - http://localhost:3000"
    echo ""
    echo "7. Start Sprint 1:"
    echo "   - Copy Sprint 1 prompt from docs/15_PROMPTS.md"
    echo "   - Paste into Continue chat (Ctrl+Shift+L)"
    echo ""
    echo -e "${YELLOW}For detailed instructions, see: docs/SETUP_FROM_ZERO.md${NC}\n"
}

# Main execution
main() {
    echo -e "${BLUE}"
    echo "╔════════════════════════════════════════╗"
    echo "║   IELTS BUDDY - Automated Setup        ║"
    echo "║   (From Zero to Development Ready)     ║"
    echo "╚════════════════════════════════════════╝"
    echo -e "${NC}"

    check_prerequisites
    create_structure
    init_git
    setup_backend
    setup_frontend
    create_database
    seed_database
    initial_commit
    print_summary
}

# Run main
main
