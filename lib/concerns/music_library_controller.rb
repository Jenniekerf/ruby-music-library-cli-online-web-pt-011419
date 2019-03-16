require 'pry'
class MusicLibraryController 
  
  attr_reader :path 
  
    def initialize(path = "./db/mp3s")
    MusicImporter.new(path).import
  end
  
  def call
    
    user_input = ""
    
    while user_input != "exit" 
    
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"
    
    user_input = gets.chomp
    
    case user_input
      when "list songs"
        list_songs
      when "list artists"
        list_artists
      when "list genres"
        list_genres
      when "list artist"
        list_songs_by_artist
      when "list genre"
        list_songs_by_genre
      when "play song"
        play_song
      end
  end
  end
  
  def list_songs
    #lists songs alphabetically by name
    #prints songs in a numbered list
    Song.all.sort_by { |n| n.name }.each.with_index(1) { |song, index| puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}" }
  end
  
  def list_artists
   Artist.all.sort_by { |n| n.name }.each.with_index(1) { |artist, index| puts "#{index}. #{artist.name}" } 
  end
  
  def list_genres
    Genre.all.sort_by { |n| n.name }.each.with_index(1) { |genre, index| puts "#{index}. #{genre.name}" } 
  end
  
  def list_songs_by_artist
    
    puts "Please enter the name of an artist:"
    input = gets.chomp
    
    if artist = Artist.find_by_name(input)
      artist.songs.sort_by{ |a| a.name }.each.with_index(1) do |song, index|
        puts "#{index}. #{song.name} - #{song.genre.name}"
      end
    end
  end
  
  def list_songs_by_genre
    
    puts "Please enter the name of a genre:"
    input = gets.chomp
    
    if genre = Genre.find_by_name(input)
      genre.songs.sort_by{ |a| a.name }.each.with_index(1) do |song, index|
        puts "#{index}. #{song.artist.name} - #{song.name}"
      end
    end
  end
  
  def play_song
    
    puts "Which song number would you like to play?"
    input = gets.chomp.to_i
    if (1..Song.all.length).include?(input)
      song = Song.all.sort_by{ |a| a.name }[input - 1]
    end

    puts "Playing #{song.name} by #{song.artist.name}" if song
  end
  
end