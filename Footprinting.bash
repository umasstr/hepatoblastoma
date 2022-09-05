#Footprinting with RGT

for i in *.dup.bam;$HOME/.local/bin/rgt-hint footprinting --atac-seq --paired-end --organism=mm10 --output-location=./ --output-prefix="${i%_2*}" $i ${i%.dup*}.bed;done

$HOME/.local/bin/rgt-motifanalysis matching --organism=mm10 --input-files YAPon.bed Liver.bed

$HOME/.local/bin/rgt-hint differential --organism=mm10 --bc --nc 24 --mpbs-files=./match/YAPon_mpbs.bed,./match/Liver_mpbs.bed --reads-files=YAPon.bam,Liver.bam --conditions=YAPon,Liver --output-location=YAPon_Liver

