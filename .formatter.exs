[
  inputs: [
    "lib/**/*.{ex,exs}",
    "test/**/*.{ex,exs}",
    "mix.exs"
  ],
  locals_without_parens: [
    ## ECTO
    # Query
    from: 2,

    # Schema
    field: 1,
    field: 2,
    field: 3,
    timestamps: 0,
    timestamps: 1,
    belongs_to: 2,
    belongs_to: 3,
    has_one: 2,
    has_one: 3,
    has_many: 2,
    has_many: 3,
    many_to_many: 2,
    many_to_many: 3,
    embeds_one: 2,
    embeds_one: 3,
    embeds_one: 4,
    embeds_many: 2,
    embeds_many: 3,
    embeds_many: 4,

    ## PLUG
    plug: 1,
    plug: 2,
    forward: 2,
    forward: 3,
    forward: 4,
    match: 2,
    match: 3,
    get: 2,
    get: 3,
    get: 4,
    post: 2,
    post: 3,
    put: 2,
    put: 3,
    patch: 2,
    patch: 3,
    delete: 2,
    delete: 3,
    options: 2,
    options: 3,
    pipe_through: 1,

    #EctoEnum
    defenum: 3
  ]
]
