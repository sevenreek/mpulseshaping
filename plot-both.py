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
    rawfile_name = 'read.txt'
    outfile_name = 'write.txt'
    source = np.fromfile(rawfile_name, sep='\n')
    result = np.fromfile(outfile_name, sep='\n')
    plt.figure()
    plt.plot(source[4096:4096*2], label='Source')
    plt.plot(result[4096:4096*2], label='Processed')
    plt.show()
