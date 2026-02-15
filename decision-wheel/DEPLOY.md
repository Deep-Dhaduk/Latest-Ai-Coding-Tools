# Deploy Decision Wheel (Firebase – free tier)

Your app is set up to deploy to **Firebase Hosting** (frontend) + **Cloud Functions** (API) + **Firestore** (data). All have free tiers.

## Prerequisites

- Node.js 18+
- A Google account
- [Firebase CLI](https://firebase.google.com/docs/cli) installed:

  ```bash
  npm install -g firebase-tools
  ```

## 1. Login

```bash
firebase login
```

## 2. Create a Firebase project (if you don’t have one)

- Open **[Firebase Console](https://console.firebase.google.com/)** and sign in.
- Click **Add project** (or **Create a project**).
- Enter a name (e.g. `decision-wheel-app`) and finish the wizard.

You need at least one project. If you already have one, skip to step 3.

## 3. Link the project to this folder

From the **decision-wheel** folder, set the project **by ID** (avoids the interactive menu that can fail on Windows):

```bash
cd "d:\Ai coding Toola\decision-wheel"
firebase use YOUR_PROJECT_ID
```

Replace `YOUR_PROJECT_ID` with your project’s ID (e.g. `decision-wheel-app`). You can see it in Firebase Console in **Project settings** (gear icon) → **Project ID**.

If the interactive menu works for you, you can instead run:

```bash
firebase use --add
```

and pick the project. If you see *“No selectable choices. All choices are disabled”*, use `firebase use YOUR_PROJECT_ID` as above.

## 4. Enable Firestore and Blaze (pay-as-you-go) for Functions

Do both of these in the [Firebase Console](https://console.firebase.google.com/) with your project open.

### 4a. Enable Firestore

1. In the left sidebar, click **Build** → **Firestore Database**.
2. Click **Create database**.
3. Choose **Start in test mode** (you can tighten rules later). Click **Next**.
4. Pick a Firestore location (e.g. `us-central1` or one near you). Click **Enable**.
5. Wait until the database is ready (you’ll see an empty “Data” tab).

### 4b. Enable Blaze (for Cloud Functions)

1. In the left sidebar, click **Build** → **Functions**.
2. If you see **Upgrade project** or **Modify plan**, click it and choose **Blaze (Pay as you go)**.
3. Add a billing account if asked (you can add a card; you won’t be charged for normal use within free quotas).
4. Finish the upgrade. You only pay if you go over the free tier limits.

## 5. Install dependencies and deploy

```bash
cd "d:\Ai coding Toola\decision-wheel"
npm install
cd functions
npm install
cd ..
firebase deploy
```

## 6. Open the app

After deploy, the CLI prints your Hosting URL, for example:

- `https://decision-wheel-app.web.app`  
- or `https://decision-wheel-app.firebaseapp.com`

Open that URL in your browser. The wheel and API will work with data stored in Firestore.

---

## Optional: Lock down Firestore

In Firebase Console → **Firestore → Rules**, you can later replace the default rules with something like:

- Only allow read/write if the request is from your app (e.g. via App Check) or restrict by field. For a small assignment, test mode is often enough.

---

## Other free backends (alternatives)

If you prefer not to use Firebase:

- **Vercel** – Deploy the `public` folder as a static site and the API as [Vercel Serverless Functions](https://vercel.com/docs/functions).
- **Render** – Create a **Web Service** and connect your repo; Render runs `npm start` (your current Express server). No code changes; use a small DB or keep the JSON file (ephemeral on free tier).
- **Railway** – Similar to Render; free tier can run the existing Node app.

The project is already wired for **Firebase**; use the steps above to deploy there.
