#!/usr/bin/ruby
# @Author: msmiller
# @Date:   2017-06-22 11:24:23
# @Last Modified by:   Mark S. Miller
# @Last Modified time: 2017-06-22 12:45:51
#
# Copyright (c) 2017 Silicon Chisel / Mark S. Miller

module SharpstoneCaptcha

  require 'active_support/core_ext/integer/inflections'
  require 'active_support/inflector'
  require 'active_support/message_encryptor'
  require 'active_support/message_verifier'

  MONTHNAMES = [nil, "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

  def self.verify_data_captcha(params, key)
    if params[:date_captcha_answer] && params[:date_captcha_id]
      m,d = self.crypt_out(params[:date_captcha_id], key).split("-")
      if (m.to_i + d.to_i) == params[:date_captcha_answer].to_i
        return true
      end
    end
    return false
  end

  def self.data_for_form(key)
    d = Time.now.day
    m = Time.now.month

    { 
      :date_captcha_id => self.crypt_in("#{m}-#{d}", key),
      :date_captcha_string => "Today is the #{Time.now.day.ordinalize} of #{SharpstoneCaptcha::MONTHNAMES[m]}"
    }
  end

  #### UTILITY FUNCTIONS ####

private

  # For captcha support - see: http://stackoverflow.com/questions/5492377/encrypt-decrypt-using-rails
  def self.crypt_in(s, k)
    crypt = ActiveSupport::MessageEncryptor.new(k)
    crypt.encrypt_and_sign(s)
  end

  def self.crypt_out(s, k)
    crypt = ActiveSupport::MessageEncryptor.new(k)
    crypt.decrypt_and_verify(s)
  end

end


=begin
require 'sharpstone_captcha'

# key will usually be: Rails.application.secrets.secret_key_base

k = "qoeuryfhowe8gnwr78t0948cgcnmerwhgxhr4gcmrshgr8hg85hg89hr8hgrt"
scp = SharpstoneCaptcha.data_for_form(k)
p scp.inspect
scp[:date_captcha_answer] = "28"
SharpstoneCaptcha.verify_data_captcha(scp, k)

=end
