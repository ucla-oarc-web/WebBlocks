task :_after do
  total_time = 0.0
  puts "[Compiler] Execution phases ran in:" if ::WebBlocks.config[:options][:timing]
  ::WebBlocks::Build::Dispatcher.telemetry[:execute_time].each do |idx, val|
    puts "  [Task: #{idx}] #{((val*10).round.to_f)/10}s" if ::WebBlocks.config[:options][:timing]
    total_time += val
  end
  puts "[Compiler] Compiler ran in #{((total_time*10).round.to_f)/10}s" unless ::WebBlocks.config[:options][:silent]
end

current_tasks =  Rake.application.top_level_tasks
current_tasks << :_after
Rake.application.instance_variable_set(:@top_level_tasks, current_tasks)