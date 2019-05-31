class ReportsController < ApplicationController
    def table_view
        #@municipalitys = Municipality.all.collect{
        #    |municipality| [municipality.name, municipality.consumers.collect{
        #        |consumer| [consumer.id, Interaction.where(consumer_id: consumer.id).collect{
        #            |interaction| [interaction.request_count]}
        #        ]}
        #    ]}

        @result = Hash.new
        @municipalitys = Municipality.all
        @municipalitys.each do |municipality|
            @result[municipality.name] = 0
            municipality.consumers.each {
                |consumer|
                interactions = Interaction.where(consumer_id: consumer.id)
                interactions.each {|interaction| @result[municipality.name] += interaction.request_count } if interactions.count > 0
            } if municipality.consumers.count > 0
        end
    end
end