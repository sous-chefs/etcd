# etcd cookbook

## Scope and product

* Full Migration authorised for PR #208 on 2026-09-08. Preserve the six public resource names and the installation/service aliases.
* This was already resource-first: root recipes/ and attributes/ were absent. The migration removes vendored v2 gems, unused init templates and obsolete test profiles; do not claim to remove a recipe API.
* etcd 3.7.1 is the default. Upstream release assets and SHA256SUMS were inspected through the GitHub API. Linux amd64, arm64, ppc64le and s390x archives are published; cookbook binary installation supports amd64 and arm64. Other architectures require an explicit source and checksum.
* Sources: <https://etcd.io/docs/v3.7/install/>, <https://etcd.io/docs/v3.7/op-guide/supported-platform/>, <https://github.com/etcd-io/etcd/releases/tag/v3.7.1>.

## Installation and platforms

* Install official prebuilt archives or the upstream container image. Upstream does not maintain distribution packages; apt/dnf/zypper availability must not determine the etcd version. No source build or compiler is required.
* Preserve supported non-EOL Linux families, including RHEL and SLES. Refresh lifecycle data at <https://endoflife.date/> before altering support.
* Amazon Linux 2 and openSUSE Leap 15 have ended support; use Amazon 2023 and Leap 16. Ubuntu 20.04 has ended standard support; use 22.04 and 24.04. Debian 12 remains within LTS.

## Implementation and verification

* etcd_key must use the v3 API through etcdctl; the vendored Ruby etcd gem only speaks v2. v2 keys are not automatically migrated. Install the client before managing keys.
* Binary resources share /usr/bin binaries. Delete is an explicit uninstall and affects other instances using that installation. Shared users and system directories are retained.
* Systemd stop/restart must perform real service actions. Delete removes the unit, managed configuration, data, WAL, log and legacy marker for that instance.
* Use Policyfile dependencies and real ChefSpec assertions: the previous spec directory was empty despite CI showing RSpec success.
* Prefer privileged Dokken locally and in CI, including Docker with the vfs storage driver. Avoid VirtualBox on GitHub runners: observed VERR_SVM_IN_USE with KVM on main run 34216139491.
* Capture Kitchen logs in /private/tmp and report first failure and idempotency/verification markers. Never describe a skipped suite as passing.

## Verified migration details

* Cinc images require `/opt/cinc/bin/cinc-client` in Dokken. Both the default and Docker suites have passed locally on Ubuntu 24.04 ARM64 with zero updates on the second converge.
* etcdctl uses `version` rather than `--version`. Lease inspection JSON names its original duration `granted-ttl`, unlike the protobuf field name. Keep regression coverage for these command contracts.
* CI tests all configured suite/platform combinations. Workstation remains pinned through install-workstation@9.0.0; the lint runner needs chef-cli for ChefSpec Policyfile support.

* Docker test fixtures use the distribution package on openSUSE because get.docker.com rejects that distribution. Do not pass --allowerasing as a global option on Fedora's DNF5. These are test-daemon setup constraints, not reasons to remove etcd platform support.
