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

   $json_obj = $zfssa->call('GET','/api/storage/v1/pools');
```

DEPENDENCIES:
   - LWP::UserAgent 
   - JSON
