# Use an official Python image
FROM python:3.9

# Create a user to avoid running as root (Hugging Face requirement)
RUN useradd -m -u 1000 user
USER user
ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH

WORKDIR $HOME/app

# Copy requirements and install them
COPY --chown=user . $HOME/app
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port Hugging Face expects
EXPOSE 7860

# Command to run your Django app on port 7860
CMD ["python", "manage.py", "runserver", "0.0.0.0:7860"]