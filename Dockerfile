FROM python:3.9

RUN pip3 install dbt-core
RUN pip3 install dbt-postgres
RUN pip3 install dbt-osmosis[workbench]
