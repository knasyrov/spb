module ApplicationHelper
	def link_to_add_attachment(name, f, association)
    	new_object = f.object.class.reflect_on_association(association).klass.new
    	fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      		render(:partial => 'shared/attachment', :locals => {:f => builder})
    	end
    	link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
	end	
end
