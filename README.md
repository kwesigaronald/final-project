# 🍅 Tomato Disease Detection — Final Year Project

A deep learning-based system for detecting diseases in tomato plants from leaf images. The project consists of a Jupyter Notebook for model training and experimentation, a dataset of tomato leaf images, and a cross-platform mobile application (Flutter/Dart) for real-time disease prediction.

---

## 📋 Table of Contents

- [Project Summary](#project-summary)
- [Repository Structure](#repository-structure)
- [Prerequisites](#prerequisites)
- [Setup Instructions](#setup-instructions)
  - [1. Clone the Repository](#1-clone-the-repository)
  - [2. Set Up the Python Environment](#2-set-up-the-python-environment)
  - [3. Set Up the Flutter Mobile App](#3-set-up-the-flutter-mobile-app)
- [Reproducing Results](#reproducing-results)
- [Mobile App Usage](#mobile-app-usage)
- [Tech Stack](#tech-stack)

---

## Project Summary

Tomato crops are highly susceptible to a variety of diseases that can devastate yields if left undetected. This project builds a Convolutional Neural Network (CNN) classifier trained on labelled tomato leaf images to identify diseases early and accurately.

The trained model is deployed inside a Flutter mobile application, enabling farmers and agricultural extension workers to snap a photo of a tomato leaf and receive an instant disease diagnosis — without needing internet connectivity after the model is loaded.

**Key goals:**
- Train a CNN model to classify tomato leaf diseases from images.
- Evaluate model performance (accuracy, loss, confusion matrix).
- Package the trained model for mobile inference.
- Build a Flutter app that runs inference on-device.

---

## Repository Structure

```
final-project/
├── FinalProject.ipynb        # Model training, evaluation & experimentation notebook
├── tomato_images/            # Dataset of tomato leaf images (organised by class)
└── app/
    └── tomato_disease/       # Flutter mobile application
        ├── lib/              # Dart source code
        ├── android/          # Android platform files
        ├── ios/              # iOS platform files
        └── pubspec.yaml      # Flutter dependencies
```

---

## Prerequisites

### For the Notebook (Model Training)

- Python 3.8+
- pip or conda
- Jupyter Notebook or JupyterLab
- GPU recommended (CUDA-compatible) for faster training

### For the Mobile App

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (stable channel, 3.x+)
- Dart SDK (bundled with Flutter)
- Android Studio or Xcode (for device/emulator deployment)
- A physical device or emulator

---

## Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/kwesigaronald/final-project.git
cd final-project
```

### 2. Set Up the Python Environment

**Create and activate a virtual environment:**

```bash
python -m venv venv
source venv/bin/activate        # On Windows: venv\Scripts\activate
```

**Install required packages:**

```bash
pip install tensorflow numpy matplotlib scikit-learn pillow jupyter
```

> If you have a CUDA-compatible GPU, install the GPU version of TensorFlow:
> ```bash
> pip install tensorflow-gpu
> ```

**Launch Jupyter:**

```bash
jupyter notebook FinalProject.ipynb
```

### 3. Set Up the Flutter Mobile App

**Navigate to the app directory:**

```bash
cd app/tomato_disease
```

**Get Flutter dependencies:**

```bash
flutter pub get
```

**Run the app on a connected device or emulator:**

```bash
flutter run
```

> To build a release APK for Android:
> ```bash
> flutter build apk --release
> ```

---

## Reproducing Results

Follow these steps in order inside `FinalProject.ipynb`:

1. **Data Loading & Exploration**
   - The notebook reads images from the `tomato_images/` directory.
   - Ensure the folder is in the project root before running.
   - Run the data loading cells to inspect class distribution and sample images.

2. **Data Preprocessing**
   - Images are resized, normalised, and split into training, validation, and test sets.
   - Run all preprocessing cells sequentially.

3. **Model Definition**
   - A CNN architecture is defined using TensorFlow/Keras.
   - Run the model definition cells to instantiate the model.

4. **Model Training**
   - Training is performed with the configured hyperparameters (epochs, batch size, learning rate).
   - Run the training cell — this may take several minutes depending on your hardware.

5. **Evaluation**
   - After training, run the evaluation cells to generate:
     - Training/validation accuracy and loss curves
     - Test set accuracy
     - Confusion matrix
     - Classification report (precision, recall, F1-score per class)

6. **Model Export**
   - Run the export cell to save the trained model (e.g., as a `.tflite` file) for use in the mobile app.
   - Place the exported model file in `app/tomato_disease/assets/` if you wish to update the app.

> **Note:** Random seeds may be set in the notebook for reproducibility. If results vary slightly between runs, ensure the seed cells are executed before training.

---

## Mobile App Usage

1. Launch the app on your device (`flutter run`).
2. Tap the camera or gallery button to select a tomato leaf image.
3. The app runs on-device inference using the bundled TFLite model.
4. The predicted disease class and confidence score are displayed on screen.

---

## Tech Stack

| Component | Technology |
|---|---|
| Model Training | Python, TensorFlow / Keras |
| Experimentation | Jupyter Notebook |
| Mobile App | Flutter (Dart) |
| On-device Inference | TensorFlow Lite |
| Platforms | Android|

---
