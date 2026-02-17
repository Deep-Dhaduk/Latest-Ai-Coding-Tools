# 🚀 Quick Start Guide - Ocean AI Multimodal Explorer

## ⚡ 5-Minute Setup (Google Colab)

### Step 1: Open the Notebook
```
1. Go to https://colab.research.google.com/
2. Click "File" → "Upload notebook"
3. Upload "Ocean_AI_Multimodal_Explorer.ipynb"
   OR
   Use "File" → "Open notebook" → "GitHub" and paste your repo URL
```

---

### Step 2: Get Your Free Gemini API Key

1. **Visit Google AI Studio:**
   - Go to: https://makersuite.google.com/app/apikey
   - Sign in with your Google account

2. **Create API Key:**
   - Click "Create API Key"
   - Copy the key (looks like: `AIzaSy...`)

3. **Add to Colab Secrets:**
   - In Colab, look for the 🔑 key icon on the LEFT sidebar
   - Click it to open "Secrets"
   - Click "+ Add new secret"
   - Name: `GEMINI_API_KEY`
   - Value: Paste your API key
   - ✅ Enable "Notebook access" toggle

---

### Step 3: Run the Notebook

**Option A - Run All (Recommended):**
```
Click: Runtime → Run all
OR
Press: Ctrl+F9 (Windows/Linux) or Cmd+F9 (Mac)
```

**Option B - Run Cell by Cell:**
```
Click the ▶️ play button on each cell
OR
Press: Shift+Enter to run current cell and move to next
```

---

### Step 4: View Outputs

You'll see:
1. 🎨 **Coral Reef Image** (procedurally generated)
2. 🔬 **AI Analysis** of the image
3. 💬 **Conservation Discussion** (text-to-text)
4. 📊 **Marine Biodiversity Infographic**
5. 🤖 **Multi-turn Conversation** about ocean acidification

**Scroll down to see all outputs!**

---

## 🆓 Free Tier Limits (Gemini API)

| Plan | Rate Limit | Daily Quota |
|------|------------|-------------|
| Free | 15 requests/min | ~1,500 requests/day |

**Tips:**
- Wait 10-15 seconds between manual runs
- The notebook has built-in retry logic
- If quota exceeded, wait 15 minutes and try again

---

## 🐛 Common Issues & Solutions

### ❌ "API key not found"
**Problem:** Colab can't access your API key

**Solutions:**
1. Make sure you clicked "Notebook access" toggle in Secrets
2. Check spelling: Must be exactly `GEMINI_API_KEY`
3. Try restarting runtime: `Runtime → Restart runtime`
4. Double-check you added the secret to THIS notebook (not another one)

---

### ❌ "Rate limit exceeded"
**Problem:** Too many API calls too quickly

