# Deploy Decision Wheel on Vercel (free)

Yes — you can deploy the Decision Wheel on **Vercel’s free tier**. The app uses **Vercel KV** (free tier) to store options so they persist.

## 1. Prerequisites

- A [Vercel](https://vercel.com) account (free).
- Project code in a Git repo (GitHub, GitLab, or Bitbucket), or use Vercel CLI.

## 2. Add Vercel KV (free storage)

Options are stored in **Vercel KV** (Redis). Create a KV database:

1. Open [Vercel Dashboard](https://vercel.com/dashboard) → your project (or create one).
2. Go to **Storage** → **Create Database** → choose **KV**.
3. Name it (e.g. `decision-wheel-kv`) and create it.
4. In the database page, click **Connect to Project** and select your Decision Wheel project so the env vars are added automatically.

## 3. Deploy

### Option A: Deploy with Git

1. Push the `decision-wheel` project to GitHub (or GitLab/Bitbucket).
2. In Vercel: **Add New** → **Project** → import the repo.
3. Set **Root Directory** to `decision-wheel` if the repo root is the parent folder; otherwise leave default.
4. Deploy. Vercel will use `vercel.json` and the `api/` folder.

### Option B: Deploy with Vercel CLI

```bash
cd "d:\Ai coding Toola\decision-wheel"
npm i -g vercel
vercel login
vercel
```

Follow the prompts. Then link the KV database in the dashboard (Storage → your KV → Connect to Project).

## 4. After deploy

Your app will be at a URL like:

- `https://decision-wheel-xxx.vercel.app`

Open it and use the wheel; options are saved in Vercel KV.

## Free tier notes

- **Vercel:** Free tier includes plenty of serverless invocations and bandwidth for a small app.
- **Vercel KV:** Free tier includes a limited amount of storage and commands; the Decision Wheel stays within that.

No credit card needed for the free tier. You only need to add a card if you choose a paid plan later.

---

## Options not saving? (Database connection)

1. **Check env vars**  
   In Vercel: **Project** → **Settings** → **Environment Variables**. You should see **KV_REST_API_URL** and **KV_REST_API_TOKEN** (or **STORAGE_KV_REST_API_URL** / **STORAGE_KV_REST_API_TOKEN** if you used a custom prefix when connecting). If they’re missing, the project isn’t linked to the Redis store.

2. **Reconnect the store**  
   Go to **Storage** → open your **decisio-wheel** (Upstash Redis) store → **Connect Project** → select **latest-ai-coding-tools** and connect. Then **Redeploy** the project once.

3. **Redeploy**  
   **Deployments** → **⋮** on the latest deployment → **Redeploy**. New env vars only apply after a new deployment.

4. **Check runtime logs**  
   **Deployments** → open a deployment → **Runtime Logs**. Try adding an option in the app and see if any errors appear (e.g. connection or auth).
