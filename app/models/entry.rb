class Entry < ApplicationRecord
  extend Memoist
  belongs_to :song
  default_scope { includes(:song).order(:year).order(:week).order(:position) }

  def previous_entry
    Entry.unscoped.where(song: song)
         .where('(year = ? and week < ?) or (year < ?)', year, week, year)
         .order(:year, :week).last
  end
  memoize :previous_entry

  def difference
    if previous_entry.nil? || indirect_previous?
      nil
    else
      previous_entry.position - position
    end
  end
  memoize :difference

  def difference_display
    if difference.nil?
      if indirect_previous?
        're'
      else
        'new'
      end
    elsif difference == 0
      nil
    else
      "%+d" % difference
    end
  end

  def state
    if difference.nil?
      if indirect_previous?
        { symbol: '⬆︎', color: 'green' }
      else
        { symbol: '️️✽', color: 'gold' }
      end
    elsif difference > 0
      { symbol: '⬆︎', color: 'green' }
    elsif difference < 0
      { symbol: '⬇︎', color: 'red' }
    else
      { symbol: '—', color: 'gray' }
    end
  end
  memoize :state

  def indirect_previous?
    return if previous_entry.nil?
    if year == previous_entry.year
      week - previous_entry.week > 1
    elsif week == 1
      week_start - previous_entry.week_start > 1.week
    end
  end
  memoize :indirect_previous?

  def week_start
    @week_start ||= Date.strptime(year.to_s + week.to_s.rjust(2, '0'), '%G%V')
  end

  def week_end
    @week_end ||= week_start + 6.days
  end
end
