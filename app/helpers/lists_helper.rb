module ListsHelper

  def file_link(information_file)
    link_to image_tag("/assets/no_image.png", width: "50", height: "50") + "Download", url_for(information_file), target: :_blank, class: "doc-img" if information_file.attached? 
  end
end
