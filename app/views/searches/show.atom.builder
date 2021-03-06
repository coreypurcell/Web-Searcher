atom_feed do |feed|
  feed.title(h @search.text)
  feed.update(!@search.results.empty? ? @search.results.first.created_at : "")
  
  unless(@search.results.empty?)
    @search.results.each do |result|
      feed.entry(@search, result) do |entry|
        entry.title(result.text)
        entry.content(result.href, :type => 'html')
      end
    end
  end
end