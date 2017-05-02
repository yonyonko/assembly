class AssembliesController < ApplicationController
  before_action :set_assembly, only: [:show, :edit, :update, :destroy]
  before_action :set_stockholder, only: [:new, :edit, :update, :destroy]

  # GET /assemblies
  # GET /assemblies.json
  def index
    @assemblies = current_user.assemblies.all
  end

  # GET /assemblies/1
  # GET /assemblies/1.json
  def show
  end

  # GET /assemblies/new
  def new
    @assembly = current_user.assemblies.build
    @assembly.user.stockholders.each do |stockholder|
      @assembly.stockholders.push stockholder
      
    end
  end

  # GET /assemblies/1/edit
  def edit
  end

  # POST /assemblies
  # POST /assemblies.json
  def create
    @assembly = current_user.assemblies.build(assembly_params)
    @assembly.stockholders = current_user.stockholders.where(id: params[:assembly][:stockholders_attributes].map{|k,v| v[:id]})
    
    respond_to do |format|
      if @assembly.save
        format.html { redirect_to @assembly, notice: 'Assembly was successfully created.' }
        format.json { render :show, status: :created, location: @assembly }
      else
        format.html { render :new }
        format.json { render json: @assembly.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assemblies/1
  # PATCH/PUT /assemblies/1.json
  def update
    respond_to do |format|
      if @assembly.update(assembly_params)
        format.html { redirect_to @assembly, notice: 'Assembly was successfully updated.' }
        format.json { render :show, status: :ok, location: @assembly }
      else
        format.html { render :edit }
        format.json { render json: @assembly.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assemblies/1
  # DELETE /assemblies/1.json
  def destroy
    @assembly.destroy
    respond_to do |format|
      format.html { redirect_to assemblies_url, notice: 'Assembly was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assembly
      @assembly = Assembly.find(params[:id])
    end
    
    def set_stockholder
      @stockholders = current_user.stockholders.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assembly_params
    #  params.require(:assembly).permit(:name, :description,
    #                             [
    #                               stockholders_attributes: [
    #                                 :id
    #                               ]
    #                             ])
    params.require(:assembly).permit(:name, :description)
    end
end
