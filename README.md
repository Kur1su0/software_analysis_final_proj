# software_analysis_final_proj
fuzzing audio adversarial attacks for voice assistant


## how to run
1. generate audio: generate injected audio to out directory(folder).  
	sh gen_audio.sh

2. test baseline: test baseline and get WER, need an input argument for parsing folder.
	e.g. sh classify_audio.sh out_speech
3. test wer only: just caculate WER based on the current file. (need an input argument for parsing folder)
	e.g. run_cal_wer_standalone.sh out_speech


out* \
|____out_list.txt : saved paths for each trained audio, original audio and expected command \
|____audio/       : each trained audio \
|____wer_res      : file for calculating WER \
|____hist/        : history for each trained audio \
|____wer.log      : output of wer result and average wer result

audio/ : a folder contain all original audio wav files.

trim/ : a folder contains all audio need to be trimed. (uncomment lines in gen_audio.sh to start the trimming process)

command_list.txt: a list of all attacking command


audio_list.txt: a list of all original audio.



