# Flutter-Rb

[![GitHubActions](https://github.com/fartem/flutter-rb/workflows/Ruby/badge.svg)](https://github.com/fartem/flutter-rb/actions?query=workflow%3ARuby)

## About

A Ruby tool for checking a Flutter plugin structure.

__Available checks__

| Check | Description | Status |
| --- | --- | --- |
| `PluginDirectoriesCheck` | Check a Flutter plugin directories structure | `ERROR` |
| `PluginPubspecNameCheck` | Check a Flutter plugin name declaration in pubspec.yaml | `ERROR` |
| `PluginPubspecDescriptionCheck` | Check a Flutter plugin description declaration in pubspec.yaml | `WARNING` |
| `PluginPubspecVersionCheck` | Check a Flutter plugin version declaration in pubspec.yaml | `ERROR` |
| `PluginPubspecAuthorCheck` | Check a Flutter plugin author declaration in pubspec.yaml | `WARNING` |
| `PluginPubspecHomepageCheck` | Check a Flutter plugin homepage declaration in pubspec.yaml | `ERROR` |

## How to use

Add path to tool in `PATH` in shell. Then run from Flutter plugin project root:

```shell
start_flutter-rb
```

## How to contribute

Soon.

## Contributors

- [@fartem](https://github.com/fartem) as Artem Fomchenkov
