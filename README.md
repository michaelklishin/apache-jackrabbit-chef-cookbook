# Apache Jackrabbit Chef Cookbook

This is an OpsCode Chef cookbook that provisions Apache Jackrabbit.

It uses standalone Jackrabbit jar, provides init.d/Upstart service script and allows you to
choose installed version, OS user, host other parameters using Chef node attributes.


## Jackrabbit Version

This cookbook currently provides Jackrabbit version 2.4 but can be used
to install other versions by overriding data bag attributes.


## Recipes

Main recipe is `jackrabbit::standalone`.


## Attributes

All the attributes below are namespaced under `node[:jackrabbit]`, so `:version` is accessible
via `node[:jackrabbit][:version]` or `node.jackrabbit.version` and so on.

* `:version`: Jackrabbit version to install (default: `"2.4.1"`)
* `:installation_dir`: installation location (default: `"/usr/local/jackrabbit"`)
* `:user`: OS user Jackrabbit will be using (default: `"jackrabbit"`)
* `:host`: host Jackrabbit will listen on (default: `"127.0.0.1"`)
* `:port`: port Jackrabbit will listen on (default: `8080`)
* `:repository_dir`: Jackrabbit repository directory path (default: `/var/lib/jackrabbit/repository`)


## Dependencies

One of: OpenJDK 7, Oracle JDK7, OpenJDK 6 or Sun JDK 6.


## Copyright & License

Michael S. Klishin, 2012.

Released under the [Apache 2.0 license](http://www.apache.org/licenses/LICENSE-2.0.html).
