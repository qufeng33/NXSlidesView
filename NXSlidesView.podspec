Pod::Spec.new do |s|
  s.name         = 'NXSlidesView'
  s.version      = '0.1.2'
  s.summary      = '无限轮播图'
  s.homepage     = 'https://github.com/qufeng33/NXSlidesView.git'
  s.license      = 'MIT'
  s.author             = { 'nightx' => 'qufeng33@hotmail.com' }
  s.platform     = :ios, '7.0'
  s.source       = { :git => 'https://github.com/qufeng33/NXSlidesView.git', :tag => s.version }
  s.source_files  = 'NXSlidesView'
  s.requires_arc = true
  s.dependency 'YYWebImage'
  s.dependency 'Masonry'
end