.PHONY: release

export tag=v1.0

build:
	@echo "===== build image ====="
	docker buildx build --tag dockerkeystone/helloworld:$(tag) .

release:
	@echo "===== release image ====="
	docker buildx build \
	--push \
	--platform=linux/amd64,linux/arm64 \
	--tag dockerkeystone/helloworld:$(tag) \
	--file ./Dockerfile \
	./