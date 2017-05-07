class MovieController < ApplicationController
  @@api_url="http://www.omdbapi.com/?t="
    
  def index
    @movies = List.all
    require('json')
    require('open-uri')
    
  end
  
  
  def new_movie
    require('json')
    require('open-uri')

    title=params['title']
    page = open(@@api_url + title)
    info = page.read
    movie = JSON.parse(info)
    
    if movie['Response']=="True"
      new = List.new
      new.title=movie['Title']
      new.poster = movie['Poster']
      new.director=movie['Director']
      new.genre=movie['Genre']
      new.save
    else
      puts "There are no information."
    end
    redirect_to '/'
  end
  
  def edit
    @edit_movie = List.find(params[:id])
  end
  
  def update 
    update_movie = List.find(params[:id])
    update_movie.title = params[:title]
    update_movie.director = params[:director]
    update_movie.genre = params[:genre]
    update_movie.save
    
    redirect_to '/'
  end
  
  def delete 
    delete_movie=List.find(params[:id])
    delete_movie.destroy
    
    redirect_to '/'
  end
end