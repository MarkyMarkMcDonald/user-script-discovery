class Exclusion < ActiveRecord::Base
  belongs_to :script, dependent: :destroy
end
