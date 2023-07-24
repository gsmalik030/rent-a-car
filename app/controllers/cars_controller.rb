class CarsController < ApplicationController
  before_action :set_car, only: %i[ show update destroy ]

  # GET /cars
  def index
    @cars = Car.all

    render json: CarSerializer.new(@cars).serializable_hash[:data].map{|hash| hash[:attributes]}
  end

  # GET /cars/1
  def show
    render json: @car
  end

  # POST /cars
  def create
    if @current_user.admin?
    @car = Car.new(car_params)

    if @car.save
      render json: @car, status: :created, location: @car
    else
      render json: @car.errors, status: :unprocessable_entity
    end
    return
  end
  forbidden
end

  # PATCH/PUT /cars/1
  def update
    if @current_user.admin?
    if @car.update(car_params)
      render json: @car
    else
      render json: @car.errors, status: :unprocessable_entity
    end
    return
  end
  forbidden
end

  def latest
    @car = Car.last
    render json:CarSerializer.new(@car).serializable_hash[:data][:attributes]
  end


  # DELETE /cars/1
  def destroy
    if @current_user.admin?
    @car.destroy
    render json: @car, status: 200
    return
    end
    forbidden
    rescue ActiveRecord::RecordNotFound
      not_found('Car')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def car_params
    params.require(:car).permit(:name, :color, :model, :rent, :rating, :description, :image)
    end
end
