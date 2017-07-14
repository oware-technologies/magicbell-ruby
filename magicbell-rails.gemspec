Gem::Specification.new do |s|
  s.name          = "magicbell-rails"
  s.summary       = "Makes it easy to add magicbell.io widget to your rails app"
  s.version       = "1.0.0.beta1"
  s.date          = "2016-07-13"
  s.authors       = ["Hana Mohan", "Nisanth Chunduru"]
  s.email         = ["hana@magicbell.io", "nisanth@magicbell.io"]
  s.files         = Dir["{lib}/**/*"] + ["README.md"]

  s.add_dependency("activesupport")
  s.add_dependency("rails")
end
