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

This guide will walk you through installing and setting up Python on your system.

### Prerequisites

Ensure that the following are available on your system:

- **Operating System**: Windows, macOS, or Linux
- **Administrator Access**: Required to install and configure Python

### Steps to Install Python

#### 1. Download Python

Make sure you have Python 3.6 or later installed on your machine.. Visit the [official Python website](https://www.python.org/downloads/) to download the latest version of Python. Choose the version suitable for your operating system (Windows, macOS, Linux).

#### 2. Install Python

##### Windows:

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

### Features:

    - Web Testing
    - Robot framework
    - Page Object Design pattern
    - Screenshot in report for failed tests
    - Github actions

### Tech stacks:

    - https://www.python.org/
    - https://docs.robotframework.org
    - https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html

### Folder Structure:

```ini {"id":"01J7V7R99JVJ4XMX440G857VAS"}
├───.github
├───.vscode
├───configurations
├───resources
|   |───keywords
|   ├───page_object
|   ├───pages
|   └───test_data
├───results
├───tests
├───.gitignore
└───README.md


```