class ObjectFlatten
  class << self
    def flatten(obj, sep = '.')
      unless obj.is_a?(Hash)
        raise TypeError, "TypeError: wrong argument type #{obj.class} (expected Hash)"
      end

      flatten0(nil, obj, sep.to_s)
    end

    private

    def flatten0(root, obj, sep, acc = [])
      case obj
      when Array
        obj.each do |value|
          flatten0(root, value, sep, acc)
        end
      when Hash
        obj.each do |key, value|
          flatten0(join(root, key, sep), value, sep, acc)
        end
      else
        acc << {root => obj}
      end

      acc
    end

    def join(root, key, sep)
      key = key.to_s
      root ? root + sep + key : key
    end
  end
end
