# Tarkov Prime Bot

This is a Discord bot that allows you to lookup flea market prices with your voice. [Small demo](https://twitter.com/romanbb/status/1550151741034729473).

## How it works

The bot listens and transcribes all text spoken by any user who starts the bot command. Then that transcribed text is processed in the bot and matched against some pattern, like `price check <item>`. Then `<item>` is looked up on Tarkov-Market and the bot spits out some useful information from there. Along with a shorter TTS message played in the channel.

## Vocabulary

This is what makes this work. There's a file `support/transcribe_vocab.txt` that contains all the mappings for Amazon Transcribe. The vocab name is hardcoded to `tarkov` for now, you should update yours accordingly.

There's a helper script you can run to push updates to AWS.

         npm run update-vocab

Make sure you check the status afterwords to see if there are any parsing failures. It needs to follow [these guidelines](https://docs.aws.amazon.com/transcribe/latest/dg/custom-vocabulary-create-table.html).

If you plan to contribute to this list, please reach out to me and I can give you access to a master spreadsheet with items catagorized by sheets. There's an export script that generates `support/transcribe_vocab.txt`.

## Run it yourself

## Setup AWS

In order to use AWS Polly and Transcribe, you will need to do the following:

1. Create a new AWS IAM user with access to the Polly and Transcribe services
2. Add your access and secret access keys to the `.env.dev` file
3. Create an S3 bucket and upload the `support/transcribe_vocab.txt` file to it with npm scripts
   1. `npm i`
   2. `npm run upload-s3-vocab`
   3. `npm run create-vocab` (make sure to edit your `package.json` to point to your S3 bucket)

These steps will at least get your S3 env setup so you can transcribe messages

### Commands

You first need to !deploy the bot. Only the owner of the app can deploy it. It will try to auto-deploy if you have the guild id configured.

1. `/join` to join your voice channel.
2. `/start` to tell the bot to start recording you. It's opt-in.

3. `/stop` stop listening
4. `/leave` leave the voice channel
5. `/check` do a text-based lookup

### Requirements

1. Basic knowledge of
   - Node
   - TypeScript
   - AWS
2. AWS Account (this will cost based on usage)
   1. Amazon Transcribe
   1. Amazon Polly - TTS
   1. S3: for storing/loading vocab model for Transcribe
3. Your own Discord App ID

### Flea Market Data

Currently two sources available. By default it will use [tarkov.dev](https://tarkov.dev). But it also has support for [Tarkov-Market](https://tarkov-market.com), but you need to have an API key to use Tarkov-Market, which costs $5/mo.

### Run Locally

#### Dev Mode

Runs with `.env.dev` vars. Has ability to auto-join and start recording a preset user in a preset guild, outputing to a preset channel based on the environment variables.

This wll build and run the service.

      npm run dev

#### Prod mode

Just runs with node in prod environmment with `.env` loaded. Doesn't build.

      ```bash
      npm run prod
      ```

### Deploy

I am trying [fly.io](https://fly.io) to host this right now. You can deploy with:

      ```bash
      npm run deploy
      ```

### Secrets & Credentials

All secrets will be stored in `.env`/`.env.dev` file.

For development the `.env.dev` file is used instead. For full reference of all the variables check out `src/config.env.ts`.

## TODO

- Finish adding item voice models!
- Session persistence (for seamless redeploys?)
