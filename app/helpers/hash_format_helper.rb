module HashFormatHelper
  # These methods add classes to the HTML structure that are defined in Bootstrap (and can be defined for other CSS frameworks)
  def format_hash(hash, html = '', read_only = true, cus_key)
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
          Rails.logger.info "read only #{read_only}"
          if (cus_key != false)
            name_with_parent = "service[" + cus_key.to_s.underscore + "]" + "[" + key.to_s.underscore + "]"
          else
            name_with_parent = "service[" + key.to_s.underscore + "]"
          end
          puts "====name_with_parent==========#{name_with_parent}=============="
          if read_only || (value.is_a?(Hash) && value.empty? )#I'm sure there's a better way to embed the readonly flag...
            ul_contents << content_tag(:input, nil, class:"form-control form-control-sm",
                                     type:"text", name:name_with_parent,
                                    id:key, value:value,  :readonly => false )
          else
            ul_contents << content_tag(:input, nil, class:"form-control form-control-sm",
                                       type:"text", name:name_with_parent,
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
            puts "=======CALL==CUSTOM=KEY!!!!!!!!!!!====#{(key.to_s.underscore.inspect)}=="
          send_key(key.to_s.underscore)
          inner = content_tag(:div, format_hash(value, '', read_only, key.to_s.underscore), class: 'divTableCell ml-5')

          ul_contents << inner

          ul_contents.html_safe
        }
      elsif value.is_a?(Array)
        Rails.logger.info "RECEIVED::ARRAY:: Calling format array"
        html += format_array(value,'', read_only, @@k)
      else
        Rails.logger.info "Unexpected value in format_hash: #{value.inspect}"
        Rails.logger.info "value type: #{value.class.name}"
      end
    end
    html.html_safe
  end

  def send_key(key)
    @@k = key
  end

  def format_array(array, html = '', read_only, parent_key)
    # Rails.logger.info "RECEIVED::ARRAY::: #{array.to_s}"
    array.each do |value|
      if value.is_a?(String)
        html += content_tag(:div, value).html_safe
      elsif value.is_a?(Hash)
        html += content_tag(:div, class: 'divTableCell') {
          inner = format_hash(value, '', read_only, parent_key)
          inner.html_safe
        }

      elsif value.is_a?(Array)
        html += format_array(value, html, read_only, parent_key)
      else
        Rails.logger.info "Unexpected value in format_array: #{value.inspect}"
        Rails.logger.info "value type: #{value.class.name}"
      end
    end
    html
  end

end
