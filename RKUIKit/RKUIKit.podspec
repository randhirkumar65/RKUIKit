Pod::Spec.new do |spec|


  spec.name         = "RKUIKit"
  spec.version      = "1.0.1"
  spec.summary      = "This pod will be handy for reusing UIKit components"
  spec.description  = "This pod will be handy for reusing UIKit components and has several helpers method which can save lot of development time."
  spec.license       = "MIT"
  spec.homepage     = "https://github.com/randhirkumar65/RKUIKit/"
  spec.author             = { "Randhir Kumar" => "randhirkumar.rk65@gmail.com" }
  spec.social_media_url   = "https://twitter.com/Iamrandhir1"
  spec.swift_version = '5.0'
  spec.platform     = :ios, "12.0"
  spec.source       = { :git => "https://github.com/randhirkumar65/RKUIKit.git", :tag => "1.0.0" }
  spec.source_files  = "RKUIKit/**/*.{h,m,swift}"

end
