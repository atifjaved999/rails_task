class List < ApplicationRecord
  has_one_attached :information_file, dependent: :destroy

  validates :name, :country, :city, :information_file, presence: true
end
