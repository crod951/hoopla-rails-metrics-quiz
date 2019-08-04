class MetricsController < ApplicationController

  def show
    @users = JSON.parse(@hoopla_client.get(@hoopla_client.get_relative_url("list_users"), {}).to_json, object_class: OpenStruct)
    metric_param_id = params[:metric_id].present? ? params[:metric_id] :  nil
    @metric = metric_param_id.present? ? JSON.parse(@hoopla_client.get("#{HooplaClient::PUBLIC_API_ENDPOINT}/metrics/#{metric_param_id}", {}).to_json, object_class: OpenStruct) :  nil
    @metric_id = @metric.href.split("/metrics/")[1]
    @metric_data = @hoopla_client.get(@metric.links.first.href, @metric.links.first.rel)

    @users.each do |user|
      user.id = user.href.split("/users/")[1]
      @metric_data.each do |data|
        if data['owner']['kind'] == "user" && user.id == data['owner']['href'].split("/users/")[1]
          user.value = data['value']
          user.value_id = data['href'].split("/values/")[1]
        end
      end
    end
  end
end
