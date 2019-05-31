class ConsumersController < ApplicationController
    def index
        @consumers = Consumer.all
    end

    def new
        @consumer = Consumer.new
        editForm_params
    end

    def edit
        @consumer = Consumer.find(params[:id])
        editForm_params(@consumer.id)
    end

    def create
        @consumer = Consumer.new(consumers_params)
        if @consumer.save
            editForm_params(@consumer.id)
            flash[:info] = 'Потребитель сервисов успешно добавлен'
            redirect_to consumers_path
        else
            editForm_params
            flash.now[:danger] = @consumer.errors.full_messages.to_sentence
            render :new
        end
    end

    def update
        @consumer = Consumer.find(params[:id])
        if @consumer.update(consumers_params)
            editForm_params(@consumer.id)
            flash[:info] = 'Потребитель сервисов успешно обновлен'
            redirect_to consumers_path
        else
            editForm_params(@consumer.id)
            flash.now[:danger] = @consumer.errors.full_messages.to_sentence
            render :edit
        end
    end

    def destroy
        @consumer = Consumer.find(params[:id])
        deltitle = @consumer.name
        if @consumer.destroy
            flash[:info] = 'Потребитель сервисов успешно удален'
            redirect_to consumers_path
        else
            editForm_params(@consumer.id)
            flash.now[:danger] = @consumer.errors.full_messages.to_sentence
            render :edit
        end
    end

    private
        def consumers_params
            params.require(:consumer).permit(:name, :municipality_id)
        end

        def editForm_params(id = nil)
            unless id.blank?
                @freport_form_url = consumer_path(id)
                @freport_form_method = "patch"
            else
                @freport_form_url = consumers_path
                @freport_form_method = "post"
            end
        end
end
