build:
	CGO_ENABLED=0 && go build -installsuffix 'static' -o clamav-prometheus-exporter .
image:
	docker build -t clamav-prometheus-exporter -t sysadminliip/clamav-prometheus-exporter:latest .
push: image
	docker push sysadminliip/clamav-prometheus-exporter:latest
