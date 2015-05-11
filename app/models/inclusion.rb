class Inclusion < ActiveRecord::Base
  belongs_to :script, dependent: :destroy
end
