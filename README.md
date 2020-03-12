# Big Brother Test

Big Brother Test is a chart to create a test env for [Big Brother](https://github.com/labbsr0x/big-brother)

## TL;DR;

```console
$ helm repo add  https://charts.bitnami.com/bitnami
$ helm install my-release big-brother-test/
```

## Introduction

This chart bootstraps a basic infra deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.


## Prerequisites

- Kubernetes 1.12+
- Helm 2.11+ or Helm 3.0-beta3+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm install my-release big-brother-test
```

The command deploys big-brother-test on the Kubernetes cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

The following table lists the configurable parameters of the Parse chart and their default values.

| Parameter                              | Description                                                                                                                                               | Default                                                 |
|----------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------|
| `etcd.deploy`                                 | Create the etcd service                                                                                                                              | `true`
| `etcd.port`                                 | Etcd port                                                                                                                              | 2379
| `etcd.image`                                 | Etcd docker image                                                                                                                             | `quay.io/coreos/etcd`                                                   
| `etcd.tag`                                 | Etcd tag image                                                                                                                        | `latest`                                                   
| `generator.service`                    | set REGISTRY_SERVICE on metrics-generator                                                                                                            | `exemple`  |
| `generator.replicaCount`                  | Number of pods for metrics-generator                                                                                                             | `1`                                                   |
| `generator.port`                         | Port of metrics-generator                                                        | `32865`                                                   |
| `generator.image`                                 | Generator docker image                                                                                                                             | `labbsr0x/metrics-generator-tabajara`                                                   
| `generator.tag`                                 | Generator tag image                                                                                                                             | `latest`
| `promster.port`                     | Port of bb-promster                                                                                           | `9090`
| `promster.level`                     | Level of bb-promster                                                                                         | `1`
| `promster.remoteUrl`                     | Set remote write url on bb-promster.                                                                                     | `""`                                                 |
| `promster.image`                                 | Generator docker image                                                                                                                             | `labbsr0x/bb-promster`                                                   
| `promster.tag`                                 | Generator tag image                                                                                                                             | `latest`

The above parameters map to the env variables defined in [big-brother/bb-promster](https://github.com/labbsr0x/bb-promster) and [big-brother/metrics-generator-tabajara](https://github.com/labbsr0x/metrics-generator-tabajara)


Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
$ helm install my-release \
  --set generator.service="example-2",etcd.deploy=false \
    big-brother-test
```

The above command creates a generetor with REGISTRY_SERVICE env set to example-2 and not create etcd deployment.

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```console
$ helm install my-release -f values.yaml big-brother-test
```

> **Tip**: You can use the default [values.yaml](values.yaml)

> **Tip**: After the first service deployed, you should use etcd.deploy=false.