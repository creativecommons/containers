# containers

Creative Commons (CC) containers images (primarily for use by CC application
container images).


## Images

- `trixie`
  - Documentation: [trixie/](trixie/)
  - GHCR: [Package trixie][pkg-trixie]
- `trixie-msmtp`
  - Documentation: [trixie-msmtp/](trixie-msmtp/)
  - GHCR: [Package trixie-msmtp][pkg-trixie-msmtp]

[pkg-trixie]: https://github.com/creativecommons/containers/pkgs/container/trixie
[pkg-trixie-msmtp]: https://github.com/creativecommons/containers/pkgs/container/trixie-msmtp


## Development

Local development uses Docker Compose and a suite of static analysis tools.


### Dependencies

1. Install Docker ([Get Docker | Docker Docs][docker-install])
2. Install additional dependencies
   macOS installation example (assumes [Homebrew][brew]):
   ```shell
   brew install gh hadolint prek shellcheck
   ```
   ```shell
   gh extension install github/gh-actions-lock
   ```
   1. Install hadolint ([Install - hadolint/hadolint][hadolint-install])
   2. Install prek ([Installation - j178/prek][prek-install])
   3. Install shellcheck ([Installing -
      koalaman/shellcheck][shellcheck-install])
   4. Install gh ([Installation - github/cli/cli][gh-install])
   5. Install gh-actions-lock ([Install - github/gh-actinos-lock][lock-install])


[docker-install]: https://docs.docker.com/get-started/get-docker/
[brew]: https://brew.sh/
[hadolint-install]: https://github.com/hadolint/hadolint#install
[prek-install]: https://github.com/j178/prek#installation
[shellcheck-install]: https://github.com/koalaman/shellcheck#installing
[gh-install]: https://github.com/cli/cli#installation
[lock-install]: https://github.com/github/gh-actions-lock#install


## Setup

1. Prepare and install prek Git hooks:
   ```shell
   prek install --prepare-hooks
   ```
2. Create the environment `.env` file by copying
   [`.env.example`](.env.example):
    ```shell
    cp .env.example .env
    ```
2. Update `.env` to ensure all variable have appropriate values.
3. Build Docker Compose services:
    ```shell
    docker-compose build
    ```


### Static analysis

Analysis on git commit is configure in Setup, step 1, above.

Prek can be invoked manually:
```shell
prek run --show-diff-on-failure --color=always --all-files
```


## License

[![CC0 1.0 Universal (CC0 1.0) Public Domain Dedication
button][cc-zero-png]][cc-zero]

[`LICENSE`](LICENSE): The contents of this repository are dedicated to the
public domain under the [CC0 1.0 Universal (CC0 1.0) Public Domain
Dedication][cc-zero].

[cc-zero-png]: https://licensebuttons.net/l/zero/1.0/88x31.png "CC0 1.0 Universal badge"
[cc-zero]: https://creativecommons.org/publicdomain/zero/1.0/ "CC0 1.0 Universal - Creative Commons"
