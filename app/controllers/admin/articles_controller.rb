class Admin::ArticlesController < ApplicationController::Admin
  
  # GET /articles
  # GET /articles.xml
  def index
    @articles = Article.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @articles }
      format.atom { render :layout => false }
    end
  end

  # GET /articles/1
  # GET /articles/1.xml
  def show
    @article = Article.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @article }
      format.atom { render :partial => "entry", :object => @article, :content_type => Mime::ATOM, :layout => false }
    end
  end

  # GET /articles/new
  # GET /articles/new.xml
  def new
    @article = Article.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @article }
    end
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id])
    render :new
  end

  # POST /articles
  # POST /articles.xml
  def create
    @article = Article.new(params[:article] || params[:entry])

    respond_to do |format|
      if @article.save
        flash[:notice] = 'Article was successfully created.'
        
        format.atom { render :partial => "entry", :object => @article, :content_type => Mime::ATOM, :status => :created, :location => [:admin, @article] }
        
        format.html { redirect_to [:admin, @article] }
        format.xml  { render :xml => @article, :status => :created, :location => [:admin, @article] }
        
      
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
        format.atom { render :text => @article.errors.full_messages.join("\n"), :status => :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.xml
  def update
    @article = Article.find(params[:id])

    respond_to do |format|
      if @article.update_attributes(params[:article] || params[:entry])
        flash[:notice] = 'Article was successfully updated.'
        format.html { redirect_to(@article) }
        format.xml  { head :ok }
        format.atom { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.xml
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to(articles_url) }
      format.xml  { head :ok }
      format.atom { head :ok }
    end
  end
  
end
