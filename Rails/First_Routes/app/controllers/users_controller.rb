class UsersController < ApplicationController
    def index
        render json: User.all
    end

    def create
        user= User.new(person_params)
        if user.save
            render json: user
        else
            render json: user.errors.full_messages, status: :unprocessable_entity
        end
    end

    def show
        render json: User.find(params[:id])
    end

    def update
        user= User.find(params[:id])
        updated_user = user.update(params.require(:person).permit(:name, :email))
        updated_user= User.find(params[:id])
        render json: updated_user
    end

    def destroy
        user= User.find(params[:id])
        user.destroy
        render json: user
    end

    private

    def person_params
        params[:person].permit(:name, :email)
    end
end