import { useState } from 'react';
import { Link } from 'react-router-dom';

export default function TestPage({ selectedLearner, testData }) {
  const [currentQuestion, setCurrentQuestion] = useState(0);
  const [answers, setAnswers] = useState({});

  if (!selectedLearner) {
    return <div className="text-center py-12">Please select a learner first</div>;
  }

  if (testData.length === 0) {
    return <div className="text-center py-12">Loading questions...</div>;
  }

  const question = testData[currentQuestion];
  const progress = ((currentQuestion + 1) / testData.length) * 100;

  const handleAnswer = (answer) => {
    setAnswers({ ...answers, [question.id]: answer });
  };

  const handleNext = () => {
    if (currentQuestion < testData.length - 1) {
      setCurrentQuestion(currentQuestion + 1);
    }
  };

  const handleSubmit = async () => {
    try {
      const API_URL = 'https://ielts-buddy-api.onrender.com';
      const res = await fetch(`${API_URL}/api/attempts`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          learnerId: selectedLearner.id,
          answers
        })
      });
      if (res.ok) {
        window.location.href = '/analyzing';
      }
    } catch (error) {
      console.error('Error submitting test:', error);
    }
  };

  return (
    <div className="max-w-4xl mx-auto">
      <div className="mb-6">
        <div className="flex justify-between mb-2">
          <span className="text-sm font-semibold">Question {currentQuestion + 1}/{testData.length}</span>
          <span className="text-sm text-gray-600">{Math.round(progress)}%</span>
        </div>
        <div className="w-full bg-gray-300 rounded-full h-2">
          <div className="bg-gradient-to-r from-[#6366f1] to-[#8b5cf6] h-2 rounded-full" style={{ width: `${progress}%` }}></div>
        </div>
      </div>

      <div className="bg-white rounded-lg shadow-lg p-8 mb-8">
        <h2 className="text-2xl font-semibold mb-4">{question.prompt}</h2>
        {question.sub && <p className="text-gray-600 mb-4">{question.sub}</p>}

        {question.type === 'mcq' && question.options && (
          <div className="space-y-3">
            {question.options.map((option, idx) => (
              <button
                key={idx}
                onClick={() => handleAnswer(idx)}
                className={`w-full p-3 text-left rounded-lg border-2 transition ${
                  answers[question.id] === idx
                    ? 'border-[#6366f1] bg-blue-50'
                    : 'border-gray-200 hover:border-gray-300'
                }`}
              >
                {option}
              </button>
            ))}
          </div>
        )}

        {(question.type === 'writing' || question.type === 'speaking') && (
          <textarea
            className="w-full p-3 border-2 border-gray-200 rounded-lg"
            rows="6"
            placeholder="Your answer here..."
            value={answers[question.id] || ''}
            onChange={(e) => handleAnswer(e.target.value)}
          />
        )}
      </div>

      <div className="flex gap-4 justify-between">
        <button
          onClick={handleNext}
          disabled={currentQuestion === testData.length - 1}
          className="px-6 py-2 bg-gray-300 rounded-lg disabled:opacity-50"
        >
          Next
        </button>
        {currentQuestion === testData.length - 1 && (
          <Link
            to="/analyzing"
            onClick={handleSubmit}
            className="px-6 py-2 bg-gradient-to-r from-[#6366f1] to-[#8b5cf6] text-white rounded-lg hover:shadow-lg"
          >
            Submit Test
          </Link>
        )}
      </div>
    </div>
  );
}
