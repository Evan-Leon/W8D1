class PostsController < ApplicationController 

    def show 
        @post = Post.find(params[:id])

        render :show 
    end

    def new 
        @post = Post.new 

        render :new 
    end

    def create 
        @post = Post.new(post_params)
        @post.author_id = params[:user_id]
        sub_id = Sub.find_by(title: params[:sub])
        if @post.save 
            redirect_to sub_url(sub_id)
        else  
            flash.now[:errors] = @post.errors.full_messages
            render :new 
        end
    end

    def edit 
        @post = Post.find(params[:id])
        render :edit 
    end

    def update 
        @post = Post.find(params[:id])
        sub_id = Sub.find_by(title: params[:sub])
        if @post.update_attributes(post_params)
            flash[:success] = "Successfully edited post!"
            redirect_to sub_url(sub_id)
        else  
            flash.now[:errors] = ["something wrong with your post lad"]
            render :edit 
        end
    end

    def destroy 
        @post = Post.find(params[:id])
        sub_id = Sub.find_by(title: @post.sub)
        if @post.author_id == current_user.id 
            if @post.delete 
                flash[:success] = ["successfully deleted post!"]
            else  
                flash[:errors] = ["unable to delete post"]
            end
        else  
            flash[:errors] = ["Sorry, you can't delete a post you didn't author"]
            
        end
        redirect_to sub_url(sub_id)
    end 

    def post_params
        params.require(:post).permit(:title, :url, :content, :sub_id)
    end
end