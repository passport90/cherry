class Entry < ApplicationRecord
  extend Memoist
  belongs_to :song
  default_scope { includes(:song).order(:year).order(:week).order(:position) }

  def previous_entry
    Entry.unscoped.where(song: song)
          .where('year <= ?', year).where('week < ?', week)
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
        '🔼️'
      else
        '️️❇️️️'
      end
    elsif difference > 0
      '🔼️'
    elsif difference < 0
      '🔽'
    else
      '➖'
    end
  end

  def indirect_previous?
    return if previous_entry.nil?
    if year == previous_entry.year
      week - previous_entry.week > 1
    elsif week == 1
      date = Date.strptime(year.to_s + week.to_s.rjust(2, '0'), '%G%V')
      prev_entry_date = Date.strptime(
        previous_entry.year.to_s + previous_entry.week.to_s.rjust(2, '0'),
        '%G%V'
      )
      date - prev_entry_date > 1.week
    end
  end
  memoize :indirect_previous?
end
