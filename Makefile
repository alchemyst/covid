TODAY := $(shell gdate -I)
#DATA_URL=https://raw.githubusercontent.com/dsfsi/covid19za/master/data
PROVINCES = GP SA
FORMAT = pdf

outputs = $(foreach province,$(PROVINCES),covid_$(TODAY)_$(province).$(FORMAT))

#datafiles = covid19za_provincial_cumulative_timeline_confirmed.csv covid19za_provincial_cumulative_timeline_deaths.csv

#data = $(addprefix data/,$(datafiles))

all: $(outputs)

# data_$(TODAY):
# 	[ -e $@ ] || touch $@

# data/%: data_$(TODAY)
# 	cd data; wget $(DATA_URL)/$*

covid_$(TODAY)_%.$(FORMAT): COVID_in_South_Africa.ipynb #$(data)
	papermill -p province $* -p outformat $(FORMAT) $< > /dev/null
