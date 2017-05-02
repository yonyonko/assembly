class Stockholder < ActiveRecord::Base
    has_and_belongs_to_many :assemblies
    belongs_to :user
    validates :name, presence: true
    validates :email, presence: true
end
