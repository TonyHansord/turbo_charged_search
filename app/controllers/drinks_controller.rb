class DrinksController < ApplicationController
  before_action :set_drink, only: %i[ show edit update destroy ]

  # GET /drinks or /drinks.json
  def index

    @query = params[:query]

    if @query.present?
      @drinks = Drink.where("name LIKE ?", "%#{@query}%")
    else
      @drinks = Drink.none
    end

    if turbo_frame_request?
      render partial: "drinks", locals: { drinks: @drinks }
      render partial: "add", locals: { query: @query } 
    else
      render :index
    end
  end

  # GET /drinks/1 or /drinks/1.json
  def show

   
      render :show
    
  end

  # GET /drinks/new
  def new
    @drink = Drink.new
  end

  # GET /drinks/1/edit
  def edit
  end

  # POST /drinks or /drinks.json
  def create
    @drink = Drink.new(drink_params)

    respond_to do |format|
      if @drink.save
        format.html { redirect_to drink_url(@drink), notice: "Drink was successfully created." }
        format.json { render :show, status: :created, location: @drink }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @drink.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /drinks/1 or /drinks/1.json
  def update
    respond_to do |format|
      if @drink.update(drink_params)
        format.html { redirect_to drink_url(@drink), notice: "Drink was successfully updated." }
        format.json { render :show, status: :ok, location: @drink }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @drink.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /drinks/1 or /drinks/1.json
  def destroy
    @drink.destroy

    respond_to do |format|
      format.html { redirect_to drinks_url, notice: "Drink was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_drink
      @drink = Drink.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def drink_params
      params.require(:drink).permit(:name)
    end
end
