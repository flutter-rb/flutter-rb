<img src="media/logo/ic_lib.png" height="100px">

# flutter_rb

[![GitHubActions](https://github.com/fartem/flutter_rb/workflows/Build/badge.svg)](https://github.com/fartem/flutter_rb/actions?query=workflow%3ARuby)
[![Codebeat](https://codebeat.co/badges/9bb32e28-ca86-4cdc-ba66-bda7f989979a)](https://codebeat.co/projects/github-com-fartem-flutter_rb-master)
[![Coverage](https://coveralls.io/repos/github/fartem/flutter_rb/badge.svg?branch=master)](https://coveralls.io/github/fartem/flutter_rb?branch=master)

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
| `PluginPubspecAuthorCheck` | Check plugin author in pubspec. Exists or not. `author` section deprecated in `pubspec.yaml` | `WARNING` |
| `PluginPubspecHomepageCheck` | Check plugin homepage in pubspec. Exists or not | `ERROR` |
| `PluginPubspecEffectiveDartCheck` | Check Flutter plugin Effective Dart depencency in pubspec file. Exists or not | `ERROR` |

#### Android

| Check | Description | Level |
| --- | --- | --- |
| `PluginGradleVersionCheck` | Check plugin version in Gradle project config (build.gradle file). Version must be the same as plugin version in pubspec file | `WARNING` |

#### iOS

| Check | Description | Level |
| --- | --- | --- |
| `PluginPodspecNameCheck` | Check plugin name in podspec file. Exists or not | `WARNING` |
| `PluginPodspecVersionCheck` | Check plugin version in podspec file. Exists or not | `WARNING` |
| `PluginPodspecAuthorsCheck` | Check plugin's authors in podspec file. Exists or not | `ERROR` |
| `PluginPodspecSourceCheck` | Check plugin iOS source path in podspec file. If Flutter plugin cannot contains iOS specific code, source path must be `'.'` | `ERROR` |

## How to use

### As local installed gem

Build gem from sources:

```shell
gem build flutter_rb.gemspec
```

Install gem:

```shell
gem i flutter_rb
```

Then run from Flutter project:
<!--  -->
```shell
frb
```

### As local executable

Add `project_folder/bin` (where `project_folder` is path to project on your machine) to PATH variable. Then updated environment and run from Flutter project:

```shell
local_frb
```

### Arguments

| Argument | Description |
| --- | --- |
| `--help` | Print help info |
| `--checkstyle-report` | Generate report in Checkstyle format |

### Output report

Tool can make report in Checkstyle format. To enable this feature, pass `--checkstyle-report` as an cli argument. The report file name is `frb-checkstyle-report.xml`.

## How to contribute

Read [Commit Convention](https://github.com/fartem/repository-rules/blob/master/commit-convention/COMMIT_CONVENTION.md). Make sure your build is green before you contribute your pull request. Then:

```shell
bundle exec rake
```

If you don't see any error messages, submit your pull request.

## Contributors

- [@fartem](https://github.com/fartem) as Artem Fomchenkov
