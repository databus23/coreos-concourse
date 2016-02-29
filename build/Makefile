build:
	docker build -t concourse-build .
	docker run --rm concourse-build cat linux-binary/concourse_linux_amd64 > concourse_linux_amd64
	chmod +x concourse_linux_amd64
