class ExhibitsController < ApplicationController
  def index
    if user_signed_in?
      @user = User.find(current_user)
      @user_detail = UserDetail.find_by(user_id: @user.id)
      @mastname = @user_detail.try(:lastname) || ''
      @mastname += @user_detail.try(:firstname) || '名無し'
      @mastname += 'さん'
    else
      @mastname  = 'ログイン/新規登録'
    end
    @exhibits = Exhibit.includes(:user)
  end



  def show
    @exhibit = Exhibit.find(params[:id])
  end

end

