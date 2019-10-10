module HashFormatHelper
  # These methods add classes to the HTML structure that are defined in Bootstrap (and can be defined for other CSS frameworks)
  def format_hash(hash, html = '', read_only = true, form = nil)
    Rails.logger.info "RECEIVED::HASH::#{read_only}: #{hash.to_s}, "

    hash.each do |key, value |
      Rails.logger.info "KEY,VALUE::::: #{key},#{value}"
      #next if value.blank?
      puts "========value=========#{value}=====#{value.is_a?(Hash)}============="
      if value.is_a?(String) || value.is_a?(Numeric)  || value.blank?
        html += content_tag(:div, class: 'divTableRow mb-3') {
          ul_contents = ''
          ul_contents << content_tag(:div, content_tag(:p, key.to_s.underscore.humanize.titleize),
                                     class: 'divTableCell')
          # Rails.logger.info "read only #{read_only}"
          if read_only || (value.is_a?(Hash) && value.empty? )#I'm sure there's a better way to embed the readonly flag...
            ul_contents << content_tag(:input, nil, class:"form-control form-control-sm",
                                     type:"text", name:key,
                                    id:key, value:value,  :readonly => true )
          else
            ul_contents << content_tag(:input, nil, class:"form-control form-control-sm",
                                       type:"text", name:key,
                                       id:key, value:value, required:true )
          end
          Rails.logger.info "\n UL_CONTENTS = #{ul_contents}"
          ul_contents.html_safe

        }
      elsif value.is_a?(Hash)
        html += content_tag(:div, class: 'divTableRow mb-3 semi-bold') {
          ul_contents = ''
          ul_contents << content_tag(:div, content_tag(:p, key.to_s.underscore.humanize.titleize),
                                     class: 'divTableCell')

          inner = content_tag(:div, format_hash(value, '', read_only), class: 'divTableCell ml-5')

          ul_contents << inner

          ul_contents.html_safe
        }
      elsif value.is_a?(Array)
        Rails.logger.info "RECEIVED::ARRAY:: Calling format array"
        html += format_array(value,'', read_only)
      else
        Rails.logger.info "Unexpected value in format_hash: #{value.inspect}"
        Rails.logger.info "value type: #{value.class.name}"
      end
    end
    html.html_safe
  end

  def format_array(array, html = '', read_only)
    Rails.logger.info "RECEIVED::ARRAY::: #{array.to_s}"
    array.each do |value|
      if value.is_a?(String)
        html += content_tag(:div, value).html_safe
      elsif value.is_a?(Hash)
        html += content_tag(:div, class: 'divTableCell') {
          inner = format_hash(value, '', read_only)
          inner.html_safe
        }

      elsif value.is_a?(Array)
        html += format_array(value, html, read_only)
      else
        Rails.logger.info "Unexpected value in format_array: #{value.inspect}"
        Rails.logger.info "value type: #{value.class.name}"
      end
    end
    html
  end

end
