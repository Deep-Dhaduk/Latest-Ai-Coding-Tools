const express = require('express');
const admin = require('firebase-admin');

const app = express();
app.use(express.json());

const COLLECTION = 'options';

async function getOptions() {
  const snap = await admin.firestore().collection(COLLECTION).orderBy('createdAt').get();
  return snap.docs.map((d) => ({ id: d.id, text: d.data().text }));
}

// GET all options
app.get('/api/options', async (req, res) => {
  try {
    const options = await getOptions();
    res.json(options);
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: 'Failed to load options' });
  }
});

// POST add option
app.post('/api/options', async (req, res) => {
  const text = (req.body.text || '').trim();
  if (!text) return res.status(400).json({ error: 'Text is required' });
  try {
    const id = Date.now().toString(36) + Math.random().toString(36).slice(2);
    await admin.firestore().collection(COLLECTION).doc(id).set({
      text,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });
    res.status(201).json({ id, text });
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: 'Failed to add option' });
  }
});

// DELETE option
app.delete('/api/options/:id', async (req, res) => {
  try {
    const ref = admin.firestore().collection(COLLECTION).doc(req.params.id);
    const doc = await ref.get();
    if (!doc.exists) return res.status(404).json({ error: 'Not found' });
    await ref.delete();
    res.json({ ok: true });
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: 'Failed to delete' });
  }
});

// GET random pick (spin)
app.get('/api/spin', async (req, res) => {
  try {
    const options = await getOptions();
    if (options.length === 0) return res.status(400).json({ error: 'Add at least one option first' });
    const pick = options[Math.floor(Math.random() * options.length)];
    res.json(pick);
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: 'Failed to spin' });
  }
});

module.exports = app;
