desc "Enqueue fetch jobs"
task :queue_jobs => :environment do
  Importer.new.enqueue_jobs
end

desc "Process jobs"
task :process_jobs => :environment do
  Importer.new.process_jobs
end

desc "Fetch Indie88 Data"
task :indie88 => :environment do
  i = Importer.new
  i.enqueue_jobs
  i.process_jobs
end
