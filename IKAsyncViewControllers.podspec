Pod::Spec.new do |spec|
  spec.name         = 'IKAsyncViewControllers'
  spec.version      = '1.0'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/iankeen/'
  spec.authors      = { 'Ian Keen' => 'iankeen82@gmail.com' }
  spec.summary      = 'A simple DSL for creating a chain of UIViewControllers to obtain a single output.'
  spec.source       = { :git => 'https://github.com/iankeen/ikasyncviewcontrollers.git', :tag => spec.version.to_s }

  spec.source_files = 'IKAsyncViewControllers/**/**.{h,m}'
  
  spec.requires_arc = true
  spec.platform     = :ios
  spec.ios.deployment_target = "7.0"

  spec.dependency 'IKResults', '~> 1.0'
end
