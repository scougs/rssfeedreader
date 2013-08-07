class EntriesController < ApplicationController


  def show
    @entry = Entry.find(params[:id])
    @sidebar_hidden = true
  end

end
