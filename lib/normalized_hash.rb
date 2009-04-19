class NormalizedHash < HashWithIndifferentAccess
  include Enumerable
  
  class_inheritable_accessor :allowed_keys
  @@allowed_keys = []
  
  class_inheritable_accessor :defaults
  @@defaults = {}
  
  class_inheritable_accessor :normalizers
  @@normalizers = {}
  
  def self.allowed_keys(*args)
    @@allowed_keys = args
  end
  
  def self.default_value(key,value)
    @@defaults[key.to_sym] = value
  end
  
  def self.normalize(*keys)
    options = keys.last.is_a?(Hash) ? keys.pop : {}
    
    keys.each do |key|
      @@normalizers[key.to_sym] = (options[:with] || "normalize_#{key}".to_sym)
    end
  end
  
  def initialize(params={})
    @source_params = {}
    self << params
  end
  
  def inspect
    @source_params.inspect
  end
  
  def each(&block)
    @@allowed_keys.each do |key|
      yield [key, @source_params[key]]
    end
  end
  
  def [](key)
    @source_params[key.to_sym]
  end
  
  def << (new_params)
    raise Exception, "Hash expected, got #{new_params.class}" if !new_params.is_a?(Hash)
    new_params.assert_valid_keys(@@allowed_keys)
    
    @@allowed_keys.each do |key|
      self.assign_with_normalization(key, (new_params[key] || @@defaults[key]))
    end
  end
  
  def assign_with_normalization(key, value)
    normalizer_method = (@@normalizers[key] || "normalize_#{key}").to_sym
    @source_params[key] = send(normalizer_method, value)
  end
  alias_method :[]=, :assign_with_normalization
  
  def method_missing(method_name, *args)
    if method_name.to_s =~ /^normalize_/
      @@defaults || args.first
    else
      super
    end
  end
  
end