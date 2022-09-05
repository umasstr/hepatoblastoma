##File Preparation Sample Code###

#Trim
cutadapt -j 12 -a CTGTCTCTTATACACATCT -A AGATGTGTATAAGAGACAG -o ${i%.gz} -p ${i%R1.fq.gz}R2.fq $i ${i%R1*}R2.fq.gz >> cutadapt.out

#Align
bwa mem -M -t 16 ~/BWAIndex/genome.fa $i ${i%R1*}R2.fq | samtools view -Sb -@ 16 - | samtools sort -@ 16 - > ${i%_R1*}.bam

#Merge sequencing lanes
samtools merge -@ 16 ${i%_S*}.bam ${i%_S*}*.bam

#Deduplicate
java -jar /share/pkg/picard/2.17.8/picard.jar MarkDuplicates VALIDATION_STRINGENCY=SILENT REMOVE_DUPLICATES=true METRICS_FILE=${i%.bam*}_dup.txt INPUT=$i OUTPUT=${i%.bam}.dup.bam

#Generate CPM-normalized bigWigs
bamCoverage -b $i -o ${i%.dup*}.cpm.bw -of=bigwig -bs=10 -p=24 --normalizeUsing CPM

#Generate YAP1 bedGraphs accounting for Tn5 cleavage shift
java -Xmx12G -jar ~/zpeaks-1.0.2.jar -bamIn $i -signalOut ${i%.bam*}.bg -forwardShift 4 -reverseShift -5 -signalOutFormat bed-graph  -signalResolution 12 -smoothingFactor 30 -parallelism 24 -peaksOut ${i%.dup*}.bed