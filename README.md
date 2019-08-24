# Elixir Jobs

Elixir Jobs is a job board based in Elixir + Phoenix.

## Technologies used

- Erlang 22.0
- Elixir 1.9.1
- Phoenix 1.4
- PostgreSQL

Some of the versions are set on `.tool_versions` file, so you can use it with [asdf version manager](https://github.com/asdf-vm/asdf)

## Start the project

The project should be installed and set up like any other elixir project.

```
$ cd elixir_jobs
$ mix deps.get
$ mix ecto.create
$ mix ecto.migrate
```

You might encounter some errors about the secrets files. That's because you need to copy the template files under `./config` and personalise them with your local configuration.

Also, assets now live on `./assets`, so NPM and brunch configurations are there.

### Seeds

The project has the model of Administrators, which take care of approving the offers before showing them on the site.

You can create a dummy administration user (credetials: dummy@user.com / 123456)  using the seeds:

```
$ mix run priv/repo/seeds.exs
```

## Contribute

All contributions are welcome, and we really hope this repo will serve for beginners as well for more advanced developers.

If you have any doubt, feel free to ask, but always respecting our [Code of Conduct](https://github.com/odarriba/elixir_jobs/blob/master/CODE_OF_CONDUCT.md).

To contribute, create a fork of the repository, make your changes and create a PR. And remember, talking on PRs/issues is a must!
