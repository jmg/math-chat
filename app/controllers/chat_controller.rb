# Chat Controller class
#
# This class handles the chat application

class ChatController < ApplicationController

    # The Index Page
    #
    # render - The Index page template
    def index
        @user = User.new
        render "index.html.erb"
    end

    # The chat Room controller
    #
    # id - The current user id
    #
    # render - The chat room template
    def room
        @user = User.find(params[:id])
        @messages = Message.find(:all, :order => "id desc", :limit => 225).reverse
        @message = Message.new
        render "room.html.erb"
    end

    # The messages update controller
    #
    # Get all the messages not fetched and update the
    # last update field of the current user
    #
    # id - The current user id
    #
    # render - The messages template if there's messages else none
    def update
        user = User.find(params[:id])
        #get all the not fetched messages for the current user
        @messages = Message.find :all, :conditions => ["sended_at > ?", user.last_update]
        #update the current user last update
        user.last_update = Time.now.to_f
        user.save
        #if there's messages then renderice else none
        if @messages.length > 0
            render "messages.html.erb", :layout => false
        else
            render :nothing => true
        end
    end

    # Create a new user
    #
    # post - the data of the new user
    #
    # redirect_to - the room controller
    def create_user
        @user = User.new(params[:user])
        @user.last_update = Time.now.to_f
        respond_to do |format|
          if @user.save
            format.html { redirect_to("/chat/room/#{@user.id}") }
            format.xml  { render :xml => @user, :status => :created, :location => @user }
          else
            format.html { render :action => "new" }
            format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
          end
        end
    end

    # Create a new message
    #
    # post - the data of the new message
    #
    # redirect_to - the update controller
    def create_message
        @message = Message.new(params[:message])
        @message.sended_at = Time.now.to_f
        respond_to do |format|
            if @message.save
                format.html { redirect_to("/chat/update/#{@message.user.id}") }
                format.xml  { render :xml => @message, :status => :created, :location => @message }
            else
                format.html { render :action => "new" }
                format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
            end
        end
    end
end
