defmodule Flightex.Bookings.ReportTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex.Bookings.Agent, as: BookingsAgent
  alias Flightex.Bookings.Report

  describe "create/1" do
    test "can create the report file" do
      BookingsAgent.start_link()

      build(:booking, id: "1") |> BookingsAgent.save()
      build(:booking, id: "2") |> BookingsAgent.save()

      expected_response =
        "1,São Paulo,Rio de Janeiro,2021-04-30 10:04:00\n" <>
          "2,São Paulo,Rio de Janeiro,2021-04-30 10:04:00\n"

      Report.create(~N[2020-01-01 00:00:00], ~N[2022-01-01 00:00:00], "report_test.csv")

      response = File.read!("report_test.csv")

      assert response == expected_response
    end
  end
end
