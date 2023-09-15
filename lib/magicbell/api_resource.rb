require 'active_support/inflector'
require 'active_support/core_ext/object/blank'
require 'json'

module MagicBell
  class ApiResource
    class << self
      def create(client, attributes = {}, extra_headers = {})
        new(client, attributes, extra_headers).create
      end

      def find(client, id)
        api_resource = new(client, 'id' => id)
        api_resource.retrieve
        api_resource
      end

      def name
        to_s.demodulize.underscore
      end

      def create_path
        "/#{name}s"
      end

      def create_url
        MagicBell.api_host + create_path
      end
    end

    attr_reader :id, :extra_headers

    def initialize(client, attributes = {}, extra_headers = {})
      @client = client
      @attributes = attributes
      @extra_headers = extra_headers

      @id = @attributes['id']
      @retrieved = true if @id
    end

    def attributes
      retrieve_unless_retrieved
      @attributes
    end

    alias_method :to_h, :attributes

    def attribute(attribute_name)
      attributes[attribute_name]
    end

    def retrieve
      response = @client.get(url)
      parse_response(response)

      self
    end

    def name
      self.class.name
    end

    def create_url
      MagicBell.api_host + create_path
    end

    def create_path
      "/#{name}s"
    end

    def url
      MagicBell.api_host + path
    end

    def path
      "/#{name}s/#{id}"
    end

    def create
      response = @client.post(
        create_url,
        body: { name => attributes }.to_json,
        headers: extra_headers
      )
      parse_response(response)

      self
    end

    def update(new_attributes = {})
      response = @client.put(
        url,
        body: new_attributes.to_json,
        headers: extra_headers
      )
      parse_response(response)

      self
    end

    def delete
      response = @client.delete(
        url,
        body: {},
        headers: extra_headers
      )
      parse_response(response)

      self
    end

    private

    attr_reader :response, :response_hash

    def retrieve_unless_retrieved
      return unless id # Never retrieve a new unsaved resource
      return if @retrieved

      retrieve
    end

    def parse_response(response)
      @response = response
      unless response.body.blank?
        @response_hash = JSON.parse(@response.body)
        @attributes = @response_hash[name]
      end
      @retrieved = true
    end
  end
end
