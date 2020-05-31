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
	CONSTRAINT ca_counties_pkey PRIMARY KEY (gid),
	CONSTRAINT name UNIQUE (name)

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
	CONSTRAINT wbdhu6_pkey PRIMARY KEY (gid),
	CONSTRAINT wbdhu6_name_key UNIQUE (name)

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
	CONSTRAINT glac_regions_pkey PRIMARY KEY (gid),
	CONSTRAINT mtnregion UNIQUE (mtnregion)

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
	aland numeric,
	awater numeric,
	intptlat character varying(11),
	intptlon character varying(12),
	in_county character varying(254),
	geom_lengt numeric,
	geom_area numeric,
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
	country_code character(2),
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
ALTER TABLE public.people OWNER TO cvanschoonhoven;
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
	CONSTRAINT "regional_Center_pk" PRIMARY KEY (rc_id),
	CONSTRAINT rc_id UNIQUE (rc_id)

);
-- ddl-end --
ALTER TABLE public.regional_center OWNER TO cvanschoonhoven;
-- ddl-end --

-- object: public.submission_info | type: TABLE --
-- DROP TABLE IF EXISTS public.submission_info CASCADE;
CREATE TABLE public.submission_info (
	submission_id integer NOT NULL,
	submitter_id integer,
	rc_id integer,
	glac_region integer,
	file_name text,
	submission_time date,
	proc_desc text,
	source_scale text,
	coord_desc text,
	gid_glac_regions integer,
	CONSTRAINT data_source_gid_pk PRIMARY KEY (submission_id),
	CONSTRAINT submission_id UNIQUE (submission_id)

);
-- ddl-end --
ALTER TABLE public.submission_info OWNER TO cvanschoonhoven;
-- ddl-end --

-- object: public.glaciers_static | type: TABLE --
-- DROP TABLE IF EXISTS public.glaciers_static CASCADE;
CREATE TABLE public.glaciers_static (
	glacier_id character varying(20) NOT NULL,
	glacier_name text,
	glims_id character varying(14),
	wgi_id character varying(20),
	rgi_id character varying(20),
	nhd_id character varying(40),
	gnis_id character varying(10),
	recno character varying(3),
	parent_icemass_id character varying(20),
	glac_status smallint NOT NULL DEFAULT 0,
	CONSTRAINT glaciers_static_pk PRIMARY KEY (glacier_id),
	CONSTRAINT glaciers_static_glacier_id_key UNIQUE (glacier_id)

);
-- ddl-end --
ALTER TABLE public.glaciers_static OWNER TO cvanschoonhoven;
-- ddl-end --

-- object: public.glaciers_variable | type: TABLE --
-- DROP TABLE IF EXISTS public.glaciers_variable CASCADE;
CREATE TABLE public.glaciers_variable (
	glacier_id character varying(20),
	submission_id integer NOT NULL,
	glac_name character varying(28),
	area numeric,
	db_area numeric,
	perimeter numeric,
	min_elev numeric,
	max_elev numeric,
	mean_elev numeric,
	glacial_region character varying(20),
	in_county text,
	in_basin text,
	num_basins smallint,
	fcode integer DEFAULT 37800,
	date timestamp,
	geom public.geometry,
	max_width numeric,
	max_length numeric,
	slope smallint,
	aspect smallint,
	connect smallint,
	surging smallint,
	linkages smallint,
	form smallint,
	term_type smallint,
	x_coord numeric,
	y_coord numeric,
	loc_unc_x smallint,
	loc_unc_y smallint,
	glob_unc_x smallint,
	glob_unc_y smallint,
	prime_class smallint,
	frontal_char smallint,
	long_char smallint,
	tongue_act smallint,
	moraines1 smallint,
	moraines2 smallint,
	source_nourish smallint,
	min_elev_exp smallint,
	mean_elev_acy smallint,
	mean_elev_abl smallint,
	activity_start smallint,
	activity_end smallint,
	snowline_acy smallint,
	snowline_date smallint,
	mean_depth smallint,
	deapth_acy smallint,
	area_acy smallint,
	area_exp smallint,
	mean_width smallint,
	mean_length smallint,
	max_len_ex smallint,
	max_len_ab smallint,
	orient_acc text,
	orient_abl text,
	remarks text,
	CONSTRAINT glims_polygons_pkey PRIMARY KEY (submission_id)

);
-- ddl-end --
ALTER TABLE public.glaciers_variable OWNER TO cvanschoonhoven;
-- ddl-end --

