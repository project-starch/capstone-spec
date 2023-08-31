PARTS_DIR?=parts
ADOC_PARTS_SRC=$(wildcard parts/*.adoc)
IMAGE_SRC=$(wildcard images/*.svg)
IMAGE_TARGET_DIR=$(OUTPUT_DIR)/images
IMAGE_TARGETS=$(patsubst images/%.svg,$(IMAGE_TARGET_DIR)/%.svg,$(IMAGE_SRC))
ADOC_TOP_SRC=main.adoc
ADOC_EXTRA_DEPS=attributes.adoc
OUTPUT_DIR?=output
OUTPUT_PDF=$(OUTPUT_DIR)/main.pdf
OUTPUT_HTML=$(OUTPUT_DIR)/index.html
REFS_TABLE_FILE=./refs/sail.txt

all: $(OUTPUT_PDF) $(OUTPUT_HTML)

ifndef EXTERNAL_CONTAINER_IMG
CONTAINER_DEF=container/dev.def
CONTAINER_IMG=container/dev.sif

$(CONTAINER_IMG): $(CONTAINER_DEF)
	apptainer build -F $@ $<
else
CONTAINER_IMG=$(EXTERNAL_CONTAINER_IMG)
endif

$(OUTPUT_PDF): $(ADOC_TOP_SRC) $(ADOC_PARTS_SRC) $(ADOC_EXTRA_DEPS) $(CONTAINER_IMG) $(IMAGE_TARGET_DIR) $(IMAGE_TARGETS) $(REFS_TABLE_FILE)
	mkdir -p $(OUTPUT_DIR)
	apptainer exec $(CONTAINER_IMG) ruby render.rb $< $@ pdf $(REFS_TABLE_FILE)

$(OUTPUT_HTML): $(ADOC_TOP_SRC) $(ADOC_PARTS_SRC) $(ADOC_EXTRA_DEPS) $(CONTAINER_IMG) $(IMAGE_TARGET_DIR) $(IMAGE_TARGETS) $(REFS_TABLE_FILE)
	mkdir -p $(OUTPUT_DIR)
	apptainer exec $(CONTAINER_IMG) ruby render.rb $< $@ html5 $(REFS_TABLE_FILE)

$(IMAGE_TARGET_DIR):
	mkdir -p $@

$(IMAGE_TARGETS): $(IMAGE_TARGET_DIR)/%.svg: images/%.svg | $(IMAGE_TARGET_DIR)
	cp $< $@

clean:
	rm -rf $(OUTPUT_DIR)

.PHONY: all clean
