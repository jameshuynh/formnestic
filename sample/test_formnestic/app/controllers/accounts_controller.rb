class AccountsController < ApplicationController
  def new
    @account = Account.new
  end
end
