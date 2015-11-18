module ApplicationHelper

  class CodeRayify < Redcarpet::Render::HTML
    def block_code(code, language)
      language ||= :plaintext
      CodeRay.scan(code, language).div
    end
  end

  def markdown(text)
    coderayified = CodeRayify.new(:filter_html => true,
                                  :hard_wrap => true)
    render_options = {
      # will remove from the output HTML tags inputted by user
      filter_html:     true,
      # will insert <br /> tags in paragraphs where are newlines
      # (ignored by default)
      hard_wrap:       true,
      # hash for extra link options, for example 'nofollow'
      link_attributes: { rel: 'nofollow' }
      # more
      # will remove <img> tags from output
      # no_images: true
      # will remove <a> tags from output
      # no_links: true
      # will remove <style> tags from output
      # no_styles: true
      # generate links for only safe protocols
      # safe_links_only: true
      # and more ... (prettify, with_toc_data, xhtml)
    }
    renderer = Redcarpet::Render::HTML.new(render_options)

    extensions = {
      #will parse links without need of enclosing them
      autolink:           true,
      # blocks delimited with 3 ` or ~ will be considered as code block.
      # No need to indent.  You can provide language name too.
      # ```ruby
      # block of code
      # ```
      fenced_code_blocks: true,
      # will ignore standard require for empty lines surrounding HTML blocks
      lax_spacing:        true,
      # will not generate emphasis inside of words, for example no_emph_no
      no_intra_emphasis:  true,
      # will parse strikethrough from ~~, for example: ~~bad~~
      strikethrough:      true,
      # will parse superscript after ^, you can wrap superscript in ()
      superscript:        true
      # will require a space after # in defining headers
      # space_after_headers: true
    }
    Redcarpet::Markdown.new(coderayified, extensions).render(text).html_safe
  end

<<<<<<< HEAD
<<<<<<< HEAD
  def avatar_url(user)
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png"
  end
=======
=======
>>>>>>> c9ec5ef... 使用 gravatar 生成用户头像
  def avatar_url(user, size = 200)
    if user.avatar_url.nil?
      hash = Digest::MD5::hexdigest(user.email.downcase)
      user.avatar_url = "http://www.gravatar.com/avatar/#{hash}"
      user.save
    end
    user.avatar_url + "?s=#{size}"
end
<<<<<<< HEAD
>>>>>>> b3b7667... 去掉无用的代码
=======
>>>>>>> c9ec5ef... 使用 gravatar 生成用户头像

end
