class Mentee < ActiveRecord::Base

  resourcify

  def self.import_csv(file)
    require "csv"

    rows = CSV.open(file)
    #strict format skipping first two rows for header and space
    rows.shift
    rows.shift
    rows.each do |row|

      #Donor Id	First Name	Last Name	Email 	Home Phone	Availability	Prophecy	BC
      #["D78201", "John", "Meadow", "Jmeadow67@hotmail.com", "2023477891", "Morning"]

      index_map = { :donor_id => 0, :first_name => 1, :last_name => 2, :email => 3,
                    :home_phone => 4,:availability => 5, :prophecy => 6, :bc => 7 }

      mentee = Mentee.new

      mentee.donor_id     = row[index_map[:donor_id]]
      mentee.first_name   = row[index_map[:first_name]]
      mentee.last_name    = row[index_map[:last_name]]
      mentee.email        = row[index_map[:email]]
      mentee.home_phone   = row[index_map[:home_phone]]
      mentee.availability = row[index_map[:availability]]
      mentee.prophecy     = row[index_map[:prophecy]]
      mentee.bc           = row[index_map[:bc]]

      p "++++ mentee import method"
      p mentee.inspect

      mentee.save!

    end
  end

end