Rails.application.routes.draw do
  # Routes for the Saved song resource:

  # CREATE
  match("/new_saved_song_form", { :controller => "saved_songs", :action => "blank_form", :via => "get" })
  match("/insert_saved_song_record", { :controller => "saved_songs", :action => "save_new_song", :via => "post" })

  # READ
  match("/", { :controller => "saved_songs", :action => "list", :via => "get" })
  match("/saved_songs", { :controller => "saved_songs", :action => "list", :via => "get" })
  match("/saved_songs/:id_to_display", { :controller => "saved_songs", :action => "details", :via => "get" })

  # UPDATE
  match("/existing_saved_song_form/:id_to_prefill", { :controller => "saved_songs", :action => "prefilled_form", :via => "get" })
  match("/update_saved_song_record/:id_to_modify", { :controller => "saved_songs", :action => "save_edits", :via => "post" })

  # DELETE
  match("/delete_saved_song/:id_to_remove", { :controller => "saved_songs", :action => "remove_row", :via => "get" })

  #------------------------------

  # Routes for the Search resource:

  # CREATE
  match("/new_search_form", { :controller => "searches", :action => "blank_form", :via => "get" })
  match("/insert_search_record", { :controller => "searches", :action => "save_new_info", :via => "post" })

  match("/add_new_song", { :controller => "searches", :action => "add_new_song", :via => "post" })


  # READ
  match("/searches", { :controller => "searches", :action => "list", :via => "get" })
  match("/searches/:id_to_display", { :controller => "searches", :action => "details", :via => "get" })

  # UPDATE
  match("/existing_search_form/:id_to_prefill", { :controller => "searches", :action => "prefilled_form", :via => "get" })
  match("/update_search_record/:id_to_modify", { :controller => "searches", :action => "save_edits", :via => "post" })

  # DELETE
  match("/delete_search/:id_to_remove", { :controller => "searches", :action => "remove_row", :via => "get" })

  #------------------------------

  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
