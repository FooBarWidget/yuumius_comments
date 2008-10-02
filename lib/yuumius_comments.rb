# Copyright (c) 2008 Phusion
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

module YuumiusComments
	mattr_accessor :host
	@@host = "http://yuumi.us"
	
	module ViewExtensions
		def yuumius_headers
			return %Q(<script type="text/javascript" src="#{YuumiusComments.host}/javascripts/embedding/inline.js"></script>)
		end
		
		def yuumius_comments(namespace)
			if namespace.blank?
				raise ArgumentError, "The 'namespace' argument may not be blank."
			elsif namespace !~ /\A[a-z0-9_:]+\Z/i
				raise ArgumentError, "The 'namespace' argument may only contain characters, numbers, underscores and colons."
			elsif namespace.index(":") != namespace.rindex(":")
				raise ArgumentError, "The 'namespace' argument may only contain a single colon."
			end
			return %Q(<script type="text/javascript" src="#{h yuumius_comments_url(namespace)}"></script>)
		end
	
	private
		def yuumius_comments_url(namespace)
			return "#{YuumiusComments.host}/embeds/channels/#{h namespace}.js"
		end
	end
end
