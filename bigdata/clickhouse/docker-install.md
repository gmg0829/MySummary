```
mkdir /work/clickhouse/clickhouse-test-db

docker run -d --name clickhouse-test-server --ulimit nofile=262144:262144 -p 8123:8123 -p 9000:9000 -p 9009:9009 --volume=/work/clickhouse/clickhouse_test_db:/var/lib/clickhouse yandex/clickhouse-server

docker run -it --rm --link clickhouse-test-server:clickhouse-server yandex/clickhouse-client --host clickhouse-server

docker run -i --rm --link clickhouse-test-server:clickhouse-server yandex/clickhouse-client --host clickhouse-server \
--query "INSERT INTO test.ontime FORMAT CSV" < /work/clickhouse/clickhouse_test_db/ontime.csv

```