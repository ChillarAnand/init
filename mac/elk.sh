#!/usr/bin/env bash

set -ex

brew install logstash
brew install elasticsearch
brew install kibana

brew info elasticsearch
brew info logstash
brew info kibana

brew services start elasticsearch
brew services start logstash
brew services start kibana
