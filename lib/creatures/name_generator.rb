class NameGenerator

  MALES = %w(
    Alaric
    Alaron
    Alynd
    Asgoth
    Berryn
    Derrib
    Eryk
    Evo
    Fausto
    Gavin
    Gorth
    Jarak
    Jasek
    Kurn
    Lan
    Ledo
    Lor
    Mavel
    Milandro
    Sandar
    Sharn
    Tarran
    Thane
    Topaz
    Tor
    Torc
    Travys
    Trebor
    Tylien
    Vicart
    Zircon
  )

  FEMALES = %w(
    Agate
    Alyvia
    Arabeth
    Ardra
    Brenna
    Caryne
    Dasi
    Derris
    Dynie
    Eryke
    Errine
    Farale
    Gavina
    Glynna
    Karran
    Kierst
    Kira
    Kyale
    Ladia
    Mora
    Moriana
    Quiss
    Sadi
    Salina
    Samia
    Sephya
    Shaundra
    Siveth
    Thana
    Valiah
    Zelda
  )

  def self.generate( male = true )
    return MALES.sample if male
    return FEMALES.sample
  end

end