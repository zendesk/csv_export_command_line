require 'rubygems'
require 'active_support'
require 'active_support/time'
require 'zendesk_api'
require 'ruby-progressbar'
require 'csv'

class Tickets < Thor

  desc "export", "exports data to a csv file"
  method_option :subdomain, :required => true, :desc => 'Zendesk account/subdomain'
  method_option :username, :required => true, :desc => 'Zendesk API username'
  method_option :token, :required => true, :desc => 'Zendesk API token'
  method_option :from, :default => 1.week.ago.to_date, :desc => 'From which creation date (1 week ago from today\'s date). Format: YYYY-MM-DD'
  method_option :to, :default => Date.today, :desc => 'To which creation date (Today\'s date). Format: YYYY-MM-DD'
  method_option :fields, :default => 'id,subject,description,status,group_id,requester_id,assignee_id,created_at', :desc => 'Ticket fields to be exported'
  method_option :output_path, :default => Dir.home, :desc => 'Where to save the csv file'
  def export
    csv = CSV.open(File.expand_path("export-#{options.subdomain}-#{Date.today}.csv", Dir.home), "wb")
    csv << fields

    tickets.all do |ticket|
      csv << fields.map { |field| ticket[field] }
      progress_bar.increment
    end
  end

  private
  def fields
    @fields ||= options.fields.split(',')
  end

  def progress_bar
    @progress_bar ||= ProgressBar.create(:title => 'Tickets',
                                        :total => tickets.count,
                                        :format => '%a %B %p%% %t')
  end

  def tickets
    @tickets ||= api.search(:query => "type:ticket created>#{options.from} created<#{options.to}")
  end

  def api
    @api ||= ZendeskAPI::Client.new do |config|
      config.url = "https://#{options.subdomain}.zendesk.com/api/v2"
      config.username = options.username
      config.token = options.token

      config.retry = true
    end
  end
end
