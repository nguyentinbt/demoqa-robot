*** Settings ***
Documentation       Global configuration variables

Library             String
Library             Collections
Library             OperatingSystem
Library             SeleniumLibrary


*** Variables ***
# Server and domain info
${BASE_URL}                 https://demoqa.com
${PRACTICE_FORM}            http://${BASE_URL}/automation-practice-form

# User info
${ADMIN USER}           robot00058@wsvietnam.com
${ADMIN PASSWORD}       Robot@123456
${NORMAL USER}          robot00058@wsvietnam.com
${NORMAL PASSWORD}      Robot@123456

# System
${BROWSER}              Chrome
${DELAY}                0
${RETRY}                3x
${INTERVAL_SHORT}             2s
${INTERVAL_MEDIUM}             5s
${INTERVAL_LONG}             10s
