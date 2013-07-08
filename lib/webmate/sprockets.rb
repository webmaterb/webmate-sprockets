require 'sprockets'
require 'webmate/sprockets/configuration'
require 'webmate/sprockets/asset_paths'
require 'webmate/sprockets/helpers'
require 'webmate/sprockets/static_compiler'

module Webmate
  module Sprockets
    def self.configure(&block)
      block.call(config)
      raise ArgumentError, "Cannot initialize Sprockets Environment without an app reference" if config.app.nil?

      @environment = ::Sprockets::Environment.new(config.app.root)

      config.paths.each do |path|
        environment.append_path(File.join(config.app.root, path))
      end

      # require assets from other gems
      Gem::Specification.to_a.each do |gem_spec|
        ['stylesheets', 'javascripts', 'images'].each do |dir|
          assets_path = File.join(gem_spec.full_gem_path, 'vendor', 'assets', dir)
          if Dir.exists?(assets_path)
            environment.append_path(assets_path)
          end
        end
      end

      if config.compress_assets?
        environment.js_compressor = Closure::Compiler.new
        environment.css_compressor = YUI::CssCompressor.new
      else
        environment.js_compressor = false
        environment.css_compressor = false
      end

      if config.manifest_path
        path = File.join(config.app.root, config.manifest_path, "manifest.yml")
      else
        path = File.join(config.app.settings.public_path, 'assets', "manifest.yml")
      end

      if File.exist?(path)
        YAML.load_file(path).each do |path, value|
          config.digests[path] = value
        end
      end

      environment.context_class.instance_eval do
        include Helpers
      end
    end

    def self.config
      @config ||= Configuration.new
    end

    def self.environment
      @environment
    end
  end
end