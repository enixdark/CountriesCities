class CitiesController < ApplicationController
  before_action :set_city, only: [:show, :edit, :update, :destroy]


  def index
    @cities = City.paginate(:page => params[:page], :per_page => 10).order('name DESC')
  end


  def show
  end

  def new
    @city = City.new
  end

  def edit
  end

  def create
    @city = City.new(city_params)
    if !city_params[:image].nil? &&
      city_params[:image].original_filename == city_text_params[:url]
      @city = City.new(city_params)
      @city.save
      @city.url = @city.image.url
    else
      @city = City.new(city_text_params)
    end

    respond_to do |format|
      if @city.save
        format.html { redirect_to @city, notice: 'City was successfully created.' }
        format.json { render :show, status: :created, location: @city }
      else
        format.html { render :new }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

    p = city_params
    if !p[:image].nil?
      if p[:image].original_filename == city_text_params[:url]
        f = p[:image]
        p[:url] = File.join('/',imageUploader.dir,f.headers.split()[2].split(/\W+/)[1..-1],
          params[:id],f.original_filename)
      else
        p[:url] = city_text_params[:url]
      end
    else
      p[:url] = city_text_params[:url]
    end

    respond_to do |format|
      if @city.update(p)
        format.html { redirect_to @city, notice: 'City was successfully updated.' }
        format.json { render :show, status: :ok, location: @city }
      else
        format.html { render :edit }
        format.json { render json: @city.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @city.destroy
    respond_to do |format|
      format.html { redirect_to cities_url, notice: 'City was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_city
      @city = City.find(params[:id])
    end

    def city_params
      params.require(:city).permit(:city_id, :name, :image)
    end

    def city_text_params
      params.require(:city).permit(:city_id, :name, :url)
    end
end
