class ConsumersController < ApplicationController
    def index
        @consumers = Consumer.all
    end
end
