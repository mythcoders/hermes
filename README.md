# Hermes

Hermes is a Rails application with API for sending emails to a separate SMTP service.

Upon registering, Clients receive an `api secret` and an `api key` to begin calling the API.
Separate approval is required before emails send by your application are actually sent to customers.
Until then, email are rerouted to the applications owner. This is handy for allowing emails in production
to be sent out but reroute emails sent in testing environments.

A log of all emails sent is also kept.

## Software

The UI is built with [Halfmoon](https://www.gethalfmoon.com/)

## Planned Features

- Delivery and read reports
- Header and footer templates
- Mail-merge
- Other forms of communication like SMS

## Message Structure

| Field         | Type     |
| ------------- | -------- |
| from\*        | string   |
| to\*          | string[] |
| cc            | string[] |
| bcc           | string[] |
| subject\*     | string   |
| html_body     | string   |
| text_body     | string   |
| environment\* | string   |

_\* denotes a required field_