--
-- PostgreSQL database cluster dump
--

-- Started on 2024-05-22 00:08:51 +03

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:q9phlZGG4C4/EcL9EOG+Mg==$hP+FyUDYPjrUEiWF6XfBiaDbSyEEd8Qk29iJp+8j8+Q=:2QDwvcPGOnojVseDxtPhWY/m71qGZxKIB0oxudG1HXA=';

--
-- User Configurations
--








--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

-- Started on 2024-05-22 00:08:51 +03

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

-- Completed on 2024-05-22 00:08:51 +03

--
-- PostgreSQL database dump complete
--

--
-- Database "Tusas-Geliapp" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

-- Started on 2024-05-22 00:08:51 +03

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
-- TOC entry 3693 (class 1262 OID 16398)
-- Name: Tusas-Geliapp; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "Tusas-Geliapp" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';


ALTER DATABASE "Tusas-Geliapp" OWNER TO postgres;

\connect -reuse-previous=on "dbname='Tusas-Geliapp'"

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 219 (class 1259 OID 40969)
-- Name: admin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin (
    admin_id integer NOT NULL,
    email character varying,
    password character varying,
    name character varying,
    surname character varying
);


ALTER TABLE public.admin OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 40968)
-- Name: admin_admin_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.admin ALTER COLUMN admin_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.admin_admin_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 230 (class 1259 OID 49166)
-- Name: apply_event; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.apply_event (
    event_id integer,
    user_id integer
);


ALTER TABLE public.apply_event OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 49200)
-- Name: apply_program; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.apply_program (
    program_id integer,
    user_id integer
);


ALTER TABLE public.apply_program OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 49179)
-- Name: event_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_user (
    event_id integer,
    user_id integer
);


ALTER TABLE public.event_user OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 40983)
-- Name: events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.events (
    event_id integer NOT NULL,
    name character varying,
    content character varying,
    image_path character varying
);


ALTER TABLE public.events OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 40982)
-- Name: events_event_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.events ALTER COLUMN event_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.events_event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 225 (class 1259 OID 40999)
-- Name: newsletters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.newsletters (
    newsletter_id integer NOT NULL,
    author_name character varying,
    content character varying,
    title character varying
);


ALTER TABLE public.newsletters OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 40998)
-- Name: newsletter_newsletter_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.newsletters ALTER COLUMN newsletter_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.newsletter_newsletter_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 217 (class 1259 OID 32768)
-- Name: otpcode; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.otpcode (
    user_id integer NOT NULL,
    expiresat timestamp with time zone,
    otp character varying(255)
);


ALTER TABLE public.otpcode OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 40991)
-- Name: podcasts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.podcasts (
    podcast_id integer NOT NULL,
    author_name character varying,
    file_path character varying,
    title character varying,
    content character varying
);


ALTER TABLE public.podcasts OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 40990)
-- Name: podcast_podcast_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.podcasts ALTER COLUMN podcast_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.podcast_podcast_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 233 (class 1259 OID 49193)
-- Name: program; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.program (
    program_id integer NOT NULL,
    name character varying(255),
    content character varying(255),
    image_path character varying(255)
);


ALTER TABLE public.program OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 49192)
-- Name: program_program_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.program ALTER COLUMN program_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.program_program_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 235 (class 1259 OID 49213)
-- Name: program_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.program_user (
    program_id integer,
    user_id integer
);


ALTER TABLE public.program_user OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 49153)
-- Name: refresh_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.refresh_tokens (
    id integer NOT NULL,
    token character varying,
    expires_at timestamp with time zone,
    admin boolean
);


ALTER TABLE public.refresh_tokens OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 49152)
-- Name: refresh_token_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.refresh_tokens ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.refresh_token_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 216 (class 1259 OID 24591)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    is_banned boolean,
    name character varying(255),
    surname character varying(255),
    email character varying(255),
    password character varying(255),
    job character varying(255),
    photo character varying(255),
    photo_type character varying,
    is_tusas boolean,
    phone character varying(255)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 24590)
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.users ALTER COLUMN user_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 227 (class 1259 OID 41007)
-- Name: videos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.videos (
    videos_id integer NOT NULL,
    title character varying,
    videos_path character varying
);


ALTER TABLE public.videos OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 41006)
-- Name: videos_videos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.videos ALTER COLUMN videos_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.videos_videos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 3671 (class 0 OID 40969)
-- Dependencies: 219
-- Data for Name: admin; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin (admin_id, email, password, name, surname) FROM stdin;
1	melihhmeral@gmail.com	Melih123	\N	\N
\.


