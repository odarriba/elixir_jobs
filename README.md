# ElixirJobs

ElixirJobs is a job board based in Elixir + Phoenix.

## Technologies used

1. Erlang 20.0
2. Elixir 1.5.1
3. Phoenix 1.3.0 (with contexts!)
4. PostgreSQl

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

### Users

The project has the model of Administrators, which take care of approving the offers before showing them on the site.

You can create a dummy administration user (credetials: dummy@user.com / 123456)  using the seeds:

```
$ mix run priv/repo/seeds.exs
```

## Thanks

Thanks to anyone which has contributed or it's going to contribute this project. No, seriously, you are awesome.

Also, special thanks to [@rrrene](https://github.com/rrrene) for his awesome job with [ElixirStatus](https://github.com/rrrene/elixirstatus-web), which was the base at the beginning of this project.

## Contribute

All contributions are welcome, and we really hope this repo will serve for beginners as well for more advanced developers.

If you have any doubt, feel free to ask, but always respecting our [Code of Conduct](https://github.com/odarriba/elixir_jobs/blob/master/CODE_OF_CONDUCT.md).
