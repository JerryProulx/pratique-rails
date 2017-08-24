class UsersController < ApplicationController
    before_action :get_user, only: [:update, :create, :edit]
    
    def index
        @users = User.all
    end
    
    def new
        @user = User.new()
    end
    
    def create
        if @user.save
            flash[:success] = "Welcome to the Alpha blog #{@user.username}"
            redirect_to articles_path
        else
            render 'new'
        end
    end
    
    def edit
    end
    
    def update
        if @user.update(user_params)
            flash[:success] = "User #{@user.username} was succesfully updated"
            redirect_to articles_path
        else
            flash[:danger] = "User cannot be updated"
            redirect_to articles_path
        end
    end
    
    def show
        @user = User.find(params[:id])
    end
    
    private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
    
    def get_user
        @user = User.find(params[:id])
    end
end