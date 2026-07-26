import express from 'express';
import { PrismaClient } from '@prisma/client';

const router = express.Router();
const prisma = new PrismaClient();

router.get('/', async (req, res) => {
  try {
    const { level, skill } = req.query;

    const where = {};
    if (level) where.level = level;
    if (skill) where.skill = skill;

    const allQuestions = await prisma.question.findMany({ where });

    if (allQuestions.length === 0) {
      return res.status(404).json({ error: 'No questions found' });
    }

    const randomQuestions = allQuestions
      .sort(() => Math.random() - 0.5)
      .slice(0, 5);

    return res.status(200).json(randomQuestions);
  } catch (error) {
    console.error('Error fetching questions:', error);
    return res.status(500).json({ error: 'Internal Server Error' });
  }
});

router.post('/', async (req, res) => {
  try {
    const { skill, type, prompt, sub, audioUrl, options, answer, level } = req.body;

    if (!skill || !type || !prompt || !level) {
      return res.status(400).json({ error: 'Missing required fields: skill, type, prompt, level' });
    }

    const question = await prisma.question.create({
      data: { skill, type, prompt, sub, audioUrl, options, answer, level }
    });

    return res.status(201).json(question);
  } catch (error) {
    console.error('Error creating question:', error);
    return res.status(500).json({ error: 'Internal Server Error' });
  }
});

export default router;
