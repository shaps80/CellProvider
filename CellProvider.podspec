Pod::Spec.new do |s|
  s.name             = 'CellProvider'
  s.version          = '1.0.0'
  s.summary          = 'A generic cell provider implementation in Swift.'
  s.homepage         = 'https://github.com/shaps80/CellProvider'
  s.screenshots     = 'https://github.com/shaps80/CellProvider/blob/master/Cells.png?raw=true'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Shaps Mohsenin' => 'shapsuk@me.com' }
  s.source           = { :git => 'https://github.com/shaps80/CellProvider.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/shaps'
  s.ios.deployment_target = '8.0'
  s.source_files = 'CellProvider/Classes/**/*'
end
