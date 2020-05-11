CREATE TABLE public.glaciers_static (
	glacier_id varchar(20) NOT NULL,
	glacier_name text,
	glims_id varchar(14),
	wgi_id varchar(20),
	rgi_id varchar(20),
	nhd_id varchar(36),
	gnis_id varchar(8),
	recno varchar(3),
	parent_icemass_id varchar(20),
	glac_status smallint NOT NULL DEFAULT 0,
	CONSTRAINT glaciers_static_pk PRIMARY KEY (glacier_id)

);