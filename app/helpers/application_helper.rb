module ApplicationHelper
	def image_tag(source, options={})
    	source = "default.jpg" if source.blank? or source == nil
    	super(source, options)
  end
end
