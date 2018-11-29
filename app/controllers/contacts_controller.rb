class ContactsController < ApplicationController
require 'open-uri'
require 'json'
require 'nokogiri'
require 'rest_client'
require 'simple_hubspot'

  # @contact = SimpleHubspot::Contact.find_by_email "coolrobot@hubspot.com"

def index
  # raise
  filepath = "https://api.hubapi.com/contacts/v1/lists/all/contacts/all?hapikey=905e4bbe-74c4-4aa2-9f1d-f7de5d6f0031&count=300"

  # filepath = "https://api.hubapi.com/contacts/v1/contact/email/coolrobot@hubspot.com/profile?hapikey=905e4bbe-74c4-4aa2-9f1d-f7de5d6f0031&count=2"
  # filepath = "https://api.hubapi.com/contacts/v1/lists?count=5&hapikey=905e4bbe-74c4-4aa2-9f1d-f7de5d6f0031&count=2"
  # filepath = "https://api.hubapi.com/properties/v1/contacts/properties?hapikey=905e4bbe-74c4-4aa2-9f1d-f7de5d6f0031&count=2"
  # filepath = "https://api.hubapi.com/content/api/v2/blog-posts?hapikey=905e4bbe-74c4-4aa2-9f1d-f7de5d6f0031&count=2"
  # filepath = "http://api.hubapi.com/content/api/v2/layouts?hapikey=905e4bbe-74c4-4aa2-9f1d-f7de5d6f0031"


  gve_read = open(filepath).read

  @gve = JSON.parse(gve_read)

  @contacts = @gve
end


def show
end

def new
end


def create
end

def edit
end

def update
end

def destroy
end



end
