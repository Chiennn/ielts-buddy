import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()

async function main() {
  console.log('🌱 Seeding database...')

  // Clear existing data
  await prisma.testAttempt.deleteMany()
  await prisma.question.deleteMany()
  await prisma.learner.deleteMany()

  // Create sample learners
  const learner1 = await prisma.learner.create({
    data: {
      name: 'Nguyễn Minh Châu',
      grade: 6,
      cefrLevel: null,
      targetIelts: '6.0',
      xp: 0,
    },
  })

  const learner2 = await prisma.learner.create({
    data: {
      name: 'Nguyễn Minh Phúc',
      grade: 2,
      cefrLevel: null,
      targetIelts: 'A2',
      xp: 0,
    },
  })

  // Create sample questions
  const questions = [
    {
      skill: 'reading',
      type: 'mcq',
      prompt: 'What is the main idea of the paragraph?',
      sub: 'Reading comprehension - Level A2',
      options: ['Option A', 'Option B', 'Option C', 'Option D'],
      answer: 1,
      level: 'A2',
    },
    {
      skill: 'grammar',
      type: 'mcq',
      prompt: 'Choose the correct verb form: "I _____ to school every day."',
      sub: 'Present simple tense',
      options: ['goes', 'go', 'going', 'gone'],
      answer: 1,
      level: 'A1',
    },
    {
      skill: 'listening',
      type: 'mcq',
      prompt: 'What does the speaker say about the weather?',
      sub: 'Listening comprehension - Weather',
      audioUrl: 'https://example.com/audio/weather.mp3',
      options: ['It is sunny', 'It is rainy', 'It is cloudy', 'It is snowy'],
      answer: 1,
      level: 'A2',
    },
    {
      skill: 'writing',
      type: 'writing',
      prompt: 'Write about your favorite hobby (50-100 words)',
      sub: 'Personal writing - Hobby description',
      level: 'B1',
    },
    {
      skill: 'speaking',
      type: 'speaking',
      prompt: 'Describe your daily routine',
      sub: 'Speaking - Personal routine',
      level: 'A2',
    },
  ]

  for (const q of questions) {
    await prisma.question.create({
      data: q,
    })
  }

  console.log('✅ Seeding completed!')
  console.log(`   - 2 Learners created`)
  console.log(`   - 5 Questions created`)
  console.log(`   - Ready for testing!`)
}

main()
  .catch((e) => {
    console.error('❌ Seeding failed:', e)
    process.exit(1)
  })
  .finally(async () => {
    await prisma.$disconnect()
  })
