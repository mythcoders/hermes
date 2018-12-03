# frozen_string_literal: true

class ApiMailer < ApplicationMailer
  before_action { @mail = params[:mail] }

  def regular
    mail(from: @mail.from,
         to: @mail.to,
         subject: @mail.subject)
  end

  def reroute
    mail(to: @mail.client.reroute_email,
         subject: "[Rerouted email] #{@mail.subject}")
  end
end
