timestamp = Time.now.strftime( '%Y%m%d%H%M%S' )

`scp -r build/ nw:/var/www/d20_vs_2d10_website/#{timestamp}`

`ssh nw 'ln -s /var/www/d20_vs_2d10_website/#{timestamp} /var/www/d20_vs_2d10_website/build'`

# Dir.glob('*') - ['build']