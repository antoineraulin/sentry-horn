use_frameworks!
platform :ios, '9.0'

target 'Horn' do
    pod 'Alamofire'             , '~> 3.5.1'
    pod 'SwiftyJSON'            , '~> 2.4.0'
    pod 'SnapKit'               , '~> 0.22.0'
    pod 'MJRefresh'             , '~> 3.1.0'
    pod 'Observable-Swift'      , :git=>'https://github.com/GengmeiRD/Observable-Swift'
    pod 'EVReflection'          , :git=>'https://github.com/evermeer/EVReflection', :branch=>'Swift2.3'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '2.3'
        end
    end
end

