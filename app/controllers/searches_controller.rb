class SearchesController < ApplicationController
  def list
    @searches = Search.all

    render("search_templates/list.html.erb")
  end

  def details
    @search = Search.where({ :id => params.fetch("id_to_display") }).first

    render("search_templates/details.html.erb")
  end

  def blank_form
    @search = Search.new

    render("search_templates/blank_form.html.erb")
  end

  def save_new_info
    @search = Search.new

    @search.text = params.fetch("text")
    @search.song_saved = params.fetch("song_saved", false)
    @search.user_id = params.fetch("user_id")
    
    api_endpoint = "http://api.musixmatch.com/ws/1.1/track.search?apikey=0527068478f4f577126db8333a867ba8&f_has_lyrics="+URI.encode(@search.text)
    require("open-uri")
    raw = open(api_endpoint).read
    parsed = JSON.parse(raw)
    @result = parsed.fetch("message").fetch("body").fetch('track_list')
    
    if @search.valid?
      @search.save
    
      # redirect_to("/searches", { :notice => "Search created successfully." })
      render("search_templates/results.html.erb")
    else
      render("search_templates/blank_form.html.erb")
    end
  end

  def prefilled_form
    @search = Search.where({ :id => params.fetch("id_to_prefill") }).first

    render("search_templates/prefilled_form.html.erb")
  end

  def save_edits
    @search = Search.where({ :id => params.fetch("id_to_modify") }).first

    @search.text = params.fetch("text")
    @search.song_saved = params.fetch("song_saved", false)
    @search.user_id = params.fetch("user_id")

    if @search.valid?
      @search.save

      redirect_to("/searches/" + @search.id.to_s, { :notice => "Search updated successfully." })
    else
      render("search_templates/prefilled_form.html.erb")
    end
  end

  def remove_row
    @search = Search.where({ :id => params.fetch("id_to_remove") }).first

    @search.destroy

    redirect_to("/searches", { :notice => "Search deleted successfully." })
  end
end
