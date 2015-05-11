class Script < ActiveRecord::Base
  has_many :inclusions
  has_many :exclusions
end
