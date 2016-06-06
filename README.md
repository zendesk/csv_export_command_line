:warning: *Use of this software is subject to important terms and conditions as set forth in the License file* :warning:

# CSV Export Command Line

## Description:

Command line tool to export tickets.

## Installation
1. Clone csv_export_command_line or download it as a zip.
2. Go into the csv_export_command_line directory (`cd PATH_TO_CSV_EXPORT_COMMAND_LINE`).
3. Run `bundle exec` to download/install the dependencies.

## Usage

You need to run it from the command line:
`bundle exec thor tickets:export --subdomain=ZENDESK_SUBDOMAIN --token=ZENDESK_TOKEN --username=ZENDESK_USERNAME`

## Options
```
  --subdomain=SUBDOMAIN        # Zendesk account/subdomain
  --username=USERNAME          # Zendesk API username
  --token=TOKEN                # Zendesk API token
  [--from=FROM]                # From which creation date (1 week ago from today's date). Format: YYYY-MM-DD
                               # Default: ON_WEEK_AGO
  [--to=TO]                    # To which creation date (Today's date). Format: YYYY-MM-DD
                               # Default: TODAY
  [--fields=FIELDS]            # Ticket fields to be exported
                               # Default: id,subject,description,status,group_id,requester_id,assignee_id,created_at
  [--output-path=OUTPUT_PATH]  # Where to save the csv file
                               # Default: HOME_PATH
```

## Screenshot(s):
* None

By downloading this tool, you are agreeing to our [terms and conditions](https://github.com/zendesklabs/wiki/wiki/Terms-and-Conditions)
