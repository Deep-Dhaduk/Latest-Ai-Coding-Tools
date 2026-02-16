const { kv } = require('./lib/kv');

const KEY = 'wheel_options';

module.exports = async function handler(req, res) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  if (req.method !== 'GET') return res.status(405).json({ error: 'Method not allowed' });

  let options;
  if (!kv) {
    options = [];
  } else {
    try {
      const data = await kv.get(KEY);
      options = Array.isArray(data) ? data : [];
    } catch {
      options = [];
    }
  }

  if (options.length === 0) return res.status(400).json({ error: 'Add at least one option first' });
  const pick = options[Math.floor(Math.random() * options.length)];
  return res.json(pick);
};
