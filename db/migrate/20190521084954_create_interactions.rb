class CreateInteractions < ActiveRecord::Migration[5.2]
    def change
        create_table :interactions do |t|
            # Владелец сервиса[0]
            t.string :serv_owner
            # Наименование сервиса[1]
            t.string :serv_name
            # SID[2]
            t.string :serv_sid
            # Потребитель сервиса[3]
            t.string :serv_consumer
            # Дата[4]
            t.datetime :serv_date
            # Количество обращений[5]
            t.integer :request_count
            # Количество ответов[6]
            t.integer :response_count
            # Сертификат[7]
            t.string :certificate
            # Операция[8]
            t.string :operation
            # Статус[9]
            t.string :status
            # Регион[10]
            t.integer :region
            # Наименование региона[11]
            t.string :region_name

            t.timestamps
        end
    end
end
