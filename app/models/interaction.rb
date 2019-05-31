class Interaction < ApplicationRecord
    belongs_to :owner
    belongs_to :consumer

    def self.import_files
        files = Dir[Rails.root.join("public/uploads", "*.csv").to_s]
        if files.count > 0
            files.each do |file|
                is_imported = UploadedFile.where(file_name: File.basename(file).to_s, file_crc: Digest::SHA2.hexdigest(File.read(file).to_s)).first
                unless is_imported
                    Interaction.import_csv(file)
                    ufile = UploadedFile.new(file_name: File.basename(file).to_s, file_crc: Digest::SHA2.hexdigest(File.read(file).to_s))
                    ufile.save!
                else
                    logger.error("[#{Time.zone.now}] Ошибка при импорте файла: такой файл уже был импортирован")
                end
                File.delete(file)
            end
        end
    end

private
    def self.import_csv(filename)
        arr_of_csv_rows = CSV.read(filename)

        if arr_of_csv_rows.count > 1
            arr_of_csv_rows.each_with_index do |row, index|
                next if index == 0
                own = Owner.find_or_create_by(name: row[0].to_s)
                cons = Consumer.find_or_create_by_custom(row[3].to_s)
                begin
                    add_row = Interaction.new(owner_id: own.id, #row[0].to_s, # Владелец сервиса
                        serv_name: row[1].to_s, # Наименование сервиса
                        serv_sid: row[2].to_s, # SID
                        consumer_id: cons.id, #row[3].to_s, # Потребитель сервиса
                        serv_date: Date.strptime(row[4].to_s, '%d.%m.%y'), # Дата
                        request_count: row[5].to_i, # Количество обращений
                        response_count: row[6].to_i, # Количество ответов
                        certificate: row[7].to_s, # Сертификат
                        operation: row[8].to_s, # Операция
                        status: row[9].to_s, # Статус
                        region: row[10].to_s, # Регион
                        region_name: row[11].to_s # Наименование региона
                    )
                    add_row.save!
                rescue => e
                    logger.error("[#{Time.zone.now}] Ошибка при импорте данных: #{e.class.name} : #{e.message}")
                end
            end
        end
    end
end