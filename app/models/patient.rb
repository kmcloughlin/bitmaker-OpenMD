class Patient < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_one :health_record
  has_many :health_status_updates
  has_and_belongs_to_many :doctors

  accepts_nested_attributes_for :health_record
  accepts_nested_attributes_for :health_status_updates

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true, numericality: true
  validates :healthcard_number, presence: true
  validates :gender, presence: true
  validates :city, presence: true
  validates :country, presence: true

  validate :date_of_birth_is_in_the_past?


  def date_of_birth_is_in_the_past?
    if date_of_birth.present? && date_of_birth > Date.tomorrow
      errors.add(:date_of_birth, "your date of birth must be in the past")
    end
  end

end
