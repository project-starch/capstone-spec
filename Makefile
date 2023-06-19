CONTAINER_DEF=container/dev.def
CONTAINER_IMG=container/dev.sif

PARTS_DIR?=parts
ADOC_PARTS_SRC=$(wildcard parts/*.adoc)
ADOC_TOP_SRC=main.adoc
OUTPUT_DIR?=output
OUTPUT_PDF=$(OUTPUT_DIR)/main.pdf
OUTPUT_HTML=$(OUTPUT_DIR)/index.html

all: $(OUTPUT_PDF) $(OUTPUT_HTML)

$(CONTAINER_IMG): $(CONTAINER_DEF)
	apptainer build -F $@ $<

$(OUTPUT_PDF): $(ADOC_TOP_SRC) $(ADOC_PARTS_SRC) $(CONTAINER_IMG)
	mkdir -p $(OUTPUT_DIR)
	$(CONTAINER_IMG) -r asciidoctor-pdf -r asciidoctor-diagram -b pdf -o $@ $<

$(OUTPUT_HTML): $(ADOC_TOP_SRC) $(ADOC_PARTS_SRC) $(CONTAINER_IMG)
	mkdir -p $(OUTPUT_DIR)
	$(CONTAINER_IMG) -r asciidoctor-diagram -b html5 -o $@ $<

clean:
	rm -rf $(OUTPUT_DIR)

.PHONY: all clean
