require 'rails_helper'

RSpec.describe "DashboardsControllers", type: :request do
  describe "GET /dashboards_controllers" do
    it "works! (now write some real specs)" do
      get dashboards_controllers_path
      expect(response).to have_http_status(200)
    end
  end
end
