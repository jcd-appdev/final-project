class SavedSongsController < ApplicationController
  def list
    @saved_songs = SavedSong.all

    @search_text = SavedSong.first.artist+" "+SavedSong.first.song
    @song_search = @search_text.gsub!(/\s/,'+')
    render("saved_song_templates/list.html.erb")
  end

  def details
    @saved_song = SavedSong.where({ :id => params.fetch("id_to_display") }).first
    @song_title = @saved_song.song
    @song_artist = @saved_song.artist
    
    api_endpoint = "http://api.musixmatch.com/ws/1.1/track.search?apikey=0527068478f4f577126db8333a867ba8&q_track="+URI.encode(@song_title)+"&q_artist="+URI.encode(@song_artist)
    require("open-uri")
    raw = open(api_endpoint).read
    parsed = JSON.parse(raw)
    @result = parsed.fetch("message").fetch("body").fetch('track_list').at(0)
   
    @track_id = @result.fetch("track").fetch("track_id").to_s    
    api_lyrics_endpoint ="https://api.musixmatch.com/ws/1.1/track.lyrics.get?apikey=0527068478f4f577126db8333a867ba8&track_id=15953433"
    require("open-uri")
    rawlyrics = open(api_lyrics_endpoint).read
    parsedlyrics = JSON.parse(rawlyrics)
   @resultlyrics = parsedlyrics.fetch("message").fetch("body").fetch("lyrics").fetch("lyrics_body").at(0)

    @word_search = @saved_artist+" "+@song_title
   
    render("saved_song_templates/details.html.erb")
  end

  def blank_form
    @saved_song = SavedSong.new

    render("saved_song_templates/blank_form.html.erb")
  end

  def save_new_song
    @saved_song = SavedSong.new
    
    @saved_song.song = params.fetch("song_name")
    @saved_song.artist = params.fetch("song_artist")

    if @saved_song.valid?
      @saved_song.save

      redirect_to("/saved_songs", { :notice => "Saved song created successfully." })
    else
      render("saved_song_templates/blank_form.html.erb")
    end
  end

  def prefilled_form
    @saved_song = SavedSong.where({ :id => params.fetch("id_to_prefill") }).first

    render("saved_song_templates/prefilled_form.html.erb")
  end

  def save_edits
    @saved_song = SavedSong.where({ :id => params.fetch("id_to_modify") }).first

    @saved_song.search_id = params.fetch("search_id")
    @saved_song.name = params.fetch("name")
    @saved_song.artist = params.fetch("artist")

    if @saved_song.valid?
      @saved_song.save

      redirect_to("/saved_songs/" + @saved_song.id.to_s, { :notice => "Saved song updated successfully." })
    else
      render("saved_song_templates/prefilled_form.html.erb")
    end
  end

  def remove_row
    @saved_song = SavedSong.where({ :id => params.fetch("id_to_remove") }).first

    @saved_song.destroy

    redirect_to("/saved_songs", { :notice => "Saved song deleted successfully." })
  end
end
