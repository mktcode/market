class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update delete destroy ]
  allow_unauthenticated_access only: %i[ show ]

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new user: Current.user, time_invested: 0
    @product.materials.build cost: 0
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Current.user.products.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Produkt wurde erfolgreich erstellt." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: "Produkt wurde erfolgreich aktualisiert." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete
    redirect_to product_path @product unless @product.user == Current.user
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    raise ActiveRecord::RecordNotFound unless @product.user == Current.user

    @product.destroy!

    respond_to do |format|
      format.html { redirect_to user_path Current.user, status: :see_other, notice: "Produkt wurde erfolgreich gelöscht." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.expect(product: [ :title, :description, :body, :time_invested, :published, images: [], materials_attributes: [ [ :name, :cost, :secondhand, :_destroy, :id ] ] ])
    end
end
