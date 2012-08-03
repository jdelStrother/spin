describe "Spin" do
  def root
    File.expand_path '../..', __FILE__
  end

  def spin(command, options={})
    command = "ruby -I #{root}/lib #{root}/bin/spin #{command} 2>&1"
    result = `#{command}`
    raise "FAILED #{command}\n#{result}" if $?.success? == !!options[:fail]
    result
  end

  it "can show current version" do
    spin("--version").should =~ /^\d+\.\d+\.\d+/
  end

  it "can show help" do
    spin("--help").should include("General Options:")
  end

  it "shows help when no arguments are given" do
    spin("", :fail => true).should include("General Options:")
  end
end
