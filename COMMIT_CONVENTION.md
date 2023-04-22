# Commit Convention

## How to work with a project

### As a repository maintainer

#### New update

1. clone a project from a repository to local workspace;
2. create a new branch for an update;
3. complete the update;
4. perform a Code Review;
5. merge your branch with `master`;
6. delete your branch.

#### Notes

1. always delete development branches;
2. always push squashed commit to `master`.

### As a contributor

1. clone a project from a repository to local workspace;
2. create a new branch for an update;
3. complete the update;
4. perform a Code Review;
5. create a Pull Request to the original repository.

## Branches

### In projects using next types of branches

* `master` - master branch. Contains a production version of the project. Don't push working changes to `master`!
* `version` - branch for a specific version.
* `issue` - branch for a specific issue.

## Commit message structure

### Template

```text
[DATE] [VERSION]: [MESSAGE]
```

### Example

```text
2019-05-12 v. 2.1.3: fixed bugs in History screen
```

#### Commit body sections order

1. `added` - what was added in the commit;
2. `closed` - what issues closed in the commit;
3. `fixed` - what was fixed in the commit;
4. `updated` - what was updated in the commit;
5. `deleted` - what was deleted in the commit;
6. `refactored` - what was refactored in the commit.
