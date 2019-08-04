class DashboardsController < ApplicationController

  def index
    @metrics = JSON.parse(@hoopla_client.get(@hoopla_client.get_relative_url("list_metrics"), {}).to_json, object_class: OpenStruct)
  end
end
