#!/usr/bin/env ruby
require 'open-uri'
require 'yaml'

DYNAMIC_DNS_CONFIG_FILE = '/etc/ez-ipupdate/dynamic_dns.yml'
AMAZON_INSTANCE_DATA_ADDRESS = "http://169.254.169.254"
api = "latest"
ip = open(File.join(AMAZON_INSTANCE_DATA_ADDRESS, api, 'meta-data', 'public-ipv4')).read

dns_config = YAML::load(File.open(DYNAMIC_DNS_CONFIG_FILE))
hosts = dns_config['host'].split(',')
hosts.each do |host|
  puts "updating dynamic dns to ip = #{ip} for host #{host} using dynamic DNS service " +
       "#{dns_config['service']}"
  command = "ez-ipupdate --address #{ip} --service-type #{dns_config['service']} " +
            "--user #{dns_config['username']}:#{dns_config['password']} --host #{host}"
  puts command
  system(command)
end