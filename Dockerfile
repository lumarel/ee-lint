ARG PYTHON_BASE_IMAGE=quay.io/ansible/python-base:latest
ARG PYTHON_BUILDER_IMAGE=quay.io/ansible/python-builder:latest
ARG ANSIBLE_BRANCH=""

FROM $PYTHON_BUILDER_IMAGE as builder
# =============================================================================
ARG ANSIBLE_BRANCH

COPY . /tmp/src
RUN if [ "$ANSIBLE_BRANCH" != "" ] ; then \
      echo "Installing requirements.txt / upper-constraints.txt for Ansible $ANSIBLE_BRANCH" ; \
      cp /tmp/src/tools/requirements-$ANSIBLE_BRANCH.txt /tmp/src/requirements.txt ; \
      cp /tmp/src/tools/upper-constraints-$ANSIBLE_BRANCH.txt /tmp/src/upper-constraints.txt ; \
    else \
      echo "Installing requirements.txt" ; \
      cp /tmp/src/tools/requirements.txt /tmp/src/requirements.txt ; \
    fi \
    && cp /tmp/src/tools/build-requirements.txt /tmp/src/build-requirements.txt \
    && cp /tmp/src/tools/bindep.txt /tmp/src/bindep.txt

ENV PIP_OPTS=--no-build-isolation
RUN assemble

FROM $PYTHON_BASE_IMAGE
# =============================================================================

COPY --from=builder /output/ /output
RUN /output/install-from-bindep \
  && rm -rf /output

ENTRYPOINT []
CMD /bin/bash
