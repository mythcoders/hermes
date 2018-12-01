class MailLogsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_mail_log, only: %i[show]

  def index
    @mail_logs = MailLog.order(created_at: :desc).page(params[:page]).per(15)
  end

  private

  def set_mail_log
    @mail_log = MailLog.find(params[:id])
  end
end
