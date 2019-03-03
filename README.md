bash-semver
===========

Version: 1.0.0

Increment semantic versioning strings in shell scripts.

```shell
$ ./increment_version.sh -h
usage: increment_version.sh [-hMmpt:]

$ ./increment_version.sh
0.0.0

$ ./increment_version.sh -p
0.0.1

$ ./increment_version.sh -m
0.1.0

$ ./increment_version.sh -M
1.0.0

$ ./increment_version.sh -Mmp
2.1.1

$ ./increment_version.sh -t dev
2.1.1-dev

$ ./increment_version.sh -p
2.1.2-dev

$ ./increment_version.sh -M -t edge
3.0.2-edge
```

The file .semver_files, store the list of your files containing a version string, and which need to be updated too.
