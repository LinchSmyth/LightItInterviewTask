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
      @encrypted_text   = encryption_and_decryption params[:clear_text], params[:shift].to_i
      @decrypted_text   = params[:clear_text]
      @shift            = params[:shift]
      @letter_frequency = frequency_counter @decrypted_text, @shift 
    # Экшн для расшифровки
    elsif params[:Decrypt]
      # Для разшифровки мы меняем значение перестановки, основываясь на том,
      # что разшифровка с шагом в 2 эквивалентна шифровке с шагом 24 (26 - 2)
      shift             = 26 - params[:shift].to_i
      @encrypted_text   = params[:cyphred_text]
      @decrypted_text   = encryption_and_decryption params[:cyphred_text], shift
      @shift            = params[:shift]
      @letter_frequency = frequency_counter @decrypted_text, shift
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

  # Метод для анализа частоты каждой буквы
  def frequency_counter clear_text, shift
    decyphred_letter_frequency = {}       # => хэш для подсчета частоты букв в расшифрованом тексте 
    letter_frequency = {}                 # => хэш для вывода частоты букв в обоих текстах

    # блок подсчета букв, которые мы предварительно переводим в нижний регистр
    clear_text.downcase.each_char do |char|
      # по аналогии с шифровкой/разшифровкой сначала переводим символы в числовой формат, а затем
      # проверяем, принадлежит ли символ буквам маленького регистра, если нет - переходим к следующему символу
      ascii_char = char.ord
      next if ascii_char < 97 && ascii_char > 122
      decyphred_letter_frequency[char] = 0 unless decyphred_letter_frequency.include?(char)
      decyphred_letter_frequency[char] += 1
    end

     # cортируем хэш по значениям от большего к меньшему
    decyphred_letter_frequency = decyphred_letter_frequency.sort_by{ |key, value| value }.reverse.to_h
    
    # формируем финальный хеш, формата {"РАЗШИФРОВАННЫЙ_СИМВОЛ -> ЗАШИФРОВАННЫЙ_СИМВОЛ " => КОЛ-ВО}
    decyphred_letter_frequency.each_pair do |key, value|
        # выполняем опять перевод символа в числовой формат, что бы каждый символ зашифровать
      ascii = key.chars.map(&:ord)
      letter = ascii[0]
        # отправляем каждый символ на зашифровку
      cyphred_letter = shifting letter, shift.to_i, 122
        # перекодируем число в символ
      cyphred_text_key = cyphred_letter.chr
        # формируем финальный хэш
      letter_frequency["#{key.upcase} -> #{cyphred_text_key.upcase}"] = value
    end

    return letter_frequency
  end
end
