class ObjectFlatten
  class << self
    def flatten(obj, options = {})
      unless obj.is_a?(Hash)
        raise TypeError, "TypeError: wrong argument type #{obj.class} (expected Hash)"
      end

      options = {
        :separator => '.',
      }.merge(options)

      flatten0(nil, obj, options)
    end

    private

    def flatten0(root, obj, options, acc = [])
      case obj
      when Array
        obj.each do |value|
          flatten0(root, value, options, acc)
        end
      when Hash
        obj.each do |key, value|
          flatten0(join(root, key, options), value, options, acc)
        end
      else
        acc << {root => obj}
      end

      acc
    end

    def join(root, key, options)
      key = key.to_s
      sep = options[:separator]
      tr = options[:tr]

      if tr
        key = key.tr(*tr)
      end

      root ? (root + sep + key) : key
    end
  end
end
