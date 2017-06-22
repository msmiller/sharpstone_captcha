#!/usr/bin/ruby
# @Author: Mark S. Miller
# @Date:   2017-06-22 15:56:26
# @Last Modified by:   Mark S. Miller
# @Last Modified time: 2017-06-22 16:22:50
#
# Copyright (c) 2017 Silicon Chisel / Mark S. Miller

require 'minitest/autorun'
require 'sharpstone_captcha'

class CaptchaTest < Minitest::Test

  def set_up
    @k = "qoeuryfhowe8gnwr78t0948cgcnmerwhgxhr4gcmrshgr8hg85hg89hr8hgrt"
    @d = Time.now.day
    @m = Time.now.month
  end

  def test_good_entry # should return true
    #p "Testing a valid answer"
    set_up
    scp = SharpstoneCaptcha.data_for_form(@k)
    scp[:ssc_captcha_answer] = @d + @m
    assert(SharpstoneCaptcha.verify_captcha(scp, @k), "Good entry test passed")
  end

  def test_bad_entry # should return false
    #p "Testing an INvalid answer (should return false)"
    set_up
    scp = SharpstoneCaptcha.data_for_form(@k)
    scp[:ssc_captcha_answer] = @d + @m + 1
    assert(!SharpstoneCaptcha.verify_captcha(scp, @k), "Bad entry test passed")
  end

  def test_null_entry # should return false
    #p "Testing an NULL answer (should return false)"
    set_up
    scp = SharpstoneCaptcha.data_for_form(@k)
    scp[:ssc_captcha_answer] = nil
    assert(!SharpstoneCaptcha.verify_captcha(scp, @k), "Bad entry test passed")
  end

  def test_blank_entry # should return false
    #p "Testing an NULL answer (should return false)"
    set_up
    scp = SharpstoneCaptcha.data_for_form(@k)
    scp[:ssc_captcha_answer] = ""
    assert(!SharpstoneCaptcha.verify_captcha(scp, @k), "Bad entry test passed")
  end

  def test_string_generation
    set_up
    scp = SharpstoneCaptcha.data_for_form(@k)
    assert_equal "Today is the #{@d.ordinalize} of #{SharpstoneCaptcha::MONTHNAMES[@m]}", scp[:ssc_captcha_string]
  end

  #def test_english_hello
  #  assert_equal "hello world",
  #    Hola.hi("english")
  #end
#
  #def test_any_hello
  #  assert_equal "hello world",
  #    Hola.hi("ruby")
  #end
#
  #def test_spanish_hello
  #  assert_equal "hola mundo",
  #    Hola.hi("spanish")
  #end
end
