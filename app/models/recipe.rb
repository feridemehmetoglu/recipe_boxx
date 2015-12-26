class Recipe < ActiveRecord::Base

	      has_many :ingredients
	      has_many :directions

	       accepts_nested_attributes_for :ingredients,
	                                      reject_if: proc { |attributes| attributes['name'].blank? },
	                                      allow_destroy: true

	       accepts_nested_attributes_for :directions,
	                                      reject_if: proc { |attributes| attributes['step'].blank? },
	                                      allow_destroy: true
           

         validates :title, :description, :image, presence: true

				has_attached_file :image, styles: { :medium => "400x400#" }	
				validates_attachment_content_type :image , content_type: /\Aimage\/.*\Z/

	def self.search(search)
	if search
	  	@recipes = Recipe.where(["title LIKE ?","%#{search}%" ])
			#@books = Book.where(["name LIKE ?","%#{params[ :search]}%" ])
		else
			all
     end
   end
end
