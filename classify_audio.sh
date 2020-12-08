#The script is to test the combined audio and get the WER for right-branch only.

# need argument for out (folder generated during gen_audio process), we provided 2 sample folders with pre-generated audio in case you don't have a decent GPU for tranning process.


if [ $# -ne 1 ]
then 
	echo "need an argument for out_path"
	exit
fi

TOOL_PATH="audio_adversarial_examples"

OUT_PATH=$1
echo "out path: $OUT_PATH"
#AUDIO_PATH="audio"
#CMD_PATH=""
#_CMD=$1
ITER=1000
#ITER=1000
#i: victim
#j: attack

#rm out_list.txt
#rm -rv out
#mkdir out
#mkdir out/audio
#mkdir out/hist


cd ${TOOL_PATH}

total_line=$(cat ../${OUT_PATH}/out_list.txt | wc -l)
echo "total $total_line"




i=1
END=$total_line
echo -e "exp\tactual" > ../${OUT_PATH}/wer.log
while [ $i -le $END ]; do
	#audio_path=`sed -n ${i}p ../${OUT_PATH}/out_list.txt| sh | awk -F '\t' '{print $1}'`
	exp_cmd=`awk -v var=$i -F '\t'  'FNR ==var{print $3}' ../${OUT_PATH}/out_list.txt`
	audio_file="../${OUT_PATH}/audio/"`awk -v var=$i -F '\t'  'FNR ==var{print $1}' ../${OUT_PATH}/out_list.txt`
	#echo -e "working on: $audio_file\t$exp_cmd"
	echo -e -n "$exp_cmd\t" >> ../${OUT_PATH}/wer.log
	python3 classify.py --in ${audio_file} --restore_path deepspeech-0.4.1-checkpoint/model.v0.4.1 >> ../${OUT_PATH}/wer.log
	echo -e "$i done: $audio_file\t$exp_cmd saved to ../${OUT_PATH}/wer.log"
	i=$(($i+1))
done

cd ../
echo "Cal WER..."
python3 cal_wer.py $OUT_PATH/wer.log |tee $OUT_PATH/wer_res 


echo "All done!"
		


