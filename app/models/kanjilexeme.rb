class Kanjilexeme < Lexeme
  # a single kanji may have more than one hiragana transliterations
     has_many   :hiraganas
end
