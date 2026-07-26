const TIMEOUT = 60 * 1000; // 60 seconds
const GROQ_API_KEY = process.env.GROQ_API_KEY;

export async function scoreWriting(text) {
  try {
    const prompt = `You are an IELTS examiner. Score this writing for a young learner (age 10-12).
Return ONLY JSON: {"band": number (1-9), "cefr": "A1|A2|B1|B2|C1|C2", "feedback": "short feedback in Vietnamese"}.
Writing: """${text}"""`;

    const response = await fetch('https://api.groq.com/openai/v1/chat/completions', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${GROQ_API_KEY}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        model: 'mixtral-8x7b-32768',
        messages: [{ role: 'user', content: prompt }],
        temperature: 0.3,
        max_tokens: 200
      }),
      signal: AbortSignal.timeout(TIMEOUT)
    });

    if (!response.ok) {
      throw new Error(`Groq API error: ${response.status}`);
    }

    const data = await response.json();
    const content = data.choices[0].message.content;
    const result = JSON.parse(content);
    return { band: result.band, cefr: result.cefr, feedback: result.feedback };
  } catch (error) {
    console.error('Error scoring writing:', error);
    throw error;
  }
}

export async function speakingTranscriptScore(transcript) {
  try {
    const prompt = `You are an IELTS examiner. Score this speaking transcript for a young learner (age 10-12).
Return ONLY JSON: {"band": number (1-9), "cefr": "A1|A2|B1|B2|C1|C2", "feedback": "short feedback in Vietnamese"}.
Transcript: """${transcript}"""`;

    const response = await fetch('https://api.groq.com/openai/v1/chat/completions', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${GROQ_API_KEY}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        model: 'mixtral-8x7b-32768',
        messages: [{ role: 'user', content: prompt }],
        temperature: 0.3,
        max_tokens: 200
      }),
      signal: AbortSignal.timeout(TIMEOUT)
    });

    if (!response.ok) {
      throw new Error(`Groq API error: ${response.status}`);
    }

    const data = await response.json();
    const content = data.choices[0].message.content;
    const result = JSON.parse(content);
    return { band: result.band, cefr: result.cefr, feedback: result.feedback };
  } catch (error) {
    console.error('Error scoring speaking:', error);
    throw error;
  }
}

export function calculateCEFR(scores) {
  const average = (scores.listening + scores.reading + scores.speaking + scores.writing) / 4;

  if (average >= 85) return 'C2';
  if (average >= 70) return 'B2';
  if (average >= 55) return 'B1';
  if (average >= 40) return 'A2';
  if (average >= 25) return 'A1';

  return 'A1';
}
