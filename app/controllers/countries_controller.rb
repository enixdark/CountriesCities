class CountriesController < ApplicationController
  before_action :set_country, only: [:show, :edit, :update, :destroy]

  
  def index
    @countries = Country.paginate(:page => params[:page], :per_page => 10).order('name DESC')
  end

  def list_cities
    """
    Get list cities of etraxt country by id
    """
    id = request.query_parameters[:id].to_i
    @data = Country.find(id).cities
    render json: @data.map { |d| {id: d.id,name: d.name,url: d.url}}
  end

  # def upload
  #   uploaded_io = params[:countries][:flag]
  #   File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
  #     file.write(uploaded_io.read)
  #   end
  # end

  
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
    @country = Country.new(country_params)
    if !country_params[:flag].nil? &&
      country_params[:flag].original_filename == country_params[:url]
      @country.save
      # path = @country.flag.store_path.split('/')
      # path.insert(3,@country.id)
      @country.url = @country.flag.url
    end
    # byebug
    respond_to do |format|
      if @country.save
        format.html { redirect_to @country, success: 'Country was successfully created.' }
        format.json { render :show, status: :created, location: @country }
      else
        format.html { render :new }
        format.json { render json: @country.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

    """
    extract request data from client and assign
    """

    p = country_params
    if !p[:flag].nil?
      if p[:flag].original_filename == country_params[:url]
        f = p[:flag]
        p[:url] = File.join('/',FlagUploader.dir,f.headers.split()[2].split(/\W+/)[1..-1],
          params[:id],f.original_filename)
      else
        p[:url] = country_params[:url]
      end
    else
      p[:url] = country_params[:url]
    end
    # country_params[:url] = country_params[:flag].url
    respond_to do |format|
      if @country.update(p)
        format.html { redirect_to @country, success: 'Country was successfully updated.' }
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
      format.html { redirect_to countries_url, success: 'Country was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_country
      @country = Country.find(params[:id])
    end

    def country_params
      params.require(:country).permit(:name, :flag, :url)
    end

    
end
