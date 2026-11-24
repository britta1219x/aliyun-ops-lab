# aliyun-ops-lab

2026 年 11 月在阿里云 ECS（2 核 4G，Ubuntu 22.04）上做的运维练习，这里放的是用到的配置和脚本。

## 目录

- mysql/：MySQL 8.0 主从的每日备份脚本，备份上传到 OSS。OSS 配了生命周期和到上海的跨区域复制，并做过异地恢复演练。
- monitoring/：Prometheus、Grafana、mysqld_exporter、node_exporter、Loki、Alloy 的 docker compose 配置。
- k8s/：k3s 上的应用部署、HPA、RBAC、Helm chart，以及 CI/CD 发布用的 ServiceAccount。
- terraform/：lab 是 VPC 和安全组的练习；import 用 import 块纳管已有安全组，state 放在 OSS。
- ansible/：系统加固、Docker、node_exporter 三个角色。

CI/CD 由 GitHub Actions 构建镜像推送到 ACR，再由服务器上的自托管 runner 发布到 k3s。

## 说明

- 密码、AccessKey 和 Terraform state 不在仓库里。monitoring 需要自己创建 .env（参考 .env.example）和 grafana-smtp.env。
- IP 地址和镜像仓库地址已替换成占位符。
- 负载均衡和弹性伸缩（CLB + ESS）是在控制台操作的，实验后已释放，没有配置文件。
