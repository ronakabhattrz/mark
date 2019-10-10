require 'swaggers/Account_Management_Service'

class Service < ApplicationRecord
  attr_accessor :service_profile

  after_initialize do
    puts '$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ AFTER INITIALISE ###################'
    api_configuration = AccountManagementService::Configuration.new { |config| config.debugging = true }
    api_client = AccountManagementService::ApiClient.new(api_configuration)
    api = AccountManagementService::ServiceProfilesApi.new(api_client)
    @service_profile = api.serviceprofiles_getlocal(ccs_service_id: ccs_service_id).d.results[0]
    @ccs_service_id = ccs_service_id
    @api_dom = @service_profile.to_s
  end

end
