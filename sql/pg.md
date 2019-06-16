
docker pull postgres:9.4

docker run --name postgres -e POSTGRES_PASSWORD=123456 -p 5432:5432 -d postgres:9.4


