# Be sure to restart your server when you modify this file.

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
# Mime::Type.register_alias "text/html", :iphone

Mime::Type.register "application/atom+xml;type=entry", :atompub

ActionController::Base.param_parsers[Mime::ATOM] = Proc.new { |data|  
  #raise Exception, "prak"
  atom_params = Hash.from_xml(data).with_indifferent_access
  atom_params.except("xmlns","generator")
}