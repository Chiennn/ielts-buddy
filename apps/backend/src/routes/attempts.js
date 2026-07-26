import express from 'express';
import { PrismaClient } from '@prisma/client';
import { scoreWriting, speakingTranscriptScore, calculateCEFR } from '../services/ollamaService.js';

const router = express.Router();
const prisma = new PrismaClient();

router.post('/', async (req, res) => {
  try {
    const { learnerId, answers } = req.body;
    if (!learnerId || !answers) {
      return res.status(400).json({ error: 'Missing required fields' });
    }

    const testAttempt = await prisma.testAttempt.create({
      data: {
        learnerId,
        answers
      }
    });

    return res.status(201).json(testAttempt);
  } catch (error) {
    console.error('Error creating test attempt:', error);
    return res.status(500).json({ error: 'Internal Server Error' });
  }
});

// Score writing/speaking with Ollama, calculate CEFR, save to DB
router.get('/:attemptId/score', async (req, res) => {
  try {
    const { attemptId } = req.params;
    const attempt = await prisma.testAttempt.findUnique({
      where: { id: attemptId },
      include: { learner: true }
    });

    if (!attempt) {
      return res.status(404).json({ error: 'Test Attempt not found' });
    }

    // Aggregate scores by skill (listening, reading, speaking, writing)
    const skillScores = {
      listening: 50,
      reading: 50,
      speaking: 0,
      writing: 0
    };

    // Process each answer
    for (const [questionId, answer] of Object.entries(attempt.answers)) {
      const question = await prisma.question.findUnique({
        where: { id: questionId }
      });

      if (!question) continue;

      // Score writing/speaking with Ollama
      if (question.type === 'writing') {
        const result = await scoreWriting(answer);
        skillScores.writing = (result.band / 9) * 100; // Convert IELTS band (1-9) to score (0-100)
      } else if (question.type === 'speaking') {
        const result = await speakingTranscriptScore(answer);
        skillScores.speaking = (result.band / 9) * 100;
      }
    }

    // Calculate overall CEFR from aggregated skill scores
    const cefrResult = calculateCEFR(skillScores);

    // Update attempt with scores and CEFR
    const updatedAttempt = await prisma.testAttempt.update({
      where: { id: attemptId },
      data: {
        scores: skillScores,
        cefrResult
      }
    });

    return res.status(200).json(updatedAttempt);
  } catch (error) {
    console.error('Error scoring test attempt:', error);
    return res.status(500).json({ error: 'Internal Server Error' });
  }
});

// Get all attempts for a learner
router.get('/learner/:learnerId', async (req, res) => {
  try {
    const { learnerId } = req.params;
    const attempts = await prisma.testAttempt.findMany({
      where: { learnerId }
    });

    return res.status(200).json(attempts);
  } catch (error) {
    console.error('Error fetching test attempts:', error);
    return res.status(500).json({ error: 'Internal Server Error' });
  }
});

export default router;
