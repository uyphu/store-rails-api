# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
phu_le = Author.create!(name: 'Phu Le', address: '123 Main Street')
author_01 = Author.create!(name: 'Author 01', address: '456 Other Street')
author_02 = Author.create!(name: 'Author 02', address: '456 Other Street2')
author_03 = Author.create!(name: 'Author 03', address: '456 Other Street3')
author_04 = Author.create!(name: 'Author 04', address: '456 Other Street4')


phu_le.books.create!(title: 'Book Phu 01', year: 2021, rating: 3, price: 100)
phu_le.books.create!(title: 'Book Phu 02', year: 2020, rating: 5, price: 101)
phu_le.books.create!(title: 'Book Phu 03', year: 2020, rating: 4, price: 102)
phu_le.books.create!(title: 'Book Phu 04', year: 2021, rating: 3, price: 103)

author_01.books.create!(title: 'Book author_01 01', year: 2021, rating: 3, price: 100)
author_01.books.create!(title: 'Book author_01 02', year: 2020, rating: 5, price: 101)
author_01.books.create!(title: 'Book author_01 03', year: 2020, rating: 4, price: 102)
author_01.books.create!(title: 'Book author_01 04', year: 2021, rating: 3, price: 103)

author_02.books.create!(title: 'Book author_02 01', year: 2021, rating: 3, price: 100)
author_02.books.create!(title: 'Book author_02 02', year: 2020, rating: 5, price: 101)
author_02.books.create!(title: 'Book author_02 03', year: 2020, rating: 4, price: 102)
author_02.books.create!(title: 'Book author_02 04', year: 2021, rating: 3, price: 103)