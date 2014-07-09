desc 'default'
task default: [:build, :test]

desc 'build'
task :build do
    sh 'msbuild'
end

desc 'rebuild'
task :rebuild do
    sh 'msbuild /t:clean;rebuild'
end

