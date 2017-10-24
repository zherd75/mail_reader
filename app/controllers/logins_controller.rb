class LoginsController < ApplicationController
  before_action :set_login, only: [:show, :edit, :update, :destroy]

  def index
    redirect_to new_login_url
  end
  
  def new
    @login = Login.new
  end

  def create
    @login = Login.new(login_params)

    auth_data = {
      :address => MAIL_SETTINGS['server'],
      :port       => MAIL_SETTINGS['port'],
      :user_name  => params[:login][:user],
      :password   => params[:login][:password],
      :enable_ssl => MAIL_SETTINGS['ssl']
    }

    begin
      Mail.defaults { retriever_method MAIL_SETTINGS['type'].to_sym, auth_data }
      Mail.first
    rescue
      flash.now[:alert] = 'Auth failed! Try again.'
      render :new
    else
      if @login.save
        session[:id] = @login.id
        redirect_to login_mail_lists_url(login_id: @login.id), notice: 'Login was successfully created.'
      else
        render :new
      end
    end
  end

  def logout
    session[:id] = nil
    redirect_to logins_url
  end

  private

  def login_params
    params.require(:login).permit(:user)
  end

end
