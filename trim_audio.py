import pyaudioconvert as pac
import sys


#pac.convert_wav_to_16bit_mono('trim/untrim_nonspeech_white_noise.wav', 'audio/nonspeech_white_noise.wav')
print(sys.argv[1],"->",sys.argv[2])
pac.convert_wav_to_16bit_mono(sys.argv[1],sys.argv[2])

