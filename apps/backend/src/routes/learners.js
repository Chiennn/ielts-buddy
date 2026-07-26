import express from 'express';
import { PrismaClient } from '@prisma/client';

const router = express.Router();
const prisma = new PrismaClient();

router.get('/', async (req, res) => {
  try {
    const learners = await prisma.learner.findMany();
    return res.status(200).json(learners);
  } catch (error) {
    console.error('Error fetching learners:', error);
    return res.status(500).json({ error: 'Internal Server Error' });
  }
});

router.post('/', async (req, res) => {
  try {
    const { name, grade, targetIelts } = req.body;
    if (!name || grade === undefined || !targetIelts) {
      return res.status(400).json({ error: 'Missing required fields' });
    }

    const learner = await prisma.learner.create({
      data: { name, grade, targetIelts }
    });

    return res.status(201).json(learner);
  } catch (error) {
    console.error('Error creating learner:', error);
    return res.status(500).json({ error: 'Internal Server Error' });
  }
});

router.get('/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const learner = await prisma.learner.findUnique({ where: { id } });

    if (!learner) return res.status(404).json({ error: 'Learner not found' });
    return res.status(200).json(learner);
  } catch (error) {
    console.error('Error fetching learner:', error);
    return res.status(500).json({ error: 'Internal Server Error' });
  }
});

router.put('/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const { name, grade, targetIelts, cefrLevel } = req.body;

    const learner = await prisma.learner.update({
      where: { id },
      data: { name, grade, targetIelts, cefrLevel }
    });

    return res.status(200).json(learner);
  } catch (error) {
    if (error.code === 'P2025') {
      return res.status(404).json({ error: 'Learner not found' });
    }
    console.error('Error updating learner:', error);
    return res.status(500).json({ error: 'Internal Server Error' });
  }
});

export default router;
