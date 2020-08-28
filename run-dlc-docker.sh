docker container run -it --rm \
    --gpus all \
    --name dlc \
    --env="DISPLAY" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --volume=/:/host \
    -u $(id -u):$(id -g) \
    dlc \
    bash;