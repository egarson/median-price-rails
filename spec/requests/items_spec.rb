require 'spec_helper'

describe "Items Requests" do
  describe "GET /items" do
    it "returns the expected response status" do
      get items_path
      response.status.should be(200)
    end
  end
end
