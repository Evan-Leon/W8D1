class SubsController < ApplicationController 
    before_action :ensure_logged_in, only: [:new, :create, :edit, :update]
    def new 
        @sub = Sub.new 

        render :new 
    end

    def create 
        @sub = Sub.new(sub_params)
        @sub.moderator_id = User.find(params[:moderator_id])
        if @sub.save 
            flash[:success] = ['New Sub Created']
            redirect_to sub_url(@sub)
        else  
            flash[:errors] = @sub.errors.full_messages
            render :new 
        end
    end

    def index 
        @subs = Sub.all 
        render :index 
    end

    def show 
        @sub = Sub.find(params[:id])
        render :show 
    end

    def edit 
        @sub = Sub.find(params[:id])
        render: edit 
    end

    def update 
        @sub = Sub.find(params[:id])

        if @sub.moderator_id == current_user.id 
            if @sub.update_attributes(sub_params)
                flash[:success] = ['Sub updated']
                redirect_to subs_url
            else  
                flash.now[:errors] = ['Incorrect Title or Description']
                render :edit 
            end
        else  
            flash.now[:errors] = ['You are not the moderator']
            render :edit 
        end
    end

    def sub_params 
        params.require(:sub).permit(:title, :description)
    end
end