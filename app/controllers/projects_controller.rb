class ProjectsController < ApplicationController

  def index
  end
  
  def test_email
     ProjectsMailer.deliver_test_email
     render :nothing => true
  end

end
