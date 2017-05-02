class Assembly < ActiveRecord::Base
    has_and_belongs_to_many :stockholders
    accepts_nested_attributes_for :stockholders
    belongs_to :user
    validates :name, presence: true
    validates :description, presence: true
end
