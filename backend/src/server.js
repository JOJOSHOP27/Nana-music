import 'dotenv/config';
import express from 'express';
import cors from 'cors';

const app = express();
const PORT = process.env.PORT || 4000;

app.use(cors({ origin: process.env.CORS_ORIGIN || '*' }));
app.use(express.json({ limit: '2mb' }));

// Health check
app.get('/api/health', (_req, res) => {
  res.json({ status: 'ok', service: 'nanz-music-backend', time: new Date().toISOString() });
});

// Rute fitur akan didaftarkan di sini pada tahap berikutnya.
// app.use('/api/auth', authRoutes);
// app.use('/api/music', musicRoutes);
// app.use('/api/playlists', playlistRoutes);

// 404 handler
app.use((_req, res) => res.status(404).json({ error: 'Endpoint tidak ditemukan' }));

// Error handler
app.use((err, _req, res, _next) => {
  console.error('[ERROR]', err);
  res.status(err.status || 500).json({ error: err.message || 'Internal server error' });
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`NANZ MUSIC backend berjalan di http://0.0.0.0:${PORT}`);
});
