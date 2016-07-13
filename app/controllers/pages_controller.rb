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
        symbol += shift
        # Если символ получился больше Z (90) то возвращаем его в алфавит
        # теперь при смещении в 1, Z становится А и т.д.
        symbol -= 26 if symbol > 90
        cyphred_text << symbol
      elsif 97 <= symbol && symbol <= 122
        # Те же самые действия для нижнего регистра
        symbol += shift
        symbol -= 26 if symbol > 122 
        cyphred_text << symbol
      else
        # если символ не лежит в данном диапазоне - то просто прибавляем его 
        cyphred_text << symbol 
      end 
    end
    cyphred_text.map{ |symbol| symbol.chr }.join
  end

  def decrypt text, shift

  end
end
