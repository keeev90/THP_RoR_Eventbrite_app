module ApplicationHelper
  # Remplacer les intitulés de types alerts Rails par ceux de Bootstrap
  def bootstrap_class_for_flash(type)
    case type
      when 'notice' then "info"
      when 'success' then "success"
      when 'error' then "danger"
      when 'alert' then "warning"
    end
  end
end