--
-- TOC entry 3682 (class 0 OID 49166)
-- Dependencies: 230
-- Data for Name: apply_event; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.apply_event (event_id, user_id) FROM stdin;
\.


--
-- TOC entry 3686 (class 0 OID 49200)
-- Dependencies: 234
-- Data for Name: apply_program; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.apply_program (program_id, user_id) FROM stdin;
1	2
\.


--
-- TOC entry 3683 (class 0 OID 49179)
-- Dependencies: 231
-- Data for Name: event_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_user (event_id, user_id) FROM stdin;
1	2
1	2
\.


--
-- TOC entry 3673 (class 0 OID 40983)
-- Dependencies: 221
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.events (event_id, name, content, image_path) FROM stdin;
1	melafdgsfadjnlkaaih	melihha@gmail.com	/Users/macbookpro/Desktop/a
\.


--
-- TOC entry 3677 (class 0 OID 40999)
-- Dependencies: 225
-- Data for Name: newsletters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.newsletters (newsletter_id, author_name, content, title) FROM stdin;
4	Melih meral	Bu bir postmman isteğidir	Newsletter_test
5	Melih meral	Bu bir postmman isteğidir	Newsaaaletter_test
6	Melih meral	Bu bir postmman isteğidir	Newsaaaafletter_test
\.


--
-- TOC entry 3669 (class 0 OID 32768)
-- Dependencies: 217
-- Data for Name: otpcode; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.otpcode (user_id, expiresat, otp) FROM stdin;
\.


--
-- TOC entry 3675 (class 0 OID 40991)
-- Dependencies: 223
-- Data for Name: podcasts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.podcasts (podcast_id, author_name, file_path, title, content) FROM stdin;
1	Melih meral	/Users/macbookpro/Desktop/a	Podcast_test	Bu bir postmman update isteğidir
\.


--
-- TOC entry 3685 (class 0 OID 49193)
-- Dependencies: 233
-- Data for Name: program; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.program (program_id, name, content, image_path) FROM stdin;
1	Podcast_test	Bu bir postmman update isteğidir	/Users/macbookpro/Desktop/a
\.


--
-- TOC entry 3687 (class 0 OID 49213)
-- Dependencies: 235
-- Data for Name: program_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.program_user (program_id, user_id) FROM stdin;
1	2
\.


