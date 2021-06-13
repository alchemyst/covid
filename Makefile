DATA_URL=https://raw.githubusercontent.com/dsfsi/covid19za/master/data
PROVINCES = GP WC SA NC
FORMAT = pdf
OUTPUT = output

outputs = $(foreach province,$(PROVINCES),$(OUTPUT)/covid_$(province).$(FORMAT))

datafiles = covid19za_provincial_cumulative_timeline_confirmed.csv covid19za_provincial_cumulative_timeline_deaths.csv covid19za_timeline_vaccination.csv

data = $(addprefix data/,$(datafiles))

static = $(wildcard static/*.csv)

all: $(outputs) $(OUTPUT)/vaccinations.$(FORMAT)

data/%:
	curl -s $(DATA_URL)/$* > $@

$(OUTPUT)/covid_%.$(FORMAT): COVID_in_South_Africa.ipynb $(data) $(static)
	papermill -p province $* -p outformat $(FORMAT) -p show_deathprediction True $< > /dev/null

$(OUTPUT)/vaccinations.$(FORMAT): vaccinations_in_South_Africa.ipynb $(data)
	papermill -p outformat $(FORMAT) $< > /dev/null
