class VotesController < ApplicationController

  def create
    
    if session[:user_id]
      work = Work.find_by(id: params[:work_id])
      user = User.find_by(id: session[:user_id])
      vote = Vote.new
      vote.work = work
      vote.user = user
      if vote.save
        flash[:success] = "Successfully upvoted!"
        redirect_back(fallback_location: :back)
        Work.increment_counter(:votes_count, work.id)
      else
        flash[:error] = "A problem occurred: Could not upvote"
        redirect_back(fallback_location: :back)
      end

    else
      flash[:error] = "A problem occurred: You must log in to do that"
      redirect_back(fallback_location: :back)
    end
    

  end
end
