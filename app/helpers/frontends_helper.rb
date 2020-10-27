module FrontendsHelper
  def link_to_word(word, full_url=false)
    if full_url
      if Rails.env.development?
        link_to word.name, "http://localhost:3000/palabra/#{word.name}" unless word.nil?
      else
        link_to word.name, "https://www.papiamentu.info/palabra/#{word.name}" unless word.nil?
      end
    else
      link_to word.name, "/palabra/#{word.name}" unless word.nil?
    end
  end

  def link_to_glossary(glossary)
    link_to glossary.name, "/glosario/#{glossary.id}" unless glossary.nil?
  end

  def link_to_source(source)
    link_to source.name, "/fuente/#{source.id}" unless source.nil?
  end

  def link_to_memory_game_play(memory_game)
    link_to memory_game.title, "/memory_games/#{memory_game.id}/play_game" unless memory_game.nil?
  end

  def link_to_memory_game_edit(memory_game)
    link_to 'edit', "/memory_games/#{memory_game.id}/edit_game" unless memory_game.nil?
  end

end
