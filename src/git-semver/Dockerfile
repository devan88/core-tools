FROM alpine/semver:latest AS base
WORKDIR /tool
COPY ./git-semver.sh .
RUN apk update && apk upgrade && apk add bash
SHELL ["/bin/bash", "-c"]
RUN chmod +x ./git-semver.sh
RUN ln -s /tool/git-semver.sh /usr/local/bin/git-semver
CMD ["git-semver"]