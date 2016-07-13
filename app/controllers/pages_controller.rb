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
      @encrypted_text = encrypt params[:clear_text], params[:shift].to_i
      raise "#{@encrypted_text}"
    # Экшн для расшифровки
    elsif params[:Decrypt]
      render "pages/help"
    end 
  end

  def encrypt text, shift
      # Превращаем строку в массив чисел
    cyphred_text = []
    clear_text = text.chars.map(&:ord)
    clear_text.map do |symbol|
      if 65 <= symbol && symbol <= 90 
        # Если символ принадлежит алфавиту в верхнем регистре
        # выполняем перестановку
        cyphred_text.push(shifting symbol, shift, 90)
      elsif 97 <= symbol && symbol <= 122
        # Те же самые действия для нижнего регистра
        cyphred_text.push(shifting symbol, shift, 122)
      else
        # если символ не лежит в данном диапазоне - то просто прибавляем его 
        cyphred_text << symbol 
      end 
    end
    cyphred_text.map{ |symbol| symbol.chr }.join
  end

  def decrypt text, shift

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
