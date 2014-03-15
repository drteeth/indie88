class SongsController < ApplicationController

  def index
    @artists = Song.all.map {|s| s.songartist}.uniq
  end

end