export default function AnalyzingPage() {
  return (
    <div className="text-center py-20">
      <div className="inline-block">
        <div className="animate-spin rounded-full h-16 w-16 border-b-2 border-[#6366f1] mb-4"></div>
        <h2 className="text-2xl font-semibold mb-2">Analyzing Your Test</h2>
        <p className="text-gray-600">Ollama is scoring your answers... Please wait</p>
      </div>
    </div>
  );
}
