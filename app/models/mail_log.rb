# frozen_string_literal: true

class MailLog < ApplicationRecord
  belongs_to :client

  validates_presence_of :to, :subject, :client

  def formatted_to
    to.split(',')
  end

  def formatted_cc
    cc.split(',')
  end

  def formatted_bcc
    bcc.split(',')
  end

  def html?
    content_type == 'html'
  end

  def text?
    content_type == 'text'
  end
end
