class ReportsController < ApplicationController
    def interaction_report
        @result = Hash.new
        municipalitys = Municipality.all
        municipalitys.each {|municipality| @result[municipality.name] = 0} if municipalitys.count > 0
        @selected_opt = 0

        unless params[:q].present?
            interactions = Interaction.all
        else
            interactions = Interaction.where(owner_id: params[:q].to_i)
            if own = Owner.find_by_id(params[:q].to_i)
                @selected_opt = own.id
            else
                return @result = nil
            end
        end

        interactions.each do |interaction|
            cons = Consumer.find_by_id(interaction.consumer_id)
            if cons.municipality_id.present? && cons.municipality_id != 0
                municipality = Municipality.find(cons.municipality_id)
                @result[municipality.name] += interaction.request_count
            end
        end
    end
end