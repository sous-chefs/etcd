#
# Author:: Adam Jacob (<adam@opscode.com>)
# Author:: Christopher Brown (<cb@opscode.com>)
# Copyright:: Copyright (c) 2008 Opscode, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'tempfile'
require 'stringio'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "spec_helper"))

class LoggerLike
  attr_accessor :level
  attr_reader :messages
  def initialize
    @messages = ""
  end

  [:debug, :info, :warn, :error, :fatal].each do |method_name|
    class_eval(<<-E)
      def #{method_name}(message)
        @messages << message
      end
    E
  end
end

describe Mixlib::Log do

  # Since we are testing class behaviour for an instance variable
  # that gets set once, we need to reset it prior to each example [cb]
  before(:each) do
    Logit.reset!
  end

  it "creates a logger using an IO object" do
    io = StringIO.new
    Logit.init(io)
    Logit << "foo"
    io.string.should match(/foo/)
  end

  it "creates a logger with a file name" do
    Tempfile.open("chef-test-log") do |tempfile|
      Logit.init(tempfile.path)
      Logit << "bar"
      tempfile.rewind
      tempfile.read.should match(/bar/)
    end
  end

  it "uses the logger provided when initialized with a logger like object" do
    logger = LoggerLike.new
    Logit.init(logger)
    Logit.debug "qux"
    logger.messages.should match(/qux/)
  end

  it "should re-initialize the logger if init is called again" do
    first_logdev, second_logdev = StringIO.new, StringIO.new
    Logit.init(first_logdev)
    Logit.fatal "FIRST"
    first_logdev.string.should match(/FIRST/)
    Logit.init(second_logdev)
    Logit.fatal "SECOND"
    first_logdev.string.should_not match(/SECOND/)
    second_logdev.string.should match(/SECOND/)
  end

  it "should set the log level using the binding form,  with :debug, :info, :warn, :error, or :fatal" do
    levels = {
      :debug => Logger::DEBUG,
      :info  => Logger::INFO,
      :warn  => Logger::WARN,
      :error => Logger::ERROR,
      :fatal => Logger::FATAL
    }
    levels.each do |symbol, constant|
      Logit.level = symbol
      Logit.logger.level.should == constant
      Logit.level.should == symbol
    end
  end

  it "passes blocks to the underlying logger object" do
    logdev = StringIO.new
    Logit.init(logdev)
    Logit.fatal { "the_message" }
    logdev.string.should match(/the_message/)
  end


  it "should set the log level using the method form, with :debug, :info, :warn, :error, or :fatal" do
    levels = {
      :debug => Logger::DEBUG,
      :info  => Logger::INFO,
      :warn  => Logger::WARN,
      :error => Logger::ERROR,
      :fatal => Logger::FATAL
    }
    levels.each do |symbol, constant|
      Logit.level(symbol)
      Logit.logger.level.should == constant
    end
  end

  it "should raise an ArgumentError if you try and set the level to something strange using the binding form" do
    lambda { Logit.level = :the_roots }.should raise_error(ArgumentError)
  end

  it "should raise an ArgumentError if you try and set the level to something strange using the method form" do
    lambda { Logit.level(:the_roots) }.should raise_error(ArgumentError)
  end

  it "should pass other method calls directly to logger" do
    Logit.level = :debug
    Logit.should be_debug
    lambda { Logit.debug("Gimme some sugar!") }.should_not raise_error
  end

  it "should default to STDOUT if init is called with no arguments" do
    logger_mock = Struct.new(:formatter, :level).new
    Logger.stub!(:new).and_return(logger_mock)
    Logger.should_receive(:new).with(STDOUT).and_return(logger_mock)
    Logit.init
  end

  it "should have by default a base log level of warn" do
    logger_mock = Struct.new(:formatter, :level).new
    Logger.stub!(:new).and_return(logger_mock)
    Logit.init
    Logit.level.should eql(:warn)
  end

end
