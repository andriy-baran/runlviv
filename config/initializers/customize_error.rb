ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  html = %(<div class="field_with_errors">#{html_tag}</div>).html_safe

  form_fields = [
    'textarea',
    'input',
    'select'
  ]

  elements = Nokogiri::HTML::DocumentFragment.parse(html_tag).css "label, " + form_fields.join(', ')

  elements.each do |e|
    if e.node_name.eql? 'label'
      html = %(<div class="form-group has-danger">#{e}</div>).html_safe
    elsif form_fields.include? e.node_name
      html = %(#{html_tag}<div class="invalid-feedback">&nbsp;#{Array(instance.error_message).uniq.join(', ')}</div>).html_safe
    end
  end
  html
end