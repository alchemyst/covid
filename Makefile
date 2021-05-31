TODAY := $(shell gdate -I)

PROVINCES = GP SA
FORMAT = pdf

outputs = $(foreach province,$(PROVINCES),covid_$(TODAY)_$(province).$(FORMAT))

all: $(outputs)

covid_$(TODAY)_%.$(FORMAT): COVID_in_South_Africa.ipynb
	papermill -p province $* -p outformat $(FORMAT) $< > /dev/null

.PHONY: all
