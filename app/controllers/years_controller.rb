class YearsController < ApplicationController
  def index
    @years = Entry.unscoped.order(year: :desc).distinct.pluck(:year)
  end
end
