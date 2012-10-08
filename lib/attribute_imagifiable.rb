module AttributeImagifiable

  extend ActiveSupport::Concern

  included do
    after_validation :generate_image
  end


  module ClassMethods
    def attribute_imagifiable(attribute, options={})
      raise ArgumentError.new("No :as given") if options[:as].nil?
      @_imagifiable_attributes ||= {}
      @_imagifiable_attributes[attribute] = options[:as]

      if (not column_names.include? "#{options[:as]}_file_name") or !self.instance_methods.include?(options[:as])
        $stderr.puts "Add #{options[:as]} Paperclip attribute before using attribute_imagifiable"
      end
    end
  end

  private
  def generate_image
    attributes =  self.class.instance_variable_get("@_imagifiable_attributes")
    attributes.each do |attribute, as|
      value = send(attribute)
      if send("#{attribute}_changed?") || !send(as).exists?
        if value.present?
          arg = Shellwords.escape(value)
          tmp_name = Rails.root.join("tmp/#{as}-#{SecureRandom.hex(10)}.jpg")
          cmd = "convert -fill black -gravity center -size x40 label:#{arg} #{tmp_name}"
          unless system(cmd)
            raise RuntimeError.new "Image generation of #{attribute} failed. #{tmp_name}"
          end
          self.send("#{as}=", File.open(tmp_name))
          File.delete tmp_name
        else
          self.send("#{as}=", nil)
        end
      end
    end
  end
end
