# Decision Wheel

A small full-stack **random picker / decision wheel**. Add options, spin the wheel, and let it choose for you. Options are saved in `options.json` so they persist between restarts.

## Run

```bash
cd decision-wheel
npm install
npm start
```

Open **http://localhost:3000** in your browser.

## Deploy (free)

- **Vercel** — See **[DEPLOY_VERCEL.md](DEPLOY_VERCEL.md)**. Uses Vercel KV for storage; free tier.
- **Firebase** — See **[DEPLOY.md](DEPLOY.md)** for Hosting + Cloud Functions + Firestore.

## Stack

- **Backend:** Node.js + Express
- **Storage:** JSON file (`options.json`)
- **Frontend:** HTML, CSS, vanilla JS

## API

- `GET /api/options` — list options
- `POST /api/options` — add option (`{ "text": "Pizza" }`)
- `DELETE /api/options/:id` — remove option
- `GET /api/spin` — get random option
