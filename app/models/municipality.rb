class Municipality < ApplicationRecord
    has_many :consumers

    before_save do
        self.filt_string = filt_string.mb_chars.downcase if filt_string.present?
    end
    before_update do
        self.filt_string = filt_string.mb_chars.downcase if filt_string.present?
    end

    validates :name, :presence => {:message => 'не может быть пустым'}
end