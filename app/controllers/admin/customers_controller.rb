class Admin::CustomersController < ApplicationController

  before_action :authenticate_admin!

  def index
    @customers = Customer.all.order('created_at DESC')
  end

  def show
    @customer = Customer.find(params[:id])
    @reviews = Review.where(customer_id: @customer.id).order('updated_at DESC').limit(1)
    @posts = Post.where(customer_id: @customer.id).order('created_at DESC').limit(1)
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer)
    else
      render :edit
    end
  end

  def review
    @customer = Customer.find(params[:id])
    @reviews = Review.where(customer_id: @customer.id).order('updated_at DESC')
  end

  def post
    @customer = Customer.find(params[:id])
    @posts = Post.where(customer_id: @customer.id).order('created_at DESC')
  end

  private

  def customer_params
    params.require(:customer).permit(:is_deleted)
  end

end
