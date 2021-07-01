# pre-commit

A framework for managing and maintaining multi-language pre-commit hooks.

Documentation: https://pre-commit.com

## Usage
Map your local project to the container's /project directory. Example:

```
docker run --rm \
    -v /path/to/repository:/project \
    yysfire/pre-commit:latest-python3 \
    pre-commit run --all-files --verbose --color always
```

## Jenkins
Example stage for Jenkins' declarative pipeline:

```
stages {
    stage('Lint') {
        agent {
            docker {
                image 'yysfire/pre-commit:latest-python3'
                args '-u 0:0'  // Avoid permission-related errors
            }
        }

        steps {
            sh 'pre-commit run --all-files --verbose --color always'
        }
    }
}
```

## GitLab CI
Example job for .gitlab-ci.yml:

```
pre-commit:
  stage: lint
  image: yysfire/pre-commit:latest-python3
  variables:
    SKIP: "no-commit-to-branch"
  script:
    - pre-commit run --verbose --color always --files $(git diff --name-only $CI_COMMIT_BEFORE_SHA $CI_COMMIT_SHA | tr '\n' ' ')
```

## GitHub Actions
Example job for GitHub Actions:

```
jobs:
  pre-commit:
    name: pre-commit
    runs-on: ubuntu-latest
    container:
      image: yysfire/pre-commit:latest-python3
    steps:
      - uses: actions/checkout@v2
      - name: Run pre-commit
        run: |
          pre-commit run --all-files --verbose --color always
```
