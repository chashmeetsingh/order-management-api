class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :destroy, :update]

  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def index
    @orders = Order.all

    if @orders.count <= 0
      render json: {
          orders: []
      }, status: :ok
    else
      render json: @orders.to_json(joined_params_exclude_config), status: :found
    end
  end

  def create
    @order = Order.init(params)

    if @order.save
      render json: @order.to_json(joined_params_exclude_config), status: :created
    else
      render json: {
          message: "Order could not be created successfully",
          errors: @order.errors.full_messages.to_sentence
      }, status: :unprocessable_entity
    end
  end

  def show
    render json: @order.to_json(joined_params_exclude_config), status: :found
  end

  def update
    @order.update_attr(params)

    if @order.save
      @order.reload
      render json: {
          item: @order.as_json(joined_params_exclude_config)
      }, status: :accepted
    else
      render json: {
          errors: @order.errors.full_messages.to_sentence
      }, status: :unprocessable_entity
    end
  end

  def destroy
    if @order.destroy
      render json: {
          message: "Order successfully deleted"
      }, status: :ok
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:orders).permit(:email)
  end

  def render_404
    render json: {
        message: "Order could not be found"
    }, status: :not_found
  end

  def excluded_params
    [:created_at, :updated_at]
  end

  def joined_params_exclude_config
    {
        include: [
            :order_items => {
                except: excluded_params
            }
        ],
        except: excluded_params
    }
  end

end
