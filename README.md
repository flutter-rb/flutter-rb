<!--suppress CheckImageSize -->
<img src="media/logo/ic_lib.png" height="100px" alt="Project's logo">

# flutter_rb

[![GitHubActions](https://github.com/flutter-rb/flutter-rb/workflows/Build/badge.svg)](https://github.com/flutter-rb/flutter-rb/actions?branch=master)
[![Codebeat](https://codebeat.co/badges/9bb32e28-ca86-4cdc-ba66-bda7f989979a)](https://codebeat.co/projects/github-com-flutter-rb-flutter-rb-master)
[![Gem Version](https://badge.fury.io/rb/flutter_rb.svg)](https://badge.fury.io/rb/flutter_rb)
[![Gem Downloads](https://img.shields.io/gem/dt/flutter_rb)](https://badge.fury.io/rb/flutter_rb)

## About

A tool for checking a Flutter plugin structure.

### Checks

#### Levels

Each issue has a `level` parameter that describes its significant importance.

| Level     | Description                                  |
|-----------|----------------------------------------------|
| `NORMAL`  | Issue not found                              |
| `WARNING` | Issue is not serious and can't break a build |
| `ERROR`   | Issue is critical and can break a build      |

#### Flutter

| Check                            | Description                                                                                                                                                                        | Level     |
|----------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------|
| `PluginDirectoriesCheck`         | Check plugin directories structure in pubspec file. Example: if a Flutter plugin has only Android specific code but not contains iOS folder with description, then iOS build fails | `ERROR`   |
| `PluginPubspecNameCheck`         | Check plugin name in pubspec file. Exists or not                                                                                                                                   | `ERROR`   |
| `PluginPubspecDescriptionCheck`  | Check plugin description in pubspec file. Exists or not                                                                                                                            | `WARNING` |
| `PluginPubspecVersionCheck`      | Check plugin version in pubspec. Exists or not                                                                                                                                     | `ERROR`   |
| `PluginPubspecAuthorCheck`       | Check plugin author in pubspec. Exists or not. `author` section deprecated in `pubspec.yaml`                                                                                       | `WARNING` |
| `PluginPubspecHomepageCheck`     | Check plugin homepage in pubspec. Exists or not                                                                                                                                    | `ERROR`   |
| `PluginPubspecLintsCheck`        | Check Flutter plugin `lints` dependency in pubspec file. Exists or not                                                                                                             | `ERROR`   |
| `PluginPubspecFlutterLintsCheck` | Check Flutter plugin `flutter_lints` dependency in pubspec file. Exists or not                                                                                                     | `ERROR`   |

#### Android

| Check                             | Description                                                                                                                   | Level     |
|-----------------------------------|-------------------------------------------------------------------------------------------------------------------------------|-----------|
| `PluginGradleAndroidPackageCheck` | Validate that \android\ package not exists in Gradle project config (build.gradle file)                                       | `ERROR`   |
| `PluginGradleVersionCheck`        | Check plugin version in Gradle project config (build.gradle file). Version must be the same as plugin version in pubspec file | `WARNING` |

#### iOS

| Check                       | Description                                                                                                                  | Level     |
|-----------------------------|------------------------------------------------------------------------------------------------------------------------------|-----------|
| `PluginPodspecNameCheck`    | Check plugin name in podspec file. Exists or not                                                                             | `WARNING` |
| `PluginPodspecVersionCheck` | Check plugin version in podspec file. Exists or not                                                                          | `WARNING` |
| `PluginPodspecAuthorsCheck` | Check plugin's authors in podspec file. Exists or not                                                                        | `ERROR`   |
| `PluginPodspecSourceCheck`  | Check plugin iOS source path in podspec file. If Flutter plugin cannot contains iOS specific code, source path must be `'.'` | `ERROR`   |

## How to use

### Android

You should add [flutter-rb-gradle-plugin](https://github.com/flutter-rb/flutter-rb-gradle-plugin) to Android side of
your plugin.

### Download gem from RubyGems

```shell
$ gem i flutter_rb
```

Then run from a Flutter plugin's project folder:

```shell
$ frb
```

### As local installed gem

Build and install gem from sources:

```shell
$ gem build flutter_rb.gemspec
$ gem i flutter_rb
```

Then run from a Flutter plugin's project folder:

```shell
$ frb
```

### As local executable

Add `project_folder/bin` (where `project_folder` is path to project on your machine) to `PATH` variable in your
environment. Then updated environment and run from a Flutter plugin's project folder:

```shell
$ local_frb
```

### Arguments

| Argument   | Description                                                                                        |
|------------|----------------------------------------------------------------------------------------------------|
| `--path`   | Path to Dart/Flutter project. flutter-rb will be use current directory if this parameter are empty |
| `--report` | Generate report in Checkstyle format                                                               |

### Configuration

Add `.flutter_rb.yaml` to root of a project for select checks that you are want to exclude:

```yaml
exclude:
  flutter:
    - check1
    - check2
    - check3
  android:
    - check1
    - check2
  ios:
    - check1
    - check2

```

### Output report

Tool can make report in Checkstyle format. To enable this feature, pass `--checkstyle-report` as an CLI argument. The
report file name is `frb-checkstyle-report.xml`.

## How to contribute

### Documentation

Just run:

```shell
$ rdoc
```

### Contribution

Read [Commit Convention](./COMMIT_CONVENTION.md). Make sure your build is green before you contribute your pull request.
Then:

```shell
$ bundle exec rake
```

If you don't see any error messages, submit your pull request.

## Contributors

- [@fartem](https://github.com/fartem) as Artem Fomchenkov
