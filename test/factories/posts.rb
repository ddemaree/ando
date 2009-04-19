Factory.define :article do |a|
  a.title { Faker::Lorem.sentence }
  a.body  { Faker::Lorem.paragraphs(5).join("\n\n") }
end

Factory.define :published_article do |a|
  a.status       "published"
  a.published_at { Time.now - 2.days }
end