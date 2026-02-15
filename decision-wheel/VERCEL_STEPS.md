# Step-by-step: Deploy Decision Wheel on Vercel

Follow either **Path A** (with GitHub) or **Path B** (CLI only, no GitHub).

---

## Path A: Deploy with GitHub

### Step 1 – Create a Vercel account

1. Go to **[vercel.com](https://vercel.com)** and sign up (use **Continue with GitHub** so Step 3 is easier).

---

### Step 2 – Push your code to GitHub

1. On [github.com](https://github.com), create a **new repository** (e.g. `decision-wheel`). Do **not** add a README (you already have code).
2. On your computer, open a terminal in the **parent** of `decision-wheel` (e.g. `d:\Ai coding Toola`).
3. Run (replace `YOUR_USERNAME` and `decision-wheel` with your repo):

   ```bash
   cd "d:\Ai coding Toola\decision-wheel"
   git init
   git add .
   git commit -m "Initial commit"
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/decision-wheel.git
   git push -u origin main
   ```

---

### Step 3 – Import the project in Vercel

1. Go to **[vercel.com/new](https://vercel.com/new)** (or Dashboard → **Add New** → **Project**).
2. Under **Import Git Repository**, select your **decision-wheel** repo. Click **Import**.
3. **Project Name:** leave as `decision-wheel` (or change if you like).
4. **Root Directory:**  
   - If the repo **is** only the decision-wheel folder (you created the repo inside `decision-wheel`), leave **Root Directory** empty.  
   - If the repo is the whole “Ai coding Toola” folder and `decision-wheel` is inside it, click **Edit** next to Root Directory and set it to **`decision-wheel`**.
5. Do **not** add any env vars yet. Click **Deploy**.
6. Wait for the first deployment to finish. The site will work but **options will not persist** until you add KV (next step).

---

### Step 4 – Create and connect Vercel KV (so options are saved)

1. In Vercel, open your **decision-wheel** project.
2. Go to the **Storage** tab.
3. Click **Create Database** → choose **KV** (Vercel KV).
4. Name it (e.g. `decision-wheel-kv`) → **Create**.
5. On the new KV database page, click **Connect Project** (or **Connect to Project**).
6. Select your **decision-wheel** project and confirm. This adds the required env vars automatically.
7. Go to the **Deployments** tab, open the **⋮** menu on the latest deployment, and click **Redeploy** (so the new env vars are used). Wait for it to finish.

---

### Step 5 – Open your app

1. In the project, click **Visit** (or open the URL shown, e.g. `https://decision-wheel-xxx.vercel.app`).
2. Add options and spin the wheel. Options should now persist (saved in Vercel KV).

---

## Path B: Deploy with Vercel CLI (no GitHub)

### Step 1 – Create a Vercel account

1. Go to **[vercel.com](https://vercel.com)** and sign up.

---

### Step 2 – Install Vercel CLI and log in

In PowerShell (or your terminal):

```powershell
npm install -g vercel
vercel login
```

Follow the browser prompt to log in.

---

### Step 3 – Deploy from the decision-wheel folder

```powershell
cd "d:\Ai coding Toola\decision-wheel"
vercel
```

- **Set up and deploy?** → **Y**
- **Which scope?** → choose your account
- **Link to existing project?** → **N**
- **Project name?** → **decision-wheel** (or press Enter)
- **In which directory is your code?** → **./** (press Enter)

Wait for the upload and build. You’ll get a URL like `https://decision-wheel-xxx.vercel.app`. The app will load but **options won’t persist** until you add KV.

---

### Step 4 – Create and connect Vercel KV

1. Open **[vercel.com/dashboard](https://vercel.com/dashboard)** and select your **decision-wheel** project.
2. Go to the **Storage** tab.
3. Click **Create Database** → **KV**.
4. Name it (e.g. `decision-wheel-kv`) → **Create**.
5. On the KV database page, click **Connect Project** and select **decision-wheel**.
6. Go to **Deployments** → **⋮** on the latest deployment → **Redeploy**. Wait for it to finish.

---

### Step 5 – Open your app

Open the project URL (e.g. `https://decision-wheel-xxx.vercel.app`). Add options and spin; they should now be saved.

---

## Troubleshooting

| Issue | What to do |
|-------|------------|
| Options don’t save | Make sure KV is created and **connected to the project**, then **Redeploy** once. |
| 500 or “KV” errors | In project **Settings** → **Environment Variables**, check that KV-related vars are present (they appear when you connect the KV database). |
| Wrong root (blank page / 404) | If the repo contains more than `decision-wheel`, set **Root Directory** to `decision-wheel` and redeploy. |

---

## Summary

1. Sign up at Vercel.  
2. Either push code to GitHub and import, or run `vercel` in `decision-wheel`.  
3. Create a **KV** database and **Connect** it to the project.  
4. **Redeploy** once after connecting KV.  
5. Use your live URL; options will persist.
