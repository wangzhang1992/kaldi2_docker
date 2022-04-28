FROM nvcr.io/nvidia/kaldi:20.09-py3

ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
RUN apt update

RUN set -ex \
        && apt install -y python-pip \
        && apt install -y python3-pip \
        && apt install -y git-lfs \
        && pip3 install --upgrade pip \
	&& pip install --upgrade pip

ADD kaldi2 /workspace/kaldi2
RUN set -ex \
        #&& mkdir -p /workspace/kaldi2 \
  	&& cd /workspace/kaldi2 \
        && pip3 install torch==1.7.1+cu110 torchvision==0.8.2+cu110 torchaudio==0.7.2 -f https://download.pytorch.org/whl/torch_stable.html


RUN set -ex \
        #&& git clone https://github.com/k2-fsa/k2.git \
	#&& git clone https://github.com/lhotse-speech/lhotse \
	#&& git clone https://github.com/k2-fsa/icefall \
	&& cd /workspace/kaldi2/k2 \
	&& python3 setup.py install \
	&& cd /workspace/kaldi2/lhotse \
	&& pip3 install -e '.[dev]' \
	&& cd /workspace/kaldi2/icefall \
	&& pip3 install -r requirements.txt \
        && pip3 install kaldifeat
		
ENV  PYTHONPATH=/workspace/kaldi2/icefall:$PYTHONPATH

WORKDIR /workspace/kaldi2/icefall
