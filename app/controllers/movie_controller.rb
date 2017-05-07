class MovieController < ApplicationController
  @@api_url="http://www.omdbapi.com/?t="
  
  def index
    @movie = Movie.all
    puts(@movie)
  end

  def edit
    @movie_id = params[:id]
    @movie = Movie.find(@movie_id)
  end

  def model_destroy
    @movie_id = params[:id]
    @movie = Movie.find(@movie_id)
    @movie.destroy
    redirect_to '/movie/index'
  end

  def model_create
    title = params[:title]
    require('json')
    require('open-uri')
    title = params[:title]
    request = @@api_url + title
    response = open(request)
    data = response.read
    res_data = JSON.parse(data)
    
    puts(res_data)
    if res_data['Response'] == 'True'
      new_movie = Movie.new
      new_movie.title = res_data['Title']
      new_movie.poster = res_data['Poster']
      new_movie.description = res_data['Director']
      new_movie.genere = res_data['Genre']
      new_movie.save
    else
      puts('No movie')
    end
    redirect_to '/movie/index'
    end

  def model_update
    id = params[:id]
    title = params[:title]
    director = params[:director]
    genre = params[:genre]
    
    movie = Movie.find(id)
    movie.title = title
    movie.description = director
    movie.genere = genre
    movie.save
    redirect_to  '/movie/index'
  end
end
