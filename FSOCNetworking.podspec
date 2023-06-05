#
# Be sure to run `pod lib lint FSOCNetworking.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FSOCNetworking'
  s.version          = '1.0.6'
  s.summary          = '在AFNetworking基础上，封装YTKRequest，提供更面向业务处理的网络层'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
主要用于定制网络数据，进行业务处理。提供打印定义、参数定义、状态码定义，面向移动端业务。
                       DESC

  s.homepage         = 'https://github.com/zhangzhongyan/FSOCNetworking'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '张忠燕' => '749994100@qq.com' }
  s.source           = { :git => 'https://github.com/zhangzhongyan/FSOCNetworking.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  
  s.requires_arc = true
#  s.default_subspec = 'BaseRequest'

  s.source_files = 'FSOCNetworking/FSOCNetworking.h'
  
  # YTKNetwork仓库
  s.subspec 'YTKNetwork' do |ss|
    ss.source_files = 'FSOCNetworking/Classes/YTKNetwork/*{h,m}'
    ss.dependency 'AFNetworking', '~> 4.0.1'
  end
  
  # Model仓库
  s.subspec 'Model' do |ss|
    ss.source_files = 'FSOCNetworking/Classes/Model/*{h,m}'
  end
    
  # Request仓库
  s.subspec 'Request' do |ss|
    ss.source_files = 'FSOCNetworking/Classes/Request/*{h,m}'
    ss.dependency 'FSOCNetworking/YTKNetwork'
    ss.dependency 'FSOCNetworking/Model'
  end
  
  # Utils仓库
  s.subspec 'Utils' do |ss|
    ss.source_files = 'FSOCNetworking/Classes/Utils/*{h,m}'
  end
  
  # Security仓库
  s.subspec 'Security' do |ss|
    ss.source_files = 'FSOCNetworking/Classes/Security/*{h,m}'
    ss.dependency 'AFNetworking'
  end
  
  # Client仓库
  s.subspec 'Client' do |ss|
    ss.source_files = 'FSOCNetworking/Classes/Client/*{h,m}'
    ss.dependency 'MJExtension'
    ss.dependency 'FSOCNetworking/Request'
    ss.dependency 'FSOCNetworking/Utils'
    ss.dependency 'FSOCUtils/JSONUtils'
  end

end
