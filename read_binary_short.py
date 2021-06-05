import sys
import os
import numpy as np
import scipy.signal as sig
import matplotlib.pyplot as plt
SHORT_SIZE = 2
INPUT_RANGE = 2014.3445
def mvToADCCode(value):
    return round ( value / ( INPUT_RANGE / 2 ) * (2**15) )

def adcCodeToMv(value):
    return value * ( INPUT_RANGE / 2 ) / (2**15) 

if __name__ == "__main__":
    file_name = sys.argv[1]
    file_size = os.path.getsize(file_name)
    sample_count = file_size/SHORT_SIZE
    print(f"Opening {file_name} with size {file_size}.")
    with open(file_name, mode='rb') as f:
        file_content = f.read()
        data = np.frombuffer(file_content, dtype=np.int16)
        print(data)
        r_max = np.max(data)
        r_min = np.min(data)
        r_avg = np.average(data)
        try:
            r_rms = np.sqrt(np.mean(data**2))
        except:
            r_rms = -1

        print(f"MAX: {r_max:4.0f} -> {adcCodeToMv(r_max):3.5f}mV")
        print(f"MIN: {r_min:4.0f} -> {adcCodeToMv(r_min):3.5f}mV")
        print(f"AVG: {r_avg:4.0f} -> {adcCodeToMv(r_avg):3.5f}mV")
        print(f"RMS: {r_rms:4.0f} -> {adcCodeToMv(r_rms):3.5f}mV")
        #exit()
        dec = input("input p to plot")
        if(dec == 'p'):
            plt.figure()
            plt.plot(data)
            #plt.plot(sig.decimate(data, 2))
            plt.show()
        """
        for mx in range(512, len(data)):
            #plt.plot(data[mx-1024:mx])
            #plt.show()
            print(data[mx-512:mx])
            input()
        """