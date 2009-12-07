Factory.define(:search) do |f|
  f.sequence(:text) { |i| "Search #{i}"}
end
