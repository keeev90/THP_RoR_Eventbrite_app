module DeviseHelper
  def devise_error_messages!
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    html = <<-HTML
    <div class="text-center alert alert-danger alert-dismissible fade show" role="alert">
      <strong> 
        #{resource.errors.count} erreur(s) :
      </strong>
      #{messages}
      <button type="button" class="close" data-dismiss="alert">
        <span aria-hidden="true">&times;</span>
      </button>
    </div>
    HTML

    html.html_safe
  end
end