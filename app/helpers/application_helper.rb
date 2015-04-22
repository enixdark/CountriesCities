module ApplicationHelper


	def image_tag(source, options={})
		source = "default.jpg" if source.blank? or source == nil
		super(source, options)
	end

	def bs_flash_class_for type
		# byebug
		case type.to_sym
			when :success 
				"alert-success"
			when :error 
				"alert-danger"
			when :notice 
				"alert-info"
			else 
				type.to_s
		end
  		# {
  		#  success: "alert-success",
  		#  error: "alert-danger",
  		#  notice: "alert-info"
  		# }[flash_type] || flash_type.to_s
  	end
  end
