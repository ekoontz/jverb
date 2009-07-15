class InflectionsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @inflection_pages, @inflections = paginate :inflections, :per_page => 10
  end

  def show
    @inflection = Inflection.find(params[:id])
  end

  def new
    @inflection = Inflection.new
  end

  def create
    @inflection = Inflection.new(params[:inflection])
    if @inflection.save
      flash[:notice] = 'Inflection was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @inflection = Inflection.find(params[:id])
  end

  def update
    @inflection = Inflection.find(params[:id])
    if @inflection.update_attributes(params[:inflection])
      flash[:notice] = 'Inflection was successfully updated.'
      redirect_to :action => 'show', :id => @inflection
    else
      render :action => 'edit'
    end
  end

  def destroy
    Inflection.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
