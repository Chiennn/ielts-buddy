import { Link } from 'react-router-dom';

export default function ResultPage() {
  const mockResult = {
    cefr: 'B1',
    scores: {
      listening: 65,
      reading: 72,
      writing: 58,
      speaking: 61
    }
  };

  const SkillBar = ({ skill, score }) => (
    <div className="mb-4">
      <div className="flex justify-between mb-2">
        <span className="font-semibold capitalize">{skill}</span>
        <span className="text-[#6366f1]">{score}%</span>
      </div>
      <div className="w-full bg-gray-300 rounded-full h-3">
        <div
          className="bg-gradient-to-r from-[#6366f1] to-[#8b5cf6] h-3 rounded-full"
          style={{ width: `${score}%` }}
        ></div>
      </div>
    </div>
  );

  return (
    <div className="max-w-2xl mx-auto">
      <div className="bg-white rounded-lg shadow-lg p-8 mb-8">
        <h1 className="text-3xl font-bold text-center mb-8">Your Result</h1>

        <div className="text-center mb-8">
          <div className="text-6xl font-bold bg-gradient-to-r from-[#6366f1] to-[#8b5cf6] bg-clip-text text-transparent mb-2">
            {mockResult.cefr}
          </div>
          <p className="text-gray-600">Your CEFR Level</p>
        </div>

        <div className="mb-8">
          <h3 className="text-xl font-semibold mb-4">Skill Breakdown</h3>
          {Object.entries(mockResult.scores).map(([skill, score]) => (
            <SkillBar key={skill} skill={skill} score={score} />
          ))}
        </div>

        <div className="bg-blue-50 rounded-lg p-4 mb-8">
          <p className="text-center text-gray-700">
            Great job! Continue learning to improve your skills.
          </p>
        </div>

        <div className="flex gap-4 justify-center">
          <Link
            to="/welcome"
            className="px-6 py-2 bg-gray-300 rounded-lg hover:bg-gray-400 transition"
          >
            Back to Home
          </Link>
          <Link
            to="/test"
            className="px-6 py-2 bg-gradient-to-r from-[#6366f1] to-[#8b5cf6] text-white rounded-lg hover:shadow-lg transition"
          >
            Take Another Test
          </Link>
        </div>
      </div>
    </div>
  );
}
