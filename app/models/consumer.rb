class Consumer < ApplicationRecord
    belongs_to :municipality

    def self.find_or_create_by_custom(cname)
        unless cons = Consumer.find_by(name: cname)
            mos = Municipality.all
            mos_id = 0
            mos.each do |one_mos|
                if (one_mos.filt_string.length > 0) && (cname.mb_chars.downcase.include?(one_mos.filt_string))
                    mos_id = one_mos.id
                    break
                end
            end
            cons = Consumer.new(name: cname, municipality_id: mos_id)
            cons.save!
        end
        return cons
    end
end
