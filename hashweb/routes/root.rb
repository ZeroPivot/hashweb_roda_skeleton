class HashWeb < Roda
  ROOT = ""
  hash_branch ROOT do |r|
    r.on do
      r.get do
        "Hello, LineDB!"
      end
    end
  end
end
