module Api
  module V1
    class ProductsController < ApplicationController
      protect_from_forgery with: :null_session
      before_action :set_product, only: [:update, :destroy]
      def index
        @products = Product.all
         respond_to do |format|
          format.html
          format.json { render json: @products }
        end
      end
      def show
        @product = Product.find(params[:id])
      end
      def new
        @product = Product.new
      end

      def create
        product = Product.new(product_params)
        # if product.save
        #
        #     render json: {
        #       status: 201,
        #       #product: product
        #     }.to_json
        # else
        #   render json: {
        #     status: 422,
        #     errors: product.errors
        #   }.to_json
        # end


    #respond_to do |format|
      if product.save
        #format.html { redirect_to @product, notice: 'Product was successfully created.' }
        #format.json { render :show, status: :created, location: @product }
        render json: product, status: :created
      else
        #format.html { render :new }
        #format.json { render json: @product.errors, status: :unprocessable_entity }
        render json: {errors: product.errors}, status: :unprocessable_entity
      end
    #end
      end
      def update
      				if @product.update(product_params)
      					render json: @product, status: :ok
      				else

      					render json: { errors: @product.errors }, status: :unprocessable_entity #422
      				end
      end
      def destroy
      				@product.destroy
      				head :no_content #204
    	end

      def edit
        @product = Product.find(params[:id])
      end

      #def update
      #  @product = Product.update(params[:id], product_params)
         # if product.update(product_params)
         #   render json: {
         #    status: 200
         #  }
         #
         #  else
         #
         #    render json: {
         #      status: 422,
         #      errors: product.errors
         #    }
         #  end
         # respond_to do |format|
         #       if @product.update(article_params)
         #         format.html { redirect_to @product, notice: 'Product was successfully updated.' }
         #         format.json { render :show, status: :ok, location: @product }
         #       else
         #         format.html { render :edit }
         #         format.json { render json: @product.errors, status: :unprocessable_entity }
         #       end
         #     end
      #end
      # def destroy
      #   product = Product.find(params[:id])
      #   product.destroy
      #
      #   render json: {
      #     status: 204
      #   }
      # end

      private
        def set_product
          @product = Product.find(params[:id])
        end
        def product_params
          params.require(:product).permit(:name, :price)
        end
    end
  end
end
