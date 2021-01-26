class Author < ApplicationRecord
    has_many :books

    def self.search(args)
		query = Author.all
		query = query.joins(:books)
		query = query.where("books.title LIKE ?", "%#{args[:title]}%")
	end
end
