class Factory
  def self.new(*args, keyword_init: false, &block)
    raise ArgumentError, 'wrong number of arguments (0 for 1+)' if args.length < 1

    if args.first.is_a?(String)
      new_class_name = args.delete_at(0)
    end

    new_class = Class.new(*args) do
      include Enumerable
      attr_accessor *args

      define_method :initialize do |*values|
        values.each_with_index do |value, index|
          instance_variable_set(:"@#{args[index]}", value)
          self.class.send(:attr_accessor, args[index])
        end
      end
    end

  end


end
