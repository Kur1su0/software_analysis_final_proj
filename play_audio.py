import pyttsx3
import sys
from playsound import playsound


#change the following line if you are using a linux machine.
AUDIO_LIST="out\\out_list.txt"
AUDIO_PATH="out\\audio\\"
CMD_PATH = "command.txt"
PATH_TO_GOOGLE="..\\google.wav"
#####################


command_list = []
audio_list= []







def get_cmd():
    with open(CMD_PATH,"r") as fp:
        lines = fp.readlines()
    for line in lines:
        #audio_list.append(AUDIO_PATH+line.split("\t")[0])
        command_list.append(line)
	#.split("\t")[0])


def get_audio():
    with open(AUDIO_LIST,"r") as fp:
        lines = fp.readlines()
    for line in lines:
        audio_list.append(AUDIO_PATH+line.split("\t")[0])
        command_list.append(line.split("\t")[2].strip("\n"))




def test(which_device):
    succeed_music,succeed_speech = 0,0
    #total_music, total_speech = 50, 50
    succeed = 0
    total = len(audio_list)
    cur_total = 0;
    get_audio()

    engine = pyttsx3.init()
    rate = engine.getProperty('rate')  # getting details of current speaking rate
    print(rate)  # printing current voice rate
    engine.setProperty('rate', 125)
    for i in range(len(audio_list)):
        print( "[",i+1,"/",len(audio_list),"done - cur secceed:", succeed, "]", "expect --- ",command_list[i])

        if which_device == "alexa" or which_device =="siri":
            engine.say(which_device)
            engine.runAndWait()
        else:
            playsound(PATH_TO_GOOGLE)

        try:
            playsound(audio_list[i])
        except:
            print("audio doesn't exist")
            continue

        usr_input=input("succeed?[y/n/q]...")
        if usr_input == 'q':
            break
        if usr_input != 'y' and  usr_input != 'n':
            print("wrong input (should be y/n): ",usr_input)
            usr_input = input("succeed?[y/n]...")
        elif usr_input == 'y':
            succeed += 1
            cur_total += 1
        elif usr_input == 'n':
            cur_total += 1
	

    if(cur_total == 0):
        print("Rate: (%d/%d)=%f" %(succeed,cur_total,0.0)   )
    else:
        print("Rate: (%d/%d)=%f" %(succeed,cur_total,float(succeed/cur_total))   )

def play_unjected_cmd(which_device):
    if which_device != "google" and which_device != "alexa" and which_device !="siri":
        print("wrong input:",which_device, "[should be alexa or google]")
        exit(1)
    get_cmd()
    engine = pyttsx3.init()
    rate = engine.getProperty('rate')  # getting details of current speaking rate
    print(rate)  # printing current voice rate
    engine.setProperty('rate', 150)
    for i in range(len(command_list)):
        print( "[",i+1,"/",len(command_list),"] expect ---",command_list[i])
        if which_device == "alexa" or which_device == "siri":
            engine.say(which_device)
            engine.say(command_list[i])
            engine.runAndWait()
        else:
            playsound(PATH_TO_GOOGLE)
            engine.say(command_list[i])
            engine.runAndWait()
        usr_input=input("Press Any Key to Continue[q to quit]")
        if usr_input == 'q':
            break

def sanity_check(which_device, which_test):
 if which_device != "google" and which_device != "alexa" and which_device != "siri":
        print("wrong input:", which_device, "[should be alexa or google]")
        exit(1)
 else:
     print("your device [",which_device,"]")

 if which_test != "attack" and which_test != "cmd":
        print("wrong input:", which_test, "[should be attack or cmd]")
        exit(1)
 else:
     print("your test [",which_test,"]")


def main():
    if len(sys.argv) !=3:
        print("wrong args, need 2 args")
        exit(1)
    which_device = sys.argv[1]
    which_test =sys.argv[2]
    sanity_check(which_device,which_test)

    #exit(1)
    if which_test == "cmd":
        play_unjected_cmd(which_device)
    else:
        test(which_device)




if __name__ == '__main__':
    main()




