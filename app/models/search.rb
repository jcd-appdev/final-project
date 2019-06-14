# == Schema Information
#
# Table name: searches
#
#  id         :integer          not null, primary key
#  text       :string
#  song_saved :boolean
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Search < ApplicationRecord
    belongs_to :user
    has_one :saved_song, :dependent => :destroy
end
