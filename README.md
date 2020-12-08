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
| `PluginDirectoriesCheck` | Check plugin directories structure in pubspec file. Example: if a Flutter plugin has only Android specific code but not contains iOS folder with description, then iOS build fails | `ERROR` |
| `PluginPubspecNameCheck` | Check plugin name in pubspec file. Exists or not | `ERROR` |
| `PluginPubspecDescriptionCheck` | Check plugin description in pubspec file. Exists or not | `WARNING` |
| `PluginPubspecVersionCheck` | Check plugin version in pubspec. Exists or not | `ERROR` |
| `PluginPubspecAuthorCheck` | Check plugin author in pubspec. Exists or not | `WARNING` |
| `PluginPubspecHomepageCheck` | Check plugin homepage in pubspec. Exists or not | `ERROR` |
| `PluginPubspecEffectiveDartCheck` | Check Flutter plugin Effective Dart depencency in pubspec file. Exists or not | `ERROR` |

#### Android

| Check | Description | Level |
| --- | --- | --- |
| `PluginGradleVersionCheck` | Check plugin version in Gradle project config (build.gradle file). Version must be the same as plugin version in pubspec.yaml | `WARNING` |

#### iOS

| Check | Description | Level |
| --- | --- | --- |
| `PluginPodspecNameCheck` | Check plugin name in podspec file. Exists or not | `WARNING` |
| `PluginPodspecVersionCheck` | Check plugin version in podspec file. Exists or not | `WARNING` |
| `PluginPodspecSourceCheck` | Check plugin iOS source path in podspec file. If Flutter plugin cannot contains iOS specific code, source path must be `'.'` | `ERROR` |

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
