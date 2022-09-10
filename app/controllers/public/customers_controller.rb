class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def index
    @customers = Customer.page(params[:page])
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    @customer.update(customer_params)
    redirect_to customers_my_page_path
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :last_name, :last_name_kana, :first_name_kana, :encrypted_password, :address, :is_deleted, :email, :postal_code)
  end

end
