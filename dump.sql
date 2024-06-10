--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases (except postgres and template1)
--

DROP DATABASE postgres_rest_app;




--
-- Drop roles
--

DROP ROLE postgres;


--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:RkblGe/PhoZZBnOHHOixaQ==$DKRK7xmIPemtHDpIk9+TUTfJ+DdsTx3kFgYn3CvDRtY=:iD4vw2NB1n9wvgBT9eMg/reJDxAoi46ppHHuW6Q1dBQ=';

--
-- User Configurations
--








--
-- Databases
--

--
-- Database "template1" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Debian 16.2-1.pgdg120+2)
-- Dumped by pg_dump version 16.2 (Debian 16.2-1.pgdg120+2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

UPDATE pg_catalog.pg_database SET datistemplate = false WHERE datname = 'template1';
DROP DATABASE template1;
--
-- Name: template1; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE template1 OWNER TO postgres;

\connect template1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: template1; Type: DATABASE PROPERTIES; Schema: -; Owner: postgres
--

ALTER DATABASE template1 IS_TEMPLATE = true;


\connect template1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE template1; Type: ACL; Schema: -; Owner: postgres
--

REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Debian 16.2-1.pgdg120+2)
-- Dumped by pg_dump version 16.2 (Debian 16.2-1.pgdg120+2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO postgres;

\connect postgres

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- PostgreSQL database dump complete
--

--
-- Database "postgres_rest_app" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Debian 16.2-1.pgdg120+2)
-- Dumped by pg_dump version 16.2 (Debian 16.2-1.pgdg120+2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: postgres_rest_app; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres_rest_app WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE postgres_rest_app OWNER TO postgres;

\connect postgres_rest_app

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.role AS ENUM (
    'admin',
    'moderator',
    'user'
);


ALTER TYPE public.role OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO postgres;

--
-- Name: contacts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contacts (
    id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    email character varying(50) NOT NULL,
    phone character varying(20) NOT NULL,
    birthday date NOT NULL,
    additional_info character varying(200),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer
);


ALTER TABLE public.contacts OWNER TO postgres;

--
-- Name: contacts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contacts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contacts_id_seq OWNER TO postgres;

--
-- Name: contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contacts_id_seq OWNED BY public.contacts.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    email character varying(150) NOT NULL,
    password character varying(255) NOT NULL,
    avatar character varying(255),
    refresh_token character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    confirmed boolean
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: contacts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts ALTER COLUMN id SET DEFAULT nextval('public.contacts_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alembic_version (version_num) FROM stdin;
9fc0fc6a1ce7
\.


--
-- Data for Name: contacts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contacts (id, first_name, last_name, email, phone, birthday, additional_info, created_at, updated_at, user_id) FROM stdin;
3	Alena	Mush	alena@example.com	420721476888	1994-01-28	string	\N	\N	\N
4	Alex	Alex	alep@example.com	string	2000-05-20	string	\N	\N	\N
5	nana	sunn	na@example.com	2323232333	2022-05-30	string	\N	\N	\N
6	jasia	mis	mii@example.com	21111111	2014-05-28	string	\N	\N	\N
7	altna	mis	a@example.com	string	2011-07-30	string	\N	\N	\N
8	stiv	string	ustiv@example.com	string	2024-05-29	string	\N	\N	\N
10	ala	string	ala@example.com	string	2000-06-03	string	2024-06-03 02:30:17.822728	2024-06-03 02:30:17.822728	1
13	alisa	string	alisa@example.com	12345679	2000-06-03	string	2024-06-03 02:42:29.942441	2024-06-03 02:42:29.942441	2
14	sona	soo	sona@example.com	string	2000-06-04	supper	2024-06-03 06:34:39.471243	2024-06-03 06:34:39.471243	1
15	sofia	string	sofi@example.com	string	2020-06-05	string	2024-06-03 06:46:09.507705	2024-06-03 06:46:09.507705	1
17	nata	string	nata@example.com	string	2000-06-05	string	2024-06-03 06:53:15.442813	2024-06-03 06:53:15.442813	2
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username, email, password, avatar, refresh_token, created_at, updated_at, confirmed) FROM stdin;
3	olenka	alena@eos.net.ua	$2b$12$/hDUtsrJq93YIBMUAI6QVu7OlqzXAc6DcCzt/t2LqLlij7cFiKQGW	https://www.gravatar.com/avatar/f98f6111f3b59db4ca3748088395d91a	\N	2024-06-06 11:57:05.892518	2024-06-06 11:57:05.892518	f
4	olenka	galena@eos.net.ua	$2b$12$p9iqcw8ND4mHJXdZW.qJVO0SzeFSldJUaLX1pHChVbBTxg326Tqja	https://www.gravatar.com/avatar/2c68c3029393799f4dbf78905b59513d	\N	2024-06-06 12:21:24.570761	2024-06-06 12:21:24.570761	f
5	alesha	alex@feron.kiev.ua	$2b$12$GcNIxRbJ8dD3PO/OrTFCWOrv/wy1gbzMop65akbTRG91KVXX2nl3C	https://www.gravatar.com/avatar/67481d919f2359d047bacb614b627521	\N	2024-06-06 12:26:10.805426	2024-06-06 12:26:10.805426	f
6	alesha1	daneko7654@morxin.com	$2b$12$Z6qmM8Bl4V6ZUBDmtoXNquW1/mULF1aeUW/AYNtzq0.TsCdcl5DU2	https://www.gravatar.com/avatar/99d488dbc9e5f40711f262a9fb79e105	\N	2024-06-06 12:46:04.544333	2024-06-06 12:46:04.544333	f
1	alena	alena.mertel@gmail.com	$2b$12$jByBd.1P5rmNfUw2DyD42uwLlxjm/0qjjt/QpAsWBCwNgZY59dDS2	https://www.gravatar.com/avatar/d49457463623521c6a5215bac4433119	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhbGVuYS5tZXJ0ZWxAZ21haWwuY29tIiwiaWF0IjoxNzE3Mzk2NDA2LCJleHAiOjE3MTgwMDEyMDYsInNjb3BlIjoicmVmcmVzaF90b2tlbiJ9.4u6JYIsO-y_2xvc2sEX-ijJSjUU3hDO2QMVR9iw8KaM	2024-06-02 06:21:48.933252	2024-06-06 16:29:59.873656	t
2	olena	a_mertel@ukr.net	$2b$12$b0RiZZpx98p0ng4b9D.GdeWdzEWq2F6846sl/YDQMi3BLb3hrfT1S	https://www.gravatar.com/avatar/c98c9974951e716cc22312c3fd6bb6d8	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhX21lcnRlbEB1a3IubmV0IiwiaWF0IjoxNzE3Mzk3NTUzLCJleHAiOjE3MTgwMDIzNTMsInNjb3BlIjoicmVmcmVzaF90b2tlbiJ9.QHvgXBujRyw0NE23tbC5PfZr4dbrQBh1da0bMIuKMbY	2024-06-02 14:40:49.376336	2024-06-06 16:30:17.05619	t
\.


--
-- Name: contacts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contacts_id_seq', 17, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 6, true);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: contacts contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: ix_contacts_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ix_contacts_email ON public.contacts USING btree (email);


--
-- Name: contacts contacts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

