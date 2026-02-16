# MNIST Classifier (Keras)

A **neural network classifier** for the [MNIST](http://yann.lecun.com/exdb/mnist/) handwritten digits dataset. Built with **Keras (TensorFlow)**. Trains a CNN, evaluates on the test set, and saves loss/accuracy curves, a confusion matrix, and the trained model.

---

## Features

- **Model:** CNN with 2 convolutional layers (32 and 64 filters), max pooling, dropout (0.5), and a dense softmax output for 10 digit classes.
- **Training:** 10 epochs, batch size 128, 90% train / 10% validation split, Adam optimizer.
- **Outputs:**
  - **Loss and accuracy curves** (train vs validation) → `outputs/loss_accuracy_curves.png`
  - **Confusion matrix** (heatmap) → `outputs/confusion_matrix.png`
  - **Classification report** (precision, recall, F1 per class) → printed to console
  - **Per-class metrics table** → printed to console
  - **Saved model** → `outputs/mnist_model.keras`
- **Reproducibility:** Fixed random seeds for NumPy and TensorFlow.

---

## Prerequisites

- **Python 3.9+**
- pip (or conda)

---

## Setup

```bash
cd mnist_keras
python -m venv venv
```

**Windows (PowerShell):**
```powershell
.\venv\Scripts\activate
pip install -r requirements.txt
```

**macOS / Linux:**
```bash
source venv/bin/activate
pip install -r requirements.txt
```

---

## Run

```bash
python mnist_classifier.py
```

On first run, the MNIST dataset is downloaded automatically. Training and evaluation run in sequence; plots and the model are written to the `outputs` folder. Expect a few minutes depending on your hardware.

---

## Outputs

| File | Description |
|------|-------------|
| `outputs/loss_accuracy_curves.png` | Train/validation loss and accuracy vs epoch |
| `outputs/confusion_matrix.png` | Confusion matrix heatmap (digits 0–9) |
| `outputs/mnist_model.keras` | Saved Keras model (load with `keras.models.load_model(...)`) |

**Console:** Classification report, per-class precision/recall/F1/support, final test loss and accuracy.

---

## Project structure

```
mnist_keras/
├── mnist_classifier.py   # Load data, build model, train, evaluate, save plots & model
├── requirements.txt      # TensorFlow, NumPy, Matplotlib, scikit-learn, seaborn
├── outputs/              # Created on first run (curves, confusion matrix, model)
├── README.md
└── .gitignore
```

---

## Tech stack

| Layer | Technology |
|-------|------------|
| Framework | TensorFlow 2.x (Keras) |
| Data / metrics | NumPy, scikit-learn |
| Plotting | Matplotlib, Seaborn |

---

## Requirements (dependencies)

- `tensorflow>=2.15.0`
- `numpy>=1.24.0`
- `matplotlib>=3.7.0`
- `scikit-learn>=1.3.0`
- `seaborn>=0.13.0`

---

Part of **Latest-Ai-Coding-Tools**. Built with Cursor (agentic AI).
