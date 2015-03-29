class LinksController < ApplicationController
  helper_method :full_url
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  def index
    @urls = Url.take(100)
  end

  def create
    @url = Url.find_by(link: params[:url][:link]) || Url.create(url_params)

    if @url.valid?
      flash[:success] = 'Url Shortened successfully!'
      flash[:short_url] = full_url(@url)
    else
      flash[:error] = 'Invalid url!'
    end

    redirect_to action: :index
  end

  def show
    url = Url.find_by_slug(params[:slug])
    url.visits << Visit.create(ip: request.ip, referer: request.referer)
    redirect_to url.link
  end

  private 

  def record_not_found
    render :text => "404 Not Found", :status => 404
  end

  def full_url(url)
    "#{request.original_url}#{url.slug}"
  end

  def url_params
     params.require(:url).permit(:link)
  end
end
