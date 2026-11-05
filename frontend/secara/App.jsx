import { Routes, Route } from 'react-router-dom';

export default function App() {
  return (
    <div className="app-shell">
      <Routes>
        <Route path="/" element={<div className="placeholder">NANZ MUSIC — Home (belum dibuat)</div>} />
        <Route path="*" element={<div className="placeholder">404 — Halaman tidak ditemukan</div>} />
      </Routes>
    </div>
  );
}
