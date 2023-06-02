class FocusedFormatter < SemanticLogger::Formatters::Json
  def initialize
    super(log_host: false, log_application: false, log_environment: false)
  end

  def pid
    # not interested in the pid
  end

  def level
    hash[:level] = log.level.upcase
    # skip level index
  end

  def thread_name
    # not interested in the thread
  end

  def duration
    return unless log.duration

    hash[:duration_ms] = log.duration
  end
end
