class InventoriesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  before_action :set_inventory, only: [:destroy, :show, :update]

  def index
    @inventories = Inventory.where.not(status: :inactive)

    render json: {
        inventories: @inventories.as_json(except: excluded_params)
    }, status: @inventories.count > 0 ? :found : :ok
  end

  def create
    @inventory = Inventory.new(inventory_params)

    if @inventory.save
      render json: {
          inventory: @inventory.as_json(except: excluded_params)
      }, status: :created
    else
      render json: {
          message: "Item could not be created successfully",
          errors: @inventory.errors.full_messages.to_sentence
      }, status: :unprocessable_entity
    end
  end

  def show
    render json: {
        inventory: @inventory.as_json(except: excluded_params)
    }, status: :found
  end

  def update
    if @inventory.update(inventory_params)
      render json: {
          inventory: @inventory.as_json(except: excluded_params)
      }, status: :accepted
    else
      render json: {
          errors: @inventory.errors.full_messages.to_sentence
      }, status: :unprocessable_entity
    end
  end

  def destroy
    if @inventory.update(status: :inactive, quantity: 0)
      render json: {
          message: "Item successfully deleted"
      }, status: :ok
    end
  end

  private

  def set_inventory
    @inventory = Inventory.find_by(id: params[:id], status: :active)
    render_404 if @inventory.nil?
  end

  def inventory_params
    params.require(:inventory).permit(:name, :description, :price, :quantity)
  end

  def excluded_params
    [:created_at, :updated_at, :status]
  end

  def render_404
    render json: {
        message: "Item could not be found"
    }, status: :not_found
  end

end
