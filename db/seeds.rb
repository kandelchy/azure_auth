50.times do |index|
  name = Faker::Name.unique.name
  phone = Faker::PhoneNumber.cell_phone
  p1 = Info.create(name: name, phone: phone)
  p1.save!
end
