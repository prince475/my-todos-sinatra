class Todo < ActiveRecord::Base

  # restricting our integer values to be only between the specified ENUM values.
  # our enums start from 0 to 3, 0 represents CREATED and so on...
  enum :status, [ :CREATED, :ONGOING, :COMPLETED, :CANCELLED ]

end