--
-- TOC entry 3681 (class 0 OID 49153)
-- Dependencies: 229
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.refresh_tokens (id, token, expires_at, admin) FROM stdin;
1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJtZWxpaGhtZXJhbEBnbWFpbC5jb20iLCJhZG1pbiI6dHJ1ZSwiaWF0IjoxNzE0ODEwMDMxLCJleHAiOjE3MTc0MDIwMzF9.fa576faUWRU4HH936GwwXagGnjg9Ord_vm3UiIE-1AA	2024-06-03 11:07:11.54+03	t
2	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJtZWxpaGhtZXJhbEBnbWFpbC5jb20iLCJhZG1pbiI6dHJ1ZSwiaWF0IjoxNzE0ODExMjA0LCJleHAiOjE3MTc0MDMyMDR9.wWnb8Cy9pQw2nZEHj2F7QzSHHztwtO9nwjTctdAjhoE	2024-06-03 11:26:44.558+03	t
5	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJtZWxpaGhtZXJhbEBnbWFpbC5jb20iLCJhZG1pbiI6dHJ1ZSwiaWF0IjoxNzE0OTAwODUyLCJleHAiOjE3MTc0OTI4NTJ9.6mDDtPa-j6dFEBTbkFVAaVi06MtDlkKztIfeHa3MNU4	2024-06-04 12:20:52.301+03	t
6	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoyLCJlbWFpbCI6Im1lbGloaG1lcmFsbEBnbWFpbC5jb20iLCJhZG1pbiI6ZmFsc2UsImlhdCI6MTcxNDkwMDg3NywiZXhwIjoxNzE3NDkyODc3fQ.5m5YxA38fUq_v8rh4_v5o80gyMC3hFxp4L_Q5ErhUME	2024-06-04 12:21:17.903+03	f
9	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoyLCJlbWFpbCI6Im1lbGloaG1lcmFsbEBnbWFpbC5jb20iLCJhZG1pbiI6ZmFsc2UsImlhdCI6MTcxNDkwNzY4MSwiZXhwIjoxNzE3NDk5NjgxfQ.v3qf6Pc-wHwZXgtzJvAhKxypK40l_DeSsuy9Vbr469k	2024-06-04 14:14:41.313+03	f
10	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJtZWxpaGhtZXJhbEBnbWFpbC5jb20iLCJhZG1pbiI6dHJ1ZSwiaWF0IjoxNzE0OTA4NTc5LCJleHAiOjE3MTc1MDA1Nzl9.MeOCE6_oJhtJXsEQFFHffJc72culfyLmrV3X4ivtt-8	2024-06-04 14:29:39.453+03	t
11	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoyLCJlbWFpbCI6Im1lbGloaG1lcmFsbEBnbWFpbC5jb20iLCJhZG1pbiI6ZmFsc2UsImlhdCI6MTcxNDkwOTM0MCwiZXhwIjoxNzE3NTAxMzQwfQ.InmpSYZUPXtUdFDdShAU71OoF8FW1oEL9sVKrIaHHro	2024-06-04 14:42:20.555+03	f
12	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJtZWxpaGhtZXJhbEBnbWFpbC5jb20iLCJhZG1pbiI6dHJ1ZSwiaWF0IjoxNzE0OTA5NTcyLCJleHAiOjE3MTc1MDE1NzJ9.iSc6r_75-oqxy5STPTs2rT6Onf-nSZN4LFzWV8WJ200	2024-06-04 14:46:12.289+03	t
13	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoyLCJlbWFpbCI6Im1lbGloaG1lcmFsbEBnbWFpbC5jb20iLCJhZG1pbiI6ZmFsc2UsImlhdCI6MTcxNDkxODI2MCwiZXhwIjoxNzE3NTEwMjYwfQ.U6xUV0c4icrFDJOkFPtdpRo4Cii6nhTsodri7aeqZDU	2024-06-04 17:11:00.104+03	f
14	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoyLCJlbWFpbCI6Im1lbGloaG1lcmFsbEBnbWFpbC5jb20iLCJhZG1pbiI6ZmFsc2UsImlhdCI6MTcxNDkxODI4OCwiZXhwIjoxNzE3NTEwMjg4fQ.y-A80Dfs_gW1g6zQS80AySrrDtw2FGJvVCHIYDiGRw0	2024-06-04 17:11:28.342+03	f
15	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJtZWxpaGhtZXJhbEBnbWFpbC5jb20iLCJhZG1pbiI6dHJ1ZSwiaWF0IjoxNzE0OTE4MzAzLCJleHAiOjE3MTc1MTAzMDN9.akkedIn9L32XLanYa9dj_7j2axU1OQt7-8iSxbzdUe4	2024-06-04 17:11:43.316+03	t
16	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoyLCJlbWFpbCI6Im1lbGloaG1lcmFsbEBnbWFpbC5jb20iLCJhZG1pbiI6ZmFsc2UsImlhdCI6MTcxNDkxOTMyMSwiZXhwIjoxNzE3NTExMzIxfQ.P9lKKb6nJIMbLQ5R-LOPAWJx0bTGXYDCNydReGcFLpo	2024-06-04 17:28:41.347+03	f
17	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJtZWxpaGhtZXJhbEBnbWFpbC5jb20iLCJhZG1pbiI6dHJ1ZSwiaWF0IjoxNzE0OTE5MzM2LCJleHAiOjE3MTc1MTEzMzZ9.2t9wjcBfXym9tfyWwJ3O321OaK93VT3xMQLSXw6ZJVc	2024-06-04 17:28:56.176+03	t
18	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoyLCJlbWFpbCI6Im1lbGloaG1lcmFsbEBnbWFpbC5jb20iLCJhZG1pbiI6ZmFsc2UsImlhdCI6MTcxNDkxOTc0NSwiZXhwIjoxNzE3NTExNzQ1fQ.SjYIVdPICEPLmB7joRnGpVx7cN3VtyjIJpl2TNJbzoo	2024-06-04 17:35:45.13+03	f
19	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJtZWxpaGhtZXJhbEBnbWFpbC5jb20iLCJhZG1pbiI6dHJ1ZSwiaWF0IjoxNzE0OTE5NzcxLCJleHAiOjE3MTc1MTE3NzF9.jsnvHfCFUzScC0EsGcIKMC8HR9qUidQOYZb05wQMrIY	2024-06-04 17:36:11.911+03	t
20	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoyLCJlbWFpbCI6Im1lbGloaG1lcmFsbEBnbWFpbC5jb20iLCJhZG1pbiI6ZmFsc2UsImlhdCI6MTcxNTAyMjQ4NywiZXhwIjoxNzE3NjE0NDg3fQ.bNtknjb4gNT8JlBWJE03XEP9H5eUPNjkcmbT8ezjX3w	2024-06-05 22:08:07.833+03	f
21	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoyLCJlbWFpbCI6Im1lbGloaG1lcmFsbEBnbWFpbC5jb20iLCJhZG1pbiI6ZmFsc2UsImlhdCI6MTcxNTAyMjUxMiwiZXhwIjoxNzE3NjE0NTEyfQ.MEeUBWP51WPJHYJOX8np_VApxTpDtJKs-sgQqTPe3rU	2024-06-05 22:08:32.591+03	f
22	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJtZWxpaGhtZXJhbEBnbWFpbC5jb20iLCJhZG1pbiI6dHJ1ZSwiaWF0IjoxNzE1MDIyODE0LCJleHAiOjE3MTc2MTQ4MTR9.7BulDBy6EtJoRMFzpIUmbJK-KEcacWRsy1Mr-Reb5ic	2024-06-05 22:13:34.361+03	t
23	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoyLCJlbWFpbCI6Im1lbGloaG1lcmFsbEBnbWFpbC5jb20iLCJhZG1pbiI6ZmFsc2UsImlhdCI6MTcxNTAyMzg4MSwiZXhwIjoxNzE3NjE1ODgxfQ.r5I8j0vUxzesg_6sN-hU-4aYHZAzfDjWeFezWzFlFv0	2024-06-05 22:31:21.598+03	f
24	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJtZWxpaGhtZXJhbEBnbWFpbC5jb20iLCJhZG1pbiI6dHJ1ZSwiaWF0IjoxNzE1MDI0MDE2LCJleHAiOjE3MTc2MTYwMTZ9.uzsUwYY3OTXwZTbs7q76iOzJEIHOcvh0-BX-SyNrw9s	2024-06-05 22:33:36.968+03	t
25	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJtZWxpaGhtZXJhbEBnbWFpbC5jb20iLCJhZG1pbiI6dHJ1ZSwiaWF0IjoxNzE1MDI0NjkxLCJleHAiOjE3MTc2MTY2OTF9.e1cenx-CLlHyX4SKEk0YZGcVExf6ieM-IEfh1zAPDzM	2024-06-05 22:44:51.764+03	t
26	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJtZWxpaGhtZXJhbEBnbWFpbC5jb20iLCJhZG1pbiI6dHJ1ZSwiaWF0IjoxNzE1MDI1NjcwLCJleHAiOjE3MTc2MTc2NzB9.4GSEZ7rfNb0VM9kBXauR9ZDBcsdIr_AsFK3oNK2_GiI	2024-06-05 23:01:10.029+03	t
\.


