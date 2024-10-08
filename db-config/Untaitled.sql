PGDMP  :        
            |            Tusas-Geliapp    16.2    16.2 S    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16398    Tusas-Geliapp    DATABASE     q   CREATE DATABASE "Tusas-Geliapp" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';
    DROP DATABASE "Tusas-Geliapp";
                postgres    false            �            1259    40969    admin    TABLE     �   CREATE TABLE public.admin (
    admin_id integer NOT NULL,
    email character varying,
    password character varying,
    name character varying,
    surname character varying
);
    DROP TABLE public.admin;
       public         heap    postgres    false            �            1259    40968    admin_admin_id_seq    SEQUENCE     �   ALTER TABLE public.admin ALTER COLUMN admin_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.admin_admin_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    219            �            1259    49166    apply_event    TABLE     O   CREATE TABLE public.apply_event (
    event_id integer,
    user_id integer
);
    DROP TABLE public.apply_event;
       public         heap    postgres    false            �            1259    49200    apply_program    TABLE     S   CREATE TABLE public.apply_program (
    program_id integer,
    user_id integer
);
 !   DROP TABLE public.apply_program;
       public         heap    postgres    false            �            1259    49179 
   event_user    TABLE     N   CREATE TABLE public.event_user (
    event_id integer,
    user_id integer
);
    DROP TABLE public.event_user;
       public         heap    postgres    false            �            1259    40983    events    TABLE     �   CREATE TABLE public.events (
    event_id integer NOT NULL,
    name character varying,
    content character varying,
    image_path character varying,
    event_date character varying,
    location character varying,
    event_link character varying
);
    DROP TABLE public.events;
       public         heap    postgres    false            �            1259    40982    events_event_id_seq    SEQUENCE     �   ALTER TABLE public.events ALTER COLUMN event_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.events_event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    221            �            1259    40999    newsletters    TABLE     �   CREATE TABLE public.newsletters (
    newsletter_id integer NOT NULL,
    author_name character varying,
    content character varying,
    title character varying,
    thumbnail_path character varying
);
    DROP TABLE public.newsletters;
       public         heap    postgres    false            �            1259    40998    newsletter_newsletter_id_seq    SEQUENCE     �   ALTER TABLE public.newsletters ALTER COLUMN newsletter_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.newsletter_newsletter_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    225            �            1259    57464    notification    TABLE     �   CREATE TABLE public.notification (
    id integer NOT NULL,
    user_id integer,
    message character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
     DROP TABLE public.notification;
       public         heap    postgres    false            �            1259    57463    notification_id_seq    SEQUENCE     �   CREATE SEQUENCE public.notification_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.notification_id_seq;
       public          postgres    false    240            �           0    0    notification_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.notification_id_seq OWNED BY public.notification.id;
          public          postgres    false    239            �            1259    32768    otpcode    TABLE     �   CREATE TABLE public.otpcode (
    user_id integer NOT NULL,
    expiresat timestamp with time zone,
    otp character varying(255)
);
    DROP TABLE public.otpcode;
       public         heap    postgres    false            �            1259    40991    podcasts    TABLE     �   CREATE TABLE public.podcasts (
    podcast_id integer NOT NULL,
    author_name character varying,
    podcast_link character varying,
    title character varying,
    content character varying,
    cover_image_path character varying
);
    DROP TABLE public.podcasts;
       public         heap    postgres    false            �            1259    40990    podcast_podcast_id_seq    SEQUENCE     �   ALTER TABLE public.podcasts ALTER COLUMN podcast_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.podcast_podcast_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    223            �            1259    49193    program    TABLE     0  CREATE TABLE public.program (
    program_id integer NOT NULL,
    name character varying(255),
    content character varying(255),
    image_path character varying(255),
    program_date character varying,
    location character varying,
    program_link character varying,
    sss character varying
);
    DROP TABLE public.program;
       public         heap    postgres    false            �            1259    49192    program_program_id_seq    SEQUENCE     �   ALTER TABLE public.program ALTER COLUMN program_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.program_program_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    233            �            1259    49226    program_speaker    TABLE     U   CREATE TABLE public.program_speaker (
    program_id integer,
    user_id integer
);
 #   DROP TABLE public.program_speaker;
       public         heap    postgres    false            �            1259    49213    program_user    TABLE     R   CREATE TABLE public.program_user (
    program_id integer,
    user_id integer
);
     DROP TABLE public.program_user;
       public         heap    postgres    false            �            1259    49153    refresh_tokens    TABLE     �   CREATE TABLE public.refresh_tokens (
    id integer NOT NULL,
    token character varying,
    expires_at timestamp with time zone,
    admin boolean
);
 "   DROP TABLE public.refresh_tokens;
       public         heap    postgres    false            �            1259    49152    refresh_token_id_seq    SEQUENCE     �   ALTER TABLE public.refresh_tokens ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.refresh_token_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    229            �            1259    57437    user_calender_event    TABLE     W   CREATE TABLE public.user_calender_event (
    event_id integer,
    user_id integer
);
 '   DROP TABLE public.user_calender_event;
       public         heap    postgres    false            �            1259    57450    user_calender_program    TABLE     [   CREATE TABLE public.user_calender_program (
    program_id integer,
    user_id integer
);
 )   DROP TABLE public.user_calender_program;
       public         heap    postgres    false            �            1259    24591    users    TABLE       CREATE TABLE public.users (
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
    phone character varying(255),
    location character varying,
    instagram character varying,
    twitter character varying,
    linkedin character varying,
    facebook character varying
);
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    24590    users_user_id_seq    SEQUENCE     �   ALTER TABLE public.users ALTER COLUMN user_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    216            �            1259    41007    videos    TABLE        CREATE TABLE public.videos (
    videos_id integer NOT NULL,
    title character varying,
    videos_path character varying
);
    DROP TABLE public.videos;
       public         heap    postgres    false            �            1259    41006    videos_videos_id_seq    SEQUENCE     �   ALTER TABLE public.videos ALTER COLUMN videos_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.videos_videos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    227            �           2604    57467    notification id    DEFAULT     r   ALTER TABLE ONLY public.notification ALTER COLUMN id SET DEFAULT nextval('public.notification_id_seq'::regclass);
 >   ALTER TABLE public.notification ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    239    240    240            s          0    40969    admin 
   TABLE DATA           I   COPY public.admin (admin_id, email, password, name, surname) FROM stdin;
    public          postgres    false    219   La       ~          0    49166    apply_event 
   TABLE DATA           8   COPY public.apply_event (event_id, user_id) FROM stdin;
    public          postgres    false    230   �a       �          0    49200    apply_program 
   TABLE DATA           <   COPY public.apply_program (program_id, user_id) FROM stdin;
    public          postgres    false    234   �a                 0    49179 
   event_user 
   TABLE DATA           7   COPY public.event_user (event_id, user_id) FROM stdin;
    public          postgres    false    231   �a       u          0    40983    events 
   TABLE DATA           g   COPY public.events (event_id, name, content, image_path, event_date, location, event_link) FROM stdin;
    public          postgres    false    221   �a       y          0    40999    newsletters 
   TABLE DATA           a   COPY public.newsletters (newsletter_id, author_name, content, title, thumbnail_path) FROM stdin;
    public          postgres    false    225   ob       �          0    57464    notification 
   TABLE DATA           H   COPY public.notification (id, user_id, message, created_at) FROM stdin;
    public          postgres    false    240   c       q          0    32768    otpcode 
   TABLE DATA           :   COPY public.otpcode (user_id, expiresat, otp) FROM stdin;
    public          postgres    false    217   #c       w          0    40991    podcasts 
   TABLE DATA           k   COPY public.podcasts (podcast_id, author_name, podcast_link, title, content, cover_image_path) FROM stdin;
    public          postgres    false    223   @c       �          0    49193    program 
   TABLE DATA           s   COPY public.program (program_id, name, content, image_path, program_date, location, program_link, sss) FROM stdin;
    public          postgres    false    233   �c       �          0    49226    program_speaker 
   TABLE DATA           >   COPY public.program_speaker (program_id, user_id) FROM stdin;
    public          postgres    false    236   od       �          0    49213    program_user 
   TABLE DATA           ;   COPY public.program_user (program_id, user_id) FROM stdin;
    public          postgres    false    235   �d       }          0    49153    refresh_tokens 
   TABLE DATA           F   COPY public.refresh_tokens (id, token, expires_at, admin) FROM stdin;
    public          postgres    false    229   �d       �          0    57437    user_calender_event 
   TABLE DATA           @   COPY public.user_calender_event (event_id, user_id) FROM stdin;
    public          postgres    false    237   Uh       �          0    57450    user_calender_program 
   TABLE DATA           D   COPY public.user_calender_program (program_id, user_id) FROM stdin;
    public          postgres    false    238   vh       p          0    24591    users 
   TABLE DATA           �   COPY public.users (user_id, is_banned, name, surname, email, password, job, photo, photo_type, is_tusas, phone, location, instagram, twitter, linkedin, facebook) FROM stdin;
    public          postgres    false    216   �h       {          0    41007    videos 
   TABLE DATA           ?   COPY public.videos (videos_id, title, videos_path) FROM stdin;
    public          postgres    false    227   �k       �           0    0    admin_admin_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.admin_admin_id_seq', 1, true);
          public          postgres    false    218            �           0    0    events_event_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.events_event_id_seq', 4, true);
          public          postgres    false    220            �           0    0    newsletter_newsletter_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.newsletter_newsletter_id_seq', 10, true);
          public          postgres    false    224            �           0    0    notification_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.notification_id_seq', 1, false);
          public          postgres    false    239            �           0    0    podcast_podcast_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.podcast_podcast_id_seq', 3, true);
          public          postgres    false    222            �           0    0    program_program_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.program_program_id_seq', 4, true);
          public          postgres    false    232            �           0    0    refresh_token_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.refresh_token_id_seq', 50, true);
          public          postgres    false    228            �           0    0    users_user_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.users_user_id_seq', 20, true);
          public          postgres    false    215            �           0    0    videos_videos_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.videos_videos_id_seq', 4, true);
          public          postgres    false    226            �           2606    40975    admin admin_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (admin_id);
 :   ALTER TABLE ONLY public.admin DROP CONSTRAINT admin_pkey;
       public            postgres    false    219            �           2606    40989    events events_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (event_id);
 <   ALTER TABLE ONLY public.events DROP CONSTRAINT events_pkey;
       public            postgres    false    221            �           2606    41005    newsletters newsletter_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.newsletters
    ADD CONSTRAINT newsletter_pkey PRIMARY KEY (newsletter_id);
 E   ALTER TABLE ONLY public.newsletters DROP CONSTRAINT newsletter_pkey;
       public            postgres    false    225            �           2606    57470    notification notification_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.notification DROP CONSTRAINT notification_pkey;
       public            postgres    false    240            �           2606    32772    otpcode otpcode_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.otpcode
    ADD CONSTRAINT otpcode_pkey PRIMARY KEY (user_id);
 >   ALTER TABLE ONLY public.otpcode DROP CONSTRAINT otpcode_pkey;
       public            postgres    false    217            �           2606    40997    podcasts podcast_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.podcasts
    ADD CONSTRAINT podcast_pkey PRIMARY KEY (podcast_id);
 ?   ALTER TABLE ONLY public.podcasts DROP CONSTRAINT podcast_pkey;
       public            postgres    false    223            �           2606    49199    program program_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.program
    ADD CONSTRAINT program_pkey PRIMARY KEY (program_id);
 >   ALTER TABLE ONLY public.program DROP CONSTRAINT program_pkey;
       public            postgres    false    233            �           2606    49159 !   refresh_tokens refresh_token_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT refresh_token_pkey PRIMARY KEY (id);
 K   ALTER TABLE ONLY public.refresh_tokens DROP CONSTRAINT refresh_token_pkey;
       public            postgres    false    229            �           2606    24597    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    216            �           2606    41013    videos videos_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.videos
    ADD CONSTRAINT videos_pkey PRIMARY KEY (videos_id);
 <   ALTER TABLE ONLY public.videos DROP CONSTRAINT videos_pkey;
       public            postgres    false    227            �           2606    49169    apply_event event_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.apply_event
    ADD CONSTRAINT event_id FOREIGN KEY (event_id) REFERENCES public.events(event_id) NOT VALID;
 >   ALTER TABLE ONLY public.apply_event DROP CONSTRAINT event_id;
       public          postgres    false    230    221    3524            �           2606    49182    event_user event_id    FK CONSTRAINT     z   ALTER TABLE ONLY public.event_user
    ADD CONSTRAINT event_id FOREIGN KEY (event_id) REFERENCES public.events(event_id);
 =   ALTER TABLE ONLY public.event_user DROP CONSTRAINT event_id;
       public          postgres    false    221    3524    231            �           2606    57440    user_calender_event event_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_calender_event
    ADD CONSTRAINT event_id FOREIGN KEY (event_id) REFERENCES public.events(event_id);
 F   ALTER TABLE ONLY public.user_calender_event DROP CONSTRAINT event_id;
       public          postgres    false    221    3524    237            �           2606    57471 &   notification notification_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 P   ALTER TABLE ONLY public.notification DROP CONSTRAINT notification_user_id_fkey;
       public          postgres    false    3518    240    216            �           2606    49203    apply_program program_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.apply_program
    ADD CONSTRAINT program_id FOREIGN KEY (program_id) REFERENCES public.program(program_id);
 B   ALTER TABLE ONLY public.apply_program DROP CONSTRAINT program_id;
       public          postgres    false    234    3534    233            �           2606    49216    program_user program_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.program_user
    ADD CONSTRAINT program_id FOREIGN KEY (program_id) REFERENCES public.program(program_id);
 A   ALTER TABLE ONLY public.program_user DROP CONSTRAINT program_id;
       public          postgres    false    3534    235    233            �           2606    49229    program_speaker program_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.program_speaker
    ADD CONSTRAINT program_id FOREIGN KEY (program_id) REFERENCES public.program(program_id);
 D   ALTER TABLE ONLY public.program_speaker DROP CONSTRAINT program_id;
       public          postgres    false    3534    236    233            �           2606    57453     user_calender_program program_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_calender_program
    ADD CONSTRAINT program_id FOREIGN KEY (program_id) REFERENCES public.program(program_id);
 J   ALTER TABLE ONLY public.user_calender_program DROP CONSTRAINT program_id;
       public          postgres    false    233    238    3534            �           2606    49174    apply_event user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.apply_event
    ADD CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id) NOT VALID;
 =   ALTER TABLE ONLY public.apply_event DROP CONSTRAINT user_id;
       public          postgres    false    3518    230    216            �           2606    49187    event_user user_id    FK CONSTRAINT     v   ALTER TABLE ONLY public.event_user
    ADD CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 <   ALTER TABLE ONLY public.event_user DROP CONSTRAINT user_id;
       public          postgres    false    216    231    3518            �           2606    49208    apply_program user_id    FK CONSTRAINT     y   ALTER TABLE ONLY public.apply_program
    ADD CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 ?   ALTER TABLE ONLY public.apply_program DROP CONSTRAINT user_id;
       public          postgres    false    234    3518    216            �           2606    49221    program_user user_id    FK CONSTRAINT     x   ALTER TABLE ONLY public.program_user
    ADD CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 >   ALTER TABLE ONLY public.program_user DROP CONSTRAINT user_id;
       public          postgres    false    216    235    3518            �           2606    49234    program_speaker user_id    FK CONSTRAINT     {   ALTER TABLE ONLY public.program_speaker
    ADD CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 A   ALTER TABLE ONLY public.program_speaker DROP CONSTRAINT user_id;
       public          postgres    false    3518    216    236            �           2606    57445    user_calender_event user_id    FK CONSTRAINT        ALTER TABLE ONLY public.user_calender_event
    ADD CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 E   ALTER TABLE ONLY public.user_calender_event DROP CONSTRAINT user_id;
       public          postgres    false    3518    237    216            �           2606    57458    user_calender_program user_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.user_calender_program
    ADD CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 G   ALTER TABLE ONLY public.user_calender_program DROP CONSTRAINT user_id;
       public          postgres    false    3518    216    238            s   0   x�3��M�����M-J�qH�M���K�����s��W� O       ~      x������ � �      �      x�3�4����� d            x�3�4����� d      u   t   x�����0c�
W���gN ��;��W�=0����T�t'*9�2
�I������1�"uk�I�.����!Ğ����D`B����b��2��`�|�OJ�z�v��a�C      y   �   x�����0 �s<E&����+w*�Tb��C���0;t0n��T1�{+w ��TQ�~�'���j9�ݳ�O\]C2�������������2	�?��4�z���؇3�}�ݟ�M4��S��Fh �$f}�      �      x������ � �      q      x������ � �      w   y   x����	1 ��v�N`7�J�^��	I�u\��@x�θ�\�T��敡O"�������V&�����B�~� K]�h���b���݋�-���t@����9  H8      �   �   x�͎��0 k{���� jDC	}bKXo�-�S0MJ�����+�j8��c�P�I�8Clk��*{j�6�q��T���H�XT�3�3}�9E�Ƙ߸��#��<W�`BHq&�2}���SG�69Kh��_�G	�����e=��%��"      �      x�3�����4�2�4bm����� >�      �      x�3�4���4����� �      }   �  x���I��H �s�����Dm�7���pYb"E�ͥEE����xڇ9z�D%ŗY�@�[\���v:�nC!KiIw>�Q����\�FhV���i���ްXz���h��^�:,���\�5D0Yx�9@�Ux���#������6�������rȚMme��ng䶱�DW�i�i����b�N�Z\��%Y�΂�24`ξ��
�!�H�?R�� �e������op��,�Cx{�i���7�x
��a�'��o���~��gK���Raea��.�hweM�vS[��$ƆzOB޴hbk��]�z6v7�z��a������؞����4T{�=#ښ��j��+PR�̉·��N�Kh����g�XNW�̙���D��GWO���$��0+�+S�c��������b�`�Q�k�Kho=k�+�¶�+�Y�m]������:n>ѣjF�:YG��cc���$p���Z����,��&zh]��h���T}U���0]�q��y�����E��3�V4ԑ� &@�"' ro]�5�˴�����dN����g��X�Ͳ��S��l�K��s���,-#�QK 9���^���_��r��Y"#�-̵�2�������*�b��ͧ�N'�<�u�G�����+����ֹȺu.�������ީ�����jօ�3P-��r��� �c��$p2��Z�%������fjeimm7X�7y�6�N*W_ۅ!.X��-��)���Wꃖ�
"w��3�=ŕ��g��f߿<��V���q�	�Q��_�;�F9:�O��
|th�+| � �6.��Q�k�O�r�Ω'0�Tp��.:Q/�Ǝ=��B&�KO���Ű=،M鲻�������/����g�8�      �      x�3�4����� d      �      x�3�4����� d      p     x���ێ�J���)��ow���Z[< ���@�h�G)@���|��gϞL��I;�a����?_>VO�D�ā߽1������ȍ�I�z�2AA^��x��G�|T��g�+f�Au\l^"\XG���A3Iq����s��"{�y��v�Ծ]���z��6o���(��i���j@1}���>~�~au�{û�C:C��.�K�-�;��"�+��L�!�.�5������)��#	����m΢t��`K��,+��a�ׄ�ĊN���\z��(d(ו��s1g^+���_��X�Cٞ��C�����T��nƾ8nthX3���2�o=��d�#Iϒ&X�����/���8mF�ׇ"��b/B�$�g�CR��U���K����eU��@��:��5���j�����~��9H&�.��b�����hsJ�<*čobJ9�5�F�!�bd���X�k��'Doj?�zi�reg0���02�1m�3;κy�k�+A����>��)Wf#7�P��Su��#ժ޹;{��ǬD�頗	��lYbh����E8w[�<+.�v*݃�}İ�@�ن.��m�Ύ�[���	�M%3�̓�.�բL�-/ϫ<˓{@��Jƾ^Ύ����f_�����m
i�-
,�B-�/<xt���$4����G�H��j5e��PL��=r,P��4U�����2���JB� ��A�����yV�{K���T� ���?�\ĤN0'scm@e�����>�6���_"����c|���;��HQ      {   S   x�3��LI��,I-.�2�t*UH�,R(�/.��M�S�,.I=2?3%��S?�8��X?719)??��(_�%�8�$�@?�+F��� �Y�     