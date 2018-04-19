# Oracle-ZFSSA-Client - Oracle ZFS Storage Appliance RESTful API Connector

[![Build Status](https://travis-ci.org/whindsx/Oracle-ZFSSA-Client.svg?branch=master)](https://travis-ci.org/whindsx/Oracle-ZFSSA-Client)

A Perl module for connecting to Oracle ZFS Storage Appliance RESTful API.

Return values are Perl JSON structures.

SYNOPSIS:
```perl

   use Oracle::ZFSSA::Client;

   $zfssa = new Oracle::ZFSSA::Client(
      user => $user,
      password => $password,
      host => "your.appliance.org"
   );

   $json_param = {
      your => 'params',
      but  => 'not required',
   };

   $json_result = $zfssa->call('POST','/api/storage/v1/method',$json_param);
```

DEPENDENCIES:
   - LWP::UserAgent
   - JSON

INSTALL:
   - Source
      - perl Makefile.PL
      - make
      - make test
      - make install
