# ComfyUI Dockerfile with WAN 2.1 and WAN 2.2 models
FROM python:3.10-slim

# System dependencies
RUN apt-get update && apt-get install -y \
    git \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Set workdir
WORKDIR /app

# Copy code
COPY . .

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Create model folders
RUN mkdir -p models/wan

# Download WAN 2.1 and WAN 2.2 models
RUN wget -O models/wan/wan_v2_1.safetensors "https://huggingface.co/Westlake-AI/WanJuan2.1/resolve/main/wan_v2_1.safetensors"
RUN wget -O models/wan/wan_v2_2.safetensors "https://huggingface.co/Westlake-AI/WanJuan2.2/resolve/main/wan_v2_2.safetensors"

# Expose port
EXPOSE 8188

# Start ComfyUI
CMD ["python", "main.py", "--port", "8188"]