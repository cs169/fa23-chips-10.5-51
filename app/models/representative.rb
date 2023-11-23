# frozen_string_literal: true
require 'net/http'
require 'json'

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.civic_api_to_representative_params(rep_info)
    rep_info.officials.each_with_index do |official, index|
      ocdid_temp = ''
      title_temp = ''
      rep_info.offices.each do |office|
        if office.official_indices.include? index
          title_temp = office.name
          ocdid_temp = office.division_id
        end
      end

      rep = Representative.create!({
        name: official.name, 
        ocdid: ocdid_temp, 
        title: title_temp})
      reps.push(rep)

      # Fetch additional information for the representative
      rep.fetch_additional_info_from_civic_api(rep)
    end

    # # Test result
    # reps.each do |representative|
    #   puts "Name: #{representative.name}"
    #   puts "Title: #{representative.title}"
    #   puts "OCID: #{representative.ocdid}"
    #   puts "Street: #{representative.street}"
    #   puts "City: #{representative.city}"
    #   puts "State: #{representative.state}"
    #   puts "ZIP: #{representative.zip}"
    #   puts "Political Party: #{representative.political_party}"
    #   puts "Photo Url: #{representative.photo_url}"
    #   puts "-----------------------"
    # end

    reps
  end

  def fetch_additional_info_from_civic_api(official)
    civic_api_key = Rails.application.credentials[:GOOGLE_API_KEY]

    # Convert to encoded format
    id = URI.encode_www_form_component(ocdid)
    civic_api_url = "https://www.googleapis.com/civicinfo/v2/representatives/#{id}?key=#{civic_api_key}"
    puts civic_api_url
    uri = URI.parse(civic_api_url)
    response = Net::HTTP.get_response(uri)

    if response.code == '200'
      data = JSON.parse(response.body)

      # Extract info with name
      data = data["officials"].find { |o| o["name"] == name }

      if data
        address = data["address"]&.first

        # Use conditional checks to ensure data is present before updating
        update_attributes({
          street: address&.fetch("line1", nil) || street,
          city: address&.fetch("city", nil) || city,
          state: address&.fetch("state", nil) || state,
          zip: address&.fetch("zip", nil) || zip,
          political_party: data["party"] || political_party,
          photo_url: data["photoUrl"] || photo_url})
      else
        puts("Fetch failed for name not found")
      end
    else
      puts("Fetch failed for network problem")
    end
  end
end
