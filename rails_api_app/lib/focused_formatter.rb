class FocusedFormatter < SemanticLogger::Formatters::Json
  def initialize
    super(log_host: false, log_application: false, log_environment: false)
  end

  def pid
    # not interested in the pid
  end

  def level
    hash[:level] = log.level
    # skip level index
  end
end
