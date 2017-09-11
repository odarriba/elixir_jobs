defmodule ElixirJobs.EctoEnums do
  import EctoEnum

  defenum JobTime, :job_time, [:unknown, :full_time, :part_time, :freelance]
  defenum JobType, :job_type, [:unknown, :onsite, :remote, :both]
end
