library(TxDb.Mmusculus.UCSC.mm10.knownGene)
library(org.Mm.eg.db)
gr <- GRanges("chr10", IRanges(62803384,62890864), strand="-")
	trs <- geneModelFromTxdb(TxDb.Mmusculus.UCSC.mm10.knownGene,
							 org.Mm.eg.db,
							 gr=gr)

	trs<-trs[["ENSMUST00000050826.13"]]
	
	YAPon<-importScore('YAPon.cpm.bw',ranges = gr,format = 'BigWig')
	YAPoffd14<-importScore('YAPoffd14.cpm.bw',ranges = gr,format = 'BigWig')
	YAPoffd64<-importScore('YAPoffd33.cpm.bw',ranges = gr,format = 'BigWig')
	Liver<-importScore('Liver.cpm.bw',ranges = gr,format = 'BigWig')
	YAPonk4<-importScore('YAPon-K4me1.cpm.bw',ranges = gr,format = 'BigWig')
	Liverk4<-importScore('Liver-K4me1.cpm.bw',ranges = gr,format = 'BigWig')
	YAPonk27<-importScore('YAPon-K27Ac.cpm.bw',ranges = gr,format = 'BigWig')
	Liverk27<-importScore('Liver-K27Ac.cpm.bw',ranges = gr,format = 'BigWig')
	YAP1<-importScore('Yap.dup.bw',ranges = gr,format = 'BigWig')
	contacts<-importGInteractions(file="contacts.bed", format="ginteractions",ranges=gr)
	
	contacts$dat<-contacts$dat[1]
	contacts$dat2<-contacts$dat2[1]
	setTrackStyleParam(contacts, "tracktype", "link")
	
	#viewTracks(trackList(YAPon,YAPoffd14,YAPoffd64,Liver,YAPonk4,Liverk4,YAPonk27,Liverk27,YAP1,contacts,trs),gr=gr)
	
	ids <- getGeneIDsFromTxDb(gr, TxDb.Mmusculus.UCSC.mm10.knownGene)
	 
	 symbols <- mget(ids, org.Mm.egSYMBOL)
	 genes <- geneTrack(ids, TxDb.Mmusculus.UCSC.mm10.knownGene,                     symbols, asList=FALSE)
	 
	 optSty <- optimizeStyle(trackList(YAPon,YAPoffd14,YAPoffd64,Liver,YAPonk4,Liverk4,YAPonk27,Liverk27,YAP1,contacts,trs), theme="safe")
	 
	 trackList <- optSty$tracks
	 viewerStyle <- optSty$style
	 
	setTrackStyleParam(trackList[[1]],"color",value = c("red4"))
	setTrackStyleParam(trackList[[2]],"color",value = c("lightskyblue1"))
	setTrackStyleParam(trackList[[3]],"color",value = c("steelblue1"))
	setTrackStyleParam(trackList[[4]],"color",value = c("steelblue3"))
	setTrackStyleParam(trackList[[5]],"color",value = c("red4"))
	setTrackStyleParam(trackList[[6]],"color",value = c("steelblue3"))
	setTrackStyleParam(trackList[[7]],"color",value = c("red4"))
	setTrackStyleParam(trackList[[8]],"color",value = c("steelblue3"))
	setTrackStyleParam(trackList[[9]],"color",value = c("orange2"))
	setTrackStyleParam(trackList[[10]],"color",value = c("purple4"))
	setTrackStyleParam(trackList[[11]],"color",value = c("black"))
	
	setTrackStyleParam(trackList[[1]], "ylim", c(0, 1.5))
	setTrackStyleParam(trackList[[2]], "ylim", c(0, 1.5))
	setTrackStyleParam(trackList[[3]], "ylim", c(0, 1.5))
	setTrackStyleParam(trackList[[4]], "ylim", c(0, 1.5))
	setTrackStyleParam(trackList[[5]], "ylim", c(0, 10))
	setTrackStyleParam(trackList[[6]], "ylim", c(0, 10))
	setTrackStyleParam(trackList[[7]], "ylim", c(0, 2))
	setTrackStyleParam(trackList[[8]], "ylim", c(0, 2))
	setTrackStyleParam(trackList[[9]], "ylim", c(0, .00000015))
	setTrackStyleParam(trackList[[10]], "tracktype", "link")

	setTrackXscaleParam(trackList[[1]], "draw" ,FALSE)
	setTrackXscaleParam(trackList[[2]], "draw" , FALSE)
	setTrackXscaleParam(trackList[[3]], "draw" , FALSE)
	setTrackXscaleParam(trackList[[4]], "draw" , FALSE)
	setTrackXscaleParam(trackList[[5]], "draw" , FALSE)
	setTrackXscaleParam(trackList[[6]], "draw" , FALSE)
	setTrackXscaleParam(trackList[[7]], "draw" , FALSE)
	setTrackXscaleParam(trackList[[8]], "draw" , FALSE)
	setTrackXscaleParam(trackList[[9]], "draw" , FALSE)
	
	setTrackStyleParam(trackList[[1]], "marginBottom", 0.1)
	setTrackStyleParam(trackList[[2]], "marginBottom", 0.1)
	setTrackStyleParam(trackList[[3]], "marginBottom", 0.1)
	setTrackStyleParam(trackList[[4]], "marginBottom", 0.1)
	setTrackStyleParam(trackList[[5]], "marginBottom", 0.1)
	setTrackStyleParam(trackList[[6]], "marginBottom", 0.1)
	setTrackStyleParam(trackList[[7]], "marginBottom", 0.1)
	setTrackStyleParam(trackList[[8]], "marginBottom", 0.1)
	setTrackStyleParam(trackList[[9]], "marginBottom", 0.1)
	setTrackStyleParam(trackList[[10]], "marginBottom", 0.1)
	
	setTrackStyleParam(trackList[[1]], "marginTop", 0)
	setTrackStyleParam(trackList[[2]], "marginTop", 0)
	setTrackStyleParam(trackList[[3]], "marginTop", 0)
	setTrackStyleParam(trackList[[4]], "marginTop", 0)
	setTrackStyleParam(trackList[[5]], "marginTop", 0)
	setTrackStyleParam(trackList[[6]], "marginTop", 0)
	setTrackStyleParam(trackList[[7]], "marginTop", 0)
	setTrackStyleParam(trackList[[8]], "marginTop", 0)
	setTrackStyleParam(trackList[[9]], "marginTop", 0)
	setTrackStyleParam(trackList[[10]], "marginTop", 0)
	
	setTrackStyleParam(trackList[[1]], "ylim", c(0, 1.5))
	vp <- viewTracks(trackList, gr=gr, viewerStyle=viewerStyle, autoOptimizeStyle=TRUE)
	 
