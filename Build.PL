
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "Module::Build" => "0.3601"
  },
  "configure_requires" => {
    "ExtUtils::MakeMaker" => "6.30",
    "Module::Build" => "0.3601"
  },
  "dist_abstract" => "Construct portable filesystem paths in a simple way",
  "dist_author" => [
    "Michal Wojciechowski <odyniec\@cpan.org>"
  ],
  "dist_name" => "File-PlainPath",
  "dist_version" => "0.011",
  "license" => "perl",
  "module_name" => "File::PlainPath",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {},
  "script_files" => []
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
