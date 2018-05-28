#
#  Be sure to run `pod spec lint RWMRecurrenceRule.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#

Pod::Spec.new do |s|

  s.name         = "RWMRecurrenceRule"
  s.version      = "0.0.1"
  s.summary      = "A library allowing you to create recurrence rules from iCalendar RRULE statements and to iterate the dates of a recurrence rule."

  s.description  = <<-DESC
Includes an extension to EKEvent and EKRecurrenceRule as well as custom structures allowing you to iterate the dates of an EKEvent and its recurrence rule. It also allows you to create EKRecurrenceRule instance from a standard iCalendar RRULE.
                   DESC

  s.homepage     = "https://github.com/rmaddy/RWMRecurrenceRule"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "Rick Maddy" => "rick@maddyhome.com" }

  s.ios.deployment_target = "9.0"
  s.osx.deployment_target = "10.9"
  s.watchos.deployment_target = "2.0"

  s.source       = { :git => "https://github.com/rmaddy/RWMRecurrenceRule.git", :tag => "#{s.version}" }

  s.source_files  = "RWMRecurrenceRule/**/*.{swift,h}"
  #s.exclude_files = "Classes/Exclude"

  s.public_header_files = "RWMRecurrenceRule/**/*.h"

  s.framework  = "Foundation"

  s.requires_arc = true

end
