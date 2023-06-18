# https://www.toptal.com/ruby-on-rails/rails-service-objects-tutorial
# https://www.toptal.com/ruby-on-rails/decoupling-rails-components
# https://web.archive.org/web/20180411005305/https://pawelurbanek.com/2018/02/12/ruby-on-rails-service-objects-and-testing-in-isolation/
# https://github.com/pawurb/smart_init
class ApplicationService
  def self.call(*args, &block)
    begin
      new(*args, &block).call
    rescue => e
      # improve output reading the service name and maybe add args?
      Rails.logger.error('Service Failed', e)
      :failed
    end
  end
end