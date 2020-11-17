TOOL_PATH="audio_adversarial_examples"
AUDIO_PATH=""
CMD_PATH=""
_CMD=$1
python3 ${TOOL_PATH}/attack.py --in sample-000000.wav --target "$_CMD" --out adv.wav --iterations 1000  --restore_path ${TOOL_PATH}/deepspeech-0.4.1-checkpoint/model.v0.4.1
