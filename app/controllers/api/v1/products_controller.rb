module Api
  module V1
    class ProductsController < ApplicationController
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
        @product = Product.new(product_params)
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


    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
      end

      def edit
        @product = Product.find(params[:id])
      end

      def update
        @product = Product.update(params[:id], product_params)
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
         respond_to do |format|
               if @product.update(article_params)
                 format.html { redirect_to @product, notice: 'Product was successfully updated.' }
                 format.json { render :show, status: :created, location: @product }
               else
                 format.html { render :edit }
                 format.json { render json: @product.errors, status: :unprocessable_entity }
               end
             end
      end
      # def destroy
      #   product = Product.find(params[:id])
      #   product.destroy
      #
      #   render json: {
      #     status: 204
      #   }
      # end

      private
        def product_params
          params.require(:product).permit(:name, :price)
        end
    end
  end
end
