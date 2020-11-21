AUDIO_PATH=$1

python3 classify.py --in ${AUDIO_PATH} --restore_path deepspeech-0.4.1-checkpoint/model.v0.4.1
