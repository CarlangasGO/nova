module ApplicationHelper
  PROVIDERS_WITH_ICONS = %w(twitter github gitlab bitbucket google_oauth2 facebook azure_oauth2 authentiq).freeze

  FORM_BASED_PROVIDERS = [/\Aldap/, 'crowd'].freeze
  
  def form_based_provider?(name)
    FORM_BASED_PROVIDERS.any? { |pattern| pattern === name.to_s }
  end
  
  def nested_dropdown(items)
    result = []
    items.map do |item, sub_items|
        result << [('- ' * item.depth) + item.name, item.id]
        result += nested_dropdown(sub_items) unless sub_items.blank?
    end
    result
  end

  #   current_controller?(:tree)           # => true
  #   current_controller?(:commits)        # => false
  #   current_controller?(:commits, :tree) # => true
  def current_controller?(*args)
    args.any? do |v| 
      v.to_s.downcase == controller.controller_name || v.to_s.downcase == controller.controller_path
    end
  end

  #   current_action?(:new)           # => true
  #   current_action?(:create)        # => false
  #   current_action?(:new, :create)  # => true
  def current_action?(*args)
    args.any? { |v| v.to_s.downcase == action_name }
  end

  def flash_class(level)
    case level
      when "notice" then "alert-info"
      when "success" then "alert-success"
      when "error" then "alert-danger"
      when "alert" then "alert-danger"
    end
  end
def gravatar_icon(user_email = '', size = nil, scale = 2)
    GravatarService.new.execute(user_email, size, scale) ||
      default_avatar
  end

  def default_avatar
    asset_path('no_avatar.png')
  end
  
  def hexdigest(string)
    Digest::SHA1.hexdigest string
  end

  def simple_sanitize(str)
    sanitize(str, tags: %w(a span))
  end

  def body_data_page
    [*controller.controller_path.split('/'), controller.action_name].compact.join(':')
  end

  def outdated_browser?
    browser.ie? && browser.version.to_i < 10
  end
  
  def truncate_first_line(message, length = 50)
    truncate(message.each_line.first.chomp, length: length) if message
  end
  
  # While similarly named to Rails's `link_to_if`, this method behaves quite differently.
  # If `condition` is truthy, a link will be returned with the result of the block
  # as its body. If `condition` is falsy, only the result of the block will be returned.
  def conditional_link_to(condition, options, html_options = {}, &block)
    if condition
      link_to options, html_options, &block
    else
      capture(&block)
    end
  end

  def page_class
    class_names = []
    class_names << 'issue-boards-page' if current_controller?(:boards)
    class_names << 'with-performance-bar' if performance_bar_enabled?

    class_names
  end
  
  # Returns active css class when condition returns true
  # otherwise returns nil.
  #
  # Example:
  #   %li{ class: active_when(params[:filter] == '1') }
  def active_when(condition)
    'active' if condition
  end
  
  def show_callout?(name)
    cookies[name] != 'true'
  end

  def collapsed_sidebar?
    cookies["sidebar_collapsed"] == "true"
  end

  def form_errors(model, type: 'form')
    return unless model.errors.any?

    pluralized = 'error'.pluralize(model.errors.count)
    headline   = "The #{type} contains the following #{pluralized}:"

    content_tag(:div, class: 'alert alert-danger', id: 'error_explanation') do
      content_tag(:h4, headline) <<
        content_tag(:ul) do
          model.errors.full_messages
            .map { |msg| content_tag(:li, msg) }
            .join
            .html_safe
        end
    end
  end
end