--
-- TOC entry 3668 (class 0 OID 24591)
-- Dependencies: 216
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, is_banned, name, surname, email, password, job, photo, photo_type, is_tusas, phone) FROM stdin;
9	f	melih	meral	melihmaeraaafaflaa2001@hotmail.com	$2b$10$Q/lgbnI3Fr.uWGNVkR.w4eEFzbURZ0J78riUXxF.cfadGggOhrm8.	dolandırıcı	\N	\N	f	05355108923
12	f	melih	meral	melihhmerall@gmail.com	\N	dolandırıcı	\N	\N	\N	05355108923
13	f	melih	meral	melihhmerall@gmail.com	\N	dolandırıcı	\N	\N	\N	05355108923
3	t	a	a	melmer@gmail.com	a	\N	\N	\N	\N	\N
4	f	melih	meral	melihmeral2001@hotmail.com	$2b$10$YJDwvMrl1Tfg7y40.ruJ1.8h5KaJKgOMd8b1X.qx.P1THnDosyYvS	dolandırıcı	\N	\N	f	05355108923
2	f	melih	meral	melihhmerall@gmail.com	$2b$10$CQHTbEKjtpxL.q9lAOhC9.8AwJmxmr2lmFYMY6O7Nqtuerh8zyqZO	dolandırıcı	sa	jpg	t	05355108923
\.


--
-- TOC entry 3679 (class 0 OID 41007)
-- Dependencies: 227
-- Data for Name: videos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.videos (videos_id, title, videos_path) FROM stdin;
1	Video	test
4	Bu bir postmman isteğidir	/Users/macbookpro/Desktop/a
\.


