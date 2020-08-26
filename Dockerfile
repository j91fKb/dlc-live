FROM tensorflow/tensorflow:1.13.1-gpu-py3-jupyter

RUN apt-get update

RUN apt-get install -y libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6

RUN apt-get install -y apt-utils wget git

RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-2020.07-Linux-x86_64.sh -O ~/anaconda.sh 

RUN /bin/bash ~/anaconda.sh -b -p /opt/conda && \
  rm ~/anaconda.sh && \
  ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
  echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
  echo "conda activate base" >> ~/.bashrc && \
  find /opt/conda/ -follow -type f -name '*.a' -delete && \
  find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
  /opt/conda/bin/conda clean -afy

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

RUN conda create -n dlc-live python=3.7 tensorflow-gpu==1.13.1 # if using GPU
SHELL ["conda", "run", "-n", "dlc-live", "/bin/bash", "-c"]
RUN pip install deeplabcut-live
RUN mkdir /deeplabcut && cd /deeplabcut && git clone https://github.com/DeepLabCut/DeepLabCut-live.git

CMD ["conda", "activate", "dlc-live"]