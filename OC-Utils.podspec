Pod::Spec.new do |s|
  s.name     = 'OC-Utils'
  s.version  = '1.0.0'
  s.license  = 'MIT'
  s.summary  = 'Objective-C Utils for iOS macOS'
  s.homepage = 'https://github.com/leleliu008/OC-Utils'
  s.authors  = { 'fpliu' => '792793182@qq.com' }
  s.source   = { :git => 'https://github.com/leleliu008/OC-Utils.git', :tag => s.version }
  s.source_files = 'OC-Utils'
  s.requires_arc = true
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target = '9.0'
end
