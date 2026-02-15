const express = require('express');
const path = require('path');
const fs = require('fs');

const app = express();
const PORT = process.env.PORT || 3000;
const DATA_FILE = path.join(__dirname, 'options.json');

app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));

function readOptions() {
  try {
    const data = fs.readFileSync(DATA_FILE, 'utf8');
    return JSON.parse(data);
  } catch {
    return [];
  }
}

function writeOptions(options) {
  fs.writeFileSync(DATA_FILE, JSON.stringify(options, null, 2), 'utf8');
}

// GET all options
app.get('/api/options', (req, res) => {
  res.json(readOptions());
});

// POST add option
app.post('/api/options', (req, res) => {
  const text = (req.body.text || '').trim();
  if (!text) return res.status(400).json({ error: 'Text is required' });
  const options = readOptions();
  const id = Date.now().toString(36) + Math.random().toString(36).slice(2);
  options.push({ id, text });
  writeOptions(options);
  res.status(201).json({ id, text });
});

// DELETE option
app.delete('/api/options/:id', (req, res) => {
  let options = readOptions();
  const before = options.length;
  options = options.filter(o => o.id !== req.params.id);
  if (options.length === before) return res.status(404).json({ error: 'Not found' });
  writeOptions(options);
  res.json({ ok: true });
});

// GET random pick (spin)
app.get('/api/spin', (req, res) => {
  const options = readOptions();
  if (options.length === 0) return res.status(400).json({ error: 'Add at least one option first' });
  const pick = options[Math.floor(Math.random() * options.length)];
  res.json(pick);
});

app.listen(PORT, () => console.log(`Decision Wheel running at http://localhost:${PORT}`));
