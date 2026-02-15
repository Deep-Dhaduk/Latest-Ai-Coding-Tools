"""
MNIST classifier using Keras with full training and evaluation metrics.
Generates: loss/accuracy curves, confusion matrix, classification report,
per-class metrics, and model save.
"""
import os
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.metrics import (
    confusion_matrix,
    classification_report,
    accuracy_score,
    precision_recall_fscore_support,
)
import tensorflow as tf
from tensorflow import keras
from tensorflow.keras import layers

# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------
RANDOM_SEED = 42
BATCH_SIZE = 128
EPOCHS = 10
IMG_ROWS, IMG_COLS = 28, 28
NUM_CLASSES = 10
OUTPUT_DIR = "outputs"
os.makedirs(OUTPUT_DIR, exist_ok=True)

np.random.seed(RANDOM_SEED)
tf.random.set_seed(RANDOM_SEED)


def load_and_preprocess():
    """Load MNIST and normalize to [0, 1]."""
    (x_train, y_train), (x_test, y_test) = keras.datasets.mnist.load_data()
    x_train = x_train.astype("float32") / 255.0
    x_test = x_test.astype("float32") / 255.0
    x_train = np.expand_dims(x_train, -1)  # (N, 28, 28, 1)
    x_test = np.expand_dims(x_test, -1)
    y_train = keras.utils.to_categorical(y_train, NUM_CLASSES)
    y_test_cat = keras.utils.to_categorical(y_test, NUM_CLASSES)
    return (x_train, y_train), (x_test, y_test_cat), y_test  # y_test for labels


def build_model():
    """CNN for MNIST."""
    model = keras.Sequential([
        layers.Input(shape=(IMG_ROWS, IMG_COLS, 1)),
        layers.Conv2D(32, kernel_size=(3, 3), activation="relu"),
        layers.MaxPooling2D(pool_size=(2, 2)),
        layers.Conv2D(64, kernel_size=(3, 3), activation="relu"),
        layers.MaxPooling2D(pool_size=(2, 2)),
        layers.Flatten(),
        layers.Dropout(0.5),
        layers.Dense(NUM_CLASSES, activation="softmax"),
    ])
    model.compile(
        optimizer="adam",
        loss="categorical_crossentropy",
        metrics=["accuracy"],
    )
    return model


def plot_history(history, save_path):
    """Plot training/validation loss and accuracy."""
    fig, axes = plt.subplots(1, 2, figsize=(12, 4))
    epochs_range = range(1, len(history.history["loss"]) + 1)

    axes[0].plot(epochs_range, history.history["loss"], label="Train Loss", marker="o", markersize=4)
    axes[0].plot(epochs_range, history.history["val_loss"], label="Val Loss", marker="s", markersize=4)
    axes[0].set_xlabel("Epoch")
    axes[0].set_ylabel("Loss")
    axes[0].set_title("Loss curves")
    axes[0].legend()
    axes[0].grid(True, alpha=0.3)

    axes[1].plot(epochs_range, history.history["accuracy"], label="Train Accuracy", marker="o", markersize=4)
    axes[1].plot(epochs_range, history.history["val_accuracy"], label="Val Accuracy", marker="s", markersize=4)
    axes[1].set_xlabel("Epoch")
    axes[1].set_ylabel("Accuracy")
    axes[1].set_title("Accuracy curves")
    axes[1].legend()
    axes[1].grid(True, alpha=0.3)

    plt.tight_layout()
    plt.savefig(save_path, dpi=150, bbox_inches="tight")
    plt.close()
    print(f"Saved: {save_path}")


def plot_confusion_matrix(y_true, y_pred, save_path):
    """Plot and save confusion matrix."""
    cm = confusion_matrix(y_true, y_pred)
    plt.figure(figsize=(10, 8))
    sns.heatmap(
        cm,
        annot=True,
        fmt="d",
        cmap="Blues",
        xticklabels=range(10),
        yticklabels=range(10),
        square=True,
        cbar_kws={"shrink": 0.8},
    )
    plt.xlabel("Predicted")
    plt.ylabel("True")
    plt.title("Confusion Matrix (MNIST)")
    plt.tight_layout()
    plt.savefig(save_path, dpi=150, bbox_inches="tight")
    plt.close()
    print(f"Saved: {save_path}")


def print_metrics(y_true, y_pred):
    """Print accuracy, classification report, and per-class metrics."""
    acc = accuracy_score(y_true, y_pred)
    print("\n" + "=" * 60)
    print("OVERALL ACCURACY: {:.4f} ({:.2f}%)".format(acc, acc * 100))
    print("=" * 60)

    print("\n--- Classification Report ---")
    print(classification_report(y_true, y_pred, digits=4, target_names=[str(i) for i in range(10)]))

    precision, recall, f1, support = precision_recall_fscore_support(y_true, y_pred, average=None)
    print("\n--- Per-class metrics ---")
    print(f"{'Class':<8} {'Precision':<12} {'Recall':<12} {'F1-Score':<12} {'Support':<10}")
    print("-" * 54)
    for i in range(10):
        print(f"{i:<8} {precision[i]:<12.4f} {recall[i]:<12.4f} {f1[i]:<12.4f} {int(support[i]):<10}")
    print("-" * 54)


def main():
    print("Loading MNIST...")
    (x_train, y_train), (x_test, y_test_cat), y_test_labels = load_and_preprocess()
    print(f"Train: {x_train.shape[0]}, Test: {x_test.shape[0]}")

    model = build_model()
    model.summary()

    print("\nTraining...")
    history = model.fit(
        x_train,
        y_train,
        batch_size=BATCH_SIZE,
        epochs=EPOCHS,
        validation_split=0.1,
        verbose=1,
    )

    # Training metrics plots
    plot_history(history, os.path.join(OUTPUT_DIR, "loss_accuracy_curves.png"))

    # Predictions
    y_pred_proba = model.predict(x_test, verbose=0)
    y_pred = np.argmax(y_pred_proba, axis=1)

    # Confusion matrix
    plot_confusion_matrix(y_test_labels, y_pred, os.path.join(OUTPUT_DIR, "confusion_matrix.png"))

    # Text metrics
    print_metrics(y_test_labels, y_pred)

    # Save model
    model_path = os.path.join(OUTPUT_DIR, "mnist_model.keras")
    model.save(model_path)
    print(f"\nModel saved: {model_path}")

    # Final evaluation
    test_loss, test_acc = model.evaluate(x_test, y_test_cat, verbose=0)
    print("\n--- Final test set ---")
    print(f"Test loss: {test_loss:.4f}")
    print(f"Test accuracy: {test_acc:.4f} ({test_acc*100:.2f}%)")
    print("\nDone. Check the 'outputs' folder for plots and saved model.")


if __name__ == "__main__":
    main()
