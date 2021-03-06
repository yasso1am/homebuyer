class Api::HousesController < ApplicationController
  before_action :set_house, only: [:show, :update, :destroy]
  
  def index
    render json: current_user.houses
  end

  def show
    render json: @house
  end

  def create
    math_house = House.do_math(house_params)
    new_house = current_user.houses.create(math_house)
       if new_house.save
        render json: new_house
      else
        render json: {errors: new_house.errors.full_messages}, status: 422
      end
  end

  def update
    if @house.update(house_params)
      render json: @house
    else
      render json: {errors: @house.errors.full_messages}, status: 422
    end
  end

  def destroy
    @house.destroy
  end

  private
    def set_house
      @house = House.find(params[:id])
    end

    def house_params
      params.require(:house).permit(
        :name,
        :payments_per_year,
        :loan_term,
        :purchase_price,
        :loan_amount,
        :down_payment_amount,
        :down_payment_percent,
        :pmi,
        :interest_rate,
        :insurance_monthly,
        :property_tax_annual,
        :property_tax_monthly,
        :hoa_monthly,
        :down_payment_amount,
        :monthly_principal_interest,
        :monthly_payment_total,
        :total_interest,
        :total_principal_interest,
        :move_in_price,
        :closing_cost,
        :discount_points,
        :user_id
        )
    end

end
