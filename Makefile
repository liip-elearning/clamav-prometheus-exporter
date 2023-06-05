image:
	docker build -t clamav-prometheus-exporter -t sysadminliip/clamav-prometheus-exporter:latest .
push: image
	docker push sysadminliip/clamav-prometheus-exporter:latest
