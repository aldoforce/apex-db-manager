apex-db-manager
===============

Apex database layer for managed packages to simplify and enforce FLS

## Overview

When writing a Managed Package, if you want to reach the AppExchange certified condition you will need to take special care with some code features like FLS.

Usually that requirement came up at the final stages of development and might have a several impact on the rollout date. Let me introduce this little DML class wrapper that enforce FLS with minimal impact on your code.

## Usage
1. Deploy this DB class into your packing/dev org
2. Search in your whole code base for insert/update/upsert DML operations and substitute them to use DB.inserter/DB.updater/DB.upserter. 
3. There is no step 3, just save everything and run your test cases

## Example
#### Original code
```java
Account a = new Account(
	name = 'Nakatomi Inc'
);
insert a;
```

#### Updated code enforcing FLS
```java
Account a = new Account(
	name = 'Nakatomi Inc'
);
DB.inserter(a);
```

## Quick Install
Use the Github Salesforce Deploy Tool link [here](https://githubsfdeploy.herokuapp.com/app/githubdeploy/aldoforce/apex-db-manager) while logged into your target org and follow instructions.
