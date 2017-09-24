class InlineFormsCreateFshpCategories < ActiveRecord::Migration

  def self.up
    create_table :fshp_categories, :id => true do |t|
      t.string :name
      t.text :comment
      t.timestamps
    end
    FshpCategory.reset_column_information
    FshpCategory.create({name: "AM: Aritmétika I Matemátika"},  :without_protection => true)
    FshpCategory.create({name: "ZW: Kuido i Bienestar"},  :without_protection => true)
    FshpCategory.create({name: "IK: Idioma i Komunikashon"},  :without_protection => true)
    FshpCategory.create({name: "HN: Hende i Naturalesa"},  :without_protection => true)
    FshpCategory.create({name: "ST: Siensia i Teknología"},  :without_protection => true)
    FshpCategory.create({name: "SS: Siensia Sosial"},  :without_protection => true)
    FshpCategory.create({name: "FFS:Formashon Físiko i Salu"},  :without_protection => true)
    FshpCategory.create({name: "FSE:Formashon Sosial i Emoshonal"},  :without_protection => true)
    FshpCategory.create({name: "FB: Filosofia di Bida"},  :without_protection => true)
    FshpCategory.create({name: "FAK:Formashon Artístiko kultural"},  :without_protection => true)
    FshpCategory.create({name: "FK: Físika i Kímika"},  :without_protection => true)
  end

  def self.down
    drop_table :fshp_categories
  end

end
