class CustomersController < ApplicationController
  before_action :initialize_session
  before_action :increment_visit_count, except: [:show]
  before_action :load_customers_to_call, except: [:add_to_call_list, :mark_as_called, :clear_call_list]

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

    if session[:to_call_list].include?(id)
      @error_alert = "This customer is already in your to call list."
    else
      session[:to_call_list] << id
      @success_alert = "You successfully added the customer to your call list."
    end

    load_customers_to_call
  end
  # Automatically load the view: add_to_call_list.js.erb

  def mark_as_called
    id = params[:id].to_i
    session[:to_call_list].delete(id)

    @success_alert = "Good work. You called a customer!"
    load_customers_to_call
    render :add_to_call_list # Run the add_to_call_list.js.erb
  end

  def clear_call_list
    session[:to_call_list] = []

    load_customers_to_call
    render :add_to_call_list # Run the add_to_call_list.js.erb
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
