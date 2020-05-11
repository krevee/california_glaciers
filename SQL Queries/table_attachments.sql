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
	glacier_id_glaciers_variable character varying(20),
	CONSTRAINT attachments_pk PRIMARY KEY (attach_name)

);
-- ddl-end --
COMMENT ON COLUMN public.attachments.adate IS 'data of publication';
-- ddl-end --
ALTER TABLE public.attachments OWNER TO cvanschoonhoven;
-- ddl-end --

