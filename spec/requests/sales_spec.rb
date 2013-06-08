require 'spec_helper'

describe "Sales Requests" do
  describe "GET /sales" do
    it "returns the expected response code and headers" do
      get sales_path
      response.status.should be(200)
    end
  end
end
