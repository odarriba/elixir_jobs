defmodule ElixirJobs.Core.Fields.JobPlaceTest do
  use ElixirJobs.DataCase

  alias ElixirJobs.Core.Fields.JobPlace

  describe "JobPlace.cast/1" do
    test "recognises valid job places" do
      assert JobPlace.cast(:onsite) == {:ok, :onsite}
      assert JobPlace.cast("onsite") == {:ok, :onsite}
    end

    test "recognises invalid job places" do
      assert JobPlace.cast(:wadus) == :error
      assert JobPlace.cast(0) == :error
    end
  end

  describe "JobPlace.load/1" do
    test "translates valid job places" do
      assert JobPlace.load("onsite") == {:ok, :onsite}
    end

    test "does not translate invalid job places" do
      assert JobPlace.load("wadus") == :error
      assert JobPlace.load(0) == :error
    end
  end

  describe "JobPlace.dump/1" do
    test "translates valid job places" do
      assert JobPlace.dump(:onsite) == {:ok, "onsite"}
    end

    test "dump/1 does not translate invalid job places" do
      assert JobPlace.dump(:wadus) == :error
      assert JobPlace.dump(0) == :error
    end
  end
end
