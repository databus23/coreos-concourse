FROM  concourse/bin-ci
WORKDIR /build

RUN git clone https://github.com/concourse/concourse.git && cd concourse && \
    git reset --hard v0.74.0 && git submodule init && git submodule update

RUN git clone https://github.com/concourse/bin.git && cd bin && \
    git reset --hard 0935c42731ec449adb4cefa92d477b37c9e9e25d  && \
    git submodule init && git submodule update

#build cli-artifacts
RUN bin/ci/build-cli-artifacts

RUN git clone https://github.com/cloudfoundry-incubator/garden-linux-release.git && \
    cd garden-linux-release && \
    git reset --hard 8105b31715f81e919bf8e79831561541199790a1 && \
    git submodule init && git submodule update

RUN mkdir -p gopath/src/github.com/concourse && ln -s $(pwd)/bin gopath/src/github.com/concourse/bin

ENV GOPATH=/build/gopath:/build/concourse \
    PATH=/build/gopath/bin:/build/concourse/bin:$PATH

RUN go get github.com/jteeuwen/go-bindata/go-bindata

RUN gopath/src/github.com/concourse/bin/scripts/build-linux
RUN cd linux/resources && rm -rf bosh* cf git pool semver tracker github-release s3 time vagrant-cloud
RUN wget -O linux/resources/docker-image https://s3.amazonaws.com/concourse-blobs/3e11d349-c283-4620-b94a-1b0e0f86e132
ADD . .
RUN go-bindata -pkg bindata -o gopath/src/github.com/concourse/bin/bindata/bindata.go cli-artifacts/... linux/...
RUN go build -o linux-binary/concourse_linux_amd64 github.com/concourse/bin/cmd/concourse
