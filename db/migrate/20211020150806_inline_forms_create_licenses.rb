class InlineFormsCreateLicenses < ActiveRecord::Migration[5.0]

  def self.up
    create_table :licenses do |t|
      t.string :name
      t.string :title
      t.text :comment
      t.string :url
      t.timestamps
    end
    License.create(name: '---', title: 'No License Specified', comment: 'Needs a license', url: '/' )
    License.create(name: 'CC BY-NC-SA 4.0', title: 'CC BY-NC-SA 4.0', comment: 'Restricted for commercial use', url: 'https://creativecommons.org/licenses/by-nc-sa/4.0' )
    License.create(name: 'CC BY-SA 3.0', title: 'CC BY-SA 3.0', comment: 'Can be used on Wikidata', url: 'https://creativecommons.org/licenses/by-sa/3.0' )
  end

  def self.down
    drop_table :licenses
  end

end
