import { Link } from 'react-router-dom';

export default function WelcomePage({ learners, setSelectedLearner }) {
  return (
    <div className="text-center py-12">
      <h1 className="text-4xl font-bold mb-4 bg-gradient-to-r from-[#6366f1] to-[#8b5cf6] bg-clip-text text-transparent">
        Welcome to IELTS Buddy
      </h1>
      <p className="text-lg text-gray-600 mb-8">Master English & Ace Your IELTS</p>

      <div className="bg-white rounded-lg shadow-lg p-8 max-w-2xl mx-auto mb-8">
        <h2 className="text-2xl font-semibold mb-6">Select Learner</h2>
        {learners.length === 0 ? (
          <p className="text-gray-500">No learners found</p>
        ) : (
          <div className="grid gap-4">
            {learners.map(learner => (
              <button
                key={learner.id}
                onClick={() => setSelectedLearner(learner)}
                className="p-4 bg-gradient-to-r from-[#6366f1] to-[#8b5cf6] text-white rounded-lg hover:shadow-lg transition"
              >
                {learner.name} (Grade {learner.grade})
              </button>
            ))}
          </div>
        )}
      </div>

      <Link
        to="/test"
        className="inline-block bg-gradient-to-r from-[#6366f1] to-[#8b5cf6] text-white px-8 py-3 rounded-lg hover:shadow-lg transition"
      >
        Start Test
      </Link>
    </div>
  );
}
