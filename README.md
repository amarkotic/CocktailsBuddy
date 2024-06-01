# CocktailsBuddy
Project built in 05/24. Detailed instructions can be found [here](https://github.com/amarkotic/CocktailsBuddy/blob/develop/Task.md).

## Table of contents
  * [Usage](#usage)
  * [Bonus features](#bonus-features)
  * [Architecture](#architecture)
    
# Usage

https://github.com/amarkotic/CocktailsBuddy/assets/40775323/d2ab0bec-2222-4d14-9fae-9513a4c4133a


# Bonus features
**• Loading states** using Result type

![loading](https://github.com/amarkotic/CocktailsBuddy/assets/40775323/5c51babf-c879-40ea-a72a-bacf35b0b679)

**• Local database** persistence implemented with **Realm**

![persistance](https://github.com/amarkotic/CocktailsBuddy/assets/40775323/bf30e8cf-1166-4177-9b19-6e4c136ba674)

- Cocktail details fetched while a user has internet access are stored to a local database so they are accessible later on without internet access.

**• Push Notifications** to increase user engagement 

![push notif](https://github.com/amarkotic/CocktailsBuddy/assets/40775323/d3df1f13-5430-4a7e-84b8-f837c77e8b52)

- If the user has checked out any cocktail and persisted it locally, he will get a daily reminder about one random cocktail he previously opened.

# Architecture

## Modularized the app using SPM
Motivation - reduce build times and showcase a project setup for unlimited feature growth

![SPM](https://github.com/amarkotic/CocktailsBuddy/assets/40775323/ff032a90-e446-46f1-9558-4310c3e3be22)

- **Core** module is the main module which contains shared code across the app - extensions, logger service, etc.

- **CoreUI** module can use functionalities from Core and create UI related shared code. For instance: PrimaryButton, NavigationBar, SearchBar, etc.

- **Networking** module is used specificaly for network requests. It can be imported in any new feature module

- **Cocktails** module is at the moment the only feature module. Unlimited number of feature modules can now be added, handle their feature-related logic and use shared code from upper modules.

- **Important:** Modules are allowed to only import modules which are higher in the hierarchy to avoid circular dependencies


## **Uncle's Bob Clean Architecture** 
Motivation - follow SOC and SOLID rules by utilising **Singletons** and **Dependency injection** design patterns

![Clean](https://github.com/amarkotic/CocktailsBuddy/assets/40775323/783dc0c9-70bf-445d-afc6-7184c89aa79a)

- Separate Feature module to layers following Clean architecture rules.

- Inject lower components to higher ones using dependency injection. Data source and domain layers should be created as singletons and their one instance should be used during the lifecycle of the app.

## MVVM + SwiftUI + Combine
Motivation - use a declarative modern approach to build Presentation layer effectively and take advantage of the reactive paradigm with combine to sink data from business layer fast

![Combine](https://github.com/amarkotic/CocktailsBuddy/assets/40775323/d1ecc64c-ffa7-47e0-91a8-320228058003)


## Coordinator pattern
Motivation - take advantage of UIKit's navigation while at the same time using SwiftUI views wrapped in **UIHostingViewController**

![coordinator](https://github.com/amarkotic/CocktailsBuddy/assets/40775323/b1fa519b-3f9d-4b78-b261-8590bdcbbc84)

- Main coordinator is responsible for handling communication between many feature coordinators - which is currently only one - CocktailsCoordinator

## Unit and UI tests
Motivation - ensure lasting code quality

### [Trello board](https://trello.com/b/RYWeeNYF/coctails-app)

