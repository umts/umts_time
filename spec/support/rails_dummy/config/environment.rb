# Load AtomicTime
libdir = File.expand_path File.join(File.dirname(__FILE__), '../../../..', 'lib')
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)
require 'atomic_time'

# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
