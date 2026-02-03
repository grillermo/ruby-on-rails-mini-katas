# README

For this kata you need to configure your rails application to ensure that
a heavy library is not loaded when the application runs but only after and
endpoint using is called. In this case the root / path should load slow but 
health check path /up shouldn't.

Change as little as possible, use rails features for this, do not touch the gem.

