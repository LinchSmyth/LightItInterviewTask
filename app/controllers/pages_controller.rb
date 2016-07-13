class PagesController < ApplicationController
  def home
  end

  def help
  end

  def about
  end

  # метод для зашифровки и разшифровки текста
  def result
    # Экшн для зашифовки
    if params[:Encrypt]
      @encrypted_text = encryption_and_decryption params[:clear_text], params[:shift].to_i
      @decrypted_text = params[:clear_text]
      @shift = params[:shift]
    # Экшн для расшифровки
    elsif params[:Decrypt]
      # Для разшифровки мы меняем значение перестановки, основываясь на том,
      # что разшифровка с шагом в 2 эквивалентна шифровке с шагом 24 (26 - 2)
      shift = 26 - params[:shift].to_i
      @encrypted_text = params[:cyphred_text]
      @decrypted_text = encryption_and_decryption params[:cyphred_text], shift
      @shift = params[:shift]
    end 
  end

  def encryption_and_decryption text, shift
      # Превращаем строку в массив чисел
    otput_text = []
    input_text = text.chars.map(&:ord)
    input_text.map do |symbol|
      if 65 <= symbol && symbol <= 90 
        # Если символ принадлежит алфавиту в верхнем регистре
        # выполняем перестановку
        otput_text.push(shifting symbol, shift, 90)
      elsif 97 <= symbol && symbol <= 122
        # Те же самые действия для нижнего регистра
        otput_text.push(shifting symbol, shift, 122)
      else
        # если символ не лежит в данном диапазоне - то просто прибавляем его 
        otput_text << symbol 
      end 
    end
    otput_text.map{ |symbol| symbol.chr }.join
  end

  # Метод перестановки
  def shifting symbol, shift, n
    symbol += shift
    # Если символ выходит за пределы "алфавита" то возвращаем его в алфавит
    # теперь при смещении в 1, Z становится А и т.д.
    symbol -= 26 if symbol > n
    return symbol
  end
end
