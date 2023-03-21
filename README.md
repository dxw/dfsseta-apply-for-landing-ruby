# The DfSSETA Apply for Landing Application

## Overview

The DfSSETA Apply for Landing application supports a fictional Apply for Landing service supplied by the (equally fictional) Department for Space Strategy and Extra-Terrestrial Affairs.

The non-fictional purpose of the application is to serve as a model application that provides a template for how services are designed and developed at dxw. The intention is to guide developers new to the organisation in the dxw approach to application development; to aid developers in honing their cross-language skills; to demonstrate the dxw approach to interested external parties; and to serve as a basis for experimentation and trying out new technologies and ideas in a principled and systematic way.

The fictional purpose is to allow pilots of interplanetary spacecraft to obtain landing permits for a variety of destinations (namely, moons and planets) within Earth's solar system.

### Language Note

The Apply for Landing application is intended to serve as a reference model instantiated in several different languages (namely Kotlin, C#, Javascript, Python, and Ruby). This repository contains the Ruby version of the application.

## Service Flow

Functionally, the Apply for Landing application user journey consists of the following steps:

1. A **start page** informs the user of the purpose of the application and the information they will need to supply in the course of completing it.
2. A spacecraft **pilot** selects a **destination** for their spacecraft journey. This destination must be a **Landable Body** (that is to say, a planet or a moon).
3. The pilot chooses an **arrival** and a **departure** date for their visit.
4. The pilot enters their **personal details** into the application, including their Pilot License Identifier
5. The user supplies information about the **spacecraft** they will be piloting, including their Spacecraft Registration Identifier
6. The completed application is then displayed in its entirety to allow the user to check for errors. At this point the user can either edit their answers or proceed to the next step.
7. The application issues a **landing permit** to the pilot.

Data validation is performed at each step, preventing the user from continuing until all information has been supplied in the correct format. As a result, Step 7 (approval) can be assumed to occur automatically once the first 6 steps are complete.

## Terminology

See [ADR 0012: Standard terminology for the Apply for Landing service](./doc/architecture/decisions/0012-standard-terminology.md-standard-terminology.md) for details of how we refer to the entities within this domain.

## Local development

For bundling JS and CSS you will need:

- `node` LTS (18.12.0)
- `yarn` used for managing JS packages rather than npm

The local development application is then run using `bin/dev` which asks `foreman` to run the app's `Procfile`.
