class UsersController < ApplicationController

  def edit
    @user_id = params[:user_id].present? ? params[:user_id] :  nil
    @metric_id = params[:metric_id].present? ? params[:metric_id] :  nil
    @value_id = params[:value_id].present? ? params[:value_id] :  nil
    @user = @user_id.present? ? JSON.parse(@hoopla_client.get("#{HooplaClient::PUBLIC_API_ENDPOINT}/users/#{@user_id}", "list_user").to_json, object_class: OpenStruct) :  nil
    @metric_value = (@metric_id.present? && @value_id.present?) ? JSON.parse(@hoopla_client.get("#{HooplaClient::PUBLIC_API_ENDPOINT}/metrics/#{@metric_id}/values/#{@value_id}", {}).to_json, object_class: OpenStruct) :  nil
  end

  def update
    @user_id = params[:user_id].present? ? params[:user_id] :  nil
    @metric_id = params[:metric_id].present? ? params[:metric_id] :  nil
    @value_id = params[:value_id].present? ?  params[:value_id] :  nil
    @metric_value = params[:metric_value].present? ? params[:metric_value] :  nil

    @metric = @metric_id.present? ? JSON.parse(@hoopla_client.get("#{HooplaClient::PUBLIC_API_ENDPOINT}/metrics/#{@metric_id}/values/#{@value_id}", {}).to_json, object_class: OpenStruct) :  nil

    @hoopla_client.put("#{HooplaClient::PUBLIC_API_ENDPOINT}/metrics/#{@metric_id}/values/#{@value_id}", {"href": "#{HooplaClient::PUBLIC_API_ENDPOINT}/metrics/#{@metric_id}/values/#{@value_id}", "metric": {"href": "#{HooplaClient::PUBLIC_API_ENDPOINT}/metrics/#{@metric_id}"}, "owner": {"kind": "user", "href": "#{HooplaClient::PUBLIC_API_ENDPOINT}/users/#{@user_id}"}, "value": @metric_value.to_i, "updated_at": @metric.updated_at})
    redirect_to "/metrics/#{@metric_id}"
  end

  def create
    @user_id = params[:user_id].present? ? params[:user_id] :  nil
    @metric_id = params[:metric_id].present? ? params[:metric_id] :  nil
    @metric_value = params[:metric_value].present? ? params[:metric_value] :  nil

    @hoopla_client.post("#{HooplaClient::PUBLIC_API_ENDPOINT}/metrics/#{@metric_id}/values", {"owner": {"kind": "user", "href": "#{HooplaClient::PUBLIC_API_ENDPOINT}/users/#{@user_id}"}, "value": @metric_value.to_i})
    redirect_to "/metrics/#{@metric_id}"
  end
end
