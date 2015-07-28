require 'csv'

task :import_data => :environment do
  csvs=
    [[Customer, 'customers'],
     [Merchant,'merchants'],
     [Item, 'items'],
     [Invoice, 'invoices'],
     [Transaction, 'transactions'],
     [InvoiceItem, 'invoice_items']
  ]

   csvs.each do |model, csv|
      file = "lib/assets/#{csv}.csv"
      CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
        model.find_or_create_by(row.to_hash)
      end
      puts "#{model} data imported"
    end
end
