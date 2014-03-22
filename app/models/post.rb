class Post < ActiveRecord::Base
  attr_accessible :content, :name, :title

  validates :name,  :presence => true
  validates :title, :presence => true,
                    :length => { :minimum => 5 }
end
p = Post.new(:content => "A new post")
 p.save
 false
p.errors.full_messages
["Name can't be blank", "Title can't be blank", "Title is too short (minimum is 5 characters)"]