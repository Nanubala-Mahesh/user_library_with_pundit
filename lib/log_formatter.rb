class LogFormatter < ActiveSupport::Logger::SimpleFormatter
  def call(severity, timestamp, _progname, message)
    { 
      type: severity,
      test: _progname,
      message: message
    }
  end
end