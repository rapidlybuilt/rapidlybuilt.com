class Apps::PagesController < Apps::BaseController
  def index
    build_breadcrumb "Home"
  end

  def rapidlybuilt_com
    build_breadcrumb "rapidlybuilt.com"
  end
end
