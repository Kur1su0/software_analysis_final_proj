#This script is to generate testing audio (original audio + text command). 
#Uncomment the lines to trim audio if you need to use your own audio
#Note that if you don't have cuda cores in your gpu, the generating process will be painful.

TOOL_PATH="audio_adversarial_examples"
#AUDIO_PATH="audio"
#CMD_PATH=""
#_CMD=$1
ITER=1000
#ITER=1000

#rm out_list.txt
#rm -rv out
mkdir out
mkdir out/audio
mkdir out/hist
# dir check, if out/audio exist, then exit and do nothing.
if [ "$(ls -A out)" ]; then
	echo "\"out\" is not Empty"
else
	echo "out is Empty"
fi

if [ "$(ls -A out/audio)" ]; then
	echo "out/audio is not Empty"
	echo "out/audio is not Empty"
	exit
else
	echo "out/audio is Empty"
fi

if [ "$(ls -A out/hist)" ]; then
	echo "out/hist is not Empty"
else
	echo "out/hist is Empty"
fi


#comment bellow to trim audio
###############################
#cd trim
#for file in *; do sox ${file}  -r 16000 -b 16 -c 1 ../audio/${file}; done
#cd ../
###############################


#update audio_list
find audio/* > audio_list.txt

cd ${TOOL_PATH}
#change 10 if number of command is not equal to 10
for i in {1..10}
do
	
	audio_file=`sed -n ${i}p ../audio_list.txt`
	for j in {1..10} 
	do
		#_CMD=`sed -n 1p ../command.txt`
		_CMD=`sed -n ${j}p ../command.txt`
		echo -e "${i}_${j}.wav\t${audio_file}\t$_CMD\t[injecting...]"
		#echo $_CMD	
		
		python3 attack.py --in ../${audio_file} --target "$_CMD" --out ../out/audio/${i}_${j}.wav --iterations ${ITER}  --restore_path deepspeech-0.4.1-checkpoint/model.v0.4.1 2>&1|tee ../out/hist/${i}_${j}.txt
		echo -e "${i}_${j}.wav\t${audio_file}\t$_CMD" >> ../out/out_list.txt
		echo -e "${i}_${j}.wav\t${audio_file}\t$_CMD\t[done!]"
	done
done
echo "All Done"
