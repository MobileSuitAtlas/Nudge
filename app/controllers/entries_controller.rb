class EntriesController < ApplicationController
    def create
        @habit = Habit.find(params[:habit_id])
        @entry = @habit.entries.build(entry_params)

        if @entry.save
            flash[:notice] = "Entry added! 💭"
        else
            flash[:alert] = "Couldn't save your entry. Did you write something?"
        end

        redirect_to habit_path(@habit)
    end

    def destroy
        @entry = Entry.find(params[:id])
        @habit = @entry.habit
        @entry.destroy

        flash[:notice] = "Entry removed."
        redirect_to habit_path(@habit)
    end

    private

    def entry_params
        params.require(:entry).permit(:content, :entry_date)
    end
end
