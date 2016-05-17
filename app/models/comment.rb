class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :topic
end
