class MunicipalitysController < ApplicationController
    def index
        @municipalitys = Municipality.all
    end

    def new
        @municipality = Municipality.new
        editForm_params
    end

    def edit
        @municipality = Municipality.find(params[:id])
        editForm_params(@municipality.id)
    end

    def create
        @municipality = Municipality.new(municipality_params)
        if @municipality.save
            editForm_params(@municipality.id)
            flash[:info] = 'Муниципальный округ успешно добавлен'
            redirect_to municipalitys_path
        else
            editForm_params
            flash.now[:danger] = @municipality.errors.full_messages.to_sentence
            render :new
        end
    end

    def update
        @municipality = Municipality.find(params[:id])
        if @municipality.update(municipality_params)
            editForm_params(@municipality.id)
            flash[:info] = 'Муниципальный округ успешно обновлен'
            redirect_to municipalitys_path
        else
            editForm_params(@municipality.id)
            flash.now[:danger] = @municipality.errors.full_messages.to_sentence
            render :edit
        end
    end

    def destroy
        @municipality = Municipality.find(params[:id])
        deltitle = @municipality.name
        if @municipality.destroy
            flash[:info] = 'Муниципальный округ успешно удален'
            redirect_to municipalitys_path
        else
            editForm_params(@municipality.id)
            flash.now[:danger] = @municipality.errors.full_messages.to_sentence
            render :edit
        end
    end

    private
        def municipality_params
            params.require(:municipality).permit(:name, :filt_string)
        end

        def editForm_params(id = nil)
            unless id.blank?
                @freport_form_url = municipality_path(id)
                @freport_form_method = "patch"
            else
                @freport_form_url = municipalitys_path
                @freport_form_method = "post"
            end
        end
end
