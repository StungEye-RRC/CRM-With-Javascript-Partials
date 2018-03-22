class CustomersController < ApplicationController
  before_action :initialize_session
  before_action :increment_visit_count, except: [:show]
  before_action :load_customers_to_call

  def index
    @customers = Customer.all

  end

  def show
    @customer = Customer.find(params[:id])
  end

  def missing_email
    @customers = Customer.where(email: '')
  end

  def add_to_call_list
    id = params[:id].to_i

    unless session[:to_call_list].include?(id)
      session[:to_call_list] << id
      redirect_to customers_path
    end
  end

  def mark_as_called
    id = params[:id].to_i
    session[:to_call_list].delete(id)
    redirect_to customers_path
  end

  def clear_call_list
    session[:to_call_list] = nil
    redirect_to customers_path
  end

  private
  def initialize_session
    session[:to_call_list] ||= []
    session[:visit_count]  ||= 0
  end

  def increment_visit_count
    session[:visit_count] += 1
  end

  def load_customers_to_call
    @customers_to_call = Customer.find(session[:to_call_list])
  end
end
