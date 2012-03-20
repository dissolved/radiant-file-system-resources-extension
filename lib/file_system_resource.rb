module FileSystemResource
  def self.included(klass)
    klass.class_eval do
      def content
        if file_system_resource?
          File.read(path)
        else
          self[:content]
        end
      end

      def path
        RAILS_ROOT + "/app/templates/#{self.class.name.downcase.pluralize}/#{filename}.radius"
      end

      def content=(value)
        raise "File System Resources are read-only from the admin." if file_system_resource?
        self[:content] = value
      end

      def filename
        raise "#filename should not be called unless a file_system_resource." unless file_system_resource?
        name
      end
    end
  end
end