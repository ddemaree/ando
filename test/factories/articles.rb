Factory.sequence :article_basename do |n|
  "article#{n}" 
end
  
Factory.define :first_article, :class => Article do |a|
  a.title "First Article"
  a.body "One morning, as Gregor Samsa was waking up from anxious dreams, he discovered that in bed he had been changed into a monstrous verminous bug. He lay on his armour-hard back and saw, as he lifted his head up a little, his brown, arched abdomen divided up into rigid bow-like sections. From this height the blanket, just about ready to slide off completely, could hardly stay in place. His numerous legs, pitifully thin in comparison to the rest of his circumference, flickered helplessly before his eyes."
  a.status "draft"
  a.created_at "2008-01-01 18:01:01 UTC"
  #a.basename { Factory.next(:article_basename) }
end

Factory.define :second_article, :class => Article do |a|
  a.title "Second Article"
  a.body "Alice was beginning to get very tired of sitting by her sister on the bank, and of having nothing to do: once or twice she had peeped into the book her sister was reading, but it had no pictures or conversations in it, 'and what is the use of a book,' thought Alice 'without pictures or conversation?'\n\nSo she was considering in her own mind (as well as she could, for the hot day made her feel very sleepy and stupid), whether the pleasure of making a daisy-chain would be worth the trouble of getting up and picking the daisies, when suddenly a White Rabbit with pink eyes ran close by her."
  a.excerpt "This is the excerpt"
  a.status "published"
  a.created_at "2008-04-21 17:01:01 UTC"
  #a.basename { Factory.next(:article_basename) }
end