# AWX custom Execution Environment - linting

An Ansible execution environment for a private AWX and other systems - linting set.
This repo is based on the ansible/awx-ee repo, but also got inspired by the ansible/creator-ee and ansible-runner repo.

## Regenerating the build context with podman

```bash
$ tox -epodman
```

## Regenerating the build context with docker

```bash
$ tox -edocker
```
