#!/usr/bin/perl -w

use strict;

use LWP::UserAgent;
use HTTP::Request::Common;
use CGI;

my $LSL_RPC_URI = 'http://xmlrpc.secondlife.com/cgi-bin/xmlrpc.cgi';

# get the key command number and argument from the command line
# and escape them so they are safe to send over XML
my $LSLKey = CGI::escapeHTML(shift || "");
my $LSLCommand = CGI::escapeHTML(shift || "");
my $LSLArgument = CGI::escapeHTML(shift || "");

# we must have a key and a command
if (!$LSLKey or !$LSLCommand) {die "bad command line";}


# build the request. The method name is llRemoteData the parameters
# consist of a single struct:
#       Channel => the id of the RPC channel
#       IntValue => the integer data
#       StringValue => the string data
my $requestBody = "
<?xml version=\"1.0\"?> 
<methodCall>
  <methodName>llRemoteData</methodName>
  <params>
    <param>
      <value>
        <struct>
          <member>
            <name>Channel</name>
              <value>
                <string>$LSLKey</string>
              </value>
            </member>
          <member>
            <name>IntValue</name>
              <value>
                <int>$LSLCommand</int>
              </value>
          </member>
          <member>
            <name>StringValue</name>
            <value>
              <string>$LSLArgument</string>
            </value>
          </member>
        </struct>
      </value>
    </param>
  </params>
</methodCall>
";

# create the user agent used to send the request
my $userAgent = LWP::UserAgent->new;
$userAgent->agent("Simple Perl RPC Demo 1.0");

# send the request and wait for the response
my $response = $userAgent->request(POST $LSL_RPC_URI,
        Content_Type => 'text/xml',
        Content => $requestBody);

# print the response or error received
print $response->error_as_HTML unless $response->is_success;

print $response->as_string;
