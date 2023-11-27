# Neobis_iOS_WeatherApp

## Table of contents
* [Description](#description)
* [Getting started](#getting-started)
* [Usage](#usage)
* [Running the Tests](#running-the-tests)
* [Workflow](#workflow)
* [Design](#design)
  
## Description 

This is the sixth project in Neobis Club. On this time, project was connect with API and JSON, like how to call requests, what is JSON files and how to decode this files. Also for better understanding I use postman to check how calls working. 
API to this application was taken from http://api.openweathermap.org.

## Getting started 

- Make sure you have the XCode version 14.0 or above installed on your computer
- Download the project files from the repository
- Install CocoaPods
- Run pod install so you can install dependencies in your project (SnapKit & CSV)
- Open the project files in Xcode
- Run the active scheme by using any emulator

## Usage

This is Weather application. And when the user launched the app, he will see city and a lot information about weather from this location. And also at the bottom of the application, user can see temperature of the next 5 days of weather. By tapping search icon, user will see new view, where user can choose another city to display in main view.

## Running the Tests

Tested all possible API errors, such as invalid URL, response or data. The best method was to make this calls from postman, check that response code is 200. And URL always be valid because all possible cities in table view is taken from weather api.

## Workflow

- Reporting Bugs:
    If you come across any bugs while using this project, please report us by creating an issue on the Github repository
- Submitting pull requests:
    If you have a bug fix or a new feature for project, feel free to submit a pull request. Make sure that your changes are well-tested.
- Improving documentation:
    If you notice any errors or mistakes in the documentation, you can submit pull request with your changes
- Providing feedback:
    If you have any feedback, you can send an email to project maintainer

## Design

Below is a screenshot of how application looks like on iphone 14:

<img width="401" alt="Снимок экрана 2023-11-27 в 20 08 51" src="https://github.com/KryaKa57/Neobis_iOS_WeatherApp/assets/132449744/300baedf-4497-4ba6-9a4f-ebbd2cb35fc8">

<img width="400" alt="Снимок экрана 2023-11-27 в 20 09 18" src="https://github.com/KryaKa57/Neobis_iOS_WeatherApp/assets/132449744/1e255d80-8352-4425-af71-cef343ee0fd7">
<img width="406" alt="Снимок экрана 2023-11-27 в 20 09 36" src="https://github.com/KryaKa57/Neobis_iOS_WeatherApp/assets/132449744/127a86cb-158b-45c8-9b2a-e33c16e7848f">
