module DatabaseSpecHelpers
  def test_for_db_error(error_message, &block)
    begin
      yield
    rescue ActiveRecord::StatementInvalid
      database_threw_error = true
    rescue
      something_else_threw_error = true
    end

    expect(!something_else_threw_error).to be(true), "There is an error in our test code"
    expect(database_threw_error && !something_else_threw_error).to be(true), error_message
  end
end