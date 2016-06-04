Pod::Spec.new do |s|
  s.name     = 'ICDataModel'
  s.version  = ‘0.0.1’
  s.ios.deployment_target = '6.1'

  s.license  = 'MIT'
  s.summary  = 'A short description of ICDataModel’
  s.homepage = 'https://github.com/402162095/ICDataModel'
  s.author       = { "xucao" => "x402162095@163.com" }
  s.source   = { :git => https://github.com/402162095/ICDataModel.git', :tag => s.version.to_s }

  s.description = 'A short description of ICDataModel'

  s.source_files = 'ICDataModel/*.{h,m}'
  s.framework    = 'Foundation'
  s.requires_arc = true
end