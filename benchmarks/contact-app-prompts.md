## Initial Prompts

```
Can you explain me Shape capabilities please?
```

```
OK. Lets start the first feature with Shape. Could you please proceed with outlining fully vertical hello world functionality, where the system gets the message from a variable, and then serves it through endpoint to the frontend? I am touching the architecture here a bit but basically to explain the fact that we are building a read only feature that cross cuts the app aspects to scaffold things.
```

```
Go ahead with the feature. After we have the hello world and the scaffolding available, I would like to proceed with the implementation of the actual functionality of a contact form:
* user provides name, email, and contact message
* submits when ready
* system validates the input
* system sends an email message to preconfigured email address

Touching a little bit on architecture and dev env setup, the email server should be configurable via env variables, for the development we should use dev email server that drops the received messages either to a file or to a console.
```