def stdbuf(env = ENV)
  case RUBY_PLATFORM
  when /netbsd/i
    stdbuf_all = env['STDBUF']
    {
      'STDBUF0' => STDIN,
      'STDBUF1' => STDOUT,
      'STDBUF2' => STDERR,
    }.each do |key, io|
      value = env[key] || stdbuf_all
      next unless value

      case value
      when 'U', 'u', 'L', 'l', '0'
        io.sync = true
      when 'F', 'f', /\A\d+\z/
        io.sync = false
      end
    end
  else  # Linux (GNU coreutils), FreeBSD, etc...
    return if !env.key?('LD_PRELOAD') || /\blibstdbuf.so\b/ !~ env['LD_PRELOAD']

    {
      '_STDBUF_I' => STDIN,
      '_STDBUF_O' => STDOUT,
      '_STDBUF_E' => STDERR,
    }.each do |key, io|
      value = env[key]
      next unless value

      case value
      when '0', 'L'
        io.sync = true
      when 'B', /\A\d+(?:[kKMGTPEZY]B?)?\z/
        io.sync = false
      end
    end
  end
end

stdbuf(ENV)
