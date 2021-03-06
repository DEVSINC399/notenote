class NotesController < ApplicationController
    before_action :find_note, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!
    def index
        @notes = current_user.notes.order("created_at desc")
    end

    def new
        @note = current_user.notes.new
    end
    
    def create
        @note = current_user.notes.new(note_params)
        if @note.save
            redirect_to @note, alert: "Record Saved Successfully."
        else
            render 'new'
        end
    end

    def edit
    end

    def update
        if @note.update(note_params)
            redirect_to @note, alert: "Record Updated Successfully."
        else
            render 'edit'
        end
    end

    def destroy
        @note.destroy
        redirect_to root_path, alert: "Record Deleted Successfully."
    end

    private
        def find_note
            @note = Note.find(params[:id])
        end

        def note_params
            params.require(:note).permit(:title, :content)
        end
end
