class ArtworksController < ApplicationController
    def index
        if params[:user_id]
            render json: Artwork.artwork_for_user_id(params[:user_id])
        end
    end

    def show
        render json: Artwork.find(params[:id])
    end

    def create
        artwork= Artwork.new(artwork_params)
        if artwork.save
            render json: artwork
        else
            render json: artwork.errors.full_messages, status: :unprocessable_entity
        end
    end

    def update
        artwork= Artwork.find(params[:id])
        if artwork.update(artwork_params)
            render json: artwork
        else
            render json: artwork.errors.full_messages, status: :unprocessable_entity
        end
    end

    def destroy
        artwork= Artwork.find(params[:id])
        render json: artwork.destroy
    end

    def like
        like= Like.new(user_id: params[:user_id], likeable_id: params[:id], likeable_type: :Artwork)
        if like.save
            render json: like
        else
            render json: like.errors.full_messages, status: :unprocessable_entity
        end
    end

    def unlike
        unlike= Like.find_by(user_id: params[:user_id], likeable_id: params[:id], likeable_type: :Artwork)
        if unlike.destroy
            render json: unlike
        else
            render json: unlike.errors.full_messages, status: :unprocessable_entity
        end
    end

    private

    def artwork_params
        params.require[:artwork].permit(:title, :image_url, :artist_id)
    end
end