SUB_NAMES = Prob1 Prob2 Prob3 Prob4 Prob5 Prob6 
SUB_DIRS = $(addprefix problems/, $(addsuffix /, $(SUB_NAMES)))
SUB_PDFS =   $(join $(SUB_DIRS), $(addsuffix .pdf, $(SUB_NAMES)))
SUB_TEXS = $(SUB_PDFS:.pdf=.tex)


P1 = problems/Prob1
PROB1_DEPEND =  $(P1)/images/4000And6000Spectrum.jpg $(P1)/Prob1ScriptOutput.txt $(P1)/PS3Prob1Script.m 

SUB_DEPEND = $(SUB_TEXS) $(PROB1_DEPEND)

LATEXMK = latexmk -use-make -pdf -dvi- -ps- 

all: PS3.pdf

parts: $(SUB_PDFS)

%.pdf: %.tex
	cd $(<D); $(LATEXMK) $(<F)
	
$(P1)/Prob1.pdf: $(P1)/Prob1.tex $(PROB1_DEPEND)

$(P1)/Prob1ScriptOutput.txt $(P1)/images/4000Spectrum.jpg $(P1)/images/6000Spectrum.jpg $(P1)/images/4000And6000Spectrum.jpg: $(P1)/PS3Prob1Script.m
	wolframscript -f $(P1)/PS3Prob1Script.m

PS3.pdf: PS3.tex $(SUB_DEPEND) 
	$(LATEXMK) PS3.tex

.PHONY: tidy clean docs publish

tidy:
	latexmk -c
	for dir in $(SUB_DIRS); do\
		(cd $$dir; latexmk -c) ;\
	done;

clean:
	latexmk -C
	for dir in $(SUB_DIRS); do\
		(cd $$dir; latexmk -C) ;\
	done;
	rm docs/*.pdf
	#rm problems/Prob1/Prob1ScriptOutput.txt
	rm problems/Prob1/images/*.jpg
	
publish: all parts
	find . -path ./docs -prune -o -name "*.pdf" -exec cp {} docs \;