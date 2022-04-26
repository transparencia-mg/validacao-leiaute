DATA_FILES_RAW := $(wildcard data-raw/*.csv)
DATA_FILES_STAGING := $(subst data-raw/,data-staging/,$(DATA_FILES_RAW))
VALIDATION_REPORTS := $(subst csv,json, $(subst data-raw,reports, $(DATA_FILES_RAW)))

all: ingest validate README.html

ingest: ## Ingest raw files (data/raw/) into staging area (data/staging/)
	rsync --itemize-changes --checksum data-raw/* data-staging/ 

validate: $(VALIDATION_REPORTS)

$(VALIDATION_REPORTS): reports/%.json: data-staging/%.csv schemas/%/latest.yaml
	-frictionless validate --json --schema schemas/$*/latest.yaml data-staging/$*.csv > $@

README.html: README.md reports/*
	livemark build README.md

vars:
	@echo 'DATA_FILES_RAW:' $(DATA_FILES_RAW)
	@echo 'DATA_FILES_STAGING:' $(DATA_FILES_STAGING)
	@echo 'VALIDATION_REPORTS:' $(VALIDATION_REPORTS)