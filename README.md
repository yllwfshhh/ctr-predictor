# CTR Predictor - Cardiothoracic Ratio Analysis

A Django web application for analyzing chest X-ray images to calculate CT ratio and detect aortic calcification using deep learning models.

## Project Structure

```
ct-calculator/
├── main/                          # Main Django app
│   ├── models.py                 # PyTorch model definitions and prediction functions
│   ├── views.py                  # View logic for web pages
│   ├── urls.py                   # URL routing
│   ├── templates/                # HTML templates
│   │   ├── index.html           # Homepage
│   │   ├── predict.html         # Prediction results page
│   │   └── test.html            # Test page
│   └── static/                   # CSS files
│       ├── index.css
│       └── predict.css
├── year3_project/                # Django project configuration 
│   ├── settings.py              # Project settings
│   ├── urls.py                  # Main URL configuration
│   ├── wsgi.py                  # WSGI config for deployment
│   └── asgi.py                  # ASGI config for deployment
├── model/                        # PyTorch model weight files (*.pth)
│   ├── ctratio_model.pth        # CT ratio detection model
│   ├── calcification_crop_model.pth  # Aortic calcification detection
│   └── calcification_rank_model.pth  # Calcification ranking model
├── media/                        # User-uploaded files and generated images
│   └── ct_ratio/                # Output images
├── static/                       # Project-level static files
├── manage.py                     # Django management script
├── db.sqlite3                    # SQLite database
├── environment.yml               # Conda environment specification
└── requirements.txt              # Python dependencies (alternative to conda)
```

## Setup Instructions

### 1. Create Conda Environment

```bash
conda env create -f environment.yml
conda activate year3-project
```

### 2. Install Missing Libraries (if needed)

```bash
conda install -n year3-project jpeg libpng -y
```

### 3. Run Database Migrations

```bash
python manage.py migrate
```

### 4. Start Development Server

```bash
python manage.py runserver
```

The application will be available at: **http://127.0.0.1:8000/**

## Features

- **CT Ratio Calculation**: Analyzes chest X-rays to calculate cardiothoracic ratio
- **Heart & Chest Detection**: Uses Faster R-CNN to detect and measure heart and chest boundaries
- **Aortic Calcification Detection**: Identifies and ranks aortic calcification levels
- **Visual Output**: Generates annotated images with measurements

## Models

The application uses three PyTorch deep learning models:

1. **Model 1 (ctratio_model.pth)**: Faster R-CNN ResNet50 FPN
   - Detects chest and heart bounding boxes
   - Calculates CT ratio: `heart_width / chest_width`

2. **Model 2 (calcification_crop_model.pth)**: Faster R-CNN ResNet50 FPN
   - Detects aortic region for calcification analysis

3. **Model 3 (calcification_rank_model.pth)**: ResNet50 Classifier
   - Classifies calcification severity (2 classes)

## Dependencies

- Python 3.10
- Django 4.1.7
- PyTorch
- torchvision
- OpenCV (cv2)
- Pillow (PIL)
- NumPy

## Notes

- Model files (*.pth) must be placed in the `model/` directory
- Supports CPU and CUDA (GPU) inference
- Images are automatically resized to 417x417 for processing
