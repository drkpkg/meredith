class PageController < ApplicationController
  before_filter :verify_user

  layout 'welcome'
  def index

  end

  def not_found
    render text: '404'
  end
end
