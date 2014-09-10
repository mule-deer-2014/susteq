class TransactionsController < ApplicationController
  before_filter :require_admin_signin
end
