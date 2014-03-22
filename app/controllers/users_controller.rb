class UsersController < ApplicationController
  skip_before_filter :authorize
  def index
    @users = User.order(:name)
    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @users }
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        format.html { redirect_to(new_order_path,
            :notice => "User #{@user.name} was successfully created.") }
        format.xml { render :xml => @user,
          :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @user.errors,
          :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(users_url,
            :notice => "User #{@user.name} was successfully updated.") }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @user.errors,
          :status => :unprocessable_entity }
      end
    end
  end

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def destroy
    @user = User.find(params[:id])
    begin
      @user.destroy
      flash[:notice] = "User #{@user.name} deleted"
    rescue Exception => e
      flash[:notice] = e.message
    end

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

end
