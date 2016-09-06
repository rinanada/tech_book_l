class OrdersController < ApplicationController
    before_action :set_user, only: [:new, :create]
    before_action :authenticate_user!, only: [:new ,:create]

  def new
    @book_price = (@book.price + 200) * 1.08.floor
    @tax = (@book.price + 200) * 0.08.floor
  end

  def create
    @order = @user.orders.create(book_id: @book.id)
    @book.update(sold?: "y", o_user_id: @user.id)
  end


  private

  def user_detail_params
    params.require(:user_detail).permit(:lastname, :firstname, :postalcode, :place, :email, :callnumber)
  end

  def user_params
    params.require(:user).permit(:email)
  end

  def set_user
    @user = User.find(current_user)
    @user_detail = UserDetail.find_by(user_id: @user.id)
    @book = Book.find(params[:book_id])
  end
end
