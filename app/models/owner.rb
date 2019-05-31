class Owner < ApplicationRecord
    has_many :interactions

    validates :name, :presence => {:message => 'не может быть пустым'}
end
