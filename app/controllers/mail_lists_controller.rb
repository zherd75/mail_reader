class MailListsController < ApplicationController
  before_action :set_mail_list, only: [:show, :edit, :update, :destroy]

  def index
    save_mails!
    @login = Login.find(session[:id])
    @mail_lists = MailList.by_user(@login.user, params[:order])
  end

  def edit
    @mail = MailList.find(params[:id])
  end

  def create
    @mail_list = MailList.new(mail_list_params)

    if @mail_list.save
      redirect_to @mail_list, notice: 'Mail list was successfully created.'
    else
      render :new
    end
  end

  private
  def set_mail_list
    @mail_list = MailList.find(params[:id])
  end

  def mail_list_params
    params.require(:mail_list).permit(:subject, :message, :date)
  end

  def save_mails!
    Mail.all.each do |m|    
      unless MailList.exists?(date: m.date, from_addr: m.from.first)
        mp = m.dup
        while mp.multipart?
          mp = mp.parts.first
        end
        message = mp.body.decoded

        MailList.new(subject: m.subject, message: message, from_addr: m.from.first, to_addr: m.to.first, date: m.date, logins_id: session[:id]).save
      end
    end
  end
end