**Solutions:**
1. Wait 10-15 minutes before running again
2. Don't run the notebook multiple times rapidly
3. Check your [API usage](https://makersuite.google.com/app/apikey) dashboard
4. The notebook will use fallback content automatically - this is OK!

---

### ❌ "Model not found (404)"
**Problem:** The specific model isn't available in your region

**Solutions:**
- Don't worry! The notebook automatically tries alternative models
- You'll see: `Model gemini-xxx not available (404)` then `trying next...`
- This is normal behavior, let it continue

---

### ❌ Images not displaying
**Problem:** Visualizations don't show up

**Solutions:**
1. **Run cells in order** (top to bottom)
2. Make sure you ran the imports cell first
3. Try: `Runtime → Restart and run all`
4. Check if matplotlib imported correctly

---

### ❌ "No module named 'google.generativeai'"
**Problem:** Dependencies not installed

**Solutions:**
1. Make sure the **first code cell** ran successfully (installs packages)
2. Look for: `!pip install -q google-generativeai...`
3. If it failed, manually run: `!pip install google-generativeai`

---

## 💡 Pro Tips

### 1. **Save Your Work**
```
File → Save a copy in Drive
```
This saves your version with outputs!

### 2. **Download Generated Images**
Left sidebar → Files → Right-click image → Download

Files to download:
- `coral_reef_scene.png`
- `marine_biodiversity_infographic.png`

### 3. **Customize Prompts**
Find cells with:
```python
prompt = """
Your custom prompt here...
"""
```
Change the text to get different AI responses!

### 4. **Speed Up Execution**
Change model preference in helper functions:
```python
models = ['gemini-1.5-flash', ...]  # Flash is fastest & cheapest
```

### 5. **Run Without API**
If you don't want to use API (or hit quota):
- Just run the notebook as-is
- It will use fallback content (pre-written educational text)
- You'll still see all visualizations!

---

## 📊 What Each Part Does

| Part | What It Does | Runtime |
|------|--------------|---------|
| **Part 1** | Generates coral reef image | ~5 seconds |
| **Part 2** | AI analyzes the image | ~10 seconds |
| **Part 3** | AI discusses ocean conservation | ~10 seconds |
| **Part 4** | Creates infographic | ~3 seconds |
| **Part 5** | Multi-turn conversation | ~15 seconds |

**Total Runtime:** ~45 seconds (with API) or ~10 seconds (without API)

---

## 🎯 Learning Objectives Checklist

After running this notebook, you should understand:

- [ ] How to set up and use Google Colab
- [ ] How to work with API keys securely
- [ ] How multimodal AI processes images and text
- [ ] How to generate images with NumPy/Matplotlib
- [ ] How to call vision AI APIs (Gemini)
- [ ] Error handling and retry logic
- [ ] How to create data visualizations
- [ ] Multi-turn conversational AI
- [ ] Marine biology and conservation basics

---

## 🔄 Next Steps After Completion

### Experiment with Modifications:

1. **Change Colors:**
```python
# In coral generation section, modify:
coral_positions = [
    (250, 500, 120, [255, 100, 150]),  # Change RGB values!
]
```

2. **Add More Corals:**
```python
# Add new positions:
coral_positions = [
    # ... existing corals
    (100, 450, 95, [200, 255, 100]),  # New green coral
]
```

3. **Modify AI Prompts:**
```python
analysis_prompt = """
Focus specifically on climate change impacts...
"""
```

4. **Upload Your Own Images:**
```python
from google.colab import files
uploaded = files.upload()
my_image = PIL.Image.open(list(uploaded.keys())[0])
# Then analyze with AI!
```

---

## 📚 Resources for Learning More

### Multimodal AI:
- [Gemini API Docs](https://ai.google.dev/docs) - Official documentation
- [Colab Tutorials](https://colab.research.google.com/notebooks/) - Official Colab guides

### Python Libraries:
- [NumPy Quickstart](https://numpy.org/doc/stable/user/quickstart.html)
- [Matplotlib Gallery](https://matplotlib.org/stable/gallery/index.html)
- [PIL/Pillow Handbook](https://pillow.readthedocs.io/)

### Marine Science:
- [NOAA Ocean Exploration](https://oceanexplorer.noaa.gov/)
- [Allen Coral Atlas](https://allencoralatlas.org/)

---

## 🎓 Assignment Ideas (For Students)

### Beginner:
1. Change all colors to your favorite palette
2. Add 2 more coral formations
3. Modify one AI prompt

### Intermediate:
4. Add a new chart to the infographic
5. Create a different underwater scene (kelp forest, deep sea)
6. Analyze an image you upload

### Advanced:
7. Add real-time user input for prompts
8. Integrate a second API (e.g., weather data)
9. Create an interactive widget with ipywidgets
10. Add video frame analysis

---

## ❓ Getting Help

**If you're stuck:**

1. **Read error messages carefully** - they usually tell you exactly what's wrong
2. **Check the [Troubleshooting section](#common-issues--solutions)**
3. **Google the error message** with "colab" or "gemini api"
4. **Ask on Stack Overflow** with tags: `google-colab`, `gemini-api`, `python`

**Useful Search Queries:**
```
"google colab secrets not working"
"gemini api rate limit how long"
"matplotlib not displaying images colab"
```

---

## ✅ Final Checklist Before Submission

If you're submitting this for a class:

- [ ] Notebook runs completely from top to bottom
- [ ] All outputs are visible
- [ ] You've added personal modifications (colors, prompts, etc.)
- [ ] Images are saved and included
- [ ] You've documented YOUR changes in markdown cells
- [ ] You understand what each part does (can explain it)
- [ ] Proper citations added if required

---

## 🎉 You're Ready!

Click `Runtime → Run all` and watch the magic happen! 🌊✨

**Enjoy exploring multimodal AI and ocean science!**

---

*Questions? Check README.md or COMPARISON.md for more details*
