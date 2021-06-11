import pathlib
import requests

base_url = "https://raw.githubusercontent.com/dsfsi/covid19za/master/data/"
data = pathlib.Path('data')
output = pathlib.Path('output')

covid_data = [
    data / "covid19za_provincial_cumulative_timeline_confirmed.csv",
    data / "covid19za_provincial_cumulative_timeline_deaths.csv",
]
covid_notebook = 'COVID_in_South_Africa.ipynb'

vacc_data = [   
    data / "covid19za_timeline_vaccination.csv"
]
vacc_notebook = 'vaccinations_in_South_Africa.ipynb'

files = covid_data + vacc_data

provinces = ['GP', 'WC', 'SA']
format = 'pdf'

def download(targets):
    target = pathlib.Path(targets[0])
    r = requests.get(f'{base_url}/{target.name}')
    with target.open('wb') as f:
        f.write(r.content)


def task_download():
    for f in files:
        yield {
            'name': f,
            'targets': [f],
            'actions': [download]
        }


def task_covidreport():
    for province in provinces:
        name = f'covid_{province}.{format}'
        yield {
            'name': name,
            'targets': [output / name],
            'file_dep': covid_data,
            'actions': [
                f'papermill -p province {province} -p outformat {format} -p show_deathprediction True {covid_notebook} > /dev/null'
            ]
        }


def task_vaccinereport():
    return {
        'targets': [output / 'vaccinations.{format}'],
        'file_dep': vacc_data,
        'actions': [
            f'papermill -p outformat {format} {vacc_notebook} > /dev/null'
        ]
    }