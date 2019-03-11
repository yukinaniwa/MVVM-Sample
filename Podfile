source 'https://github.com/CocoaPods/Specs.git'

platform :ios, "11.0"

target 'MVVM-Sample' do

    use_frameworks!

    pod 'RxSwift',    '~> 4.0'
    pod 'RxCocoa',    '~> 4.0'

    pod 'SwiftyBeaver',    '~> 1.0'

end

post_install do | installer |
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = "3.0"
        end
    end
end
