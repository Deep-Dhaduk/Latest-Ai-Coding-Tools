const { createClient } = require('@vercel/kv');

// Support default (KV_*) or custom-prefixed (e.g. STORAGE_KV_*) env vars from Vercel/Upstash
const url = process.env.KV_REST_API_URL || process.env.STORAGE_KV_REST_API_URL;
const token = process.env.KV_REST_API_TOKEN || process.env.STORAGE_KV_REST_API_TOKEN;
const kv = url && token ? createClient({ url, token }) : null;

module.exports = { kv };
