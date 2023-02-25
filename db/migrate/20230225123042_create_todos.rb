class CreateTodos < ActiveRecord::Migration[7.0]

  # 7.0 is sinatra avtive record version 7.0
  # rake db:create_migration NAME=create_todos is the migration command that initiates creation of our db.

  def change

    # creating the our table by use of helper method create_table and giving it a name.
    create_table :todos do |t|

      # title which does not accept null values.
      # createdAt is the timestamp and shows when the todo was created
      # our status will incorparate ENUM just represent interger values that can be querried using a string.
      # ENUMS are used for db values that are distinct options and can be nothing else. They are like multiple choice
      # ENUM values are Integer values. using a number to represent some text. eg 1 to rep create and maybe 2 to rep delete.
      # then when you see 1 you just know creation is goin on
      # run migration with rake db:migrate.
      # it runs migration and creates a schema.rb file which contains detalis of how our db was created and how the table looks like.
      
      t.string :title, null: false
      t.string :description, null: false
      t.datetime :due
      t.datetime :createdAt, null: false
      t.integer :status, null: false, default: 0


    end


  end
end
