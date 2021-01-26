# spec/integration/books_spec.rb
require 'swagger_helper'

describe 'Books API' do

  path '/api/v1/books' do

    post 'Creates a book' do
      tags 'Books'
      consumes 'application/json', 'application/xml'
      parameter name: :book, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          year: { type: :integer },
          rating: { type: :integer },
          price: { type: :number }
        },
        required: [ 'title', 'year' ]
      }

      response '201', 'book created' do
        let(:book) { { title: 'Dodo', year: 2020 } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:book) { { title: 'foo' } }
        run_test!
      end
    end
  end

  path '/api/v1/books/{id}' do

    get 'Retrieves a book' do
      tags 'Books'
      produces 'application/json', 'application/xml'
      parameter name: :id, :in => :path, :type => :string

      response '200', 'name found' do
        schema type: :object,
          properties: {
            id: { type: :integer, },
            title: { type: :string },
            year: { type: :integer },
            rating: { type: :integer },
            price: { type: :number }
          },
          required: [ 'id', 'title', 'year' ]

        let(:id) { Book.create(title: 'foo', year: 2020).id }
        run_test!
      end

      response '404', 'book not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    delete 'Deletes a book' do
        tags 'Books'
        produces 'application/json', 'application/xml'
        parameter name: :id, :in => :path, :type => :string
  
        response '200', 'name found' do
          schema type: :object,
            properties: {
              id: { type: :integer, },
              title: { type: :string },
              year: { type: :integer },
              rating: { type: :integer },
              price: { type: :number }
            },
            required: [ 'id', 'title', 'year' ]
  
          let(:id) { Book.create(title: 'foo', year: 2020).id }
          run_test!
        end
  
        response '404', 'book not found' do
          let(:id) { 'invalid' }
          run_test!
        end
      end
    end
end