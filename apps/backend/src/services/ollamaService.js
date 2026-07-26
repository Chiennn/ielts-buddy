const TIMEOUT = 30 * 1000; // 30 seconds

export async function scoreWriting(text) {
  try {
    const prompt = `You are an IELTS examiner. Score this writing for a young learner.
Return ONLY JSON: {"band": number, "cefr": "A1|A2|B1|B2|C1|C2", "feedback": "short vi text"}.
Writing: """${text}"""`;

    const response = await fetch('http://localhost:11434/api/generate', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ model: 'qwen2.5:14b', prompt, stream: false, format: 'json' }),
      signal: AbortSignal.timeout(TIMEOUT)
    });

    if (!response.ok) {
      throw new Error('Failed to score writing');
    }

    const data = await response.json();
    const result = JSON.parse(data.response);
    return { band: result.band, cefr: result.cefr, feedback: result.feedback };
  } catch (error) {
    console.error('Error scoring writing:', error);
    throw error;
  }
}

export async function speakingTranscriptScore(transcript) {
  try {
    const prompt = `You are an IELTS examiner. Score this speaking transcript for a young learner.
Return ONLY JSON: {"band": number, "cefr": "A1|A2|B1|B2|C1|C2", "feedback": "short vi text"}.
Transcript: """${transcript}"""`;

    const response = await fetch('http://localhost:11434/api/generate', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ model: 'qwen2.5:14b', prompt, stream: false, format: 'json' }),
      signal: AbortSignal.timeout(TIMEOUT)
    });

    if (!response.ok) {
      throw new Error('Failed to score speaking');
    }

    const data = await response.json();
    const result = JSON.parse(data.response);
    return { band: result.band, cefr: result.cefr, feedback: result.feedback };
  } catch (error) {
    console.error('Error scoring speaking:', error);
    throw error;
  }
}

export async function calculateCEFR(scores) {
  try {
    const average = (scores.listening + scores.reading + scores.speaking + scores.writing) / 4;

    if (average >= 85) return 'C2';
    if (average >= 70) return 'B2';
    if (average >= 55) return 'B1';
    if (average >= 40) return 'A2';
    if (average >= 25) return 'A1';

    return 'A1';
  } catch (error) {
    console.error('Error calculating CEFR:', error);
    throw error;
  }
}
