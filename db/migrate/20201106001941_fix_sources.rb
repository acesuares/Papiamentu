class FixSources < ActiveRecord::Migration[6.0]
  def up
    s101 = Goal.find_by_name('101 SIFMA')
    s102 = Goal.find_by_name('102 SIFMA')
    s103 = Goal.find_by_name('103 SIFMA')
    s104 = Goal.find_by_name('104 SIFMA')
    f101 = Source.find_by_name('101 Traha komo asistente di kuido den un organisashon')
    f102 = Source.find_by_name('102 Hasi trabou doméstiko ')
    f103 = Source.find_by_name('103 Yuda ku aktividat di tur dia ')
    f104 = Source.find_by_name(' 104 Kon anda ku reseptor di kuido ')

    f101.words.each do |word|
      word.goals << s101
      word.save
    end
    f102.words.each do |word|
      word.goals << s102
      word.save
    end
    f103.words.each do |word|
      word.goals << s103
      word.save
    end
    f104.words.each do |word|
      word.goals << s104
      word.save
    end

    a1   = Goal.find_by_name('A1 Dijkhoff')
    a2   = Goal.find_by_name('A2 Dijkhoff')
    d1   = Source.find_by_name('Dijkhoff Les 1')
    d2   = Source.find_by_name('Dijkhoff Les 2')

    d1.words.each do |word|
      word.goals << a1
      word.save
    end

    d2.words.each do |word|
      word.goals << a2
      word.save
    end

  end
end
