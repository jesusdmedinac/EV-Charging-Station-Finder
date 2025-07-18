# Findings

This document will contain the findings of the take-home coding challenge.

## Using .xcconfig files for API keys

I created a `Secrets.xcconfig` file to store the API key for the OpenChargeMap API. This file is added to the `.gitignore` file to prevent it from being committed to the repository.

In order to correctly access the API key value I follow [Using .xcconfig files the right way for API Keys in an iOS app](https://moinulhassan.medium.com/read-variables-from-env-file-to-xcconfig-files-for-different-schemes-in-xcode-3ef977a0eef8) tutorial.