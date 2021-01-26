# spec/integration/authors_spec.rb
require 'swagger_helper'

describe 'Authors API' do

  path '/api/v1/authors' do

    post 'Creates a author' do
      tags 'Authors'
      consumes 'application/json', 'application/xml'
      parameter name: :author, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          address: { type: :string }
        },
        required: [ 'name', 'address' ]
      }

      response '201', 'author created' do
        let(:author) { { name: 'Dodo', address: 'available' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:author) { { name: 'foo' } }
        run_test!
      end
    end
  end

  path '/api/v1/authors/{id}' do

    get 'Retrieves a author' do
      tags 'Authors'
      produces 'application/json', 'application/xml'
      parameter name: :id, :in => :path, :type => :string

      response '200', 'name found' do
        schema type: :object,
          properties: {
            id: { type: :integer, },
            name: { type: :string },
            address: { type: :string }
          },
          required: [ 'id', 'name', 'address' ]

        let(:id) { Author.create(name: 'foo', address: 'bar').id }
        run_test!
      end

      response '404', 'author not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    delete 'Deletes a author' do
        tags 'Authors'
        produces 'application/json', 'application/xml'
        parameter name: :id, :in => :path, :type => :string
  
        response '200', 'name found' do
          schema type: :object,
            properties: {
              id: { type: :integer, },
              name: { type: :string },
              address: { type: :string }
            },
            required: [ 'id', 'name', 'address' ]
  
          let(:id) { Author.create(name: 'foo', address: 'bar').id }
          run_test!
        end
  
        response '404', 'author not found' do
          let(:id) { 'invalid' }
          run_test!
        end
      end
    end
end