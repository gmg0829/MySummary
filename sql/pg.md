
docker pull postgres:9.4

docker run --name postgres -e POSTGRES_PASSWORD=123456 -p 5432:5432 -d postgres:9.4

docker run --name productPostgres -v /data/pgdata:/var/lib/postgresql/data -e POSTGRES_PASSWORD=elensdata -p 54321:5432 -d postgres:9.4