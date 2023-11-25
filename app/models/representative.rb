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
      rep = update_rep(addr, official, ocdid_temp, title_temp)
      reps.push(rep)
    end
    reps
  end

  def self.update_rep(addr, official, ocdid_temp, title_temp)
    attributes = base_attributes(official, ocdid_temp, title_temp)
    attributes.merge!(address_attributes(addr)) if addr
    Representative.find_or_create_by!(attributes)
  end

  # Common attributes
  def self.base_attributes(official, ocdid_temp, title_temp)
    {
      name:      official.name,
      ocdid:     ocdid_temp,
      title:     title_temp,
      party:     official.party,
      photo_url: official.photo_url
    }
  end

  # Address-related attributes
  def self.address_attributes(addr)
    {
      street: addr[0].line1,
      city:   addr[0].city,
      state:  addr[0].state,
      zip:    addr[0].zip
    }
  end
end
