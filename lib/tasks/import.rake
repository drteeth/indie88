desc "Enqueue fetch jobs"
task :queue_jobs => :environment do
  Importer.new.enqueue_jobs
end

desc "Process jobs"
task :process_jobs => :environment do
  Importer.new.process_jobs
end
