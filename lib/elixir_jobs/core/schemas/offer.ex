defmodule ElixirJobs.Core.Schemas.Offer do
  @moduledoc """
  Offer schema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias ElixirJobs.Core.Fields.JobPlace
  alias ElixirJobs.Core.Fields.JobType

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "offers" do
    field :title, :string
    field :company, :string
    field :location, :string
    field :url, :string
    field :slug, :string
    field :summary, :string

    field :job_place, JobPlace
    field :job_type, JobType

    field :contact_email, :string

    field :published_at, :utc_datetime

    timestamps(type: :utc_datetime)
  end

  @required_attrs [
    :title,
    :company,
    :contact_email,
    :location,
    :url,
    :job_place,
    :job_type,
    :summary
  ]
  @optional_attrs [:published_at, :slug]

  @email_regexp ~r/^[A-Za-z0-9._%+-+']+@[A-Za-z0-9.-]+\.[A-Za-z]+$/
  @url_regexp ~r/^\b((https?:\/\/?)[^\s()<>]+(?:\([\w\d]+\)|([^[:punct:]\s]|\/)))$/

  @doc false
  def changeset(offer, attrs) do
    offer
    |> cast(attrs, @required_attrs ++ @optional_attrs)
    |> validate_required(@required_attrs)
    |> validate_length(:title, min: 5, max: 50)
    |> validate_length(:company, min: 2, max: 30)
    |> validate_length(:summary, min: 10, max: 2000)
    |> validate_length(:location, min: 3, max: 50)
    |> validate_length(:url, min: 1, max: 255)
    |> validate_format(:url, @url_regexp)
    |> validate_length(:contact_email, min: 1, max: 255)
    |> validate_format(:contact_email, @email_regexp)
    |> validate_inclusion(:job_place, JobPlace.available_values())
    |> validate_inclusion(:job_type, JobType.available_values())
    |> unique_constraint(:slug)
    |> generate_slug()
  end

  defp generate_slug(changeset) do
    case get_field(changeset, :slug) do
      nil -> put_change(changeset, :slug, do_generate_slug(changeset))
      _ -> changeset
    end
  end

  defp do_generate_slug(changeset) do
    uid =
      Ecto.UUID.generate()
      |> to_string()
      |> String.split("-")
      |> List.first()

    title =
      changeset
      |> get_field(:title)
      |> Kernel.||("")
      |> Slugger.slugify_downcase()

    company =
      changeset
      |> get_field(:company)
      |> Kernel.||("")
      |> Slugger.slugify_downcase()

    "#{company}-#{title}-#{uid}"
  end
end
