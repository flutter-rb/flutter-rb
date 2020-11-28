#!/usr/bin/ruby

require_relative './flutter'
flutter_rb = FlutterRb::FlutterRb.new

flutter_rb.start(Dir.pwd)
