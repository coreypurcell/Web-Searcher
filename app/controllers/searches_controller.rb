class SearchesController < ApplicationController
  before_filter :fetch_object, :only => [:show,:edit,:update,:destroy]
  
  def index
    @searches = Search.all
  end
  
  def show
    @results = @search.results
  end
 
  def new
    @search = Search.new
  end
 
  def create
    @search = Search.new(params[:search])
    if @search.save
      flash[:notice] = "Search created."
      redirect_to searches_path
    else
      render :action => 'new'
    end
  end
 
  def edit

  end
  
  def update
    if @search.update_attributes(params[:search])
      flash[:notice] = "Search updated."
      redirect_to searches_path
    else
      render :action => 'edit'
    end
  end
  
  def destroy    
    @search.destroy
    flash[:notice] = "Search deleted."
    redirect_to searches_url
  end
  
  private
  
  def fetch_object
    @search = Search.find(params[:id])
  end
  
end
