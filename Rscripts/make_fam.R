#create fam file from lgen
library(dplyr)
library(data.table)
library(argparse)

parser <- ArgumentParser()
parser$add_argument("--lgen", help="file path of the lgen")
parser$add_argument("-o", "--out", help="Use as in plink. Out is output prefix including full path and no file type extensions.")
args <- parser$parse_args()

lgen<-fread(args$lgen, header=F)
#lgen<-fread('/home/isabelle/METS/METSpractice.lgen',header=F)
#lgen cols look like:
#LD1	LD1	10:100012219-GT	G	G
#LD1	LD1	10:100013340-CT	C	C
#LD1	LD1	10:100013467-GA	G	G

#.fam cols: fid, iid, father, mother, sex, case/control
fam<-select(lgen, V1,V2)
fam<-mutate(fam, V3=0)%>%mutate(V4=0)%>%mutate(V5=2)%>%mutate(V6=0)
#sex for THIS dataset is all female, will need to figure out how to deal with varying sex later

write.table(fam, file = paste(args$out,".fam",sep=""), sep = "\t", col.names = F, row.names = F, quote = F)
