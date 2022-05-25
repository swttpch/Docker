FROM mysql:5.7

#adicionando o database
ENV MYSQL_DATABASE monitech
ENV MYSQL_ROOT_PASSWORD sptech

#executar automatico
COPY ./scripts/ /docker-entrypoint-initdb.d/

EXPOSE 3306


