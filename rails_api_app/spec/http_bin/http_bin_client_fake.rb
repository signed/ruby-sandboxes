# frozen_string_literal: true
module HttpBin
  class ClientFake

    def initialize
      @success = false
    end

    def call_succeeds
      @success = true
    end

    def call_fails
      @success = false
    end

    def post_to_anything(body = {})
      return :failed unless @success

      { 'json' => body }
    end

  end

end
