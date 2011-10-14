# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "base62"
  s.version = "0.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["JT Zemp", "Saadiq Rodgers-King", "Derrick Camerino"]
  s.date = "2010-11-24"
  s.description = "Base62 monkeypatches Integer to add an Integer#base62_encode\n                instance method to encode an integer in the character set of\n                0-9 + A-Z + a-z. It also monkeypatches String to add\n                String#base62_decode to take the string and turn it back\n                into a valid integer."
  s.email = "jtzemp@gmail.com"
  s.homepage = "http://github.com/jtzemp/base62"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "Base62 monkeypatches Integer to add an Integer#base62_encode instance method to encode an integer in the character set of 0-9 + A-Z + a-z. It also monkeypatches String to add String#base62_decode to take the string and turn it back into a valid integer."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
