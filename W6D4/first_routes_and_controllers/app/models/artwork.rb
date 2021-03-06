class Artwork < ApplicationRecord
    validates :title, presence: true
    validates :image_url, presence: true, uniqueness: true
    validates :title, uniqueness: { scope: :artist_id}

    belongs_to(
      :artist, 
      primary_key: :id,
      foreign_key: :artist_id,
      class_name: 'User'
    )

    has_many :artwork_shares,
        primary_key: :id,
        foreign_key: :artwork_id,
        class_name: 'ArtworkShare'

    has_many :shared_viewers,
        through: :artwork_shares,
        source: :viewer

    has_many :comments,
        primary_key: :id,
        foreign_key: :artwork_id,
        class_name: 'Comment',
        dependent: :destroy

    # def self.user_id_artworks(user_id)
    #   Artwork
    #     .joins(:artwork_shares)
    #     .where('artworks.artist_id = :user_id') 
    # end

    # def self.shared_artworks(user_id)
    #   Artwork
    #     .joins()
    # end
end
