namespace :interactor do
  task run: :environment do
    MainWorker.perform_async
  end
end
