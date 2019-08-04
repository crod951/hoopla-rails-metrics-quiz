class UsersController < ApplicationController

  def edit
    user_id = params[:user_id].present? ? params[:user_id] :  nil
    metric_id = params[:metric_id].present? ? params[:metric_id] :  nil
    value_id = params[:value_id].present? ? params[:value_id] :  nil
    @user = user_id.present? ? JSON.parse(@hoopla_client.get("#{HooplaClient::PUBLIC_API_ENDPOINT}/users/#{user_id}", "list_user").to_json, object_class: OpenStruct) :  nil
    @metric_value = (metric_id.present? && value_id.present?) ? JSON.parse(@hoopla_client.get("#{HooplaClient::PUBLIC_API_ENDPOINT}/metrics/#{metric_id}/values/#{value_id}", {}).to_json, object_class: OpenStruct) :  nil
  end
end
