# == Schema Information
#
# Table name: saved_songs
#
#  id         :integer          not null, primary key
#  search_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  song       :string
#  artist     :string
#

class SavedSong < ApplicationRecord
    belongs_to :search

end
