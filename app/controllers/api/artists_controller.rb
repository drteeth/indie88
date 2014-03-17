class Api::ArtistsController < ApplicationController
  respond_to :json

  def index
    artists = Artist.order(:name)
    respond_with artists
  end

  def show
    artist = Artist.find params[:id]
    respond_with artist
  end

  def stats
    sql = <<-SQL
      select fem_level, count(fem_level)
      from songs s
      inner join artists a
      on s.artist_id = a.id
      where a.fem_level is not null
      group by fem_level;
    SQL
    stats = ActiveRecord::Base.connection.select_all(sql)

    # TODO use rail-y syntax
    # Song.includes(:artist).where('artists.fem_level is not null').references(:artists).group(:fem_level).count

    render json: stats
  end

  def create
    artist = Artist.new artist_params
    artist.save
    respond_with artist
  end

  def update
    artist = Artist.find params[:id]
    artist.update_attributes artist_params
    respond_with artist
  end

  private

  def artist_params
    params.require(:artist).permit(:name, :fem_level)
  end

end
