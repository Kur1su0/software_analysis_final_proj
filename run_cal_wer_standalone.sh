
if [ $# -ne 1 ]
then 
	echo "need an argument for out_path"
	exit
fi

OUT_PATH=$1
echo "$OUT_PATH"
python3 cal_wer.py ${OUT_PATH}/wer.log |tee ${OUT_PATH}/wer_res.output
