class EntriesController < ApplicationController
  def create
    year = params[:entries][:year].to_i
    week = params[:entries][:week].to_i
    if year.blank? || week.blank?
      raise ActionController::ParameterMissing
    end

    if year < 1950 || year >= 2100 || week < 1 || week > 53
      raise ActionController::BadRequest
    end

    if params[:entries][:songs].values.uniq!.present?
      raise ActionController::BadRequest
    end


    ActiveRecord::Base.transaction do
      (1..10).each do |position|
        song_id = params[:entries][:songs]["#{position}"]
        Entry.create!(
          year: year, week: week, position: position, song_id: song_id
        )
      end
    end

    redirect_to entries_path(year: year, week: week)
  end

  def edit
    @year = params[:year].to_i
    @week = params[:week].to_i

    @entries = Entry.where(year: @year, week: @week).all
    raise ActionController::BadRequest if @entries.size < 10
  end

  def index
    @year = params[:year].to_i
    @week = params[:week].to_i

    @entries = Entry.where(year: @year, week: @week).all
    raise ActionController::RoutingError if @entries.size < 10

    @week_start = Date.strptime(@year.to_s + @week.to_s.rjust(2, '0'), '%G%V')
    @prev_week = @week_start - 1.week
    @next_week = @week_start + 1.week
    @week_end = @next_week - 1.day
  end

  def new
  end

  def update
    year = params[:year].to_i
    week = params[:week].to_i

    if params[:entries][:songs].values.uniq!.present?
      raise ActionController::BadRequest
    end

    ActiveRecord::Base.transaction do
      (1..10).each do |position|
        entry = Entry.where(year: year, week: week, position: position).first
        song_id = params[:entries][:songs]["#{position}"]
        entry.update!(song_id: song_id)
      end
    end

    redirect_to entries_index_path(year: year, week: week)
  end
end
