module StarlingServer
  class Protocol < EventMachine::Connection
    def initialize(options = {})
      @opts = options
    end

    def stats(*args)
      @opts[:server].stats(*args)
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

      loop do
        if response = @handler.run
          send_data response
          break
        end
      end
    end

    def unbind 
      @queue_collection.close
    end
  end
end
