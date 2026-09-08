# frozen_string_literal: true

require 'json'
require 'base64'

provides :etcd_key
unified_mode true
property :sensitive, [true, false], default: true

property :key, String, name_property: true, desired_state: false
property :value, String
property :ttl, [Integer, String], default: 0, coerce: proc { |v| Integer(v) }, callbacks: { 'must not be negative' => proc { |v| v >= 0 } }
property :host, String, default: '127.0.0.1', desired_state: false
property :port, Integer, default: 2379, desired_state: false
property :scheme, %w(http https), default: 'http', desired_state: false
property :cacert, String, desired_state: false
property :cert, String, desired_state: false
property :client_key, String, desired_state: false
property :etcdctl_bin, String, default: '/usr/bin/etcdctl', desired_state: false
property :command_timeout, Integer, default: 30, desired_state: false
property :watch_timeout, Integer, default: 600, desired_state: false

def client_command(*args)
  command = [etcdctl_bin, "--endpoints=#{scheme}://#{host}:#{port}", "--command-timeout=#{command_timeout}s"]
  command << "--cacert=#{cacert}" if cacert
  command << "--cert=#{cert}" if cert
  command << "--key=#{client_key}" if client_key
  command + args
end

def client_json(*args, **options)
  result = shell_out!(*client_command('--write-out=json', *args), **options, timeout: command_timeout, environment: { 'ETCDCTL_API' => '3' })
  JSON.parse(result.stdout)
end

load_current_value do |desired|
  item = desired.client_json('get', '--', desired.key).fetch('kvs', []).first
  if item
    value Base64.strict_decode64(item.fetch('value', ''))
    lease = item.fetch('lease', 0).to_i
    ttl(lease.zero? ? 0 : desired.client_json('lease', 'timetolive', lease.to_s(16)).fetch('granted-ttl'))
  else
    current_value_does_not_exist!
  end
end

action :set do
  raise ArgumentError, 'etcd_key :set requires a value' if new_resource.value.nil?

  converge_if_changed :value, :ttl do
    options = []
    if new_resource.ttl.positive?
      lease = new_resource.client_json('lease', 'grant', new_resource.ttl.to_s).fetch('ID')
      options << "--lease=#{lease.to_i.to_s(16)}"
    end
    new_resource.client_json('put', *options, '--', new_resource.key, input: new_resource.value)
  end
end

action :delete do
  unless current_resource.nil?
    converge_by "delete etcd key #{new_resource.key}" do
      new_resource.client_json('del', '--', new_resource.key)
    end
  end
end

action :watch do
  execute "watch etcd key #{new_resource.key}" do
    command new_resource.client_command('watch', '--', new_resource.key)
    environment 'ETCDCTL_API' => '3'
    timeout new_resource.watch_timeout
    sensitive true
  end
end
