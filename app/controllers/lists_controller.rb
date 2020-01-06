class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]
  before_action :all_countries, only: [:new, :edit]
  before_action :set_message, only: [:show]

  # GET /lists
  # GET /lists.json
  def index
    @lists = List.all
  end

  # GET /lists/1
  # GET /lists/1.json
  def show
  end

  # GET /lists/new
  def new
    @list = List.new
  end

  # GET /lists/1/edit
  def edit
    @cities = all_cities(@list.country)
  end

  # POST /lists
  # POST /lists.json
  def create
    @list = List.new(list_params)

    respond_to do |format|
      if @list.save
        format.html { redirect_to @list, notice: 'List was successfully created.' }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { render :new }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lists/1
  # PATCH/PUT /lists/1.json
  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to @list, notice: 'List was successfully updated.' }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :edit }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.json
  def destroy
    @list.destroy
    respond_to do |format|
      format.html { redirect_to lists_url, notice: 'List was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def cities
    @cities = all_cities(params[:country])
    render :partial => "cities"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def list_params
      params.require(:list).permit(:name, :country, :city, :information_file)
    end

    def all_countries
      @countries = CS.countries.map { |c| [c[1], c[0]] }
    end

    def all_cities(country_code)
      CS.states(country_code).keys.flat_map { |state| CS.cities(state, country_code) }
    end

    def set_message
      ip_country = Geocoder.search(remote_ip()).first.country
      if ip_country == @list.country
        @message = "Hello from #{country_name(ip_country)}"
      else
        @message = "HEEY It looks like you are from #{country_name(ip_country)}"
      end
    end

    def remote_ip
      if request.remote_ip == '127.0.0.1'
        # Hard coded remote address
        '119.155.29.195'
      else
        request.remote_ip
      end
    end

    def country_name(country_code)
      CS.countries[:"#{country_code}"]
    end
end
