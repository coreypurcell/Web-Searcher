Factory.define(:search) do |f|
  f.sequence(:text) { |i| "Search #{i}"}
end

Factory.define :result do |r|
  r.sequence(:text) { |i| "Result #{i}"}
  r.association :search, :factory => :search
end
