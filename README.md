# IELTS Buddy

Interactive learning platform for IELTS preparation built with React, Express, and SQLite.

## Technology Stack

- **Frontend**: React 18 + Vite + Tailwind CSS
- **Backend**: Express.js + Prisma ORM
- **Database**: SQLite
- **Node.js**: 22 LTS compatible

## Project Structure

```
ielts-buddy/
├── apps/
│   ├── frontend/          # React + Vite application (port 5173)
│   │   ├── src/
│   │   │   ├── App.jsx    # Main React component
│   │   │   ├── main.jsx   # React entry point
│   │   │   └── index.css  # Tailwind styles
│   │   ├── index.html     # HTML template
│   │   ├── package.json
│   │   ├── vite.config.js
│   │   ├── tailwind.config.js
│   │   └── postcss.config.js
│   └── backend/           # Express API server (port 5000)
│       ├── src/
│       │   └── main.js    # Express entry point
│       ├── prisma/
│       │   └── schema.prisma  # Database schema
│       ├── package.json
│       ├── .env           # Local environment variables
│       └── .env.example   # Environment template
├── docs/                  # Documentation
├── .gitignore
├── package.json           # Root package for scripts
└── README.md
```

## Getting Started

### Prerequisites

- Node.js 22 LTS or higher
- npm or yarn package manager

### Installation

#### Option 1: Automated Setup (Recommended)

```bash
npm run setup
```

This runs `npm install` in all packages (root, frontend, backend).

#### Option 2: Manual Setup

```bash
# Install root dependencies
npm install

# Install frontend dependencies
cd apps/frontend
npm install

# Install backend dependencies
cd ../backend
npm install
```

### Database Setup

Initialize the SQLite database with Prisma:

```bash
cd apps/backend
npx prisma migrate dev --name init
```

This creates the `dev.db` file and sets up the schema.

## Running the Application

### Start Both Services

**Terminal 1 - Backend (API on port 5000):**
```bash
npm run dev:backend
```

**Terminal 2 - Frontend (UI on port 5173):**
```bash
npm run dev:frontend
```

The frontend will automatically try to connect to the backend API.

### Alternative: Run Individually

```bash
# Backend only
cd apps/backend
npm start              # production mode
npm run dev          # development with auto-reload

# Frontend only
cd apps/frontend
npm run dev          # development server
npm run build        # production build
npm run preview      # preview production build
```

## API Endpoints

### Health Check
- `GET /` - API status

### Learners
- `GET /api/learners` - List all learners
- `POST /api/learners` - Create a new learner
  - Body: `{ "email": "user@example.com", "name": "John Doe" }`

### Questions
- `GET /api/questions` - List all questions
- `POST /api/questions` - Create a new question
  - Body: `{ "type": "listening", "content": "...", "options": "...", "answer": "..." }`

### Test Attempts
- `POST /api/test-attempts` - Record a test attempt
  - Body: `{ "learnerId": 1, "questionId": 1, "userAnswer": "...", "isCorrect": true, "score": 95 }`
- `GET /api/test-attempts/:learnerId` - Get learner's test attempts

## Development

### Add New Dependencies

```bash
# Frontend
cd apps/frontend
npm install package-name

# Backend
cd apps/backend
npm install package-name
```

### Database Schema Changes

Edit `apps/backend/prisma/schema.prisma` then:

```bash
cd apps/backend
npx prisma migrate dev --name your_migration_name
```

### Code Formatting

Both packages use their respective formatters (Prettier for React, Node.js conventions for Express).

## Testing

This is a Sprint 0 baseline. Tests can be added in subsequent sprints:

- Frontend tests: Add Jest + React Testing Library
- Backend tests: Add Jest or Mocha

## Environment Variables

### Backend (.env)

```
DATABASE_URL="file:./dev.db"
NODE_ENV="development"
PORT=5000
```

See `.env.example` for the template.

## Troubleshooting

### Port Already in Use

If port 5000 or 5173 is already in use:

```bash
# Change backend port in .env
PORT=5001

# Change frontend port in vite.config.js
server: { port: 5174 }
```

### Database Connection Error

```bash
cd apps/backend
rm prisma/dev.db
npx prisma migrate dev --name init
```

### Node Modules Issues

```bash
# Clean installation
cd apps/backend
rm -r node_modules package-lock.json
npm install

cd ../frontend
rm -r node_modules package-lock.json
npm install
```

## Building for Production

```bash
# Build frontend
npm run build:frontend

# Build backend (no build step, but verify dependencies)
npm run build:backend

# Or together
npm run build:frontend && npm run build:backend
```

## Contributing

Sprint 0 is the foundation. All development follows the project guidelines in `/docs`.

## License

MIT
