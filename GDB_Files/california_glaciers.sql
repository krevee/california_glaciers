-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.2_snapshot20190921
-- PostgreSQL version: 11.0
-- Project Site: pgmodeler.io
-- Model Author: ---

-- object: rds_iam | type: ROLE --
-- DROP ROLE IF EXISTS rds_iam;
CREATE ROLE rds_iam WITH 
	INHERIT
	ENCRYPTED PASSWORD '********';
-- ddl-end --

-- object: rds_ad | type: ROLE --
-- DROP ROLE IF EXISTS rds_ad;
CREATE ROLE rds_ad WITH 
	INHERIT
	ENCRYPTED PASSWORD '********';
-- ddl-end --

-- object: cvanschoonhoven | type: ROLE --
-- DROP ROLE IF EXISTS cvanschoonhoven;
CREATE ROLE cvanschoonhoven WITH 
	CREATEDB
	CREATEROLE
	INHERIT
	LOGIN
	ENCRYPTED PASSWORD '********';
-- ddl-end --

-- object: rdsrepladmin | type: ROLE --
-- DROP ROLE IF EXISTS rdsrepladmin;
CREATE ROLE rdsrepladmin WITH 
	REPLICATION
	ENCRYPTED PASSWORD '********';
-- ddl-end --

-- -- object: rdsadmin | type: ROLE --
-- -- DROP ROLE IF EXISTS rdsadmin;
-- CREATE ROLE rdsadmin WITH 
-- 	SUPERUSER
-- 	CREATEDB
-- 	CREATEROLE
-- 	INHERIT
-- 	LOGIN
-- 	REPLICATION
-- 	BYPASSRLS
-- 	ENCRYPTED PASSWORD '********';
-- -- ddl-end --
-- 
-- object: rds_superuser | type: ROLE --
-- DROP ROLE IF EXISTS rds_superuser;
CREATE ROLE rds_superuser WITH 
	INHERIT
	ENCRYPTED PASSWORD '********'
	ROLE cvanschoonhoven;
-- ddl-end --

-- object: rds_replication | type: ROLE --
-- DROP ROLE IF EXISTS rds_replication;
CREATE ROLE rds_replication WITH 
	INHERIT
	ENCRYPTED PASSWORD '********'
	ADMIN rds_superuser;
-- ddl-end --

-- object: rds_password | type: ROLE --
-- DROP ROLE IF EXISTS rds_password;
CREATE ROLE rds_password WITH 
	INHERIT
	ENCRYPTED PASSWORD '********'
	ADMIN rds_superuser;
-- ddl-end --

-- object: chase | type: ROLE --
-- DROP ROLE IF EXISTS chase;
CREATE ROLE chase WITH 
	CREATEDB
	CREATEROLE
	INHERIT
	LOGIN
	ENCRYPTED PASSWORD '********';
-- ddl-end --

-- object: chase_cp | type: ROLE --
-- DROP ROLE IF EXISTS chase_cp;
CREATE ROLE chase_cp WITH 
	CREATEDB
	CREATEROLE
	INHERIT
	LOGIN
	ENCRYPTED PASSWORD '********';
-- ddl-end --


-- Database creation must be done outside a multicommand file.
-- These commands were put in this file only as a convenience.
-- -- object: california_glaciers | type: DATABASE --
-- -- DROP DATABASE IF EXISTS california_glaciers;
-- CREATE DATABASE california_glaciers
-- 	ENCODING = 'UTF8'
-- 	LC_COLLATE = 'en_US.UTF-8'
-- 	LC_CTYPE = 'en_US.UTF-8'
-- 	TABLESPACE = pg_default
-- 	OWNER = cvanschoonhoven;
-- -- ddl-end --
-- 

-- -- object: public.geometry | type: TYPE --
-- -- DROP TYPE IF EXISTS public.geometry CASCADE;
-- CREATE TYPE public.geometry;
-- -- ddl-end --
-- 
-- object: postgis | type: EXTENSION --
-- DROP EXTENSION IF EXISTS postgis CASCADE;
CREATE EXTENSION postgis
WITH SCHEMA public
VERSION '2.5.2';
-- ddl-end --
COMMENT ON EXTENSION postgis IS E'PostGIS geometry, geography, and raster spatial types and functions';
-- ddl-end --

-- object: public.ca_counties_gid_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.ca_counties_gid_seq CASCADE;
CREATE SEQUENCE public.ca_counties_gid_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;
-- ddl-end --
ALTER SEQUENCE public.ca_counties_gid_seq OWNER TO cvanschoonhoven;
-- ddl-end --

