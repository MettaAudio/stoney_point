# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  volunteer_form = $('.js-volunteer-form')
  caddie_form    = $('.js-caddie-form')
  golfer_form    = $('.js-golfer-form')

  $('.js-volunteer-form').hide() if volunteer_form.data('volunteer-present') == false
  $('.js-caddie-form').hide() if caddie_form.data('caddie-present') == false
  $('.js-golfer-form').hide() if golfer_form.data('golfer-present') == false

  $(".js-volunteer-btn").on "click", ->
    $('.js-volunteer-form').toggle 'fast', ->
      $('.js-volunteer-form input:visible').prop 'disabled', false
      $('.js-volunteer-form select:visible').prop 'disabled', false
      $('.js-volunteer-form input:hidden').prop 'disabled', true
      $('.js-volunteer-form select:hidden').prop 'disabled', true

  $(".js-caddie-btn").on "click", ->
    $('.js-caddie-form').toggle 'fast', ->
      $('.js-caddie-form input:visible').prop 'disabled', false
      $('.js-caddie-form select:visible').prop 'disabled', false
      $('.js-caddie-form input:hidden').prop 'disabled', true
      $('.js-caddie-form select:hidden').prop 'disabled', true

  $(".js-golfer-btn").on "click", ->
    $('.js-golfer-form').toggle 'fast', ->
      $('.js-golfer-form input:visible').prop 'disabled', false
      $('.js-golfer-form select:visible').prop 'disabled', false
      $('.js-golfer-form input:hidden').prop 'disabled', true
      $('.js-golfer-form select:hidden').prop 'disabled', true