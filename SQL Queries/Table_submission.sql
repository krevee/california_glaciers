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
	CONSTRAINT data_source_gid_pk PRIMARY KEY (submission_id),
	CONSTRAINT data_source_sid_un UNIQUE (submission_id)

);