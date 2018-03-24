class CharactersController < ApplicationController
  before_action :set_character, only: [:show, :edit, :update, :destroy]

  # GET /characters
  # GET /characters.json
  def index
    if current_project
      @characters = current_project.characters
    else
      @characters = current_user.characters
    end
  end

  # GET /characters/1
  # GET /characters/1.json
  def show
    @other_groups = @character.project.groups - @character.groups
    @notable = @character
    @notes = @notable.notes
    @note = Note.new
  end

  def membership
    @character = Character.find(params[:character_id])
    @membership = Membership.create(group_id: params[:group_id], character_id: @character.id, role: params[:role])
    redirect_to @character
  end

  # GET /characters/new
  def new
    @character = Character.new
    @projects = Project.order(:title)
  end

  # GET /characters/1/edit
  def edit
    @projects = Project.order(:title)
  end

  # POST /characters
  # POST /characters.json
  def create
    @character = Character.new(character_params)

    @character.details = Sanitize.fragment(@character.details, Sanitize::Config::RELAXED)

    respond_to do |format|
      if @character.save
        format.html { redirect_to @character, notice: 'Character was successfully created.' }
        format.json { render :show, status: :created, location: @character }
      else
        format.html { render :new }
        format.json { render json: @character.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /characters/1
  # PATCH/PUT /characters/1.json
  def update
    respond_to do |format|
      if @character.update(character_params)
        @character.details = Sanitize.fragment(@character.details, Sanitize::Config::RELAXED)
        @character.save
        format.html { redirect_to @character, notice: 'Character was successfully updated.' }
        format.json { render :show, status: :ok, location: @character }
      else
        format.html { render :edit }
        format.json { render json: @character.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /characters/1
  # DELETE /characters/1.json
  def destroy
    @character.destroy
    respond_to do |format|
      format.html { redirect_to characters_url, notice: 'Character was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_character
      @character = Character.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def character_params
      params.require(:character).permit(:nym, :fullname, :birthyear, :details, :project_id)
    end
end
