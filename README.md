<h2 align="center"> Python and Robot Framework with Selenium Setup </h2>

### Requirements:

[![NodeJs](https://img.shields.io/badge/-NodeJS%20v12%20OR%20later-%23339933?logo=npm)](https://nodejs.org/en/download/)
[![Java](https://img.shields.io/badge/-JDK-%23007396?logo=java&logoColor=black&)](https://www.oracle.com/java/technologies/downloads/)
[![Docker](https://img.shields.io/badge/-Docker-0db7ed?logo=docker&logoColor=white)](https://docs.docker.com/engine/install/)
[![VSCode](https://img.shields.io/badge/-Visual%20Studio%20Code-%233178C6?logo=visual-studio-code)](https://code.visualstudio.com/download)
[![Appium-Inspector](https://img.shields.io/badge/-Appium%20Inspector-662d91?logo=appium&logoColor=black)](https://github.com/appium/appium-inspector/releases)
[![AndroidStudio](https://img.shields.io/badge/-Android%20Studio-3DDC84?logo=android-studio&logoColor=white)](https://developer.android.com/studio)
[![Static Badge](https://img.shields.io/badge/build-passing-brightgreen)](https://developer.android.com/studio)

### Getting Started:

Clone Repository

```bash {"id":"01J7V7R99JVJ4XMX43ZJ7Q2NZW"}
1. git clone https://github.com/nguyentinbt/demoqa-robot.git
2. Navigate to `demoqa-robot`

```

### Python setup

This guide will help you set up Python, Robot Framework, and the Selenium library for testing automation.

#### Prerequisites

Make sure you have Python 3.6 or later installed on your machine. You can download it from [Python's official website](https://www.python.org/downloads/).

# Python Setup Guide

This guide will walk you through installing and setting up Python on your system.

## Prerequisites

Ensure that the following are available on your system:

- **Operating System**: Windows, macOS, or Linux
- **Administrator Access**: Required to install and configure Python

## Steps to Install Python

### 1. Download Python

Visit the [official Python website](https://www.python.org/downloads/) to download the latest version of Python. Choose the version suitable for your operating system (Windows, macOS, Linux).

### 2. Install Python

#### Windows:

1. Run the downloaded installer.
2. **Important:** Check the box that says "Add Python to PATH".
3. Click **Install Now** and follow the instructions.

#### macOS:

1. Open the downloaded `.pkg` file and follow the installation steps.
2. Python will automatically be added to your PATH.

#### Linux:

Use the package manager specific to your distribution to install Python. For example, on Ubuntu, run the following command:

```bash {"id":"01J7V9YWD83109BBB084QCHX4W"}
sudo apt update
sudo apt install python3 python3-pip

### Running Tests

#### User interactive CLI

```sh {"id":"01J7V7R99JVJ4XMX43ZSJ8VZ5W"}
npm start

```

To verify if Python is installed, run:

```bash {"id":"01J7VAJF8VKCSTK4KC9DVSV463"}
python --version

```

#### Install Robot Framework globally

```bash {"id":"01J7V7R99JVJ4XMX4401GP2VM6"}
pip install robotframework
robot --version
```

#### Install Selenium Library

```sh {"id":"01J7V7R99JVJ4XMX4404MTS8NV"}
pip install --upgrade robotframework-seleniumlibrary
```

#### Run the test in local

```sh {"id":"01J7VAR43C6J66F1REB0XFXE4C"}
robot --outputdir results tests/
```

#### Generate Report

```sh {"id":"01J7V7R99JVJ4XMX4407CG967T"}
npm run report:mocha
npm run report:cucumber
npm run report-mobile

```

Report Paths:

```sh {"id":"01J7V7R99JVJ4XMX4409TMG52G"}
mocha: mochawesome-report/mochawesome-report.html
cucumber: reports/cucumber/cucumber-report.html
api: reports/api/mochawesome.html
mobile: reports/mobile/mobile.html

```

#### Send Report

```sh {"id":"01J7V7R99JVJ4XMX440DBDPSG0"}
update .env file with Sender email, password and recipients email list
npm run mailCucumberReport

```

### Features:

    - Web, Mobile and API Testing
    - Mocha and Cucumber BDD framework
    - Page Object Design pattern
    - Docker integration
    - Parallel execution
    - Cross browser testing
    - Retry failed test
    - Screenshot in report for failed tests
    - Download chromedriver from local path
    - Github actions
    - Send test report to list of Gmail

### Tech stacks:

[![WebdriverIO](https://img.shields.io/badge/-WebdriverI/O-EA5906?logo=WebdriverIO&logoColor=white)](https://webdriver.io/)
[![TypeScript](https://img.shields.io/badge/-TypeScript-%233178C6?logo=Typescript&logoColor=black)](https://www.typescriptlang.org/)
[![Mocha](https://img.shields.io/badge/-Mocha-%238D6748?logo=Mocha&logoColor=white)](https://mochajs.org/)
[![CucumberIO](https://img.shields.io/badge/-Cucumber.io-brightgreen?logo=cucumber&logoColor=white)](https://cucumber.io/)
[![ChaiJS](https://img.shields.io/badge/-ChaiJS-FEDABD?logo=Chai&logoColor=black)](https://www.chaijs.com/)
[![SuperTest](https://img.shields.io/badge/-SuperTest-07BA82?logoColor=white)](https://github.com/visionmedia/supertest)
[![Enquirer](https://img.shields.io/badge/-Enquirer-f0db4f?logoColor=white)](https://github.com/enquirer/enquirer)
[![Docker](https://img.shields.io/badge/-Docker-0db7ed?logo=docker&logoColor=white)](https://www.docker.com/)
[![Appium](https://img.shields.io/badge/-Appium-662d91?logo=appium&logoColor=black)](https://github.com/appium/appium)
[![Node-Mailer](https://img.shields.io/badge/-Node%20Mailer-89D05C?logo=gmail&logoColor=blue)](https://github.com/nodemailer/nodemailer)

### Folder Structure:

```ini {"id":"01J7V7R99JVJ4XMX440G857VAS"}
├───.github
├───.vscode
├───src
|   ├───api (api test and configs)
|   ├───mobile (mobiel test and configs)
|   └───web
|       ├───config (wdio config files)
|       ├───executables
|       ├───generator
|       ├───pages
|       ├───resources
|       ├───static
|       ├───tests
|       │     ├───cucumber
|       │     └───mocha
|       ├───types
|       └───Utils
|
├───.env
├───.gitignore
├───docker-compose.yml
├───LICENSE
├───package-lock.json
├───package.json
├───README.md
├───runner.ts
└───tsconfig.json

```

### Manage browser driver:

Usually inside corporate network exe files download from external sites are blocked.
When we try to download the drivers it might fail, in that case we can maintain drivers
locally and install as custom path.

```bash {"id":"01J7V7R99JVJ4XMX440JGC6QJC"}
Download the latest driver from 'https://chromedriver.chromium.org/downloads'
Place the the 'chromedriver_win32.zip' file inside src/executables/drivers
execute 'installchromedriver.bat' file to dowload the driver from placed folder

```

### Sample Report

![SampleReports](https://user-images.githubusercontent.com/65847528/144699948-507b314e-9639-450c-b127-fb9b0721a2d8.gif)

### Sample Email

<img src="https://user-images.githubusercontent.com/94898700/168330995-09d88ed8-f916-493f-a43b-19b6ca58df0b.png" alt="sample report" width="400"/>
<!-- ![sample_email](https://user-images.githubusercontent.com/94898700/168330995-09d88ed8-f916-493f-a43b-19b6ca58df0b.png) -->

# WebdriverIOE2E