-- object: public.attachments | type: TABLE --
-- DROP TABLE IF EXISTS public.attachments CASCADE;
CREATE TABLE public.attachments (
	attach_name text NOT NULL,
	glacier_id character varying(20),
	file_type character varying(4),
	"URL" text,
	adate date,
	editor text,
	author text,
	description text,
	submission_id_glaciers_variable integer,
	CONSTRAINT attachments_pk PRIMARY KEY (attach_name)

);
-- ddl-end --
COMMENT ON COLUMN public.attachments.adate IS 'data of publication';
-- ddl-end --
ALTER TABLE public.attachments OWNER TO cvanschoonhoven;
-- ddl-end --

-- object: glaciers_variable_fk | type: CONSTRAINT --
-- ALTER TABLE public.attachments DROP CONSTRAINT IF EXISTS glaciers_variable_fk CASCADE;
ALTER TABLE public.attachments ADD CONSTRAINT glaciers_variable_fk FOREIGN KEY (submission_id_glaciers_variable)
REFERENCES public.glaciers_variable (submission_id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: glac_regions_fk | type: CONSTRAINT --
-- ALTER TABLE public.submission_info DROP CONSTRAINT IF EXISTS glac_regions_fk CASCADE;
ALTER TABLE public.submission_info ADD CONSTRAINT glac_regions_fk FOREIGN KEY (gid_glac_regions)
REFERENCES public.glac_regions (gid) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: in_county | type: CONSTRAINT --
-- ALTER TABLE public.ca_places DROP CONSTRAINT IF EXISTS in_county CASCADE;
ALTER TABLE public.ca_places ADD CONSTRAINT in_county FOREIGN KEY (in_county)
REFERENCES public.ca_counties (name) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: parent_rc | type: CONSTRAINT --
-- ALTER TABLE public.regional_center DROP CONSTRAINT IF EXISTS parent_rc CASCADE;
ALTER TABLE public.regional_center ADD CONSTRAINT parent_rc FOREIGN KEY (parent_rc)
REFERENCES public.regional_center (rc_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: rc_id | type: CONSTRAINT --
-- ALTER TABLE public.submission_info DROP CONSTRAINT IF EXISTS rc_id CASCADE;
ALTER TABLE public.submission_info ADD CONSTRAINT rc_id FOREIGN KEY (rc_id)
REFERENCES public.regional_center (rc_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: submitter_id | type: CONSTRAINT --
-- ALTER TABLE public.submission_info DROP CONSTRAINT IF EXISTS submitter_id CASCADE;
ALTER TABLE public.submission_info ADD CONSTRAINT submitter_id FOREIGN KEY (submitter_id)
REFERENCES public.people (contact_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: in_county | type: CONSTRAINT --
-- ALTER TABLE public.glaciers_variable DROP CONSTRAINT IF EXISTS in_county CASCADE;
ALTER TABLE public.glaciers_variable ADD CONSTRAINT in_county FOREIGN KEY (in_county)
REFERENCES public.ca_counties (name) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: in_basin | type: CONSTRAINT --
-- ALTER TABLE public.glaciers_variable DROP CONSTRAINT IF EXISTS in_basin CASCADE;
ALTER TABLE public.glaciers_variable ADD CONSTRAINT in_basin FOREIGN KEY (in_basin)
REFERENCES public.wbdhu6 (name) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: glacial_region | type: CONSTRAINT --
-- ALTER TABLE public.glaciers_variable DROP CONSTRAINT IF EXISTS glacial_region CASCADE;
ALTER TABLE public.glaciers_variable ADD CONSTRAINT glacial_region FOREIGN KEY (glacial_region)
REFERENCES public.glac_regions (mtnregion) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: submission_id | type: CONSTRAINT --
-- ALTER TABLE public.glaciers_variable DROP CONSTRAINT IF EXISTS submission_id CASCADE;
ALTER TABLE public.glaciers_variable ADD CONSTRAINT submission_id FOREIGN KEY (submission_id)
REFERENCES public.submission_info (submission_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- object: glaciers_variable_glacier_id_fkey | type: CONSTRAINT --
-- ALTER TABLE public.glaciers_variable DROP CONSTRAINT IF EXISTS glaciers_variable_glacier_id_fkey CASCADE;
ALTER TABLE public.glaciers_variable ADD CONSTRAINT glaciers_variable_glacier_id_fkey FOREIGN KEY (glacier_id)
REFERENCES public.glaciers_static (glacier_id) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

-- -- object: public.geometry | type: TYPE --
-- -- DROP TYPE IF EXISTS public.geometry CASCADE;
-- CREATE TYPE public.geometry;
-- -- ddl-end --
-- 