-- object: public.ca_counties | type: TABLE --
-- DROP TABLE IF EXISTS public.ca_counties CASCADE;
CREATE TABLE public.ca_counties (
	gid integer NOT NULL DEFAULT nextval('public.ca_counties_gid_seq'::regclass),
	statefp character varying(2),
	countyfp character varying(3),
	countyns character varying(8),
	geoid character varying(5),
	name character varying(100),
	namelsad character varying(100),
	lsad character varying(2),
	classfp character varying(2),
	mtfcc character varying(5),
	csafp character varying(3),
	cbsafp character varying(5),
	metdivfp character varying(5),
	funcstat character varying(1),
	aland double precision,
	awater double precision,
	intptlat character varying(11),
	intptlon character varying(12),
	geom public.geometry,
	CONSTRAINT ca_counties_pkey PRIMARY KEY (gid)

);
-- ddl-end --
ALTER TABLE public.ca_counties OWNER TO cvanschoonhoven;
-- ddl-end --

-- object: ca_counties_geom_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.ca_counties_geom_idx CASCADE;
CREATE INDEX ca_counties_geom_idx ON public.ca_counties
	USING gist
	(
	  geom
	)
	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: public.ca_places_gid_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.ca_places_gid_seq CASCADE;
CREATE SEQUENCE public.ca_places_gid_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;
-- ddl-end --
ALTER SEQUENCE public.ca_places_gid_seq OWNER TO cvanschoonhoven;
-- ddl-end --

-- object: public.ca_places | type: TABLE --
-- DROP TABLE IF EXISTS public.ca_places CASCADE;
CREATE TABLE public.ca_places (
	gid integer NOT NULL DEFAULT nextval('public.ca_places_gid_seq'::regclass),
	statefp character varying(2),
	placefp character varying(5),
	placens character varying(8),
	geoid character varying(7),
	name character varying(100),
	namelsad character varying(100),
	lsad character varying(2),
	classfp character varying(2),
	pcicbsa character varying(1),
	pcinecta character varying(1),
	mtfcc character varying(5),
	funcstat character varying(1),
	aland double precision,
	awater double precision,
	intptlat character varying(11),
	intptlon character varying(12),
	geom public.geometry,
	CONSTRAINT ca_places_pkey PRIMARY KEY (gid)

);
-- ddl-end --
ALTER TABLE public.ca_places OWNER TO cvanschoonhoven;
-- ddl-end --

-- object: ca_places_geom_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.ca_places_geom_idx CASCADE;
CREATE INDEX ca_places_geom_idx ON public.ca_places
	USING gist
	(
	  geom
	)
	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: public.wbdhu6_gid_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.wbdhu6_gid_seq CASCADE;
CREATE SEQUENCE public.wbdhu6_gid_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;
-- ddl-end --
ALTER SEQUENCE public.wbdhu6_gid_seq OWNER TO cvanschoonhoven;
-- ddl-end --

-- object: public.wbdhu6 | type: TABLE --
-- DROP TABLE IF EXISTS public.wbdhu6 CASCADE;
CREATE TABLE public.wbdhu6 (
	gid integer NOT NULL DEFAULT nextval('public.wbdhu6_gid_seq'::regclass),
	objectid bigint,
	tnmid character varying(40),
	metasource character varying(40),
	sourcedata character varying(100),
	sourceorig character varying(130),
	sourcefeat character varying(40),
	loaddate date,
	gnis_id bigint,
	areaacres numeric,
	areasqkm numeric,
	states character varying(50),
	huc6 character varying(6),
	name character varying(120),
	shape_leng numeric,
	shape_area numeric,
	geom public.geometry,
	CONSTRAINT wbdhu6_pkey PRIMARY KEY (gid)

);
-- ddl-end --
ALTER TABLE public.wbdhu6 OWNER TO cvanschoonhoven;
-- ddl-end --

-- object: wbdhu6_geom_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.wbdhu6_geom_idx CASCADE;
CREATE INDEX wbdhu6_geom_idx ON public.wbdhu6
	USING gist
	(
	  geom
	)
	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: public.glac_regions_gid_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.glac_regions_gid_seq CASCADE;
CREATE SEQUENCE public.glac_regions_gid_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;
-- ddl-end --
ALTER SEQUENCE public.glac_regions_gid_seq OWNER TO cvanschoonhoven;
-- ddl-end --

