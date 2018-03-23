class NotesController < ApplicationController
	before_action :load_notable
  
  def create
  	@note = @notable.notes.new(note_params)
  	@note.content = Sanitize.fragment(@note.content, Sanitize::Config::RELAXED)
  	@note.save
  	if @note.save
  		redirect_to [@notable], notice: 'Note created'
  	else
  		render :new
  	end
  end

  private

  def load_notable
  	resource, id = request.path.split('/')[1,2]
  	@notable = resource.singularize.classify.constantize.find(id)
  end

  def note_params
    params.require(:note).permit(:title, :content)
  end
end
