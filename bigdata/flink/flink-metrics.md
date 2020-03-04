## Flink+Prometheus+Grafana


wget -c https://github.com/prometheus/prometheus/releases/download/v2.12.0/prometheus-2.12.0.linux-amd64.tar.gz

wget -c https://github.com/prometheus/pushgateway/releases/download/v0.9.1/pushgateway-0.9.1.linux-amd64.tar.gz

service iptables restart    重启防火墙，修改生效
vi /etc/sysconfig/iptables  
-A INPUT -p tcp -m state --state NEW -m tcp --dport 3000 -j ACCEPT   



global:
  scrape_interval:     60s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
  evaluation_interval: 60s # Evaluate rules every 15 seconds. The default is every 1 minute.
  # scrape_timeout is set to the global default (10s).

# Alertmanager configuration
alerting:
  alertmanagers:
  - static_configs:
    - targets:
      # - alertmanager:9093

# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: 'prometheus'
    static_configs:
    - targets: ['localhost:9090']
      labels:
        instance: prometheus

  - job_name: 'pushgateway'
    static_configs:
    - targets: ['my-flink002:9091']
      labels:
        instance: pushgateway

metrics.reporter.promgateway.class: org.apache.flink.metrics.prometheus.PrometheusPushGatewayReporter
# 这里写PushGateway的主机名与端口号
metrics.reporter.promgateway.host: localhost
metrics.reporter.promgateway.port: 9091
# Flink metric在前端展示的标签（前缀）与随机后缀
metrics.reporter.promgateway.jobName: flink-metrics-ppg
metrics.reporter.promgateway.randomJobNameSuffix: true
metrics.reporter.promgateway.deleteOnShutdown: false


nohup ./pushgateway --web.listen-address :9091 > /var/log/pushgateway.log 2>&1 &

nohup ./prometheus --config.file=prometheus.yml > /var/log/prometheus.log 2>&1 &


/root/flink/flink-1.9.2/bin/flink run \
/root/flink/flink-1.9.2/examples/streaming/SocketWindowWordCount.jar \
--port 17777


https://blog.csdn.net/cheyanming123/article/details/101298609

https://www.jianshu.com/p/886378855cea?utm_campaign=haruki