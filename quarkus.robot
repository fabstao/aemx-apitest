*** Settings ***
Library    String
Library    REST          http://172.10.10.1:8788          ssl_verify=false

*** Test Cases ***
Fruits: Quantity
  GET         /fruits
  Integer     response status   200
  Array       $                 minItems=2    maxItems=10
  Output      $

Fruits: Schema
  GET         /fruits
  Integer     response status   200
  String      $[0].name         Apple
  Output      $
