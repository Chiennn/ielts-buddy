import { Link } from 'react-router-dom';

export default function DashboardPage({ selectedLearner }) {
  if (!selectedLearner) {
    return <div className="text-center py-12">Please select a learner first</div>;
  }

  const mockProgress = {
    level: selectedLearner.cefrLevel || 'A1',
    xp: selectedLearner.xp || 0,
    streak: 7,
    tasksToday: 3
  };

  return (
    <div className="max-w-4xl mx-auto">
      <h1 className="text-3xl font-bold mb-8">Dashboard - {selectedLearner.name}</h1>

      <div className="grid grid-cols-1 md:grid-cols-4 gap-4 mb-8">
        <StatCard label="Current Level" value={mockProgress.level} />
        <StatCard label="XP Points" value={mockProgress.xp} />
        <StatCard label="Day Streak" value={mockProgress.streak} />
        <StatCard label="Today's Tasks" value={mockProgress.tasksToday} />
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
        <div className="bg-white rounded-lg shadow-lg p-6">
          <h2 className="text-xl font-semibold mb-4">Learning Progress</h2>
          <div className="space-y-3">
            {['Reading', 'Writing', 'Listening', 'Speaking'].map(skill => (
              <div key={skill}>
                <div className="flex justify-between mb-1">
                  <span className="text-sm font-medium">{skill}</span>
                  <span className="text-sm text-gray-600">65%</span>
                </div>
                <div className="w-full bg-gray-300 rounded-full h-2">
                  <div className="bg-gradient-to-r from-[#6366f1] to-[#8b5cf6] h-2 rounded-full" style={{ width: '65%' }}></div>
                </div>
              </div>
            ))}
          </div>
        </div>

        <div className="bg-white rounded-lg shadow-lg p-6">
          <h2 className="text-xl font-semibold mb-4">Today's Tasks</h2>
          <div className="space-y-3">
            <TaskItem title="Complete Reading Test" completed={true} />
            <TaskItem title="Practice Writing" completed={false} />
            <TaskItem title="Listen & Repeat" completed={false} />
          </div>
          <Link
            to="/test"
            className="mt-4 block w-full bg-gradient-to-r from-[#6366f1] to-[#8b5cf6] text-white text-center py-2 rounded-lg hover:shadow-lg transition"
          >
            Start Test
          </Link>
        </div>
      </div>
    </div>
  );
}

const StatCard = ({ label, value }) => (
  <div className="bg-white rounded-lg shadow-lg p-4 text-center">
    <p className="text-gray-600 text-sm mb-2">{label}</p>
    <p className="text-3xl font-bold bg-gradient-to-r from-[#6366f1] to-[#8b5cf6] bg-clip-text text-transparent">
      {value}
    </p>
  </div>
);

const TaskItem = ({ title, completed }) => (
  <div className="flex items-center gap-3 p-3 bg-gray-50 rounded-lg">
    <input
      type="checkbox"
      checked={completed}
      className="w-5 h-5 cursor-pointer"
      readOnly
    />
    <span className={completed ? 'line-through text-gray-500' : 'text-gray-700'}>
      {title}
    </span>
  </div>
);
