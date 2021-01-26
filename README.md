# Store Rails API Sample [![PRs Welcome](https://img.shields.io/badge/PRs-welcome-green.svg)](https://github.com/facebook/create-react-app/blob/master/CONTRIBUTING.md)
An application to build REST API service with Rails

## Requirement:
	+ Mysql
	+ Ruby at least 2.0

### 1. Install Ruby
	https://rubyinstaller.org/
### 2. Install Rails
```bash
	gem install rails
```
	
### 3. Create Rails application with mode api
```bash
	rails new store-rails-api --api --database=mysql
	cd store-rails-api --api
```
### 4. Create a Author model
```bash
	rails generate model author name:string address:string
```
	
	
	NOTE: typ of model :primary_key, :string, :text, :integer, :float, :decimal, :datetime, :timestamp,
:time, :date, :binary, :boolean, :references

	It will generate:
	  invoke  active_record
      create    db/migrate/20210126045411_create_authors.rb
      create    app/models/author.rb
      invoke    test_unit
      create      test/models/author_test.rb
      create      test/fixtures/authors.yml
### 5. Create a Book model belongs to Author, One Author has many Books
	```bash
	rails generate model book title:string year:string rating:integer price:decimal author:references
	```
	
	It will generate:
	  invoke  active_record
      create    db/migrate/20210126045733_create_books.rb
      create    app/models/book.rb
      invoke    test_unit
      create      test/models/book_test.rb
      create      test/fixtures/books.yml
### 6. Update database connection to Mysql
	Create database name: store_rails_api_development
	Go to config/database.yml, update user/pass to connect mysql
### 7. Run migrate database to create tables in mysql
```bash
	rails db:migrate
```
	
### 8. Update relationship between Book model and Author Model
	In app/models/book.rb
		add "belongs_to :author"
	In app/models/author.rb
		add "has_many :books"
	In db/seeds.rb, input sample data for testing:
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
	
	
```bash
rails db:seed
```
### 9. Create author controller
```bash
rails generate scaffold_controller api/v1/author
```
	rails generate scaffold_controller api/v1/author 
	create  app/controllers/api/v1/authors_controller.rb
      invoke  resource_route
       route    namespace :api do
		  namespace :v1 do
			resources :authors
		  end
		end
      invoke  test_unit
      create    test/controllers/api/v1/authors_controller_test.rb
### 10. Create book controller 
```bash
rails generate scaffold_controller api/v1/book
```
	
	create  app/controllers/api/v1/books_controller.rb
      invoke  resource_route
       route    namespace :api do
		  namespace :v1 do
			resources :books
		  end
		end
      invoke  test_unit
      create    test/controllers/api/v1/books_controller_test.rb
### 11. Setup swagger
	11.1 Add rswag and rspec-rails gems to Gemfile
		group :development, :test do
		  gem 'rspec-rails', '~> 3.5'
		end
		gem 'rswag'
	11.2 Install with bundler
```bash
bundle install
```
		
	11.3 Run generator
```bash
rails generate rspec:install
```
		
		  create  .rspec
		  create  spec
		  create  spec/spec_helper.rb
		  create  spec/rails_helper.rb
```bash
	rails g rswag:install
```
		
			generate  rswag:specs:install
			   rails  generate rswag:specs:install
			  create  spec/swagger_helper.rb
			generate  rswag:api:install
			   rails  generate rswag:api:install
			  create  config/initializers/rswag_api.rb
			   route  mount Rswag::Api::Engine => '/api-docs'
			generate  rswag:ui:install
			   rails  generate rswag:ui:install
			  create  config/initializers/rswag-ui.rb
			   route  mount Rswag::Ui::Engine => '/api-docs'
	11.4 Create an integration spec to describe to test API and generate swagger.yml
	spec/integration/author_spec.rb
	describe 'Authors API' do

	  path '/api/v1/authors' do

		post 'Creates a author' do
		  tags 'Authors'
		  consumes 'application/json', 'application/xml'
		  parameter name: :author, in: :body, schema: {
			type: :object,
			properties: {
			  name: { type: :string },
			  photo_url: { type: :string },
			  status: { type: :string }
			},
			required: [ 'name', 'status' ]
		  }

		  response '201', 'author created' do
			let(:author) { { name: 'Dodo', status: 'available' } }
			run_test!
		  end

		  response '422', 'invalid request' do
			let(:author) { { name: 'foo' } }
			run_test!
		  end
		end
	  end
	end
	spec/integration/book_spec.rb
	
	10.5 Generate swagger file
```bash
	rake rswag:specs:swaggerize
```
		
### 12. Run application
```bash
	bundle install
	rails server
```
	
	
### 13. Open browser with http://localhost:3000/api-docs

### 14. API flow

	User request -> routes.rb -> ...controller.rb -> model -> integrate database 
