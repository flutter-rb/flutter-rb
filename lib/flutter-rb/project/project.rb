module FlutterRb
  class Project
    def initialize(pubspec, android_folder, ios_folder)
      @pubspec = pubspec
      @android_folder = android_folder
      @ios_folder = ios_folder
    end

    attr_accessor :pubspec, :android_folder, :ios_folder
  end
end
