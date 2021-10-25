# env-rails 🐳

![License](https://img.shields.io/github/license/soso555BoBs/env-rails)
![Stars](https://img.shields.io/github/stars/soso555BoBs/env-rails)
![Issues](https://img.shields.io/github/issues/soso555BoBs/env-rails)
![Forks](https://img.shields.io/github/forks/soso555BoBs/env-rails)

## Introduction

- Build a simple rails development environment with docker-compose.

## Usage

- with creating rails project

    ```bash
    $ git clone git@github.com:soso555BoBs/env-rails.git
    $ cd env-rails
    $ make create-project # Install rails(6.1) project
    ```

- without creating rails project

    ```bash
    $ git clone git@github.com:soso555BoBs/env-rails.git
    $ cd env-rails
    $ git clone git@github.com:rails/rails.git env-rails/backend # Clone any project to the backend directory
    $ make init
    ```

- access
    - backend
        - http://localhost
    - mailhog
        - http://localhost:8025/

## Container structures

```bash
├── app
├── web
├── rredis
├── rmailhog
└── pgsql
```

### app container

- Base image
  - [ruby](https://hub.docker.com/_/ruby/):2.7.4

### web container

- Base image
  - [nginx](https://hub.docker.com/_/nginx):1.20-alpine
  - [node](https://hub.docker.com/_/node):16-alpine

### db container

- Base image
  - [postgres](https://hub.docker.com/_/postgres):12.2-alpine
