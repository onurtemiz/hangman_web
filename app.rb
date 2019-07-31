require 'sinatra'
require './hangman'

game = Game.new
info = nil

get '/' do
  erb :index, locals: {game: game, info: info}
end

post '/' do
  if params[:new]
    game = Game.new
    info = 'Yeni Kelime Oluşturuldu'
  else
    info = nil
    if game.check_letter(params[:letter])
      game.alphabet.change_leter_color(params[:letter])
      game.life -= 1 if game.check_answer(params[:letter]) == false
      if game.game_won?
        info = "Oyunu Kazandınız!. Kelimeniz: #{game.keyword.keyword}"
        game = Game.new
      elsif game.game_lost?
        info = "Oyunu Kaybettiniz!. Kelimeniz: #{game.keyword.keyword}"
        game = Game.new
      end
    else
      info = 'Lütfen daha önce kullanmadığınız bir harf girin.'
    end
  end
  redirect '/'
end