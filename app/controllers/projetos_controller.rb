class ProjetosController < ApplicationController
  before_filter :authenticate_usuario!, :expect => [:index, :show]
  # GET /projetos
  # GET /projetos.json
  def index
    @projetos = Projeto.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projetos }
    end
  end

  # GET /projetos/1
  # GET /projetos/1.json
  def show
    @projeto = Projeto.find(params[:id])
    @enrollments = Enroll.find_all_by_projeto_id params[:id]

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @projeto }
    end
  end

  # GET /projetos/new
  # GET /projetos/new.json
  def new
    @projeto = Projeto.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @projeto }
    end
  end

  # GET /projetos/1/edit
  def edit
    @projeto = Projeto.find(params[:id])
  end

  # POST /projetos
  # POST /projetos.json
  def create
    @projeto = Projeto.new(params[:projeto])
    @projeto.usuario = current_usuario

    respond_to do |format|
      if @projeto.save
        format.html { redirect_to @projeto, notice: 'Projeto was successfully created.' }
        format.json { render json: @projeto, status: :created, location: @projeto }
      else
        format.html { render action: "new" }
        format.json { render json: @projeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projetos/1
  # PUT /projetos/1.json
  def update
    @projeto = Projeto.find(params[:id])

    respond_to do |format|
      if @projeto.update_attributes(params[:projeto])
        format.html { redirect_to @projeto, notice: 'Projeto was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @projeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projetos/1
  # DELETE /projetos/1.json
  def destroy
    @projeto = Projeto.find(params[:id])
    @projeto.destroy

    respond_to do |format|
      format.html { redirect_to projetos_url }
      format.json { head :no_content }
    end
  end

  def enroll
    enroll = Enroll.find_by_usuario_id params[:usuario]
    enroll.destroy unless enroll.nil?

    enroll = Enroll.new
    enroll.projeto = Projeto.find params[:projeto]
    enroll.usuario = current_usuario

    enroll.save

    flash[:message] = "You have enrolled with success"
    redirect_to :controller => :projetos, :action => :index
  end
  def cancel
    enroll = Enroll.find_by_usuario_id params[:usuario]
    enroll.destroy
    flash[:message] = "You have canceled your enrollment with success"
    redirect_to :controller => :projetos, :action => :index
  end

end
