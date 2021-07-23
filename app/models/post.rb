class Post < ApplicationRecord

	belongs_to :user
	has_many :comments
	has_many :likes

	include ImageUploader::Attachment(:image)

	validates :image, presence: true
	validates :description, presence: true
end
