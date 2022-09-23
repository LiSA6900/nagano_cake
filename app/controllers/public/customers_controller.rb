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

  def unsubscribe
  end

  def withdraw
    @customer = current_customer
    #is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :telephone_number, :address, :is_deleted, :postal_code)
  end

end
