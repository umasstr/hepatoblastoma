#!/bin/bash
if [ "$1" == "" ]; then
	echo "useage: bedpeToBigBed in.bedpe chrom.sizes out.bb [optional threshold 0-1]"
	exit 0
else
	if [ "$4" == "" ] || [ "$4" \> 1 ] || [ "$4" \< 0 ]; then
		echo "no number >0 & <1 detected in arg 4 setting ABC threshold to 0" && \
		t=0
	else
		t="$4"
	fi
	
	u=`awk -v x="$t" 'BEGIN{print 1000*x}'`
	
	awk -v x=250 -v y=1000 'BEGIN{OFS="\t"}{print $1,$2,$5,$7,$8*y,"1",".","0",$1,$2,$3,".",".",$4,$5-x,$6+x,".","."}' < "$1" | awk -v OFS="\t" '{ $5 = sprintf("%.0f", $5) }1' | awk -v u="$u" '{ if ($5 < u) {++removed;next} else {print $0} }' > EnhancerPredictions.interact
 
	awk '{ if ($2 > $3) {++removed;next} else {print $0} }' < EnhancerPredictions.interact > EnhancerPredictions.interact.1
 
	awk '{ if ($2 < $3) {++removed;next} else {print $0} }' < EnhancerPredictions.interact > EnhancerPredictions.interact.2
 
	awk 'BEGIN{OFS="\t"}{print $1,$3,$2,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18}' EnhancerPredictions.interact.2 > EnhancerPredictions.interact.3
 
	cat EnhancerPredictions.interact.1 EnhancerPredictions.interact.3 | sort -k1,1 -k2,2n > EnhancerPredictions.bed
	
	FILE="interact.as"
	if [ -f "$FILE" ]; then
		echo "BED5+13 reference check: $FILE exists." 
	else
		echo "$FILE does not exist. Downloading from UCSC" && wget https://genome.ucsc.edu/goldenPath/help/examples/interact/interact.as
	fi 
 
	bedToBigBed -as=interact.as -type=bed5+13  EnhancerPredictions.bed "$2" "$3"
 
	rm EnhancerPredictions.interact*
	rm EnhancerPredictions.bed
fi
