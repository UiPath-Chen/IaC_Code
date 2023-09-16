export tag=v1.0

all: release

release:
	echo "build image"
	docker buildx build --tag dockerkeystone/helloworld:$(tag) .