platform :ios, '13.0'

use_frameworks!

target 'YahooStocks' do

  pod 'RxSwift', '6.2.0'
  pod 'RxCocoa', '6.2.0'

end

target 'RestClient' do

  pod 'RxSwift', '6.2.0'
  pod 'RxCocoa', '6.2.0'

end


target 'API' do

  pod 'RxSwift', '6.2.0'
  pod 'RxCocoa', '6.2.0'

end


post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end