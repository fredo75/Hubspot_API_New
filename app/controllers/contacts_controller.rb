class ContactsController < ApplicationController
require 'open-uri'
require 'json'
require 'nokogiri'
require 'rest_client'
require 'uri'
require 'net/http'
require 'simple_hubspot'


  def index
    @contacts = Contact.all


    # @contactshub = SimpleHubspot::Contact.find_by_email "coolrobot@hubspot.com"
    # @contactshub = SimpleHubspot::Contact.create_or_update "coort@hubspot.com", { firstname: "#{params[:contact][:firstname]}", lastname: "#{params[:contact][:lastname]}", company: "#{params[:contact][:company]}" }
    # raise
    # filepath = "https://api.hubapi.com/contacts/v1/lists/all/contacts/all?hapikey=905e4bbe-74c4-4aa2-9f1d-f7de5d6f0031&count=300"

    # filepath = "https://api.hubapi.com/contacts/v1/contact/email/coolrobot@hubspot.com/profile?hapikey=905e4bbe-74c4-4aa2-9f1d-f7de5d6f0031&count=2"
    # filepath = "https://api.hubapi.com/contacts/v1/lists?count=5&hapikey=905e4bbe-74c4-4aa2-9f1d-f7de5d6f0031&count=2"
    # filepath = "https://api.hubapi.com/properties/v1/contacts/properties?hapikey=905e4bbe-74c4-4aa2-9f1d-f7de5d6f0031&count=2"
    # filepath = "https://api.hubapi.com/content/api/v2/blog-posts?hapikey=905e4bbe-74c4-4aa2-9f1d-f7de5d6f0031&count=2"
    # filepath = "http://api.hubapi.com/content/api/v2/layouts?hapikey=905e4bbe-74c4-4aa2-9f1d-f7de5d6f0031"

    # gve_read = open(filepath).read
    # @gve = JSON.parse(gve_read)
    # @contacts = @gve

          ##################################################################
          ##################### PHANTOM BUSTER #############################
          ##################################################################



    # url_1 = "https://phantombuster.com/api/v1/agent/31385?&key=PuzLoIgb0mCaokfWEc51aRpqQvm1nuab"
    # url_2 = "https://phantombuster.com/api/v1/agent/31385/lauch?&key=PuzLoIgb0mCaokfWEc51aRpqQvm1nuab"

    # url_3 = "https://phantombuster.com/api/v1/agent/31385/abort?&key=PuzLoIgb0mCaokfWEc51aRpqQvm1nuab"

    # url_4 = "https://phantombuster.com/api/v1/agent/31385/output?&key=PuzLoIgb0mCaokfWEc51aRpqQvm1nuab"
    # url = URI("https://phantombuster.com/api/v1/agent/31385?&key=PuzLoIgb0mCaokfWEc51aRpqQvm1nuab")

    # url = URI("https://phantombuster.com/api/v1/user?&key=PuzLoIgb0mCaokfWEc51aRpqQvm1nuab")

   url = URI("https://phantombuster.com/api/v1/agent/31385/output?&key=PuzLoIgb0mCaokfWEc51aRpqQvm1nuab")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(url)
    request["accept"] = 'application/json'

    @response = http.request(request)
    @phantombuster_callback_json = JSON.parse(@response.read_body)
    @phantombuster_callback = @phantombuster_callback_json["data"]["resultObject"]["jsonUrl"]


    url_ph = URI(@phantombuster_callback)

    http_2 = Net::HTTP.new(url_ph.host, url_ph.port)
    http_2.use_ssl = true
    request_2 = Net::HTTP::Get.new(url_ph)
    request["accept"] = 'application/json'

    @response_2 = http_2.request(request_2)
    @phantombuster_callback_parse_json = JSON.parse(@response_2.read_body)

    @for_huspot = @phantombuster_callback_parse_json[0]["fullName"]



  end


  def show
    @contact = Contact.find(params[:id])
  end

  def new
    @contact = Contact.new



          ##################################################################
          ##################### PHANTOM BUSTER #############################
          ##################################################################
    # @contactshub = SimpleHubspot::Contact.create_or_update "coosrtert@hubspot.com", { firstname: "#{params[:contact][:firstname]}", lastname: "#{params[:contact][:lastname]}", company: "#{params[:contact][:company]}" }


   url = URI("https://phantombuster.com/api/v1/agent/31385/output?&key=PuzLoIgb0mCaokfWEc51aRpqQvm1nuab")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(url)
    request["accept"] = 'application/json'

    @response = http.request(request)
    @phantombuster_callback_json = JSON.parse(@response.read_body)
    @phantombuster_callback = @phantombuster_callback_json["data"]["resultObject"]["jsonUrl"]


    url_ph = URI(@phantombuster_callback)

    http_2 = Net::HTTP.new(url_ph.host, url_ph.port)
    http_2.use_ssl = true
    request_2 = Net::HTTP::Get.new(url_ph)
    request["accept"] = 'application/json'

    @response_2 = http_2.request(request_2)
    @phantombuster_callback_parse_json = JSON.parse(@response_2.read_body)

    @for_huspot = @phantombuster_callback_parse_json[0]

    @contactshub = SimpleHubspot::Contact.create_or_update "#{@phantombuster_callback_parse_json[8]["firstName"]}@azerty.com", { firstname: "#{@phantombuster_callback_parse_json[8]["firstName"]}", lastname: "#{@phantombuster_callback_parse_json[8]["lastName"]}" }

  end


  def create
    # @params = params[:contact]
    @contactshub = SimpleHubspot::Contact.create_or_update "#{params[:contact][:email]}", { firstname: "#{params[:contact][:firstname]}", lastname: "#{params[:contact][:lastname]}", company: "#{params[:contact][:company]}" }
    # raise
    # @contact_hub = SimpleHubspot::Contact.update 1,  { email: "email@email.com" }
    # @contact = SimpleHubspot::Contact.create_or_update "email@email.com", { firstname: "James", lastname: "Cameron", company: 'USA' }
    @contact = Contact.new(contact_params)
    @contact = @contact.save
    # redirect_to contact_path(@contact)
  end

  def edit
    @contact = Contact.find(params[:id])
    # @contactshub = SimpleHubspot::Contact.create_or_update "coosrtert@hubspot.com", { firstname: "#{params[:contact][:firstname]}", lastname: "#{params[:contact][:lastname]}", company: "#{params[:contact][:company]}" }

  end

  def update
     @contact = Contact.find(params[:id])
     @contact.update(contact_params)
     redirect_to contacts_path(@contact)
  end

  def destroy
  end

private

  def contact_params
    params.require(:contact).permit(:firstname, :lastname, :email, :company)
  end

end
