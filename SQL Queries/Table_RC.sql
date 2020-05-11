CREATE TABLE public.regional_center (
	rc_id integer NOT NULL,
	parent_rc integer,
	main_contact integer,
	url_primary text,
	url_secondary text,
	rc_poly polygon,
	CONSTRAINT "regional_Center_pk" PRIMARY KEY (rc_id)

);