import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import learnersRouter from './routes/learners.js';
import questionsRouter from './routes/questions.js';
import attemptsRouter from './routes/attempts.js';

dotenv.config();

const app = express();

app.use(cors());
app.use(express.json());

app.get('/', (req, res) => {
  res.json({ message: 'IELTS Buddy API - Hello World!' });
});

app.use('/api/learners', learnersRouter);
app.use('/api/questions', questionsRouter);
app.use('/api/attempts', attemptsRouter);

app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ error: 'Internal Server Error' });
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Backend running on http://localhost:${PORT}`);
});
