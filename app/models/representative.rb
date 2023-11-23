# frozen_string_literal: true
require 'net/http'
require 'json'

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.civic_api_to_representative_params(rep_info)
    reps = []

    rep_info.officials.each_with_index do |official, index|
      ocdid_temp = ''
      title_temp = ''

      rep_info.offices.each do |office|
        
        if office.official_indices.include? index
          title_temp = office.name
          ocdid_temp = office.division_id
        end
      end

      addr = official.address
      if addr
        rep = Representative.find_or_create_by!({
          name: official.name, 
          ocdid: ocdid_temp, 
          title: title_temp,
          party: official.party, 
          street: addr[0].line1, 
          city: addr[0].city,
          state: addr[0].state, 
          zip: addr[0].zip, 
          photo_url: official.photo_url})
      else
        rep = Representative.find_or_create_by!({
          name: official.name, 
          ocdid: ocdid_temp, 
          title: title_temp,
          party: official.party, 
          photo_url: official.photo_url})
      end

      reps.push(rep)

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
end