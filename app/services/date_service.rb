class DateService
  attr_reader :check_in, :check_out

  def initialize(check_in, check_out)
    @check_in = check_in
    @check_out = check_out
  end

end