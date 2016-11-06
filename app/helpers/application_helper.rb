module ApplicationHelper
	def notice_message
    alert_types = { notice: :success, alert: :danger }

    close_button_options = { class: "close", "data-dismiss" => "alert", "aria-hidden" => true }
    close_button = content_tag(:button, "×", close_button_options)

    alerts = flash.map do |type, message|
      alert_content = close_button + message

      alert_type = alert_types[type.to_sym] || type
      alert_class = "alert alert-#{alert_type} alert-dismissable"

      content_tag(:div, alert_content, class: alert_class)
    end

    alerts.join("\n").html_safe
  end

  def set_image_url(source, style)
    if source.pictures.blank?
      return "/images/#{style}/picture.jpg"
    else
      return source.pictures.first.photo.url(style)
    end
  end

  def set_images_url(source, style)
    if source.pictures.blank?
      pictures = ["/images/#{style}/picture.jpg"]
    else
      pictures = source.pictures.map{ |picture| picture.photo.url(style)}
    end
  end
end
