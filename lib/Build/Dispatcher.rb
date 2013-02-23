require 'observer'

module WebBlocks
  
  module Build
    
    module Dispatcher
      
      @telemetry = {:execute_time => {}}
      
      def self.telemetry
        
        @telemetry
        
      end
      
      def observers 
        
        @observers = [] unless @observers
        @observers
        
      end
      
      def reset_observers
        
        @observers = []
        
      end
      
      def observer observer
        
        observers << observer
        
      end
      
      def execute event
        
        ["before_#{event}", event, "after_#{event}"].each do |event|
          log.system 'Dispatcher', "Executing task: #{event}" do
            happened = false
            t1 = Time.now.to_f
            observers.each do |object|
              next unless object.respond_to? event
              object.send(event) 
              happened = true
            end 
            t2 = Time.now.to_f
            ::WebBlocks::Build::Dispatcher.telemetry[:execute_time][event] = t2 - t1 if happened
          end
        end
        
      end
      
    end
    
  end
  
end