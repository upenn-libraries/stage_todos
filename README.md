# stage-todos

Script to stage arbitrary todo files to a destination folder for processing.

## Requires

Ruby version 2.3 or better. 

The script's use of the squiggly heredoc operator `<<~EOF ... EOF` will cause
parsing to fail for any earlier version of Ruby.

<https://infinum.co/the-capsized-eight/multiline-strings-ruby-2-3-0-the-squiggly-heredoc> 

## Usage

The output of command help:

    Usage: stage-todos [OPTIONS] {SOURCE_DIR|FILE...} DEST_DIR
        -b, --batch-size COUNT           Number of todo files to copy [default=5]; use ALL to copy all files.
        -p, --prefix WORD                Text to prefix to copied todo files [default=""]
        -x, --[no]-clobber               Overwrite existing todo files [default=false]
        -c, --case-sensitive             Destination filesystem is case sensitive [default=false]
        -h, --help                       Prints this help
        -H, --detailed-help              Print detailed help with examples

Stage a set of todo files to a directory for processing.

### Logging

Default log level is INFO. To change it, set `STAGE_TODOS_LOG_LEVEL` environment
variable; valid values are `FATAL`, `ERROR`, `WARN`, `INFO`, or `DEBUG`.

### Examples

Stage the first 10 todo files from '/mnt/share1/source' to '/mnt/share2/todo',
prefixing each copied file name with 'colenda_':

    $ stage-todos --batch-size 10 --prefix colenda_ /mnt/share1/source /mnt/share2/todo

Stage the all todo files from '/mnt/share1/source' to '/mnt/share2/todo':

    $ stage-todos --batch-size ALL /mnt/share1/source /mnt/share2/todo

Stage the first 5 (= default batch size) todo files matching 'W3*.todo' to
'/mnt/share2/todo':

    $ stage-todos -p openn_ /mnt/share1/source/W3*.todo /mnt/share2/todo

Stage 'W341.todo' and 'W342.todo' to '/mnt/share2/todo':

    $ stage-todos -p openn_ /mnt/share1/source/W341.todo /mnt/share1/source/W342.todo /mnt/share2/todo

### Running in production

This script can be run in production with Docker.  To deploy it, issue the following commands from within this repository's root directory:

```bash
$ cp .env.example .env
$ vi .env
```

Edit the file:

```bash
LOCAL_DESTINATION=x
LOCAL_OPENN_SOURCE=x
LOCAL_BULWARK_SOURCE=x
```

Where the environment variable match up to the following:

* `LOCAL_DESTINATION` - the directory on the host filesystem where todo files are to be staged
* `LOCAL_OPENN_SOURCE` - the directory on the host filesystem where the OPenn todo files are uploaded prior to running the script
* `LOCAL_BULWARK_SOURCE` - the directory on the host filesystem where the Bulwark todo files are uploaded prior to running the script 

Below are examples of running the script for Bulwark and OPenn respectively:

```bash
$ docker-compose run stage_todos ruby stage-todos --batch-size 10 /todos/bulwark/ /staged
$ docker-compose run stage_todos ruby stage-todos --batch-size 10 /todos/openn/ /staged
```