-- object: public.glac_regions | type: TABLE --
-- DROP TABLE IF EXISTS public.glac_regions CASCADE;
CREATE TABLE public.glac_regions (
	gid integer NOT NULL DEFAULT nextval('public.glac_regions_gid_seq'::regclass),
	id integer,
	mtnregion character varying(50),
	geom public.geometry,
	CONSTRAINT glac_regions_pkey PRIMARY KEY (gid)

);
-- ddl-end --
ALTER TABLE public.glac_regions OWNER TO cvanschoonhoven;
-- ddl-end --

-- object: glac_regions_geom_idx | type: INDEX --
-- DROP INDEX IF EXISTS public.glac_regions_geom_idx CASCADE;
CREATE INDEX glac_regions_geom_idx ON public.glac_regions
	USING gist
	(
	  geom
	)
	WITH (FILLFACTOR = 90);
-- ddl-end --

-- object: public.people | type: TABLE --
-- DROP TABLE IF EXISTS public.people CASCADE;
CREATE TABLE public.people (
	contact_id integer NOT NULL,
	surname text,
	givennames text,
	prof_title text,
	affiliation text,
	department text,
	address1 text,
	address2 text,
	city text,
	state_province text,
	postal_code text,
	country_code char(2),
	office_loc text,
	url_primary text,
	url_secondary text,
	workphone_primary text,
	workphone_secondary text,
	workfax text,
	homephone text,
	mobilephone text,
	email_primary text,
	email_secondary text,
	comment text,
	CONSTRAINT people_pk PRIMARY KEY (contact_id)

);
-- ddl-end --
ALTER TABLE public.people OWNER TO postgres;
-- ddl-end --

-- object: public.regional_center | type: TABLE --
-- DROP TABLE IF EXISTS public.regional_center CASCADE;
CREATE TABLE public.regional_center (
	rc_id integer NOT NULL,
	parent_rc integer,
	main_contact integer,
	url_primary text,
	url_secondary text,
	rc_poly polygon,
	CONSTRAINT "regional_Center_pk" PRIMARY KEY (rc_id)

);
-- ddl-end --
ALTER TABLE public.regional_center OWNER TO postgres;
-- ddl-end --

-- object: public.glaciers_static | type: TABLE --
-- DROP TABLE IF EXISTS public.glaciers_static CASCADE;
CREATE TABLE public.glaciers_static (
	glacier_id varchar(20),
	glacier_name text,
	glims_id varchar(14),
	wgi_id varchar(20),
	rgi_id varchar(20),
	nhd_id varchar(36),
	gnis_id varchar(8),
	recno varchar(3),
	parent_icemass_id varchar(20),
	glac_status varchar(20)
);
-- ddl-end --
ALTER TABLE public.glaciers_static OWNER TO postgres;
-- ddl-end --

-- object: public.submission_info | type: TABLE --
-- DROP TABLE IF EXISTS public.submission_info CASCADE;
CREATE TABLE public.submission_info (
	gid integer NOT NULL,
	org_name character varying(100),
	org_abrv character varying(10),
	org_url text,
	contributor character varying(30),
	sdate date,
	sid character varying(15) NOT NULL,
	CONSTRAINT data_source_gid_pk PRIMARY KEY (gid,sid),
	CONSTRAINT data_source_sid_un UNIQUE (sid)

);
-- ddl-end --
ALTER TABLE public.submission_info OWNER TO chase;
-- ddl-end --

-- object: public.attachments | type: TABLE --
-- DROP TABLE IF EXISTS public.attachments CASCADE;
CREATE TABLE public.attachments (

);
-- ddl-end --
ALTER TABLE public.attachments OWNER TO postgres;
-- ddl-end --

-- object: public.glims_polygons_gid_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.glims_polygons_gid_seq CASCADE;
CREATE SEQUENCE public.glims_polygons_gid_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;
-- ddl-end --
ALTER SEQUENCE public.glims_polygons_gid_seq OWNER TO chase;
-- ddl-end --

