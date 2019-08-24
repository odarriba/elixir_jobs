defmodule ElixirJobs.Core.Fields.JobTypeTest do
  use ElixirJobs.DataCase

  alias ElixirJobs.Core.Fields.JobType

  describe "JobType.cast/1" do
    test "recognises valid job types" do
      assert JobType.cast(:full_time) == {:ok, :full_time}
      assert JobType.cast("full_time") == {:ok, :full_time}
    end

    test "recognises invalid job types" do
      assert JobType.cast(:wadus) == :error
      assert JobType.cast(0) == :error
    end
  end

  describe "JobType.load/1" do
    test "translates valid job types" do
      assert JobType.load("full_time") == {:ok, :full_time}
    end

    test "does not translate invalid job types" do
      assert JobType.load("wadus") == :error
      assert JobType.load(0) == :error
    end
  end

  describe "JobType.dump/1" do
    test "translates valid job types" do
      assert JobType.dump(:full_time) == {:ok, "full_time"}
    end

    test "dump/1 does not translate invalid job types" do
      assert JobType.dump(:wadus) == :error
      assert JobType.dump(0) == :error
    end
  end
end
