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

  def link_to_glossary(glossary, full_url=false)
    if full_url
      if Rails.env.development?
        link_to glossary.name, "http://localhost:3000/glossaries/#{glossary.id}" unless glossary.nil?
      else
        link_to glossary.name, "https://www.papiamentu.info/glossaries/#{glossary.name}" unless glossary.nil?
      end
    else
      link_to glossary.name, "/glossaries/#{glossary.id}" unless glossary.nil?
    end
  end

end
