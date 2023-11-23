# frozen_string_literal: true

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

      rep_exist = Representative.find_by(name: official.name, title: title_temp)
      if rep_exist.nil?
        rep = Representative.create!({ name: official.name, ocdid: ocdid_temp, title: title_temp,
        address: contact_address(official), party: officials.party, photo: official.photo_url })
        reps.push(rep)
      else
        reps.push(rep_exist)
      end
    end
    reps
  end

  def self.contact_address(official)
    address_string = ''
    unless official.address.nil?
      address_info = official.address[0]
      address_string = "#{address_info.line1}, #{address_info.city}, #{address_info.state} #{address_info.zip}"
    end
    address_string
  end
end
