--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: doctrine_migration_versions; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.doctrine_migration_versions (
    version character varying(191) NOT NULL,
    executed_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    execution_time integer
);


ALTER TABLE public.doctrine_migration_versions OWNER TO root;

--
-- Name: field; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.field (
    id integer NOT NULL,
    label character varying(255) NOT NULL
);


ALTER TABLE public.field OWNER TO root;

--
-- Name: field_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.field_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.field_id_seq OWNER TO root;

--
-- Name: field_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.field_id_seq OWNED BY public.field.id;


--
-- Name: field_option; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.field_option (
    id integer NOT NULL,
    field_id integer NOT NULL,
    label character varying(255) NOT NULL
);


ALTER TABLE public.field_option OWNER TO root;

--
-- Name: field_option_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.field_option_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.field_option_id_seq OWNER TO root;

--
-- Name: field_option_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.field_option_id_seq OWNED BY public.field_option.id;


--
-- Name: report; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.report (
    id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.report OWNER TO root;

--
-- Name: report_entry; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.report_entry (
    id integer NOT NULL,
    report_id integer NOT NULL,
    field_id integer NOT NULL,
    field_option_id integer,
    expected_result character varying(255) NOT NULL,
    actual_result character varying(255) NOT NULL,
    comment character varying(255) DEFAULT NULL::character varying,
    tested_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.report_entry OWNER TO root;

--
-- Name: COLUMN report_entry.tested_at; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN public.report_entry.tested_at IS '(DC2Type:datetime_immutable)';


--
-- Name: report_entry_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.report_entry_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.report_entry_id_seq OWNER TO root;

--
-- Name: report_entry_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.report_entry_id_seq OWNED BY public.report_entry.id;


--
-- Name: report_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.report_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.report_id_seq OWNER TO root;

--
-- Name: report_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.report_id_seq OWNED BY public.report.id;


--
-- Name: role; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.role (
    id integer NOT NULL,
    label character varying(255) NOT NULL
);


ALTER TABLE public.role OWNER TO root;

--
-- Name: role_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.role_id_seq OWNER TO root;

--
-- Name: role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.role_id_seq OWNED BY public.role.id;


--
-- Name: role_user; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.role_user (
    user_id integer NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE public.role_user OWNER TO root;

--
-- Name: user; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL
);


ALTER TABLE public."user" OWNER TO root;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_id_seq OWNER TO root;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- Name: field id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.field ALTER COLUMN id SET DEFAULT nextval('public.field_id_seq'::regclass);


--
-- Name: field_option id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.field_option ALTER COLUMN id SET DEFAULT nextval('public.field_option_id_seq'::regclass);


--
-- Name: report id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.report ALTER COLUMN id SET DEFAULT nextval('public.report_id_seq'::regclass);


--
-- Name: report_entry id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.report_entry ALTER COLUMN id SET DEFAULT nextval('public.report_entry_id_seq'::regclass);


--
-- Name: role id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.role ALTER COLUMN id SET DEFAULT nextval('public.role_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Data for Name: doctrine_migration_versions; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.doctrine_migration_versions (version, executed_at, execution_time) FROM stdin;
DoctrineMigrations\\Version20250414124536	2025-04-14 12:46:49	52
\.


--
-- Data for Name: field; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.field (id, label) FROM stdin;
\.


--
-- Data for Name: field_option; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.field_option (id, field_id, label) FROM stdin;
\.


--
-- Data for Name: report; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.report (id, user_id) FROM stdin;
\.


--
-- Data for Name: report_entry; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.report_entry (id, report_id, field_id, field_option_id, expected_result, actual_result, comment, tested_at) FROM stdin;
\.


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.role (id, label) FROM stdin;
\.


--
-- Data for Name: role_user; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.role_user (user_id, role_id) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public."user" (id, first_name, last_name, email, password) FROM stdin;
\.


--
-- Name: field_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.field_id_seq', 1, false);


--
-- Name: field_option_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.field_option_id_seq', 1, false);


--
-- Name: report_entry_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.report_entry_id_seq', 1, false);


--
-- Name: report_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.report_id_seq', 1, false);


--
-- Name: role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.role_id_seq', 1, false);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.user_id_seq', 1, false);


--
-- Name: doctrine_migration_versions doctrine_migration_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.doctrine_migration_versions
    ADD CONSTRAINT doctrine_migration_versions_pkey PRIMARY KEY (version);


--
-- Name: field_option field_option_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.field_option
    ADD CONSTRAINT field_option_pkey PRIMARY KEY (id);


--
-- Name: field field_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.field
    ADD CONSTRAINT field_pkey PRIMARY KEY (id);


--
-- Name: report_entry report_entry_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.report_entry
    ADD CONSTRAINT report_entry_pkey PRIMARY KEY (id);


--
-- Name: report report_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.report
    ADD CONSTRAINT report_pkey PRIMARY KEY (id);


--
-- Name: role role_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- Name: role_user role_user_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.role_user
    ADD CONSTRAINT role_user_pkey PRIMARY KEY (user_id, role_id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: idx_13d9a0942c79be5; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_13d9a0942c79be5 ON public.report_entry USING btree (field_option_id);


--
-- Name: idx_13d9a09443707b0; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_13d9a09443707b0 ON public.report_entry USING btree (field_id);


--
-- Name: idx_13d9a094bd2a4c0; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_13d9a094bd2a4c0 ON public.report_entry USING btree (report_id);


--
-- Name: idx_332ca4dda76ed395; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_332ca4dda76ed395 ON public.role_user USING btree (user_id);


--
-- Name: idx_332ca4ddd60322ac; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_332ca4ddd60322ac ON public.role_user USING btree (role_id);


--
-- Name: idx_70c28cb2443707b0; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_70c28cb2443707b0 ON public.field_option USING btree (field_id);


--
-- Name: idx_c42f7784a76ed395; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX idx_c42f7784a76ed395 ON public.report USING btree (user_id);


--
-- Name: uniq_8d93d649e7927c74; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX uniq_8d93d649e7927c74 ON public."user" USING btree (email);


--
-- Name: report_entry fk_13d9a0942c79be5; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.report_entry
    ADD CONSTRAINT fk_13d9a0942c79be5 FOREIGN KEY (field_option_id) REFERENCES public.field_option(id);


--
-- Name: report_entry fk_13d9a09443707b0; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.report_entry
    ADD CONSTRAINT fk_13d9a09443707b0 FOREIGN KEY (field_id) REFERENCES public.field(id);


--
-- Name: report_entry fk_13d9a094bd2a4c0; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.report_entry
    ADD CONSTRAINT fk_13d9a094bd2a4c0 FOREIGN KEY (report_id) REFERENCES public.report(id);


--
-- Name: role_user fk_332ca4dda76ed395; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.role_user
    ADD CONSTRAINT fk_332ca4dda76ed395 FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: role_user fk_332ca4ddd60322ac; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.role_user
    ADD CONSTRAINT fk_332ca4ddd60322ac FOREIGN KEY (role_id) REFERENCES public.role(id);


--
-- Name: field_option fk_70c28cb2443707b0; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.field_option
    ADD CONSTRAINT fk_70c28cb2443707b0 FOREIGN KEY (field_id) REFERENCES public.field(id);


--
-- Name: report fk_c42f7784a76ed395; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.report
    ADD CONSTRAINT fk_c42f7784a76ed395 FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- PostgreSQL database dump complete
--

