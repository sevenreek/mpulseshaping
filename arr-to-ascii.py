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
    step_size = 1024
    with open("out.txt", mode='w') as outf:
        with open(file_name, mode='rb') as f:
            active = True
            while active:
                file_content = f.read(step_size*SHORT_SIZE)
                if(file_content != b'' and file_content is not None):
                    data = np.frombuffer(file_content, dtype=np.int16)
                    for sample in data:
                        outf.write("{}\n".format(sample))
                else: 
                    active = False
                    break
