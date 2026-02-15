# MNIST Classifier (Keras)

Neural network classifier for the MNIST handwritten digits dataset using Keras (TensorFlow), with full training and evaluation metrics.

## What it does

- **Model:** CNN (2 conv + pool layers, dropout, dense softmax).
- **Training:** 10 epochs, 90% train / 10% validation split, Adam optimizer.
- **Metrics generated:**
  - **Loss and accuracy curves** (train vs validation) → `outputs/loss_accuracy_curves.png`
  - **Confusion matrix** (heatmap) → `outputs/confusion_matrix.png`
  - **Classification report** (precision, recall, F1 per class, printed to console)
  - **Per-class metrics table** (precision, recall, F1, support, printed to console)
  - **Final test loss and accuracy** (printed)
  - **Saved model** → `outputs/mnist_model.keras`

## Setup

```bash
cd "d:\Ai coding Toola\mnist_keras"
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
```

## Run

```bash
python mnist_classifier.py
```

On first run, MNIST will be downloaded. Training and evaluation run automatically; plots and the model are written to the `outputs` folder.

## Outputs

| File | Description |
|------|-------------|
| `outputs/loss_accuracy_curves.png` | Train/val loss and accuracy vs epoch |
| `outputs/confusion_matrix.png` | Confusion matrix heatmap |
| `outputs/mnist_model.keras` | Saved Keras model |

Console: classification report, per-class metrics, final test loss/accuracy.

## Requirements

- Python 3.9+
- TensorFlow (Keras), NumPy, Matplotlib, scikit-learn, seaborn
