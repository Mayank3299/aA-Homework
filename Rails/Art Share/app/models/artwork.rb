# == Schema Information
#
# Table name: artworks
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  image_url  :string           not null
#  artist_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Artwork < ApplicationRecord
   validates :title, :artist_id, :image_url, presence: true
   validates :image_url, uniqueness: true
   validates :title, uniqueness: {scope: :artist_id}

   belongs_to :artist,
    primary_key: :id,
    foreign_key: :artist_id,
    class_name: :User

    has_many :artwork_shares
    has_many :shared_viewers,
        through: :artwork_shares,
        source: :viewer

    def self.artwork_for_user_id(user_id)
        Artwork
            .left_outer_joins(:artwork_shares)
            .where('(artworks.artist_id = :user_id) OR (artwork_shares.viewer_id = :user_id)', user_id: user_id)
            .distinct
    end
end
