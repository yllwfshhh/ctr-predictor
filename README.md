---
title: CTR Predictor
link: https://rainforest10-ctr-predictor.hf.space/test/index/
description: website deployed on Hugging Face Spaces.
---

# CTR Predictor - Cardiothoracic Ratio Analysis

A Django web application for analyzing chest X-ray images to calculate CT ratio and detect aortic calcification using deep learning models.

## Project Structure

```
ctr-predictor/
├── main/                          # Main Django app
│   ├── models.py                 # PyTorch model definitions and prediction functions
│   ├── views.py                  # View logic for web pages
│   ├── urls.py                   # URL routing
│   ├── templates/                # HTML templates
│   │   ├── index.html           # Homepage
│   │   ├── predict.html         # Prediction results page
│   │   └── test.html            # Test page
│   └── static/                   # Static assets (CSS, images for UI)
│       ├── index.css            # Homepage styles
│       ├── predict.css          # Prediction page styles
│       ├── background01.jpg     # Background image for homepage
│       ├── sample01.jpg         # Sample X-ray image 1
│       ├── sample02.jpg         # Sample X-ray image 2
│       └── source*.jpg          # Additional UI images
├── year3_project/                # Django project configuration 
│   ├── settings.py              # Project settings
│   ├── urls.py                  # Main URL configuration
│   ├── wsgi.py                  # WSGI config for deployment
│   └── asgi.py                  # ASGI config for deployment
├── media/                        # Dynamic content (models, uploads, generated images)
│   ├── model/                   # PyTorch model weight files (*.pth) - NOT in git
│   │   ├── ctratio_model.pth        # CT ratio detection model
│   │   ├── calcification_crop_model.pth  # Aortic calcification detection
│   │   └── calcification_rank_model.pth  # Calcification ranking model
│   ├── ct_ratio/                # Generated output images - NOT in git
│   │   └── show_image.jpg       # Annotated prediction result
│   ├── aortic_image.jpg         # Cropped aortic region (generated) - NOT in git
│   └── [uploaded images]        # User-uploaded X-ray images - NOT in git
├── manage.py                     # Django management script
├── db.sqlite3                    # SQLite database
├── environment.yml               # Conda environment specification
└── .gitignore                    # Git ignore rules (excludes media/ folder)
```

## Directory Explanation

### `main/static/` - Static Assets (Served via `/static/`)
- **CSS files**: Stylesheets for the web interface
- **Images**: Background images, sample X-rays for demo, and UI graphics
- **Purpose**: Files that are part of the application design and don't change
- **Version Control**: ✅ Included in git repository

### `media/` - Dynamic Content (Served via `/media/`)
- **model/**: Pre-trained PyTorch model files (large .pth files)
- **ct_ratio/**: Generated images with detection annotations
- **Uploaded images**: User-uploaded X-ray images for prediction
- **Purpose**: Files that are generated at runtime or user-uploaded
- **Version Control**: ❌ Excluded from git (too large, privacy concerns)

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

### 3. Download Model Files

The application requires pre-trained PyTorch model files. Download them from:
**https://drive.google.com/drive/folders/1L3D1ws_gr_ixLwyYsYelSLafcrYGHwv3?usp=sharing**

Contact the repository owner for access if needed. Create the directory structure and place the downloaded `.pth` files:

```bash
mkdir -p media/model
# Place the downloaded files in media/model/
# - ctratio_model.pth
# - calcification_crop_model.pth
# - calcification_rank_model.pth
```

### 4. Create Media Directories

```bash
mkdir -p media/ct_ratio
```

### 5. Run Database Migrations

```bash
python manage.py migrate
```

### 6. Start Development Server

```bash
python manage.py runserver
```

The application will be available at:
- **Homepage**: http://127.0.0.1:8000/test/index/
- **Prediction Page**: http://127.0.0.1:8000/test/predict/

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

- Model files (*.pth) must be placed in the `media/model/` directory
- The entire `media/` folder is excluded from git (see `.gitignore`)
- Supports CPU and CUDA (GPU) inference
- Images are automatically resized to 417x417 for processing
- Static assets (CSS, UI images) are in `main/static/` and served via `/static/`
- Dynamic content (models, uploads, generated images) are in `media/` and served via `/media/`
