# ps_log

logging processes' history for Linux

## Usage

Create directory.

    $ mkdir /path/to/log_dir

Set cron.

    */3 * * * * cd /path/to/log_dir && bash /path/to/ps_log.sh

## Easy Setup

    $ curl https://raw.githubusercontent.com/akagisho/ps_log/master/setup.sh | sudo bash
