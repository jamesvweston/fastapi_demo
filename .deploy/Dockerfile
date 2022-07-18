FROM python:3.9.13

RUN pip install poetry==1.1.14
#RUN pip install psycopg2==2.9.3

# Configuring poetry
RUN poetry config virtualenvs.create false

COPY ../pyproject.toml  poetry.lock /app/src/
WORKDIR /app/src

# Installing requirements
RUN poetry install

COPY .. /app/src/
RUN poetry install

CMD ["/usr/local/bin/python", "-m", "asdf"]
