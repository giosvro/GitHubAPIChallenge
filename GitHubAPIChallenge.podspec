Pod::Spec.new do |s|
  s.name         = 'GitHubAPIChallenge'
  s.version      = '0.1.0'
  s.summary      = 'Encapsulates the GitHub REST API'
  s.description  = 'An Objective-C framework that encapsulates the GitHub REST API, providing a streamlined interface for interacting with GitHub resources.'
  s.homepage     = 'https://github.com/giosvro/GitHubAPIChallenge'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'Giovanni Severo Barros' => 'giovannisevero10@gmail.com' }
  s.source       = { :git => 'https://github.com/giosvro/GitHubAPIChallenge.git', :tag => s.version }

  s.ios.deployment_target = '18.0'
  s.source_files = 'GitHubAPIChallenge/**/*.{h,m}'
  s.public_header_files = 'GitHubAPIChallenge/Models/**/*.h', 
                          'GitHubAPIChallenge/Services/**/*.h'


  s.private_header_files = 'GitHubAPIChallenge/Network/**/*.h'


  # Exponha apenas os headers nas pastas Models e Services
  s.public_header_files = 'GitHubAPIChallenge/Models/**/*.h', 
                          'GitHubAPIChallenge/Services/**/*.h'

  # Marque os headers em Network como privados para ocultá-los do cliente
  s.private_header_files = 'GitHubAPIChallenge/Network/**/*.h'

end
