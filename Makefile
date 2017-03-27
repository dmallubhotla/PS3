SUB_NAMES = Prob1 Prob2 Prob3 Prob4 Prob5 Prob6 
SUB_DIRS = $(addprefix problems/, $(addsuffix /, $(SUB_NAMES)))
SUB_PDFS =   $(join $(SUB_DIRS), $(addsuffix .pdf, $(SUB_NAMES)))
SUB_TEXS = $(SUB_PDFS:.pdf=.tex)

SUB_DEPEND = $(SUB_TEXS)


LATEXMK = latexmk -use-make -pdf -dvi- -ps- 

all: PS3.pdf

parts: $(SUB_PDFS)



%.pdf: %.tex
	cd $(<D); $(LATEXMK) $(<F)

	
PS3.pdf: PS3.tex $(SUB_DEPEND) 
	$(LATEXMK) PS3.tex

	.PHONY: tidy clean docs

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
	
publish: all parts
	find . -path ./docs -prune -o -name "*.pdf" -exec cp {} docs \;