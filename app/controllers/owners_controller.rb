class OwnersController < ApplicationController
    def index
        @owners = Owner.all
    end

    def new
        @owner = Owner.new
        editForm_params
    end

    def edit
        @owner = Owner.find(params[:id])
        editForm_params(@owner.id)
    end

    def create
        @owner = Owner.new(owners_params)
        if @owner.save
            editForm_params(@owner.id)
            flash[:info] = 'Владелец сервисов успешно добавлен'
            redirect_to owners_path
        else
            editForm_params
            flash.now[:danger] = @owner.errors.full_messages.to_sentence
            render :new
        end
    end

    def update
        @owner = Owner.find(params[:id])
        if @owner.update(owners_params)
            editForm_params(@owner.id)
            flash[:info] = 'Владелец сервисов успешно обновлен'
            redirect_to owners_path
        else
            editForm_params(@owner.id)
            flash.now[:danger] = @owner.errors.full_messages.to_sentence
            render :edit
        end
    end

    def destroy
        @owner = Owner.find(params[:id])
        deltitle = @owner.name
        if @owner.destroy
            flash[:info] = 'Владелец сервисов успешно удален'
            redirect_to owners_path
        else
            editForm_params(@owner.id)
            flash.now[:danger] = @owner.errors.full_messages.to_sentence
            render :edit
        end
    end

    private
        def owners_params
            params.require(:owner).permit(:name)
        end

        def editForm_params(id = nil)
            unless id.blank?
                @freport_form_url = owner_path(id)
                @freport_form_method = "patch"
            else
                @freport_form_url = owners_path
                @freport_form_method = "post"
            end
        end
end