--
-- TOC entry 3694 (class 0 OID 0)
-- Dependencies: 218
-- Name: admin_admin_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admin_admin_id_seq', 1, true);


--
-- TOC entry 3695 (class 0 OID 0)
-- Dependencies: 220
-- Name: events_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.events_event_id_seq', 3, true);


--
-- TOC entry 3696 (class 0 OID 0)
-- Dependencies: 224
-- Name: newsletter_newsletter_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.newsletter_newsletter_id_seq', 6, true);


--
-- TOC entry 3697 (class 0 OID 0)
-- Dependencies: 222
-- Name: podcast_podcast_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.podcast_podcast_id_seq', 2, true);


--
-- TOC entry 3698 (class 0 OID 0)
-- Dependencies: 232
-- Name: program_program_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.program_program_id_seq', 2, true);


--
-- TOC entry 3699 (class 0 OID 0)
-- Dependencies: 228
-- Name: refresh_token_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.refresh_token_id_seq', 26, true);


--
-- TOC entry 3700 (class 0 OID 0)
-- Dependencies: 215
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 13, true);


--
-- TOC entry 3701 (class 0 OID 0)
-- Dependencies: 226
-- Name: videos_videos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.videos_videos_id_seq', 4, true);


--
-- TOC entry 3503 (class 2606 OID 40975)
-- Name: admin admin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (admin_id);


--
-- TOC entry 3505 (class 2606 OID 40989)
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (event_id);


--
-- TOC entry 3509 (class 2606 OID 41005)
-- Name: newsletters newsletter_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.newsletters
    ADD CONSTRAINT newsletter_pkey PRIMARY KEY (newsletter_id);


--
-- TOC entry 3501 (class 2606 OID 32772)
-- Name: otpcode otpcode_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.otpcode
    ADD CONSTRAINT otpcode_pkey PRIMARY KEY (user_id);


--
-- TOC entry 3507 (class 2606 OID 40997)
-- Name: podcasts podcast_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.podcasts
    ADD CONSTRAINT podcast_pkey PRIMARY KEY (podcast_id);


--
-- TOC entry 3515 (class 2606 OID 49199)
-- Name: program program_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.program
    ADD CONSTRAINT program_pkey PRIMARY KEY (program_id);


--
-- TOC entry 3513 (class 2606 OID 49159)
-- Name: refresh_tokens refresh_token_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT refresh_token_pkey PRIMARY KEY (id);


--
-- TOC entry 3499 (class 2606 OID 24597)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- TOC entry 3511 (class 2606 OID 41013)
-- Name: videos videos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.videos
    ADD CONSTRAINT videos_pkey PRIMARY KEY (videos_id);


--
-- TOC entry 3516 (class 2606 OID 49169)
-- Name: apply_event event_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apply_event
    ADD CONSTRAINT event_id FOREIGN KEY (event_id) REFERENCES public.events(event_id) NOT VALID;


--
-- TOC entry 3518 (class 2606 OID 49182)
-- Name: event_user event_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_user
    ADD CONSTRAINT event_id FOREIGN KEY (event_id) REFERENCES public.events(event_id);


--
-- TOC entry 3520 (class 2606 OID 49203)
-- Name: apply_program program_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apply_program
    ADD CONSTRAINT program_id FOREIGN KEY (program_id) REFERENCES public.program(program_id);


--
-- TOC entry 3522 (class 2606 OID 49216)
-- Name: program_user program_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.program_user
    ADD CONSTRAINT program_id FOREIGN KEY (program_id) REFERENCES public.program(program_id);


--
-- TOC entry 3517 (class 2606 OID 49174)
-- Name: apply_event user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apply_event
    ADD CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id) NOT VALID;


--
-- TOC entry 3519 (class 2606 OID 49187)
-- Name: event_user user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_user
    ADD CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- TOC entry 3521 (class 2606 OID 49208)
-- Name: apply_program user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apply_program
    ADD CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- TOC entry 3523 (class 2606 OID 49221)
-- Name: program_user user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.program_user
    ADD CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id);


-- Completed on 2024-05-22 00:08:52 +03

--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

-- Started on 2024-05-22 00:08:52 +03

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
-- TOC entry 2 (class 3079 OID 16384)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 3587 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


-- Completed on 2024-05-22 00:08:52 +03

--
-- PostgreSQL database dump complete
--

-- Completed on 2024-05-22 00:08:52 +03

--
-- PostgreSQL database cluster dump complete
--

