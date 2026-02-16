# Decision Wheel

A full-stack **random picker / decision wheel** app. Add options, spin the wheel, and let it choose for you. Built with a modern dark UI and SVG wheel with labels.

---

## Live demo

**Try it here:** [https://latest-ai-coding-tools-b2hmtfabg-deep-dhaduks-projects.vercel.app](https://latest-ai-coding-tools-b2hmtfabg-deep-dhaduks-projects.vercel.app)

---

## Features

- Add, remove, and list options
- Spin the wheel to pick a random option
- Option names shown on the wheel segments
- Persistent storage (Vercel KV when deployed; JSON file when run locally)
- Responsive layout
- No sign-up required

---

## Run locally

```bash
cd decision-wheel
npm install
npm start
```

Open **http://localhost:3000** in your browser. Options are stored in `options.json` in the project folder.

---

## Deploy (free)

- **Vercel** — [Live app](https://latest-ai-coding-tools-dlit7dpyd-deep-dhaduks-projects.vercel.app/). See **[DEPLOY_VERCEL.md](DEPLOY_VERCEL.md)** or **[VERCEL_STEPS.md](VERCEL_STEPS.md)** for step-by-step deploy; uses Vercel KV for storage.
- **Firebase** — See **[DEPLOY.md](DEPLOY.md)** for Hosting + Cloud Functions + Firestore.

---

## Tech stack

| Layer    | Tech                    |
|----------|-------------------------|
| Frontend | HTML, CSS, vanilla JS   |
| Backend  | Node.js + Express       |
| Storage  | JSON file (local) / Vercel KV (Vercel) |

---

## API

| Method | Endpoint           | Description                    |
|--------|--------------------|--------------------------------|
| GET    | `/api/options`     | List all options              |
| POST   | `/api/options`     | Add option (`{ "text": "…" }`) |
| DELETE | `/api/options/:id` | Remove an option               |
| GET    | `/api/spin`        | Get a random option           |

---

## Project structure

```
decision-wheel/
├── public/           # Static frontend
│   ├── index.html
│   ├── style.css
│   └── app.js
├── api/              # Vercel serverless (for Vercel deploy)
├── server.js         # Express server (for local run)
├── package.json
├── vercel.json
└── README.md
```

---

Part of **Latest-Ai-Coding-Tools**. Built with Cursor (agentic AI).
