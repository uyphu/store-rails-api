class Api::V1::AuthorsController < ApplicationController
  before_action :set_api_v1_author, only: [:show, :update, :destroy]

  # GET /api/v1/authors
  def index
    @api_v1_authors = Author.all

    render json: @api_v1_authors
  end

  # GET /api/v1/authors/1
  def show
    render json: @api_v1_author
  end

  # POST /api/v1/authors
  def create
    @api_v1_author = Author.new(api_v1_author_params)

    if @api_v1_author.save
      render json: @api_v1_author.to_json(only: [:id, :name, :address]), status: :created
    else
      render json: @api_v1_author.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/authors/1
  def update
    if @api_v1_author.update(api_v1_author_params)
      render json: @api_v1_author
    else
      render json: @api_v1_author.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/authors/1
  def destroy
    @api_v1_author.destroy
  end

  def search
    @api_v1_authors = Author.search(params)
    render json: @api_v1_authors
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_author
      @api_v1_author = Author.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_v1_author_params
      #params.fetch(:api_v1_author, {})
      params.fetch(:author).permit(:name, :address)
    end
end
