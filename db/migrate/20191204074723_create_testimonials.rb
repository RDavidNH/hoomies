class CreateTestimonials < ActiveRecord::Migration[5.2]
  def change
    create_table :testimonials do |t|
      t.string :content
      t.integer :note
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
