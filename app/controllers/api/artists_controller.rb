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
    labels = {
      nil => 'Unknown',
      0 => 'None',
      1 => 'Backing',
      2 => 'Fronted',
      3 => 'All'
    }
    stats = Artist.where('fem_level is not null').group_by(&:fem_level).map do |k,v|
      {
        label: labels[k],
        value: v.length
      }
    end
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
