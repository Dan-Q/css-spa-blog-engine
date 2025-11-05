# Don't produce output files for individual posts:
ignore 'posts/*'

helpers do
  def parse_content(content, type)
    case type
    when :md
      return Kramdown::Document.new(content).to_html
    end
    content # return original content if not in the list of "special" types above!
  end

  def posts
    return @posts if @posts # caching - only load all the posts once!
    @posts = []
    # force Markdown parsing even if it's e.g. HTML, for consistency, and make YAML parser trust Dates
    frontmatter_parser = FrontMatterParser::Parser.new(:md, loader: FrontMatterParser::Loader::Yaml.new(allowlist_classes: [Date]))
    Dir.glob('source/posts/*').each do |file|
      parsed = frontmatter_parser.call(File.read(file))
      post = parsed.front_matter
      post['content'] = parse_content(parsed.content, file.split('.').last.to_sym)
      @posts << post
    end
    # filter out posts in the future, then sort by date (reverse chronological order)
    @posts = @posts.select { |post| post['date'] <= Date.today }.sort_by { |post| post['date'] }.reverse
    @posts
  end
end
