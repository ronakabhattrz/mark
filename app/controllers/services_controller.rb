class ServicesController < ApplicationController
  before_action :set_service, only: [:show, :edit, :update, :destroy]

  # GET /services
  # GET /services.json
  def index
    @services = Service.all
    if params[:service].present?
      new
    end
    if params[:id].present?
      edit
    end
  end

  # GET /services/1
  # GET /services/1.json
  def show
    @service = set_service
    @service_profile = @service.service_profile
    puts @service_profile.to_hash.to_s
  end

  # GET /services/new
  def new
    @service = Service.new(service_params)
    @service.save
    @service_profile = @service.service_profile
    puts @service_profile.to_hash.to_s
  end

  # GET /services/1/edit
  def edit
    @service = set_service
    @service_profile = @service.service_profile
    puts @service_profile.to_hash.to_s
  end

  # POST /services
  # POST /services.json
  def create
    @service = Service.new(service_params)

    respond_to do |format|
      if @service.save
        format.html { redirect_to @service, notice: 'Service was successfully created.' }
        format.json { render :show, status: :created, location: @service }
      else
        format.html { render :new }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /services/1
  # PATCH/PUT /services/1.json
  def update
    remove_extra_value_from_hash(request.params,params[:service][:ccs_service_id])
    respond_to do |format|
      if @service.update(service_params)
        format.html { redirect_to services_path, notice: 'Service was successfully updated.' }
        format.json { render :show, status: :ok, location: @service }
      else
        format.html { render :edit }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /services/1
  # DELETE /services/1.json
  def destroy
    @service.destroy
    respond_to do |format|
      format.html { redirect_to services_url, notice: 'Service was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_service
    @service = Service.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def service_params
    params.require(:service).permit(:ccs_service_id, :api_dom)
  end

  def remove_extra_value_from_hash(request_hash,ccs_service_id)
    request_hash.delete("utf8")
    request_hash.delete("_method")
    request_hash.delete("authenticity_token")
    request_hash.delete("commit")
    request_hash.delete("controller")
    request_hash.delete("action")
    request_hash.delete("id")
    new_hash = {"d": {"results": [request_hash]}}
    service_profile = AccountManagementService::ServiceProfile.new(new_hash)
    if service_profile.valid?
      r = service_profile.to_hash
      File.open("lib/swaggers/Account_Management_Service/data/#{ccs_service_id}_new.json","w") do |f|
        f.write(r.to_json)
      end
    end
    # send to api...
    #@service_profile = api.serviceprofiles_post(service_profile.to_hash)
  end

  # def compare_json(ccs_service_id, params)
  #   file = File.read("lib/swaggers/Account_Management_Service/data/#{ccs_service_id}.json")
  #   data_hash = JSON.parse(file)
  #   data_hash = data_hash["d"]["results"].first
  #   data_hash.each do |data|
  #     puts "===============DATA==========#{data.inspect}======"
  #     if params[data.first] != data.last
  #       if data.last.is_a?(Hash)
  #         d = data.last["results"]
  #         d.each do |ele|
  #           ele.each_with_index do |new_ele, index|
  #             if params[new_ele.first].present?
  #               if params[new_ele.first] != new_ele.last
  #                 if data_hash[data.first]["results"][index].present?
  #                   if data_hash[data.first]["results"][index][new_ele.first].present?
  #                     data_hash[data.first]["results"][index][new_ele.first] = params[new_ele.first]
  #                   end
  #                 end
  #               end
  #             end
  #           end
  #         end
  #       else
  #        data_hash[data.first] = params[data.first]
  #       end
  #     end
  #   end
  #   new_hash = {"d": {"results": [data_hash]}}
  #   File.open("lib/swaggers/Account_Management_Service/data/#{ccs_service_id}.json","w") do |f|
  #     f.write(new_hash.to_json)
  #   end
  # end
end
