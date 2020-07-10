class YearsController < ApplicationController
  def index
    @years = Entry.order(year: :desc).distinct.pluck(:year)
  end
end
