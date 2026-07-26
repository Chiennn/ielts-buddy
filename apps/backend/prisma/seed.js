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

  // Create IELTS practice questions
  const questions = [
    // READING - 5 questions
    {
      skill: 'reading',
      type: 'mcq',
      prompt: 'What is the main purpose of the article about renewable energy?',
      sub: 'Reading Passage 1: Renewable Energy',
      options: [
        'To explain why fossil fuels are still important',
        'To describe how solar panels generate electricity',
        'To discuss the benefits and challenges of renewable energy',
        'To compare different countries\' energy policies'
      ],
      answer: 2,
      level: 'B1',
    },
    {
      skill: 'reading',
      type: 'mcq',
      prompt: 'According to the passage, what is the main advantage of wind energy?',
      sub: 'Reading Passage 1: Renewable Energy',
      options: [
        'It is more expensive than solar energy',
        'It produces no carbon emissions',
        'It requires less maintenance than coal plants',
        'It works better in warm climates'
      ],
      answer: 1,
      level: 'B1',
    },
    {
      skill: 'reading',
      type: 'mcq',
      prompt: 'The author\'s tone in this article is primarily:',
      sub: 'Reading Passage 1: Renewable Energy',
      options: [
        'Critical and pessimistic',
        'Informative and balanced',
        'Emotional and persuasive',
        'Humorous and sarcastic'
      ],
      answer: 1,
      level: 'B2',
    },
    {
      skill: 'reading',
      type: 'mcq',
      prompt: 'Which of the following best describes the structure of the passage?',
      sub: 'Reading Passage 1: Renewable Energy',
      options: [
        'Problem and solution',
        'Cause and effect',
        'Chronological order',
        'General information to specific examples'
      ],
      answer: 3,
      level: 'B1',
    },
    {
      skill: 'reading',
      type: 'mcq',
      prompt: 'It can be inferred from the passage that investment in renewable energy will likely:',
      sub: 'Reading Passage 1: Renewable Energy',
      options: [
        'Decrease in the coming years',
        'Remain stable with no growth',
        'Increase due to environmental concerns',
        'Only be made by developing countries'
      ],
      answer: 2,
      level: 'B2',
    },

    // GRAMMAR/VOCABULARY - 3 questions
    {
      skill: 'grammar',
      type: 'mcq',
      prompt: 'If I _____ known about the traffic, I would have left earlier.',
      sub: 'Grammar: Third Conditional',
      options: [
        'had',
        'would have',
        'have',
        'did'
      ],
      answer: 0,
      level: 'B1',
    },
    {
      skill: 'grammar',
      type: 'mcq',
      prompt: 'The company _____ several new employees in the past month.',
      sub: 'Grammar: Present Perfect',
      options: [
        'has hired',
        'hired',
        'is hiring',
        'will hire'
      ],
      answer: 0,
      level: 'A2',
    },
    {
      skill: 'grammar',
      type: 'mcq',
      prompt: 'Despite _____ the instructions carefully, he still made mistakes.',
      sub: 'Grammar: Prepositions & Gerunds',
      options: [
        'read',
        'to read',
        'reading',
        'has read'
      ],
      answer: 2,
      level: 'B1',
    },

    // LISTENING - 3 questions
    {
      skill: 'listening',
      type: 'mcq',
      prompt: 'Where is the conversation taking place?',
      sub: 'Listening Section 1: At a hotel reception',
      options: [
        'At an airport',
        'At a hotel',
        'At a restaurant',
        'At a train station'
      ],
      answer: 1,
      level: 'A2',
    },
    {
      skill: 'listening',
      type: 'mcq',
      prompt: 'What is the guest\'s main concern?',
      sub: 'Listening Section 1: At a hotel reception',
      options: [
        'The room is too small',
        'The Wi-Fi password is not working',
        'There is no hot water',
        'The breakfast time is too early'
      ],
      answer: 1,
      level: 'A2',
    },
    {
      skill: 'listening',
      type: 'mcq',
      prompt: 'How long will the guest stay at the hotel?',
      sub: 'Listening Section 1: At a hotel reception',
      options: [
        'One night',
        'Three nights',
        'One week',
        'Two weeks'
      ],
      answer: 1,
      level: 'A1',
    },

    // WRITING - 3 prompts
    {
      skill: 'writing',
      type: 'writing',
      prompt: 'You are writing a formal email to your teacher requesting a meeting. Write an email (80-120 words) explaining when you are available and what you would like to discuss.',
      sub: 'Writing Task: Formal Email',
      level: 'B1',
    },
    {
      skill: 'writing',
      type: 'writing',
      prompt: 'Describe an important person in your life and explain why they are important to you. Write 120-150 words.',
      sub: 'Writing Task: Descriptive Paragraph',
      level: 'A2',
    },
    {
      skill: 'writing',
      type: 'writing',
      prompt: 'Write a formal letter of complaint to a restaurant about a poor dining experience. Include specific details about what went wrong (150-180 words).',
      sub: 'Writing Task: Formal Complaint Letter',
      level: 'B1',
    },

    // SPEAKING - 3 prompts
    {
      skill: 'speaking',
      type: 'speaking',
      prompt: 'Describe a memorable trip you have taken. Talk about where you went, when you went, who you went with, and why it was memorable.',
      sub: 'Speaking Part 2: Cue Card Topic',
      level: 'B1',
    },
    {
      skill: 'speaking',
      type: 'speaking',
      prompt: 'What is your favorite hobby? Why do you enjoy it? How often do you do it?',
      sub: 'Speaking Part 1: Personal Interests',
      level: 'A2',
    },
    {
      skill: 'speaking',
      type: 'speaking',
      prompt: 'Do you think technology has made life easier or more complicated? Explain your opinion with examples.',
      sub: 'Speaking Part 3: Abstract Discussion',
      level: 'B2',
    },
  ]

  for (const q of questions) {
    await prisma.question.create({
      data: q,
    })
  }

  console.log('✅ Seeding completed!')
  console.log(`   - 2 Learners created`)
  console.log(`   - 20 Real IELTS Questions created`)
  console.log(`   - Topics: Reading, Grammar, Listening, Writing, Speaking`)
  console.log(`   - Levels: A1-B2`)
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
