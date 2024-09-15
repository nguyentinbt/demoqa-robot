# Robot Framework Naming Convention Guide

This document outlines the naming conventions to be followed for files, folders, and test cases in Robot Framework projects. Consistent naming improves code readability, maintenance, and collaboration.

---

## Table of Contents

1. [General Guidelines](#general-guidelines)
2. [File Naming](#file-naming)
3. [Folder Naming](#folder-naming)
4. [Resource File Naming](#resource-file-naming)
5. [Variable File Naming](#variable-file-naming)
6. [Test Case Naming](#test-case-naming)
7. [Examples](#examples)

---

## General Guidelines

- Use lowercase letters for file and folder names.
- Use underscores (`_`) to separate words in file and folder names (snake_case) for clarity.
- Test case names should be descriptive and use natural language with spaces.
- Be consistent with naming to ensure ease of use and maintenance.

---

## File Naming

### Test Suite Files

- Use descriptive names that reflect the functionality being tested.
- Use lowercase letters with underscores (`_`) between words.
- File extensions: `.robot` or `.txt`.

**Examples:**

- `login_tests.robot`
- `user_registration.robot`
- `api_validation.robot`

### Resource Files

- Name resource files based on their purpose or the functionality they encapsulate.
- Use `.robot`, `.txt`, or `.resource` as the file extension.

**Examples:**

- `common_keywords.robot`
- `api_endpoints.resource`

### Variable Files

- Name variable files based on the type of data they contain.
- For Python-based variable files, use the `.py` extension.
- For Robot Framework variable files, use the `.robot` or `.txt` extension.

**Examples:**

- `environment_variables.py`
- `test_data.robot`

---

## Folder Naming

- Folder names should be descriptive of the test category or feature.
- Use lowercase letters with underscores (`_`) between words or use PascalCase for consistency.

**Examples:**

- `login_tests/`
- `user_management/`
- `data_driven_tests/`

---

## Test Case Naming

- Use natural language and descriptive names for test cases.
- Test case names should be written in title case with spaces between words.

**Examples:**

- `Login With Valid Credentials`
- `Verify User Registration Process`
- `API Returns 200 Status`

---

## Examples

### Example Project Structure:

```bash {"id":"01J7V6RVGPE0R09ZP7Q4KCT5ZT"}
DEMOQA-ROBOT/
│
├── login_tests/
│   ├── login_with_valid_credentials.robot
│   └── login_with_invalid_credentials.robot
│
├── user_management/
│   ├── user_registration.robot
│   ├── user_login.robot
│   └── user_profile.robot
│
├── resources/
│   ├── common_keywords.robot
│   └── api_endpoints.resource
│
├── variables/
│   ├── environment_variables.py
│   └── test_data.robot
│
└── README.md

```
