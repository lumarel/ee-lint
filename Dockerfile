ARG ANSIBLE_BUILD_VERSION

FROM quay.io/lumarel/ee-default:$ANSIBLE_BUILD_VERSION
USER root

RUN python3 -m pip install ansible-lint ansible-lint-junit
