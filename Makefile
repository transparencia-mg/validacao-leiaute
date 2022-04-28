DATA_FILES := $(wildcard data/*.csv)
VALIDATION_REPORTS := $(subst csv,json, $(subst data,reports, $(DATA_FILES)))

all: validate reports.html

validate: $(VALIDATION_REPORTS)

$(VALIDATION_REPORTS): reports/%.json: data/%.csv schemas/%/latest.yaml
	-frictionless validate --json --schema schemas/$*/latest.yaml data/$*.csv > $@

reports.html: reports.md reports/*
	livemark build reports.md
