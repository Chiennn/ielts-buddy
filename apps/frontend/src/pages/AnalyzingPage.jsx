import { useEffect } from 'react';

export default function AnalyzingPage() {
  useEffect(() => {
    async function scoreAttempt() {
      try {
        const attemptId = localStorage.getItem('attemptId');
        if (!attemptId) {
          console.error('No attempt ID found');
          return;
        }

        const API_URL = import.meta.env.VITE_API_URL;
        const res = await fetch(`${API_URL}/api/attempts/${attemptId}/score`);

        if (res.ok) {
          window.location.href = '/result';
        }
      } catch (error) {
        console.error('Error scoring test:', error);
      }
    }

    scoreAttempt();
  }, []);

  return (
    <div className="text-center py-20">
      <div className="inline-block">
        <div className="animate-spin rounded-full h-16 w-16 border-b-2 border-[#6366f1] mb-4"></div>
        <h2 className="text-2xl font-semibold mb-2">Analyzing Your Test</h2>
        <p className="text-gray-600">Scoring your answers with AI... Please wait</p>
      </div>
    </div>
  );
}
