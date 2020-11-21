from utils.wer import wer
import sys

exp_list=[]
actual_list=[]

def get_list(path):
    with open(path,'r') as fp:
        lines = fp.readlines()[1:]
    
    print("total num: ",len(lines))
    for i in range(len(lines)):
        exp_list.append(lines[i].strip().split('\t')[0]  )  
        actual_list.append(lines[i].strip().split('\t')[1]  )  
    


def main():
    get_list(sys.argv[1])
    res = 0.0
    for i in range(len(exp_list)):
        res += wer(exp_list[i].split(),actual_list[i].split() )
    #res = wer("what is it".split(), "what is".split())



    print("AVG:\t" , float(res/len(exp_list))  )
if __name__ == "__main__":
    main()


