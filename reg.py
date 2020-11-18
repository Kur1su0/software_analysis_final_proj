import speech_recognition as sr

AUDIO_LIST="out/out_list.txt"
AUDIO_PATH="out/audio/"
audio_list =[]



def get_audio():
    with open(AUDIO_LIST,"r") as fp:
        lines = fp.readlines()
    for line in lines:
        audio_list.append(AUDIO_PATH+line.split("\t")[0])
	#.split("\t")[0])


def main():
    get_audio()
    r = sr.Recognizer()
    
    for i in range(len(audio_list)):
        try:
            detect_audio = sr.AudioFile(audio_list[i])
            with detect_audio as source:
                audio = r.record(source)

            res = r.recognize_google(audio)
            print(res)
        except:
            print("No result")

if __name__ == '__main__':
        main()
