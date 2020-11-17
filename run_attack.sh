TOOL_PATH="audio_adversarial_examples"
#AUDIO_PATH="audio"
#CMD_PATH=""
#_CMD=$1
ITER=1000
#i: victim
#j: attack

#rm out_list.txt
#rm -rv out
#mkdir out
#mkdir out/audio
#mkdir out/hist

cd ${TOOL_PATH}
for i in {1..102}
do
	
	audio_file=`sed -n ${i}p ../audio_list.txt`
	for j in {1..10} 
	do
		_CMD=`sed -n ${j}p ../command.txt`
		echo -e "${i}_${j}.wav\t${audio_file}\t$_CMD\t[injecting...]"
		#echo $_CMD	
		python3 attack.py --in ../${audio_file} --target "$_CMD" --out ../out/audio/${i}_${j}.wav --iterations ${ITER}  --restore_path deepspeech-0.4.1-checkpoint/model.v0.4.1 2>&1|tee ../out/hist/${i}_${j}.txt
		echo -e "${i}_${j}.wav\t${audio_file}\t$_CMD" >> ../out_list.txt
		echo -e "${i}_${j}.wav\t${audio_file}\t$_CMD\t[done!]"
	done
done
echo "All Done"
#python3 ${TOOL_PATH}/attack.py --in sample-000000.wav --target "$_CMD" --out adv.wav --iterations ${ITER}  --restore_path ${TOOL_PATH}/deepspeech-0.4.1-checkpoint/model.v0.4.1
