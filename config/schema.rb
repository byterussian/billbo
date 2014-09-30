Configuration.db.create_table :invoices do

  # Ids
  primary_key :id
  String  :stripe_id, unique: true
  String  :stripe_customer_id

  # Numbering
  Integer :year
  Integer :sequence_number
  String  :number, unique: true

  # Invoice lifecycle
  Boolean :added_vat
  Time    :finalized_at
  Time    :reserved_at

  # Credit notes
  Boolean :credit_note, default: false
  String  :reference_number

  # PDF generation
  Time    :pdf_generated_at

  # Amounts
  Integer :subtotal
  Integer :discount_amount
  Integer :subtotal_after_discount
  Integer :vat_amount
  Decimal :vat_rate
  Integer :total
  String  :currency

  # Used exchange rate and amounts in EUR
  Decimal :exchange_rate_eur
  Integer :vat_amount_eur
  Integer :total_eur

  # Snapshot of customer
  String  :customer_name
  String  :customer_company_name
  String  :customer_country_code
  String  :customer_address
  Boolean :customer_vat_registered
  String  :customer_vat_number
  String  :customer_accounting_id

  # VIES information
  String  :vies_company_name
  String  :vies_address
  String  :vies_request_identifier

end unless Configuration.db.tables.include?(:invoices)
