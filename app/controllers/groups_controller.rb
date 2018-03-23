class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  # GET /groups
  # GET /groups.json
  def index
    if current_project
      @groups = current_project.groups
    else
      @groups = Group.all
    end
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @other_chars = @group.project.characters - @group.characters
    @notable = @group
    @notes = @notable.notes
    @note = Note.new
  end

  def membership
    @group = Group.find(params[:group_id])
    @membership = Membership.create(group_id: @group.id, character_id: params[:character_id], role: params[:role])
    redirect_to @group
  end

  # GET /groups/new
  def new
    @group = Group.new
    @projects = Project.order(:title)
  end

  # GET /groups/1/edit
  def edit
    @projects = Project.order(:title)
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)

    @group.description = Sanitize.fragment(@group.description, Sanitize::Config::RELAXED)

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        @group.description = Sanitize.fragment(@group.description, Sanitize::Config::RELAXED)
        @group.save
        
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:title, :description, :project_id)
    end
end
