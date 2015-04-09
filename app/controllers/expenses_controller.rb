class ExpensesController < ApplicationController

  before_filter :authenticate_user!

  def show
    @expense = Expense.find(params[:id])
    authorize! :manage, @expense
  end

  def index
    @expenses = Expense.filter(params[:search], params[:type], params[:tag], params[:category], params[:start_time], params[:end_time], current_user.id)
  end

  def new
    @expense = Expense.new(user_id: current_user.id)
    authorize! :manage, @expense
  end

  def create
    @expense = Expense.new(expense_params)
    authorize! :manage, @expense
    if @expense.save
      flash[:success] = "Expense created"
      redirect_to @expense
    else
      render "new"
    end
  end

  def edit
    @expense = Expense.find(params[:id])
    authorize! :manage, @expense
  end

  def update
    @expense = Expense.find(params[:id])
    authorize! :manage, @expense
    if @expense.update_attributes(expense_params)
      flash[:success] = "Expense updated"
      redirect_to @expense
    else
      render 'edit'
    end
  end


  def destroy
    @expense = Expense.find(params[:id])
    authorize! :manage, @expense
    @expense.destroy
    flash[:success] = "Expense deleted"
    redirect_to expenses_url
  end


  private

  def expense_params
    params.require(:expense).permit(:title, :description, :amount, :user_id, :expense_type, :time ,:category_id, :tag_ids => [])
  end

end
