import { useEffect, useState } from 'react';
import { BrowserRouter as Router, Routes, Route, Link, useLocation } from 'react-router-dom';
import WelcomePage from './pages/WelcomePage';
import TestPage from './pages/TestPage';
import AnalyzingPage from './pages/AnalyzingPage';
import ResultPage from './pages/ResultPage';
import DashboardPage from './pages/DashboardPage';

const App = () => {
  const [selectedLearner, setSelectedLearner] = useState(null);
  const [testData, setTestData] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function fetchData() {
      try {
        const learnerRes = await fetch('http://localhost:5000/api/learners');
        const testRes = await fetch('http://localhost:5000/api/questions?level=A2');

        if (!learnerRes.ok || !testRes.ok) throw new Error('Failed to fetch');

        const learners = await learnerRes.json();
        const questions = await testRes.json();

        setSelectedLearner(learners[0] || null);
        setTestData(questions);
      } catch (error) {
        console.error('Error fetching data:', error);
      } finally {
        setLoading(false);
      }
    }

    fetchData();
  }, []);

  return (
    <Router>
      <div className="flex flex-col min-h-screen bg-[#eef0f7] text-[#1e293b]">
        <Header />
        <main className="flex-grow container mx-auto px-4 py-8">
          {loading ? (
            <div className="text-center py-20">Loading...</div>
          ) : (
            <Routes>
              <Route path="/" element={<WelcomePage learners={selectedLearner ? [selectedLearner] : []} setSelectedLearner={setSelectedLearner} />} />
              <Route path="/welcome" element={<WelcomePage learners={selectedLearner ? [selectedLearner] : []} setSelectedLearner={setSelectedLearner} />} />
              <Route path="/test" element={<TestPage selectedLearner={selectedLearner} testData={testData} />} />
              <Route path="/analyzing" element={<AnalyzingPage />} />
              <Route path="/result" element={<ResultPage />} />
              <Route path="/dashboard" element={<DashboardPage selectedLearner={selectedLearner} />} />
            </Routes>
          )}
        </main>
        <Footer />
      </div>
    </Router>
  );
};

const Header = () => {
  const location = useLocation();

  const isActive = (path) => location.pathname === path;

  return (
    <header className="bg-gradient-to-r from-[#6366f1] to-[#8b5cf6] text-white shadow-lg">
      <div className="container mx-auto px-4 py-4 flex items-center justify-between">
        <Link to="/" className="text-2xl font-bold">IELTS Buddy</Link>
        <nav className="flex gap-6">
          {[
            { path: '/welcome', label: 'Welcome' },
            { path: '/test', label: 'Test' },
            { path: '/dashboard', label: 'Dashboard' }
          ].map(({ path, label }) => (
            <Link
              key={path}
              to={path}
              className={`hover:text-gray-200 transition ${isActive(path) ? 'border-b-2 pb-1' : ''}`}
            >
              {label}
            </Link>
          ))}
        </nav>
      </div>
    </header>
  );
};

const Footer = () => (
  <footer className="bg-[#1e293b] text-white py-4 mt-12">
    <div className="container mx-auto px-4 text-center text-sm">
      © 2026 IELTS Buddy. All rights reserved.
    </div>
  </footer>
);

export default App;
