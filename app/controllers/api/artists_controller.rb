class Api::ArtistsController < ApplicationController
  respond_to :json

  def index
    artists = Artist.all.limit(10)#.includes(:songs)
    respond_with artists
  end

  def show
    artist = Artist.find(params[:id])#.includes(:songs)
    respond_with artist
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
