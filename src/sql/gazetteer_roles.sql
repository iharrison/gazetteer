﻿-- ###############################################################################
-- 
--  Copyright 2015 Crown copyright (c)
--  Land Information New Zealand and the New Zealand Government.
--  All rights reserved
-- 
--  This program is released under the terms of the new BSD license. See the 
--  LICENSE file for more information.
-- 
-- ###############################################################################


-- Roles for the gazetteer database

CREATE ROLE gaz_owner
  NOSUPERUSER NOINHERIT NOCREATEDB NOCREATEROLE;

CREATE ROLE gazetteer_dba
  NOSUPERUSER INHERIT NOCREATEDB CREATEROLE;

CREATE ROLE gazetteer_user
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE;

CREATE ROLE gazetteer_admin IN ROLE gazetteer_user
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE;

CREATE ROLE gaz_web_reader
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE;

CREATE ROLE gaz_web_admin
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE;

CREATE ROLE gaz_web_developer
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE;

CREATE ROLE gazetteer_export
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE;

GRANT gaz_web_admin TO gazetteer_dba;
GRANT gazetteer_admin TO gazetteer_dba;
GRANT gazetteer_user TO gazetteer_admin;

-- Login roles for web database access and web development
-- <passwords available in local repository only>

CREATE USER gaz_web IN ROLE gaz_web_reader ENCRYPTED PASSWORD '********';
CREATE USER gaz_web_dev IN ROLE gaz_web_reader, gaz_web_developer ENCRYPTED PASSWORD '********';

ALTER USER gaz_web SET search_path=gazetteer_web, public;
ALTER USER gaz_web_dev SET search_path=gazetteer_web, public;

CREATE ROLE gaz_web_logins
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE;

GRANT gaz_web_logins TO gaz_web;
GRANT gaz_web_logins TO gaz_web_dev;

