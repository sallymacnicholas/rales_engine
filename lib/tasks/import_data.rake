require 'csv'

task :import_data => :environment do
  csvs=
    [[Customer, 'customers'],
     [Merchant,'merchants'],
     [Item, 'items'],
     [Invoice, 'invoices']
  ]

   csvs.each do |model, csv|
      file = "lib/assets/#{csv}.csv"
      CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
        model.find_or_create_by(row.to_hash)
      end
      puts "#{model} data imported"
   end

  CSV.foreach("lib/assets/transactions.csv", headers: true) do |row|
    Transaction.find_or_create_by(row.to_hash.except("id", "credit_card_expiration_date"))
  end
  puts "Transaction data imported"

  CSV.foreach("lib/assets/invoice_items.csv", headers: true, header_converters: :symbol) do |row|
    InvoiceItem.find_or_create_by(row.to_hash)
  end
  puts "InvoiceItem data imported"


end
