# Flutter-Rb

[![GitHubActions](https://github.com/fartem/flutter-rb/workflows/Ruby/badge.svg)](https://github.com/fartem/flutter-rb/actions?query=workflow%3ARuby)

## About

A Ruby tool for checking a Flutter plugin structure.

### Checks

#### Levels

| Level | Description |
| --- | --- |
| `NORMAL` | Issue not found |
| `WARNING` | Not serious issue, cannot break build |
| `ERROR` | Serious issue, may break build |

#### Flutter

| Check | Description | Level |
| --- | --- | --- |
| `PluginDirectoriesCheck` | Soon | `ERROR` |
| `PluginPubspecNameCheck` | Soon | `ERROR` |
| `PluginPubspecDescriptionCheck` | Soon | `WARNING` |
| `PluginPubspecVersionCheck` | Soon | `ERROR` |
| `PluginPubspecAuthorCheck` | Soon | `WARNING` |
| `PluginPubspecHomepageCheck` | Soon | `ERROR` |

#### Android

| Check | Description | Level |
| --- | --- | --- |
| `PluginGradleVersionCheck` | Soon | `WARNING` |

#### iOS

| Check | Description | Level |
| --- | --- | --- |
| `PluginPodspecNameCheck` | Soon | `WARNING` |
| `PluginPodspecVersionCheck` | Soon | `WARNING` |
| `PluginPodspecSourceCheck` | Soon | `ERROR` |

## How to use

Add path to tool in `PATH` in shell. Then run from Flutter plugin project root:

```shell
flutterrb
```

## How to contribute

Read [Commit Convention](https://github.com/fartem/repository-rules/blob/master/commit-convention/COMMIT_CONVENTION.md). Make sure your build is green before you contribute your pull request. Then:

```shell
rake rubocop
```

If you don't see any error messages, submit your pull request.

## Contributors

- [@fartem](https://github.com/fartem) as Artem Fomchenkov
