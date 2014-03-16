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