-- object: public.glaciers_variable | type: TABLE --
-- DROP TABLE IF EXISTS public.glaciers_variable CASCADE;
CREATE TABLE public.glaciers_variable (
	gid integer NOT NULL DEFAULT nextval('public.glims_polygons_gid_seq'::regclass),
	line_type character varying(20),
	glac_id character varying(20) NOT NULL,
	area numeric,
	db_area numeric,
	min_elev numeric,
	max_elev numeric,
	glac_name character varying(28),
	glac_stat character varying(20),
	geog_area character varying(20),
	geom geometry,
	in_county text,
	in_basin text,
	fcode integer DEFAULT 37800,
	fdate date,
	sid character varying(15),
	CONSTRAINT glims_polygons_pkey PRIMARY KEY (gid),
	CONSTRAINT glaciers_glac_id_un UNIQUE (glac_id)

);
-- ddl-end --
COMMENT ON TABLE public.glaciers_variable IS E'Author: Chase VanSchoonhoven\nDate Created: 04/07/2018\nDescription: \n\nGlacier polygons of Glaciers located within the Sierra Nevada Mountain range.\n\nGlacier data based off of the World Glacier Inventory (WGI) which contains information for over 130,000 glaciers. Inventory parameters include geographic location, area, length, orientation, elevation, and classification. The WGI is based primarily on aerial photographs and maps with most glaciers having one data entry only. Hence, the dataset can be viewed as a snapshot of the glacier distribution in the second half of the 20th century. It is based on the original WGI (WGMS 1989) from the World Glacier Monitoring Service (WGMS).\n\nSource: WGMS, and National Snow and Ice Data Center (comps.). 1999, updated 2012. World Glacier Inventory, Version 1. [Indicate subset used]. Boulder, Colorado USA. NSIDC: National Snow and Ice Data Center. doi: https://doi.org/10.7265/N5/NSIDC-WGI-2012-02. [Date Accessed].';
-- ddl-end --
COMMENT ON CONSTRAINT glims_polygons_pkey ON public.glaciers_variable  IS 'Author: Chase VanSchoonhoven
Date Created: 04/07/2018
Description: 

Glacier polygons of Glaciers located within the Sierra Nevada Mountain range.

Glacier data based off of the World Glacier Inventory (WGI) which contains information for over 130,000 glaciers. Inventory parameters include geographic location, area, length, orientation, elevation, and classification. The WGI is based primarily on aerial photographs and maps with most glaciers having one data entry only. Hence, the dataset can be viewed as a snapshot of the glacier distribution in the second half of the 20th century. It is based on the original WGI (WGMS 1989) from the World Glacier Monitoring Service (WGMS).

Source: WGMS, and National Snow and Ice Data Center (comps.). 1999, updated 2012. World Glacier Inventory, Version 1. [Indicate subset used]. Boulder, Colorado USA. NSIDC: National Snow and Ice Data Center. doi: https://doi.org/10.7265/N5/NSIDC-WGI-2012-02. [Date Accessed].';
-- ddl-end --
COMMENT ON CONSTRAINT glaciers_glac_id_un ON public.glaciers_variable  IS 'Author: Chase VanSchoonhoven
Date Created: 04/07/2018
Description: 

Glacier polygons of Glaciers located within the Sierra Nevada Mountain range.

Glacier data based off of the World Glacier Inventory (WGI) which contains information for over 130,000 glaciers. Inventory parameters include geographic location, area, length, orientation, elevation, and classification. The WGI is based primarily on aerial photographs and maps with most glaciers having one data entry only. Hence, the dataset can be viewed as a snapshot of the glacier distribution in the second half of the 20th century. It is based on the original WGI (WGMS 1989) from the World Glacier Monitoring Service (WGMS).

Source: WGMS, and National Snow and Ice Data Center (comps.). 1999, updated 2012. World Glacier Inventory, Version 1. [Indicate subset used]. Boulder, Colorado USA. NSIDC: National Snow and Ice Data Center. doi: https://doi.org/10.7265/N5/NSIDC-WGI-2012-02. [Date Accessed].';
-- ddl-end --
ALTER TABLE public.glaciers_variable OWNER TO chase;
-- ddl-end --

-- object: public.ca_counties_tiger2016_gid_seq | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.ca_counties_tiger2016_gid_seq CASCADE;
CREATE SEQUENCE public.ca_counties_tiger2016_gid_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;
-- ddl-end --
ALTER SEQUENCE public.ca_counties_tiger2016_gid_seq OWNER TO chase;
-- ddl-end --

-- object: public.wbdhu6_gid_seq_cp | type: SEQUENCE --
-- DROP SEQUENCE IF EXISTS public.wbdhu6_gid_seq_cp CASCADE;
CREATE SEQUENCE public.wbdhu6_gid_seq_cp
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START WITH 1
	CACHE 1
	NO CYCLE
	OWNED BY NONE;
-- ddl-end --
ALTER SEQUENCE public.wbdhu6_gid_seq_cp OWNER TO chase;
-- ddl-end --

-- -- object: public.geometry | type: TYPE --
-- -- DROP TYPE IF EXISTS public.geometry CASCADE;
-- CREATE TYPE public.geometry;
-- -- ddl-end --
-- 

