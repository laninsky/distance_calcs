# distance_calcs
Calculates pairwise distance between samples for a folder of fasta files

Uses: http://emboss.sourceforge.net/apps/release/6.6/emboss/apps/distmat.html - distmat will need to be in your path

Options you need to define:
```
export nucmethod=0

#Modify nucmethod to the multiple substitution method you would prefer
#0	(Uncorrected)
#1	(Jukes-Cantor)
#2	(Kimura)
#3	(Tamura)
#4	(Tajima-Nei)
#5	(Jin-Nei Gamma)

export folderlocation=/path/to/where/your/files/are
```
e.g.
```
export nucmethod=3
export folderlocation=locus_specific_fasta
```


```
for i in $folderlocation/*;
  do distmat -nucmethod $nucmethod -sequence $i -outfile $i.out;
done;

Rscript todist.R $folderlocation

```
To cite EMBOSS:

Rice, P. Longden, I. and Bleasby, A. 2000. EMBOSS: The European Molecular Biology Open Software Suite. Trends in Genetics 16, (6) pp276--277

To cite this pipeline:

TBD
