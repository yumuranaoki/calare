class StaticPagesController < ApplicationController
  def home
    if logged_in?
      redirect_to you_path
    end
  end

  def react
  end
end
