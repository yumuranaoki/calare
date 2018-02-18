class ApiController < ApplicationController
  def receivedate
    logger.debug("でばっぐ：#{params[:startdate]}")
  end

  def receivetime
    logger.debug("でばっぐ：#{params}")
  end
end
