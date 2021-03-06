class House < ApplicationRecord
    belongs_to :user
    belongs_to :district
    belongs_to :type
    has_many :feature_houses, dependent: :destroy
    has_many :features, through: :feature_houses, dependent: :destroy
    has_many :comments, as: :commentable, dependent: :destroy
    has_many :likes, as: :likeable, dependent: :destroy

    has_many_attached :photos, dependent: :destroy
    

    validates :title, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 6}
    validates :description, presence: true, length: {minimum: 128}
    validates :room_number, presence: true, numericality: {greater_than: 0}
    validates :address, presence: true
    validates :status, presence: true
    validates :price, presence: true, numericality: {greater_than: 0}
    validates :district_id, presence: true
    validates :type_id, presence: true
    validates :is_available, presence: true
    validate :check_user_post_status, on: :create

    rails_admin do
        configure :comments do
            visible do
                bindings[:controller].current_ability.can? :edit, Comment
            end
        end

        configure :likes do
            visible do
                bindings[:controller].current_ability.can? :edit, Like
            end
        end

        configure :feature_houses do
            visible do
                bindings[:controller].current_ability.can? :edit, FeatureHouse
            end
        end

        configure :user do
            visible do
                bindings[:controller].current_ability.can? :edit, User
            end
        end


    end

    def check_user_post_status
        if self.user.can_post == false
            errors.add(:message, 'Upgrade your count to Gold to have possibility to post 3 to 6 articles')
        end
    end

end
