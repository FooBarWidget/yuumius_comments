require 'rubygems'
require 'active_support'
require 'erb'
require File.dirname(__FILE__) + '/../lib/yuumius_comments'

class Helper
	include YuumiusComments::ViewExtensions
			
	public :yuumius_comments_url
	
	def h(text)
		return ERB::Util.h(text)
	end
end

DEFAULT_YUUMIUS_COMMENTS_HOST = YuumiusComments.host

describe YuumiusComments::ViewExtensions, "#yuumius_comments" do
	before :each do
		@helper = Helper.new
		YuumiusComments.host = DEFAULT_YUUMIUS_COMMENTS_HOST
	end
	
	it "works" do
		@helper.yuumius_comments("foo").should == '<script type="text/javascript" src="http://yuumi.us/embeds/channels/foo.js"></script>'
	end
	
	it "doesn't accept a blank namespace argument" do
		lambda { @helper.yuumius_comments("   ") }.should raise_error(ArgumentError)
	end
	
	it "accepts characters, numbers and underscores in the namespace argument" do
		lambda { @helper.yuumius_comments("aAbC_1234_") }.should_not raise_error(ArgumentError)
	end
	
	it "doesn't accept namespace arguments that contain anything other than characters, numbers, underscores and colons" do
		lambda { @helper.yuumius_comments("AabC_1234_.") }.should raise_error(ArgumentError)
	end
	
	it "accepts a single colon in the namespace argument" do
		lambda { @helper.yuumius_comments("foo:bar") }.should_not raise_error(ArgumentError)
	end
	
	it "doesn't accept multiple colons in the namespace argument" do
		lambda { @helper.yuumius_comments("foo:bar:baz") }.should raise_error(ArgumentError)
	end
	
	it "constructs the URL using YuumiusComments.host" do
		YuumiusComments.host = "http://foo"
		@helper.yuumius_comments_url("hi").should == "http://foo/embeds/channels/hi.js"
	end
end
