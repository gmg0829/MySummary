```
docker run -d --name=espn-50 -p 9200:9200 -p 9300:9300  -v /var/espn/config/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml -v /var/espn/data:/usr/share/elasticsearch/data elasticsearch:5.6.9

./bin/elasticsearch-plugin install https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v5.6.9/elasticsearch-analysis-ik-5.6.9.zip


./bin/elasticsearch-plugin install https://github.com/medcl/elasticsearch-analysis-pinyin/releases/download/v5.6.9/elasticsearch-analysis-pinyin-5.6.9.zip

docker run -p 9100:9100 mobz/elasticsearch-head:5
```