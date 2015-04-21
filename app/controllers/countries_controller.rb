class CountriesController < ApplicationController
  before_action :set_country, only: [:show, :edit, :update, :destroy]

  
  def index
    @countries = Country.paginate(:page => params[:page], :per_page => 10).order('name DESC')
  end

  def list_cities
    id = request.query_parameters[:id].to_i
    @data = Country.find(id).cities
    render json: @data.map { |d| {id: d.id,name: d.name}}
  end

  def upload
    uploaded_io = params[:countries][:flag]
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
  end

  
  def show
    # @country = Country.find(params[:id])
    # byebug
  end

  def new
    @country = Country.new
  end

  def edit
  end

  
  def create
    if country_params[:flag].original_filename == country_text_params[:flag_text]
      @country = Country.new(country_params)
    else
      @country = Country.new
      @country.name = country_text_params[:name]
      @country.flag = country_text_params[:flag_text]
    end
    byebug
    respond_to do |format|
      if @country.save
        format.html { redirect_to @country, notice: 'Country was successfully created.' }
        format.json { render :show, status: :created, location: @country }
      else
        format.html { render :new }
        format.json { render json: @country.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @country.update(country_params)
        format.html { redirect_to @country, notice: 'Country was successfully updated.' }
        format.json { render :show, status: :ok, location: @country }
      else
        format.html { render :edit }
        format.json { render json: @country.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @country.destroy
    respond_to do |format|
      format.html { redirect_to countries_url, notice: 'Country was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_country
      @country = Country.find(params[:id])
    end

    def country_params
      params.require(:country).permit(:name, :flag)
    end

    def country_text_params
      params.require(:country).permit(:name, :flag_text)
    end
end
