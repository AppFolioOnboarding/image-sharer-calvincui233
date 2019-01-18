class AddUntaggedTag < ActiveRecord::Migration[5.2]
  def self.up
    execute <<-SQL
      INSERT INTO taggings (taggable_id) SELECT DISTINCT images.id FROM images LEFT JOIN taggings 
      WHERE images.id != taggings.taggable_id
    SQL
    execute <<-SQL
      UPDATE taggings SET (tag_id, taggable_type) = ((SELECT id FROM tags WHERE name='untagged'), 'Image')
      WHERE tag_id isnull
    SQL
  end

  def self.down
    execute <<-SQL
      DELETE FROM taggings WHERE tag_id = (SELECT id FROM tags WHERE name='untagged')
    SQL
    excuete <<-SQL
      DELETE FROM tags WHERE name='untagged'
    SQL
  end
end
