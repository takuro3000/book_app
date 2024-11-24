// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require jquery
//= require rails-ujs
import { Turbo } from "@hotwired/turbo-rails"
Turbo.session.drive = false
import "controllers"
