# SQL TRIGGERS FRO TEACHERS MANAGEMENT

## Overview

This project demonstrates SQL triggers for handling insert and delete operations on a teachers table, ensuring data integrity and logging actions.

## Features

* Table Creation: teachers table with fields id, name, subject, experience, and salary.
* Insert Trigger (Before Insert): Prevents negative salary values.
* Insert Trigger (After Insert): Logs insertion actions into teacher_log.
* Delete Trigger (Before Delete): Prevents deletion of teachers with experience greater than 10 years.
* Delete Trigger (After Delete): Logs deletion actions into teacher_log.

