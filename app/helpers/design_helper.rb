module DesignHelper
  def body_class
    "#{controller_name}_#{action_name}"
  end

  def get_tapas
    DiaryCover.all.order("created_at DESC")
  end
  
  def date_now

    I18n.l(Time.now, format: "%A, %d %B del %Y")
    
  end
  
  def title(page_title = "", &block)
    content_for(:title) { h(page_title.to_s)}
    
    
    if block.blank?
      data = page_title 
    else
      inner = capture(&block)
      data = inner.html_safe
    end

    #inner = content_tag(:div, data, class: "float-left") 

    inner = content_tag(:h2, data, class: "no-margin-bottom") 

    #inner2 = content_tag(:br, "", class: "clear") 
    #"<br class='clear'>".html_safe
    inner = content_tag(:div, inner, class: "container-fluid") 

    inner = content_tag(:div, inner, class: "hcontent") 

    content_tag(:header, inner, class: "page-header") 

  end


  def image_helper(page_image = "", &block)
    content_for(:my_image) { h(page_image.to_s)}
  end


  def raw_description

    tag_description = ""

    if @post.present?
      tag_description += "#{strip_tags(@post.content)}" 
    else
      tag_description += "El Primer Portal de Noticias de la Región Ucayali www.gacetaucayalina.com informa sobre actualidad local), nacional e internacional, política, elecciones, gastronomía, espectáculos y deportes, economía,  mundo, Perú, sociedad, ciudades, policiales, internet, tecnología, infografías, fotos, videos, audios, multimedia, humor, mapas, archivo" 
    end
    tag_description
    

  end

  def raw_keywords

    tag_description = ""

    if @post.present?
      tag_description += "#{strip_tags(@post.content.to_s)}" 
    else
      tag_description += "gacetaucayalina, Ucayali, Madre de Dios,Pedro Otiniano,George Clooney,Fútbol peruano, nacional e internacional, política, elecciones, gastronomía, espectáculos y deportes, economía,  mundo, Perú, sociedad, ciudades, policiales, internet, tecnología, infografías, fotos, videos, audios, multimedia, humor, mapas, archivo" 
    end
    tag_description
    

  end

  
  def raw_image
    raw_my_image = ""

    if @post.present?
      
      raw_my_image += "#{strip_tags("https://www.#{@site.url}#{@post.default_image_url}")}" 
    else
      raw_my_image += image_url "grupo_gaceta/social.jpg?1234"
    end
    raw_my_image
  end

  def raw_url

    tag_url = ""

    if content_for?(:url)
      tag_url += "#{strip_tags(content_for(:url))}" 
    else
      tag_url += request.url 
    end
    tag_url
  
  end

  def raw_title
    tag_title = ""

    if content_for?(:title)
      tag_title += "#{strip_tags(content_for(:title)).truncate(100)} | GacetaUcayalina" 
    else
      tag_title += " ZetaNova.com" 
    end
    tag_title
  end

  def show_title?
    @show_title
  end

  def section(options = {}, &block)
    #args[:class] = args.has_key?(:class) ? "#{args[:class]}" : ""
    #attrs = args.map {|k,v| "#{k}='#{v}' " }.join(" ")

    col_data = {}
    col_data[:class] = options.has_key?(:col_class) ? "#{options[:col_class]}" : "col-lg-12"

    inner = capture(&block)

    inner = content_tag(:div, inner, col_data) 

    inner = content_tag(:div, inner, class: "row")

    inner = content_tag(:div, inner, class: "container-fluid")

    content_tag(:section, inner, options)
  end

  def card(title, &block)

    inner = content_tag(:h3, title, class: "h4") 
    inner = content_tag(:div, inner, class: "card-header d-flex align-items-center")

      inner2 = capture(&block)

      inner2 = content_tag(:div, inner2, class: "card-body") 
      
    content_tag(:div, inner + inner2, class: "card")
    
  end

end