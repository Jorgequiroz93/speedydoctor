require "prawn"

Prawn::Document.generate("hello.pdf") do
  text "Hello World!"
end

class ReportsController < ApplicationController
end
