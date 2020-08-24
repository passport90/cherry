module ApplicationHelper
  def artist_link(artist)
    link_to artist.name, artist_path(artist)
  end

  def display_song_artist_with_link(song)
    if song.artists.size == 1
      artist_link(song.artists.first)
    elsif song.artists.size == 2
      song.artists.map do |artist|
        artist_link(artist)
      end.join(' and ')
    else
      song.artists.take(song.artists.size - 1).map do |artist|
        artist_link(artist)
      end.join(', ') + ", and #{artist_link(song.artists.last)}"
    end
  end
end
