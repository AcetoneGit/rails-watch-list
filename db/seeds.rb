# # This file should ensure the existence of records required to run the application in every environment (production,
# # development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# #
# # Example:
# #
# #   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
# #     MovieGenre.find_or_create_by!(name: genre_name)
# #   end

# puts "Cleaning db"
# Movie.destroy_all
# List.destroy_all

# Movie.create(title: "Wonder Woman 1984", overview: "Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s", poster_url: "https://image.tmdb.org/t/p/original/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg", rating: 6.9)
# Movie.create(title: "The Shawshank Redemption", overview: "Framed in the 1940s for double murder, upstanding banker Andy Dufresne begins a new life at the Shawshank prison", poster_url: "https://image.tmdb.org/t/p/original/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg", rating: 8.7)
# Movie.create(title: "Titanic", overview: "101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic.", poster_url: "https://image.tmdb.org/t/p/original/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg", rating: 7.9)
# Movie.create(title: "Ocean's Eight", overview: "Debbie Ocean, a criminal mastermind, gathers a crew of female thieves to pull off the heist of the century.", poster_url: "https://image.tmdb.org/t/p/original/MvYpKlpFukTivnlBhizGbkAe3v.jpg", rating: 7.0)


List.create(name: "Horreur")

List.create(name: "Comédie")


List.create(name: "Thriller")


List.create(name: "Les films prefs de Benjos")

List.create(name: "Comedie Romantique")

List.create(name: "Comedie Musicale")

List.create(name: "Action")

List.create(name: "Que les films de Wes Anderson")

List.create(name: "Science-fiction")

List.create(name: "Comedie Debile")

List.create(name: "Ninjas")

List.create(name: "Documentaires")

puts "All good!"

# db/seeds.rb
require 'httparty'
require 'json'

puts "🗑️ Cleaning database..."
Movie.destroy_all
puts "Database cleaned!"

puts "🎬 Fetching movies from API..."

# URL de l'API - remplacez par l'URL réelle de votre API
api_url = "https://tmdb.lewagon.com/movie/top_rated"

# Récupération des données
response = HTTParty.get(api_url)

# Vérification que la requête a fonctionné
if response.code == 200
  # Convertir la réponse en JSON
  movies_data = JSON.parse(response.body)

  # Limiter à 100 films
  movies_to_create = movies_data.is_a?(Array) ? movies_data.first(100) : movies_data['results'].first(100)

  puts "Creating #{movies_to_create.length} movies..."

  movies_to_create.each do |movie_data|
    movie = Movie.create!(
      title: movie_data['original_title'],
      overview: movie_data['overview'],
      poster_url: movie_data['poster_path'],
      rating: movie_data['vote_average'].to_f
    )

    puts "✅ Created #{movie.title}"
  end

  puts "🎉 Finished! Created #{Movie.count} movies."
else
  puts "❌ Error fetching data from API: #{response.code} - #{response.message}"
end

api_url = "https://tmdb.lewagon.com/movie/popular"

# Récupération des données
response = HTTParty.get(api_url)

# Vérification que la requête a fonctionné
if response.code == 200
  # Convertir la réponse en JSON
  movies_data = JSON.parse(response.body)

  # Limiter à 100 films
  movies_to_create = movies_data.is_a?(Array) ? movies_data.first(100) : movies_data['results'].first(100)

  puts "Creating #{movies_to_create.length} movies..."

  movies_to_create.each do |movie_data|
    movie = Movie.create!(
      title: movie_data['original_title'],
      overview: movie_data['overview'],
      poster_url: movie_data['poster_path'],
      rating: movie_data['vote_average'].to_f
    )

    puts "✅ Created #{movie.title}"
  end

  puts "🎉 Finished! Created #{Movie.count} movies."
else
  puts "❌ Error fetching data from API: #{response.code} - #{response.message}"
end
