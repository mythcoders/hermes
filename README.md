# Hermes

Rails API for logging emails and then sending them to AWS Simple Email Service for delivery.
Supports multiple API clients and tracking emails sent by each client.

## Software

The UI is built with [Halfmoon](https://www.gethalfmoon.com/)

## Getting Started

Create a `Client` to receive an `key` and `secret` for calling the API. Separate approval is required before emails send
by your client application are actually sent to customers. Until then, email are rerouted to the applications owner.
This is handy for allowing emails in production to be sent out but reroute emails sent in testing environments.

A log of all emails sent is also kept.

## Message Structure

| Field         | Type     |
| ------------- | -------- |
| bcc           | string[] |
| cc            | string[] |
| environment\* | string   |
| from\*        | string   |
| html_body     | string   |
| subject\*     | string   |
| text_body     | string   |
| to\*          | string[] |

_\* denotes a required field_