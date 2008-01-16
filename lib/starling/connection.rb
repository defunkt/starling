module StarlingServer
  class Protocol < EventMachine::Connection
    def initialize(options = {})
      @opts = options
    end

    def stats
      @opts[:server].stats
    end

    def logger
      @opts[:server].logger
    end

    def post_init
      stats[:total_connections] += 1
      set_comm_inactivity_timeout @opts[:timeout]
      @queue_collection = QueueCollection.new(@opts[:path])
      @handler = Handler.new(self, @queue_collection)
    end

    def receive_data(data)
      @handler << data
      @retry = true
      logger.info "== Received: #{data.inspect}"

      loop do
        @last_activity = Time.now

        if response = @handler.run
          logger.info "== Response: #{response.inspect}"
          @last_activity = Time.now
          send_data response
          break
        elsif @retry
          @retry = false
          logger.info "== No Response"
        else
          logger.info "== No more retries"
          break
        end
      end
    end

    def unbind 
      @queue_collection.close
    end
  end
end
