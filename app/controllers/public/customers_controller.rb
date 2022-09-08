class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
    @customer = current_user
  end

  def index
    @customers = Customer.page(params[:page])
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :last_name, :last_name_kana, :first_name_kana, :encrypted_password, :address, :is_deleted)
  end

end
