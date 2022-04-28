DATA_FILES := $(wildcard data/*.csv)
VALIDATION_REPORTS := $(subst csv,json, $(subst data,reports, $(DATA_FILES)))

all: clean ingest validate README.html

ingest-bad: ## Ingest raw files (data/raw/) into staging area (data/staging/)
	rsync --itemize-changes --checksum archive/bad/* data/ 

ingest: ## Ingest raw files (data/raw/) into staging area (data/staging/)
	rsync --itemize-changes --checksum archive/clean/* data/

validate: $(VALIDATION_REPORTS)

$(VALIDATION_REPORTS): reports/%.json: data/%.csv schemas/%/latest.yaml
	-frictionless validate --json --schema schemas/$*/latest.yaml data/$*.csv > $@

README.html: README.md reports/*
	@livemark build README.md

clean:
	@rm -rf data/*
	@rm -rf reports/*

vars:
	@echo 'DATA_FILES:' $(DATA_FILES)
	@echo 'VALIDATION_REPORTS:' $(VALIDATION_REPORTS)