ARG PYTORCH="2.1.1"
ARG CUDA="12.1"
ARG CUDNN="8"

FROM pytorch/pytorch:${PYTORCH}-cuda${CUDA}-cudnn${CUDNN}-runtime

ENV TORCH_CUDA_ARCH_LIST="6.0 6.1 7.0 7.5 8.0 8.6+PTX" \
    TORCH_NVCC_FLAGS="-Xfatbin -compress-all" \
    CMAKE_PREFIX_PATH="$(dirname $(which conda))/../" \
    FORCE_CUDA="1"


# Install the required packages
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive  \
    apt-get install -y ffmpeg libsm6 libxext6 git ninja-build libglib2.0-0 libsm6 libxrender-dev nano \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install MMEngine and MMCV
RUN pip install openmim && \
    mim install "mmengine>=0.7.1" "mmcv>=2.0.0rc4"

# Install MMDetection
RUN conda clean --all \
    && git clone https://github.com/open-mmlab/mmdetection.git /mmdetection \
    && cd /mmdetection \
    && pip install --no-cache-dir -e .

WORKDIR /app
COPY data /app/data
COPY my_config_docker.py /app

