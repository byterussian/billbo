require './environment'

$db.create_table :invoices do
  primary_key :id

  Integer :year
  Integer :sequence_number
  String  :number
  String  :stripe_id
  Time    :created_at
end
