const { kv } = require('@vercel/kv');

const KEY = 'wheel_options';

async function getOptions() {
  try {
    const data = await kv.get(KEY);
    return Array.isArray(data) ? data : [];
  } catch {
    return [];
  }
}

async function setOptions(options) {
  await kv.set(KEY, options);
}

module.exports = async function handler(req, res) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'DELETE, OPTIONS');
  if (req.method === 'OPTIONS') return res.status(200).end();

  if (req.method !== 'DELETE') return res.status(405).json({ error: 'Method not allowed' });

  const id = req.query.id;
  if (!id) return res.status(400).json({ error: 'ID required' });

  const options = await getOptions();
  const filtered = options.filter((o) => o.id !== id);
  if (filtered.length === options.length) return res.status(404).json({ error: 'Not found' });
  await setOptions(filtered);
  return res.json({ ok: true });
};
