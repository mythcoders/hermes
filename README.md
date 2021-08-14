# Hermes

Application (and API) for logging emails and sending them to [Amazon Web Services Simple Email Service (SES)](https://aws.amazon.com/ses/) for delivery.

MythCoders uses SES as a cost effective way to sent emails but the services unfortunately does not provide the ability to see a log of sent emails. Hermes fills that gap.

## Features

- Track email sending from multiple sources before sending to SES for delivery
- Use environments to apply rules when a client sends an email
- Easily see SMTP delivery results
- View when emails are opened and when links are clicked

## Software

Hermes is a Ruby on Rails application. The UI is built with [Halfmoon](https://www.gethalfmoon.com/)

## Licensing

See the [LICENSE](LICENSE) file for licensing information as it pertains to
files in this repository.
