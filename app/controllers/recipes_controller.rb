class RecipesController < ApplicationController
	def index
		@recipes = Recipe.search(params[:search])
		#@recipes = Recipe.all.order("created_at DESC")
	end

	def show
		@recipe = Recipe.find(params[:id])
	end

	def new
		@recipe = Recipe.new
	end

	def create
		@recipe = Recipe.new(recipe_params)
     if @recipe.save
     	redirect_to @recipe, notice: "Successfully created new recipe"
     else
     	render 'new'	
     end
	end
  def edit
  	  @recipe = Recipe.find(params[:id])
  end

  def update
  	 if @recipe.update(recipe_params)
  	  redirect_to @recipe
  	 else
  		render 'edit'
  	 end
  end

	def destroy
		@recipe = Recipe.find(params[:id])
		@recipe.destroy
		redirect_to recipes_path, notice: "Successfully deleted recipe"
	end

	private

  def recipe_params
  	params.require(:recipe).permit(:title, :description, :image, ingredients_attributes: [:id, :name, :_destroy], directions_attributes: [:id, :step, :_destroy])
  	
  end

	def find_recipe
		@recipe = Recipe.find(params[:id])
	end

end
