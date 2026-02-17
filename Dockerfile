# Use an official Python image
FROM python:3.9

# Create a user to avoid running as root (Hugging Face requirement)
RUN useradd -m -u 1000 user

USER root

# Install system dependencies for OpenCV and other image libraries
RUN apt-get update && apt-get install -y \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

USER user
ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH

WORKDIR $HOME/app

# Copy requirements and install them
COPY --chown=user . $HOME/app
RUN pip install --no-cache-dir -r requirements.txt

# Create necessary directories
RUN mkdir -p media/ct_ratio && \
    python manage.py migrate

# Expose the port Hugging Face expects
EXPOSE 7860

# Command to run your Django app on port 7860
CMD ["python", "manage.py", "runserver", "0.0.0.0:7860"]