class WeeksController < ApplicationController
  def index
    raise ActionController::ParameterMissing if params[:year].blank?
    @year = params[:year].to_i
    weeks_nums = Entry.unscoped.where(year: @year).order(:week).distinct
                      .pluck(:week)
    @weeks = weeks_nums.map do |week_num|
      {
        week_num: week_num,
        week_start: (
          Date.strptime(@year.to_s + week_num.to_s.rjust(2, '0'), '%G%V')
        )
      }
    end
  end
end
