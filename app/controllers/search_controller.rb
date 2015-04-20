class SearchController < ApplicationController

def search
  if params[:q].nil?
    @artifacts = []
  else
    @artifacts = Artifact.search params[:q]
  end

  respond_to do |format|
          format.html {render :layout => 'info'}
      end

end

end
