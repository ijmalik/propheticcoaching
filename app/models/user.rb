class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  accepts_nested_attributes_for :roles

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :mentees, :foreign_key => "coach_id"
  has_many :chats

  scope :coaches, -> { Role.where("name='coach'").first.users }

  def is_admin?
    self.has_role?(:admin) ? true : false
  end

  def name
    "#{first_name} #{last_name}".titleize
  end

  def escaped_name
    name.gsub /\W/, "_"
  end

def self.import_csv(file)
    require "csv"

    rows = CSV.open(file)
    #strict format skipping first two rows for header and space
    #rows.shift
    rows.shift
    rows.each do |row|

      index_map = { :first_name => 0, :last_name => 1, :email => 2, :address => 3,
                    :home_phone => 4, :password => 5 }

      user = User.new

      #mentee.donor_id     = row[index_map[:donor_id]]
      user.first_name   = row[index_map[:first_name]]
      user.last_name    = row[index_map[:last_name]]
      user.email        = row[index_map[:email]]
      user.address      = row[index_map[:address]]
      user.home_phone   = row[index_map[:home_phone]]
      user.password     = row[index_map[:password]]

      p "++++ user import method"
      p user.inspect
      user.add_role "coach"
      user.save!

    end
  end

end
