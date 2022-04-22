# A simple COVID model for South Africa
This repository contains a notebook which plots the COVID cases and deaths in South Africa.

The notebook also fits a simple model which connects the cases to the deaths.

I am not an epidemiologist, so take this with a grain of salt.

To get started and install dependencies you can do
```shell
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

This should allow you to run the main notebook.
To generate all the output graphs run

```shell
doit -n 16
```
