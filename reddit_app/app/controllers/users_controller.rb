class UsersController < ApplicationController

    before_action :ensure_logged_in, only: [:destroy, :show]
    def index 
        @users = User.all 

        render :index
    end

    def show 
        @user = User.find(params[:id])

        render :show 
    end

    def new 
        @user = User.new 

        render :new 
    end

    def create 
        @user = User.new(user_params)

        if @user.save 
            login!(@user)

            redirect_to users_url 
        else  
            flash.now[:errors] = @user.errors.full_messages
            render :new 
        end
    end

    def edit 
        @user = User.find(params[:id])

        render :edit
    end

    def update 
        @user = User.find(params[:id])

        if @user.update_attributes(user_params)
            flash.now[:success] = ["Successfully edited #{@user.username}!"]
            redirect_to user_url(@user) 
        else  
            flash.now[:errors] = ['Inccorect username or password']
            render :edit 
        end
    end

    def user_params 
        params.require(:user).permit(:username, :password)
    end
end