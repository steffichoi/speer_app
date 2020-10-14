class Tweet < ApplicationRecord
    validates_presence_of :tweet, :created_by
end
