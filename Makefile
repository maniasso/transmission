VERSION ?= 4.0.4
CACHE ?= --no-cache=1
FULLVERSION ?= 4.0.4
archs ?= amd64 arm32v6 arm64v8 i386

.PHONY: all build publish latest
all: build publish latest
qemu-arm-static:
	cp /usr/bin/qemu-arm-static .
qemu-aarch64-static:
	cp /usr/bin/qemu-aarch64-static .
build: qemu-aarch64-static qemu-arm-static
	$(foreach arch,$(archs), \
		cat Dockerfile | sed "s/FROM alpine/FROM ${arch}\/alpine/g" > .Dockerfile; \
		docker build -t jaymoulin/transmission:${VERSION}-$(arch) --build-arg VERSION=${VERSION} -f .Dockerfile ${CACHE} .;\
	)
publish:
	docker push jaymoulin/transmission -a
	cat manifest.yml | sed "s/\$$VERSION/${VERSION}/g" > manifest.yaml
	cat manifest.yaml | sed "s/\$$FULLVERSION/${FULLVERSION}/g" > manifest2.yaml
	mv manifest2.yaml manifest.yaml
	manifest-tool push from-spec manifest.yaml
latest: build
	FULLVERSION=latest VERSION=${VERSION} make publish
