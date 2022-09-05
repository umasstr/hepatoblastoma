#!/usr/bin/env python
import sys
import gzip
import statistics
import pyBigWig
import math
def read(bigwig, regions):
    with pyBigWig.open(bigwig) as bw:
        return [ statistics.mean(
            bw.values(x.split()[0], int(x.split()[1]), int(x.strip().split()[2]))
        ) for x in f ]
def zscores(bed, bigwig):
    bw = pyBigWig.open(bigwig)
    if bw is None:
        raise Exception("Error opening %s: no such file or directory." % bigwig)
    with (gzip.open if bed.endswith(".gz") else open)(bed, 'rt') as f:
        signal = [ statistics.mean(
            bw.values(x.split()[0], int(x.split()[1]), int(x.strip().split()[2]))
        ) for x in f ]
    signalmean = statistics.mean([ math.log(x) for x in signal if x > 0.0 ])
    signalstd = statistics.stdev([ math.log(x) for x in signal if x > 0.0 ])
    return [ (math.log(x) - signalmean) / signalstd if x > 0.0 else -10.0 for x in signal ]
def main(argc, argv):
    if argc < 3:
        print("usage: zscore signal.bigwig peaks.bed", file = sys.stderr)
        return 1
    z = zscores(argv[2], argv[1])
    with (gzip.open if argv[2].endswith(".gz") else open)(argv[2], 'rt') as f:
        idx = 0
        for line in f:
            print("%s\t%f" % (line.strip(), z[idx]))
            idx += 1
    return 0
if __name__ == "__main__":
    sys.exit(main(len(sys.argv), sys.argv))

#COURTESY OF WENG LAB AT UMASS CHAN MEDICAL SCHOOL
