class WelcomeController < ApplicationController
    def index
        # Владелец сервиса[0]
        # Наименование сервиса[1]
        # SID[2]
        # Потребитель сервиса[3]
        # Дата[4]
        # Количество обращений[5]
        # Количество ответов[6]
        # Сертификат[7]
        # Операция[8]
        # Статус[9]
        # Регион[10]
        # Наименование региона[11]

        #Interaction.import_files

        @interactions = Interaction.all
    end
end
