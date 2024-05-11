FROM mcr.microsoft.com/mssql/server:2022-latest

ENV SA_PASSWORD P@ssw0rd
ENV ACCEPT_EULA Y
ENV MSSQL_PID Express
USER root

RUN mkdir -p /usr/src/app   
WORKDIR /usr/src/app
COPY . /usr/src/app
RUN chmod +x /usr/src/app/run-initialization.sh

CMD /bin/bash ./entrypoint.sh