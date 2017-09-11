defmodule ElixirJobs.EctoEnums do
  import EctoEnum

  defenum JobType, :job_type, [:unknown, :full_time, :part_time, :freelance]
  defenum JobPlace, :job_place, [:unknown, :onsite, :remote, :both]
end
