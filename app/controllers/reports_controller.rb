class ReportsController < ApplicationController
    def table_view
        @result = Hash.new
        municipalitys = Municipality.all
        municipalitys.each {|municipality| @result[municipality.name] = 0} if municipalitys.count > 0
        @filt_owner = "Все"
        unless params[:q].present?
            interactions = Interaction.all
            @selected_opt = 0
        else
            interactions = Interaction.where(owner_id: params[:q].to_i)
            if own = Owner.find(params[:q].to_i)
                @selected_opt = own.id
            end
        end

        interactions.each do |interaction|
            cons = Consumer.find(interaction.consumer_id)
            if cons.municipality_id && cons.municipality_id != 0
                municipality = Municipality.find(cons.municipality_id)
                @result[municipality.name] += interaction.request_count
            end
        end
    end
end