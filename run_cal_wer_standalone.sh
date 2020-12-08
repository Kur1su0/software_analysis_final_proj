$1=$OUT_PATH

if [ $# -ne 1 ]
then 
	echo "need an argument for out_path"
	exit
fi

python3 cal_wer.py $OUT_PATH/wer.log |tee $OUT_PATH/wer_res                                                                                                                                                                                                                            
