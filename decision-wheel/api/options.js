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
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
  if (req.method === 'OPTIONS') return res.status(200).end();

  if (req.method === 'GET') {
    const options = await getOptions();
    return res.json(options);
  }

  if (req.method === 'POST') {
    const text = (req.body?.text || '').trim();
    if (!text) return res.status(400).json({ error: 'Text is required' });
    const options = await getOptions();
    const id = Date.now().toString(36) + Math.random().toString(36).slice(2);
    options.push({ id, text });
    await setOptions(options);
    return res.status(201).json({ id, text });
  }

  return res.status(405).json({ error: 'Method not allowed' });
};
