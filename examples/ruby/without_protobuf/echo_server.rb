#!/usr/bin/env ruby

# Copyright 2015, Google Inc.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
#     * Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above
# copyright notice, this list of conditions and the following disclaimer
# in the documentation and/or other materials provided with the
# distribution.
#     * Neither the name of Google Inc. nor the names of its
# contributors may be used to endorse or promote products derived from
# this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# Sample gRPC server that implements the EchoWithoutProtobuf service.
#
# Usage: $ path/to/echo_server.rb

this_dir = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH.unshift(this_dir) unless $LOAD_PATH.include?(this_dir)

require 'grpc'
require 'echo_services_noprotobuf'

# EchoServer is simple server that implements the EchoWithoutProtobuf server.
class EchoServer < EchoWithoutProtobuf::Service
  # echo implements the EchoWithoutProtobuf 'Echo' rpc method.
  def echo(echo_req, _unused_call)
    echo_req
  end
end

# main starts an RpcServer that receives requests to EchoWithoutProtobuf at the sample
# server port.
def main
  s = GRPC::RpcServer.new
  s.add_http2_port('0.0.0.0:50051', :this_port_is_insecure)
  s.handle(EchoServer)
  s.run_till_terminated
end

main
