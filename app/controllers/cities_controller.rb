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
      city_params[:image].original_filename == city_params[:url]
      @city.save
      @city.url = @city.image.url
    end
    respond_to do |format|
      if @city.save
        @country = Country.find_by(id: @city.country_id)
        format.html { redirect_to @country, success: 'City was successfully created.' }
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
      if p[:image].original_filename == city_params[:url]
        f = p[:image]
        p[:url] = File.join('/',imageUploader.dir,f.headers.split()[2].split(/\W+/)[1..-1],
          params[:id],f.original_filename)
      else
        p[:url] = city_params[:url]
      end
    else
      p[:url] = city_params[:url]
    end

    respond_to do |format|
      if @city.update(p)
        @country = Country.find_by(id: @city.country_id)
        format.html { redirect_to @country, success: 'City was successfully updated.' }
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
      @country = Country.find_by(id: @city.country_id)
      format.html { redirect_to @country, success: 'City was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_city
      @city = City.find(params[:id])
    end

    def city_params
      params.require(:city).permit(:country_id, :name, :image, :url)
    end

    # def city_text_params
    #   params.require(:city).permit(:country_id, :name, :url)
    # end
end
