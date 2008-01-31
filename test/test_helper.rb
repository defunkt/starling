require 'test/unit'
require 'fileutils'
$:.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

lib = File.join(File.dirname(__FILE__), "..")
tmp = File.join(lib, 'tmp')
FileUtils.mkdir tmp unless File.exists? tmp
$:.unshift(File.join(lib, "lib"))
