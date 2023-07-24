class Car < ApplicationRecord
    has_one_attached :image

    validates :name, presence: true, length: { minimum: 2, maximum: 50 }
    validates :color, presence: true, length: { minimum: 2, maximum: 50 }
    validates :model, presence: true, length: { minimum: 2, maximum: 20 }
    validates :rent, presence: true, numericality: { greater_than: 0 }
    validates :rating, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 5 }
    validates :description, presence: true, length: { minimum: 2, maximum: 500 }
    validates :image, presence: true
    def image_url
        Rails.application.routes.url_helpers.url_for(image) if image.attached?
    end
end
