

# require 'google/apis/people_v1'
# require 'google/api_client/client_secrets.rb'


class ApplicationController < ActionController::Base

  # app/controller/application_controller.rb

  # People = Google::Apis::PeopleV1
  # def contacts
  #   secrets = Google::APIClient::ClientSecrets.new(
  #     {
  #       "web" =>
  #         {
  #           "access_token" => current_user.token,
  #           "refresh_token" => current_user.refresh_token,
  #           "client_id" => Rails.application.credentials.google[:client_id],
  #           "client_secret" => Rails.application.credentials.google[:client_secret]
  #         }
  #     }
  #   )
  #   service = People::PeopleServiceService.new
  #   service.authorization = credentials.to_authorization
  #   response = service.list_person_connections(
  #     'people/me',
  #      person_fields: ['names', 'emailAddresses', 'phoneNumbers']
  #   )
  #   render json: response
  # end
end
