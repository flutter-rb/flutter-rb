module FlutterRb
  # Check for Flutter plugin structure validation
  class PluginDirectoriesCheck < Check
    def info
      'Validate Flutter plugin structure'
    end

    def check(plugin_root)
      android_exists = File.exist?("#{plugin_root}/android")
      ios_exists = File.exist?("#{plugin_root}/ios")

      android_exists && ios_exists || !android_exists && !ios_exists
    end
  end
end
