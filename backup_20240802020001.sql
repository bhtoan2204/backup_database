--
-- PostgreSQL database dump
--

-- Dumped from database version 15.7 (Debian 15.7-0+deb12u1)
-- Dumped by pg_dump version 15.7 (Debian 15.7-0+deb12u1)

-- Started on 2024-08-02 02:00:01 UTC

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
-- TOC entry 8 (class 2615 OID 17216)
-- Name: aiven_extras; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA aiven_extras;


ALTER SCHEMA aiven_extras OWNER TO postgres;

--
-- TOC entry 2 (class 3079 OID 17217)
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- TOC entry 4312 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- TOC entry 3 (class 3079 OID 17254)
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- TOC entry 4313 (class 0 OID 0)
-- Dependencies: 3
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- TOC entry 1171 (class 1247 OID 17266)
-- Name: genre_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.genre_enum AS ENUM (
    'male',
    'female',
    'non_specified'
);


ALTER TYPE public.genre_enum OWNER TO postgres;

--
-- TOC entry 1174 (class 1247 OID 17274)
-- Name: homework_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.homework_status AS ENUM (
    'pending',
    'completed'
);


ALTER TYPE public.homework_status OWNER TO postgres;

--
-- TOC entry 1177 (class 1247 OID 17281)
-- Name: household_item_detail; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.household_item_detail AS (
	id_household_item integer,
	id_family integer,
	item_name character varying,
	item_description character varying,
	description text,
	item_imageurl character varying,
	category_name character varying,
	quantity integer,
	threshold integer,
	condition character varying,
	expired_date date
);


ALTER TYPE public.household_item_detail OWNER TO postgres;

--
-- TOC entry 1180 (class 1247 OID 17284)
-- Name: household_item_details; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.household_item_details AS (
	id_household_item integer,
	id_family integer,
	id_category integer,
	item_name character varying,
	item_description character varying,
	description text,
	item_imageurl character varying,
	quantity integer,
	threshold integer,
	condition character varying,
	category_name character varying
);


ALTER TYPE public.household_item_details OWNER TO postgres;

--
-- TOC entry 1183 (class 1247 OID 17287)
-- Name: household_item_record; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.household_item_record AS (
	id_household_item integer,
	id_family integer,
	item_name text,
	item_description text,
	item_imageurl text,
	quantity integer,
	threshold integer,
	condition text,
	category_name text
);


ALTER TYPE public.household_item_record OWNER TO postgres;

--
-- TOC entry 1186 (class 1247 OID 17290)
-- Name: household_item_update; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.household_item_update AS (
	old_imageurl text,
	new_item_name text,
	new_item_description text,
	new_id_category integer,
	new_item_imageurl text
);


ALTER TYPE public.household_item_update OWNER TO postgres;

--
-- TOC entry 1189 (class 1247 OID 17292)
-- Name: member_family_role_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.member_family_role_enum AS ENUM (
    'Member',
    'Owner'
);


ALTER TYPE public.member_family_role_enum OWNER TO postgres;

--
-- TOC entry 1192 (class 1247 OID 17298)
-- Name: order_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.order_status_enum AS ENUM (
    'PENDING',
    'SUCCESS',
    'FAILED'
);


ALTER TYPE public.order_status_enum OWNER TO postgres;

--
-- TOC entry 1360 (class 1247 OID 24751)
-- Name: otp_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.otp_type_enum AS ENUM (
    'reset_password',
    'validate_account'
);


ALTER TYPE public.otp_type_enum OWNER TO postgres;

--
-- TOC entry 1195 (class 1247 OID 17312)
-- Name: shopping_lists_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.shopping_lists_status_enum AS ENUM (
    'IN_PROGRESS',
    'COMPLETED'
);


ALTER TYPE public.shopping_lists_status_enum OWNER TO postgres;

--
-- TOC entry 1198 (class 1247 OID 17318)
-- Name: status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.status AS ENUM (
    'failed',
    'successed',
    'pending',
    'refunded'
);


ALTER TYPE public.status OWNER TO postgres;

--
-- TOC entry 1201 (class 1247 OID 17328)
-- Name: status_e; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.status_e AS ENUM (
    'Failed',
    'Succeeded',
    'Pending',
    'Refunded'
);


ALTER TYPE public.status_e OWNER TO postgres;

--
-- TOC entry 1204 (class 1247 OID 17338)
-- Name: status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.status_enum AS ENUM (
    'Failed',
    'Successed',
    'Pending',
    'Refunded'
);


ALTER TYPE public.status_enum OWNER TO postgres;

--
-- TOC entry 1207 (class 1247 OID 17348)
-- Name: subject_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.subject_status AS ENUM (
    'in_progress',
    'done'
);


ALTER TYPE public.subject_status OWNER TO postgres;

--
-- TOC entry 1210 (class 1247 OID 17354)
-- Name: type_otp; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.type_otp AS ENUM (
    'verify',
    'register',
    'forgot_password'
);


ALTER TYPE public.type_otp OWNER TO postgres;

--
-- TOC entry 1213 (class 1247 OID 17362)
-- Name: users_login_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.users_login_type_enum AS ENUM (
    'local',
    'google',
    'facebook'
);


ALTER TYPE public.users_login_type_enum OWNER TO postgres;

--
-- TOC entry 389 (class 1255 OID 17370)
-- Name: analyze_and_query_table_sizes(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.analyze_and_query_table_sizes() RETURNS TABLE("Table" name, "Total Size (KB)" bigint, "Table Size (KB)" bigint, "Index Size (KB)" bigint, "Live Tuples" bigint, "Dead Tuples" bigint)
    LANGUAGE plpgsql
    AS $$
DECLARE
    r RECORD;
BEGIN
    FOR r IN
        SELECT tablename
        FROM pg_tables
        WHERE schemaname NOT IN ('pg_catalog', 'information_schema')
    LOOP
        EXECUTE 'ANALYZE ' || quote_ident(r.tablename);
    END LOOP;

    RETURN QUERY
    SELECT
        tablename AS "Table",
        pg_total_relation_size(tablename::regclass) / 1024 AS "Total Size (KB)",
        pg_relation_size(tablename::regclass) / 1024 AS "Table Size (KB)",
        (pg_total_relation_size(tablename::regclass) - pg_relation_size(tablename::regclass)) / 1024 AS "Index Size (KB)",
        pg_stat_get_live_tuples(tablename::regclass) AS "Live Tuples",
        pg_stat_get_dead_tuples(tablename::regclass) AS "Dead Tuples"
    FROM
        pg_tables
    WHERE
        schemaname NOT IN ('pg_catalog', 'information_schema')
    ORDER BY
        pg_total_relation_size(tablename::regclass) DESC;
END;
$$;


ALTER FUNCTION public.analyze_and_query_table_sizes() OWNER TO postgres;

--
-- TOC entry 390 (class 1255 OID 17371)
-- Name: array_insert_at_index(json[], integer, json); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.array_insert_at_index(arr json[], idx integer, elem json) RETURNS json[]
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN array_cat(array_cat(array_slice(arr, 1, idx), ARRAY[elem]), array_slice(arr, idx+1, array_length(arr, 1)-idx));
END;
$$;


ALTER FUNCTION public.array_insert_at_index(arr json[], idx integer, elem json) OWNER TO postgres;

--
-- TOC entry 391 (class 1255 OID 17372)
-- Name: check_phone_number_exists(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.check_phone_number_exists(p_phone character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE
    phone_exists BOOLEAN;
BEGIN
    SELECT EXISTS (SELECT 1 FROM users WHERE phone = p_phone) INTO phone_exists;
    RETURN phone_exists;
END;
$$;


ALTER FUNCTION public.check_phone_number_exists(p_phone character varying) OWNER TO postgres;

--
-- TOC entry 392 (class 1255 OID 17373)
-- Name: compare_passwords(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.compare_passwords(input_password character varying, hashed_password character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE
    decryption_key VARCHAR;
    decrypted_password VARCHAR;
BEGIN
    -- Lấy key từ bảng key với id = 1
    SELECT key INTO decryption_key 
    FROM key 
    WHERE id = 1;

    -- Giải mã hashed_password để so sánh với input_password
    decrypted_password := pgp_sym_decrypt(hashed_password::BYTEA, decryption_key);

    -- So sánh mật khẩu đã giải mã với mật khẩu nhập vào
    if decrypted_password = input_password then
    	return true;
    else 
    	return false;
    end if;
END;
$$;


ALTER FUNCTION public.compare_passwords(input_password character varying, hashed_password character varying) OWNER TO postgres;

--
-- TOC entry 393 (class 1255 OID 17374)
-- Name: create_category_event(character varying, character varying, integer, uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.create_category_event(_title character varying, _color character varying, _id_family integer, _id_user uuid) RETURNS TABLE(id_category_event integer, title character varying, color character varying, id_family integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM member_family f WHERE f.id_family = _id_family AND f.id_user = _id_user) THEN
        IF NOT EXISTS (SELECT 1 FROM category_event ce WHERE ce.title = _title AND ce.id_family = _id_family) THEN
            RETURN QUERY
            INSERT INTO category_event (title, color, id_family, created_at, updated_at)
            VALUES (_title, _color, _id_family, now(), now() )
            RETURNING category_event.id_category_event, category_event.title, category_event.color, category_event.id_family;
        ELSE
            RAISE EXCEPTION 'Title already exists in the specified family';
        END IF;
    ELSE
        RAISE EXCEPTION 'User does not belong to the specified family';
    END IF;
END;
$$;


ALTER FUNCTION public.create_category_event(_title character varying, _color character varying, _id_family integer, _id_user uuid) OWNER TO postgres;

--
-- TOC entry 394 (class 1255 OID 17375)
-- Name: create_users_from_table(); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.create_users_from_table()
    LANGUAGE plpgsql
    AS $$
DECLARE
    user_record RECORD;
    user_exists BOOLEAN;
BEGIN
    FOR user_record IN SELECT * FROM users LOOP
        BEGIN
            -- Kiểm tra xem người dùng đã tồn tại chưa
            EXECUTE 'SELECT EXISTS (SELECT FROM pg_catalog.pg_user WHERE usename = ''' || user_record.id_user || ''')' INTO user_exists;
            
            -- Nếu người dùng chưa tồn tại, tạo người dùng mới
            IF NOT user_exists THEN
                EXECUTE 'CREATE USER "' || user_record.id_user || '" WITH PASSWORD ' || quote_literal(user_record.password) || ';';
                RAISE NOTICE 'User % created successfully', user_record.id_user;
            END IF;
        EXCEPTION
            WHEN others THEN
                RAISE EXCEPTION 'Failed to create user %: %', user_record.id_user, SQLERRM;
        END;
    END LOOP;
END;
$$;


ALTER PROCEDURE public.create_users_from_table() OWNER TO postgres;

--
-- TOC entry 395 (class 1255 OID 17376)
-- Name: decrease_family_quantity(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.decrease_family_quantity() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF TG_OP = 'DELETE' THEN
        UPDATE family SET quantity = quantity - 1 WHERE id_family = OLD.id_family;
    END IF;
    RETURN OLD;
END;
$$;


ALTER FUNCTION public.decrease_family_quantity() OWNER TO postgres;

--
-- TOC entry 396 (class 1255 OID 17377)
-- Name: decryption(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.decryption(encrypted_data text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
    p_key TEXT;
BEGIN
    -- Lấy key từ bảng key với id = 1
    SELECT key INTO p_key FROM "key" WHERE id = 1;
    -- Giải mã dữ liệu với key đã lấy
    RETURN pgp_sym_decrypt(encrypted_data::BYTEA, p_key)::TEXT;
END;
$$;


ALTER FUNCTION public.decryption(encrypted_data text) OWNER TO postgres;

--
-- TOC entry 374 (class 1255 OID 17381)
-- Name: encrypt(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.encrypt(data text) RETURNS bytea
    LANGUAGE plpgsql
    AS $$
DECLARE
    key_bytea bytea;
BEGIN
    SELECT key INTO key_bytea FROM key WHERE id = 1;
    RETURN pgp_sym_encrypt(data, key_bytea, 'compress-algo=1, cipher-algo=aes256');
END;
$$;


ALTER FUNCTION public.encrypt(data text) OWNER TO postgres;

--
-- TOC entry 397 (class 1255 OID 17382)
-- Name: encrypt_user_password(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.encrypt_user_password() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    encryption_key VARCHAR;
BEGIN
    SELECT key INTO encryption_key 
    FROM key 
    where id=1;

    IF TG_OP = 'INSERT' then
        EXECUTE 'CREATE USER "' || NEW.id_user || '" WITH PASSWORD ' || quote_literal(NEW.password) || ';';
        NEW.password := encryption(NEW.password);
       
        EXECUTE 'GRANT CONNECT ON DATABASE defaultdb TO "' || NEW.id_user || '";';

    ELSIF TG_OP = 'UPDATE' then
    	EXECUTE 'ALTER USER "' || NEW.id_user || '" WITH PASSWORD ' || quote_literal(NEW.password) || ';';
        NEW.password := encryption(NEW.password);

    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public.encrypt_user_password() OWNER TO postgres;

--
-- TOC entry 398 (class 1255 OID 17383)
-- Name: encryption(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.encryption(data text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
    p_key TEXT;
BEGIN
    -- Lấy key từ bảng key với id = 1
    SELECT key INTO p_key FROM "key" WHERE id = 1;
    -- Mã hóa dữ liệu với key đã lấy
    RETURN pgp_sym_encrypt(data, p_key, 'compress-algo=1, cipher-algo=aes256')::TEXT;
END;
$$;


ALTER FUNCTION public.encryption(data text) OWNER TO postgres;

--
-- TOC entry 402 (class 1255 OID 17410)
-- Name: f_create_invoice_items(uuid, integer, integer, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_create_invoice_items(p_id_user uuid, p_id_family integer, p_id_invoice integer, p_items text) RETURNS TABLE(id_item integer, id_invoice integer, item_description character varying, item_name character varying, quantity integer, unit_price numeric, total_price numeric)
    LANGUAGE plpgsql
    AS $$
DECLARE
    invoice_item JSONB;
    invoice_items JSONB[];
BEGIN
    invoice_items := ARRAY(SELECT jsonb_array_elements(p_items::JSONB));

    FOR invoice_item IN SELECT * FROM jsonb_array_elements(p_items::JSONB)
    LOOP
        IF NOT EXISTS (
            SELECT 1 FROM member_family 
            WHERE id_user = p_id_user AND id_family = p_id_family
        ) THEN
            RAISE EXCEPTION 'User with id % is not a member of family with id %', p_id_user, p_id_family;
        END IF;

        -- Insert the invoice item and capture the returning values
        INSERT INTO invoice_items (id_invoice, item_description, item_name, quantity, unit_price)
        VALUES (
            p_id_invoice,
            invoice_item->>'item_description',
            invoice_item->>'item_name',
            (invoice_item->>'quantity')::INTEGER,
            (invoice_item->>'unit_price')::NUMERIC
        )
        RETURNING 
            invoice_items.id_item, 
            invoice_items.id_invoice, 
            invoice_items.item_description, 
            invoice_items.item_name, 
            invoice_items.quantity, 
            invoice_items.unit_price,
			invoice_items.total_price
        INTO 
            id_item, 
            id_invoice, 
            item_description, 
            item_name, 
            quantity, 
            unit_price,
			total_price;

        -- Return the inserted values
        RETURN NEXT; 
    END LOOP;
END;
$$;


ALTER FUNCTION public.f_create_invoice_items(p_id_user uuid, p_id_family integer, p_id_invoice integer, p_items text) OWNER TO postgres;

--
-- TOC entry 403 (class 1255 OID 17411)
-- Name: f_create_invoice_type(uuid, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_create_invoice_type(p_id_user uuid, p_id_family integer, p_type_name character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_id_invoice_type INTEGER;
BEGIN
    INSERT INTO invoice_type (type_name, id_family)
    VALUES (p_type_name, p_id_family)
    RETURNING id_invoice_type INTO v_id_invoice_type;

    RETURN v_id_invoice_type;
END;
$$;


ALTER FUNCTION public.f_create_invoice_type(p_id_user uuid, p_id_family integer, p_type_name character varying) OWNER TO postgres;

--
-- TOC entry 404 (class 1255 OID 17412)
-- Name: f_create_order(uuid, integer, integer, character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_create_order(p_id_user uuid, p_id_package integer, p_amount integer, p_method character varying, p_id_family integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    user_exists BOOLEAN;
    new_id int;
    p_price int;
    p_expired int;
BEGIN
    IF p_id_family = 0 THEN
        SELECT EXISTS(SELECT 1 FROM users WHERE id_user = p_id_user) INTO user_exists;
        
        SELECT price, expired INTO p_price, p_expired 
        FROM package 
        WHERE id_package = p_id_package AND price = p_amount;

        IF NOT user_exists THEN
            RAISE EXCEPTION 'User does not exist';
        ELSIF p_price IS NULL THEN
            RAISE EXCEPTION 'Package does not match';
        ELSE
            BEGIN
                INSERT INTO "order"(id_user, id_package, status, created_at, expired_at, id_family, method) 
                VALUES (p_id_user, p_id_package, 'Pending', NOW(), NOW() + INTERVAL '1 month' * p_expired, null, p_method)
                RETURNING id_order INTO new_id;
                RETURN new_id;
            EXCEPTION
                WHEN others THEN
                    RAISE EXCEPTION 'Failed to create order: %', SQLERRM;
            END;
        END IF;
    ELSE 
        BEGIN
            INSERT INTO "order"(id_user, id_package, status, created_at, expired_at, id_family, method) 
            VALUES (p_id_user, p_id_package, 'Pending', NOW(), NOW() + INTERVAL '1 month' * p_expired, p_id_family, p_method)
            RETURNING id_order INTO new_id;
           	RETURN new_id;

        END;
    END IF;
END;
$$;


ALTER FUNCTION public.f_create_order(p_id_user uuid, p_id_package integer, p_amount integer, p_method character varying, p_id_family integer) OWNER TO postgres;

--
-- TOC entry 405 (class 1255 OID 17413)
-- Name: f_create_room(uuid, integer, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_create_room(p_id_user uuid, p_id_family integer, p_room_name text) RETURNS TABLE(id_room integer, room_name character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY INSERT INTO room (id_family, room_name) 
                     VALUES (p_id_family, p_room_name) 
                     RETURNING room.id_room, room.room_name;
END;
$$;


ALTER FUNCTION public.f_create_room(p_id_user uuid, p_id_family integer, p_room_name text) OWNER TO postgres;

--
-- TOC entry 406 (class 1255 OID 17414)
-- Name: f_create_shopping_item(uuid, integer, text, integer, integer, integer, timestamp without time zone, numeric, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_create_shopping_item(p_id_user uuid, p_id_list integer, p_item_name text, p_quantity integer, p_id_item_type integer, p_priority_level integer, p_reminder_date timestamp without time zone, p_price numeric, p_description text) RETURNS TABLE(id_item integer, id_list integer, item_name character varying, quantity integer, is_purchased boolean, id_item_type integer, priority_level integer, reminder_date timestamp without time zone, price numeric, description character varying)
    LANGUAGE plpgsql
    AS $$
begin
	IF NOT EXISTS (
        SELECT 1 
		FROM member_family mb 
		JOIN shopping_lists sl ON mb.id_family = sl.id_family
		WHERE sl.id_list = p_id_list AND mb.id_user = p_id_user
    ) THEN
        RAISE EXCEPTION 'User is not part of the specified family.';
    END IF;
	
	RETURN QUERY
	insert into shopping_items(id_list, item_name, quantity, is_purchased, id_item_type, priority_level, reminder_date, price, description)
	values (p_id_list, p_item_name, p_quantity, false, p_id_item_type, p_priority_level, p_reminder_date, p_price, p_description)
	returning
		shopping_items.id_item,
		shopping_items.id_list,
		shopping_items.item_name,
		shopping_items.quantity,
		shopping_items.is_purchased,
		shopping_items.id_item_type,
		shopping_items.priority_level,
		shopping_items.reminder_date,
		shopping_items.price,
		shopping_items.description;
		
	EXCEPTION
    WHEN OTHERS THEN
        RAISE;
end;
$$;


ALTER FUNCTION public.f_create_shopping_item(p_id_user uuid, p_id_list integer, p_item_name text, p_quantity integer, p_id_item_type integer, p_priority_level integer, p_reminder_date timestamp without time zone, p_price numeric, p_description text) OWNER TO postgres;

--
-- TOC entry 407 (class 1255 OID 17415)
-- Name: f_create_shopping_list(uuid, integer, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_create_shopping_list(p_id_user uuid, p_id_family integer, p_title text, p_description text) RETURNS TABLE(id_list integer, id_family integer, title character varying, created_at timestamp with time zone, updated_at timestamp with time zone, status character varying, description character varying)
    LANGUAGE plpgsql
    AS $$
begin
	RETURN QUERY
	insert into shopping_lists(id_family, title, description)
	values (p_id_family, p_title, p_description)
	returning
		shopping_lists.id_list,
		shopping_lists.id_family,
		shopping_lists.title,
		shopping_lists.created_at,
		shopping_lists.updated_at,
		shopping_lists.status,
		shopping_lists.description;
	
	EXCEPTION
    WHEN OTHERS THEN
        RAISE;
end;
$$;


ALTER FUNCTION public.f_create_shopping_list(p_id_user uuid, p_id_family integer, p_title text, p_description text) OWNER TO postgres;

--
-- TOC entry 410 (class 1255 OID 17416)
-- Name: f_create_subject(text, integer, integer, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_create_subject(p_id_user text, p_id_education_progress integer, p_id_family integer, p_subject_name text, p_description text) RETURNS TABLE(id_subject integer, subject_name character varying, description text, component_scores json, midterm_score double precision, final_score double precision, bonus_score double precision, status public.subject_status)
    LANGUAGE plpgsql
    AS $$
begin
	IF NOT EXISTS (
        SELECT 1 FROM education_progress
        WHERE id_education_progress = p_id_education_progress
    ) THEN
        RAISE EXCEPTION 'Education Progress ID % not found.', p_id_education_progress;
    END IF;
	
	RETURN QUERY
	INSERT INTO subjects (
        id_education_progress,
        subject_name,
        description,
        component_scores,
        midterm_score,
        final_score,
        bonus_score,
        status
    )
    VALUES (p_id_education_progress, p_subject_name, p_description, '{}'::JSON, NULL, NULL, NULL, 'in_progress')
	
	RETURNING subjects.id_subject, subjects.subject_name, subjects.description, 
	subjects.component_scores, subjects.midterm_score, subjects.final_score, subjects.bonus_score, subjects.status;
END;
$$;


ALTER FUNCTION public.f_create_subject(p_id_user text, p_id_education_progress integer, p_id_family integer, p_subject_name text, p_description text) OWNER TO postgres;

--
-- TOC entry 411 (class 1255 OID 17417)
-- Name: f_create_user(text, text, text, text, text, text, date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_create_user(p_email text, p_phone text, p_password text, p_firstname text, p_lastname text, p_genre text, p_birthdate date) RETURNS uuid
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_user_id UUID;
BEGIN
    IF EXISTS (SELECT 1 FROM users WHERE (email = p_email AND login_type ='local') OR (phone = p_phone and isphoneverified = true)) THEN
        RAISE EXCEPTION 'Email or phone is already in used';
    END IF;

    INSERT INTO users (email, phone, "password", firstname, lastname, genre, birthdate, avatar, "language", login_type, isemailverified)
    VALUES (p_email, p_phone, p_password, p_firstname, p_lastname, p_genre, p_birthdate, 
		'https://static.vecteezy.com/system/resources/previews/020/911/740/non_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png',
		'vn', 'local', true)
    RETURNING id_user INTO v_user_id;

    RETURN v_user_id;
END;
$$;


ALTER FUNCTION public.f_create_user(p_email text, p_phone text, p_password text, p_firstname text, p_lastname text, p_genre text, p_birthdate date) OWNER TO postgres;

--
-- TOC entry 412 (class 1255 OID 17418)
-- Name: f_create_user(character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_create_user(p_gmail character varying, p_phone character varying, p_password character varying, p_firstname character varying, p_lastname character varying, p_language character varying, p_login_type character varying, p_avatar character varying) RETURNS uuid
    LANGUAGE plpgsql
    AS $$
DECLARE
    new_id UUID;
	casted_login_type users_login_type_enum;
BEGIN
    -- Kiểm tra số điện thoại
    IF p_phone IS NOT NULL AND f_validate_user_phone(p_phone) THEN
        RAISE EXCEPTION 'Phone number % already exists', p_phone;
    END IF;

    casted_login_type := p_login_type::users_login_type_enum;

    BEGIN
        INSERT INTO users(
            id_user, email, phone, "password", "language", created_at, 
            login_type, firstname, lastname, avatar
        )
        VALUES (
            f_generate_unique_uuid(), p_gmail, p_phone, p_password, 
            p_language, CURRENT_TIMESTAMP, casted_login_type, p_firstname, p_lastname, p_avatar
        )
        RETURNING id_user INTO new_id;
    EXCEPTION WHEN others THEN
        RAISE EXCEPTION 'Failed to create user: %', SQLERRM;
    END; 

    RETURN new_id;
END;
$$;


ALTER FUNCTION public.f_create_user(p_gmail character varying, p_phone character varying, p_password character varying, p_firstname character varying, p_lastname character varying, p_language character varying, p_login_type character varying, p_avatar character varying) OWNER TO postgres;

--
-- TOC entry 413 (class 1255 OID 17419)
-- Name: f_delete_asset(text, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_delete_asset(p_id_user text, p_id_family integer, p_id_asset integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_deleted_count INT;
BEGIn
    DELETE FROM finance_assets
    WHERE id_family = p_id_family AND id_asset = p_id_asset;
	
	GET DIAGNOSTICS v_deleted_count = ROW_COUNT;
	
	IF v_deleted_count > 0 THEN
        RETURN 'Asset deleted successfully.';
    ELSE
        RETURN 'Asset not found or could not be deleted.';
    END IF;
END;
$$;


ALTER FUNCTION public.f_delete_asset(p_id_user text, p_id_family integer, p_id_asset integer) OWNER TO postgres;

--
-- TOC entry 414 (class 1255 OID 17420)
-- Name: f_delete_calendar_event(uuid, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_delete_calendar_event(p_id_user uuid, p_id_calendar integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM calendar
        WHERE id_calendar = p_id_calendar;
        RETURN TRUE;
END;
$$;


ALTER FUNCTION public.f_delete_calendar_event(p_id_user uuid, p_id_calendar integer) OWNER TO postgres;

--
-- TOC entry 415 (class 1255 OID 17421)
-- Name: f_delete_component_score(text, integer, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_delete_component_score(p_id_user text, p_id_subject integer, p_id_family integer, p_id_education_progress integer, p_index integer) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    current_component_scores JSONB;
    updated_component_scores JSONB := '[]'::JSONB;
    component_array JSONB[];
    array_length INT;
BEGIN
    SELECT component_scores INTO current_component_scores FROM subjects WHERE id_subject = p_id_subject AND id_education_progress = p_id_education_progress;

    -- Kiểm tra nếu component_scores là NULL hoặc là một đối tượng rỗng
    IF current_component_scores IS NULL OR current_component_scores = '{}'::JSONB THEN
        RAISE EXCEPTION 'No component scores available to delete for subject ID %.', p_id_subject;
    ELSE
        component_array := ARRAY(SELECT jsonb_array_elements(current_component_scores -> 'component_scores'));
        array_length := array_length(component_array, 1);

        -- Điều chỉnh chỉ mục để phù hợp với bắt đầu từ 0 và kiểm tra tính hợp lệ
        IF p_index < 0 OR p_index >= array_length THEN
            RAISE EXCEPTION 'Index out of bounds. Valid index is between 0 and %', array_length - 1;
        END IF;

        -- Loại bỏ giá trị tại index chỉ định bằng cách không thêm nó vào updated_component_scores
        FOR i IN 1..array_length LOOP
            IF i - 1 != p_index THEN
                updated_component_scores := updated_component_scores || component_array[i];
            END IF;
        END LOOP;

        updated_component_scores := jsonb_build_object('component_scores', updated_component_scores);
    END IF;

    UPDATE subjects
    SET component_scores = updated_component_scores
    WHERE id_subject = p_id_subject AND id_education_progress = p_id_education_progress;

    RETURN updated_component_scores;
END;
$$;


ALTER FUNCTION public.f_delete_component_score(p_id_user text, p_id_subject integer, p_id_family integer, p_id_education_progress integer, p_index integer) OWNER TO postgres;

--
-- TOC entry 416 (class 1255 OID 17422)
-- Name: f_delete_education_progress(text, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_delete_education_progress(p_id_user text, p_id_family integer, p_id_education_progress integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM education_progress
    WHERE id_education_progress = p_id_education_progress;

    RETURN 'Delete Successfully';

END;
$$;


ALTER FUNCTION public.f_delete_education_progress(p_id_user text, p_id_family integer, p_id_education_progress integer) OWNER TO postgres;

--
-- TOC entry 417 (class 1255 OID 17423)
-- Name: f_delete_expenditure(text, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_delete_expenditure(p_id_user text, p_id_family integer, p_id_expenditure integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM member_family
        WHERE id_user = p_id_user::uuid AND id_family = p_id_family
    ) AND EXISTS (
        SELECT 1 FROM finance_expenditure
        WHERE id_expenditure = p_id_expenditure AND id_family = p_id_family
    ) THEN
        DELETE FROM finance_expenditure
        WHERE id_expenditure = p_id_expenditure;

        RETURN TRUE;
    ELSE
        RAISE EXCEPTION 'User is not authorized to delete this expenditure or it does not exist.';
    END IF;
END;
$$;


ALTER FUNCTION public.f_delete_expenditure(p_id_user text, p_id_family integer, p_id_expenditure integer) OWNER TO postgres;

--
-- TOC entry 418 (class 1255 OID 17424)
-- Name: f_delete_expenditure_type(uuid, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_delete_expenditure_type(p_id_user uuid, p_id_family integer, p_id_expenditure_type integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_exists BOOLEAN;
    v_expenditure_details JSONB;
BEGIN
    -- Truy vấn expenditure_details từ bảng finance_expenditure_type
    SELECT expenditure_details INTO v_expenditure_details
    FROM finance_expenditure_type
    WHERE id_family = p_id_family;

    -- Nếu expenditure_details không tồn tại hoặc không chứa id_expenditure_type, không có gì để xóa
    IF v_expenditure_details IS NULL OR NOT EXISTS (SELECT * FROM jsonb_array_elements(v_expenditure_details) AS category WHERE (category->>'id_expense_type')::INTEGER = p_id_expenditure_type) THEN
        RAISE EXCEPTION 'Expenditure type with specified ID does not exist.';
    END IF;

    -- Xóa loại chi tiêu từ expenditure_details
    v_expenditure_details := (SELECT jsonb_agg(category) FROM jsonb_array_elements(v_expenditure_details) AS category WHERE (category->>'id_expense_type')::INTEGER <> p_id_expenditure_type);

    -- Cập nhật lại expenditure_details trong bảng finance_expenditure_type
    UPDATE finance_expenditure_type
    SET expenditure_details = v_expenditure_details
    WHERE id_family = p_id_family;
END;
$$;


ALTER FUNCTION public.f_delete_expenditure_type(p_id_user uuid, p_id_family integer, p_id_expenditure_type integer) OWNER TO postgres;

--
-- TOC entry 419 (class 1255 OID 17425)
-- Name: f_delete_family(uuid, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_delete_family(p_id_user uuid, p_id_family integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
declare 
	result_message varchar;
	recordCount int;
begin
	SELECT COUNT(*) INTO recordCount FROM member_family WHERE id_user = p_id_user AND id_family = p_id_family and role='owner';
	if recordCount> 0 then 
	    BEGIN
	        DELETE FROM family WHERE id_family = p_id_family;
	       	result_message := 'Successfully deleted family';
	    EXCEPTION
	        WHEN others THEN
	            result_message:= 'Fail to delete family';
 		end;
	else 
       	result_message:= 'Not the owner of the family';

    end if;
   return result_message;
END;
$$;


ALTER FUNCTION public.f_delete_family(p_id_user uuid, p_id_family integer) OWNER TO postgres;

--
-- TOC entry 420 (class 1255 OID 17426)
-- Name: f_delete_finance_income_source(uuid, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_delete_finance_income_source(p_id_user uuid, p_id_family integer, p_id_income_source integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_exists BOOLEAN;
    v_income_details JSONB;
BEGIN
    -- Truy vấn income_details từ bảng finance_income_source
    SELECT income_details INTO v_income_details
    FROM finance_income_source
    WHERE id_family = p_id_family;

    -- Nếu income_details không tồn tại hoặc không chứa id_income_source, không có gì để xóa
    IF v_income_details IS NULL OR NOT EXISTS (SELECT * FROM jsonb_array_elements(v_income_details) AS source WHERE (source->>'id_income_source')::INTEGER = p_id_income_source) THEN
        RAISE EXCEPTION 'Income source with specified ID does not exist.';
    END IF;

    -- Xóa nguồn thu nhập từ income_details
    v_income_details := (SELECT jsonb_agg(source) FROM jsonb_array_elements(v_income_details) AS source WHERE (source->>'id_income_source')::INTEGER <> p_id_income_source);

    -- Cập nhật lại income_details trong bảng finance_income_source
    UPDATE finance_income_source
    SET income_details = v_income_details
    WHERE id_family = p_id_family;
END;
$$;


ALTER FUNCTION public.f_delete_finance_income_source(p_id_user uuid, p_id_family integer, p_id_income_source integer) OWNER TO postgres;

--
-- TOC entry 421 (class 1255 OID 17427)
-- Name: f_delete_guideline(character varying, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_delete_guideline(p_id_user character varying, p_id_family integer, p_id_guideline integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM guide_items
    WHERE id_family = p_id_family AND id_item = p_id_guideline;
    
    IF NOT FOUND THEN
        RAISE EXCEPTION 'No guideline found with ID % in family ID %.', p_id_guideline, p_id_family;
    END IF;

    RETURN 'Guideline with ID ' || p_id_guideline || ' has been successfully deleted.';
END;
$$;


ALTER FUNCTION public.f_delete_guideline(p_id_user character varying, p_id_family integer, p_id_guideline integer) OWNER TO postgres;

--
-- TOC entry 422 (class 1255 OID 17428)
-- Name: f_delete_guideline_step(character varying, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_delete_guideline_step(p_id_user character varying, p_id_family integer, p_id_guideline integer, p_step_index integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
    current_steps JSONB;
    removed_step JSONB;
    updated_steps JSONB;
    image_url TEXT;
BEGIN
    SELECT step INTO current_steps FROM guide_items WHERE id_family = p_id_family AND id_item = p_id_guideline;
    
    current_steps := current_steps::JSONB;
    
    SELECT (current_steps->'steps'->p_step_index) INTO removed_step;
    image_url := removed_step->>'imageUrl';
    
    updated_steps := (
        SELECT jsonb_agg(elem) 
        FROM jsonb_array_elements(current_steps->'steps') WITH ORDINALITY arr(elem, idx)
        WHERE idx - 1 <> p_step_index
    );
    
    UPDATE guide_items
    SET step = jsonb_set(current_steps, '{steps}', updated_steps)
    WHERE id_family = p_id_family AND id_item = p_id_guideline;
    
    RETURN image_url;
END;
$$;


ALTER FUNCTION public.f_delete_guideline_step(p_id_user character varying, p_id_family integer, p_id_guideline integer, p_step_index integer) OWNER TO postgres;

--
-- TOC entry 423 (class 1255 OID 17429)
-- Name: f_delete_household_item(text, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_delete_household_item(p_id_user text, p_id_family integer, p_id_household_item integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_is_member BOOLEAN;
    v_image_url TEXT;
BEGIN
    SELECT item_imageurl INTO v_image_url FROM household_items
    WHERE id_household_item = p_id_household_item AND id_family = p_id_family;

    IF v_image_url IS NULL THEN
        RAISE EXCEPTION 'Item does not exist or does not belong to this family.';
        RETURN NULL;
    END IF;

    DELETE FROM household_items
    WHERE id_household_item = p_id_household_item AND id_family = p_id_family;

    RETURN v_image_url;
END;
$$;


ALTER FUNCTION public.f_delete_household_item(p_id_user text, p_id_family integer, p_id_household_item integer) OWNER TO postgres;

--
-- TOC entry 424 (class 1255 OID 17430)
-- Name: f_delete_income(text, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_delete_income(p_id_user text, p_id_family integer, p_id_income integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM member_family AS mf
        JOIN finance_income AS fi ON mf.id_family = fi.id_family
        WHERE mf.id_user = uuid(p_id_user)
        AND mf.id_family = p_id_family
        AND fi.id_income = p_id_income
    ) THEN
        DELETE FROM finance_income
        WHERE id_income = p_id_income;

        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$;


ALTER FUNCTION public.f_delete_income(p_id_user text, p_id_family integer, p_id_income integer) OWNER TO postgres;

--
-- TOC entry 425 (class 1255 OID 17431)
-- Name: f_delete_invoice(uuid, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_delete_invoice(id_user_param uuid, id_family_param integer, id_invoice_param integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
    old_imageurl text;
BEGIN
    SELECT imageurl INTO old_imageurl 
    FROM invoice 
    WHERE id_invoice = id_invoice_param;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Invoice does not exist.';
        RETURN NULL;
    END IF;
	
	DELETE FROM invoice_items
    WHERE id_invoice = id_invoice_param;

    DELETE FROM invoice
    WHERE id_invoice = id_invoice_param;

    RETURN old_imageurl;
END;
$$;


ALTER FUNCTION public.f_delete_invoice(id_user_param uuid, id_family_param integer, id_invoice_param integer) OWNER TO postgres;

--
-- TOC entry 401 (class 1255 OID 17432)
-- Name: f_delete_invoice_item(uuid, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_delete_invoice_item(p_id_user uuid, p_id_family integer, p_id_invoice integer, p_id_item integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 
        FROM member_family mf
        JOIN invoice i ON mf.id_family = i.id_family
        JOIN invoice_items ii ON i.id_invoice = ii.id_invoice
        WHERE mf.id_user = p_id_user 
          AND mf.id_family = p_id_family
          AND i.id_invoice = p_id_invoice
          AND ii.id_item = p_id_item
    ) THEN
        RAISE EXCEPTION 'Validation failed: either user is not a member of the family, invoice not found in family, or invoice item not found in invoice';
    END IF;

    DELETE FROM invoice_items
    WHERE id_item = p_id_item;
END;
$$;


ALTER FUNCTION public.f_delete_invoice_item(p_id_user uuid, p_id_family integer, p_id_invoice integer, p_id_item integer) OWNER TO postgres;

--
-- TOC entry 408 (class 1255 OID 17433)
-- Name: f_delete_invoice_type(uuid, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_delete_invoice_type(p_id_user uuid, p_id_family integer, p_id_invoice_type integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM invoice_type 
    WHERE id_invoice_type = p_id_invoice_type AND id_family = p_id_family;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'No invoice type found for user with id %, family with id %, and invoice type with id %', p_id_user, p_id_family, p_id_invoice_type;
    END IF;
END;
$$;


ALTER FUNCTION public.f_delete_invoice_type(p_id_user uuid, p_id_family integer, p_id_invoice_type integer) OWNER TO postgres;

--
-- TOC entry 427 (class 1255 OID 17434)
-- Name: f_delete_member(uuid, uuid, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_delete_member(p_id_current_user uuid, p_id_user uuid, p_id_family integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
    recordCount_member int;
   	result_message varchar;
   	recordCount_owner int;
BEGIN 
	select count(*) into recordCount_owner from member_family where id_user=p_id_current_user and id_family = p_id_family and role='owner';

    SELECT COUNT(*) INTO recordCount_member FROM member_family WHERE id_user = p_id_user AND id_family = p_id_family;
    if recordCount_owner>0 then
   	begin
		if recordCount_member> 0 then
	        BEGIN
	            delete from member_family where id_family=p_id_family and p_id_user=id_user;
	           	   	result_message:= 'Successfully deleted member';
	
	        EXCEPTION
			    WHEN others THEN
			        result_message:= 'Failed to delete member';
	        END;
	    ELSE
	        result_message:= 'Invalid family or user provided';
	    END IF;
	 end;
	else 
		result_message := 'The current user is not the owner of this family';
	end if;
   return result_message;
END;
$$;


ALTER FUNCTION public.f_delete_member(p_id_current_user uuid, p_id_user uuid, p_id_family integer) OWNER TO postgres;

--
-- TOC entry 428 (class 1255 OID 17435)
-- Name: f_delete_otp_by_email(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_delete_otp_by_email(p_email character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM otp
    WHERE id_user IN (SELECT id_user FROM users WHERE email = p_email and login_type = 'local')
    AND otp_type = 'forgot password';
END;
$$;


ALTER FUNCTION public.f_delete_otp_by_email(p_email character varying) OWNER TO postgres;

--
-- TOC entry 429 (class 1255 OID 17436)
-- Name: f_delete_otp_by_phone(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_delete_otp_by_phone(p_phone character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM otp
    WHERE id_user IN (SELECT id_user FROM users WHERE phone = p_phone and login_type = 'local')
    AND otp_type = 'forgot password';
END;
$$;


ALTER FUNCTION public.f_delete_otp_by_phone(p_phone character varying) OWNER TO postgres;

--
-- TOC entry 430 (class 1255 OID 17437)
-- Name: f_delete_refresh_token(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_delete_refresh_token(refresh_token_value character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM refresh_token WHERE refresh_token = refresh_token_value;
END;
$$;


ALTER FUNCTION public.f_delete_refresh_token(refresh_token_value character varying) OWNER TO postgres;

--
-- TOC entry 431 (class 1255 OID 17438)
-- Name: f_delete_room(uuid, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_delete_room(p_id_user uuid, p_id_family integer, p_id_room integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM household_items WHERE id_room = p_id_room;
        
    DELETE FROM room WHERE id_room = p_id_room AND id_family = p_id_family;
	
	RETURN 'Delete room successfully';
END;
$$;


ALTER FUNCTION public.f_delete_room(p_id_user uuid, p_id_family integer, p_id_room integer) OWNER TO postgres;

--
-- TOC entry 432 (class 1255 OID 17439)
-- Name: f_delete_shopping_item(uuid, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_delete_shopping_item(p_id_user uuid, p_id_family integer, p_id_list integer, p_id_item integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM shopping_items si
        JOIN shopping_lists sl ON si.id_list = sl.id_list
        JOIN member_family mf ON sl.id_family = mf.id_family
        WHERE si.id_item = p_id_item 
          AND mf.id_user = p_id_user 
          AND sl.id_family = p_id_family 
          AND sl.id_list = p_id_list
    ) THEN
        RAISE EXCEPTION 'User does not have permission to delete this shopping item';
    END IF;

    -- Xóa shopping item
    DELETE FROM shopping_items
    WHERE id_item = p_id_item;
    
    RETURN 'Deleted'; -- Trả về text "Deleted"

END;
$$;


ALTER FUNCTION public.f_delete_shopping_item(p_id_user uuid, p_id_family integer, p_id_list integer, p_id_item integer) OWNER TO postgres;

--
-- TOC entry 433 (class 1255 OID 17440)
-- Name: f_delete_shopping_list(uuid, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_delete_shopping_list(p_id_user uuid, p_id_family integer, p_id_list integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM shopping_lists sl
        JOIN member_family mf ON sl.id_family = mf.id_family
        WHERE sl.id_list = p_id_list AND mf.id_user = p_id_user AND sl.id_family = p_id_family
    ) THEN
        RAISE EXCEPTION 'User does not have permission to delete this shopping list';
    END IF;

    DELETE FROM shopping_items
    WHERE id_list = p_id_list;

    DELETE FROM shopping_lists
    WHERE id_list = p_id_list;
    
    RETURN 'Deleted shopping list successful'; -- Trả về text "Deleted"

END;
$$;


ALTER FUNCTION public.f_delete_shopping_list(p_id_user uuid, p_id_family integer, p_id_list integer) OWNER TO postgres;

--
-- TOC entry 434 (class 1255 OID 17441)
-- Name: f_delete_subject(text, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_delete_subject(p_id_user text, p_id_family integer, p_id_education_progress integer, p_id_subject integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM education_progress WHERE id_family = p_id_family AND education_progress.id_education_progress = p_id_education_progress) THEN
        RAISE EXCEPTION 'Family or education progress not found.';
    END IF;
	
	IF NOT EXISTS (SELECT 1 FROM subjects WHERE id_subject = p_id_subject AND id_education_progress = p_id_education_progress) THEN
        RAISE EXCEPTION 'Subject not found.';
    END IF;
	
	DELETE FROM subjects
    WHERE id_subject = p_id_subject AND id_education_progress = p_id_education_progress;

    RETURN 'Subject deleted successfully.';
END;
$$;


ALTER FUNCTION public.f_delete_subject(p_id_user text, p_id_family integer, p_id_education_progress integer, p_id_subject integer) OWNER TO postgres;

--
-- TOC entry 435 (class 1255 OID 17442)
-- Name: f_find_user(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_find_user(p_id_user uuid) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
    first_name TEXT;
    last_name TEXT;
BEGIN
    -- Sử dụng câu lệnh SELECT để truy vấn first name và last name của user từ bảng users dựa trên id_user
    SELECT users.firstname, users.lastname INTO first_name, last_name FROM users WHERE id_user = p_id_user;
    
    -- Kiểm tra xem có tìm thấy thông tin của user không
    IF first_name IS NOT NULL AND last_name IS NOT NULL THEN
        RETURN first_name || ' ' || last_name; -- Trả về first name và last name của user nếu tìm thấy
    ELSE
        RETURN 'User not found'; -- Trả về thông báo nếu không tìm thấy user
    END IF;
END;
$$;


ALTER FUNCTION public.f_find_user(p_id_user uuid) OWNER TO postgres;

--
-- TOC entry 436 (class 1255 OID 17443)
-- Name: f_generate_invitation(uuid, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_generate_invitation(p_id_user uuid, p_id_family integer, p_code character varying) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM family_invitation WHERE id_family = p_id_family) THEN
            UPDATE family_invitation
            SET code = p_code
            WHERE id_family = p_id_family;
            RETURN 'Invitation code updated successfully';
        ELSE
            INSERT INTO family_invitation (id_family, code)
            VALUES (p_id_family, p_code);
            RETURN 'Invitation code created successfully';
        END IF;
END;
$$;


ALTER FUNCTION public.f_generate_invitation(p_id_user uuid, p_id_family integer, p_code character varying) OWNER TO postgres;

--
-- TOC entry 437 (class 1255 OID 17444)
-- Name: f_generate_link_invite(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_generate_link_invite(p_id_family integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE 
    invite_code VARCHAR;
BEGIN 
    SELECT code_invite INTO invite_code FROM family WHERE id_family = p_id_family;

    IF invite_code IS NULL THEN
        invite_code := generate_unique_invite_code();
        UPDATE family SET code_invite = invite_code WHERE id_family = p_id_family;
    END IF;

    RETURN 'http://localhost:8080/invite/' || invite_code;
END;
$$;


ALTER FUNCTION public.f_generate_link_invite(p_id_family integer) OWNER TO postgres;

--
-- TOC entry 438 (class 1255 OID 17445)
-- Name: f_generate_otp(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_generate_otp(owner_id uuid) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
    otp VARCHAR := '';
    i INT := 1;
BEGIN
    BEGIN
        LOOP
            otp := '';
            FOR i IN 1..6 LOOP
                otp := otp || (floor(random() * 10)::int)::varchar;
            END LOOP;

            PERFORM 1
            FROM otp
            WHERE code = otp
            LIMIT 1;

            EXIT WHEN NOT FOUND;
        END LOOP;

        CREATE TEMPORARY TABLE temp_expiry_time AS
            SELECT now() + interval '1 day' AS expiry_time;

        INSERT INTO otp (id_user, code, created_at, updated_at, expired_at )
        VALUES (
        	owner_id,
            otp,
            CURRENT_TIMESTAMP,
            CURRENT_TIMESTAMP,
            (SELECT expiry_time FROM temp_expiry_time)
            
        );

        DROP TABLE IF EXISTS temp_expiry_time;

    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END;

    RETURN otp;
END;
$$;


ALTER FUNCTION public.f_generate_otp(owner_id uuid) OWNER TO postgres;

--
-- TOC entry 439 (class 1255 OID 17446)
-- Name: f_generate_otp(uuid, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_generate_otp(p_id_user uuid, p_email character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_code VARCHAR(6);
BEGIN
    -- Delete existing OTPs for the user
    DELETE FROM otp WHERE id_user = p_id_user;

    -- Generate random 6-digit code
    SELECT TO_CHAR(FLOOR(RANDOM() * 999999)::INT, 'FM000000') INTO v_code;

    -- Insert new OTP entry into the database
    INSERT INTO otp (id_user, email, code, created_at, updated_at, expired_at)
    VALUES (p_id_user, p_email, v_code, NOW(), NOW(), NOW() + INTERVAL '15 minutes');

    -- Return the generated code
    RETURN v_code;
END;
$$;


ALTER FUNCTION public.f_generate_otp(p_id_user uuid, p_email character varying) OWNER TO postgres;

--
-- TOC entry 440 (class 1255 OID 17447)
-- Name: f_generate_otp(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_generate_otp(p_id_user character varying, p_email character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_code VARCHAR(6);
BEGIN
    DELETE FROM otp WHERE id_user = uuid(p_id_user);

    SELECT TO_CHAR(FLOOR(RANDOM() * 999999)::INT, 'FM000000') INTO v_code;

    INSERT INTO otp (id_user, email, code, created_at, updated_at, expired_at)
    VALUES (uuid(p_id_user), p_email, v_code, NOW(), NOW(), NOW() + INTERVAL '15 minutes');

    -- Return the generated code
    RETURN v_code;
END;
$$;


ALTER FUNCTION public.f_generate_otp(p_id_user character varying, p_email character varying) OWNER TO postgres;

--
-- TOC entry 441 (class 1255 OID 17448)
-- Name: f_generate_refresh_token(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_generate_refresh_token(id_user uuid) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
    new_token VARCHAR;
BEGIN
    new_token := md5(random()::text || clock_timestamp()::text);

    INSERT INTO refresh_token (refresh_token, id_user, created_at, expired_at)
    VALUES (new_token,id_user, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + INTERVAL '24 hours');
	return new_token;
END;
$$;


ALTER FUNCTION public.f_generate_refresh_token(id_user uuid) OWNER TO postgres;

--
-- TOC entry 442 (class 1255 OID 17449)
-- Name: f_generate_refresh_token(uuid, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_generate_refresh_token(id_user uuid, refresh_token character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
BEGIN
BEGIN
    INSERT INTO refresh_token (refresh_token, id_user, created_at, expired_at)
    VALUES (refresh_token, id_user, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + INTERVAL '72 hours');
	return refresh_token;
END;
END;
$$;


ALTER FUNCTION public.f_generate_refresh_token(id_user uuid, refresh_token character varying) OWNER TO postgres;

--
-- TOC entry 443 (class 1255 OID 17450)
-- Name: f_generate_unique_uuid(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_generate_unique_uuid() RETURNS uuid
    LANGUAGE plpgsql
    AS $$
DECLARE
    new_uuid UUID;
BEGIN
    LOOP
        -- Tạo một UUID mới
        new_uuid := uuid_generate_v4();

        -- Kiểm tra xem UUID mới có tồn tại trong bảng hay không
        EXIT WHEN NOT EXISTS (
            SELECT 1 FROM users WHERE id_user = new_uuid
        );
    END LOOP;

    -- Trả về UUID mới và không trùng lặp
    RETURN new_uuid;
END;
$$;


ALTER FUNCTION public.f_generate_unique_uuid() OWNER TO postgres;

--
-- TOC entry 444 (class 1255 OID 17451)
-- Name: f_get_all_education_progress(text, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_all_education_progress(p_id_user text, p_skip_amount integer, p_items_per_page integer, p_id_family integer) RETURNS TABLE(id_education_progress integer, id_user uuid, title character varying, progress_notes text, school_info text, created_at timestamp without time zone, updated_at timestamp without time zone, avatar character varying, firstname character varying, lastname character varying)
    LANGUAGE plpgsql
    AS $$
begin
	return query
	select ep.id_education_progress, ep.id_user, ep.title, ep.progress_notes, ep.school_info, ep.created_at, ep.updated_at,
	u.avatar, u.firstname, u.lastname
	from education_progress ep
	join users u on ep.id_user = u.id_user
	where ep.id_family = p_id_family
	LIMIT p_items_per_page OFFSET p_skip_amount;
END;
$$;


ALTER FUNCTION public.f_get_all_education_progress(p_id_user text, p_skip_amount integer, p_items_per_page integer, p_id_family integer) OWNER TO postgres;

--
-- TOC entry 445 (class 1255 OID 17452)
-- Name: f_get_all_invoice_items(uuid, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_all_invoice_items(p_id_user uuid, p_id_family integer, p_id_invoice integer) RETURNS TABLE(id_item integer, id_invoice integer, item_description character varying, item_name character varying, quantity integer, unit_price numeric, total_price numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY 
    SELECT 
        ii.id_item,
        ii.id_invoice,
        ii.item_description,
        ii.item_name,
        ii.quantity,
        ii.unit_price,
		ii.total_price
    FROM 
        invoice_items ii
    WHERE 
        ii.id_invoice = p_id_invoice;
END;
$$;


ALTER FUNCTION public.f_get_all_invoice_items(p_id_user uuid, p_id_family integer, p_id_invoice integer) OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17453)
-- Name: member_family_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.member_family_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.member_family_id_seq OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 222 (class 1259 OID 17454)
-- Name: member_family; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.member_family (
    id_user uuid NOT NULL,
    id_family integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    id integer DEFAULT nextval('public.member_family_id_seq'::regclass) NOT NULL,
    role public.member_family_role_enum DEFAULT 'Member'::public.member_family_role_enum,
    id_family_role integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.member_family OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 17462)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id_user uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    email character varying,
    phone character varying,
    password character varying,
    language character varying,
    twofa boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    isphoneverified boolean DEFAULT false NOT NULL,
    isadmin boolean DEFAULT false NOT NULL,
    firstname character varying,
    lastname character varying,
    isemailverified boolean DEFAULT false NOT NULL,
    avatar character varying,
    login_type public.users_login_type_enum DEFAULT 'local'::public.users_login_type_enum NOT NULL,
    birthdate date,
    genre character varying,
    is_banned boolean DEFAULT false NOT NULL,
    salt character varying NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 17476)
-- Name: view_users_role; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_users_role AS
 SELECT users.id_user,
    users.email,
    users.phone,
    users.language,
    users.firstname,
    users.lastname,
    m.id_family,
    m.role,
    users.avatar
   FROM (public.users
     JOIN public.member_family m ON ((users.id_user = m.id_user)));


ALTER TABLE public.view_users_role OWNER TO postgres;

--
-- TOC entry 446 (class 1255 OID 17481)
-- Name: f_get_all_member(uuid, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_all_member(p_id_user uuid, p_id_family integer) RETURNS SETOF public.view_users_role
    LANGUAGE plpgsql
    AS $$
DECLARE
    recordCount int;
    userRecord view_users_role%ROWTYPE;
BEGIN
    SELECT COUNT(*) INTO recordCount FROM member_family WHERE id_user = p_id_user AND id_family = p_id_family;

    IF recordCount > 0 THEN
        FOR userRecord IN 
            SELECT * FROM view_users_role WHERE  id_family=p_id_family
        LOOP
            RETURN NEXT userRecord;
        END LOOP;
    END IF;

    
END;
$$;


ALTER FUNCTION public.f_get_all_member(p_id_user uuid, p_id_family integer) OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17482)
-- Name: finance_assets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.finance_assets (
    id_asset integer NOT NULL,
    id_family integer NOT NULL,
    name character varying(255) NOT NULL,
    purchase_date date DEFAULT ('now'::text)::date NOT NULL,
    description text DEFAULT ''::text,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    image_url text,
    value bigint NOT NULL
);


ALTER TABLE public.finance_assets OWNER TO postgres;

--
-- TOC entry 447 (class 1255 OID 17491)
-- Name: f_get_asset(text, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_asset(p_id_user text, p_id_family integer, p_page integer DEFAULT 1, p_items_per_page integer DEFAULT 10) RETURNS SETOF public.finance_assets
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT *
    FROM finance_assets
    WHERE id_family = p_id_family
    ORDER BY id_asset
    LIMIT p_items_per_page OFFSET (p_page - 1) * p_items_per_page;
END;
$$;


ALTER FUNCTION public.f_get_asset(p_id_user text, p_id_family integer, p_page integer, p_items_per_page integer) OWNER TO postgres;

--
-- TOC entry 449 (class 1255 OID 17492)
-- Name: f_get_calendar_detail(uuid, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_calendar_detail(p_id_user uuid, p_id_calendar integer) RETURNS TABLE(id_calendar integer, title character varying, description character varying, time_start timestamp without time zone, time_end timestamp without time zone, color text, is_all_day boolean, category integer, location character varying, recurrence_exception character varying, recurrence_id integer, recurrence_rule character varying, start_timezone character varying, end_timezone character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM calendar c
        INNER JOIN member_family mf ON c.id_family = mf.id_family
        WHERE mf.id_user = p_id_user AND c.id_calendar = p_id_calendar
    ) THEN
        RAISE EXCEPTION 'User does not belong to the family or calendar does not belong to the family';
    END IF;

    RETURN QUERY
     SELECT
        c.id_calendar,
        c.title,
        c.description,
        c.time_start,
        c.time_end,
        c.color,
        c.is_all_day,
        c.category, 
        c.location, 
        c.recurrence_exception, 
        c.recurrence_id, 
        c.recurrence_rule, 
        c.start_timezone,
        c.end_timezone,
        get_category_event(c.category) as name_category
    FROM calendar c
    WHERE
        c.id_calendar = p_id_calendar;
END;
$$;


ALTER FUNCTION public.f_get_calendar_detail(p_id_user uuid, p_id_calendar integer) OWNER TO postgres;

--
-- TOC entry 450 (class 1255 OID 17493)
-- Name: f_get_calendar_events(uuid, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_calendar_events(p_id_user uuid, p_id_family integer) RETURNS TABLE(id_calendar integer, title character varying, description character varying, time_start timestamp without time zone, time_end timestamp without time zone, color text, is_all_day boolean, category integer, location character varying, recurrence_exception character varying, recurrence_id integer, recurrence_rule character varying, start_timezone character varying, end_timezone character varying, name_category character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY 
    SELECT
        c.id_calendar,
        c.title,
        c.description,
        c.time_start,
        c.time_end,
        c.color,
        c.is_all_day,
        c.category, 
        c.location, 
        c.recurrence_exception, 
        c.recurrence_id, 
        c.recurrence_rule, 
        c.start_timezone,
        c.end_timezone,
        get_category_event(c.category)::character varying as name_category
    FROM calendar c
    INNER JOIN member_family mf ON c.id_family = mf.id_family
    WHERE mf.id_family = p_id_family AND mf.id_user = p_id_user;
END;
$$;


ALTER FUNCTION public.f_get_calendar_events(p_id_user uuid, p_id_family integer) OWNER TO postgres;

--
-- TOC entry 451 (class 1255 OID 17494)
-- Name: f_get_category_name(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_category_name(p_id_family integer, p_id_expense_type integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_category_name TEXT;
BEGIN
    -- Lấy tên của category dựa trên id_expense_type và id_family
    SELECT category->>'category' INTO v_category_name
    FROM (
        SELECT jsonb_array_elements(finance_expenditure_type.expenditure_details) AS category
        FROM finance_expenditure_type 
        WHERE id_family = p_id_family
    ) AS subquery
    WHERE (category->>'id_expense_type')::integer = p_id_expense_type;

    -- Kiểm tra xem có tìm thấy category không
    IF NOT FOUND THEN
        v_category_name := 'Other';
    END IF;

    RETURN v_category_name;
END;
$$;


ALTER FUNCTION public.f_get_category_name(p_id_family integer, p_id_expense_type integer) OWNER TO postgres;

--
-- TOC entry 452 (class 1255 OID 17495)
-- Name: f_get_detail_education_progress(text, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_detail_education_progress(p_id_user text, p_id_family integer, p_id_education_progress integer) RETURNS TABLE(id_education_progress integer, education_progress_info json, subjects_info json)
    LANGUAGE plpgsql
    AS $$
DECLARE
    subject_record RECORD;
    subjects_array JSON := '[]'::JSON;
begin
	IF NOT EXISTS (
        SELECT 1 FROM education_progress
        WHERE education_progress.id_education_progress = p_id_education_progress AND education_progress.id_family = p_id_family
    ) THEN
        RAISE EXCEPTION 'Education Progress ID % not found in family ID %.', p_id_education_progress, p_id_family;
    END IF;
	
	RETURN QUERY
    SELECT ep.id_education_progress, 
           row_to_json(ep.*),
           (SELECT json_agg(row_to_json(sub.*))
            FROM (SELECT id_subject, subject_name, description, status
                  FROM subjects
                  WHERE subjects.id_education_progress = p_id_education_progress) sub)
    FROM education_progress ep
    WHERE ep.id_education_progress = p_id_education_progress AND ep.id_family = p_id_family;
END;
$$;


ALTER FUNCTION public.f_get_detail_education_progress(p_id_user text, p_id_family integer, p_id_education_progress integer) OWNER TO postgres;

--
-- TOC entry 453 (class 1255 OID 17496)
-- Name: f_get_detail_subject(text, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_detail_subject(p_id_user text, p_id_family integer, p_id_education_progress integer, p_id_subject integer) RETURNS TABLE(id_subject integer, subject_name character varying, description text, component_scores json, midterm_score double precision, final_score double precision, bonus_score double precision, status public.subject_status)
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM education_progress
        WHERE id_education_progress = p_id_education_progress AND id_family = p_id_family
    ) THEN
        RAISE EXCEPTION 'Education Progress ID % not found in family ID %.', p_id_education_progress, p_id_family;
    END IF;
    
    IF NOT EXISTS (
        SELECT 1 FROM subjects
        WHERE subjects.id_subject = p_id_subject AND subjects.id_education_progress = p_id_education_progress
    ) THEN
        RAISE EXCEPTION 'Subject ID % not found in education progress ID %.', p_id_subject, p_id_education_progress;
    END IF;
    
    RETURN QUERY
    SELECT subjects.id_subject, subjects.subject_name, 
	subjects.description, subjects.component_scores, 
	subjects.midterm_score, subjects.final_score, subjects.bonus_score, subjects.status
    FROM subjects
    WHERE subjects.id_subject = p_id_subject AND subjects.id_education_progress = p_id_education_progress;
END;
$$;


ALTER FUNCTION public.f_get_detail_subject(p_id_user text, p_id_family integer, p_id_education_progress integer, p_id_subject integer) OWNER TO postgres;

--
-- TOC entry 454 (class 1255 OID 17497)
-- Name: f_get_events_for_family(uuid, integer, timestamp without time zone, timestamp without time zone); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_events_for_family(p_id_user uuid, p_id_family integer, p_date_start timestamp without time zone, p_date_end timestamp without time zone) RETURNS TABLE(id_calendar integer, title character varying, description character varying, time_start timestamp without time zone, time_end timestamp without time zone, color text, is_all_day boolean, category integer, location character varying, recurrence_exception character varying, recurrence_id integer, recurrence_rule character varying, start_timezone character varying, end_timezone character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
     SELECT
        c.id_calendar,
        c.title,
        c.description,
        c.time_start,
        c.time_end,
        c.color,
        c.is_all_day,
        c.category, 
        c.location, 
        c.recurrence_exception, 
        c.recurrence_id, 
        c.recurrence_rule, 
        c.start_timezone,
        c.end_timezone,
        get_category_event(c.category) as name_category
    FROM calendar c
    INNER JOIN
        member_family mf ON c.id_family = mf.id_family
    WHERE
        mf.id_user = p_id_user
        AND mf.id_family = p_id_family
        AND c.time_start <= p_date_end
        AND c.time_end >= p_date_start;
END;
$$;


ALTER FUNCTION public.f_get_events_for_family(p_id_user uuid, p_id_family integer, p_date_start timestamp without time zone, p_date_end timestamp without time zone) OWNER TO postgres;

--
-- TOC entry 455 (class 1255 OID 17498)
-- Name: f_get_expenditure(text, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_expenditure(p_id_user text, p_id_family integer, p_page integer, p_items_per_page integer) RETURNS TABLE(id_expenditure integer, id_family integer, id_created_by uuid, expense_name character varying, amount numeric, expenditure_date date, description text)
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_offset INTEGER;
BEGIN
    v_offset := (p_page - 1) * p_items_per_page;

    RETURN QUERY
    SELECT e.id_expenditure, e.id_family, e.id_created_by, et.expense_name, e.amount, e.expenditure_date, e.description
    FROM finance_expenditure e
    INNER JOIN finance_expenditure_type et ON e.id_expense_type = et.id_expense_type
    WHERE e.id_family = p_id_family
    ORDER BY e.expenditure_date DESC, e.id_expenditure
    LIMIT p_items_per_page OFFSET v_offset;
END;
$$;


ALTER FUNCTION public.f_get_expenditure(p_id_user text, p_id_family integer, p_page integer, p_items_per_page integer) OWNER TO postgres;

--
-- TOC entry 456 (class 1255 OID 17499)
-- Name: f_get_expenditure_by_id(text, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_expenditure_by_id(p_id_user text, p_id_family integer, p_id_expenditure integer) RETURNS TABLE(id_expenditure integer, expense_name character varying, id_family integer, id_created_by uuid, id_expense_type integer, amount numeric, expenditure_date date, description text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 
        FROM member_family mf
        JOIN finance_expenditure fe ON mf.id_family = fe.id_family
        WHERE mf.id_user = p_id_user::uuid
        AND mf.id_family = p_id_family 
        AND fe.id_expenditure = p_id_expenditure
    ) THEN
        RAISE EXCEPTION 'User is not a member of the specified family or expenditure does not belong to this family.';
    END IF;

    RETURN QUERY
    SELECT fe.id_expenditure, fet.expense_name, fe.id_family, fe.id_created_by, fe.id_expense_type, fe.amount, fe.expenditure_date, fe.description
    FROM finance_expenditure fe
	JOIN finance_expenditure_type fet ON fe.id_expense_type = fet.id_expense_type
    WHERE fe.id_expenditure = p_id_expenditure;
END;
$$;


ALTER FUNCTION public.f_get_expenditure_by_id(p_id_user text, p_id_family integer, p_id_expenditure integer) OWNER TO postgres;

--
-- TOC entry 457 (class 1255 OID 17500)
-- Name: f_get_expense_by_date(uuid, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_expense_by_date(p_id_user uuid, p_id_family integer, p_expense_date character varying) RETURNS TABLE(id_expense_type integer, expense_category text, expense_amount numeric, description text, name text)
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_user_exists BOOLEAN;
BEGIN
    RETURN QUERY
    SELECT 
        fe.id_expense_type,
        f_get_category_name(p_id_family, fe.id_expense_type) AS expense_category,
        fe.amount,
        fe.description,
        f_find_user(fe.id_created_by)
    FROM 
        finance_expenditure fe
    WHERE 
        fe.id_family = p_id_family 
        AND fe.expenditure_date = p_expense_date::date; 
END;
$$;


ALTER FUNCTION public.f_get_expense_by_date(p_id_user uuid, p_id_family integer, p_expense_date character varying) OWNER TO postgres;

--
-- TOC entry 458 (class 1255 OID 17501)
-- Name: f_get_expense_by_date_range(uuid, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_expense_by_date_range(p_id_user uuid, p_id_family integer, p_days_range integer) RETURNS TABLE(id_expense_type integer, expense_category text, expense_amount numeric, description text, name text, expenditure_date date)
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_user_exists BOOLEAN;
    v_end_date DATE := CURRENT_DATE;
    v_start_date DATE;
BEGIN
    -- Calculate the start date
    v_start_date := v_end_date - (p_days_range || ' days')::interval;

    -- Debugging: Raise notice to check the date range
    RAISE NOTICE 'Start Date: %, End Date: %', v_start_date, v_end_date;

    -- Check if the user is a member of the specified family
    SELECT EXISTS (
        SELECT 1
        FROM member_family
        WHERE id_user = p_id_user AND id_family = p_id_family
    ) INTO v_user_exists;

    IF NOT v_user_exists THEN
        RAISE EXCEPTION 'User is not a member of the specified family.';
    END IF;

    -- Return the query results
    RETURN QUERY
    SELECT 
        fe.id_expense_type,
        f_get_category_name(p_id_family, fe.id_expense_type) AS expense_category,
        fe.amount,
        fe.description,
        f_find_user(fe.id_created_by),
        fe.expenditure_date
    FROM 
        finance_expenditure fe
    WHERE 
        fe.id_family = p_id_family 
        AND fe.expenditure_date BETWEEN v_start_date AND v_end_date; 
END;
$$;


ALTER FUNCTION public.f_get_expense_by_date_range(p_id_user uuid, p_id_family integer, p_days_range integer) OWNER TO postgres;

--
-- TOC entry 459 (class 1255 OID 17502)
-- Name: f_get_expense_by_month(uuid, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_expense_by_month(p_id_user uuid, p_id_family integer, p_month integer, p_year integer) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_user_exists BOOLEAN;
    v_result jsonb := '[]'::jsonb;
    v_current_date date;
    v_total numeric;
    v_categories jsonb;
    v_category jsonb;
BEGIN
    -- Lấy các ngày chi tiêu trong tháng/năm
    FOR v_current_date IN
        SELECT DISTINCT expenditure_date::date
        FROM finance_expenditure
        WHERE id_family = p_id_family 
          AND EXTRACT(MONTH FROM expenditure_date) = p_month
          AND EXTRACT(YEAR FROM expenditure_date) = p_year
    LOOP
        -- Tính tổng chi tiêu cho ngày hiện tại
        SELECT COALESCE(SUM(amount), 0)
        INTO v_total
        FROM finance_expenditure
        WHERE id_family = p_id_family 
          AND expenditure_date::date = v_current_date;

        -- Lấy danh sách các loại chi tiêu cho ngày hiện tại
        v_categories := '[]'::jsonb;
        FOR v_category IN
            SELECT jsonb_build_object(
                       'name', f_get_category_name(p_id_family, fe.id_expense_type),
                       'amount', COALESCE(SUM(fe.amount), 0)
                   ) AS category
            FROM finance_expenditure fe
            WHERE fe.id_family = p_id_family 
              AND fe.expenditure_date::date = v_current_date
            GROUP BY fe.id_expense_type
        LOOP
            v_categories := v_categories || v_category;
        END LOOP;

        -- Thêm kết quả vào JSON chính
        v_result := v_result || jsonb_build_object(
            'date', v_current_date,
            'total', v_total,
            'categories', v_categories
        )::jsonb;
    END LOOP;

    RETURN v_result;
END;
$$;


ALTER FUNCTION public.f_get_expense_by_month(p_id_user uuid, p_id_family integer, p_month integer, p_year integer) OWNER TO postgres;

--
-- TOC entry 460 (class 1255 OID 17503)
-- Name: f_get_expense_by_year(uuid, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_expense_by_year(p_id_user uuid, p_id_family integer, p_year integer) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_user_exists BOOLEAN;
    v_result jsonb := '[]'::jsonb;
    v_current_month integer;
    v_total numeric;
    v_categories jsonb;
    v_category jsonb;
BEGIN
    -- Kiểm tra xem người dùng có thuộc gia đình không
    SELECT EXISTS (
        SELECT 1
        FROM member_family
        WHERE id_user = p_id_user AND id_family = p_id_family
    ) INTO v_user_exists;

    IF NOT v_user_exists THEN
        RAISE EXCEPTION 'User is not a member of the specified family.';
    END IF;

    -- Duyệt qua các tháng trong năm
    FOR v_current_month IN 1..12 LOOP
        -- Tính tổng chi tiêu cho tháng hiện tại
        SELECT COALESCE(SUM(amount), 0)
        INTO v_total
        FROM finance_expenditure
        WHERE id_family = p_id_family 
          AND EXTRACT(MONTH FROM expenditure_date) = v_current_month
          AND EXTRACT(YEAR FROM expenditure_date) = p_year;

        -- Lấy danh sách các loại chi tiêu cho tháng hiện tại
        v_categories := '[]'::jsonb;
        FOR v_category IN
            SELECT jsonb_build_object(
            			'id_expense_type', fe.id_expense_type,
                       'name', f_get_category_name(p_id_family, fe.id_expense_type),
                       'amount', COALESCE(SUM(fe.amount), 0)
                   ) AS category
            FROM finance_expenditure fe
            WHERE fe.id_family = p_id_family 
              AND EXTRACT(MONTH FROM fe.expenditure_date) = v_current_month
              AND EXTRACT(YEAR FROM fe.expenditure_date) = p_year
            GROUP BY fe.id_expense_type
        LOOP
            v_categories := v_categories || v_category;
        END LOOP;

        -- Thêm kết quả vào JSON chính nếu có chi tiêu trong tháng
        IF v_total > 0 THEN
            v_result := v_result || jsonb_build_object(
                'month', v_current_month,
                'total', v_total,
                'categories', v_categories
            )::jsonb;
        END IF;
    END LOOP;

    RETURN v_result;
END;
$$;


ALTER FUNCTION public.f_get_expense_by_year(p_id_user uuid, p_id_family integer, p_year integer) OWNER TO postgres;

--
-- TOC entry 461 (class 1255 OID 17504)
-- Name: f_get_expenses_with_pagination(uuid, integer, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_expenses_with_pagination(p_id_user uuid, p_id_family integer, p_days_range integer, p_page_number integer, p_items_per_page integer) RETURNS json
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_user_exists BOOLEAN;
    v_total_count integer;
    v_total_pages integer;
    v_start_date DATE;
    v_end_date DATE := CURRENT_DATE;
    v_expenses JSON;
    v_total_expense NUMERIC;
BEGIN
    -- Calculate the start date
    v_start_date := v_end_date - (p_days_range || ' days')::interval;

    -- Check if the user is a member of the specified family
    SELECT EXISTS (
        SELECT 1
        FROM member_family
        WHERE id_user = p_id_user AND id_family = p_id_family
    ) INTO v_user_exists;

    IF NOT v_user_exists THEN
        RETURN '{"total_pages": 0, "current_page": 0, "total_expense": 0, "expenses": []}'::JSON;
    END IF;

    -- Get the total count of records
    SELECT COUNT(*)
    INTO v_total_count
    FROM finance_expenditure fe
    WHERE fe.id_family = p_id_family
      AND fe.expenditure_date BETWEEN v_start_date AND v_end_date;

    -- Calculate total pages
    v_total_pages := CEIL(v_total_count::numeric / p_items_per_page);

    -- Calculate the total expense
    SELECT COALESCE(SUM(fe.amount), 0)
    INTO v_total_expense
    FROM finance_expenditure fe
    WHERE fe.id_family = p_id_family
      AND fe.expenditure_date BETWEEN v_start_date AND v_end_date;

    -- Return the paginated query results and total pages as JSON
    v_expenses := json_build_object(
        'total_pages', v_total_pages,
        'current_page', p_page_number,
        'total_expense', v_total_expense,
        'expenses', (
            SELECT COALESCE(json_agg(expense_data), '[]'::JSON)
            FROM (
                SELECT
                    fe.id_expense_type,
                    fe.id_expenditure, -- Add id_expenditure field
                    f_get_category_name(p_id_family, fe.id_expense_type) AS expense_category,
                    fe.amount AS expense_amount,
                    fe.description,
                    f_find_user(fe.id_created_by) AS name,
                    fe.expenditure_date,
                    fe.image_url AS image_url 
                FROM finance_expenditure fe
                WHERE fe.id_family = p_id_family 
                  AND fe.expenditure_date BETWEEN v_start_date AND v_end_date
                ORDER BY fe.expenditure_date DESC
                OFFSET (p_page_number - 1) * p_items_per_page
                LIMIT p_items_per_page
            ) AS expense_data
        )
    );

    RETURN v_expenses;
END;
$$;


ALTER FUNCTION public.f_get_expenses_with_pagination(p_id_user uuid, p_id_family integer, p_days_range integer, p_page_number integer, p_items_per_page integer) OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 17505)
-- Name: family_id_family_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.family_id_family_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.family_id_family_seq OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17506)
-- Name: family; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.family (
    id_family integer DEFAULT nextval('public.family_id_family_seq'::regclass) NOT NULL,
    quantity integer NOT NULL,
    description character varying DEFAULT ''::character varying,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    name character varying DEFAULT 'New Family'::character varying NOT NULL,
    avatar character varying,
    owner_id uuid NOT NULL,
    expired_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.family OWNER TO postgres;

--
-- TOC entry 462 (class 1255 OID 17517)
-- Name: f_get_family(uuid, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_family(p_id_user uuid, p_id_family integer) RETURNS SETOF public.family
    LANGUAGE plpgsql
    AS $$
DECLARE
    recordCount int;
    familyRecord family%ROWTYPE;
BEGIN
    SELECT COUNT(*) INTO recordCount FROM member_family WHERE id_user = p_id_user AND id_family = p_id_family;

    IF recordCount > 0 THEN
        SELECT * INTO familyRecord FROM family WHERE id_family = p_id_family;
        RETURN NEXT familyRecord;
    ELSE
        RETURN;
    END IF;
END;
$$;


ALTER FUNCTION public.f_get_family(p_id_user uuid, p_id_family integer) OWNER TO postgres;

--
-- TOC entry 463 (class 1255 OID 17518)
-- Name: f_get_finance_expenditure_type(uuid, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_finance_expenditure_type(p_id_user uuid, p_id_family integer) RETURNS SETOF jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_exists BOOLEAN;
BEGIN
    RETURN QUERY
    SELECT expenditure_details
    FROM finance_expenditure_type
    WHERE id_family = p_id_family; 
END;
$$;


ALTER FUNCTION public.f_get_finance_expenditure_type(p_id_user uuid, p_id_family integer) OWNER TO postgres;

--
-- TOC entry 464 (class 1255 OID 17519)
-- Name: f_get_finance_income_source(uuid, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_finance_income_source(p_id_user uuid, p_id_family integer) RETURNS SETOF jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_exists BOOLEAN;
BEGIN
    RETURN QUERY
    SELECT income_details
    FROM finance_income_source
    WHERE id_family = p_id_family; 
END;
$$;


ALTER FUNCTION public.f_get_finance_income_source(p_id_user uuid, p_id_family integer) OWNER TO postgres;

--
-- TOC entry 465 (class 1255 OID 17520)
-- Name: f_get_finance_summary(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_finance_summary(p_id_user text, p_id_family integer) RETURNS TABLE(id_summary integer, id_family integer, summary_date date, total_income numeric, total_expenditure numeric, daily_balance numeric, weekly_balance numeric, monthly_balance numeric, yearly_balance numeric, current_balance numeric)
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_id_summary INT;
BEGIN
    SELECT financial_summary.id_summary
    INTO v_id_summary
    FROM financial_summary
    WHERE financial_summary.id_family = p_id_family;

    IF v_id_summary IS NULL THEN
        INSERT INTO financial_summary (id_family, summary_date)
        VALUES (p_id_family, CURRENT_DATE)
        RETURNING financial_summary.id_summary INTO v_id_summary;
    END IF;

    RETURN QUERY
    SELECT *
    FROM financial_summary
    WHERE financial_summary.id_summary = v_id_summary;
END;
$$;


ALTER FUNCTION public.f_get_finance_summary(p_id_user text, p_id_family integer) OWNER TO postgres;

--
-- TOC entry 466 (class 1255 OID 17521)
-- Name: f_get_guideline(character varying, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_guideline(p_id_user character varying, p_id_family integer, p_id_guideline integer) RETURNS TABLE(id_item integer, name character varying, description character varying, id_family integer, step json, is_shared boolean, created_at timestamp without time zone, updated_at timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        guide_items.id_item, 
        guide_items.name, 
        guide_items.description, 
        guide_items.id_family,
        guide_items.step::json, 
        guide_items.is_shared, 
        guide_items.created_at, 
        guide_items.updated_at
    FROM guide_items
    WHERE guide_items.id_family = p_id_family AND guide_items.id_item = p_id_guideline;
END;
$$;


ALTER FUNCTION public.f_get_guideline(p_id_user character varying, p_id_family integer, p_id_guideline integer) OWNER TO postgres;

--
-- TOC entry 467 (class 1255 OID 17522)
-- Name: f_get_guideline_step(character varying, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_guideline_step(p_id_user character varying, p_id_family integer, p_id_guideline integer) RETURNS json
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_step JSON;
BEGIN
    SELECT step INTO v_step
    FROM guide_items
    WHERE id_family = p_id_family AND id_item = p_id_guideline;

    IF v_step IS NULL THEN
        RAISE EXCEPTION 'No step found for Guideline ID % in Family ID %.', p_id_guideline, p_id_family;
    END IF;

    RETURN v_step;
END;
$$;


ALTER FUNCTION public.f_get_guideline_step(p_id_user character varying, p_id_family integer, p_id_guideline integer) OWNER TO postgres;

--
-- TOC entry 468 (class 1255 OID 17523)
-- Name: f_get_guidelines(text, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_guidelines(p_id_user text, p_id_family integer, p_page integer, p_limit integer) RETURNS json
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_offset INT := (p_page - 1) * p_limit;
    item_records JSON;
    total_items INT;
BEGIN
        SELECT COUNT(*) INTO total_items
        FROM guide_items
        WHERE id_family = p_id_family;

        SELECT JSON_AGG(t) INTO item_records
        FROM (
            SELECT id_item, name, description, created_at, updated_at
            FROM guide_items
            WHERE id_family = p_id_family
            ORDER BY created_at DESC
            LIMIT p_limit OFFSET v_offset
        ) t;

        RETURN JSON_BUILD_OBJECT('items', item_records, 'total_items', total_items);
END;
$$;


ALTER FUNCTION public.f_get_guidelines(p_id_user text, p_id_family integer, p_page integer, p_limit integer) OWNER TO postgres;

--
-- TOC entry 469 (class 1255 OID 17524)
-- Name: f_get_guidelines(character varying, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_guidelines(p_id_user character varying, p_id_family integer, p_page integer, p_limit integer) RETURNS TABLE(name character varying, description character varying, created_at timestamp without time zone, updated_at timestamp without time zone, total_items integer)
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_offset INT := (p_page - 1) * p_limit;
BEGIN
    SELECT COUNT(*) INTO total_items
        FROM guide_items
        WHERE id_family = p_id_family;

        RETURN QUERY
        SELECT guide_items.name, guide_items.description, guide_items.created_at, guide_items.updated_at, total_items
        FROM guide_items
        WHERE id_family = p_id_family
        ORDER BY created_at DESC
        LIMIT p_limit OFFSET v_offset;
END;
$$;


ALTER FUNCTION public.f_get_guidelines(p_id_user character varying, p_id_family integer, p_page integer, p_limit integer) OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 17525)
-- Name: household_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.household_items (
    id_household_item integer NOT NULL,
    id_family integer NOT NULL,
    item_name character varying(255) NOT NULL,
    id_category integer NOT NULL,
    id_room integer,
    description text,
    item_imageurl text,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.household_items OWNER TO postgres;

--
-- TOC entry 470 (class 1255 OID 17532)
-- Name: f_get_household_item(text, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_household_item(p_id_user text, p_id_family integer, p_page integer, p_items_per_page integer) RETURNS SETOF public.household_items
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_offset INT;
BEGIN
    v_offset := (p_page - 1) * p_items_per_page;

    RETURN QUERY
    SELECT hi.*
    FROM household_items hi
    JOIN member_family mf ON hi.id_family = mf.id_family
    WHERE mf.id_user = uuid(p_id_user) AND hi.id_family = p_id_family
    ORDER BY hi.id_household_item
    LIMIT p_items_per_page OFFSET v_offset;

END;
$$;


ALTER FUNCTION public.f_get_household_item(p_id_user text, p_id_family integer, p_page integer, p_items_per_page integer) OWNER TO postgres;

--
-- TOC entry 448 (class 1255 OID 17533)
-- Name: f_get_household_item_detail(text, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_household_item_detail(p_id_user text, p_id_family integer, p_id_item integer) RETURNS SETOF public.household_item_detail
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT hi.id_household_item, hi.id_family, hi.item_name, hi.item_description, hi.description,
           hi.item_imageurl, hic.category_name,
           hci.quantity, hci.threshold, hdi.condition, hci.expired_date
    FROM household_items hi
    LEFT JOIN household_item_categories hic ON hi.id_category = hic.id_category
    LEFT JOIN household_consumable_items hci ON hi.id_household_item = hci.id_household_item
    LEFT JOIN household_durable_items hdi ON hi.id_household_item = hdi.id_household_item
    WHERE hi.id_household_item = p_id_item AND hi.id_family = p_id_family;

END;
$$;


ALTER FUNCTION public.f_get_household_item_detail(p_id_user text, p_id_family integer, p_id_item integer) OWNER TO postgres;

--
-- TOC entry 375 (class 1255 OID 17534)
-- Name: f_get_ids_member(text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_ids_member(p_id_user text, p_id_family integer) RETURNS SETOF uuid
    LANGUAGE plpgsql
    AS $$
DECLARE
    user_exists INT;
BEGIN
    SELECT COUNT(*) INTO user_exists FROM member_family 
    WHERE id_user = p_id_user::uuid AND id_family = p_id_family;

    IF user_exists > 0 THEN
        RETURN QUERY 
        SELECT id_user FROM member_family WHERE id_family = p_id_family;
    END IF;

    RETURN;
END;
$$;


ALTER FUNCTION public.f_get_ids_member(p_id_user text, p_id_family integer) OWNER TO postgres;

--
-- TOC entry 471 (class 1255 OID 17535)
-- Name: f_get_income(text, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_income(p_id_user text, p_id_family integer, p_page integer, p_items_per_page integer) RETURNS TABLE(id_income integer, id_family integer, id_created_by uuid, income_name character varying, amount numeric, income_date date, description text)
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_offset INTEGER;
BEGIN
    v_offset := (p_page - 1) * p_items_per_page;
    
    RETURN QUERY
        SELECT fi.id_income, fi.id_family, fi.id_created_by, fic.income_name,
               fi.amount, fi.income_date, fi.description
        FROM finance_income AS fi
		INNER JOIN finance_income_source fic on fic.id_income_source = fi.id_income_source
        WHERE fi.id_family = p_id_family
        ORDER BY fi.income_date DESC, fi.id_income
        LIMIT p_items_per_page OFFSET v_offset;
END;
$$;


ALTER FUNCTION public.f_get_income(p_id_user text, p_id_family integer, p_page integer, p_items_per_page integer) OWNER TO postgres;

--
-- TOC entry 472 (class 1255 OID 17536)
-- Name: f_get_income_by_date(uuid, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_income_by_date(p_id_user uuid, p_id_family integer, p_income_date character varying) RETURNS TABLE(id_income_source integer, income_category text, income_amount numeric, description text, name text)
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_user_exists BOOLEAN;
BEGIN
    RETURN QUERY
    SELECT 
        fi.id_income_source,
        f_get_income_name(p_id_family, fi.id_income_source),
        fi.amount,
        fi.description,
        f_find_user(fi.id_created_by)
    FROM 
        finance_income fi 
    WHERE 
        fi.id_family = p_id_family 
        AND fi.income_date = p_income_date::date;
END;
$$;


ALTER FUNCTION public.f_get_income_by_date(p_id_user uuid, p_id_family integer, p_income_date character varying) OWNER TO postgres;

--
-- TOC entry 473 (class 1255 OID 17537)
-- Name: f_get_income_by_date_range(uuid, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_income_by_date_range(p_id_user uuid, p_id_family integer, p_days_range integer) RETURNS TABLE(id_income_source integer, income_category text, income_amount numeric, description text, name text, income_date date)
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_user_exists BOOLEAN;
    v_end_date DATE := CURRENT_DATE;
    v_start_date DATE;
BEGIN
    -- Calculate the start date
    v_start_date := v_end_date - (p_days_range || ' days')::interval;

    -- Debugging: Raise notice to check the date range
    RAISE NOTICE 'Start Date: %, End Date: %', v_start_date, v_end_date;

    -- Check if the user is a member of the specified family
    SELECT EXISTS (
        SELECT 1
        FROM member_family
        WHERE id_user = p_id_user AND id_family = p_id_family
    ) INTO v_user_exists;

    IF NOT v_user_exists THEN
        RAISE EXCEPTION 'User is not a member of the specified family.';
    END IF;

    -- Return the query results
    RETURN QUERY
    SELECT 
        fi.id_income AS id_income_source,
        f_get_income_name(p_id_family, fi.id_income) AS income_category,
        fi.amount AS income_amount,
        fi.description,
        f_find_user(fi.id_created_by) AS name,
        fi.income_date
    FROM 
        finance_income fi 
    WHERE 
        fi.id_family = p_id_family 
        AND fi.income_date BETWEEN v_start_date AND v_end_date; 
END;
$$;


ALTER FUNCTION public.f_get_income_by_date_range(p_id_user uuid, p_id_family integer, p_days_range integer) OWNER TO postgres;

--
-- TOC entry 474 (class 1255 OID 17538)
-- Name: f_get_income_by_date_range(uuid, integer, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_income_by_date_range(p_id_user uuid, p_id_family integer, p_days_range integer, p_page_number integer, p_items_per_page integer) RETURNS TABLE(id_income_source integer, income_category text, income_amount numeric, description text, name text, income_date date, total_pages integer)
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_user_exists BOOLEAN;
    v_total_count integer;
    v_total_pages integer;
    v_start_date DATE;
    v_end_date DATE := CURRENT_DATE;
BEGIN
    -- Calculate the start date
    v_start_date := v_end_date - (p_days_range || ' days')::interval;

    -- Debugging: Raise notice to check the date range
    RAISE NOTICE 'Start Date: %, End Date: %', v_start_date, v_end_date;

    -- Check if the user is a member of the specified family
    SELECT EXISTS (
        SELECT 1
        FROM member_family
        WHERE id_user = p_id_user AND id_family = p_id_family
    ) INTO v_user_exists;

    IF NOT v_user_exists THEN
        RAISE EXCEPTION 'User is not a member of the specified family.';
    END IF;

    -- Get the total count of income records
    SELECT COUNT(*)
    INTO v_total_count
    FROM finance_income fi
    WHERE fi.id_family = p_id_family
      AND fi.income_date BETWEEN v_start_date AND v_end_date;

    -- Calculate total pages
    v_total_pages := CEIL(v_total_count::numeric / p_items_per_page);

    -- Return the paginated query results and total pages
    RETURN QUERY
    SELECT 
        fi.id_income AS id_income_source,
        f_get_income_name(p_id_family, fi.id_income) AS income_category,
        fi.amount AS income_amount,
        fi.description,
        f_find_user(fi.id_created_by) AS name,
        fi.income_date,
        v_total_pages AS total_pages
    FROM 
        finance_income fi
    WHERE 
        fi.id_family = p_id_family 
        AND fi.income_date BETWEEN v_start_date AND v_end_date
    ORDER BY fi.income_date DESC
    OFFSET (p_page_number - 1) * p_items_per_page
    LIMIT p_items_per_page;
END;
$$;


ALTER FUNCTION public.f_get_income_by_date_range(p_id_user uuid, p_id_family integer, p_days_range integer, p_page_number integer, p_items_per_page integer) OWNER TO postgres;

--
-- TOC entry 475 (class 1255 OID 17539)
-- Name: f_get_income_by_id(text, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_income_by_id(p_id_user text, p_id_family integer, p_id_income integer) RETURNS TABLE(id_income integer, id_family integer, id_created_by uuid, id_income_source integer, amount numeric, income_date date, description text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT fi.id_income, fi.id_family, fi.id_created_by, fi.id_income_source,
               fi.amount, fi.income_date, fi.description
        FROM finance_income AS fi
        WHERE fi.id_income = p_id_income AND fi.id_family = p_id_family;
END;
$$;


ALTER FUNCTION public.f_get_income_by_id(p_id_user text, p_id_family integer, p_id_income integer) OWNER TO postgres;

--
-- TOC entry 476 (class 1255 OID 17540)
-- Name: f_get_income_by_month(uuid, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_income_by_month(p_id_user uuid, p_id_family integer, p_month integer, p_year integer) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_user_exists BOOLEAN;
    v_result jsonb := '[]'::jsonb;
    v_current_date date;
    v_total numeric;
    v_categories jsonb;
    v_category jsonb;
BEGIN
    FOR v_current_date IN
        SELECT DISTINCT income_date::date
        FROM finance_income
        WHERE id_family = p_id_family 
          AND EXTRACT(MONTH FROM income_date) = p_month
          AND EXTRACT(YEAR FROM income_date) = p_year
    LOOP
        -- Tính tổng thu nhập của ngày hiện tại
        SELECT COALESCE(SUM(amount), 0)
        INTO v_total
        FROM finance_income
        WHERE id_family = p_id_family 
          AND income_date::date = v_current_date;

        v_categories := '[]'::jsonb;
        
        -- Lặp qua từng loại thu nhập trong ngày hiện tại
        FOR v_category IN
            SELECT jsonb_build_object(
                       'name', f_get_income_name(p_id_family, fi.id_income_source),
                       'amount', COALESCE(SUM(fi.amount), 0)
                   ) AS category
            FROM finance_income fi
            WHERE fi.id_family = p_id_family 
              AND fi.income_date::date = v_current_date
            GROUP BY fi.id_income_source
        LOOP
            v_categories := v_categories || v_category;
        END LOOP;

        -- Thêm kết quả vào JSON chính
        v_result := v_result || jsonb_build_object(
            'date', v_current_date,
            'total', v_total,
            'categories', v_categories
        )::jsonb;
    END LOOP;

    RETURN v_result;
END;
$$;


ALTER FUNCTION public.f_get_income_by_month(p_id_user uuid, p_id_family integer, p_month integer, p_year integer) OWNER TO postgres;

--
-- TOC entry 478 (class 1255 OID 17541)
-- Name: f_get_income_by_year(uuid, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_income_by_year(p_id_user uuid, p_id_family integer, p_year integer) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_user_exists BOOLEAN;
    v_result jsonb := '[]'::jsonb;
    v_current_month integer;
    v_total_income numeric;
    v_income_sources jsonb;
    v_income_source jsonb;
BEGIN

    FOR v_current_month IN 1..12 LOOP
        -- Tính tổng thu nhập cho tháng hiện tại
        SELECT COALESCE(SUM(amount), 0)
        INTO v_total_income
        FROM finance_income
        WHERE id_family = p_id_family 
          AND EXTRACT(MONTH FROM income_date) = v_current_month
          AND EXTRACT(YEAR FROM income_date) = p_year;

        -- Lấy danh sách các nguồn thu nhập cho tháng hiện tại
        v_income_sources := '[]'::jsonb;
        FOR v_income_source IN
            SELECT jsonb_build_object(
                       'name', f_get_income_name(p_id_family, fi.id_income_source),
                       'amount', COALESCE(SUM(fi.amount), 0)
                   ) AS income_source
            FROM finance_income fi
            WHERE fi.id_family = p_id_family 
              AND EXTRACT(MONTH FROM fi.income_date) = v_current_month
              AND EXTRACT(YEAR FROM fi.income_date) = p_year
            GROUP BY fi.id_income_source
        LOOP
            v_income_sources := v_income_sources || v_income_source;
        END LOOP;

        -- Thêm kết quả vào JSON chính nếu có thu nhập trong tháng
        IF v_total_income > 0 THEN
            v_result := v_result || jsonb_build_object(
                'month', v_current_month,
                'total', v_total_income,
                'categories', v_income_sources
            )::jsonb;
        END IF;
    END LOOP;

    RETURN v_result;
END;
$$;


ALTER FUNCTION public.f_get_income_by_year(p_id_user uuid, p_id_family integer, p_year integer) OWNER TO postgres;

--
-- TOC entry 479 (class 1255 OID 17542)
-- Name: f_get_income_name(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_income_name(p_id_family integer, p_id_income_type integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_category_name TEXT;
BEGIN
    -- Lấy tên của category dựa trên id_expense_type và id_family
   SELECT category->>'category' into v_category_name
	FROM (
	    SELECT jsonb_array_elements(finance_income_source.income_details) AS category
	    FROM finance_income_source 
	    WHERE id_family = p_id_family
	) AS subquery
	WHERE (category->>'id_income_source')::integer = p_id_income_type;

    -- Kiểm tra xem có tìm thấy category không
    IF NOT FOUND THEN
        v_category_name := 'Other';
    END IF;

    RETURN v_category_name;
END;
$$;


ALTER FUNCTION public.f_get_income_name(p_id_family integer, p_id_income_type integer) OWNER TO postgres;

--
-- TOC entry 480 (class 1255 OID 17543)
-- Name: f_get_income_with_pagination(uuid, integer, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_income_with_pagination(p_id_user uuid, p_id_family integer, p_days_range integer, p_page_number integer, p_items_per_page integer) RETURNS json
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_user_exists BOOLEAN;
    v_total_count integer;
    v_total_pages integer;
    v_start_date DATE;
    v_end_date DATE := CURRENT_DATE;
    v_income_records JSON;
    v_total_income NUMERIC;
BEGIN
    -- Calculate the start date
    v_start_date := v_end_date - (p_days_range || ' days')::interval;

    -- Check if the user is a member of the specified family
    SELECT EXISTS (
        SELECT 1
        FROM member_family
        WHERE id_user = p_id_user AND id_family = p_id_family
    ) INTO v_user_exists;

    IF NOT v_user_exists THEN
        RETURN '{"total_pages": 0, "current_page": 0, "total_income": 0, "income": []}'::JSON;
    END IF;

    -- Get the total count of income records
    SELECT COUNT(*)
    INTO v_total_count
    FROM finance_income fi
    WHERE fi.id_family = p_id_family
      AND fi.income_date BETWEEN v_start_date AND v_end_date;

    -- Calculate total pages
    v_total_pages := CEIL(v_total_count::numeric / p_items_per_page);

    -- Calculate the total income
    SELECT COALESCE(SUM(fi.amount), 0)
    INTO v_total_income
    FROM finance_income fi
    WHERE fi.id_family = p_id_family
      AND fi.income_date BETWEEN v_start_date AND v_end_date;

    -- Ensure the requested page is within the range
    IF p_page_number < 1 OR p_page_number > v_total_pages THEN
        RETURN json_build_object(
            'total_pages', v_total_pages,
            'current_page', p_page_number,
            'total_income', v_total_income,
            'income', '[]'::JSON
        );
    END IF;

    -- Construct JSON object with pagination information and income records
    v_income_records := json_build_object(
        'total_pages', v_total_pages,
        'current_page', p_page_number,
        'total_income', v_total_income,
        'income', (
            SELECT COALESCE(json_agg(income_data), '[]'::JSON)
            FROM (
                SELECT
                    fi.id_income AS id_income_source,
                    f_get_income_name(p_id_family, fi.id_income) AS income_category,
                    fi.amount AS income_amount,
                    fi.description,
                    f_find_user(fi.id_created_by) AS name,
                    fi.income_date
                FROM finance_income fi
                WHERE fi.id_family = p_id_family
                  AND fi.income_date BETWEEN v_start_date AND v_end_date
                ORDER BY fi.income_date DESC
                OFFSET (p_page_number - 1) * p_items_per_page
                LIMIT p_items_per_page
            ) AS income_data
        )
    );

    RETURN v_income_records;
END;
$$;


ALTER FUNCTION public.f_get_income_with_pagination(p_id_user uuid, p_id_family integer, p_days_range integer, p_page_number integer, p_items_per_page integer) OWNER TO postgres;

--
-- TOC entry 481 (class 1255 OID 17544)
-- Name: f_get_invitation_code(uuid, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_invitation_code(p_id_user uuid, p_id_family integer) RETURNS TABLE(id_invitation integer, id_family integer, code character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM member_family mb WHERE mb.id_user = p_id_user AND mb.id_family = p_id_family) THEN
        RETURN QUERY SELECT fi.id_invitation, fi.id_family, fi.code FROM family_invitation fi WHERE fi.id_family = p_id_family;
    ELSE
        RETURN;
    END IF;
END;
$$;


ALTER FUNCTION public.f_get_invitation_code(p_id_user uuid, p_id_family integer) OWNER TO postgres;

--
-- TOC entry 482 (class 1255 OID 17545)
-- Name: f_get_invoice_detail(uuid, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_invoice_detail(p_id_user uuid, p_id_family integer, p_id_invoice integer) RETURNS TABLE(id_invoice integer, id_family integer, id_invoice_type integer, id_invoice_type_name character varying, invoice_date date, invoice_name character varying, description character varying, imageurl text, tax_amount numeric, amount numeric, total_amount numeric, created_at timestamp with time zone, updated_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN QUERY
        SELECT
			i.id_invoice,
            i.id_family,
            i.id_invoice_type,
            it.type_name,
            i.invoice_date,
            i.invoice_name,
            i.description,
            i.imageurl,
            i.tax_amount,
            i.amount,
            i.total_amount,
            i.created_at,
            i.updated_at
        FROM invoice i
		JOIN invoice_type it on i.id_invoice_type = it.id_invoice_type
        WHERE i.id_invoice = p_id_invoice;
END;
$$;


ALTER FUNCTION public.f_get_invoice_detail(p_id_user uuid, p_id_family integer, p_id_invoice integer) OWNER TO postgres;

--
-- TOC entry 483 (class 1255 OID 17546)
-- Name: f_get_invoice_item_detail(uuid, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_invoice_item_detail(p_id_user uuid, p_id_family integer, p_id_invoice integer, p_id_invoice_item integer) RETURNS TABLE(id_item integer, id_invoice integer, item_description character varying, item_name character varying, quantity integer, unit_price numeric, total_price numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM invoice i
        WHERE i.id_invoice = p_id_invoice AND i.id_family = p_id_family
    ) THEN
        RAISE EXCEPTION 'Invoice with id % is not found in family with id %', p_id_invoice, p_id_family;
    END IF;

    RETURN QUERY
    SELECT
        ii.id_item,
        ii.id_invoice,
        ii.item_description,
        ii.item_name,
        ii.quantity,
        ii.unit_price,
		ii.total_price
    FROM
        invoice_items ii
    WHERE
        ii.id_item = p_id_invoice_item AND ii.id_invoice = p_id_invoice;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Invoice item with id % not found in invoice with id %', p_id_invoice_item, p_id_invoice;
    END IF;
END;
$$;


ALTER FUNCTION public.f_get_invoice_item_detail(p_id_user uuid, p_id_family integer, p_id_invoice integer, p_id_invoice_item integer) OWNER TO postgres;

--
-- TOC entry 484 (class 1255 OID 17547)
-- Name: f_get_invoice_types(uuid, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_invoice_types(p_id_user uuid, p_id_family integer) RETURNS TABLE(id_invoice_type integer, type_name character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY 
        SELECT it.id_invoice_type, it.type_name
        FROM invoice_type it
        WHERE it.id_family = p_id_family;
END;
$$;


ALTER FUNCTION public.f_get_invoice_types(p_id_user uuid, p_id_family integer) OWNER TO postgres;

--
-- TOC entry 486 (class 1255 OID 17548)
-- Name: f_get_invoices(uuid, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_invoices(p_id_user uuid, p_id_family integer, p_page integer, p_items_per_page integer) RETURNS TABLE(id_invoice integer, id_family integer, id_invoice_type integer, id_invoice_type_name character varying, invoice_date date, invoice_name character varying, description character varying, imageurl text, tax_amount numeric, amount numeric, total_amount numeric, created_at timestamp with time zone, updated_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
        SELECT 
            i.id_invoice,
            i.id_family,
            i.id_invoice_type,
            it.type_name,
            i.invoice_date,
            i.invoice_name,
            i.description,
            i.imageurl,
            i.tax_amount,
            i.amount,
            i.total_amount,
            i.created_at,
            i.updated_at
        FROM invoice i
        JOIN invoice_type it ON i.id_invoice_type = it.id_invoice_type
        WHERE i.id_family = p_id_family
        ORDER BY i.created_at DESC
        LIMIT p_items_per_page OFFSET (p_page - 1) * p_items_per_page;
END;
$$;


ALTER FUNCTION public.f_get_invoices(p_id_user uuid, p_id_family integer, p_page integer, p_items_per_page integer) OWNER TO postgres;

--
-- TOC entry 487 (class 1255 OID 17549)
-- Name: f_get_member(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_member(p_id_user uuid) RETURNS SETOF public.users
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY SELECT id_user, email, phone, language, firstname FROM users WHERE id_user = p_id_user;
END;
$$;


ALTER FUNCTION public.f_get_member(p_id_user uuid) OWNER TO postgres;

--
-- TOC entry 488 (class 1255 OID 17550)
-- Name: f_get_monthly_revenue(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_monthly_revenue() RETURNS TABLE(month date, monthly_revenue numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    WITH months AS (
        SELECT generate_series(
            date_trunc('month', CURRENT_DATE) - INTERVAL '5 months',
            date_trunc('month', CURRENT_DATE),
            '1 month'::interval
        )::DATE AS month
    ),
    revenue AS (
        SELECT
            date_trunc('month', o.created_at)::DATE AS month,
            COALESCE(SUM(p.price)::NUMERIC, 0) AS monthly_revenue
        FROM
            "order" o
        JOIN
            package p ON o.id_package = p.id_package
        WHERE
            o.status = 'Succeeded'
        GROUP BY
            date_trunc('month', o.created_at)
    )
    SELECT
        m.month,
        COALESCE(r.monthly_revenue, 0) AS monthly_revenue
    FROM
        months m
    LEFT JOIN
        revenue r ON m.month = r.month
    ORDER BY
        m.month;
END;
$$;


ALTER FUNCTION public.f_get_monthly_revenue() OWNER TO postgres;

--
-- TOC entry 489 (class 1255 OID 17551)
-- Name: f_get_role_member(uuid, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_role_member(p_id_user uuid, p_id_family integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE 	
    v_role varchar;
    v_name varchar;
BEGIN 	
    SELECT "role" INTO v_role FROM member_family WHERE id_user = p_id_user AND id_family = p_id_family;
    
    SELECT "name" INTO v_name FROM "role" WHERE "role" = v_role;
    
    RETURN v_name;
END
$$;


ALTER FUNCTION public.f_get_role_member(p_id_user uuid, p_id_family integer) OWNER TO postgres;

--
-- TOC entry 490 (class 1255 OID 17552)
-- Name: f_get_rooms(uuid, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_rooms(p_id_user uuid, p_id_family integer) RETURNS TABLE(id_room integer, room_name character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY 
    SELECT room.id_room, room.room_name
    FROM room
    JOIN member_family ON room.id_family = member_family.id_family
    WHERE member_family.id_user = p_id_user
    AND member_family.id_family = p_id_family;
END;
$$;


ALTER FUNCTION public.f_get_rooms(p_id_user uuid, p_id_family integer) OWNER TO postgres;

--
-- TOC entry 491 (class 1255 OID 17553)
-- Name: f_get_shopping_item(uuid, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_shopping_item(p_id_user uuid, p_id_list integer, p_page integer, p_items_per_page integer) RETURNS TABLE(id_item integer, id_list integer, item_name character varying, quantity integer, is_purchased boolean, priority_level integer, reminder_date timestamp without time zone, price numeric, description character varying, id_item_type integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
		si.id_item, 
		si.id_list, 
		si.item_name, 
		si.quantity, 
		si.is_purchased, 
		si.priority_level,
		si.reminder_date,
		si.price,
		si.description,
		si.id_item_type
    FROM shopping_items si
    WHERE si.id_list = p_id_list
    OFFSET (p_page - 1) * p_items_per_page
    LIMIT p_items_per_page;

EXCEPTION WHEN OTHERS THEN
    RAISE;
END;
$$;


ALTER FUNCTION public.f_get_shopping_item(p_id_user uuid, p_id_list integer, p_page integer, p_items_per_page integer) OWNER TO postgres;

--
-- TOC entry 492 (class 1255 OID 17554)
-- Name: f_get_shopping_list(uuid, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_shopping_list(p_id_user uuid, p_id_family integer, p_page integer, p_itemsperpage integer) RETURNS TABLE(id_list integer, id_family integer, title character varying, created_at timestamp with time zone, updated_at timestamp with time zone, status character varying, description character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY
  SELECT *
  FROM shopping_lists sl
  WHERE sl.id_family = p_id_family
  ORDER BY created_at DESC
  LIMIT p_itemsPerPage OFFSET (p_page - 1) * p_itemsPerPage;
END;
$$;


ALTER FUNCTION public.f_get_shopping_list(p_id_user uuid, p_id_family integer, p_page integer, p_itemsperpage integer) OWNER TO postgres;

--
-- TOC entry 493 (class 1255 OID 17555)
-- Name: f_get_statiscal_expenditure(uuid, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_statiscal_expenditure(p_id_user uuid, p_id_family integer) RETURNS TABLE(month_year text, total_expenditure numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    WITH month_series AS (
        SELECT TO_CHAR(DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '1 month' * generate_series(0, 5), 'YYYY-MM') AS month
    ),
    expenditure_data AS (
        SELECT TO_CHAR(fe.expenditure_date, 'YYYY-MM') AS month_year, SUM(fe.amount) AS total_expenditure
        FROM finance_expenditure fe
        JOIN member_family mf ON fe.id_family = mf.id_family
        WHERE mf.id_user = p_id_user AND mf.id_family = p_id_family
          AND fe.expenditure_date >= DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '5 months'
          AND fe.expenditure_date < DATE_TRUNC('month', CURRENT_DATE) + INTERVAL '1 month'
        GROUP BY month_year
    )
    SELECT ms.month AS month_year, COALESCE(ed.total_expenditure, 0) AS total_expenditure
    FROM month_series ms
    LEFT JOIN expenditure_data ed ON ms.month = ed.month_year
    ORDER BY ms.month DESC;
END;
$$;


ALTER FUNCTION public.f_get_statiscal_expenditure(p_id_user uuid, p_id_family integer) OWNER TO postgres;

--
-- TOC entry 494 (class 1255 OID 17556)
-- Name: f_get_statiscal_income(uuid, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_statiscal_income(p_id_user uuid, p_id_family integer) RETURNS TABLE(month_year text, total_income numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    WITH month_series AS (
        SELECT TO_CHAR(DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '1 month' * generate_series(0, 5), 'YYYY-MM') AS month
    ),
    income_data AS (
        SELECT TO_CHAR(fi.income_date, 'YYYY-MM') AS month_year, SUM(fi.amount) AS total_income
        FROM finance_income fi
        JOIN member_family mf ON fi.id_family = mf.id_family
        WHERE mf.id_user = p_id_user AND mf.id_family = p_id_family
          AND fi.income_date >= DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '5 months'
          AND fi.income_date < DATE_TRUNC('month', CURRENT_DATE) + INTERVAL '1 month'
        GROUP BY month_year
    )
    SELECT ms.month AS month_year, COALESCE(id.total_income, 0) AS total_income
    FROM month_series ms
    LEFT JOIN income_data id ON ms.month = id.month_year
    ORDER BY ms.month DESC;
END;
$$;


ALTER FUNCTION public.f_get_statiscal_income(p_id_user uuid, p_id_family integer) OWNER TO postgres;

--
-- TOC entry 380 (class 1255 OID 17557)
-- Name: f_get_step_image_url(integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_step_image_url(p_id_family integer, p_id_guideline integer, p_index integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
    image_url TEXT;
BEGIN
    SELECT step->'steps'->p_index->>'imageUrl' INTO image_url
    FROM guide_items
    WHERE id_family = p_id_family AND id_item = p_id_guideline;

    RETURN image_url;
END;
$$;


ALTER FUNCTION public.f_get_step_image_url(p_id_family integer, p_id_guideline integer, p_index integer) OWNER TO postgres;

--
-- TOC entry 496 (class 1255 OID 17558)
-- Name: f_get_summary(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_summary() RETURNS TABLE(total_users integer, total_families integer, total_orders_succeeded integer, total_orders_pending integer, revenue_last_6_months numeric, total_revenue numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        -- Count total users
        (SELECT COUNT(*)::INT FROM users) AS total_users,
        
        -- Count total families
        (SELECT COUNT(*)::INT FROM family) AS total_families,
        
        -- Count orders with status 'Succeeded'
        (SELECT COUNT(*)::INT FROM "order" WHERE status = 'Succeeded') AS total_orders_succeeded,
        
        -- Count orders with status 'Pending'
        (SELECT COUNT(*)::INT FROM "order" WHERE status = 'Pending') AS total_orders_pending,
        
        -- Calculate revenue for the last 6 months
        (SELECT COALESCE(SUM(p.price)::NUMERIC, 0) 
         FROM "order" o
         JOIN package p ON o.id_package = p.id_package
         WHERE o.status = 'Succeeded'
         AND o.created_at >= CURRENT_DATE - INTERVAL '6 months') AS revenue_last_6_months,
        
        -- Calculate total revenue for all time
        (SELECT COALESCE(SUM(p.price)::NUMERIC, 0)
         FROM "order" o
         JOIN package p ON o.id_package = p.id_package
         WHERE o.status = 'Succeeded') AS total_revenue;
END;
$$;


ALTER FUNCTION public.f_get_summary() OWNER TO postgres;

--
-- TOC entry 497 (class 1255 OID 17559)
-- Name: f_get_users_info(text[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_users_info(ids text[]) RETURNS TABLE(id_user uuid, firstname character varying, lastname character varying, avatar character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT u.id_user, u.firstname, u.lastname, u.avatar
    FROM users u
    WHERE u.id_user = ANY(ARRAY(SELECT UUID(unnest(ids))));
END;
$$;


ALTER FUNCTION public.f_get_users_info(ids text[]) OWNER TO postgres;

--
-- TOC entry 498 (class 1255 OID 17560)
-- Name: f_get_users_infos(uuid[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_get_users_infos(userids uuid[]) RETURNS TABLE(id_user uuid, email character varying, phone character varying, language character varying, firstname character varying, lastname character varying, avatar character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT u.id_user, u.email, u.phone, u.language, u.firstname, u.lastname, u.avatar
    FROM users u
    WHERE u.id_user = ANY(userIds);
END;
$$;


ALTER FUNCTION public.f_get_users_infos(userids uuid[]) OWNER TO postgres;

--
-- TOC entry 499 (class 1255 OID 17561)
-- Name: f_getfamily(uuid, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_getfamily(p_id_user uuid, p_id_family integer) RETURNS SETOF public.family
    LANGUAGE plpgsql
    AS $$
DECLARE
    recordCount int;
    familyRecord family%ROWTYPE;
BEGIN
    SELECT COUNT(*) INTO recordCount FROM member_family WHERE id_user = p_id_user AND id_family = p_id_family;

    IF recordCount > 0 THEN
        SELECT * INTO familyRecord FROM family WHERE id_family = p_id_family;
        RETURN NEXT familyRecord;
    ELSE
        RETURN;
    END IF;
END;
$$;


ALTER FUNCTION public.f_getfamily(p_id_user uuid, p_id_family integer) OWNER TO postgres;

--
-- TOC entry 500 (class 1255 OID 17562)
-- Name: f_handle_forgot_password_by_email(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_handle_forgot_password_by_email(p_email text) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
	v_otp_code varchar(6);
	v_user_id uuid;
begin
	SELECT u.id_user INTO v_user_id
    FROM users u
    WHERE u.email = p_email;

	IF v_user_id IS NULL THEN
        RAISE EXCEPTION 'No user does not verify with this email';
    ELSE
        v_otp_code := LPAD((FLOOR(RANDOM() * 1000000)::INT)::TEXT, 6, '0');
        INSERT INTO otp (id_user, code, otp_type, expired_at)
        VALUES (v_user_id, v_otp_code, 'forgot password', CURRENT_TIMESTAMP + INTERVAL '15 minutes');
        RETURN v_otp_code;
    END IF;

END;
$$;


ALTER FUNCTION public.f_handle_forgot_password_by_email(p_email text) OWNER TO postgres;

--
-- TOC entry 501 (class 1255 OID 17563)
-- Name: f_handle_forgot_password_by_phone(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_handle_forgot_password_by_phone(p_phone text) RETURNS text
    LANGUAGE plpgsql
    AS $$
declare
	v_otp_code varchar(6);
	v_user_id uuid;
begin
	SELECT u.id_user INTO v_user_id
    FROM users u
    WHERE u.phone = p_phone AND u.isphoneverified = true;

	IF v_user_id IS NULL THEN
        RAISE EXCEPTION 'No user does not verify with this phone number';
    ELSE
        v_otp_code := LPAD((FLOOR(RANDOM() * 1000000)::INT)::TEXT, 6, '0');
        INSERT INTO otp (id_user, code, otp_type, expired_at)
        VALUES (v_user_id, v_otp_code, 'forgot password', CURRENT_TIMESTAMP + INTERVAL '15 minutes');
        RETURN v_otp_code;
    END IF;

END;
$$;


ALTER FUNCTION public.f_handle_forgot_password_by_phone(p_phone text) OWNER TO postgres;

--
-- TOC entry 502 (class 1255 OID 17564)
-- Name: f_handle_invitation(uuid, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_handle_invitation(p_id_user uuid, p_id_family integer, p_code character varying) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_invitation_exists BOOLEAN;
    v_user_already_member BOOLEAN;
BEGIN
    SELECT EXISTS (SELECT 1 FROM family_invitation WHERE id_family = p_id_family AND code = p_code) INTO v_invitation_exists;
    SELECT EXISTS (SELECT 1 FROM member_family WHERE id_user = p_id_user AND id_family = p_id_family) INTO v_user_already_member;
    IF v_invitation_exists AND NOT v_user_already_member THEN
        INSERT INTO member_family (id_user, id_family, "role") VALUES (p_id_user, p_id_family, 'Member');
        RETURN 'User added to the family successfully';
    ELSIF v_user_already_member THEN
        RETURN 'User is already a member of the family';
    ELSE
        RETURN 'Invalid invitation code';
    END IF;
END;
$$;


ALTER FUNCTION public.f_handle_invitation(p_id_user uuid, p_id_family integer, p_code character varying) OWNER TO postgres;

--
-- TOC entry 503 (class 1255 OID 17565)
-- Name: f_insert_component_score(text, integer, integer, integer, text, double precision, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_insert_component_score(p_id_user text, p_id_subject integer, p_id_education_progress integer, p_id_family integer, p_component_name text, p_score double precision, p_index integer) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    new_component JSONB;
    current_component_scores JSONB;
    updated_component_scores JSONB := '[]'::JSONB; -- Khởi tạo mảng JSONB rỗng cho các điểm thành phần
    final_component_scores JSONB; -- JSONB cuối cùng để cập nhật
    component_array JSONB[];
    array_length INT;
BEGIN
    new_component := jsonb_build_object(
        'component_name', p_component_name,
        'score', p_score
    );

    SELECT component_scores INTO current_component_scores FROM subjects WHERE id_subject = p_id_subject;

    -- Kiểm tra nếu component_scores là NULL hoặc là một đối tượng rỗng
    IF current_component_scores IS NULL OR current_component_scores = '{}'::JSONB THEN
        updated_component_scores := jsonb_build_array(new_component);
    ELSE
        component_array := ARRAY(SELECT jsonb_array_elements(current_component_scores -> 'component_scores'));
        array_length := array_length(component_array, 1);

        -- Xử lý cho vị trí 0 như là chèn vào đầu mảng
        IF p_index < 0 OR p_index IS NULL THEN
            p_index := 0;
        ELSIF p_index > array_length THEN
            p_index := array_length + 1; -- Đảm bảo rằng nó không vượt quá kích thước mảng
        END IF;

        FOR i IN 0..array_length LOOP
            IF i = p_index THEN
                updated_component_scores := updated_component_scores || new_component;
            END IF;
            IF i < array_length THEN
                updated_component_scores := updated_component_scores || component_array[i+1];
            END IF;
        END LOOP;
    END IF;

    -- Bọc updated_component_scores trong 'component_scores' cho kết quả cuối cùng
    final_component_scores := jsonb_build_object('component_scores', updated_component_scores);

    UPDATE subjects
    SET component_scores = final_component_scores
    WHERE id_subject = p_id_subject AND id_education_progress = p_id_education_progress;

    RETURN final_component_scores;
END;
$$;


ALTER FUNCTION public.f_insert_component_score(p_id_user text, p_id_subject integer, p_id_education_progress integer, p_id_family integer, p_component_name text, p_score double precision, p_index integer) OWNER TO postgres;

--
-- TOC entry 505 (class 1255 OID 17566)
-- Name: f_insert_guideline_step(character varying, integer, integer, character varying, character varying, text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_insert_guideline_step(p_id_user character varying, p_id_family integer, p_id_guideline integer, p_name character varying, p_description character varying, p_fileurl text, p_index integer) RETURNS json
    LANGUAGE plpgsql
    AS $$
DECLARE
    new_step JSON;
    current_steps JSON;
    updated_steps JSON;
    steps_array JSON[];
    i INTEGER;
BEGIN
    -- Tạo một đối tượng JSON mới
    new_step := json_build_object(
        'name', p_name,
        'description', p_description,
        'imageUrl', p_fileurl
    );

    -- Lấy danh sách các bước hiện tại từ cột step
    SELECT step INTO current_steps FROM guide_items WHERE id_family = p_id_family AND id_item = p_id_guideline;

    -- Nếu không có danh sách bước, tạo mới một mảng chứa bước mới
    IF current_steps IS NULL THEN
        updated_steps := json_build_object('steps', json_build_array(new_step));
    ELSE
        -- Chuyển đổi current_steps thành một mảng JSON
        steps_array := ARRAY(SELECT json_array_elements_text(current_steps->'steps'));

        -- Tạo một mảng tạm thời để chứa bước mới
        FOR i IN 0..array_length(steps_array, 1) LOOP
            IF i = p_index THEN
                -- Thêm mới bước vào vị trí chỉ định trong mảng
                steps_array := steps_array[0:i] || new_step || steps_array[i:array_length(steps_array, 1)];
                EXIT;
            END IF;
        END LOOP;

        -- Cập nhật danh sách bước đã cập nhật vào updated_steps
        updated_steps := json_build_object('steps', steps_array);
    END IF;

    -- Cập nhật cột step của bảng guide_items với mảng đã được cập nhật
    UPDATE guide_items
    SET step = updated_steps
    WHERE id_family = p_id_family AND id_item = p_id_guideline;

    -- Trả về bước mới
    RETURN new_step;
END;
$$;


ALTER FUNCTION public.f_insert_guideline_step(p_id_user character varying, p_id_family integer, p_id_guideline integer, p_name character varying, p_description character varying, p_fileurl text, p_index integer) OWNER TO postgres;

--
-- TOC entry 506 (class 1255 OID 17567)
-- Name: f_is_user_member_of_family(character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_is_user_member_of_family(p_id_user character varying, p_id_family integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Kiểm tra xem người dùng có phải là thành viên của gia đình không
    IF EXISTS (
        SELECT 1 FROM member_family
        WHERE id_user = p_id_user::uuid AND id_family = p_id_family
    ) THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$;


ALTER FUNCTION public.f_is_user_member_of_family(p_id_user character varying, p_id_family integer) OWNER TO postgres;

--
-- TOC entry 507 (class 1255 OID 17568)
-- Name: f_mark_shared_guideline(character varying, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_mark_shared_guideline(p_id_user character varying, p_id_family integer, p_id_guideline integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE guide_items
        SET is_shared = NOT is_shared
        WHERE id_family = p_id_family AND id_item = p_id_guideline;

        RETURN 'Guideline shared status successfully toggled.';
END;
$$;


ALTER FUNCTION public.f_mark_shared_guideline(p_id_user character varying, p_id_family integer, p_id_guideline integer) OWNER TO postgres;

--
-- TOC entry 508 (class 1255 OID 17569)
-- Name: f_modify_score(text, integer, integer, integer, double precision, double precision, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_modify_score(p_id_user text, p_id_subject integer, p_id_education_progress integer, p_id_family integer, p_midterm_score double precision, p_final_score double precision, p_bonus_score double precision) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Biến để lưu trữ điểm số hiện tại
    current_scores JSONB;
    -- Biến để lưu trữ kết quả trả về
    result JSONB := '{}';
BEGIN

    IF NOT EXISTS (
        SELECT 1 FROM subjects
        WHERE id_subject = p_id_subject AND id_education_progress = p_id_education_progress
    ) THEN
        RAISE EXCEPTION 'Subject ID % with Education Progress ID % not found.', p_id_subject, p_id_education_progress;
    END IF;

    -- Lấy điểm số hiện tại để so sánh
    SELECT jsonb_build_object(
        'midterm_score', midterm_score,
        'final_score', final_score,
        'bonus_score', bonus_score
    ) INTO current_scores
    FROM subjects
    WHERE id_subject = p_id_subject AND id_education_progress = p_id_education_progress;

    -- Cập nhật điểm số nếu không NULL
    UPDATE subjects
    SET midterm_score = COALESCE(p_midterm_score, midterm_score),
        final_score = COALESCE(p_final_score, final_score),
        bonus_score = COALESCE(p_bonus_score, bonus_score)
    WHERE id_subject = p_id_subject AND id_education_progress = p_id_education_progress;

    -- Xây dựng kết quả trả về dựa trên giá trị đầu vào
    IF p_midterm_score IS NOT NULL THEN
        result := result || jsonb_build_object('midterm_score', p_midterm_score);
    END IF;
    IF p_final_score IS NOT NULL THEN
        result := result || jsonb_build_object('final_score', p_final_score);
    END IF;
    IF p_bonus_score IS NOT NULL THEN
        result := result || jsonb_build_object('bonus_score', p_bonus_score);
    END IF;

    -- Trả về điểm số đã cập nhật, nếu không có gì để cập nhật, trả về điểm số hiện tại
    RETURN COALESCE(result, current_scores);
END;
$$;


ALTER FUNCTION public.f_modify_score(p_id_user text, p_id_subject integer, p_id_education_progress integer, p_id_family integer, p_midterm_score double precision, p_final_score double precision, p_bonus_score double precision) OWNER TO postgres;

--
-- TOC entry 509 (class 1255 OID 17570)
-- Name: f_remove_score(text, integer, integer, integer, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_remove_score(p_id_user text, p_id_subject integer, p_id_education_progress integer, p_id_family integer, p_score_name text) RETURNS text
    LANGUAGE plpgsql
    AS $_$
BEGIN
    -- Kiểm tra xem score_name có hợp lệ không
    IF p_score_name NOT IN ('midterm_score', 'final_score', 'bonus_score') THEN
        RAISE EXCEPTION 'Invalid score name. Must be one of: midterm_score, final_score, bonus_score.';
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM subjects
        WHERE id_subject = p_id_subject AND id_education_progress = p_id_education_progress
    ) THEN
        RAISE EXCEPTION 'Subject ID % with Education Progress ID % not found.', p_id_subject, p_id_education_progress;
    END IF;

    -- Sử dụng Dynamic SQL để set giá trị NULL cho trường chỉ định
    EXECUTE 'UPDATE subjects SET ' || p_score_name || ' = NULL WHERE id_subject = $1 AND id_education_progress = $2'
    USING p_id_subject, p_id_education_progress;

    -- Trả về tên trường đã được set NULL
    RETURN p_score_name;
END;
$_$;


ALTER FUNCTION public.f_remove_score(p_id_user text, p_id_subject integer, p_id_education_progress integer, p_id_family integer, p_score_name text) OWNER TO postgres;

--
-- TOC entry 510 (class 1255 OID 17571)
-- Name: f_reset_password_by_email(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_reset_password_by_email(p_email text, p_password text) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE users
    SET "password" = p_password
    FROM (SELECT id_user FROM users WHERE email = p_email) AS subquery
    WHERE users.id_user = subquery.id_user and login_type = 'local';

    IF found THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$;


ALTER FUNCTION public.f_reset_password_by_email(p_email text, p_password text) OWNER TO postgres;

--
-- TOC entry 511 (class 1255 OID 17572)
-- Name: f_reset_password_by_phone(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_reset_password_by_phone(p_phone text, p_password text) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE users
    SET "password" = p_password
    FROM (SELECT id_user FROM users WHERE phone = p_phone) AS subquery
    WHERE users.id_user = subquery.id_user and login_type = 'local';

    IF found THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$;


ALTER FUNCTION public.f_reset_password_by_phone(p_phone text, p_password text) OWNER TO postgres;

--
-- TOC entry 512 (class 1255 OID 17573)
-- Name: f_schedule_cleanup_expired_otps(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_schedule_cleanup_expired_otps() RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Xóa công việc cũ (nếu có)
    PERFORM pg_cancel_backend(pid)
    FROM pg_stat_activity
    WHERE state = 'idle in transaction' AND query ~* 'f_cleanup_expired_otps';

    -- Tạo công việc mới
    PERFORM pg_advisory_unlock_all();
    PERFORM pg_advisory_lock(1);

    -- Lên lịch quy trình xóa bản ghi hết hạn trong bảng otp mỗi ngày lúc 3 giờ sáng
    PERFORM cron.schedule('0 3 * * *', 'SELECT f_cleanup_expired_otps()', 'Cleanup expired OTPs');
END;
$$;


ALTER FUNCTION public.f_schedule_cleanup_expired_otps() OWNER TO postgres;

--
-- TOC entry 513 (class 1255 OID 17574)
-- Name: f_update_asset(text, integer, integer, character varying, text, numeric, date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_update_asset(p_id_user text, p_id_asset integer, p_id_family integer, p_name character varying, p_description text, p_value numeric, p_purchase_date date) RETURNS public.finance_assets
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_updated_asset finance_assets;
BEGIN
    UPDATE finance_assets
    SET name = COALESCE(p_name, name),
        description = COALESCE(p_description, description),
        value = COALESCE(p_value, value),
        purchase_date = COALESCE(p_purchase_date, purchase_date)
    WHERE id_asset = p_id_asset AND id_family = p_id_family
    RETURNING * INTO v_updated_asset;

    RETURN v_updated_asset;
END;
$$;


ALTER FUNCTION public.f_update_asset(p_id_user text, p_id_asset integer, p_id_family integer, p_name character varying, p_description text, p_value numeric, p_purchase_date date) OWNER TO postgres;

--
-- TOC entry 515 (class 1255 OID 17575)
-- Name: f_update_calendar_event(uuid, integer, character varying, character varying, timestamp without time zone, timestamp without time zone, text, boolean, integer, text, text, integer, text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_update_calendar_event(p_id_user uuid, p_id_calendar integer, p_title character varying DEFAULT NULL::character varying, p_description character varying DEFAULT NULL::character varying, p_time_start timestamp without time zone DEFAULT NULL::timestamp without time zone, p_time_end timestamp without time zone DEFAULT NULL::timestamp without time zone, p_color text DEFAULT NULL::text, p_is_all_day boolean DEFAULT NULL::boolean, p_category integer DEFAULT NULL::integer, p_location text DEFAULT NULL::text, p_recurrence_exception text DEFAULT NULL::text, p_recurrence_id integer DEFAULT NULL::integer, p_recurrence_rule text DEFAULT NULL::text, p_start_timezone text DEFAULT NULL::text, p_end_timezone text DEFAULT NULL::text) RETURNS TABLE(id_calendar integer, title character varying, description character varying, time_start timestamp without time zone, time_end timestamp without time zone, color text, is_all_day boolean, category integer, location character varying, recurrence_exception character varying, recurrence_id integer, recurrence_rule character varying, start_timezone character varying, end_timezone character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM calendar c
        INNER JOIN member_family mf ON c.id_family = mf.id_family
        WHERE mf.id_user = p_id_user AND c.id_calendar = p_id_calendar
    ) THEN
        RAISE EXCEPTION 'User does not belong to the family or calendar does not belong to the family';
    END IF;

    RETURN QUERY
    UPDATE calendar c
    SET
        title = COALESCE(p_title, c.title),
        description = COALESCE(p_description, c.description),
        time_start = COALESCE(p_time_start, c.time_start),
        time_end = COALESCE(p_time_end, c.time_end),
        color = COALESCE(p_color, c.color),
        is_all_day = COALESCE(p_is_all_day, c.is_all_day),
        category = COALESCE(p_category, c.category),
        location = COALESCE(p_location, c.location),
        recurrence_exception = COALESCE(p_recurrence_exception, c.recurrence_exception),
        recurrence_id = COALESCE(p_recurrence_id, c.recurrence_id),
        recurrence_rule = COALESCE(p_recurrence_rule, c.recurrence_rule),
        start_timezone = COALESCE(p_start_timezone, c.start_timezone),
        end_timezone = COALESCE(p_end_timezone, c.end_timezone),
        updated_at = NOW()
    WHERE c.id_calendar = p_id_calendar
    RETURNING 
        c.id_calendar,
        c.title,
        c.description,
        c.time_start,
        c.time_end,
        c.color,
        c.is_all_day,
        c.category, 
        c.location, 
        c.recurrence_exception, 
        c.recurrence_id, 
        c.recurrence_rule, 
        c.start_timezone,
        c.end_timezone;
END;
$$;


ALTER FUNCTION public.f_update_calendar_event(p_id_user uuid, p_id_calendar integer, p_title character varying, p_description character varying, p_time_start timestamp without time zone, p_time_end timestamp without time zone, p_color text, p_is_all_day boolean, p_category integer, p_location text, p_recurrence_exception text, p_recurrence_id integer, p_recurrence_rule text, p_start_timezone text, p_end_timezone text) OWNER TO postgres;

--
-- TOC entry 516 (class 1255 OID 17576)
-- Name: f_update_component_score(text, integer, integer, integer, text, double precision, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_update_component_score(p_id_user text, p_id_subject integer, p_id_education_progress integer, p_id_family integer, p_component_name text, p_score double precision, p_index integer) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    current_component_scores JSONB;
    updated_component_scores JSONB := '[]'::JSONB;
    component_array JSONB[];
    array_length INT;
    new_component JSONB;
BEGIN
    new_component := jsonb_build_object(
        'component_name', p_component_name,
        'score', p_score
    );

    SELECT component_scores INTO current_component_scores FROM subjects WHERE id_subject = p_id_subject AND id_education_progress = p_id_education_progress;

    -- Kiểm tra nếu component_scores là NULL hoặc là một đối tượng rỗng
    IF current_component_scores IS NULL OR current_component_scores = '{}'::JSONB THEN
        RAISE EXCEPTION 'No component scores available to update for subject ID %.', p_id_subject;
    ELSE
        component_array := ARRAY(SELECT jsonb_array_elements(current_component_scores -> 'component_scores'));
        array_length := array_length(component_array, 1);

        -- Điều chỉnh chỉ mục để phù hợp với bắt đầu từ 0
        IF p_index < 0 OR p_index >= array_length THEN
            RAISE EXCEPTION 'Index out of bounds. Valid index is between 0 and %', array_length - 1;
        END IF;

        -- Cập nhật giá trị tại index chỉ định
        FOR i IN 1..array_length LOOP
            IF i - 1 = p_index THEN
                updated_component_scores := updated_component_scores || new_component;
            ELSE
                updated_component_scores := updated_component_scores || component_array[i];
            END IF;
        END LOOP;

        updated_component_scores := jsonb_build_object('component_scores', updated_component_scores);
    END IF;

    UPDATE subjects
    SET component_scores = updated_component_scores
    WHERE id_subject = p_id_subject AND id_education_progress = p_id_education_progress;

    RETURN updated_component_scores;
END;
$$;


ALTER FUNCTION public.f_update_component_score(p_id_user text, p_id_subject integer, p_id_education_progress integer, p_id_family integer, p_component_name text, p_score double precision, p_index integer) OWNER TO postgres;

--
-- TOC entry 517 (class 1255 OID 17577)
-- Name: f_update_education_progress(integer, integer, integer, integer, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_update_education_progress(p_id_user integer, p_id_subject integer, p_id_education_progress integer, p_id_family integer, p_subject_name character varying, p_description character varying) RETURNS TABLE(updated_subject_name character varying, updated_description character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Kiểm tra xem id_family và id_education_progress có tồn tại trong bảng education_progress không
    IF NOT EXISTS (SELECT 1 FROM education_progress WHERE id_family = p_id_family AND id_education_progress = p_id_education_progress) THEN
        RAISE EXCEPTION 'Family or education progress not found.';
    END IF;

    -- Cập nhật bảng subjects và trả về giá trị mới
    UPDATE subjects
    SET 
        subject_name = COALESCE(p_subject_name, subject_name),
        description = COALESCE(p_description, description)
    WHERE id_education_progress = p_id_education_progress
    AND id_subject = p_id_subject
    RETURNING subject_name, description INTO updated_subject_name, updated_description;
END;
$$;


ALTER FUNCTION public.f_update_education_progress(p_id_user integer, p_id_subject integer, p_id_education_progress integer, p_id_family integer, p_subject_name character varying, p_description character varying) OWNER TO postgres;

--
-- TOC entry 518 (class 1255 OID 17578)
-- Name: f_update_education_progress(text, integer, integer, text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_update_education_progress(p_id_user text, p_id_education_progress integer, p_id_family integer, p_title text, p_progress_notes text, p_school_info text) RETURNS TABLE(id_education_progress integer, id_family integer, title text, progress_notes text, school_info text, created_at timestamp without time zone, updated_at timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
DECLARE
    user_in_family BOOLEAN;
BEGIN

    UPDATE education_progress
    SET
        title = COALESCE(p_title, education_progress.title),
        progress_notes = COALESCE(p_progress_notes, education_progress.progress_notes),
        school_info = COALESCE(p_school_info, education_progress.school_info),
        updated_at = CURRENT_TIMESTAMP
    WHERE education_progress.id_education_progress = p_id_education_progress
    RETURNING 
        education_progress.id_education_progress, 
        education_progress.id_family, 
        education_progress.title, 
        education_progress.progress_notes, 
        education_progress.school_info, 
        education_progress.created_at, 
        education_progress.updated_at 
    INTO STRICT 
		id_education_progress, 
        id_family, 
        title, 
        progress_notes, 
        school_info, 
        created_at, 
        updated_at;
    
    RETURN NEXT;
END;
$$;


ALTER FUNCTION public.f_update_education_progress(p_id_user text, p_id_education_progress integer, p_id_family integer, p_title text, p_progress_notes text, p_school_info text) OWNER TO postgres;

--
-- TOC entry 519 (class 1255 OID 17579)
-- Name: f_update_expenditure(text, integer, text, integer, numeric, date, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_update_expenditure(p_id_user text, p_id_expenditure integer, p_id_created_by text, p_id_expense_type integer, p_amount numeric, p_expenditure_date date, p_description text) RETURNS TABLE(id_expenditure integer, id_created_by uuid, id_expense_type integer, amount numeric, expenditure_date date, description text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF EXISTS (
        SELECT 1
		FROM users u
		INNER JOIN member_family mf ON u.id_user = mf.id_user
		INNER JOIN finance_expenditure e ON mf.id_family = e.id_family
		WHERE u.id_user = p_id_user::uuid AND e.id_expenditure = p_id_expenditure
    ) THEN
        UPDATE finance_expenditure SET
            id_expense_type = COALESCE(p_id_expense_type, finance_expenditure.id_expense_type),
            amount = COALESCE(p_amount, finance_expenditure.amount),
            expenditure_date = COALESCE(p_expenditure_date, finance_expenditure.expenditure_date),
            description = COALESCE(p_description, finance_expenditure.description),
			id_created_by = COALESCE(p_id_created_by::uuid, finance_expenditure.id_created_by)
        WHERE finance_expenditure.id_expenditure = p_id_expenditure;

        RETURN QUERY
        SELECT 
			finance_expenditure.id_expenditure, 
			finance_expenditure.id_created_by,
			finance_expenditure.id_expense_type, 
			finance_expenditure.amount, 
			finance_expenditure.expenditure_date, 
			finance_expenditure.description
        FROM finance_expenditure
        WHERE finance_expenditure.id_expenditure = p_id_expenditure;
    ELSE
        RAISE EXCEPTION 'User is not authorized to update this income entry.';
    END IF;
END;
$$;


ALTER FUNCTION public.f_update_expenditure(p_id_user text, p_id_expenditure integer, p_id_created_by text, p_id_expense_type integer, p_amount numeric, p_expenditure_date date, p_description text) OWNER TO postgres;

--
-- TOC entry 387 (class 1255 OID 17581)
-- Name: f_update_expenditure_type(uuid, integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_update_expenditure_type(p_id_user uuid, p_id_expenditure_type integer, p_id_family integer, p_name character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_exists BOOLEAN;
BEGIN
    UPDATE finance_expenditure_type
    SET expense_name = p_name
    WHERE id_expense_type = p_id_expenditure_type AND id_family = p_id_family;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Expenditure type not found or does not belong to the family.';
    END IF;
END;
$$;


ALTER FUNCTION public.f_update_expenditure_type(p_id_user uuid, p_id_expenditure_type integer, p_id_family integer, p_name character varying) OWNER TO postgres;

--
-- TOC entry 520 (class 1255 OID 17582)
-- Name: f_update_family(uuid, integer, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_update_family(p_id_user uuid, p_id_family integer, p_name character varying, p_description character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
    recordCount int;
   	result_message varchar;
    recordCount_user int;
   	recordCount_family int;

begin
	select count(*) into recordCount_user from users where id_user=p_id_user; 
	select count(*) into recordCount_family from family where id_family = p_id_family; 
	SELECT COUNT(*) INTO recordCount FROM member_family WHERE id_user = p_id_user AND id_family = p_id_family;
	if recordCount_user then 
		if recordCount_family >0 then
			if recordCount> 0 then 
			    BEGIN
			        UPDATE family SET description = p_description, "name" = p_name, updated_at=now() WHERE id_family = p_id_family;
			       	result_message:='Successfully updated family';
			    EXCEPTION
			        WHEN others THEN
			           result_message:= 'Failed to update family';
			    END;
			 else 
		       	 result_message:= 'Not in the same family';
		
			 end if;
		else 
	       	 result_message:= 'Invalid family provided';
	    end if;

	else 
       	 result_message:= 'Invalid user provided';
    end if; 

	return result_message;
end;
$$;


ALTER FUNCTION public.f_update_family(p_id_user uuid, p_id_family integer, p_name character varying, p_description character varying) OWNER TO postgres;

--
-- TOC entry 521 (class 1255 OID 17583)
-- Name: f_update_finance_income_source(uuid, integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_update_finance_income_source(p_id_user uuid, p_id_income integer, p_id_family integer, p_name character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_exists BOOLEAN;
BEGIN
    -- Update income source name
    UPDATE finance_income_source
    SET income_name = p_name
    WHERE id_income_source = p_id_income AND id_family = p_id_family;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Income source not found or does not belong to the family.';
    END IF;
END;
$$;


ALTER FUNCTION public.f_update_finance_income_source(p_id_user uuid, p_id_income integer, p_id_family integer, p_name character varying) OWNER TO postgres;

--
-- TOC entry 522 (class 1255 OID 17584)
-- Name: f_update_guideline(character varying, integer, integer, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_update_guideline(p_id_user character varying, p_id_family integer, p_id_item integer, p_name character varying, p_description character varying) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE guide_items
    SET name = p_name, description = p_description, updated_at = CURRENT_TIMESTAMP
    WHERE id_family = p_id_family AND id_item = p_id_item;
    
    IF NOT FOUND THEN
        RAISE EXCEPTION 'No guideline found with ID % in family ID % to update.', p_id_item, p_id_family;
    END IF;

    RETURN 'Guideline with ID ' || p_id_item || ' has been successfully updated.';
END;
$$;


ALTER FUNCTION public.f_update_guideline(p_id_user character varying, p_id_family integer, p_id_item integer, p_name character varying, p_description character varying) OWNER TO postgres;

--
-- TOC entry 523 (class 1255 OID 17585)
-- Name: f_update_guideline_step(character varying, integer, integer, integer, character varying, character varying, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_update_guideline_step(p_id_user character varying, p_id_family integer, p_id_guideline integer, p_index integer, p_name character varying, p_description character varying, p_fileurl text) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    current_step JSONB;
    updated_steps JSONB;
BEGIN
    SELECT step->'steps'->p_index INTO current_step
    FROM guide_items
    WHERE id_family = p_id_family AND id_item = p_id_guideline;
    
    current_step := jsonb_build_object(
        'name', COALESCE(p_name, current_step->>'name'),
        'description', COALESCE(p_description, current_step->>'description'),
        'fileUrl', COALESCE(p_fileUrl, current_step->>'fileUrl')
    );
    
    UPDATE guide_items
    SET step = jsonb_set(step, ARRAY['steps', p_index::text], current_step, true)
    WHERE id_family = p_id_family AND id_item = p_id_guideline
    RETURNING step->'steps'->p_index INTO updated_steps;
    
    RETURN updated_steps;
END;
$$;


ALTER FUNCTION public.f_update_guideline_step(p_id_user character varying, p_id_family integer, p_id_guideline integer, p_index integer, p_name character varying, p_description character varying, p_fileurl text) OWNER TO postgres;

--
-- TOC entry 524 (class 1255 OID 17586)
-- Name: f_update_household_consumable_item(text, integer, integer, integer, integer, date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_update_household_consumable_item(p_id_user text, p_id_family integer, p_id_item integer, p_quantity integer, p_threshold integer, p_expired_date date) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE household_consumable_items
    SET quantity = COALESCE(p_quantity, quantity),
        threshold = COALESCE(p_threshold, threshold),
        expired_date = COALESCE(p_expired_date, expired_date)
    WHERE id_household_item = p_id_item;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Item not found or no update necessary.';
    END IF;

    RETURN 'Consumable item updated successfully.';
END;
$$;


ALTER FUNCTION public.f_update_household_consumable_item(p_id_user text, p_id_family integer, p_id_item integer, p_quantity integer, p_threshold integer, p_expired_date date) OWNER TO postgres;

--
-- TOC entry 525 (class 1255 OID 17587)
-- Name: f_update_household_durable_item(text, integer, integer, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_update_household_durable_item(p_id_user text, p_id_family integer, p_id_item integer, p_condition text) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE household_durable_items
    SET condition = p_condition
    WHERE id_household_item = p_id_item;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Item not found or no update necessary.';
    END IF;
	
	RETURN 'Durable item updated successfully';
END;
$$;


ALTER FUNCTION public.f_update_household_durable_item(p_id_user text, p_id_family integer, p_id_item integer, p_condition text) OWNER TO postgres;

--
-- TOC entry 526 (class 1255 OID 17588)
-- Name: f_update_household_item(text, integer, integer, text, text, integer, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_update_household_item(p_id_user text, p_id_family integer, p_id_item integer, p_item_name text DEFAULT NULL::text, p_item_description text DEFAULT NULL::text, p_id_category integer DEFAULT NULL::integer, p_item_imageurl text DEFAULT NULL::text) RETURNS public.household_item_update
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_old_imageUrl TEXT;
    v_result household_item_update;
BEGIN
    SELECT item_imageUrl INTO v_old_imageUrl
    FROM household_items
    WHERE id_household_item = p_id_item AND id_family = p_id_family;

    UPDATE household_items
    SET 
        item_name = COALESCE(p_item_name, item_name),
        item_description = COALESCE(p_item_description, item_description),
        id_category = COALESCE(p_id_category, id_category),
        item_imageUrl = COALESCE(p_item_imageUrl, item_imageUrl)
    WHERE id_household_item = p_id_item AND id_family = p_id_family;

    SELECT item_name, item_description, id_category, item_imageUrl
    INTO v_result.new_item_name, v_result.new_item_description, v_result.new_id_category, v_result.new_item_imageUrl
    FROM household_items
    WHERE id_household_item = p_id_item AND id_family = p_id_family;

    v_result.old_imageUrl := v_old_imageUrl;

    RETURN v_result;
END;
$$;


ALTER FUNCTION public.f_update_household_item(p_id_user text, p_id_family integer, p_id_item integer, p_item_name text, p_item_description text, p_id_category integer, p_item_imageurl text) OWNER TO postgres;

--
-- TOC entry 528 (class 1255 OID 17589)
-- Name: f_update_household_item(text, integer, integer, integer, text, text, integer, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_update_household_item(p_id_user text, p_id_family integer, p_id_item integer, p_id_room integer, p_item_name text DEFAULT NULL::text, p_item_description text DEFAULT NULL::text, p_id_category integer DEFAULT NULL::integer, p_item_imageurl text DEFAULT NULL::text) RETURNS public.household_item_update
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_old_imageUrl TEXT;
    v_result household_item_update;
BEGIN
    SELECT item_imageUrl INTO v_old_imageUrl
    FROM household_items
    WHERE id_household_item = p_id_item AND id_family = p_id_family;

    UPDATE household_items
    SET 
        item_name = COALESCE(p_item_name, item_name),
        item_description = COALESCE(p_item_description, item_description),
        id_category = COALESCE(p_id_category, id_category),
        item_imageUrl = COALESCE(p_item_imageUrl, item_imageUrl),
		id_room = COALESCE(p_id_room, id_room)
    WHERE id_household_item = p_id_item AND id_family = p_id_family;

    SELECT item_name, item_description, id_category, item_imageUrl
    INTO v_result.new_item_name, v_result.new_item_description, v_result.new_id_category, v_result.new_item_imageUrl
    FROM household_items
    WHERE id_household_item = p_id_item AND id_family = p_id_family;

    v_result.old_imageUrl := v_old_imageUrl;

    RETURN v_result;
END;
$$;


ALTER FUNCTION public.f_update_household_item(p_id_user text, p_id_family integer, p_id_item integer, p_id_room integer, p_item_name text, p_item_description text, p_id_category integer, p_item_imageurl text) OWNER TO postgres;

--
-- TOC entry 529 (class 1255 OID 17590)
-- Name: f_update_income(text, integer, uuid, integer, numeric, date, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_update_income(p_id_user text, p_id_income integer, p_id_created_by uuid, p_id_income_source integer, p_amount numeric, p_income_date date, p_description text) RETURNS TABLE(id_income integer, id_income_source integer, amount numeric, income_date date, description text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM finance_income
        WHERE finance_income.id_income = p_id_income AND (id_created_by = p_id_user::uuid OR id_created_by = p_id_created_by)
    ) THEN
        UPDATE finance_income SET
            id_income_source = COALESCE(p_id_income_source, finance_income.id_income_source),
            amount = COALESCE(p_amount, finance_income.amount),
            income_date = COALESCE(p_income_date, finance_income.income_date),
            description = COALESCE(p_description, finance_income.description)
        WHERE finance_income.id_income = p_id_income;

        RETURN QUERY
        SELECT finance_income.id_income, finance_income.id_income_source, 
		finance_income.amount, finance_income.income_date, finance_income.description
        FROM finance_income
        WHERE finance_income.id_income = p_id_income;
    ELSE
        RAISE EXCEPTION 'User is not authorized to update this income entry.';
    END IF;
END;
$$;


ALTER FUNCTION public.f_update_income(p_id_user text, p_id_income integer, p_id_created_by uuid, p_id_income_source integer, p_amount numeric, p_income_date date, p_description text) OWNER TO postgres;

--
-- TOC entry 530 (class 1255 OID 17592)
-- Name: f_update_invoice(uuid, integer, integer, integer, character varying, date, character varying, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_update_invoice(id_user_param uuid, id_invoice_param integer, id_family_param integer, id_invoice_type_param integer, invoice_name_param character varying, invoice_date_param date, description_param character varying, fileurl_param text) RETURNS TABLE(id_invoice integer, id_family integer, id_invoice_type integer, invoice_date date, total_amount numeric, description character varying, imageurl text, created_at timestamp with time zone, updated_at timestamp with time zone, invoice_name character varying, old_imageurl text)
    LANGUAGE plpgsql
    AS $$
DECLARE
    old_imageurl text;
BEGIN
    -- Fetch the old image URL and check if the invoice exists in one query
    SELECT i.imageurl INTO old_imageurl 
    FROM invoice i
    WHERE i.id_invoice = id_invoice_param;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Invoice does not exist.';
        RETURN;
    END IF;

    UPDATE invoice
    SET
        id_invoice_type = COALESCE(id_invoice_type_param, invoice.id_invoice_type),
        invoice_name = COALESCE(invoice_name_param, invoice.invoice_name),
        invoice_date = COALESCE(invoice_date_param, invoice.invoice_date),
        description = COALESCE(description_param, invoice.description),
        imageurl = COALESCE(fileurl_param, invoice.imageurl)
    WHERE invoice.id_invoice = id_invoice_param;

    RETURN QUERY
    SELECT
        i.*,
        old_imageurl
    FROM invoice i
    WHERE i.id_invoice = id_invoice_param;
END;
$$;


ALTER FUNCTION public.f_update_invoice(id_user_param uuid, id_invoice_param integer, id_family_param integer, id_invoice_type_param integer, invoice_name_param character varying, invoice_date_param date, description_param character varying, fileurl_param text) OWNER TO postgres;

--
-- TOC entry 531 (class 1255 OID 17593)
-- Name: f_update_invoice_items(uuid, integer, integer, integer, character varying, character varying, integer, numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_update_invoice_items(p_id_user uuid, p_id_family integer, p_id_invoice integer, p_id_item integer, p_item_name character varying, p_item_description character varying, p_quantity integer, p_unit_price numeric) RETURNS TABLE(id_item integer, id_invoice integer, item_description character varying, item_name character varying, quantity integer, unit_price numeric, total_price numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 
        FROM member_family mf
        JOIN invoice i ON mf.id_family = i.id_family
        JOIN invoice_items ii ON i.id_invoice = ii.id_invoice
        WHERE mf.id_user = p_id_user 
          AND mf.id_family = p_id_family
          AND i.id_invoice = p_id_invoice
          AND ii.id_item = p_id_item
    ) THEN
        RAISE EXCEPTION 'Validation failed: either user is not a member of the family, invoice not found in family, or invoice item not found in invoice';
    END IF;

	RETURN QUERY
    UPDATE invoice_items
    SET 
        item_name = COALESCE(p_item_name, invoice_items.item_name),
        item_description = COALESCE(p_item_description, invoice_items.item_description),
        quantity = COALESCE(p_quantity, invoice_items.quantity),
        unit_price = COALESCE(p_unit_price, invoice_items.unit_price)
    WHERE invoice_items.id_item = p_id_item
    RETURNING 
        invoice_items.id_item,
        invoice_items.id_invoice,
        invoice_items.item_description,
        invoice_items.item_name,
        invoice_items.quantity,
        invoice_items.unit_price,
        invoice_items.total_price;
END;
$$;


ALTER FUNCTION public.f_update_invoice_items(p_id_user uuid, p_id_family integer, p_id_invoice integer, p_id_item integer, p_item_name character varying, p_item_description character varying, p_quantity integer, p_unit_price numeric) OWNER TO postgres;

--
-- TOC entry 532 (class 1255 OID 17594)
-- Name: f_update_invoice_type(uuid, integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_update_invoice_type(p_id_user uuid, p_id_family integer, p_id_invoice_type integer, p_type_name character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE invoice_type 
    SET type_name = p_type_name
    WHERE id_invoice_type = p_id_invoice_type AND id_family = p_id_family;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'No invoice type found for user with id %, family with id %, and invoice type with id %', p_id_user, p_id_family, p_id_invoice_type;
    END IF;
END;
$$;


ALTER FUNCTION public.f_update_invoice_type(p_id_user uuid, p_id_family integer, p_id_invoice_type integer, p_type_name character varying) OWNER TO postgres;

--
-- TOC entry 399 (class 1255 OID 17595)
-- Name: f_update_room(uuid, integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_update_room(p_id_user uuid, p_id_family integer, p_id_room integer, p_room_name character varying) RETURNS TABLE(id_room integer, room_name character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE room
    SET room_name = p_room_name
    WHERE room.id_room = p_id_room AND room.id_family = p_id_family
    RETURNING room.id_room, room.room_name INTO id_room, room_name;

    RETURN NEXT;
END;
$$;


ALTER FUNCTION public.f_update_room(p_id_user uuid, p_id_family integer, p_id_room integer, p_room_name character varying) OWNER TO postgres;

--
-- TOC entry 533 (class 1255 OID 17596)
-- Name: f_update_shopping_item(uuid, integer, integer, character varying, integer, boolean, integer, timestamp without time zone, numeric, character varying, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_update_shopping_item(p_id_user uuid, p_id_item integer, p_id_list integer, p_item_name character varying, p_quantity integer, p_is_purchased boolean, p_priority_level integer, p_reminder_date timestamp without time zone, p_price numeric, p_description character varying, p_id_item_type integer) RETURNS TABLE(id_item integer, id_list integer, item_name character varying, quantity integer, is_purchased boolean, priority_level integer, reminder_date timestamp without time zone, price numeric, description character varying, id_item_type integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
  -- Kiểm tra xem user có quyền sửa shopping item hay không
  IF NOT EXISTS (
    SELECT 1
    FROM shopping_items si
    JOIN shopping_lists sl ON si.id_list = sl.id_list
    JOIN member_family mf ON sl.id_family = mf.id_family
    WHERE si.id_item = p_id_item AND mf.id_user = p_id_user
  ) THEN
    RAISE EXCEPTION 'User does not have permission to update this shopping item';
  END IF;

  -- Cập nhật shopping item, bỏ qua giá trị NULL
  UPDATE shopping_items
  SET
    item_name = COALESCE(p_item_name, shopping_items.item_name),
    quantity = COALESCE(p_quantity, shopping_items.quantity),
    is_purchased = COALESCE(p_is_purchased, shopping_items.is_purchased),
    priority_level = COALESCE(p_priority_level, shopping_items.priority_level),
    reminder_date = COALESCE(p_reminder_date, shopping_items.reminder_date),
    price = COALESCE(p_price, shopping_items.price),
    description = COALESCE(p_description, shopping_items.description),
    id_item_type = COALESCE(p_id_item_type, shopping_items.id_item_type)
  WHERE shopping_items.id_item = p_id_item;

  -- Trả về giá trị sau khi update
  RETURN QUERY
  SELECT si.id_item, si.id_list, si.item_name, si.quantity, si.is_purchased, si.priority_level, 
         si.reminder_date, si.price, si.description, si.id_item_type
  FROM shopping_items si
  WHERE si.id_item = p_id_item;
END;
$$;


ALTER FUNCTION public.f_update_shopping_item(p_id_user uuid, p_id_item integer, p_id_list integer, p_item_name character varying, p_quantity integer, p_is_purchased boolean, p_priority_level integer, p_reminder_date timestamp without time zone, p_price numeric, p_description character varying, p_id_item_type integer) OWNER TO postgres;

--
-- TOC entry 534 (class 1255 OID 17597)
-- Name: f_update_shopping_list(uuid, integer, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_update_shopping_list(p_id_user uuid, p_id_list integer, p_title character varying, p_description character varying) RETURNS TABLE(id_list integer, id_family integer, title character varying, created_at timestamp with time zone, updated_at timestamp with time zone, status character varying, description character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM shopping_lists sl
    JOIN member_family mf ON sl.id_family = mf.id_family
    WHERE sl.id_list = p_id_list AND mf.id_user = p_id_user
  ) THEN
    RAISE EXCEPTION 'User does not have permission to update this shopping list';
  END IF;

  UPDATE shopping_lists
  SET 
    title = COALESCE(p_title, shopping_lists.title),
    description = COALESCE(p_description, shopping_lists.description),
    updated_at = NOW()
  WHERE shopping_lists.id_list = p_id_list;

  RETURN QUERY
  SELECT sl.id_list, sl.id_family, sl.title, sl.created_at, sl.updated_at, sl.status, sl.description
  FROM shopping_lists sl
  WHERE sl.id_list = p_id_list;
END;
$$;


ALTER FUNCTION public.f_update_shopping_list(p_id_user uuid, p_id_list integer, p_title character varying, p_description character varying) OWNER TO postgres;

--
-- TOC entry 535 (class 1255 OID 17600)
-- Name: f_update_user_profile(uuid, text, text, text, date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_update_user_profile(p_id_user uuid, p_firstname text, p_lastname text, p_genre text, p_birthdate date) RETURNS public.users
    LANGUAGE plpgsql
    AS $$
DECLARE
    updated_user users;
BEGIN
    UPDATE users
    SET
        firstname = COALESCE(p_firstname, firstname),
        lastname = COALESCE(p_lastname, lastname),
        genre = COALESCE(p_genre, genre),
        birthdate = COALESCE(p_birthdate, birthdate)
    WHERE id_user = p_id_user
    RETURNING * INTO updated_user;

    RETURN updated_user;
END;
$$;


ALTER FUNCTION public.f_update_user_profile(p_id_user uuid, p_firstname text, p_lastname text, p_genre text, p_birthdate date) OWNER TO postgres;

--
-- TOC entry 536 (class 1255 OID 17601)
-- Name: f_validate_otp(uuid, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_validate_otp(p_id_user uuid, p_otp character varying, p_email character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE
    otp_valid BOOLEAN := FALSE;
BEGIN
    -- Check if the OTP is correct, belongs to the user, matches the email, and is not expired.
    SELECT EXISTS (
        SELECT 1
        FROM otp
        WHERE id_user = p_id_user
          AND code = p_otp
          AND email = p_email
          AND expired_at > NOW()
    ) INTO otp_valid;

    -- If the OTP is valid, update the user's email verification status.
    IF otp_valid THEN
        UPDATE users
        SET isemailverified = TRUE
        WHERE id_user = p_id_user;

        -- Delete the OTP as it has been used.
        DELETE FROM otp
        WHERE id_user = p_id_user AND code = p_otp;
    END IF;

    -- Return whether the OTP was valid.
    RETURN otp_valid;
END;
$$;


ALTER FUNCTION public.f_validate_otp(p_id_user uuid, p_otp character varying, p_email character varying) OWNER TO postgres;

--
-- TOC entry 537 (class 1255 OID 17602)
-- Name: f_validate_otp(character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_validate_otp(p_id_user character varying, p_otp character varying, p_email character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE
    otp_valid BOOLEAN := FALSE;
BEGIN
    -- Check if the OTP is correct, belongs to the user, matches the email, and is not expired.
    SELECT EXISTS (
        SELECT 1
        FROM otp
        WHERE id_user = uuid(p_id_user)
          AND code = p_otp
          AND email = p_email
          AND expired_at > NOW()
    ) INTO otp_valid;

    -- If the OTP is valid, update the user's email verification status.
    IF otp_valid THEN
        UPDATE users
        SET isemailverified = TRUE
        WHERE id_user = uuid(p_id_user);

        -- Delete the OTP as it has been used.
        DELETE FROM otp
        WHERE id_user = uuid(p_id_user) AND code = p_otp;
    END IF;

    -- Return whether the OTP was valid.
    RETURN otp_valid;
END;
$$;


ALTER FUNCTION public.f_validate_otp(p_id_user character varying, p_otp character varying, p_email character varying) OWNER TO postgres;

--
-- TOC entry 538 (class 1255 OID 17603)
-- Name: f_validate_user_mail(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_validate_user_mail(p_mail character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE
    mail_exists BOOLEAN;
BEGIN
    mail_exists := FALSE;
    SELECT TRUE INTO mail_exists
    FROM users
    where email = p_mail
    LIMIT 1;
    RETURN mail_exists;
END
$$;


ALTER FUNCTION public.f_validate_user_mail(p_mail character varying) OWNER TO postgres;

--
-- TOC entry 539 (class 1255 OID 17604)
-- Name: f_validate_user_phone(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.f_validate_user_phone(p_phone character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE
    phone_exists BOOLEAN;
BEGIN
    phone_exists := FALSE;
    SELECT TRUE INTO phone_exists
    from users
    WHERE phone = p_phone
    LIMIT 1;

    RETURN phone_exists;
END;
$$;


ALTER FUNCTION public.f_validate_user_phone(p_phone character varying) OWNER TO postgres;

--
-- TOC entry 400 (class 1255 OID 17605)
-- Name: generate_invite_code(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.generate_invite_code() RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
    chars VARCHAR := 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    result VARCHAR := '';
    i INTEGER;
BEGIN
    FOR i IN 1..1 LOOP
        result := result || substr(chars, floor(random() * length(chars) + 1)::INTEGER, 1);
    END LOOP;
    RETURN result;
END;
$$;


ALTER FUNCTION public.generate_invite_code() OWNER TO postgres;

--
-- TOC entry 409 (class 1255 OID 17606)
-- Name: generate_key(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.generate_key(length integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
    random_key VARCHAR;
BEGIN
    SELECT gen_salt('md5') || substr(md5(random()::text), 0, length) INTO random_key;

    RETURN random_key;
END;
$$;


ALTER FUNCTION public.generate_key(length integer) OWNER TO postgres;

--
-- TOC entry 426 (class 1255 OID 17607)
-- Name: generate_unique_invite_code(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.generate_unique_invite_code() RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
    characters VARCHAR := 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    invite_code VARCHAR := '';
    i INT := 0;
BEGIN
    FOR i IN 1..10 LOOP -- Độ dài mã mời mong muốn (10 ký tự)
        invite_code := invite_code || substr(characters, floor(random() * length(characters) + 1)::integer, 1);
    END LOOP;
    
    RETURN invite_code;
END;
$$;


ALTER FUNCTION public.generate_unique_invite_code() OWNER TO postgres;

--
-- TOC entry 504 (class 1255 OID 17608)
-- Name: generate_unique_invite_code(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.generate_unique_invite_code(p_id_family integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
    characters VARCHAR := 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    invite_code VARCHAR := '';
    i INT := 0;
    result VARCHAR := '';
    
BEGIN
    -- Kiểm tra xem có mã mời tồn tại trong bảng family không
    SELECT code_invite INTO invite_code FROM family WHERE id_family=p_id_family;

    -- Nếu không có mã mời tồn tại, tạo mới một mã mời
    IF invite_code IS NULL THEN
        FOR i IN 1..10 LOOP -- Độ dài mã mời mong muốn (10 ký tự)
            invite_code := invite_code || substr(characters, floor(random() * length(characters) + 1)::integer, 1);
        END LOOP;
        -- Cập nhật mã mời vào bảng family
        UPDATE family SET code_invite=invite_code where id_family=p_id_family;
    END IF;
          
    result:= 'http://localhost:8080/invite/' || invite_code;
    RETURN result;
END;
$$;


ALTER FUNCTION public.generate_unique_invite_code(p_id_family integer) OWNER TO postgres;

--
-- TOC entry 527 (class 1255 OID 17609)
-- Name: get_active_sessions_defaultdb(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_active_sessions_defaultdb() RETURNS TABLE(pid integer, usename name, datname name, client_addr inet, client_port integer, backend_start timestamp with time zone, state text, query_start timestamp with time zone, state_change timestamp with time zone)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        psa.pid,
        psa.usename,
        psa.datname,
        psa.client_addr,
        psa.client_port,
        psa.backend_start,
        psa.state,
        psa.query_start,
        psa.state_change
    FROM
        pg_stat_activity psa
    WHERE 
        psa.state = 'active' AND psa.datname = 'defaultdb';
END;
$$;


ALTER FUNCTION public.get_active_sessions_defaultdb() OWNER TO postgres;

--
-- TOC entry 540 (class 1255 OID 17610)
-- Name: get_all_category_events(integer, uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_all_category_events(p_id_family integer, p_id_user uuid) RETURNS TABLE(id_category_event integer, title character varying, color character varying, id_family integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM member_family f WHERE f.id_family = p_id_family AND f.id_user = p_id_user) THEN
        RETURN QUERY
        SELECT category_event.id_category_event, category_event.title, category_event.color, category_event.id_family FROM category_event WHERE category_event.id_family = p_id_family;
    ELSE
        RAISE EXCEPTION 'User does not belong to the specified family';
    END IF;
END;
$$;


ALTER FUNCTION public.get_all_category_events(p_id_family integer, p_id_user uuid) OWNER TO postgres;

--
-- TOC entry 541 (class 1255 OID 17611)
-- Name: get_all_family(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_all_family(p_id_user uuid) RETURNS SETOF public.family
    LANGUAGE plpgsql
    AS $$
DECLARE
    familyRecord RECORD;
BEGIN
    FOR familyRecord IN 
        SELECT id_family FROM member_family WHERE id_user = p_id_user
    LOOP
        RETURN QUERY SELECT * FROM family WHERE id_family = familyRecord.id_family;
    END LOOP;
END;
$$;


ALTER FUNCTION public.get_all_family(p_id_user uuid) OWNER TO postgres;

--
-- TOC entry 542 (class 1255 OID 17612)
-- Name: get_category_event(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_category_event(p_id_category integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_name text;
BEGIN
    SELECT title INTO v_name
    FROM category_event
    WHERE id_category_event = p_id_category;

    RETURN v_name;
END;
$$;


ALTER FUNCTION public.get_category_event(p_id_category integer) OWNER TO postgres;

--
-- TOC entry 543 (class 1255 OID 17613)
-- Name: get_category_event_by_id(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_category_event_by_id(_id_category_event integer) RETURNS TABLE(id_category_event integer, title character varying, color character varying, id_family integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT * FROM category_event WHERE id_category_event = _id_category_event;
END;
$$;


ALTER FUNCTION public.get_category_event_by_id(_id_category_event integer) OWNER TO postgres;

--
-- TOC entry 544 (class 1255 OID 17614)
-- Name: get_category_event_by_id(integer, uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_category_event_by_id(_id_category_event integer, _id_user uuid) RETURNS TABLE(id_category_event integer, title character varying, color character varying, id_family integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM member_family f WHERE f.id_family = p_id_family AND f.id_user = p_id_user) THEN
        RETURN QUERY
        SELECT * FROM category_event WHERE id_category_event = _id_category_event;
    ELSE
        RAISE EXCEPTION 'User does not belong to the specified family';
    END IF;
END;
$$;


ALTER FUNCTION public.get_category_event_by_id(_id_category_event integer, _id_user uuid) OWNER TO postgres;

--
-- TOC entry 545 (class 1255 OID 17615)
-- Name: get_events_for_family_on_date(date, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_events_for_family_on_date(selected_date date, family_id integer) RETURNS TABLE(id_calendar integer, datetime timestamp without time zone, description text, id_family integer, title text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT id_calendar, datetime, description, id_family, title
    FROM calendar
    WHERE id_family = family_id
    AND DATE(datetime) = selected_date;
END;
$$;


ALTER FUNCTION public.get_events_for_family_on_date(selected_date date, family_id integer) OWNER TO postgres;

--
-- TOC entry 546 (class 1255 OID 17616)
-- Name: get_package_info_by_id_user(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_package_info_by_id_user(id_user integer) RETURNS TABLE(id_package integer, expired_at timestamp without time zone, package_info jsonb)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY 
    SELECT o.id_package, p.name, p.price, p.description, o.expired_at
    FROM "order" o
    JOIN package p ON o.id_package = p.id
    WHERE o.status = 'Successed' AND o.id_user = id_user;
END;
$$;


ALTER FUNCTION public.get_package_info_by_id_user(id_user integer) OWNER TO postgres;

--
-- TOC entry 495 (class 1255 OID 25029)
-- Name: insert_finance_expenditure(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.insert_finance_expenditure() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Không thực hiện hành động nào
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.insert_finance_expenditure() OWNER TO postgres;

--
-- TOC entry 514 (class 1255 OID 25030)
-- Name: insert_income_sources(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.insert_income_sources() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Không thực hiện hành động nào
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.insert_income_sources() OWNER TO postgres;

--
-- TOC entry 547 (class 1255 OID 17619)
-- Name: p_create_role(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.p_create_role() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN 
    EXECUTE 'CREATE ROLE ' || NEW.role;
    EXECUTE 'GRANT CONNECT ON DATABASE famfund_i2wq_a3fq TO ' || NEW.role;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.p_create_role() OWNER TO postgres;

--
-- TOC entry 548 (class 1255 OID 17620)
-- Name: p_delete_member(uuid, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.p_delete_member(IN p_id_user uuid, IN p_id_family integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM member_family WHERE id_user = p_id_user AND id_family = p_id_family) THEN
        DELETE FROM member_family WHERE id_user = p_id_user AND id_family = p_id_family;
    END IF;
END;
$$;


ALTER PROCEDURE public.p_delete_member(IN p_id_user uuid, IN p_id_family integer) OWNER TO postgres;

--
-- TOC entry 549 (class 1255 OID 17621)
-- Name: p_delete_member(uuid, uuid, integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.p_delete_member(IN p_id_current_user uuid, IN p_id_user uuid, IN p_id_family integer)
    LANGUAGE plpgsql
    AS $$
DECLARE
    recordCount int;
BEGIN 
    SELECT COUNT(*) INTO recordCount FROM member_family WHERE id_user = p_id_user AND id_family = p_id_family;
	if recordCount> 0 then
        BEGIN
            delete from member_family where id_family=p_id_family and p_id_user=id_user;
        EXCEPTION
		    WHEN others THEN
		        RAISE EXCEPTION 'Failed to delete member: %', SQLERRM;
        END;
    ELSE
        RAISE EXCEPTION 'Invalid family ID or user ID provided';
    END IF;
END;
$$;


ALTER PROCEDURE public.p_delete_member(IN p_id_current_user uuid, IN p_id_user uuid, IN p_id_family integer) OWNER TO postgres;

--
-- TOC entry 550 (class 1255 OID 17622)
-- Name: p_delete_role(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.p_delete_role() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN 

	EXECUTE 'DROP ROLE IF EXISTS ' || OLD.role;

    RETURN OLD;
END;
$$;


ALTER FUNCTION public.p_delete_role() OWNER TO postgres;

--
-- TOC entry 477 (class 1255 OID 17623)
-- Name: p_update_role(uuid, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.p_update_role(p_id_user uuid, p_id_family integer, p_role character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
    error_message varchar;
BEGIN
    BEGIN
        UPDATE member_family
        SET "role" = p_role
        WHERE id_family = p_id_family AND id_user = p_id_user;

        IF NOT FOUND THEN
            error_message := 'Failed to update role for the user.';
        END IF;
    EXCEPTION
        WHEN others THEN
            error_message := 'Failed to update role for the user.';
    END;

    RETURN error_message;
END;
$$;


ALTER FUNCTION public.p_update_role(p_id_user uuid, p_id_family integer, p_role character varying) OWNER TO postgres;

--
-- TOC entry 485 (class 1255 OID 17624)
-- Name: p_validate_otp(character varying, uuid); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.p_validate_otp(IN code character varying, IN id_user uuid)
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM otp WHERE code = code and id_user=id_user) THEN
        UPDATE users
        SET twofa = TRUE
        WHERE id_user = id_user;

        DELETE FROM otp
        WHERE code = code and id_user=id_user ;
    ELSE
        RAISE EXCEPTION 'Invalid OTP code';
    END IF;
END;
$$;


ALTER PROCEDURE public.p_validate_otp(IN code character varying, IN id_user uuid) OWNER TO postgres;

--
-- TOC entry 551 (class 1255 OID 17625)
-- Name: update_category_event(integer, character varying, character varying, integer, uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_category_event(_id_category_event integer, _title character varying, _color character varying, _id_family integer, _id_user uuid) RETURNS TABLE(id_category_event integer, title character varying, color character varying, id_family integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM member_family f WHERE f.id_family = _id_family AND f.id_user = _id_user) THEN
        -- Cập nhật mục và trả về mục vừa cập nhật
        RETURN QUERY
        UPDATE category_event
        SET title = _title, color = _color, updated_at = now()
        WHERE category_event.id_category_event = _id_category_event AND category_event.id_family = _id_family
        RETURNING category_event.id_category_event, category_event.title, category_event.color, category_event.id_family;
    ELSE
        RAISE EXCEPTION 'User does not belong to the specified family';
    END IF;
END;
$$;


ALTER FUNCTION public.update_category_event(_id_category_event integer, _title character varying, _color character varying, _id_family integer, _id_user uuid) OWNER TO postgres;

--
-- TOC entry 552 (class 1255 OID 17626)
-- Name: update_family_quantity(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_family_quantity() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
        UPDATE family SET quantity = (SELECT COUNT(*) FROM member_family WHERE id_family = NEW.id_family) WHERE id_family = NEW.id_family;
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_family_quantity() OWNER TO postgres;

--
-- TOC entry 553 (class 1255 OID 17631)
-- Name: update_invoice_amount(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_invoice_amount() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Cập nhật tổng tiền hóa đơn dựa trên tổng tiền các mặt hàng
    UPDATE invoice
    SET amount = (
        SELECT COALESCE(SUM(total_price), 0) 
        FROM invoice_items 
        WHERE id_invoice = NEW.id_invoice
    )
    WHERE id_invoice = NEW.id_invoice;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_invoice_amount() OWNER TO postgres;

--
-- TOC entry 554 (class 1255 OID 17632)
-- Name: update_invoice_updated_at(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_invoice_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_invoice_updated_at() OWNER TO postgres;

--
-- TOC entry 555 (class 1255 OID 17633)
-- Name: update_key_value(); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.update_key_value()
    LANGUAGE plpgsql
    AS $$
DECLARE
    new_key VARCHAR;
BEGIN
    UPDATE users SET password = decryption(password);

    new_key := generate_key(16);

    UPDATE key SET key = new_key, updated_at = NOW() WHERE id = 1;

    UPDATE users SET password = encryption(password), updated_at = NOW();
END;
$$;


ALTER PROCEDURE public.update_key_value() OWNER TO postgres;

--
-- TOC entry 556 (class 1255 OID 17634)
-- Name: update_modified_column(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_modified_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW; 
END;
$$;


ALTER FUNCTION public.update_modified_column() OWNER TO postgres;

--
-- TOC entry 557 (class 1255 OID 17635)
-- Name: update_role_on_member_family(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_role_on_member_family() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare 
	old_role_name varchar;
	new_role_name varchar;
BEGIN
    SELECT OLD.role_name, NEW.role_name INTO old_role_name, new_role_name;

    IF OLD.role <> NEW.role THEN
        EXECUTE 'REVOKE ALL ON DATABASE famfund_i2wq_a3fq FROM ' || id_user;

        EXECUTE 'GRANT ' || NEW.role || ' TO ' || id_user;

    END IF;
END;
$$;


ALTER FUNCTION public.update_role_on_member_family() OWNER TO postgres;

--
-- TOC entry 558 (class 1255 OID 17636)
-- Name: update_total_amount(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_total_amount() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Tính tổng amount + tax và gán vào total_amount
    NEW.total_amount := NEW.amount + NEW.tax_amount;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_total_amount() OWNER TO postgres;

--
-- TOC entry 559 (class 1255 OID 17637)
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_updated_at_column() OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 17660)
-- Name: calendar_id_calendar_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.calendar_id_calendar_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.calendar_id_calendar_seq OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 17703)
-- Name: discount; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.discount (
    code character varying(255) NOT NULL,
    percentage integer NOT NULL,
    expired_at timestamp with time zone DEFAULT now() NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.discount OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 17709)
-- Name: education_progress_id_education_progress_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.education_progress_id_education_progress_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.education_progress_id_education_progress_seq OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 17710)
-- Name: education_progress; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.education_progress (
    id_education_progress integer DEFAULT nextval('public.education_progress_id_education_progress_seq'::regclass) NOT NULL,
    id_family integer NOT NULL,
    id_user uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    title character varying NOT NULL,
    progress_notes character varying NOT NULL,
    school_info character varying NOT NULL
);


ALTER TABLE public.education_progress OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 17718)
-- Name: education_progress_id_education_progress_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.education_progress_id_education_progress_seq1
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.education_progress_id_education_progress_seq1 OWNER TO postgres;

--
-- TOC entry 4314 (class 0 OID 0)
-- Dependencies: 233
-- Name: education_progress_id_education_progress_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.education_progress_id_education_progress_seq1 OWNED BY public.education_progress.id_education_progress;


--
-- TOC entry 325 (class 1259 OID 24473)
-- Name: famili_invitation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.famili_invitation (
    id_invitation integer NOT NULL,
    id_family integer NOT NULL,
    code character varying(255) NOT NULL
);


ALTER TABLE public.famili_invitation OWNER TO postgres;

--
-- TOC entry 324 (class 1259 OID 24472)
-- Name: famili_invitation_id_invitation_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.famili_invitation_id_invitation_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.famili_invitation_id_invitation_seq OWNER TO postgres;

--
-- TOC entry 4315 (class 0 OID 0)
-- Dependencies: 324
-- Name: famili_invitation_id_invitation_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.famili_invitation_id_invitation_seq OWNED BY public.famili_invitation.id_invitation;


--
-- TOC entry 234 (class 1259 OID 17725)
-- Name: family_extra_packages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.family_extra_packages (
    id_family_extra_package integer NOT NULL,
    id_family integer NOT NULL,
    id_extra_package integer NOT NULL
);


ALTER TABLE public.family_extra_packages OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 17728)
-- Name: family_extra_packages_id_family_extra_package_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.family_extra_packages_id_family_extra_package_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.family_extra_packages_id_family_extra_package_seq OWNER TO postgres;

--
-- TOC entry 4316 (class 0 OID 0)
-- Dependencies: 235
-- Name: family_extra_packages_id_family_extra_package_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.family_extra_packages_id_family_extra_package_seq OWNED BY public.family_extra_packages.id_family_extra_package;


--
-- TOC entry 236 (class 1259 OID 17729)
-- Name: family_id_family_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.family_id_family_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.family_id_family_seq1 OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 17731)
-- Name: family_id_family_seq2; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.family_id_family_seq2
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.family_id_family_seq2 OWNER TO postgres;

--
-- TOC entry 4317 (class 0 OID 0)
-- Dependencies: 237
-- Name: family_id_family_seq2; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.family_id_family_seq2 OWNED BY public.family.id_family;


--
-- TOC entry 238 (class 1259 OID 17732)
-- Name: family_id_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.family_id_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.family_id_sequence OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 17733)
-- Name: family_invitation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.family_invitation (
    id_invitation integer NOT NULL,
    id_family integer,
    code character varying
);


ALTER TABLE public.family_invitation OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 17738)
-- Name: family_invitation_id_invitation_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.family_invitation_id_invitation_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.family_invitation_id_invitation_seq OWNER TO postgres;

--
-- TOC entry 4318 (class 0 OID 0)
-- Dependencies: 240
-- Name: family_invitation_id_invitation_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.family_invitation_id_invitation_seq OWNED BY public.family_invitation.id_invitation;


--
-- TOC entry 241 (class 1259 OID 17739)
-- Name: family_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.family_roles (
    id_family_role integer NOT NULL,
    role_name_vn character varying NOT NULL,
    role_name_en character varying NOT NULL
);


ALTER TABLE public.family_roles OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 17744)
-- Name: family_roles_id_family_role_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.family_roles_id_family_role_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.family_roles_id_family_role_seq OWNER TO postgres;

--
-- TOC entry 4319 (class 0 OID 0)
-- Dependencies: 242
-- Name: family_roles_id_family_role_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.family_roles_id_family_role_seq OWNED BY public.family_roles.id_family_role;


--
-- TOC entry 243 (class 1259 OID 17745)
-- Name: feedback_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.feedback_metadata (
    metadata_key character varying NOT NULL,
    "totalFeedbacks" integer DEFAULT 0 NOT NULL,
    "averageRating" double precision DEFAULT '0'::double precision NOT NULL
);


ALTER TABLE public.feedback_metadata OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 17752)
-- Name: feedbacks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.feedbacks (
    id_feedback integer NOT NULL,
    comment text NOT NULL,
    rating integer NOT NULL,
    id_user uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.feedbacks OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 17759)
-- Name: feedbacks_id_feedback_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.feedbacks_id_feedback_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.feedbacks_id_feedback_seq OWNER TO postgres;

--
-- TOC entry 4320 (class 0 OID 0)
-- Dependencies: 245
-- Name: feedbacks_id_feedback_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.feedbacks_id_feedback_seq OWNED BY public.feedbacks.id_feedback;


--
-- TOC entry 246 (class 1259 OID 17760)
-- Name: finance_assets_asset_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.finance_assets_asset_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.finance_assets_asset_id_seq OWNER TO postgres;

--
-- TOC entry 4321 (class 0 OID 0)
-- Dependencies: 246
-- Name: finance_assets_asset_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.finance_assets_asset_id_seq OWNED BY public.finance_assets.id_asset;


--
-- TOC entry 247 (class 1259 OID 17761)
-- Name: finance_assets_id_asset_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.finance_assets_id_asset_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.finance_assets_id_asset_seq OWNER TO postgres;

--
-- TOC entry 4322 (class 0 OID 0)
-- Dependencies: 247
-- Name: finance_assets_id_asset_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.finance_assets_id_asset_seq OWNED BY public.finance_assets.id_asset;


--
-- TOC entry 248 (class 1259 OID 17762)
-- Name: finance_expenditure; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.finance_expenditure (
    id_expenditure integer NOT NULL,
    id_family integer NOT NULL,
    description text DEFAULT ''::text,
    id_created_by uuid,
    id_expenditure_type integer,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    amount integer DEFAULT 0 NOT NULL,
    image_url text,
    expenditure_date timestamp without time zone DEFAULT now() NOT NULL,
    id_utility integer,
    id_shopping_list integer
);


ALTER TABLE public.finance_expenditure OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 17772)
-- Name: finance_expenditure_expenditure_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.finance_expenditure_expenditure_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.finance_expenditure_expenditure_id_seq OWNER TO postgres;

--
-- TOC entry 4323 (class 0 OID 0)
-- Dependencies: 249
-- Name: finance_expenditure_expenditure_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.finance_expenditure_expenditure_id_seq OWNED BY public.finance_expenditure.id_expenditure;


--
-- TOC entry 250 (class 1259 OID 17773)
-- Name: finance_expenditure_id_expenditure_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.finance_expenditure_id_expenditure_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.finance_expenditure_id_expenditure_seq OWNER TO postgres;

--
-- TOC entry 4324 (class 0 OID 0)
-- Dependencies: 250
-- Name: finance_expenditure_id_expenditure_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.finance_expenditure_id_expenditure_seq OWNED BY public.finance_expenditure.id_expenditure;


--
-- TOC entry 251 (class 1259 OID 17774)
-- Name: finance_expenditure_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.finance_expenditure_type (
    id_family integer NOT NULL,
    id_expenditure_type integer NOT NULL,
    expense_type_name character varying(255) NOT NULL,
    expense_type_name_vn character varying(255)
);


ALTER TABLE public.finance_expenditure_type OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 17777)
-- Name: finance_expenditure_type_id_expenditure_type_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.finance_expenditure_type_id_expenditure_type_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.finance_expenditure_type_id_expenditure_type_seq OWNER TO postgres;

--
-- TOC entry 4325 (class 0 OID 0)
-- Dependencies: 252
-- Name: finance_expenditure_type_id_expenditure_type_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.finance_expenditure_type_id_expenditure_type_seq OWNED BY public.finance_expenditure_type.id_expenditure_type;


--
-- TOC entry 253 (class 1259 OID 17778)
-- Name: finance_income; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.finance_income (
    id_income integer NOT NULL,
    id_family integer NOT NULL,
    id_created_by uuid NOT NULL,
    id_income_source integer NOT NULL,
    description text DEFAULT ''::text,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    amount integer DEFAULT 0 NOT NULL,
    income_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.finance_income OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 17788)
-- Name: finance_income_id_income_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.finance_income_id_income_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.finance_income_id_income_seq OWNER TO postgres;

--
-- TOC entry 4326 (class 0 OID 0)
-- Dependencies: 254
-- Name: finance_income_id_income_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.finance_income_id_income_seq OWNED BY public.finance_income.id_income;


--
-- TOC entry 255 (class 1259 OID 17789)
-- Name: finance_income_income_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.finance_income_income_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.finance_income_income_id_seq OWNER TO postgres;

--
-- TOC entry 4327 (class 0 OID 0)
-- Dependencies: 255
-- Name: finance_income_income_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.finance_income_income_id_seq OWNED BY public.finance_income.id_income;


--
-- TOC entry 256 (class 1259 OID 17790)
-- Name: finance_income_source; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.finance_income_source (
    id_family integer NOT NULL,
    id_income_source integer NOT NULL,
    income_source_name character varying(255) NOT NULL,
    income_source_name_vn character varying(255)
);


ALTER TABLE public.finance_income_source OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 17793)
-- Name: finance_income_source_id_income_source_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.finance_income_source_id_income_source_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.finance_income_source_id_income_source_seq OWNER TO postgres;

--
-- TOC entry 4328 (class 0 OID 0)
-- Dependencies: 257
-- Name: finance_income_source_id_income_source_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.finance_income_source_id_income_source_seq OWNED BY public.finance_income_source.id_income_source;


--
-- TOC entry 258 (class 1259 OID 17794)
-- Name: financial_summary; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.financial_summary (
    id_summary integer NOT NULL,
    id_family integer NOT NULL,
    summary_date date NOT NULL,
    total_income numeric(12,2) DEFAULT 0,
    total_expenditure numeric(12,2) DEFAULT 0,
    daily_balance numeric(12,2) DEFAULT 0,
    weekly_balance numeric(12,2) DEFAULT 0,
    monthly_balance numeric(12,2) DEFAULT 0,
    yearly_balance numeric(12,2) DEFAULT 0,
    current_balance numeric(12,2) DEFAULT 0
);


ALTER TABLE public.financial_summary OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 17804)
-- Name: financial_summary_summary_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.financial_summary_summary_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.financial_summary_summary_id_seq OWNER TO postgres;

--
-- TOC entry 4329 (class 0 OID 0)
-- Dependencies: 259
-- Name: financial_summary_summary_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.financial_summary_summary_id_seq OWNED BY public.financial_summary.id_summary;


--
-- TOC entry 260 (class 1259 OID 17805)
-- Name: flow_watermarks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flow_watermarks (
    slot text NOT NULL,
    watermark text
);


ALTER TABLE public.flow_watermarks OWNER TO postgres;

--
-- TOC entry 327 (class 1259 OID 24700)
-- Name: frequently_question; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.frequently_question (
    id integer NOT NULL,
    question character varying NOT NULL,
    answer character varying NOT NULL,
    answer_vn character varying NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.frequently_question OWNER TO postgres;

--
-- TOC entry 326 (class 1259 OID 24699)
-- Name: frequently_question_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.frequently_question_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.frequently_question_id_seq OWNER TO postgres;

--
-- TOC entry 4330 (class 0 OID 0)
-- Dependencies: 326
-- Name: frequently_question_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.frequently_question_id_seq OWNED BY public.frequently_question.id;


--
-- TOC entry 261 (class 1259 OID 17819)
-- Name: guide_items_id_item_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.guide_items_id_item_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.guide_items_id_item_seq OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 17820)
-- Name: household_consumable_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.household_consumable_items (
    id_household_item integer NOT NULL,
    quantity integer NOT NULL,
    threshold integer NOT NULL,
    expired_date date
);


ALTER TABLE public.household_consumable_items OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 17823)
-- Name: household_durable_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.household_durable_items (
    id_household_item integer NOT NULL,
    condition character varying(255) NOT NULL
);


ALTER TABLE public.household_durable_items OWNER TO postgres;

--
-- TOC entry 264 (class 1259 OID 17826)
-- Name: household_item_categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.household_item_categories (
    id_household_item_category integer NOT NULL,
    category_name character varying(255) NOT NULL
);


ALTER TABLE public.household_item_categories OWNER TO postgres;

--
-- TOC entry 265 (class 1259 OID 17829)
-- Name: household_item_categories_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.household_item_categories_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.household_item_categories_category_id_seq OWNER TO postgres;

--
-- TOC entry 4331 (class 0 OID 0)
-- Dependencies: 265
-- Name: household_item_categories_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.household_item_categories_category_id_seq OWNED BY public.household_item_categories.id_household_item_category;


--
-- TOC entry 266 (class 1259 OID 17830)
-- Name: household_item_categories_id_household_item_category_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.household_item_categories_id_household_item_category_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.household_item_categories_id_household_item_category_seq OWNER TO postgres;

--
-- TOC entry 4332 (class 0 OID 0)
-- Dependencies: 266
-- Name: household_item_categories_id_household_item_category_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.household_item_categories_id_household_item_category_seq OWNED BY public.household_item_categories.id_household_item_category;


--
-- TOC entry 267 (class 1259 OID 17831)
-- Name: household_items_id_household_item_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.household_items_id_household_item_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.household_items_id_household_item_seq OWNER TO postgres;

--
-- TOC entry 4333 (class 0 OID 0)
-- Dependencies: 267
-- Name: household_items_id_household_item_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.household_items_id_household_item_seq OWNED BY public.household_items.id_household_item;


--
-- TOC entry 268 (class 1259 OID 17832)
-- Name: invoice; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invoice (
    id_invoice integer NOT NULL,
    id_family integer NOT NULL,
    id_invoice_type integer NOT NULL,
    invoice_date date NOT NULL,
    total_amount numeric(10,2) NOT NULL,
    description character varying(255),
    imageurl text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    invoice_name character varying(255) NOT NULL,
    tax_amount numeric(10,2) DEFAULT 0,
    amount numeric(10,2) DEFAULT 0
);


ALTER TABLE public.invoice OWNER TO postgres;

--
-- TOC entry 269 (class 1259 OID 17841)
-- Name: invoice_id_invoice_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.invoice_id_invoice_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.invoice_id_invoice_seq OWNER TO postgres;

--
-- TOC entry 4334 (class 0 OID 0)
-- Dependencies: 269
-- Name: invoice_id_invoice_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.invoice_id_invoice_seq OWNED BY public.invoice.id_invoice;


--
-- TOC entry 270 (class 1259 OID 17842)
-- Name: invoice_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invoice_items (
    id_item integer NOT NULL,
    id_invoice integer NOT NULL,
    item_description character varying(255) NOT NULL,
    quantity integer NOT NULL,
    unit_price numeric(10,2) NOT NULL,
    total_price numeric(10,2) GENERATED ALWAYS AS (((quantity)::numeric * unit_price)) STORED,
    item_name character varying(255) NOT NULL
);


ALTER TABLE public.invoice_items OWNER TO postgres;

--
-- TOC entry 271 (class 1259 OID 17848)
-- Name: invoice_items_id_item_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.invoice_items_id_item_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.invoice_items_id_item_seq OWNER TO postgres;

--
-- TOC entry 4335 (class 0 OID 0)
-- Dependencies: 271
-- Name: invoice_items_id_item_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.invoice_items_id_item_seq OWNED BY public.invoice_items.id_item;


--
-- TOC entry 272 (class 1259 OID 17849)
-- Name: invoice_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invoice_type (
    id_invoice_type integer NOT NULL,
    type_name character varying(50) NOT NULL,
    id_family integer NOT NULL
);


ALTER TABLE public.invoice_type OWNER TO postgres;

--
-- TOC entry 273 (class 1259 OID 17852)
-- Name: invoice_type_id_invoice_type_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.invoice_type_id_invoice_type_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.invoice_type_id_invoice_type_seq OWNER TO postgres;

--
-- TOC entry 4336 (class 0 OID 0)
-- Dependencies: 273
-- Name: invoice_type_id_invoice_type_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.invoice_type_id_invoice_type_seq OWNED BY public.invoice_type.id_invoice_type;


--
-- TOC entry 274 (class 1259 OID 17858)
-- Name: key_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.key_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.key_id_seq OWNER TO postgres;

--
-- TOC entry 275 (class 1259 OID 17859)
-- Name: key_id_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.key_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.key_id_seq1 OWNER TO postgres;

--
-- TOC entry 276 (class 1259 OID 17860)
-- Name: member_family_id_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.member_family_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.member_family_id_seq1 OWNER TO postgres;

--
-- TOC entry 277 (class 1259 OID 17861)
-- Name: member_family_id_seq2; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.member_family_id_seq2
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.member_family_id_seq2 OWNER TO postgres;

--
-- TOC entry 4337 (class 0 OID 0)
-- Dependencies: 277
-- Name: member_family_id_seq2; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.member_family_id_seq2 OWNED BY public.member_family.id;


--
-- TOC entry 278 (class 1259 OID 17862)
-- Name: notification_id_notification_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notification_id_notification_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.notification_id_notification_seq OWNER TO postgres;

--
-- TOC entry 279 (class 1259 OID 17863)
-- Name: order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."order" (
    id_family integer,
    status public.order_status_enum DEFAULT 'PENDING'::public.order_status_enum NOT NULL,
    id_package_main integer,
    id_package_extra integer,
    id_package_combo integer,
    method character varying DEFAULT 'VNPAY'::character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    id_order uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    id_user uuid NOT NULL,
    price numeric NOT NULL,
    bank_code character varying
);


ALTER TABLE public."order" OWNER TO postgres;

--
-- TOC entry 280 (class 1259 OID 17873)
-- Name: order_family_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_family_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.order_family_id_seq OWNER TO postgres;

--
-- TOC entry 281 (class 1259 OID 17874)
-- Name: order_id_order_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_id_order_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.order_id_order_seq OWNER TO postgres;

--
-- TOC entry 282 (class 1259 OID 17875)
-- Name: order_id_order_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_id_order_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.order_id_order_seq1 OWNER TO postgres;

--
-- TOC entry 284 (class 1259 OID 17884)
-- Name: otp_id_otp_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.otp_id_otp_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.otp_id_otp_seq OWNER TO postgres;

--
-- TOC entry 283 (class 1259 OID 17876)
-- Name: otp; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.otp (
    id_otp integer DEFAULT nextval('public.otp_id_otp_seq'::regclass) NOT NULL,
    id_user uuid NOT NULL,
    code character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    expired_at timestamp without time zone,
    email character varying,
    phone character varying,
    type public.otp_type_enum
);


ALTER TABLE public.otp OWNER TO postgres;

--
-- TOC entry 285 (class 1259 OID 17885)
-- Name: otp_otp_id_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.otp_otp_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.otp_otp_id_seq1 OWNER TO postgres;

--
-- TOC entry 286 (class 1259 OID 17886)
-- Name: otp_otp_id_seq2; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.otp_otp_id_seq2
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.otp_otp_id_seq2 OWNER TO postgres;

--
-- TOC entry 4338 (class 0 OID 0)
-- Dependencies: 286
-- Name: otp_otp_id_seq2; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.otp_otp_id_seq2 OWNED BY public.otp.id_otp;


--
-- TOC entry 287 (class 1259 OID 17887)
-- Name: package_combo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.package_combo (
    id_combo_package integer NOT NULL,
    name character varying NOT NULL,
    description character varying,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    price integer DEFAULT 500000 NOT NULL,
    name_vn character varying DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.package_combo OWNER TO postgres;

--
-- TOC entry 288 (class 1259 OID 17896)
-- Name: package_combo_id_combo_package_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.package_combo_id_combo_package_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.package_combo_id_combo_package_seq OWNER TO postgres;

--
-- TOC entry 4339 (class 0 OID 0)
-- Dependencies: 288
-- Name: package_combo_id_combo_package_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.package_combo_id_combo_package_seq OWNED BY public.package_combo.id_combo_package;


--
-- TOC entry 289 (class 1259 OID 17897)
-- Name: package_combo_package_extra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.package_combo_package_extra (
    package_combo_id integer NOT NULL,
    package_extra_id integer NOT NULL
);


ALTER TABLE public.package_combo_package_extra OWNER TO postgres;

--
-- TOC entry 290 (class 1259 OID 17900)
-- Name: package_extra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.package_extra (
    id_extra_package integer NOT NULL,
    name character varying NOT NULL,
    description character varying,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    price integer DEFAULT 500000 NOT NULL,
    name_vn character varying DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.package_extra OWNER TO postgres;

--
-- TOC entry 291 (class 1259 OID 17909)
-- Name: package_extra_id_extra_package_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.package_extra_id_extra_package_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.package_extra_id_extra_package_seq OWNER TO postgres;

--
-- TOC entry 4340 (class 0 OID 0)
-- Dependencies: 291
-- Name: package_extra_id_extra_package_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.package_extra_id_extra_package_seq OWNED BY public.package_extra.id_extra_package;


--
-- TOC entry 292 (class 1259 OID 17910)
-- Name: package_main; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.package_main (
    id_main_package integer NOT NULL,
    name character varying NOT NULL,
    description character varying,
    is_active boolean DEFAULT true NOT NULL,
    duration_months integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    price integer DEFAULT 500000 NOT NULL,
    name_vn character varying DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.package_main OWNER TO postgres;

--
-- TOC entry 293 (class 1259 OID 17919)
-- Name: package_main_id_main_package_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.package_main_id_main_package_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.package_main_id_main_package_seq OWNER TO postgres;

--
-- TOC entry 4341 (class 0 OID 0)
-- Dependencies: 293
-- Name: package_main_id_main_package_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.package_main_id_main_package_seq OWNED BY public.package_main.id_main_package;


--
-- TOC entry 294 (class 1259 OID 17920)
-- Name: payment_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment_history (
    id_payment_history integer NOT NULL,
    payment_method character varying DEFAULT 'vnpay'::character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    id_user uuid NOT NULL,
    type character varying NOT NULL,
    amount integer NOT NULL,
    id_order uuid NOT NULL
);


ALTER TABLE public.payment_history OWNER TO postgres;

--
-- TOC entry 295 (class 1259 OID 17927)
-- Name: payment_history_id_payment_history_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payment_history_id_payment_history_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payment_history_id_payment_history_seq OWNER TO postgres;

--
-- TOC entry 4342 (class 0 OID 0)
-- Dependencies: 295
-- Name: payment_history_id_payment_history_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payment_history_id_payment_history_seq OWNED BY public.payment_history.id_payment_history;


--
-- TOC entry 296 (class 1259 OID 17928)
-- Name: payment_method; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payment_method (
    id integer NOT NULL,
    name character varying NOT NULL,
    code character varying NOT NULL,
    url_image character varying
);


ALTER TABLE public.payment_method OWNER TO postgres;

--
-- TOC entry 297 (class 1259 OID 17933)
-- Name: payment_method_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payment_method_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.payment_method_id_seq OWNER TO postgres;

--
-- TOC entry 298 (class 1259 OID 17934)
-- Name: payment_method_id_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payment_method_id_seq1
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payment_method_id_seq1 OWNER TO postgres;

--
-- TOC entry 4343 (class 0 OID 0)
-- Dependencies: 298
-- Name: payment_method_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payment_method_id_seq1 OWNED BY public.payment_method.id;


--
-- TOC entry 299 (class 1259 OID 17935)
-- Name: refresh_token_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.refresh_token_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.refresh_token_id_seq OWNER TO postgres;

--
-- TOC entry 300 (class 1259 OID 17936)
-- Name: refresh_token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.refresh_token (
    refresh_token character varying NOT NULL,
    id_user uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    expired_at timestamp without time zone NOT NULL,
    id integer DEFAULT nextval('public.refresh_token_id_seq'::regclass) NOT NULL
);


ALTER TABLE public.refresh_token OWNER TO postgres;

--
-- TOC entry 301 (class 1259 OID 17943)
-- Name: refresh_token_id_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.refresh_token_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.refresh_token_id_seq1 OWNER TO postgres;

--
-- TOC entry 302 (class 1259 OID 17944)
-- Name: refresh_token_id_seq2; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.refresh_token_id_seq2
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.refresh_token_id_seq2 OWNER TO postgres;

--
-- TOC entry 4344 (class 0 OID 0)
-- Dependencies: 302
-- Name: refresh_token_id_seq2; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.refresh_token_id_seq2 OWNED BY public.refresh_token.id;


--
-- TOC entry 303 (class 1259 OID 17945)
-- Name: room; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.room (
    id_room integer NOT NULL,
    id_family integer NOT NULL,
    room_name character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    room_image character varying
);


ALTER TABLE public.room OWNER TO postgres;

--
-- TOC entry 304 (class 1259 OID 17952)
-- Name: room_id_room_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.room_id_room_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.room_id_room_seq OWNER TO postgres;

--
-- TOC entry 4345 (class 0 OID 0)
-- Dependencies: 304
-- Name: room_id_room_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.room_id_room_seq OWNED BY public.room.id_room;


--
-- TOC entry 305 (class 1259 OID 17953)
-- Name: shopping_item_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shopping_item_types (
    id_item_type integer NOT NULL,
    item_type_name_en character varying(255) NOT NULL,
    item_type_name_vn character varying(255) NOT NULL,
    icon_url text
);


ALTER TABLE public.shopping_item_types OWNER TO postgres;

--
-- TOC entry 306 (class 1259 OID 17958)
-- Name: shopping_item_types_id_item_type_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.shopping_item_types_id_item_type_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shopping_item_types_id_item_type_seq OWNER TO postgres;

--
-- TOC entry 4346 (class 0 OID 0)
-- Dependencies: 306
-- Name: shopping_item_types_id_item_type_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.shopping_item_types_id_item_type_seq OWNED BY public.shopping_item_types.id_item_type;


--
-- TOC entry 307 (class 1259 OID 17959)
-- Name: shopping_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shopping_items (
    id_item integer NOT NULL,
    id_list integer NOT NULL,
    id_item_type integer NOT NULL,
    item_name character varying(255) NOT NULL,
    description character varying,
    quantity integer DEFAULT 1 NOT NULL,
    is_purchased boolean DEFAULT false NOT NULL,
    priority_level integer DEFAULT 1 NOT NULL,
    reminder_date timestamp without time zone DEFAULT '2024-08-02 01:02:43.979'::timestamp without time zone,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    price integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.shopping_items OWNER TO postgres;

--
-- TOC entry 308 (class 1259 OID 17971)
-- Name: shopping_items_id_item_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.shopping_items_id_item_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shopping_items_id_item_seq OWNER TO postgres;

--
-- TOC entry 4347 (class 0 OID 0)
-- Dependencies: 308
-- Name: shopping_items_id_item_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.shopping_items_id_item_seq OWNED BY public.shopping_items.id_item;


--
-- TOC entry 309 (class 1259 OID 17972)
-- Name: shopping_list_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shopping_list_types (
    id_shopping_list_type integer NOT NULL,
    type_name_en character varying(255) NOT NULL,
    type_name_vn character varying(255) NOT NULL,
    icon_url text
);


ALTER TABLE public.shopping_list_types OWNER TO postgres;

--
-- TOC entry 310 (class 1259 OID 17977)
-- Name: shopping_list_types_id_shopping_list_type_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.shopping_list_types_id_shopping_list_type_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shopping_list_types_id_shopping_list_type_seq OWNER TO postgres;

--
-- TOC entry 4348 (class 0 OID 0)
-- Dependencies: 310
-- Name: shopping_list_types_id_shopping_list_type_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.shopping_list_types_id_shopping_list_type_seq OWNED BY public.shopping_list_types.id_shopping_list_type;


--
-- TOC entry 311 (class 1259 OID 17978)
-- Name: shopping_lists; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shopping_lists (
    id_list integer NOT NULL,
    id_family integer NOT NULL,
    title character varying(255) NOT NULL,
    description character varying,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    id_shopping_list_type integer NOT NULL,
    status public.shopping_lists_status_enum DEFAULT 'IN_PROGRESS'::public.shopping_lists_status_enum NOT NULL,
    id_expenditure integer
);


ALTER TABLE public.shopping_lists OWNER TO postgres;

--
-- TOC entry 312 (class 1259 OID 17986)
-- Name: shopping_lists_id_list_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.shopping_lists_id_list_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shopping_lists_id_list_seq OWNER TO postgres;

--
-- TOC entry 4349 (class 0 OID 0)
-- Dependencies: 312
-- Name: shopping_lists_id_list_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.shopping_lists_id_list_seq OWNED BY public.shopping_lists.id_list;


--
-- TOC entry 313 (class 1259 OID 17987)
-- Name: subject; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subject (
    id_subject integer NOT NULL,
    id_education_progress integer NOT NULL,
    subject_name character varying NOT NULL,
    description character varying,
    component_scores json,
    status character varying DEFAULT 'in_progress'::character varying,
    midterm_score double precision,
    final_score double precision,
    bonus_score double precision
);


ALTER TABLE public.subject OWNER TO postgres;

--
-- TOC entry 314 (class 1259 OID 17993)
-- Name: subject_id_subject_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subject_id_subject_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subject_id_subject_seq OWNER TO postgres;

--
-- TOC entry 4350 (class 0 OID 0)
-- Dependencies: 314
-- Name: subject_id_subject_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subject_id_subject_seq OWNED BY public.subject.id_subject;


--
-- TOC entry 315 (class 1259 OID 17994)
-- Name: subjects_id_subject_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subjects_id_subject_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.subjects_id_subject_seq OWNER TO postgres;

--
-- TOC entry 316 (class 1259 OID 17995)
-- Name: user_info_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.user_info_view AS
 SELECT users.email,
    users.phone,
    users.language,
    users.firstname,
    users.lastname
   FROM public.users;


ALTER TABLE public.user_info_view OWNER TO postgres;

--
-- TOC entry 317 (class 1259 OID 17999)
-- Name: utilities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.utilities (
    id_utility integer NOT NULL,
    id_family integer NOT NULL,
    id_utilities_type integer NOT NULL,
    description character varying DEFAULT ''::character varying,
    image_url text,
    value integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    id_expenditure integer
);


ALTER TABLE public.utilities OWNER TO postgres;

--
-- TOC entry 318 (class 1259 OID 18008)
-- Name: utilities_id_utility_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.utilities_id_utility_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.utilities_id_utility_seq OWNER TO postgres;

--
-- TOC entry 4351 (class 0 OID 0)
-- Dependencies: 318
-- Name: utilities_id_utility_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.utilities_id_utility_seq OWNED BY public.utilities.id_utility;


--
-- TOC entry 319 (class 1259 OID 18009)
-- Name: utilities_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.utilities_type (
    id_utilities_type integer NOT NULL,
    name_en character varying(255) NOT NULL,
    name_vn character varying(255) NOT NULL
);


ALTER TABLE public.utilities_type OWNER TO postgres;

--
-- TOC entry 320 (class 1259 OID 18014)
-- Name: utilities_type_id_utilities_type_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.utilities_type_id_utilities_type_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.utilities_type_id_utilities_type_seq OWNER TO postgres;

--
-- TOC entry 4352 (class 0 OID 0)
-- Dependencies: 320
-- Name: utilities_type_id_utilities_type_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.utilities_type_id_utilities_type_seq OWNED BY public.utilities_type.id_utilities_type;


--
-- TOC entry 321 (class 1259 OID 18015)
-- Name: v_user_id; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.v_user_id (
    id_user uuid
);


ALTER TABLE public.v_user_id OWNER TO postgres;

--
-- TOC entry 322 (class 1259 OID 18018)
-- Name: view_all_users_details; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_all_users_details AS
 SELECT users.id_user,
    users.email,
    users.phone,
    users.language,
    users.twofa,
    users.created_at,
    users.updated_at,
    users.isphoneverified,
    users.firstname,
    users.lastname,
    users.isemailverified,
    users.avatar,
    users.login_type
   FROM public.users;


ALTER TABLE public.view_all_users_details OWNER TO postgres;

--
-- TOC entry 323 (class 1259 OID 18022)
-- Name: view_users; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_users AS
 SELECT users.id_user,
    users.email,
    users.phone,
    users.language,
    users.firstname,
    users.lastname,
    users.avatar
   FROM public.users;


ALTER TABLE public.view_users OWNER TO postgres;

--
-- TOC entry 3849 (class 2604 OID 24476)
-- Name: famili_invitation id_invitation; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.famili_invitation ALTER COLUMN id_invitation SET DEFAULT nextval('public.famili_invitation_id_invitation_seq'::regclass);


--
-- TOC entry 3753 (class 2604 OID 18032)
-- Name: family_extra_packages id_family_extra_package; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family_extra_packages ALTER COLUMN id_family_extra_package SET DEFAULT nextval('public.family_extra_packages_id_family_extra_package_seq'::regclass);


--
-- TOC entry 3754 (class 2604 OID 18033)
-- Name: family_invitation id_invitation; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family_invitation ALTER COLUMN id_invitation SET DEFAULT nextval('public.family_invitation_id_invitation_seq'::regclass);


--
-- TOC entry 3755 (class 2604 OID 18034)
-- Name: family_roles id_family_role; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family_roles ALTER COLUMN id_family_role SET DEFAULT nextval('public.family_roles_id_family_role_seq'::regclass);


--
-- TOC entry 3758 (class 2604 OID 18035)
-- Name: feedbacks id_feedback; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedbacks ALTER COLUMN id_feedback SET DEFAULT nextval('public.feedbacks_id_feedback_seq'::regclass);


--
-- TOC entry 3733 (class 2604 OID 18036)
-- Name: finance_assets id_asset; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.finance_assets ALTER COLUMN id_asset SET DEFAULT nextval('public.finance_assets_id_asset_seq'::regclass);


--
-- TOC entry 3761 (class 2604 OID 18037)
-- Name: finance_expenditure id_expenditure; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.finance_expenditure ALTER COLUMN id_expenditure SET DEFAULT nextval('public.finance_expenditure_id_expenditure_seq'::regclass);


--
-- TOC entry 3767 (class 2604 OID 18038)
-- Name: finance_expenditure_type id_expenditure_type; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.finance_expenditure_type ALTER COLUMN id_expenditure_type SET DEFAULT nextval('public.finance_expenditure_type_id_expenditure_type_seq'::regclass);


--
-- TOC entry 3768 (class 2604 OID 18039)
-- Name: finance_income id_income; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.finance_income ALTER COLUMN id_income SET DEFAULT nextval('public.finance_income_id_income_seq'::regclass);


--
-- TOC entry 3774 (class 2604 OID 18040)
-- Name: finance_income_source id_income_source; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.finance_income_source ALTER COLUMN id_income_source SET DEFAULT nextval('public.finance_income_source_id_income_source_seq'::regclass);


--
-- TOC entry 3775 (class 2604 OID 18041)
-- Name: financial_summary id_summary; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.financial_summary ALTER COLUMN id_summary SET DEFAULT nextval('public.financial_summary_summary_id_seq'::regclass);


--
-- TOC entry 3850 (class 2604 OID 24703)
-- Name: frequently_question id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.frequently_question ALTER COLUMN id SET DEFAULT nextval('public.frequently_question_id_seq'::regclass);


--
-- TOC entry 3783 (class 2604 OID 18043)
-- Name: household_item_categories id_household_item_category; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.household_item_categories ALTER COLUMN id_household_item_category SET DEFAULT nextval('public.household_item_categories_id_household_item_category_seq'::regclass);


--
-- TOC entry 3744 (class 2604 OID 18044)
-- Name: household_items id_household_item; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.household_items ALTER COLUMN id_household_item SET DEFAULT nextval('public.household_items_id_household_item_seq'::regclass);


--
-- TOC entry 3784 (class 2604 OID 18045)
-- Name: invoice id_invoice; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice ALTER COLUMN id_invoice SET DEFAULT nextval('public.invoice_id_invoice_seq'::regclass);


--
-- TOC entry 3789 (class 2604 OID 18046)
-- Name: invoice_items id_item; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_items ALTER COLUMN id_item SET DEFAULT nextval('public.invoice_items_id_item_seq'::regclass);


--
-- TOC entry 3791 (class 2604 OID 18047)
-- Name: invoice_type id_invoice_type; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_type ALTER COLUMN id_invoice_type SET DEFAULT nextval('public.invoice_type_id_invoice_type_seq'::regclass);


--
-- TOC entry 3800 (class 2604 OID 18049)
-- Name: package_combo id_combo_package; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.package_combo ALTER COLUMN id_combo_package SET DEFAULT nextval('public.package_combo_id_combo_package_seq'::regclass);


--
-- TOC entry 3806 (class 2604 OID 18050)
-- Name: package_extra id_extra_package; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.package_extra ALTER COLUMN id_extra_package SET DEFAULT nextval('public.package_extra_id_extra_package_seq'::regclass);


--
-- TOC entry 3812 (class 2604 OID 18051)
-- Name: package_main id_main_package; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.package_main ALTER COLUMN id_main_package SET DEFAULT nextval('public.package_main_id_main_package_seq'::regclass);


--
-- TOC entry 3818 (class 2604 OID 18052)
-- Name: payment_history id_payment_history; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_history ALTER COLUMN id_payment_history SET DEFAULT nextval('public.payment_history_id_payment_history_seq'::regclass);


--
-- TOC entry 3821 (class 2604 OID 18053)
-- Name: payment_method id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_method ALTER COLUMN id SET DEFAULT nextval('public.payment_method_id_seq1'::regclass);


--
-- TOC entry 3824 (class 2604 OID 18054)
-- Name: room id_room; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room ALTER COLUMN id_room SET DEFAULT nextval('public.room_id_room_seq'::regclass);


--
-- TOC entry 3827 (class 2604 OID 18055)
-- Name: shopping_item_types id_item_type; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shopping_item_types ALTER COLUMN id_item_type SET DEFAULT nextval('public.shopping_item_types_id_item_type_seq'::regclass);


--
-- TOC entry 3828 (class 2604 OID 18056)
-- Name: shopping_items id_item; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shopping_items ALTER COLUMN id_item SET DEFAULT nextval('public.shopping_items_id_item_seq'::regclass);


--
-- TOC entry 3836 (class 2604 OID 18057)
-- Name: shopping_list_types id_shopping_list_type; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shopping_list_types ALTER COLUMN id_shopping_list_type SET DEFAULT nextval('public.shopping_list_types_id_shopping_list_type_seq'::regclass);


--
-- TOC entry 3837 (class 2604 OID 18058)
-- Name: shopping_lists id_list; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shopping_lists ALTER COLUMN id_list SET DEFAULT nextval('public.shopping_lists_id_list_seq'::regclass);


--
-- TOC entry 3841 (class 2604 OID 18059)
-- Name: subject id_subject; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subject ALTER COLUMN id_subject SET DEFAULT nextval('public.subject_id_subject_seq'::regclass);


--
-- TOC entry 3843 (class 2604 OID 18060)
-- Name: utilities id_utility; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilities ALTER COLUMN id_utility SET DEFAULT nextval('public.utilities_id_utility_seq'::regclass);


--
-- TOC entry 3848 (class 2604 OID 18061)
-- Name: utilities_type id_utilities_type; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilities_type ALTER COLUMN id_utilities_type SET DEFAULT nextval('public.utilities_type_id_utilities_type_seq'::regclass);


--
-- TOC entry 4212 (class 0 OID 17703)
-- Dependencies: 230
-- Data for Name: discount; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.discount (code, percentage, expired_at, created_at, updated_at) FROM stdin;
KHAITRUONGBATNGO	15	2024-07-20 19:07:34+00	2024-07-20 19:07:34	2024-07-20 19:07:34
MUNGKHAITRUONG	22	2024-07-22 00:00:00+00	2024-07-20 19:07:34.000443	2024-07-20 19:46:30.440004
KHAITRUONGNE	23	2024-07-03 00:00:00+00	2024-07-20 19:44:47.151249	2024-07-20 19:48:18.20018
SUMMER2024	10	2024-08-21 16:41:36.33832+00	2024-07-22 16:41:36.33832	2024-07-22 16:41:36.33832
BACKTOSCHOOL	15	2024-09-05 16:41:36.33832+00	2024-07-22 16:41:36.33832	2024-07-22 16:41:36.33832
HOLIDAYSALE	20	2024-09-20 16:41:36.33832+00	2024-07-22 16:41:36.33832	2024-07-22 16:41:36.33832
BLACKFRIDAY	25	2024-08-21 16:41:36.33832+00	2024-07-22 16:41:36.33832	2024-07-22 16:41:36.33832
WINTER2024	5	2024-08-06 16:41:36.33832+00	2024-07-22 16:41:36.33832	2024-07-22 16:41:36.33832
NEWYEAR2024	30	2024-09-05 16:41:36.33832+00	2024-07-22 16:41:36.33832	2024-07-22 16:41:36.33832
SPRING2024	10	2024-09-20 16:41:36.33832+00	2024-07-22 16:41:36.33832	2024-07-22 16:41:36.33832
FALLSALE2024	20	2024-08-21 16:41:36.33832+00	2024-07-22 16:41:36.33832	2024-07-22 16:41:36.33832
CYBERMONDAY	25	2024-09-05 16:41:36.33832+00	2024-07-22 16:41:36.33832	2024-07-22 16:41:36.33832
EASTER2024	30	2024-09-20 16:41:36.33832+00	2024-07-22 16:41:36.33832	2024-07-22 16:41:36.33832
\.


--
-- TOC entry 4214 (class 0 OID 17710)
-- Dependencies: 232
-- Data for Name: education_progress; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.education_progress (id_education_progress, id_family, id_user, created_at, updated_at, title, progress_notes, school_info) FROM stdin;
6	96	28905675-858b-4a93-a283-205899779622	2024-06-20 12:37:24.144368	2024-06-20 12:37:24.144368	Đại học năm 3	Đại học năm 3 - HKII	Đại học Khoa học Tự Nhiên
1	96	bd94ba3a-b046-4a05-a260-890913e09df9	2024-06-19 17:57:02.288148	2024-06-22 06:53:18.254636	stringgg	testtttt	testtttt
4	96	bd94ba3a-b046-4a05-a260-890913e09df9	2024-06-20 11:33:30.329205	2024-07-07 10:29:24.048596	Figma Update	75	Truong doi
47	96	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-08 23:54:42.151682	2024-07-08 23:54:42.151682	Giang Test Education	De lam UI	Truong Doi
11	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	2024-06-26 11:27:43.550275	2024-07-16 22:03:49.358662	Math 17	K	Hcmus
48	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	2024-07-17 10:07:57.567033	2024-07-17 10:07:57.567033	College	Year 4	Hcmus
50	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	2024-07-19 16:37:25.438797	2024-07-19 16:37:25.438797	Vật lý cao cấp	không biết viết gì	Bách Khoa HCM
10	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	2024-06-22 07:24:49.439447	2024-07-21 17:18:03.424072	ABC BAC	GVHT: TEST TEACHER	HcmusSSS
85	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	2024-07-22 16:44:34.540149	2024-07-22 16:44:34.540149	High School Year 1	Doing well in most subjects	Springfield High School
86	96	28905675-858b-4a93-a283-205899779622	2024-07-22 16:44:34.540149	2024-07-22 16:44:34.540149	High School Year 2	Struggling with math	Springfield High School
87	96	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-22 16:44:34.540149	2024-07-22 16:44:34.540149	High School Year 3	Excellent in sciences	Springfield High School
88	96	101627d7-019e-4a58-b8c0-b30806db3780	2024-07-22 16:44:34.540149	2024-07-22 16:44:34.540149	High School Year 4	Preparing for college	Springfield High School
89	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	2024-07-22 16:44:34.540149	2024-07-22 16:44:34.540149	Middle School Year 1	Good performance overall	Springfield Middle School
90	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	2024-07-22 16:44:34.540149	2024-07-22 16:44:34.540149	Middle School Year 2	Needs improvement in history	Springfield Middle School
91	96	28905675-858b-4a93-a283-205899779622	2024-07-22 16:44:34.540149	2024-07-22 16:44:34.540149	Middle School Year 3	Showing progress in mathematics	Springfield Middle School
92	96	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-22 16:44:34.540149	2024-07-22 16:44:34.540149	Middle School Year 4	Preparing for high school	Springfield Middle School
93	96	101627d7-019e-4a58-b8c0-b30806db3780	2024-07-22 16:44:34.540149	2024-07-22 16:44:34.540149	Elementary Year 1	Enjoys art and music	Springfield Elementary
94	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	2024-07-22 16:44:34.540149	2024-07-22 16:44:34.540149	Elementary Year 2	Very good in reading	Springfield Elementary
95	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	2024-07-29 15:53:08.844997	2024-07-29 15:53:08.844997	Oo	Oooo	Ooo
97	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	2024-07-29 20:09:05.237477	2024-07-29 20:09:05.237477	U	U	U
96	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	2024-07-29 20:08:39.460852	2024-07-29 20:10:37.603522	Uu	U	U
98	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	2024-07-30 09:55:39.911097	2024-07-30 09:55:39.911097	Năm 3	Noted	Đại học khtn
99	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	2024-07-30 10:01:26.768664	2024-07-30 10:01:26.768664	Năm 1	Noted	Đại học KHTN
100	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	2024-08-01 19:07:06.828215	2024-08-01 19:07:06.828215	Năm 2	Noted	Đại học KHTN
101	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	2024-08-01 19:12:28.342828	2024-08-01 19:12:28.342828	Năm cuối	Note	Đại học KHTN
\.


--
-- TOC entry 4304 (class 0 OID 24473)
-- Dependencies: 325
-- Data for Name: famili_invitation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.famili_invitation (id_invitation, id_family, code) FROM stdin;
\.


--
-- TOC entry 4209 (class 0 OID 17506)
-- Dependencies: 227
-- Data for Name: family; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.family (id_family, quantity, description, created_at, updated_at, name, avatar, owner_id, expired_at) FROM stdin;
98	0	Nước tương	2024-03-29 17:57:42.572	2024-06-26 14:09:59.263808	bún đậu	https://storage.googleapis.com/famfund-bucket/avatar/avatar_family_bd94ba3a-b046-4a05-a260-890913e09df9_1719410995934_C8A1B3A5-8794-4850-B427-9BB30460DBB6.jpg	bd94ba3a-b046-4a05-a260-890913e09df9	2024-09-28 16:52:34.578085+00
99	0	shin eee	2024-04-03 12:41:26.158	2024-07-01 17:16:43.570059	gia dinh la so 0	https://storage.googleapis.com/famfund-bucket/avatar/avatar_family_bd94ba3a-b046-4a05-a260-890913e09df9_1719854202847_45892102-8AC9-402E-A909-3FA0A5137C56.jpg	bd94ba3a-b046-4a05-a260-890913e09df9	2024-06-28 16:52:34.578085+00
2	0		2024-06-30 09:10:52.541729	2024-06-30 09:51:18.655998	New Family	\N	bd94ba3a-b046-4a05-a260-890913e09df9	2025-06-30 09:10:52.444+00
97	1	BlackPink Group 7	2024-03-28 11:01:24.214	2024-07-29 00:36:42.827712	blackpunk1	https://storage.googleapis.com/famfund-bucket/avatar/avatar_family_bd94ba3a-b046-4a05-a260-890913e09df9_1722213402515_channels4_profile.jpg	bd94ba3a-b046-4a05-a260-890913e09df9	2024-09-28 16:52:34.578085+00
96	3	Famfund in your area	2024-03-27 09:20:26.437	2024-08-02 00:57:15.404719	Famfund	https://storage.googleapis.com/famfund-bucket/avatar/avatar_family_bd94ba3a-b046-4a05-a260-890913e09df9_1722560206287_4FC72F1C-AA09-47FF-905D-6EE476EF0DE3.jpg	bd94ba3a-b046-4a05-a260-890913e09df9	2025-06-28 16:52:34.578+00
117	1		2024-08-01 17:11:23.447333	2024-08-01 17:11:23.447333	New Family	\N	bd94ba3a-b046-4a05-a260-890913e09df9	2024-11-01 17:11:23.256+00
\.


--
-- TOC entry 4216 (class 0 OID 17725)
-- Dependencies: 234
-- Data for Name: family_extra_packages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.family_extra_packages (id_family_extra_package, id_family, id_extra_package) FROM stdin;
1	97	1
2	97	2
3	97	3
5	97	5
8	96	1
9	96	2
10	96	3
11	96	4
12	96	5
14	96	7
22	2	2
23	2	3
24	2	4
25	2	5
26	2	1
27	97	4
30	117	4
\.


--
-- TOC entry 4221 (class 0 OID 17733)
-- Dependencies: 239
-- Data for Name: family_invitation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.family_invitation (id_invitation, id_family, code) FROM stdin;
2	97	360084e9-2fcd-4956-ae66-ab3f8a8334f4
3	\N	5359087a-5677-453a-b632-79137dc0af07
4	\N	74c13183-b5de-443d-b9dd-711652f05f8b
5	\N	f7602c35-d6c5-4abe-b11f-ff3fce4dab81
6	\N	d8ab1676-a55b-4272-8de6-cb6a3d4a0f8d
7	\N	9bab1265-148d-4152-bc8d-9447601fac54
8	\N	54b27629-1d99-4974-adfe-6dc2b5a4db75
9	\N	ddba321d-1520-472b-8c49-75fa197668ca
10	\N	0507456d-6e92-4896-9d2c-e6cd58276a9f
1	96	5a105793-6a1e-4552-a6e0-d23ec8312bfc
\.


--
-- TOC entry 4223 (class 0 OID 17739)
-- Dependencies: 241
-- Data for Name: family_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.family_roles (id_family_role, role_name_vn, role_name_en) FROM stdin;
1	Chưa biết	Unknown
2	Cha	Father
3	Mẹ	Mother
4	Con trai	Son
5	Con gái	Daughter
6	Ông nội	Paternal Grandfather
7	Bà nội	Paternal Grandmother
8	Ông ngoại	Maternal Grandfather
9	Bà ngoại	Maternal Grandmother
10	Cố nội	Paternal Great-Grandfather
11	Cụ nội	Paternal Great-Grandmother
12	Cố ngoại	Maternal Great-Grandfather
13	Cụ ngoại	Maternal Great-Grandmother
14	Anh trai	Older Brother
15	Em trai	Younger Brother
16	Chị gái	Older Sister
17	Em gái	Younger Sister
18	Cháu trai	Nephew/Grandson
19	Cháu gái	Niece/Granddaughter
20	Chồng	Husband
21	Vợ	Wife
22	Chắt trai	Great-Grandson
23	Chắt gái	Great-Granddaughter
24	Chút trai	Great-Great-Grandson
25	Chút gái	Great-Great-Granddaughter
26	Cậu	Maternal Uncle
27	Dì	Maternal Aunt
28	Bác trai	Paternal Older Uncle
29	Bác gái	Paternal Older Aunt
30	Chú	Paternal Younger Uncle
31	Thím	Paternal Younger Uncle's Wife
32	Cô	Paternal Aunt
33	Dượng	Maternal Uncle's Husband
34	Con dâu	Daughter-in-law
35	Con rể	Son-in-law
36	Anh rể	Brother-in-law
37	Chị dâu	Sister-in-law
38	Em dâu	Younger Brother's Wife
39	Em rể	Younger Sister's Husband
\.


--
-- TOC entry 4225 (class 0 OID 17745)
-- Dependencies: 243
-- Data for Name: feedback_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.feedback_metadata (metadata_key, "totalFeedbacks", "averageRating") FROM stdin;
feedback_metadata	23	4.3478260869565215
\.


--
-- TOC entry 4226 (class 0 OID 17752)
-- Dependencies: 244
-- Data for Name: feedbacks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.feedbacks (id_feedback, comment, rating, id_user, created_at, updated_at) FROM stdin;
1	app ngu z tr	4	bd94ba3a-b046-4a05-a260-890913e09df9	2024-06-24 16:28:51.384439	2024-06-24 16:28:51.384439
2	app ngu z tr	4	bd94ba3a-b046-4a05-a260-890913e09df9	2024-06-24 16:29:56.726036	2024-06-24 16:29:56.726036
3	app ngu z tr	5	bd94ba3a-b046-4a05-a260-890913e09df9	2024-06-24 16:30:58.107215	2024-06-24 16:30:58.107215
4	ok	5	bd94ba3a-b046-4a05-a260-890913e09df9	2024-06-25 16:30:42.828508	2024-06-25 16:30:42.828508
5	Rất tốt	5	bd94ba3a-b046-4a05-a260-890913e09df9	2024-06-25 16:30:58.539653	2024-06-25 16:30:58.539653
6	aloo	4	bd94ba3a-b046-4a05-a260-890913e09df9	2024-06-26 13:04:41.436547	2024-06-26 13:04:41.436547
39	Test chơi	5	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-04 10:12:44.863168	2024-07-04 10:12:44.863168
40	string	4	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-08 10:12:21.347828	2024-07-08 10:12:21.347828
41	Hơi tệ	3	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-08 10:17:16.053343	2024-07-08 10:17:16.053343
42	46	5	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-08 10:17:55.252491	2024-07-08 10:17:55.252491
43	4	5	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-08 10:20:59.964553	2024-07-08 10:20:59.964553
44	Siêu đẹp	5	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-08 10:26:16.652015	2024-07-08 10:26:16.652015
45	Hmm	3	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-08 10:26:32.962356	2024-07-08 10:26:32.962356
46	4	5	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-08 10:31:48.763973	2024-07-08 10:31:48.763973
47	Quá 6	2	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-09 18:48:02.251413	2024-07-09 18:48:02.251413
48	OKey	5	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-15 01:48:21.073969	2024-07-15 01:48:21.073969
49	app được đấy nhờ, nhớ làm video call nha	5	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-19 17:30:45.591587	2024-07-19 17:30:45.591587
50	This product exceeded my expectations!	1	a86feee2-cb93-4a11-a724-35b2a0630b1e	2024-07-22 16:53:54.092132	2024-07-22 16:53:54.092132
51	This product exceeded my expectations!	1	e05be2ad-8a6b-433d-8dd4-65efb36d4318	2024-07-22 16:53:54.092132	2024-07-22 16:53:54.092132
52	This product exceeded my expectations!	1	7892faac-a86a-4a6e-8e12-c0e6f4408d11	2024-07-21 16:53:54.092132	2024-07-21 16:53:54.092132
53	This product exceeded my expectations!	1	ac430758-0fc5-4f1c-a849-134fae1723d3	2024-07-21 16:53:54.092132	2024-07-21 16:53:54.092132
54	This product exceeded my expectations!	1	2082eded-d0bd-46a5-a62d-1bed3839a6e9	2024-07-20 16:53:54.092132	2024-07-20 16:53:54.092132
55	This product exceeded my expectations!	1	68427a25-ab77-47ee-a17a-f618ebca1d66	2024-07-20 16:53:54.092132	2024-07-20 16:53:54.092132
56	This product exceeded my expectations!	1	eb3604a4-1c26-4d9b-a144-8430fcedce9e	2024-07-19 16:53:54.092132	2024-07-19 16:53:54.092132
57	This product exceeded my expectations!	1	398b86a6-8e22-45a6-8676-e9fb2f3a7f35	2024-07-18 16:53:54.092132	2024-07-18 16:53:54.092132
58	This product exceeded my expectations!	1	10ae4605-bd00-4f81-a599-a4f8f593c1a8	2024-07-18 16:53:54.092132	2024-07-18 16:53:54.092132
59	It is a good product, I would recommend it.	2	a1d62ba5-9cc1-4beb-9acc-cdba325c1b93	2024-07-16 16:53:54.092132	2024-07-16 16:53:54.092132
60	It is a good product, I would recommend it.	2	3db0256c-c406-4f5a-9e85-d5b2244f294a	2024-07-16 16:53:54.092132	2024-07-16 16:53:54.092132
61	It is a good product, I would recommend it.	2	30598aef-51e3-4610-945f-4530edf86842	2024-07-16 16:53:54.092132	2024-07-16 16:53:54.092132
62	It is a good product, I would recommend it.	2	0ad6f5b5-f6f8-4035-84d2-779966235b1c	2024-07-16 16:53:54.092132	2024-07-16 16:53:54.092132
63	It is a good product, I would recommend it.	2	9b951afe-c7ea-44b3-bace-00cd63ae6876	2024-07-14 16:53:54.092132	2024-07-14 16:53:54.092132
64	It is a good product, I would recommend it.	2	28905675-858b-4a93-a283-205899779622	2024-07-12 16:53:54.092132	2024-07-12 16:53:54.092132
65	It is a good product, I would recommend it.	2	39736911-800d-476b-b9ed-a7c0d9f2c0ff	2024-07-12 16:53:54.092132	2024-07-12 16:53:54.092132
66	It is a good product, I would recommend it.	2	594b1d0d-86fe-4534-b1c7-52ec7a2667c3	2024-07-12 16:53:54.092132	2024-07-12 16:53:54.092132
67	It is a good product, I would recommend it.	2	29d5f6f6-24da-4cbd-87c1-2b7d6582039f	2024-07-11 16:53:54.092132	2024-07-11 16:53:54.092132
68	It is a good product, I would recommend it.	2	743d7372-31ce-45a5-b999-c5f3b202b629	2024-07-11 16:53:54.092132	2024-07-11 16:53:54.092132
69	It is a good product, I would recommend it.	3	8a5ccf49-f775-4efe-a03c-36a39c5cfd95	2024-07-10 16:53:54.092132	2024-07-10 16:53:54.092132
70	It is a good product, I would recommend it.	3	67eeebe5-774f-4dc1-8f11-77eef7b630da	2024-07-10 16:53:54.092132	2024-07-10 16:53:54.092132
71	It is a good product, I would recommend it.	3	ff55db45-0781-491f-9146-ff4a0c87a6cc	2024-07-10 16:53:54.092132	2024-07-10 16:53:54.092132
72	It is a good product, I would recommend it.	3	a945a041-317c-4e7b-85e0-02670230225a	2024-07-10 16:53:54.092132	2024-07-10 16:53:54.092132
73	It is a good product, I would recommend it.	3	e6f375c1-f100-4f1e-86cf-bac589a4b4d6	2024-07-10 16:53:54.092132	2024-07-10 16:53:54.092132
74	It is a good product, I would recommend it.	3	a4b586c8-0f7a-4627-8403-fc09881c8eb6	2024-07-10 16:53:54.092132	2024-07-10 16:53:54.092132
75	It is a good product, I would recommend it.	3	addfb4ac-4895-4fec-be39-d3e935d94e2a	2024-07-10 16:53:54.092132	2024-07-10 16:53:54.092132
76	It is a good product, I would recommend it.	3	0c29e181-a341-4796-8055-730a151b22ae	2024-07-09 16:53:54.092132	2024-07-09 16:53:54.092132
77	It is a good product, I would recommend it.	3	f84d79c4-9b04-4dc1-b170-561ce8ec66c5	2024-07-09 16:53:54.092132	2024-07-09 16:53:54.092132
78	It is okay, but could be improved.	3	d4cab358-191e-4a87-98a6-edb36ca8d821	2024-07-07 16:53:54.092132	2024-07-07 16:53:54.092132
79	It is okay, but could be improved.	3	d127be7d-7e58-4090-a332-88a7cba778e4	2024-07-07 16:53:54.092132	2024-07-07 16:53:54.092132
80	It is okay, but could be improved.	3	d03789c8-05a2-40b5-beb4-15ec1ff59c13	2024-07-05 16:53:54.092132	2024-07-05 16:53:54.092132
81	It is okay, but could be improved.	4	2ae945cf-3229-42bf-a121-2918ad736019	2024-07-04 16:53:54.092132	2024-07-04 16:53:54.092132
82	It is okay, but could be improved.	4	25c42a91-bb44-4ea8-9dc3-0980d2987921	2024-07-04 16:53:54.092132	2024-07-04 16:53:54.092132
83	It is okay, but could be improved.	4	101627d7-019e-4a58-b8c0-b30806db3780	2024-07-03 16:53:54.092132	2024-07-03 16:53:54.092132
84	It is okay, but could be improved.	4	218f8efd-e453-4a68-b1b4-b54b71b9a04a	2024-07-03 16:53:54.092132	2024-07-03 16:53:54.092132
85	It is okay, but could be improved.	4	44d5d04d-25c5-4a8e-9328-bc8e90110d46	2024-07-03 16:53:54.092132	2024-07-03 16:53:54.092132
86	It is okay, but could be improved.	4	22982c99-db14-4521-8c90-1cefca3f513f	2024-07-01 16:53:54.092132	2024-07-01 16:53:54.092132
87	It is okay, but could be improved.	4	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-01 16:53:54.092132	2024-07-01 16:53:54.092132
88	It is okay, but could be improved.	4	3b5b6d2f-7038-4155-a81f-473ecfa93e64	2024-06-30 16:53:54.092132	2024-06-30 16:53:54.092132
89	It is okay, but could be improved.	4	fd4c8c04-b031-4ed4-9faa-e23146a79c9a	2024-06-30 16:53:54.092132	2024-06-30 16:53:54.092132
90	Not satisfied with this product.	5	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	2024-06-28 16:53:54.092132	2024-06-28 16:53:54.092132
91	Not satisfied with this product.	5	eba531d6-415e-4d8d-9da0-1a0ead7f6f28	2024-06-28 16:53:54.092132	2024-06-28 16:53:54.092132
92	Not satisfied with this product.	5	8f538109-63bf-431d-9fdb-3b5f05c72b04	2024-06-27 16:53:54.092132	2024-06-27 16:53:54.092132
93	Not satisfied with this product.	5	2ca8d27c-4e8c-4457-846e-5f5bb1afe103	2024-06-27 16:53:54.092132	2024-06-27 16:53:54.092132
94	Not satisfied with this product.	5	9791d284-ff48-46c1-be1d-6fe12727a259	2024-06-26 16:53:54.092132	2024-06-26 16:53:54.092132
95	Not satisfied with this product.	5	f66f158e-1076-44ae-b342-2334052eb60b	2024-06-26 16:53:54.092132	2024-06-26 16:53:54.092132
96	Not satisfied with this product.	5	6f77c48e-3273-429d-8b5d-395ec8fe2de8	2024-06-26 16:53:54.092132	2024-06-26 16:53:54.092132
97	Not satisfied with this product.	5	cf723e9f-f75a-4b94-9634-43880f326743	2024-06-25 16:53:54.092132	2024-06-25 16:53:54.092132
98	Not satisfied with this product.	5	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	2024-06-24 16:53:54.092132	2024-06-24 16:53:54.092132
99	Ok\n	5	28905675-858b-4a93-a283-205899779622	2024-07-25 14:43:02.403712	2024-07-25 14:43:02.403712
100	Hmm	3	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-27 08:26:17.169934	2024-07-27 08:26:17.169934
101	hehe	3	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-27 08:26:53.389976	2024-07-27 08:26:53.389976
102	132	5	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-27 08:27:14.791287	2024-07-27 08:27:14.791287
103	Cũng oke	4	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-28 17:07:07.393729	2024-07-28 17:07:07.393729
104	Very comfortable app\n	5	c691514e-5e9c-4995-9938-15952b462363	2024-07-29 21:22:16.360929	2024-07-29 21:22:16.360929
105	Hi	5	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-31 09:50:32.084839	2024-07-31 09:50:32.084839
\.


--
-- TOC entry 4207 (class 0 OID 17482)
-- Dependencies: 225
-- Data for Name: finance_assets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.finance_assets (id_asset, id_family, name, purchase_date, description, created_at, updated_at, image_url, value) FROM stdin;
2	96	Xe hơi	2024-11-29	Xe hơi 2 cánh	2024-07-07 17:13:12.056555	2024-07-22 14:51:54.238512	https://storage.googleapis.com/famfund-bucket/expense/asset_bd94ba3a-b046-4a05-a260-890913e09df9_1720376776652_i8.jpg	1000000
26	96	Giường 	2024-07-01	Giường là một món đồ nội thất được sử dụng làm nơi ngủ, nghỉ ngơi và thư giãn. Hầu hết các giường hiện đại bao gồm một tấm nệm mềm, đệm trên khung giường. Nệm nằm trên nền vững chắc, thường là thanh gỗ hoặc đế bung ra. Một chiếc giường có thể được mô tả là thoải mái, ấm cúng và mời gọi, cung cấp một nơi để nghỉ ngơi và thư giãn	2024-07-31 15:41:13.413175	2024-07-31 22:36:42.217585	https://storage.googleapis.com/famfund-bucket/expense/asset_bd94ba3a-b046-4a05-a260-890913e09df9_1722440473083_OIP.jpg	40000
14	96	Con mèo	2024-07-27		2024-07-29 14:03:07.758438	2024-07-29 14:10:19.386667	https://storage.googleapis.com/famfund-bucket/expense/asset_bd94ba3a-b046-4a05-a260-890913e09df9_1722262218997_CCB8544D-B249-4418-B915-4A457B15607F.jpg	10000000
4	96	Xe hơi	2024-07-24	Hi\n	2024-07-07 17:54:51.867077	2024-07-25 21:28:12.064968	https://storage.googleapis.com/famfund-bucket/expense/asset_bd94ba3a-b046-4a05-a260-890913e09df9_1720601037851_18F954C0-91FF-4EBE-8743-B144FAD1BAEF.png	100000
18	96	Máy giặt	2024-07-29		2024-07-29 14:21:41.564867	2024-07-29 14:22:01.125119	https://storage.googleapis.com/famfund-bucket/expense/asset_bd94ba3a-b046-4a05-a260-890913e09df9_1722262920744_24A1B38C-887B-4ADA-A59B-3A65F5F54513.jpg	100000000
19	96	Máy sấy	2024-07-29		2024-07-29 14:23:55.006059	2024-07-29 14:23:55.006059	https://storage.googleapis.com/famfund-bucket/expense/asset_bd94ba3a-b046-4a05-a260-890913e09df9_1722263034695_B86CA3E1-AE5D-4A1F-88AC-09FD6BF6CDBC.jpg	30000000
10	96	Chung cư	2024-07-11		2024-07-22 14:55:24.178652	2024-07-29 15:40:04.033581	https://storage.googleapis.com/famfund-bucket/expense/asset_bd94ba3a-b046-4a05-a260-890913e09df9_1722267603714_E3E93853-0585-4148-B0D6-FE581D2C644F.jpg	100000000
7	96	Nhà lầu	2024-07-24		2024-07-22 14:53:27.407566	2024-08-01 01:51:01.312329	https://storage.googleapis.com/famfund-bucket/expense/asset_bd94ba3a-b046-4a05-a260-890913e09df9_1722477060719_OIP.jpg	100000
\.


--
-- TOC entry 4230 (class 0 OID 17762)
-- Dependencies: 248
-- Data for Name: finance_expenditure; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.finance_expenditure (id_expenditure, id_family, description, id_created_by, id_expenditure_type, created_at, updated_at, amount, image_url, expenditure_date, id_utility, id_shopping_list) FROM stdin;
31	96	Mua quần áo	bd94ba3a-b046-4a05-a260-890913e09df9	5	2024-07-08 21:00:49.433103	2024-07-08 21:00:49.433103	350000	\N	2024-06-28 00:00:00	\N	\N
32	96	Đi ăn tiệc cưới	bd94ba3a-b046-4a05-a260-890913e09df9	1	2024-07-08 21:00:49.433103	2024-07-08 21:00:49.433103	700000	\N	2024-06-27 00:00:00	\N	\N
33	96	Chi tiêu du lịch	bd94ba3a-b046-4a05-a260-890913e09df9	4	2024-07-08 21:00:49.433103	2024-07-08 21:00:49.433103	1500000	\N	2024-06-26 00:00:00	\N	\N
34	96	Mua đồ gia dụng mới	bd94ba3a-b046-4a05-a260-890913e09df9	3	2024-07-08 21:00:49.433103	2024-07-08 21:00:49.433103	400000	\N	2024-06-25 00:00:00	\N	\N
35	96	Chi tiêu sửa nhà	bd94ba3a-b046-4a05-a260-890913e09df9	2	2024-07-08 21:00:49.433103	2024-07-08 21:00:49.433103	800000	\N	2024-06-24 00:00:00	\N	\N
36	96	Đi mua sắm thực phẩm	bd94ba3a-b046-4a05-a260-890913e09df9	5	2024-07-08 21:00:49.433103	2024-07-08 21:00:49.433103	300000	\N	2024-06-23 00:00:00	\N	\N
37	96	Chi tiêu điện tử gia dụng	bd94ba3a-b046-4a05-a260-890913e09df9	1	2024-07-08 21:00:49.433103	2024-07-08 21:00:49.433103	600000	\N	2024-06-22 00:00:00	\N	\N
38	96	Mua đồ chơi cho con	bd94ba3a-b046-4a05-a260-890913e09df9	4	2024-07-08 21:00:49.433103	2024-07-08 21:00:49.433103	200000	\N	2024-06-21 00:00:00	\N	\N
39	96	Sửa xe ô tô	bd94ba3a-b046-4a05-a260-890913e09df9	3	2024-07-08 21:00:49.433103	2024-07-08 21:00:49.433103	1200000	\N	2024-06-20 00:00:00	\N	\N
40	96	Mua sách và báo	bd94ba3a-b046-4a05-a260-890913e09df9	2	2024-07-08 21:00:49.433103	2024-07-08 21:00:49.433103	150000	\N	2024-06-19 00:00:00	\N	\N
41	96	Mua quần áo	bd94ba3a-b046-4a05-a260-890913e09df9	5	2024-07-08 21:00:50.626044	2024-07-08 21:00:50.626044	350000	\N	2024-06-28 00:00:00	\N	\N
42	96	Đi ăn tiệc cưới	bd94ba3a-b046-4a05-a260-890913e09df9	1	2024-07-08 21:00:50.626044	2024-07-08 21:00:50.626044	700000	\N	2024-06-27 00:00:00	\N	\N
43	96	Chi tiêu du lịch	bd94ba3a-b046-4a05-a260-890913e09df9	4	2024-07-08 21:00:50.626044	2024-07-08 21:00:50.626044	1500000	\N	2024-06-26 00:00:00	\N	\N
44	96	Mua đồ gia dụng mới	bd94ba3a-b046-4a05-a260-890913e09df9	3	2024-07-08 21:00:50.626044	2024-07-08 21:00:50.626044	400000	\N	2024-06-25 00:00:00	\N	\N
45	96	Chi tiêu sửa nhà	bd94ba3a-b046-4a05-a260-890913e09df9	2	2024-07-08 21:00:50.626044	2024-07-08 21:00:50.626044	800000	\N	2024-06-24 00:00:00	\N	\N
46	96	Đi mua sắm thực phẩm	bd94ba3a-b046-4a05-a260-890913e09df9	5	2024-07-08 21:00:50.626044	2024-07-08 21:00:50.626044	300000	\N	2024-06-23 00:00:00	\N	\N
47	96	Chi tiêu điện tử gia dụng	bd94ba3a-b046-4a05-a260-890913e09df9	1	2024-07-08 21:00:50.626044	2024-07-08 21:00:50.626044	600000	\N	2024-06-22 00:00:00	\N	\N
48	96	Mua đồ chơi cho con	bd94ba3a-b046-4a05-a260-890913e09df9	4	2024-07-08 21:00:50.626044	2024-07-08 21:00:50.626044	200000	\N	2024-06-21 00:00:00	\N	\N
50	96	Mua sách và báo	bd94ba3a-b046-4a05-a260-890913e09df9	2	2024-07-08 21:00:50.626044	2024-07-08 21:00:50.626044	150000	\N	2024-06-19 00:00:00	\N	\N
51	96	Mua điện thoại mới	bd94ba3a-b046-4a05-a260-890913e09df9	5	2024-07-08 21:00:57.611374	2024-07-08 21:00:57.611374	12000000	\N	2024-07-03 00:00:00	\N	\N
52	96	Đóng tiền điện	bd94ba3a-b046-4a05-a260-890913e09df9	1	2024-07-08 21:00:57.611374	2024-07-08 21:00:57.611374	500000	\N	2024-07-02 00:00:00	\N	\N
53	96	Chi tiêu sinh nhật	bd94ba3a-b046-4a05-a260-890913e09df9	4	2024-07-08 21:00:57.611374	2024-07-08 21:00:57.611374	800000	\N	2024-07-01 00:00:00	\N	\N
54	96	Sửa chữa xe máy	bd94ba3a-b046-4a05-a260-890913e09df9	3	2024-07-08 21:00:57.611374	2024-07-08 21:00:57.611374	300000	\N	2024-06-30 00:00:00	\N	\N
55	96	Mua sách và văn phòng phẩm	bd94ba3a-b046-4a05-a260-890913e09df9	2	2024-07-08 21:00:57.611374	2024-07-08 21:00:57.611374	250000	\N	2024-06-29 00:00:00	\N	\N
57	96	Đóng tiền điện	bd94ba3a-b046-4a05-a260-890913e09df9	1	2024-07-08 21:01:02.684714	2024-07-08 21:01:02.684714	500000	\N	2024-07-02 00:00:00	\N	\N
58	96	Chi tiêu sinh nhật	bd94ba3a-b046-4a05-a260-890913e09df9	4	2024-07-08 21:01:02.684714	2024-07-08 21:01:02.684714	800000	\N	2024-07-01 00:00:00	\N	\N
59	96	Sửa chữa xe máy	bd94ba3a-b046-4a05-a260-890913e09df9	3	2024-07-08 21:01:02.684714	2024-07-08 21:01:02.684714	300000	\N	2024-06-30 00:00:00	\N	\N
60	96	Mua sách và văn phòng phẩm	bd94ba3a-b046-4a05-a260-890913e09df9	2	2024-07-08 21:01:02.684714	2024-07-08 21:01:02.684714	250000	\N	2024-06-29 00:00:00	\N	\N
63	96		bd94ba3a-b046-4a05-a260-890913e09df9	2	2024-07-09 18:12:45.649308	2024-07-09 18:12:45.649308	100000	\N	2024-07-09 18:11:23.893	\N	\N
10	96	Mua quần áo	bd94ba3a-b046-4a05-a260-890913e09df9	5	2024-07-08 20:51:46.765886	2024-07-13 19:50:18.393332	400000	https://storage.googleapis.com/famfund-bucket/expense/expense_bd94ba3a-b046-4a05-a260-890913e09df9_1720900217448_DC68F86B-1F84-403E-B68C-590C18D1A587.jpg	2024-07-04 00:00:00	\N	\N
12	96	Đóng tiền điện	bd94ba3a-b046-4a05-a260-890913e09df9	1	2024-07-08 20:52:28.317564	2024-07-13 19:53:21.623723	500000	https://storage.googleapis.com/famfund-bucket/expense/expense_bd94ba3a-b046-4a05-a260-890913e09df9_1720900400932_DC68F86B-1F84-403E-B68C-590C18D1A587.jpg	2024-07-02 00:00:00	\N	\N
71	96	Grocery shopping	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	1	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	1500000		2024-01-10 08:30:00	\N	\N
72	96	Monthly rent	28905675-858b-4a93-a283-205899779622	2	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2000000		2024-01-20 12:00:00	\N	\N
73	96	Electricity bill	bd94ba3a-b046-4a05-a260-890913e09df9	3	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2500000		2024-02-05 10:00:00	\N	\N
74	96	Bus fare	101627d7-019e-4a58-b8c0-b30806db3780	4	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	1800000		2024-02-15 14:00:00	\N	\N
75	96	Medical expenses	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	5	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2200000		2024-03-01 16:00:00	\N	\N
76	96	Tuition fees	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	6	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	1600000		2024-03-10 09:00:00	\N	\N
77	96	Movie tickets	28905675-858b-4a93-a283-205899779622	7	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2400000		2024-03-25 11:00:00	\N	\N
78	96	Car insurance	bd94ba3a-b046-4a05-a260-890913e09df9	8	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	1700000		2024-04-01 13:00:00	\N	\N
15	96	Mua sách và văn phòng phẩm	bd94ba3a-b046-4a05-a260-890913e09df9	2	2024-07-08 20:52:28.317564	2024-07-26 01:14:59.274864	250000	https://storage.googleapis.com/famfund-bucket/expense/expense_28905675-858b-4a93-a283-205899779622_1721956498365_D9B956CB-3108-4DD2-AE32-25A029EF7C68.jpg	2024-06-29 00:00:00	\N	\N
19	96	Sửa chữa xe máy	bd94ba3a-b046-4a05-a260-890913e09df9	3	2024-07-08 20:54:31.969054	2024-07-26 01:45:40.64607	300000	https://storage.googleapis.com/famfund-bucket/expense/expense_28905675-858b-4a93-a283-205899779622_1721958339956_expense_28905675-858b-4a93-a283-205899779622_1721957433671_expense_28905675-858b-4a93-a283-205899779622_1721956498365_D9B956CB-3108-4DD2-AE32-25A029EF7C68.jpg	2024-06-30 00:00:00	\N	\N
23	96	Chi tiêu du lịch	bd94ba3a-b046-4a05-a260-890913e09df9	4	2024-07-08 21:00:46.96934	2024-07-26 02:54:32.745059	1500000	https://storage.googleapis.com/famfund-bucket/expense/expense_28905675-858b-4a93-a283-205899779622_1721962472153_expense_28905675-858b-4a93-a283-205899779622_1721962404088_expense_28905675-858b-4a93-a283-205899779622_1721958424402_expense_28905675-858b-4a93-a283-205899779622_1721957433671_expense_28905675-858b-4a93-a283-205899779622_1721956498365_D9B956CB-3108-4DD2-AE32-25A029EF7C68.jpg	2024-06-26 00:00:00	\N	\N
27	96	Chi tiêu điện tử gia dụng	bd94ba3a-b046-4a05-a260-890913e09df9	1	2024-07-08 21:00:46.96934	2024-07-26 03:00:21.727267	600000	https://storage.googleapis.com/famfund-bucket/expense/expense_28905675-858b-4a93-a283-205899779622_1721962821338_ADA21D67-691F-495F-865C-9F86DD335B50.jpg	2024-06-22 00:00:00	\N	\N
28	96	Mua đồ chơi cho con	bd94ba3a-b046-4a05-a260-890913e09df9	4	2024-07-08 21:00:46.96934	2024-07-26 03:02:03.55521	200000	https://storage.googleapis.com/famfund-bucket/expense/expense_28905675-858b-4a93-a283-205899779622_1721962923242_453D3FBF-6715-454B-865B-22B46E9E9CFD.jpg	2024-06-21 00:00:00	\N	\N
30	96	Mua sách và báo	bd94ba3a-b046-4a05-a260-890913e09df9	2	2024-07-08 21:00:46.96934	2024-07-27 10:48:04.66661	150000	https://storage.googleapis.com/famfund-bucket/expense/expense_bd94ba3a-b046-4a05-a260-890913e09df9_1722077283337_2024-lamborghini-revuelto-exterior.jpg	2024-06-19 00:00:00	\N	\N
79	96	Dining out	101627d7-019e-4a58-b8c0-b30806db3780	9	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2500000		2024-04-15 15:00:00	\N	\N
80	96	Fitness membership	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	10	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2000000		2024-05-02 10:00:00	\N	\N
81	96	Internet bill	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	1	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2200000		2024-05-10 11:00:00	\N	\N
82	96	Books and supplies	28905675-858b-4a93-a283-205899779622	2	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	1900000		2024-05-20 12:00:00	\N	\N
83	96	Health insurance	bd94ba3a-b046-4a05-a260-890913e09df9	3	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2100000		2024-06-01 13:00:00	\N	\N
84	96	Public transport	101627d7-019e-4a58-b8c0-b30806db3780	4	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	1800000		2024-06-10 14:00:00	\N	\N
85	96	Gym membership	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	5	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2300000		2024-06-20 15:00:00	\N	\N
86	96	Grocery shopping	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	6	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	1900000		2024-07-01 10:00:00	\N	\N
87	96	Rent	28905675-858b-4a93-a283-205899779622	7	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2500000		2024-07-10 12:00:00	\N	\N
88	96	Utilities	bd94ba3a-b046-4a05-a260-890913e09df9	8	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2200000		2024-07-15 14:00:00	\N	\N
89	96	Healthcare	101627d7-019e-4a58-b8c0-b30806db3780	9	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2000000		2024-07-20 09:00:00	\N	\N
90	96	Education	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	10	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2100000		2024-07-22 16:00:00	\N	\N
91	96	Entertainment	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	1	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	1800000		2024-01-15 08:30:00	\N	\N
92	96	Insurance	28905675-858b-4a93-a283-205899779622	2	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2200000		2024-01-25 12:00:00	\N	\N
93	96	Debt Payments	bd94ba3a-b046-4a05-a260-890913e09df9	3	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	1700000		2024-02-05 10:00:00	\N	\N
94	96	Savings	101627d7-019e-4a58-b8c0-b30806db3780	4	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2000000		2024-02-15 14:00:00	\N	\N
95	96	Food & Groceries	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	5	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2300000		2024-03-05 11:00:00	\N	\N
96	96	Rent	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	6	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	1900000		2024-03-15 09:00:00	\N	\N
97	96	Utilities	28905675-858b-4a93-a283-205899779622	7	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2100000		2024-04-01 13:00:00	\N	\N
98	96	Transportation	bd94ba3a-b046-4a05-a260-890913e09df9	8	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	1800000		2024-04-15 10:00:00	\N	\N
99	96	Healthcare	101627d7-019e-4a58-b8c0-b30806db3780	9	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2400000		2024-05-01 12:00:00	\N	\N
100	96	Education	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	10	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2000000		2024-05-15 14:00:00	\N	\N
101	96	Entertainment	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	1	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2200000		2024-06-01 08:30:00	\N	\N
102	96	Insurance	28905675-858b-4a93-a283-205899779622	2	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	1800000		2024-06-15 10:00:00	\N	\N
103	96	Debt Payments	bd94ba3a-b046-4a05-a260-890913e09df9	3	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2100000		2024-06-20 12:00:00	\N	\N
104	96	Savings	101627d7-019e-4a58-b8c0-b30806db3780	4	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2000000		2024-07-01 14:00:00	\N	\N
105	96	Food & Groceries	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	5	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2300000		2024-07-10 09:00:00	\N	\N
106	96	Rent	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	6	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	1900000		2024-07-15 12:00:00	\N	\N
107	96	Utilities	28905675-858b-4a93-a283-205899779622	7	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2100000		2024-07-20 11:00:00	\N	\N
108	96	Transportation	bd94ba3a-b046-4a05-a260-890913e09df9	8	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2200000		2024-07-22 10:00:00	\N	\N
109	96	Healthcare	101627d7-019e-4a58-b8c0-b30806db3780	9	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2000000		2024-07-22 16:00:00	\N	\N
110	96	Education	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	10	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2100000		2024-07-22 17:00:00	\N	\N
111	96	Entertainment	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	1	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	1900000		2024-01-30 13:00:00	\N	\N
112	96	Insurance	28905675-858b-4a93-a283-205899779622	2	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2100000		2024-02-28 14:00:00	\N	\N
113	96	Debt Payments	bd94ba3a-b046-4a05-a260-890913e09df9	3	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2300000		2024-03-30 15:00:00	\N	\N
114	96	Savings	101627d7-019e-4a58-b8c0-b30806db3780	4	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	1800000		2024-04-30 16:00:00	\N	\N
115	96	Food & Groceries	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	5	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2500000		2024-05-30 17:00:00	\N	\N
116	96	Rent	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	6	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2000000		2024-06-30 18:00:00	\N	\N
117	96	Utilities	28905675-858b-4a93-a283-205899779622	7	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2200000		2024-07-01 19:00:00	\N	\N
118	96	Transportation	bd94ba3a-b046-4a05-a260-890913e09df9	8	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2400000		2024-07-02 20:00:00	\N	\N
119	96	Healthcare	101627d7-019e-4a58-b8c0-b30806db3780	9	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2100000		2024-07-05 21:00:00	\N	\N
120	96	Education	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	10	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2300000		2024-07-07 22:00:00	\N	\N
121	96	Entertainment	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	1	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	1800000		2024-07-10 23:00:00	\N	\N
122	96	Insurance	28905675-858b-4a93-a283-205899779622	2	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2000000		2024-07-12 18:00:00	\N	\N
123	96	Debt Payments	bd94ba3a-b046-4a05-a260-890913e09df9	3	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2300000		2024-07-15 17:00:00	\N	\N
124	96	Savings	101627d7-019e-4a58-b8c0-b30806db3780	4	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2200000		2024-07-18 16:00:00	\N	\N
125	96	Food & Groceries	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	5	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2000000		2024-07-20 15:00:00	\N	\N
126	96	Rent	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	6	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2100000		2024-07-22 14:00:00	\N	\N
127	96	Utilities	28905675-858b-4a93-a283-205899779622	7	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2300000		2024-07-22 12:00:00	\N	\N
128	96	Transportation	bd94ba3a-b046-4a05-a260-890913e09df9	8	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2200000		2024-07-22 11:00:00	\N	\N
129	96	Healthcare	101627d7-019e-4a58-b8c0-b30806db3780	9	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2000000		2024-07-22 10:00:00	\N	\N
130	96	Education	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	10	2024-07-22 17:11:43.369692	2024-07-22 17:11:43.369692	2200000		2024-07-22 09:00:00	\N	\N
14	96	Sửa chữa xe máy	bd94ba3a-b046-4a05-a260-890913e09df9	3	2024-07-08 20:52:28.317564	2024-07-25 20:35:45.748789	300000	https://storage.googleapis.com/famfund-bucket/expense/expense_bd94ba3a-b046-4a05-a260-890913e09df9_1721939745235_20A8FE8D-5219-4637-ACFD-FCB140A8CBAF.jpg	2024-06-30 00:00:00	\N	\N
17	96	Đóng tiền điện	bd94ba3a-b046-4a05-a260-890913e09df9	1	2024-07-08 20:54:31.969054	2024-07-26 01:16:59.800328	500000	https://storage.googleapis.com/famfund-bucket/expense/expense_28905675-858b-4a93-a283-205899779622_1721956619162_45B6D8F2-CCCA-4302-B551-D42620338E35.jpg	2024-07-02 00:00:00	\N	\N
18	96	Chi tiêu sinh nhật	bd94ba3a-b046-4a05-a260-890913e09df9	4	2024-07-08 20:54:31.969054	2024-07-26 01:30:34.317143	800000	https://storage.googleapis.com/famfund-bucket/expense/expense_28905675-858b-4a93-a283-205899779622_1721957433671_expense_28905675-858b-4a93-a283-205899779622_1721956498365_D9B956CB-3108-4DD2-AE32-25A029EF7C68.jpg	2024-07-01 00:00:00	\N	\N
20	96	Mua sách và văn phòng phẩm	bd94ba3a-b046-4a05-a260-890913e09df9	2	2024-07-08 20:54:31.969054	2024-07-26 01:47:05.007834	250000	https://storage.googleapis.com/famfund-bucket/expense/expense_28905675-858b-4a93-a283-205899779622_1721958424402_expense_28905675-858b-4a93-a283-205899779622_1721957433671_expense_28905675-858b-4a93-a283-205899779622_1721956498365_D9B956CB-3108-4DD2-AE32-25A029EF7C68.jpg	2024-06-29 00:00:00	\N	\N
21	96	Mua quần áo	bd94ba3a-b046-4a05-a260-890913e09df9	5	2024-07-08 21:00:46.96934	2024-07-26 02:51:53.94995	350000	https://storage.googleapis.com/famfund-bucket/expense/expense_28905675-858b-4a93-a283-205899779622_1721962313157_expense_28905675-858b-4a93-a283-205899779622_1721958424402_expense_28905675-858b-4a93-a283-205899779622_1721957433671_expense_28905675-858b-4a93-a283-205899779622_1721956498365_D9B956CB-3108-4DD2-AE32-25A029EF7C68.jpg	2024-06-28 00:00:00	\N	\N
24	96	Mua đồ gia dụng mới	bd94ba3a-b046-4a05-a260-890913e09df9	3	2024-07-08 21:00:46.96934	2024-07-26 02:56:15.562998	400000	https://storage.googleapis.com/famfund-bucket/expense/expense_28905675-858b-4a93-a283-205899779622_1721962574922_expense_28905675-858b-4a93-a283-205899779622_1721962404088_expense_28905675-858b-4a93-a283-205899779622_1721958424402_expense_28905675-858b-4a93-a283-205899779622_1721957433671_expense_28905675-858b-4a93-a283-205899779622_1721956498365_D9B956CB-3108-4DD2-AE32-25A029EF7C68.jpg	2024-06-25 00:00:00	\N	\N
25	96	Chi tiêu sửa nhà	bd94ba3a-b046-4a05-a260-890913e09df9	2	2024-07-08 21:00:46.96934	2024-07-26 02:57:05.918021	800000	https://storage.googleapis.com/famfund-bucket/expense/expense_28905675-858b-4a93-a283-205899779622_1721962625141_expense_28905675-858b-4a93-a283-205899779622_1721962404088_expense_28905675-858b-4a93-a283-205899779622_1721958424402_expense_28905675-858b-4a93-a283-205899779622_1721957433671_expense_28905675-858b-4a93-a283-205899779622_1721956498365_D9B956CB-3108-4DD2-AE32-25A029EF7C68.jpg	2024-06-24 00:00:00	\N	\N
26	96	Đi mua sắm thực phẩm	bd94ba3a-b046-4a05-a260-890913e09df9	5	2024-07-08 21:00:46.96934	2024-07-26 02:57:56.706967	300000	https://storage.googleapis.com/famfund-bucket/expense/expense_28905675-858b-4a93-a283-205899779622_1721962676104_expense_28905675-858b-4a93-a283-205899779622_1721962404088_expense_28905675-858b-4a93-a283-205899779622_1721958424402_expense_28905675-858b-4a93-a283-205899779622_1721957433671_expense_28905675-858b-4a93-a283-205899779622_1721956498365_D9B956CB-3108-4DD2-AE32-25A029EF7C68.jpg	2024-06-23 00:00:00	\N	\N
29	96	Sửa xe ô tô	bd94ba3a-b046-4a05-a260-890913e09df9	3	2024-07-08 21:00:46.96934	2024-07-27 10:45:39.780368	1200000	https://storage.googleapis.com/famfund-bucket/expense/expense_bd94ba3a-b046-4a05-a260-890913e09df9_1722077138454_2024-lamborghini-revuelto-exterior.jpg	2024-06-20 00:00:00	\N	\N
149	96		9e153f4a-7c30-4e6f-a1bd-157a6eea5885	1	2024-08-01 06:02:25.109318	2024-08-01 06:02:25.109318	100000	\N	2024-08-01 06:02:25.109318	\N	\N
153	96		9e153f4a-7c30-4e6f-a1bd-157a6eea5885	1	2024-08-01 06:30:51.11464	2024-08-01 06:30:51.11464	100000	\N	2024-08-01 06:30:51.11464	\N	\N
154	96		e4334118-dfef-4e5e-bfad-6a5db2e10d0b	6	2024-08-01 06:32:22.126386	2024-08-01 06:33:12.911737	2	https://storage.googleapis.com/famfund-bucket/expense/expense_bd94ba3a-b046-4a05-a260-890913e09df9_1722493992414_572622EE-AF33-4CC2-BF13-4941821BB3A8.png	2024-08-01 06:10:23.76	\N	\N
137	96		bd94ba3a-b046-4a05-a260-890913e09df9	1	2024-07-27 10:42:10.717234	2024-08-01 07:25:03.311633	20000	https://storage.googleapis.com/famfund-bucket/expense/expense_bd94ba3a-b046-4a05-a260-890913e09df9_1722497102749_expense_bd94ba3a-b046-4a05-a260-890913e09df9_1722077329135_2024-lamborghini-revuelto-exterior.jpg	2024-08-01 07:24:56.148	\N	\N
166	96		bd94ba3a-b046-4a05-a260-890913e09df9	2	2024-08-01 13:56:05.284487	2024-08-01 16:53:41.712347	50000	\N	2024-08-01 13:56:05.284487	\N	\N
172	96		\N	3	2024-08-01 17:35:37.079725	2024-08-01 17:35:37.079725	100000	\N	2024-08-01 17:35:37.026	\N	\N
\.


--
-- TOC entry 4233 (class 0 OID 17774)
-- Dependencies: 251
-- Data for Name: finance_expenditure_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.finance_expenditure_type (id_family, id_expenditure_type, expense_type_name, expense_type_name_vn) FROM stdin;
96	1	Food & Groceries	Thực phẩm và mặt hàng phẩm
96	2	Rent	Tiền thuê
96	3	Utilities	Chi phí tiện ích
96	4	Transportation	Chi phí đi lại
96	5	Healthcare	Y tế
96	6	Education	Giáo dục
96	7	Entertainment	Giải trí
96	8	Insurance	Bảo hiểm
96	9	Debt Payments	Nợ
96	10	Savings :z	Tiết kiệm
117	241	Utilities	\N
117	242	Shopping	\N
117	243	Food & Groceries	Thực phẩm và mặt hàng phẩm
117	244	Rent	Tiền thuê
117	245	Utilities	Chi phí tiện ích
117	246	Transportation	Chi phí đi lại
117	247	Healthcare	Y tế
117	248	Education	Giáo dục
117	249	Entertainment	Giải trí
117	250	Insurance	Bảo hiểm
117	251	Debt Payments	Nợ
117	252	Savings	Tiết kiệm
\.


--
-- TOC entry 4235 (class 0 OID 17778)
-- Dependencies: 253
-- Data for Name: finance_income; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.finance_income (id_income, id_family, id_created_by, id_income_source, description, created_at, updated_at, amount, income_date) FROM stdin;
68	96	bd94ba3a-b046-4a05-a260-890913e09df9	7	Tiền thuê nhà	2024-07-08 22:21:30.332009	2024-07-08 22:21:30.332009	15000000	2024-07-04 00:00:00
70	96	bd94ba3a-b046-4a05-a260-890913e09df9	9	Tiền hoa hồng	2024-07-08 22:21:30.332009	2024-07-08 22:21:30.332009	2500000	2024-07-06 00:00:00
71	96	bd94ba3a-b046-4a05-a260-890913e09df9	10	Tiền thưởng	2024-07-08 22:21:30.332009	2024-07-08 22:21:30.332009	4000000	2024-07-07 00:00:00
72	96	bd94ba3a-b046-4a05-a260-890913e09df9	1	Tiền lương tháng 1	2024-07-08 22:21:30.332009	2024-07-08 22:21:30.332009	10000000	2024-07-01 00:00:00
75	96	bd94ba3a-b046-4a05-a260-890913e09df9	4	Thưởng tháng 2	2024-07-08 22:21:30.332009	2024-07-08 22:21:30.332009	5500000	2024-08-02 00:00:00
76	96	bd94ba3a-b046-4a05-a260-890913e09df9	5	Tiền lương tháng 3	2024-07-08 22:21:30.332009	2024-07-08 22:21:30.332009	11000000	2024-09-01 00:00:00
67	96	bd94ba3a-b046-4a05-a260-890913e09df9	10	string	2024-07-08 22:21:30.332009	2024-07-13 19:18:44.316496	300000	2024-07-13 19:18:17.329
69	96	bd94ba3a-b046-4a05-a260-890913e09df9	10	Tiền cổ tức	2024-07-08 22:21:30.332009	2024-07-13 19:38:31.48552	6000000	2024-07-13 19:38:27.728
73	96	bd94ba3a-b046-4a05-a260-890913e09df9	5	Thưởng tháng 1	2024-07-08 22:21:30.332009	2024-07-13 19:43:30.882618	5000000	2024-07-13 19:43:20.967
37	96	bd94ba3a-b046-4a05-a260-890913e09df9	1	Tiền lương tháng 1	2024-07-08 22:19:52.520791	2024-07-08 22:19:52.520791	10000000	2024-07-01 00:00:00
40	96	bd94ba3a-b046-4a05-a260-890913e09df9	4	Thưởng tháng 2	2024-07-08 22:19:52.520791	2024-07-08 22:19:52.520791	5500000	2024-08-02 00:00:00
41	96	bd94ba3a-b046-4a05-a260-890913e09df9	5	Tiền lương tháng 3	2024-07-08 22:19:52.520791	2024-07-08 22:19:52.520791	11000000	2024-09-01 00:00:00
42	96	bd94ba3a-b046-4a05-a260-890913e09df9	6	Thưởng tháng 3	2024-07-08 22:19:52.520791	2024-07-08 22:19:52.520791	6000000	2024-09-02 00:00:00
43	96	bd94ba3a-b046-4a05-a260-890913e09df9	7	Tiền lương tháng 4	2024-07-08 22:19:52.520791	2024-07-08 22:19:52.520791	11500000	2024-10-01 00:00:00
44	96	bd94ba3a-b046-4a05-a260-890913e09df9	8	Thưởng tháng 4	2024-07-08 22:19:52.520791	2024-07-08 22:19:52.520791	6500000	2024-10-02 00:00:00
45	96	bd94ba3a-b046-4a05-a260-890913e09df9	9	Tiền lương tháng 5	2024-07-08 22:19:52.520791	2024-07-08 22:19:52.520791	12000000	2024-11-01 00:00:00
46	96	bd94ba3a-b046-4a05-a260-890913e09df9	10	Thưởng tháng 5	2024-07-08 22:19:52.520791	2024-07-08 22:19:52.520791	7000000	2024-11-02 00:00:00
93	96	28905675-858b-4a93-a283-205899779622	2	Web development services	2024-07-22 16:59:25.475315	2024-07-22 16:59:25.475315	5500000	2024-07-16 14:00:00
94	96	bd94ba3a-b046-4a05-a260-890913e09df9	3	Cryptocurrency investments	2024-07-22 16:59:25.475315	2024-07-22 16:59:25.475315	12000000	2024-07-11 11:30:00
95	96	101627d7-019e-4a58-b8c0-b30806db3780	4	Office rent	2024-07-22 16:59:25.475315	2024-07-22 16:59:25.475315	7500000	2024-07-22 08:45:00
96	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	5	Dividend payments from stocks	2024-07-22 16:59:25.475315	2024-07-22 16:59:25.475315	2500000	2024-07-15 10:15:00
97	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	6	Marketing consulting fees	2024-07-22 16:59:25.475315	2024-07-22 16:59:25.475315	6500000	2024-07-18 09:30:00
98	96	28905675-858b-4a93-a283-205899779622	7	Music royalties	2024-07-22 16:59:25.475315	2024-07-22 16:59:25.475315	9000000	2024-07-20 15:00:00
99	96	bd94ba3a-b046-4a05-a260-890913e09df9	8	Academic grants	2024-07-22 16:59:25.475315	2024-07-22 16:59:25.475315	5000000	2024-07-19 13:45:00
100	96	101627d7-019e-4a58-b8c0-b30806db3780	9	Year-end bonuses	2024-07-22 16:59:25.475315	2024-07-22 16:59:25.475315	3500000	2024-07-22 16:00:00
101	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	10	Interest from savings	2024-07-22 16:59:25.475315	2024-07-22 16:59:25.475315	1500000	2024-07-14 17:30:00
102	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	1	Salary for July	2024-07-22 16:59:25.475315	2024-07-22 16:59:25.475315	10500000	2024-07-23 09:00:00
103	96	28905675-858b-4a93-a283-205899779622	2	Freelance design services	2024-07-22 16:59:25.475315	2024-07-22 16:59:25.475315	5200000	2024-07-12 14:00:00
104	96	bd94ba3a-b046-4a05-a260-890913e09df9	3	Real estate investments	2024-07-22 16:59:25.475315	2024-07-22 16:59:25.475315	14500000	2024-07-13 11:30:00
105	96	101627d7-019e-4a58-b8c0-b30806db3780	4	Warehouse rent	2024-07-22 16:59:25.475315	2024-07-22 16:59:25.475315	7200000	2024-07-17 08:45:00
106	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	5	Dividend income	2024-07-22 16:59:25.475315	2024-07-22 16:59:25.475315	2200000	2024-07-20 10:15:00
107	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	6	IT consulting fees	2024-07-22 16:59:25.475315	2024-07-22 16:59:25.475315	6200000	2024-07-21 09:30:00
108	96	28905675-858b-4a93-a283-205899779622	7	Patent royalties	2024-07-22 16:59:25.475315	2024-07-22 16:59:25.475315	8500000	2024-07-11 15:00:00
109	96	bd94ba3a-b046-4a05-a260-890913e09df9	8	Government grants	2024-07-22 16:59:25.475315	2024-07-22 16:59:25.475315	4300000	2024-07-12 13:45:00
110	96	101627d7-019e-4a58-b8c0-b30806db3780	9	Holiday bonuses	2024-07-22 16:59:25.475315	2024-07-22 16:59:25.475315	3100000	2024-07-18 16:00:00
111	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	10	Loan interest	2024-07-22 16:59:25.475315	2024-07-22 16:59:25.475315	1300000	2024-07-19 17:30:00
112	96	28905675-858b-4a93-a283-205899779622	7	Book royalties	2024-07-22 17:00:12.976325	2024-07-22 17:00:12.976325	8700000	2024-07-12 15:00:00
113	96	bd94ba3a-b046-4a05-a260-890913e09df9	8	Research grants	2024-07-22 17:00:12.976325	2024-07-22 17:00:12.976325	4700000	2024-07-14 13:45:00
114	96	101627d7-019e-4a58-b8c0-b30806db3780	9	End-of-year bonuses	2024-07-22 17:00:12.976325	2024-07-22 17:00:12.976325	3400000	2024-07-20 16:00:00
115	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	10	Savings account interest	2024-07-22 17:00:12.976325	2024-07-22 17:00:12.976325	1400000	2024-07-22 17:30:00
116	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	1	Salary for August	2024-07-22 17:00:12.976325	2024-07-22 17:00:12.976325	11500000	2024-07-23 09:00:00
117	96	28905675-858b-4a93-a283-205899779622	2	Marketing services	2024-07-22 17:00:12.976325	2024-07-22 17:00:12.976325	5400000	2024-07-21 14:00:00
118	96	bd94ba3a-b046-4a05-a260-890913e09df9	3	Real estate rental income	2024-07-22 17:00:12.976325	2024-07-22 17:00:12.976325	12500000	2024-07-17 11:30:00
119	96	101627d7-019e-4a58-b8c0-b30806db3780	4	Office lease	2024-07-22 17:00:12.976325	2024-07-22 17:00:12.976325	7300000	2024-07-18 08:45:00
120	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	5	Dividend income from shares	2024-07-22 17:00:12.976325	2024-07-22 17:00:12.976325	2600000	2024-07-15 10:15:00
121	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	6	Business consulting fees	2024-07-22 17:00:12.976325	2024-07-22 17:00:12.976325	6700000	2024-07-22 09:30:00
122	96	28905675-858b-4a93-a283-205899779622	7	Royalty payments for patents	2024-07-22 17:00:12.976325	2024-07-22 17:00:12.976325	8800000	2024-07-12 15:00:00
123	96	bd94ba3a-b046-4a05-a260-890913e09df9	8	Educational grants	2024-07-22 17:00:12.976325	2024-07-22 17:00:12.976325	4900000	2024-07-19 13:45:00
124	96	101627d7-019e-4a58-b8c0-b30806db3780	9	Annual performance bonuses	2024-07-22 17:00:12.976325	2024-07-22 17:00:12.976325	3200000	2024-07-16 16:00:00
125	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	10	Interest on fixed deposits	2024-07-22 17:00:12.976325	2024-07-22 17:00:12.976325	1200000	2024-07-20 17:30:00
126	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	1	August salary	2024-07-22 17:00:12.976325	2024-07-22 17:00:12.976325	11800000	2024-07-19 09:00:00
127	96	28905675-858b-4a93-a283-205899779622	2	IT consultancy services	2024-07-22 17:00:12.976325	2024-07-22 17:00:12.976325	5500000	2024-07-14 14:00:00
128	96	bd94ba3a-b046-4a05-a260-890913e09df9	3	Bond investments	2024-07-22 17:00:12.976325	2024-07-22 17:00:12.976325	13500000	2024-07-22 11:30:00
129	96	101627d7-019e-4a58-b8c0-b30806db3780	4	Commercial rent	2024-07-22 17:00:12.976325	2024-07-22 17:00:12.976325	7400000	2024-07-11 08:45:00
130	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	5	Dividend earnings	2024-07-22 17:00:12.976325	2024-07-22 17:00:12.976325	2700000	2024-07-16 10:15:00
78	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	2		2024-07-19 10:32:44.624378	2024-07-26 01:53:36.459037	100000000	2024-07-26 01:53:26.424
80	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	2		2024-07-19 10:47:12.515159	2024-07-26 01:57:09.392366	10000	2024-07-26 01:57:06.771
79	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	2	string	2024-07-19 10:38:39.633328	2024-07-26 01:55:52.273776	100000	2024-07-26 01:55:24.886
81	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	7		2024-07-19 10:48:53.510133	2024-07-26 02:02:16.415901	10000	2024-07-26 01:59:24.071
82	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	1	Monthly salary	2024-07-22 16:59:25.475315	2024-07-26 02:07:37.542295	10000000	2024-07-26 02:07:23.396
83	96	28905675-858b-4a93-a283-205899779622	3	Consulting services	2024-07-22 16:59:25.475315	2024-07-26 02:09:08.877291	5000000	2024-07-26 02:08:09.212
84	96	bd94ba3a-b046-4a05-a260-890913e09df9	3	Stock investments	2024-07-22 16:59:25.475315	2024-07-26 02:11:10.301412	15000000	2024-07-26 02:11:07.973
85	96	101627d7-019e-4a58-b8c0-b30806db3780	4	Apartment rent	2024-07-22 16:59:25.475315	2024-07-26 02:12:47.3801	7000000	2024-07-26 02:12:45.225
87	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	6	Consulting fees	2024-07-22 16:59:25.475315	2024-07-26 02:20:15.755676	6000000	2024-07-26 02:20:11.646
86	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	7	Dividend payments	2024-07-22 16:59:25.475315	2024-07-26 02:18:56.305205	2000000	2024-07-26 02:13:57.792
88	96	28905675-858b-4a93-a283-205899779622	7	Book royalties	2024-07-22 16:59:25.475315	2024-07-26 02:22:04.896699	8000000	2024-07-26 02:22:01.075
89	96	bd94ba3a-b046-4a05-a260-890913e09df9	8	Research grants	2024-07-22 16:59:25.475315	2024-07-26 02:23:18.568029	4500000	2024-07-26 02:22:45.327
38	96	bd94ba3a-b046-4a05-a260-890913e09df9	9	Thưởng tháng 1	2024-07-08 22:19:52.520791	2024-07-26 02:24:55.278088	500000000	2024-07-26 02:24:39.522
92	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	1	Monthly salary	2024-07-22 16:59:25.475315	2024-07-26 02:31:20.69518	11000	2024-07-26 02:31:10.892
39	96	bd94ba3a-b046-4a05-a260-890913e09df9	5	Tiền lương tháng 2	2024-07-08 22:19:52.520791	2024-08-01 07:22:37.140851	10500000	2024-08-01 07:22:31.136
91	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	10	Bank interest	2024-07-22 16:59:25.475315	2024-07-26 02:34:52.911216	10000	2024-07-26 02:34:00
74	96	bd94ba3a-b046-4a05-a260-890913e09df9	4	Tiền lương tháng 2	2024-07-08 22:21:30.332009	2024-08-01 07:22:53.38977	10500000	2024-08-01 07:22:46.583
131	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	6	Consulting revenue	2024-07-22 17:00:12.976325	2024-07-22 17:00:12.976325	6800000	2024-07-15 09:30:00
132	96	28905675-858b-4a93-a283-205899779622	7	Creative work royalties	2024-07-22 17:00:12.976325	2024-07-22 17:00:12.976325	8900000	2024-07-13 15:00:00
133	96	bd94ba3a-b046-4a05-a260-890913e09df9	8	Scholarship grants	2024-07-22 17:00:12.976325	2024-07-22 17:00:12.976325	5100000	2024-07-12 13:45:00
134	96	101627d7-019e-4a58-b8c0-b30806db3780	9	Holiday bonuses	2024-07-22 17:00:12.976325	2024-07-22 17:00:12.976325	3300000	2024-07-20 16:00:00
135	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	10	Savings interest	2024-07-22 17:00:12.976325	2024-07-22 17:00:12.976325	1500000	2024-07-22 17:30:00
136	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	1	September salary	2024-07-22 17:00:12.976325	2024-07-22 17:00:12.976325	12200000	2024-07-23 09:00:00
137	96	28905675-858b-4a93-a283-205899779622	2	Freelance writing services	2024-07-22 17:00:12.976325	2024-07-22 17:00:12.976325	5600000	2024-07-19 14:00:00
138	96	bd94ba3a-b046-4a05-a260-890913e09df9	3	Mutual fund earnings	2024-07-22 17:00:12.976325	2024-07-22 17:00:12.976325	14000000	2024-07-22 11:30:00
139	96	101627d7-019e-4a58-b8c0-b30806db3780	4	Real estate rental income	2024-07-22 17:00:12.976325	2024-07-22 17:00:12.976325	7500000	2024-07-23 08:45:00
140	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	5	Equity dividends	2024-07-22 17:00:12.976325	2024-07-22 17:00:12.976325	2800000	2024-07-21 10:15:00
141	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	6	Business income	2024-07-22 17:00:12.976325	2024-07-22 17:00:12.976325	6900000	2024-07-20 09:30:00
142	96	28905675-858b-4a93-a283-205899779622	7	Music royalties	2024-07-22 17:00:12.976325	2024-07-22 17:00:12.976325	9100000	2024-07-17 15:00:00
143	96	bd94ba3a-b046-4a05-a260-890913e09df9	8	Government research grants	2024-07-22 17:00:12.976325	2024-07-22 17:00:12.976325	5300000	2024-07-16 13:45:00
144	96	101627d7-019e-4a58-b8c0-b30806db3780	9	Bonus payments	2024-07-22 17:00:12.976325	2024-07-22 17:00:12.976325	3400000	2024-07-15 16:00:00
145	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	10	Fixed deposit interest	2024-07-22 17:00:12.976325	2024-07-22 17:00:12.976325	1600000	2024-07-14 17:30:00
146	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	1	Monthly salary	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	12000000	2024-07-01 09:00:00
147	96	28905675-858b-4a93-a283-205899779622	2	Consulting services	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	5300000	2024-07-02 14:00:00
148	96	bd94ba3a-b046-4a05-a260-890913e09df9	3	Investment returns	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	14500000	2024-07-03 11:30:00
149	96	101627d7-019e-4a58-b8c0-b30806db3780	4	Rental income	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	7200000	2024-07-04 08:45:00
150	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	5	Dividend income	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	2500000	2024-07-05 10:15:00
151	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	6	Freelance work	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	6800000	2024-07-06 09:30:00
152	96	28905675-858b-4a93-a283-205899779622	7	Royalty payments	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	8500000	2024-07-07 15:00:00
153	96	bd94ba3a-b046-4a05-a260-890913e09df9	8	Research grant	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	5000000	2024-07-08 13:45:00
154	96	101627d7-019e-4a58-b8c0-b30806db3780	9	Performance bonus	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	3100000	2024-07-09 16:00:00
155	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	10	Interest income	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	1300000	2024-07-10 17:30:00
156	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	1	August salary	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	11500000	2024-07-11 09:00:00
157	96	28905675-858b-4a93-a283-205899779622	2	Marketing services	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	5500000	2024-07-12 14:00:00
158	96	bd94ba3a-b046-4a05-a260-890913e09df9	3	Real estate income	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	12500000	2024-07-13 11:30:00
159	96	101627d7-019e-4a58-b8c0-b30806db3780	4	Office lease	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	7300000	2024-07-14 08:45:00
160	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	5	Dividend from shares	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	2600000	2024-07-15 10:15:00
161	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	6	Business consulting	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	6700000	2024-07-16 09:30:00
162	96	28905675-858b-4a93-a283-205899779622	7	Book royalties	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	8800000	2024-07-17 15:00:00
163	96	bd94ba3a-b046-4a05-a260-890913e09df9	8	Educational grants	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	4900000	2024-07-18 13:45:00
164	96	101627d7-019e-4a58-b8c0-b30806db3780	9	Annual bonuses	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	3200000	2024-07-19 16:00:00
165	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	10	Interest on deposits	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	1200000	2024-07-20 17:30:00
166	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	1	September salary	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	11800000	2024-07-21 09:00:00
167	96	28905675-858b-4a93-a283-205899779622	2	Freelance services	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	5600000	2024-07-22 14:00:00
168	96	bd94ba3a-b046-4a05-a260-890913e09df9	3	Investment returns	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	13500000	2024-07-23 11:30:00
169	96	101627d7-019e-4a58-b8c0-b30806db3780	4	Commercial rent	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	7400000	2024-07-24 08:45:00
170	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	5	Equity dividends	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	2700000	2024-07-25 10:15:00
171	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	6	Business income	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	6900000	2024-07-26 09:30:00
172	96	28905675-858b-4a93-a283-205899779622	7	Music royalties	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	9100000	2024-07-27 15:00:00
173	96	bd94ba3a-b046-4a05-a260-890913e09df9	8	Government grants	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	5300000	2024-07-28 13:45:00
174	96	101627d7-019e-4a58-b8c0-b30806db3780	9	Holiday bonuses	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	3400000	2024-07-29 16:00:00
176	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	1	October salary	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	12200000	2024-08-01 09:00:00
177	96	28905675-858b-4a93-a283-205899779622	2	Freelance work	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	5700000	2024-08-02 14:00:00
178	96	bd94ba3a-b046-4a05-a260-890913e09df9	3	Stock investments	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	14000000	2024-08-03 11:30:00
179	96	101627d7-019e-4a58-b8c0-b30806db3780	4	Lease income	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	7500000	2024-08-04 08:45:00
180	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	5	Dividend earnings	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	2800000	2024-08-05 10:15:00
181	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	6	Consulting fees	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	7000000	2024-08-06 09:30:00
182	96	28905675-858b-4a93-a283-205899779622	7	Royalty income	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	9200000	2024-08-07 15:00:00
183	96	bd94ba3a-b046-4a05-a260-890913e09df9	8	Research income	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	5400000	2024-08-08 13:45:00
184	96	101627d7-019e-4a58-b8c0-b30806db3780	9	Annual bonus	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	3500000	2024-08-09 16:00:00
185	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	10	Interest on savings	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	1700000	2024-08-10 17:30:00
186	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	1	November salary	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	12500000	2024-08-11 09:00:00
187	96	28905675-858b-4a93-a283-205899779622	2	Freelance consulting	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	5800000	2024-08-12 14:00:00
188	96	bd94ba3a-b046-4a05-a260-890913e09df9	3	Real estate investment	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	15000000	2024-08-13 11:30:00
189	96	101627d7-019e-4a58-b8c0-b30806db3780	4	Rental revenue	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	7600000	2024-08-14 08:45:00
190	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	5	Equity dividends	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	2900000	2024-08-15 10:15:00
191	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	6	Business income	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	7100000	2024-08-16 09:30:00
192	96	28905675-858b-4a93-a283-205899779622	7	Music royalties	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	9300000	2024-08-17 15:00:00
193	96	bd94ba3a-b046-4a05-a260-890913e09df9	8	Grants received	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	5500000	2024-08-18 13:45:00
194	96	101627d7-019e-4a58-b8c0-b30806db3780	9	End-of-year bonuses	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	3600000	2024-08-19 16:00:00
195	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	10	Interest earned	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	1800000	2024-08-20 17:30:00
196	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	1	December salary	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	12700000	2024-08-21 09:00:00
197	96	28905675-858b-4a93-a283-205899779622	2	Freelance services	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	5900000	2024-08-22 14:00:00
198	96	bd94ba3a-b046-4a05-a260-890913e09df9	3	Stocks and bonds	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	15500000	2024-08-23 11:30:00
199	96	101627d7-019e-4a58-b8c0-b30806db3780	4	Lease income	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	7700000	2024-08-24 08:45:00
200	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	5	Share dividends	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	3000000	2024-08-25 10:15:00
201	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	6	Consulting revenue	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	7200000	2024-08-26 09:30:00
202	96	28905675-858b-4a93-a283-205899779622	7	Royalty fees	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	9400000	2024-08-27 15:00:00
203	96	bd94ba3a-b046-4a05-a260-890913e09df9	8	Scholarship grants	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	5600000	2024-08-28 13:45:00
204	96	101627d7-019e-4a58-b8c0-b30806db3780	9	Bonus payments	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	3700000	2024-08-29 16:00:00
205	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	10	Interest from savings	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	1900000	2024-08-30 17:30:00
206	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	1	January salary	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	13000000	2024-09-01 09:00:00
207	96	28905675-858b-4a93-a283-205899779622	2	Consulting services	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	6000000	2024-09-02 14:00:00
208	96	bd94ba3a-b046-4a05-a260-890913e09df9	3	Investment gains	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	16000000	2024-09-03 11:30:00
209	96	101627d7-019e-4a58-b8c0-b30806db3780	4	Rental income	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	7800000	2024-09-04 08:45:00
210	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	5	Dividend income	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	3100000	2024-09-05 10:15:00
211	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	6	Business income	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	7300000	2024-09-06 09:30:00
212	96	28905675-858b-4a93-a283-205899779622	7	Royalty income	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	9500000	2024-09-07 15:00:00
213	96	bd94ba3a-b046-4a05-a260-890913e09df9	8	Research grants	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	5700000	2024-09-08 13:45:00
214	96	101627d7-019e-4a58-b8c0-b30806db3780	9	Annual bonuses	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	3800000	2024-09-09 16:00:00
215	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	10	Interest earnings	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	2000000	2024-09-10 17:30:00
216	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	1	February salary	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	13500000	2024-09-11 09:00:00
217	96	28905675-858b-4a93-a283-205899779622	2	Freelance work	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	6100000	2024-09-12 14:00:00
218	96	bd94ba3a-b046-4a05-a260-890913e09df9	3	Stocks investments	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	16500000	2024-09-13 11:30:00
219	96	101627d7-019e-4a58-b8c0-b30806db3780	4	Lease income	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	7900000	2024-09-14 08:45:00
220	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	5	Share dividends	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	3200000	2024-09-15 10:15:00
221	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	6	Consulting revenue	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	7400000	2024-09-16 09:30:00
222	96	28905675-858b-4a93-a283-205899779622	7	Royalty payments	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	9600000	2024-09-17 15:00:00
223	96	bd94ba3a-b046-4a05-a260-890913e09df9	8	Educational grants	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	5800000	2024-09-18 13:45:00
224	96	101627d7-019e-4a58-b8c0-b30806db3780	9	Bonus payments	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	3900000	2024-09-19 16:00:00
225	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	10	Interest from savings	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	2100000	2024-09-20 17:30:00
226	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	1	March salary	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	14000000	2024-09-21 09:00:00
227	96	28905675-858b-4a93-a283-205899779622	2	Consulting services	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	6200000	2024-09-22 14:00:00
228	96	bd94ba3a-b046-4a05-a260-890913e09df9	3	Investment returns	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	17000000	2024-09-23 11:30:00
229	96	101627d7-019e-4a58-b8c0-b30806db3780	4	Rental revenue	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	8000000	2024-09-24 08:45:00
230	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	5	Equity dividends	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	3300000	2024-09-25 10:15:00
231	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	6	Business consulting	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	7500000	2024-09-26 09:30:00
232	96	28905675-858b-4a93-a283-205899779622	7	Music royalties	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	9700000	2024-09-27 15:00:00
233	96	bd94ba3a-b046-4a05-a260-890913e09df9	8	Research grants	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	5900000	2024-09-28 13:45:00
234	96	101627d7-019e-4a58-b8c0-b30806db3780	9	Year-end bonuses	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	4000000	2024-09-29 16:00:00
235	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	10	Interest income	2024-07-22 17:01:40.733541	2024-07-22 17:01:40.733541	2200000	2024-09-30 17:30:00
236	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	1	Salary	2024-07-22 17:22:40.250468	2024-07-22 17:22:40.250468	5000000	2024-01-05 10:00:00
237	96	28905675-858b-4a93-a283-205899779622	2	Services	2024-07-22 17:22:40.250468	2024-07-22 17:22:40.250468	3000000	2024-01-15 11:00:00
238	96	bd94ba3a-b046-4a05-a260-890913e09df9	3	Investments	2024-07-22 17:22:40.250468	2024-07-22 17:22:40.250468	4500000	2024-01-25 12:00:00
239	96	101627d7-019e-4a58-b8c0-b30806db3780	4	Rent	2024-07-22 17:22:40.250468	2024-07-22 17:22:40.250468	6000000	2024-02-02 13:00:00
240	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	5	Dividends	2024-07-22 17:22:40.250468	2024-07-22 17:22:40.250468	3500000	2024-02-10 14:00:00
241	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	6	Consulting fees	2024-07-22 17:22:40.250468	2024-07-22 17:22:40.250468	5500000	2024-02-20 15:00:00
242	96	28905675-858b-4a93-a283-205899779622	7	Royalties	2024-07-22 17:22:40.250468	2024-07-22 17:22:40.250468	7000000	2024-03-01 16:00:00
243	96	bd94ba3a-b046-4a05-a260-890913e09df9	8	Grants	2024-07-22 17:22:40.250468	2024-07-22 17:22:40.250468	8000000	2024-03-10 17:00:00
244	96	101627d7-019e-4a58-b8c0-b30806db3780	9	Bonuses	2024-07-22 17:22:40.250468	2024-07-22 17:22:40.250468	6500000	2024-03-15 18:00:00
245	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	10	Interest	2024-07-22 17:22:40.250468	2024-07-22 17:22:40.250468	9000000	2024-04-01 19:00:00
246	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	1	Salary	2024-07-22 17:22:40.250468	2024-07-22 17:22:40.250468	5000000	2024-04-10 20:00:00
247	96	28905675-858b-4a93-a283-205899779622	2	Services	2024-07-22 17:22:40.250468	2024-07-22 17:22:40.250468	3200000	2024-04-20 21:00:00
248	96	bd94ba3a-b046-4a05-a260-890913e09df9	3	Investments	2024-07-22 17:22:40.250468	2024-07-22 17:22:40.250468	4700000	2024-05-01 22:00:00
249	96	101627d7-019e-4a58-b8c0-b30806db3780	4	Rent	2024-07-22 17:22:40.250468	2024-07-22 17:22:40.250468	6100000	2024-05-10 23:00:00
250	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	5	Dividends	2024-07-22 17:22:40.250468	2024-07-22 17:22:40.250468	3600000	2024-05-20 14:00:00
251	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	6	Consulting fees	2024-07-22 17:22:40.250468	2024-07-22 17:22:40.250468	5600000	2024-06-01 15:00:00
252	96	28905675-858b-4a93-a283-205899779622	7	Royalties	2024-07-22 17:22:40.250468	2024-07-22 17:22:40.250468	7200000	2024-06-10 16:00:00
253	96	bd94ba3a-b046-4a05-a260-890913e09df9	8	Grants	2024-07-22 17:22:40.250468	2024-07-22 17:22:40.250468	8100000	2024-06-20 17:00:00
254	96	101627d7-019e-4a58-b8c0-b30806db3780	9	Bonuses	2024-07-22 17:22:40.250468	2024-07-22 17:22:40.250468	6600000	2024-07-01 18:00:00
255	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	10	Interest	2024-07-22 17:22:40.250468	2024-07-22 17:22:40.250468	9100000	2024-07-10 19:00:00
256	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	1	Salary	2024-07-22 17:22:40.250468	2024-07-22 17:22:40.250468	5100000	2024-07-15 20:00:00
257	96	28905675-858b-4a93-a283-205899779622	2	Services	2024-07-22 17:22:40.250468	2024-07-22 17:22:40.250468	3300000	2024-07-20 21:00:00
258	96	bd94ba3a-b046-4a05-a260-890913e09df9	3	Investments	2024-07-22 17:22:40.250468	2024-07-22 17:22:40.250468	4800000	2024-07-22 22:00:00
259	96	101627d7-019e-4a58-b8c0-b30806db3780	4	Rent	2024-07-22 17:22:40.250468	2024-07-22 17:22:40.250468	6200000	2024-07-23 23:00:00
260	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	5	Dividends	2024-07-22 17:22:40.250468	2024-07-22 17:22:40.250468	3700000	2024-07-24 14:00:00
261	96	db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	6	Consulting fees	2024-07-22 17:22:40.250468	2024-07-22 17:22:40.250468	5700000	2024-07-25 15:00:00
262	96	28905675-858b-4a93-a283-205899779622	7	Royalties	2024-07-22 17:22:40.250468	2024-07-22 17:22:40.250468	7300000	2024-07-26 16:00:00
264	96	101627d7-019e-4a58-b8c0-b30806db3780	9	Bonuses	2024-07-22 17:22:40.250468	2024-07-22 17:22:40.250468	6700000	2024-07-28 18:00:00
266	96	28905675-858b-4a93-a283-205899779622	2		2024-07-26 00:43:42.977894	2024-07-26 00:43:42.977894	10000	2024-07-26 00:39:17.272
267	96	101627d7-019e-4a58-b8c0-b30806db3780	1		2024-07-26 00:55:45.880939	2024-07-26 00:55:45.880939	100000	2024-07-26 00:39:17.272
268	96	101627d7-019e-4a58-b8c0-b30806db3780	1		2024-07-26 00:57:20.538614	2024-07-26 00:57:20.538614	10000	2024-07-26 00:39:17.272
77	96	28905675-858b-4a93-a283-205899779622	5		2024-07-09 18:06:38.893626	2024-07-26 01:51:50.576783	10000000	2024-07-26 01:51:32.352
90	96	101627d7-019e-4a58-b8c0-b30806db3780	1	Performance bonuses	2024-07-22 16:59:25.475315	2024-08-01 07:22:14.124665	300000000	2024-07-26 02:24:11.647
269	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	2		2024-08-01 06:05:58.328629	2024-08-01 07:23:36.670175	1000000000	2024-08-01 06:05:37.875
175	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	7	Interest from savings	2024-07-22 17:01:40.733541	2024-08-01 07:24:21.083543	1600000	2024-08-01 07:23:55.612
265	96	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	9	Interest	2024-07-22 17:22:40.250468	2024-08-01 07:28:45.09049	9200000	2024-08-01 07:28:38.621
263	96	bd94ba3a-b046-4a05-a260-890913e09df9	6	Grants	2024-07-22 17:22:40.250468	2024-08-01 07:29:42.620472	8200000	2024-08-01 07:29:35.892
270	96	bd94ba3a-b046-4a05-a260-890913e09df9	2	string	2024-08-01 13:53:00.920624	2024-08-01 15:26:45.755264	5000	2024-07-31 18:23:01.7
\.


--
-- TOC entry 4238 (class 0 OID 17790)
-- Dependencies: 256
-- Data for Name: finance_income_source; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.finance_income_source (id_family, id_income_source, income_source_name, income_source_name_vn) FROM stdin;
96	1	Salary	Lương
96	2	Services	Dịch vụ
96	3	Investments	Đầu tư
96	4	Rent	Thuê
96	5	Dividends	Cổ tức
96	6	Consulting fees	Phí tư vấn
96	7	Royalties	Tiền bản quyền
96	8	Grants	Tài trợ
96	9	Bonuses	Thưởng
96	10	Interest	Lãi suất
117	132	Salary	Lương
117	133	Services	Dịch vụ
117	134	Investments	Đầu tư
117	135	Rent	Thuê
117	136	Dividends	Cổ tức
117	137	Consulting fees	Phí tư vấn
117	138	Royalties	Tiền bản quyền
117	139	Grants	Tài trợ
117	140	Bonuses	Thưởng
117	141	Interest	Lãi suất
\.


--
-- TOC entry 4240 (class 0 OID 17794)
-- Dependencies: 258
-- Data for Name: financial_summary; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.financial_summary (id_summary, id_family, summary_date, total_income, total_expenditure, daily_balance, weekly_balance, monthly_balance, yearly_balance, current_balance) FROM stdin;
5	97	2024-06-15	0.00	0.00	0.00	0.00	0.00	0.00	0.00
4	96	2024-04-22	2266561263.37	195240172.35	0.00	0.00	0.00	0.00	2071321091.02
\.


--
-- TOC entry 4242 (class 0 OID 17805)
-- Dependencies: 260
-- Data for Name: flow_watermarks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.flow_watermarks (slot, watermark) FROM stdin;
flow_slot	867d6263-976c-430f-8b1b-e798e96787d3
\.


--
-- TOC entry 4306 (class 0 OID 24700)
-- Dependencies: 327
-- Data for Name: frequently_question; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.frequently_question (id, question, answer, answer_vn, is_active, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4244 (class 0 OID 17820)
-- Dependencies: 262
-- Data for Name: household_consumable_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.household_consumable_items (id_household_item, quantity, threshold, expired_date) FROM stdin;
13	10	1	2024-04-29
6	5	5	2022-12-31
21	5	5	2022-12-31
37	0	0	\N
41	0	0	\N
44	0	0	\N
\.


--
-- TOC entry 4245 (class 0 OID 17823)
-- Dependencies: 263
-- Data for Name: household_durable_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.household_durable_items (id_household_item, condition) FROM stdin;
7	new
9	new
10	new
11	good
8	poor
6	good
24	good
45	good
\.


--
-- TOC entry 4246 (class 0 OID 17826)
-- Dependencies: 264
-- Data for Name: household_item_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.household_item_categories (id_household_item_category, category_name) FROM stdin;
1	Kitchen
2	Living Room
3	Bedroom
4	Bathroom
5	Home Office
6	Garage/Utility
7	Laundry Room
8	Outdoor and Garden
\.


--
-- TOC entry 4210 (class 0 OID 17525)
-- Dependencies: 228
-- Data for Name: household_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.household_items (id_household_item, id_family, item_name, id_category, id_room, description, item_imageurl, created_at, updated_at) FROM stdin;
6	96	tủ lạnh cùi	1	5	\N	\N	2024-07-09 14:07:23.841572	2024-07-09 14:07:23.841572
7	96	tủ lạnh cùi	1	4	\N	\N	2024-07-09 14:07:23.841572	2024-07-09 14:07:23.841572
8	96	tủ lạnh cùi	1	6	\N	\N	2024-07-09 14:07:23.841572	2024-07-09 14:07:23.841572
9	96	tủ lạnh cùi	1	6	\N	\N	2024-07-09 14:07:23.841572	2024-07-09 14:07:23.841572
10	96	tủ lạnh cùi	1	5	\N	\N	2024-07-09 14:07:23.841572	2024-07-09 14:07:23.841572
11	96	eulaaaaa	1	5	\N	\N	2024-07-09 14:07:23.841572	2024-07-09 14:07:23.841572
13	96	Adudu	2	6	\N	\N	2024-07-09 14:07:23.841572	2024-07-09 14:07:23.841572
19	96	adu dark	1	4	hi	https://storage.googleapis.com/famfund-bucket/household/household_bd94ba3a-b046-4a05-a260-890913e09df9_1719946811858	2024-07-09 14:07:23.841572	2024-07-09 14:07:23.841572
20	96	adu dark	1	4	hi	https://storage.googleapis.com/famfund-bucket/household/household_bd94ba3a-b046-4a05-a260-890913e09df9_1719946859432	2024-07-09 14:07:23.841572	2024-07-09 14:07:23.841572
21	96	adu dark	1	4	hi	https://storage.googleapis.com/famfund-bucket/household/household_bd94ba3a-b046-4a05-a260-890913e09df9_1719947053908	2024-07-09 14:07:23.841572	2024-07-09 14:07:23.841572
24	96	Giường	2	8	Giường	https://storage.googleapis.com/famfund-bucket/household/household_bd94ba3a-b046-4a05-a260-890913e09df9_1720710826053	2024-07-11 15:11:47.149963	2024-07-11 15:13:47.950407
37	96	Cái bàn phím	3	4	Bàn phím rẻ tiền cho macbook	\N	2024-07-27 18:34:17.193108	2024-07-27 18:34:17.193108
41	96	cục đất	1	23	\N	https://storage.googleapis.com/famfund-bucket/household/household_bd94ba3a-b046-4a05-a260-890913e09df9_1722345909008	2024-07-30 13:25:09.314605	2024-07-30 13:25:09.314605
44	96	Giuong	1	5	\N	https://storage.googleapis.com/famfund-bucket/household/household_bd94ba3a-b046-4a05-a260-890913e09df9_1722413705060	2024-07-31 08:15:05.669839	2024-07-31 08:15:05.669839
45	96	Giuong	3	5	haha	https://storage.googleapis.com/famfund-bucket/household/household_bd94ba3a-b046-4a05-a260-890913e09df9_1722413746708	2024-07-31 08:15:47.052412	2024-07-31 08:15:47.052412
\.


--
-- TOC entry 4250 (class 0 OID 17832)
-- Dependencies: 268
-- Data for Name: invoice; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.invoice (id_invoice, id_family, id_invoice_type, invoice_date, total_amount, description, imageurl, created_at, updated_at, invoice_name, tax_amount, amount) FROM stdin;
4	96	3	2024-05-16	8850000.00		https://storage.googleapis.com/famfund-bucket/invoice/invoice_bd94ba3a-b046-4a05-a260-890913e09df9_1715876244572_paper-cash-sell-receipt-vector-23876532.jpg	2024-05-16 16:17:25.60858+00	2024-06-22 04:02:41.431962+00	cái này test chơi chơi	0.00	8850000.00
\.


--
-- TOC entry 4252 (class 0 OID 17842)
-- Dependencies: 270
-- Data for Name: invoice_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.invoice_items (id_item, id_invoice, item_description, quantity, unit_price, item_name) FROM stdin;
6	4	thúi quắc luôn á pa	1	1100000.00	cái quần xì thúi
7	4	thúi quắc luôn á pa	1	1100000.00	cái quần xì thúi
8	4	thúi quắc luôn á pa	1	1100000.00	cái quần xì thúi
9	4	thúi quắc luôn á pa	1	1100000.00	cái quần xì thúi
10	4	thúi quắc luôn á pa	1	1100000.00	cái quần xì thúi
11	4	thúi quắc luôn á pa	1	1100000.00	cái quần xì thúi
12	4	thúi quắc luôn á pa	2	1100000.00	cái quần xì thúi
13	4	test	1	50000.00	test
\.


--
-- TOC entry 4254 (class 0 OID 17849)
-- Dependencies: 272
-- Data for Name: invoice_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.invoice_type (id_invoice_type, type_name, id_family) FROM stdin;
1	Electricity	97
2	Electricity	98
3	Electricity	99
4	Electricity	96
5	Water	97
6	Water	98
7	Water	99
8	Water	96
14	Restaurant	96
23	Electricity	100
24	Water	100
27	Electricity	101
28	Water	101
\.


--
-- TOC entry 4205 (class 0 OID 17454)
-- Dependencies: 222
-- Data for Name: member_family; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.member_family (id_user, id_family, created_at, updated_at, id, role, id_family_role) FROM stdin;
e4334118-dfef-4e5e-bfad-6a5db2e10d0b	97	2024-07-25 16:23:44.493251	2024-07-25 16:23:44.493251	20	\N	1
bd94ba3a-b046-4a05-a260-890913e09df9	117	2024-08-01 17:11:24.387926	2024-08-02 00:33:24.551915	36	Owner	3
bd94ba3a-b046-4a05-a260-890913e09df9	96	2024-07-31 01:58:35.443741	2024-08-02 00:35:42.417223	27	Member	8
e4334118-dfef-4e5e-bfad-6a5db2e10d0b	96	2024-07-25 16:22:36.919622	2024-08-02 00:37:46.224185	19	\N	2
9e153f4a-7c30-4e6f-a1bd-157a6eea5885	96	2024-07-31 06:52:38.284406	2024-08-02 00:37:59.786611	35	Member	36
\.


--
-- TOC entry 4261 (class 0 OID 17863)
-- Dependencies: 279
-- Data for Name: order; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."order" (id_family, status, id_package_main, id_package_extra, id_package_combo, method, created_at, updated_at, id_order, id_user, price, bank_code) FROM stdin;
96	SUCCESS	1	\N	\N	VNPAY	2024-07-02 16:40:05.647755	2024-07-02 16:49:10.502759	51512296-614b-43cc-a1b5-79db2141d09f	bd94ba3a-b046-4a05-a260-890913e09df9	500000	NCB
2	SUCCESS	2	\N	\N	VNPAY	2024-06-30 09:50:17.20457	2024-06-30 09:51:18.836028	95876c1b-6768-4541-b24b-6438318a59a0	bd94ba3a-b046-4a05-a260-890913e09df9	500000	NCB
\N	PENDING	1	\N	\N	VNPAY	2024-06-30 14:54:00.848099	2024-06-30 14:54:00.848099	9cf2566a-95c5-456a-9797-29ecf08a8098	bd94ba3a-b046-4a05-a260-890913e09df9	500000	NCB
\N	PENDING	2	\N	\N	VNPAY	2024-06-30 15:01:29.051036	2024-06-30 15:01:29.051036	a779df89-79d7-49a1-bb78-662d9a5fdf3b	bd94ba3a-b046-4a05-a260-890913e09df9	500000	NCB
2	SUCCESS	\N	\N	2	VNPAY	2024-06-30 09:26:59.244941	2024-06-30 09:47:08.598681	b59c04e5-92b2-4930-a467-bee39f29a0ee	bd94ba3a-b046-4a05-a260-890913e09df9	500000	NCB
96	SUCCESS	1	\N	\N	VNPAY	2024-06-26 15:44:06.643473	2024-06-30 09:47:08.598681	cac8b2cc-44c7-4718-8573-529cf540f346	bd94ba3a-b046-4a05-a260-890913e09df9	500000	NCB
2	SUCCESS	2	\N	\N	VNPAY	2024-06-28 17:09:11.372065	2024-06-30 09:47:08.598681	10ad93c1-650c-496c-a7f9-45ae6aa4b252	bd94ba3a-b046-4a05-a260-890913e09df9	500000	NCB
\N	PENDING	1	\N	\N	VNPAY	2024-07-04 09:10:40.05161	2024-07-04 09:10:40.05161	0022997c-e21e-4205-9c6d-acf77f486f46	bd94ba3a-b046-4a05-a260-890913e09df9	500000	string
\N	PENDING	1	\N	\N	VNPAY	2024-07-04 09:11:30.94786	2024-07-04 09:11:30.94786	2d2e7915-515c-4d40-9720-2b6fd0075a3b	bd94ba3a-b046-4a05-a260-890913e09df9	500000	VNB
\N	PENDING	1	\N	\N	VNPAY	2024-07-04 09:12:19.253319	2024-07-04 09:12:19.253319	4fbd91bf-2f44-4706-8de0-8eecb3d5b174	bd94ba3a-b046-4a05-a260-890913e09df9	500000	NCB
\N	PENDING	1	\N	\N	VNPAY	2024-07-04 09:21:15.348354	2024-07-04 09:21:15.348354	0185a5ef-664e-4482-9b22-075e1afcd0bc	bd94ba3a-b046-4a05-a260-890913e09df9	500000	NCB
\N	PENDING	1	\N	\N	VNPAY	2024-07-04 09:22:46.651012	2024-07-04 09:22:46.651012	2b5b52d1-6e5e-45ce-8598-6eb0191cc3d1	bd94ba3a-b046-4a05-a260-890913e09df9	500000	NCB
\N	PENDING	1	\N	\N	VNPAY	2024-07-04 09:43:44.151641	2024-07-04 09:43:44.151641	e703522e-af51-4d82-a353-7d414e4cf7fc	bd94ba3a-b046-4a05-a260-890913e09df9	500000	NCB
\N	PENDING	\N	1	\N	VNPAY	2024-07-04 09:48:28.151067	2024-07-04 09:48:28.151067	034dd055-143e-455d-a6a3-f79419ff4791	bd94ba3a-b046-4a05-a260-890913e09df9	500000	NCB
\N	PENDING	\N	1	\N	VNPAY	2024-07-04 09:49:25.952603	2024-07-04 09:49:25.952603	531350c7-2585-49b7-9800-dd68979ab65f	bd94ba3a-b046-4a05-a260-890913e09df9	500000	NCB
\N	PENDING	\N	1	\N	VNPAY	2024-07-04 09:50:13.750431	2024-07-04 09:50:13.750431	5a8aa00d-bc8f-48d8-bb4b-2522780802d2	bd94ba3a-b046-4a05-a260-890913e09df9	500000	NCB
\N	PENDING	\N	1	\N	VNPAY	2024-07-04 09:51:25.548496	2024-07-04 09:51:25.548496	c2296429-88d6-4c14-8ac5-9973c1fe9108	bd94ba3a-b046-4a05-a260-890913e09df9	500000	NCB
\N	PENDING	\N	1	\N	VNPAY	2024-07-04 16:24:18.748712	2024-07-04 16:24:18.748712	84af561d-7013-4348-8862-863b66cb472c	bd94ba3a-b046-4a05-a260-890913e09df9	500000	NCB
\N	PENDING	\N	1	\N	VNPAY	2024-07-04 16:35:26.847916	2024-07-04 16:35:26.847916	3198dfd5-b9bc-4760-97f8-c436a03b9f7a	bd94ba3a-b046-4a05-a260-890913e09df9	500000	NCB
96	PENDING	\N	1	\N	VNPAY	2024-07-24 10:52:53.149292	2024-07-24 10:52:53.149292	17370482-21b3-47bd-9f3e-fd14efc1bdf6	28905675-858b-4a93-a283-205899779622	500000	NCB
96	PENDING	\N	1	\N	VNPAY	2024-07-25 04:14:00.62566	2024-07-25 04:14:00.62566	db781554-fd2d-4a85-a0db-36b56c519d9b	28905675-858b-4a93-a283-205899779622	500000	VPB
96	PENDING	\N	1	\N	VNPAY	2024-07-25 04:14:08.646078	2024-07-25 04:14:08.646078	e5fa31a1-4493-4747-8311-c663df5ce8db	28905675-858b-4a93-a283-205899779622	500000	BIDV
96	PENDING	\N	1	\N	VNPAY	2024-07-25 14:49:07.091909	2024-07-25 14:49:07.091909	a42a1203-af6f-4db4-a8e3-c09608e731b1	28905675-858b-4a93-a283-205899779622	500000	BIDV
96	PENDING	\N	1	\N	VNPAY	2024-07-26 07:10:13.049939	2024-07-26 07:10:13.049939	746782c2-cd18-4a63-9c8a-800cafa34506	28905675-858b-4a93-a283-205899779622	500000	BIDV
96	PENDING	\N	\N	2	VNPAY	2024-07-26 07:14:02.60007	2024-07-26 07:14:02.60007	8647c69a-6dd9-4c6e-aa07-9fe372f1bcd0	28905675-858b-4a93-a283-205899779622	250000	OCB
\N	PENDING	\N	\N	2	VNPAY	2024-07-26 07:14:15.230666	2024-07-26 07:14:15.230666	0e54e163-769b-40f0-b6fb-5e8615a36f96	28905675-858b-4a93-a283-205899779622	250000	VBA
\N	PENDING	\N	\N	2	VNPAY	2024-07-26 07:14:21.214835	2024-07-26 07:14:21.214835	c6957073-d7de-4917-baa0-b1b18f2d6da0	28905675-858b-4a93-a283-205899779622	250000	NCB
96	PENDING	\N	\N	2	VNPAY	2024-07-27 09:43:35.285847	2024-07-27 09:43:35.285847	bf8286df-53b9-4e6d-ac31-498e2f19dc09	28905675-858b-4a93-a283-205899779622	250000	BIDV
96	PENDING	\N	\N	2	VNPAY	2024-07-29 04:16:22.526323	2024-07-29 04:16:22.526323	551a4d41-1501-4c57-8252-32073ef34004	bd94ba3a-b046-4a05-a260-890913e09df9	250000	NCB
\N	PENDING	\N	\N	2	VNPAY	2024-07-29 14:46:01.507821	2024-07-29 14:46:01.507821	209d2337-617f-4a3f-95a4-8e76c8266c28	bd94ba3a-b046-4a05-a260-890913e09df9	250000	NCB
96	PENDING	\N	\N	2	VNPAY	2024-07-29 14:46:25.163197	2024-07-29 14:46:25.163197	d3552966-e49a-4a8c-84e8-8217aeb5a796	bd94ba3a-b046-4a05-a260-890913e09df9	250000	NCB
\N	PENDING	\N	3	\N	VNPAY	2024-07-30 08:23:31.394672	2024-07-30 08:23:31.394672	2d5aa6f7-8bac-4d81-808e-e312c1b4beaa	bd94ba3a-b046-4a05-a260-890913e09df9	50000	NCB
\N	PENDING	\N	3	\N	VNPAY	2024-07-30 08:24:52.842818	2024-07-30 08:24:52.842818	38ccacc4-ca8a-4031-be89-e4aec58c2770	bd94ba3a-b046-4a05-a260-890913e09df9	50000	NCB
\N	PENDING	\N	3	\N	VNPAY	2024-07-30 08:25:35.050439	2024-07-30 08:25:35.050439	f23216aa-c4ab-4e7a-95e9-7a48ac80993c	bd94ba3a-b046-4a05-a260-890913e09df9	50000	NCB
\N	PENDING	\N	3	\N	VNPAY	2024-07-30 08:26:43.006175	2024-07-30 08:26:43.006175	d70bef82-77ca-408a-b6eb-e74a5cbbb113	bd94ba3a-b046-4a05-a260-890913e09df9	50000	NCB
\N	PENDING	\N	3	\N	VNPAY	2024-07-30 08:27:31.500068	2024-07-30 08:27:31.500068	fce8b4f0-cadc-418d-bf60-e5b715746530	bd94ba3a-b046-4a05-a260-890913e09df9	50000	NCB
\N	PENDING	\N	3	\N	VNPAY	2024-07-30 08:28:06.659529	2024-07-30 08:28:06.659529	13ae0603-9674-4a5b-909a-cb4529c19c70	bd94ba3a-b046-4a05-a260-890913e09df9	50000	NCB
\N	PENDING	\N	3	\N	VNPAY	2024-07-30 08:29:07.216013	2024-07-30 08:29:07.216013	a5a5f2ad-5e80-4592-9006-c63b86c210ff	bd94ba3a-b046-4a05-a260-890913e09df9	50000	NCB
\N	PENDING	\N	3	\N	VNPAY	2024-07-30 08:29:55.258625	2024-07-30 08:29:55.258625	22acd57f-de8b-4a8b-9229-942d2f7f288d	bd94ba3a-b046-4a05-a260-890913e09df9	50000	NCB
\N	PENDING	\N	3	\N	VNPAY	2024-07-30 08:30:17.682792	2024-07-30 08:30:17.682792	0064df4e-8ba6-41ad-833b-39b569c2692c	bd94ba3a-b046-4a05-a260-890913e09df9	50000	NCB
\N	PENDING	\N	3	\N	VNPAY	2024-07-30 08:31:06.991685	2024-07-30 08:31:06.991685	9937fb5b-dc46-47b3-afc4-5b3c0e7b936a	bd94ba3a-b046-4a05-a260-890913e09df9	50000	NCB
\N	PENDING	\N	3	\N	VNPAY	2024-07-30 08:31:18.181485	2024-07-30 08:31:18.181485	716dd5e4-e8f8-4f9a-babc-2fefe9adc736	bd94ba3a-b046-4a05-a260-890913e09df9	50000	NCB
\N	PENDING	1	\N	\N	VNPAY	2024-07-30 08:33:05.232044	2024-07-30 08:33:05.232044	3d702f87-8ab3-4109-8f8a-e9eb267875fd	bd94ba3a-b046-4a05-a260-890913e09df9	100000	NCB
\N	PENDING	1	\N	\N	VNPAY	2024-07-30 08:33:41.25069	2024-07-30 08:33:41.25069	eceb504f-7504-4224-b77e-4fa5459b19f0	bd94ba3a-b046-4a05-a260-890913e09df9	100000	NCB
\N	PENDING	1	\N	\N	VNPAY	2024-07-30 08:35:51.16287	2024-07-30 08:35:51.16287	f916751e-9811-48dc-ba6d-68bdc69fac3d	bd94ba3a-b046-4a05-a260-890913e09df9	100000	NCB
\N	PENDING	\N	\N	2	VNPAY	2024-07-30 08:40:28.250391	2024-07-30 08:40:28.250391	a01b0b91-63ec-451f-8e69-211fcaae9963	bd94ba3a-b046-4a05-a260-890913e09df9	250000	NCB
\N	PENDING	\N	\N	2	VNPAY	2024-07-30 09:02:02.357606	2024-07-30 09:02:02.357606	9b1cb77e-e778-4b35-a4d0-f5f9390f18ee	bd94ba3a-b046-4a05-a260-890913e09df9	250000	NCB
\N	PENDING	\N	\N	2	VNPAY	2024-07-30 09:30:48.909054	2024-07-30 09:30:48.909054	467971f9-59a9-4eac-8f89-3563ce9531d2	bd94ba3a-b046-4a05-a260-890913e09df9	250000	NCB
\N	PENDING	\N	\N	2	VNPAY	2024-07-30 09:43:34.112802	2024-07-30 09:43:34.112802	c45eba73-237c-442b-846e-d6bb8d2a25f8	bd94ba3a-b046-4a05-a260-890913e09df9	250000	NCB
\N	PENDING	1	\N	\N	VNPAY	2024-07-30 13:08:17.292142	2024-07-30 13:08:17.292142	ac34a6c3-e4ad-4453-86b9-3d4f893c7636	bd94ba3a-b046-4a05-a260-890913e09df9	100000	NCB
\N	PENDING	1	\N	\N	VNPAY	2024-07-30 13:22:12.65852	2024-07-30 13:22:12.65852	03252fe8-29a4-42c4-9243-850c073c66fe	bd94ba3a-b046-4a05-a260-890913e09df9	100000	NCB
\N	PENDING	2	\N	\N	VNPAY	2024-07-30 14:47:01.392463	2024-07-30 14:47:01.392463	a1cbdc1d-b8e1-4a4e-bde0-2cd169ecb49d	bd94ba3a-b046-4a05-a260-890913e09df9	200000	NCB
\N	PENDING	1	\N	\N	VNPAY	2024-07-30 23:04:57.402222	2024-07-30 23:04:57.402222	d9b0c8d7-d32e-4c33-9521-93634aa2187c	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	100000	NCB
\N	PENDING	1	\N	\N	VNPAY	2024-07-30 23:06:50.490269	2024-07-30 23:06:50.490269	ffd0cb84-efa1-41bd-be34-36b5c3241431	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	100000	NCB
\N	PENDING	1	\N	\N	VNPAY	2024-07-30 23:07:00.223587	2024-07-30 23:07:00.223587	ad213543-1737-4be4-abf9-47d98495c013	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	100000	NCB
96	SUCCESS	1	\N	\N	VNPAY	2024-07-31 06:31:56.826283	2024-07-31 06:32:51.157309	d129affe-0588-45ea-905c-0e5b9661736b	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	100000	NCB
96	SUCCESS	1	\N	\N	VNPAY	2024-07-31 06:33:13.40406	2024-07-31 06:33:54.477058	47fca40a-feda-4a95-bb5e-22ce73791c10	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	100000	NCB
\N	PENDING	2	\N	\N	VNPAY	2024-07-31 08:10:08.684763	2024-07-31 08:10:08.684763	3788f596-d533-4bda-b19c-a6df591968ca	bd94ba3a-b046-4a05-a260-890913e09df9	200000	VBA
\N	PENDING	2	\N	\N	VNPAY	2024-07-31 08:10:17.530609	2024-07-31 08:10:17.530609	d602aa52-4e78-40b8-b781-bc505a4ecc9e	bd94ba3a-b046-4a05-a260-890913e09df9	200000	ACB
96	PENDING	1	\N	\N	VNPAY	2024-07-31 08:26:26.244713	2024-07-31 08:26:26.244713	50a9a6dd-6e33-42be-bf26-9531920c8012	bd94ba3a-b046-4a05-a260-890913e09df9	100000	MB
\N	PENDING	3	\N	\N	VNPAY	2024-07-31 08:26:44.577511	2024-07-31 08:26:44.577511	adda609a-69a7-4cf3-8761-2a341350686c	bd94ba3a-b046-4a05-a260-890913e09df9	70000	ACB
\N	PENDING	1	\N	\N	VNPAY	2024-08-01 04:42:22.831617	2024-08-01 04:42:22.831617	9cc64f00-4758-4bf3-8971-1983879aefde	bd94ba3a-b046-4a05-a260-890913e09df9	100000	NCB
96	PENDING	2	\N	\N	VNPAY	2024-08-01 04:52:29.399833	2024-08-01 04:52:29.399833	e139137c-3dfc-48af-a22e-68b5f98978f3	bd94ba3a-b046-4a05-a260-890913e09df9	200000	OCB
117	PENDING	\N	2	\N	VNPAY	2024-08-02 00:20:44.266455	2024-08-02 00:20:44.266455	124a8575-9a9a-469a-897d-bf5fe0ac4e00	bd94ba3a-b046-4a05-a260-890913e09df9	50000	NCB
117	SUCCESS	1	\N	\N	VNPAY	2024-08-01 04:43:19.536858	2024-08-01 17:11:25.830804	55264d5c-6733-4947-863b-5589b63c89b1	bd94ba3a-b046-4a05-a260-890913e09df9	100000	NCB
\N	PENDING	1	\N	\N	VNPAY	2024-08-02 00:21:26.053731	2024-08-02 00:21:26.053731	425aa909-1f6c-45c3-9f65-843f254b1b20	bd94ba3a-b046-4a05-a260-890913e09df9	100000	string
\N	PENDING	1	\N	\N	VNPAY	2024-08-02 00:21:40.635886	2024-08-02 00:21:40.635886	d053b4c4-b46e-48a4-9634-28c63b8c883a	bd94ba3a-b046-4a05-a260-890913e09df9	100000	NCB
117	PENDING	\N	5	\N	VNPAY	2024-08-02 00:23:45.874003	2024-08-02 00:23:45.874003	c0dd7f81-f1d3-4ffe-a1ae-940ac88fb486	bd94ba3a-b046-4a05-a260-890913e09df9	50000	NCB
\N	PENDING	1	\N	\N	VNPAY	2024-08-02 00:24:41.767993	2024-08-02 00:24:41.767993	37b3104b-12c2-43b3-b301-785e272baafd	bd94ba3a-b046-4a05-a260-890913e09df9	100000	NCB
\.


--
-- TOC entry 4265 (class 0 OID 17876)
-- Dependencies: 283
-- Data for Name: otp; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.otp (id_otp, id_user, code, created_at, updated_at, expired_at, email, phone, type) FROM stdin;
1	cf723e9f-f75a-4b94-9634-43880f326743	156801	2024-07-24 15:27:18.03069	2024-07-24 15:27:18.03069	\N	banhhaotoan2002@gmail.com	\N	reset_password
3	e05be2ad-8a6b-433d-8dd4-65efb36d4318	918950	2024-07-26 07:48:05.55332	2024-07-26 07:48:05.55332	\N	tthien20@clc.fitus.edu.vn	\N	reset_password
4	e05be2ad-8a6b-433d-8dd4-65efb36d4318	222886	2024-07-26 07:57:03.999004	2024-07-26 07:57:03.999004	\N	tthien20@clc.fitus.edu.vn	\N	reset_password
5	2082eded-d0bd-46a5-a62d-1bed3839a6e9	438698	2024-07-26 16:44:01.564169	2024-07-26 16:44:01.564169	\N	phamgiangthaiduong1@gmail.com	\N	reset_password
6	2082eded-d0bd-46a5-a62d-1bed3839a6e9	310556	2024-07-27 00:38:36.609736	2024-07-27 00:38:36.609736	\N	phamgiangthaiduong1@gmail.com	\N	reset_password
7	2082eded-d0bd-46a5-a62d-1bed3839a6e9	748331	2024-07-27 00:54:35.00028	2024-07-27 00:54:35.00028	\N	phamgiangthaiduong1@gmail.com	\N	reset_password
8	2082eded-d0bd-46a5-a62d-1bed3839a6e9	678044	2024-07-27 02:11:19.156551	2024-07-27 02:11:19.156551	\N	phamgiangthaiduong1@gmail.com	\N	reset_password
9	2082eded-d0bd-46a5-a62d-1bed3839a6e9	703843	2024-07-27 02:13:08.152259	2024-07-27 02:13:08.152259	\N	phamgiangthaiduong1@gmail.com	\N	reset_password
10	2082eded-d0bd-46a5-a62d-1bed3839a6e9	591451	2024-07-27 02:25:56.108645	2024-07-27 02:25:56.108645	\N	phamgiangthaiduong1@gmail.com	\N	reset_password
11	2082eded-d0bd-46a5-a62d-1bed3839a6e9	748212	2024-07-27 02:27:04.531041	2024-07-27 02:27:04.531041	\N	phamgiangthaiduong1@gmail.com	\N	reset_password
12	2082eded-d0bd-46a5-a62d-1bed3839a6e9	317099	2024-07-27 02:29:10.77655	2024-07-27 02:29:10.77655	\N	phamgiangthaiduong1@gmail.com	\N	reset_password
13	2082eded-d0bd-46a5-a62d-1bed3839a6e9	394458	2024-07-27 02:29:44.463664	2024-07-27 02:29:44.463664	\N	phamgiangthaiduong1@gmail.com	\N	reset_password
14	2082eded-d0bd-46a5-a62d-1bed3839a6e9	757993	2024-07-27 03:09:26.13195	2024-07-27 03:09:26.13195	\N	phamgiangthaiduong1@gmail.com	\N	reset_password
15	2082eded-d0bd-46a5-a62d-1bed3839a6e9	521778	2024-07-27 03:29:35.257773	2024-07-27 03:29:35.257773	\N	phamgiangthaiduong1@gmail.com	\N	reset_password
16	2082eded-d0bd-46a5-a62d-1bed3839a6e9	935872	2024-07-27 03:31:44.565706	2024-07-27 03:31:44.565706	\N	phamgiangthaiduong1@gmail.com	\N	reset_password
17	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	309783	2024-07-27 12:27:39.74368	2024-07-27 12:27:39.74368	\N	duongthanhgiang.0108@gmail.com	\N	reset_password
18	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	986195	2024-07-27 12:55:06.362968	2024-07-27 12:55:06.362968	\N	duongthanhgiang.0108@gmail.com	\N	reset_password
19	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	325569	2024-07-27 13:10:48.623671	2024-07-27 13:10:48.623671	\N	duongthanhgiang.0108@gmail.com	\N	reset_password
20	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	361124	2024-07-27 13:13:38.936889	2024-07-27 13:13:38.936889	\N	duongthanhgiang.0108@gmail.com	\N	reset_password
21	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	784982	2024-07-27 13:17:43.445041	2024-07-27 13:17:43.445041	\N	duongthanhgiang.0108@gmail.com	\N	reset_password
22	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	924226	2024-07-27 13:18:37.684082	2024-07-27 13:18:37.684082	\N	duongthanhgiang.0108@gmail.com	\N	reset_password
23	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	884894	2024-07-27 13:19:17.40457	2024-07-27 13:19:17.40457	\N	duongthanhgiang.0108@gmail.com	\N	reset_password
24	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	932813	2024-07-27 13:19:59.138645	2024-07-27 13:19:59.138645	\N	duongthanhgiang.0108@gmail.com	\N	reset_password
25	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	925124	2024-07-27 13:26:43.807378	2024-07-27 13:26:43.807378	\N	duongthanhgiang.0108@gmail.com	\N	reset_password
26	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	570503	2024-07-27 13:36:08.837348	2024-07-27 13:36:08.837348	\N	duongthanhgiang.0108@gmail.com	\N	reset_password
27	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	702023	2024-07-27 13:41:29.456074	2024-07-27 13:41:29.456074	\N	duongthanhgiang.0108@gmail.com	\N	reset_password
28	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	982714	2024-07-27 13:45:17.324066	2024-07-27 13:45:17.324066	\N	duongthanhgiang.0108@gmail.com	\N	reset_password
29	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	959615	2024-07-27 13:48:51.371342	2024-07-27 13:48:51.371342	\N	duongthanhgiang.0108@gmail.com	\N	reset_password
30	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	646509	2024-07-27 14:05:43.954708	2024-07-27 14:05:43.954708	\N	duongthanhgiang.0108@gmail.com	\N	reset_password
31	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	182000	2024-07-27 16:46:59.391586	2024-07-27 16:46:59.391586	\N	duongthanhgiang.0108@gmail.com	\N	reset_password
32	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	847302	2024-07-27 16:53:21.706045	2024-07-27 16:53:21.706045	\N	duongthanhgiang.0108@gmail.com	\N	reset_password
33	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	286625	2024-07-27 17:05:25.23743	2024-07-27 17:05:25.23743	\N	duongthanhgiang.0108@gmail.com	\N	reset_password
34	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	724330	2024-07-27 17:07:47.737975	2024-07-27 17:07:47.737975	\N	duongthanhgiang.0108@gmail.com	\N	reset_password
35	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	896137	2024-07-27 17:11:06.385376	2024-07-27 17:11:06.385376	\N	duongthanhgiang.0108@gmail.com	\N	reset_password
36	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	256991	2024-07-27 17:15:03.696082	2024-07-27 17:15:03.696082	\N	duongthanhgiang.0108@gmail.com	\N	reset_password
37	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	337720	2024-07-27 17:18:19.9181	2024-07-27 17:18:19.9181	\N	duongthanhgiang.0108@gmail.com	\N	reset_password
38	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	581627	2024-07-27 17:37:27.007738	2024-07-27 17:37:27.007738	\N	duongthanhgiang.0108@gmail.com	\N	reset_password
39	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	749739	2024-07-27 17:39:52.167191	2024-07-27 17:39:52.167191	\N	duongthanhgiang.0108@gmail.com	\N	reset_password
40	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	458251	2024-07-27 17:50:52.565832	2024-07-27 17:50:52.565832	\N	duongthanhgiang.0108@gmail.com	\N	reset_password
41	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	239283	2024-07-27 17:54:17.337318	2024-07-27 17:54:17.337318	\N	duongthanhgiang.0108@gmail.com	\N	reset_password
42	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	795039	2024-07-27 17:59:34.958516	2024-07-27 17:59:34.958516	\N	duongthanhgiang.0108@gmail.com	\N	reset_password
43	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	515149	2024-07-27 18:03:03.052088	2024-07-27 18:03:03.052088	\N	duongthanhgiang.0108@gmail.com	\N	reset_password
44	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	350489	2024-07-27 18:12:54.111224	2024-07-27 18:12:54.111224	\N	duongthanhgiang.0108@gmail.com	\N	reset_password
45	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	830691	2024-07-27 18:14:07.314678	2024-07-27 18:14:07.314678	\N	duongthanhgiang.0108@gmail.com	\N	reset_password
46	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	370346	2024-07-27 18:23:08.965079	2024-07-27 18:23:08.965079	\N	duongthanhgiang.0108@gmail.com	\N	reset_password
47	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	659881	2024-07-27 18:24:50.821059	2024-07-27 18:24:50.821059	\N	duongthanhgiang.0108@gmail.com	\N	reset_password
48	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	869302	2024-07-27 18:25:57.422424	2024-07-27 18:25:57.422424	\N	duongthanhgiang.0108@gmail.com	\N	reset_password
49	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	159608	2024-07-27 18:26:33.319254	2024-07-27 18:26:33.319254	\N	duongthanhgiang.0108@gmail.com	\N	reset_password
52	bd94ba3a-b046-4a05-a260-890913e09df9	422850	2024-07-28 11:15:22.604001	2024-07-28 11:15:22.604001	\N	banhhaotoan2002@gmail.com	\N	validate_account
54	bd94ba3a-b046-4a05-a260-890913e09df9	238103	2024-07-28 11:15:28.722965	2024-07-28 11:15:28.722965	\N	banhhaotoan2002@gmail.com	\N	validate_account
55	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	694179	2024-07-28 16:34:59.290271	2024-07-28 16:34:59.290271	\N	duongthanhgiang.0108@gmail.com	\N	reset_password
56	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	137297	2024-07-28 17:19:28.039028	2024-07-28 17:19:28.039028	\N	duongthanhgiang.0108@gmail.com	\N	reset_password
57	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	579301	2024-07-28 19:18:41.571486	2024-07-28 19:18:41.571486	\N	\N	+84982900108	validate_account
59	f3cb40a0-a576-40ad-b2ee-d2f5b44d5070	728032	2024-07-29 00:09:36.791235	2024-07-29 00:09:36.791235	\N	dtgiang.cv@gmail.com	\N	validate_account
60	f3cb40a0-a576-40ad-b2ee-d2f5b44d5070	404533	2024-07-29 00:17:22.703536	2024-07-29 00:17:22.703536	\N	dtgiang.cv@gmail.com	\N	validate_account
62	eac98f28-a97e-4b4f-981c-3c7e7c546664	337154	2024-07-29 00:24:12.300214	2024-07-29 00:24:12.300214	\N	dtgiang.cv@gmail.com	\N	validate_account
63	eac98f28-a97e-4b4f-981c-3c7e7c546664	122000	2024-07-29 00:27:51.251196	2024-07-29 00:27:51.251196	\N	dtgiang.cv@gmail.com	\N	validate_account
64	27cabf67-e851-452d-a135-84a9b9e06392	973857	2024-07-29 00:30:04.171334	2024-07-29 00:30:04.171334	\N	duongthanhgiang0.0108@gmail.com	\N	validate_account
65	4365ffab-b1be-4354-90b3-24652ecdfaf3	232583	2024-07-29 00:37:00.874695	2024-07-29 00:37:00.874695	\N	duongthanhgiang0.0108@gmail.com	\N	validate_account
66	4365ffab-b1be-4354-90b3-24652ecdfaf3	287307	2024-07-29 00:39:15.431293	2024-07-29 00:39:15.431293	\N	duongthanhgiang0.0108@gmail.com	\N	validate_account
67	4365ffab-b1be-4354-90b3-24652ecdfaf3	993647	2024-07-29 00:43:17.468468	2024-07-29 00:43:17.468468	\N	duongthanhgiang0.0108@gmail.com	\N	validate_account
68	4365ffab-b1be-4354-90b3-24652ecdfaf3	375947	2024-07-29 00:46:31.858919	2024-07-29 00:46:31.858919	\N	duongthanhgiang0.0108@gmail.com	\N	validate_account
71	28a399c7-b9b9-4ac0-93fb-197bc9ea7ef6	906571	2024-07-29 03:17:19.443174	2024-07-29 03:17:19.443174	\N	duongthanhgiang0.0108@gmail.com	\N	validate_account
72	28a399c7-b9b9-4ac0-93fb-197bc9ea7ef6	140320	2024-07-29 03:29:46.253773	2024-07-29 03:29:46.253773	\N	duongthanhgiang0.0108@gmail.com	\N	validate_account
73	23860743-99d4-49c3-aee6-681132222a8f	760970	2024-07-29 03:31:56.289094	2024-07-29 03:31:56.289094	\N	duongthanhgiang0.0108@gmail.com	\N	validate_account
74	23860743-99d4-49c3-aee6-681132222a8f	881719	2024-07-29 03:33:54.190378	2024-07-29 03:33:54.190378	\N	duongthanhgiang0.0108@gmail.com	\N	validate_account
75	23860743-99d4-49c3-aee6-681132222a8f	452358	2024-07-29 03:35:09.41005	2024-07-29 03:35:09.41005	\N	duongthanhgiang0.0108@gmail.com	\N	validate_account
76	23860743-99d4-49c3-aee6-681132222a8f	939787	2024-07-29 03:37:40.427831	2024-07-29 03:37:40.427831	\N	duongthanhgiang0.0108@gmail.com	\N	validate_account
77	b8a4c543-d479-4371-b60f-9b83419c5ad3	634950	2024-07-29 03:42:20.357783	2024-07-29 03:42:20.357783	\N	duongthanhgiang.0108@gmail.com	\N	validate_account
78	b8a4c543-d479-4371-b60f-9b83419c5ad3	893538	2024-07-29 03:48:17.159049	2024-07-29 03:48:17.159049	\N	duongthanhgiang.0108@gmail.com	\N	validate_account
79	b8a4c543-d479-4371-b60f-9b83419c5ad3	712566	2024-07-29 03:56:16.227815	2024-07-29 03:56:16.227815	\N	duongthanhgiang.0108@gmail.com	\N	validate_account
80	b8a4c543-d479-4371-b60f-9b83419c5ad3	267985	2024-07-29 03:56:44.201359	2024-07-29 03:56:44.201359	\N	duongthanhgiang.0108@gmail.com	\N	validate_account
81	23860743-99d4-49c3-aee6-681132222a8f	558353	2024-07-29 04:03:53.647721	2024-07-29 04:03:53.647721	\N	duongthanhgiang0.0108@gmail.com	\N	validate_account
82	23860743-99d4-49c3-aee6-681132222a8f	781439	2024-07-29 14:25:35.348823	2024-07-29 14:25:35.348823	\N	duongthanhgiang0.0108@gmail.com	\N	validate_account
83	23860743-99d4-49c3-aee6-681132222a8f	775559	2024-07-29 18:29:46.526876	2024-07-29 18:29:46.526876	\N	duongthanhgiang0.0108@gmail.com	\N	validate_account
84	23860743-99d4-49c3-aee6-681132222a8f	540940	2024-07-29 18:30:45.09707	2024-07-29 18:30:45.09707	\N	duongthanhgiang0.0108@gmail.com	\N	validate_account
85	23860743-99d4-49c3-aee6-681132222a8f	386880	2024-07-29 18:31:54.069377	2024-07-29 18:31:54.069377	\N	duongthanhgiang0.0108@gmail.com	\N	validate_account
86	23860743-99d4-49c3-aee6-681132222a8f	152357	2024-07-29 18:39:24.20177	2024-07-29 18:39:24.20177	\N	duongthanhgiang0.0108@gmail.com	\N	validate_account
87	880c52ce-ef78-42dc-9a71-d175d4d8a437	495973	2024-07-29 18:56:42.686106	2024-07-29 18:56:42.686106	\N	dtgiang20@clc.fitus.edu.vn	\N	validate_account
88	386e7ca1-cbe5-4a61-8b1b-8e31643d6cc6	516480	2024-07-29 18:57:04.425692	2024-07-29 18:57:04.425692	\N	dtgiang20@clc.fitus.edu.vn	\N	validate_account
89	386e7ca1-cbe5-4a61-8b1b-8e31643d6cc6	415545	2024-07-29 18:57:17.759137	2024-07-29 18:57:17.759137	\N	dtgiang20@clc.fitus.edu.vn	\N	validate_account
90	b8a4c543-d479-4371-b60f-9b83419c5ad3	182712	2024-07-29 19:03:33.488123	2024-07-29 19:03:33.488123	\N	duongthanhgiang.0108@gmail.com	\N	validate_account
91	b8a4c543-d479-4371-b60f-9b83419c5ad3	373327	2024-07-29 19:03:56.041278	2024-07-29 19:03:56.041278	\N	duongthanhgiang.0108@gmail.com	\N	validate_account
92	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	927668	2024-07-29 19:08:48.327887	2024-07-29 19:08:48.327887	\N	\N	+84982900108	validate_account
93	b8a4c543-d479-4371-b60f-9b83419c5ad3	212324	2024-07-29 19:09:11.656614	2024-07-29 19:09:11.656614	\N	duongthanhgiang.0108@gmail.com	\N	validate_account
95	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	556785	2024-07-29 19:50:55.748327	2024-07-29 19:50:55.748327	\N	\N	+84982900108	validate_account
96	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	333747	2024-07-29 19:50:56.525865	2024-07-29 19:50:56.525865	\N	\N	+84982900108	validate_account
97	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	129283	2024-07-29 19:51:19.644777	2024-07-29 19:51:19.644777	\N	\N	+84982900108	validate_account
98	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	575660	2024-07-29 19:55:14.076127	2024-07-29 19:55:14.076127	\N	\N	+84982900108	validate_account
99	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	907945	2024-07-29 19:56:11.820875	2024-07-29 19:56:11.820875	\N	\N	+84982900108	validate_account
102	c691514e-5e9c-4995-9938-15952b462363	194813	2024-07-30 10:43:10.583368	2024-07-30 10:43:10.583368	\N	duongthanhgiang@yopmail.com	\N	reset_password
103	c691514e-5e9c-4995-9938-15952b462363	935749	2024-07-30 10:46:22.140376	2024-07-30 10:46:22.140376	\N	duongthanhgiang@yopmail.com	\N	reset_password
104	e4334118-dfef-4e5e-bfad-6a5db2e10d0b	875343	2024-07-30 11:26:30.346119	2024-07-30 11:26:30.346119	\N	duongthanhgiang.0108@gmail.com	\N	reset_password
105	c691514e-5e9c-4995-9938-15952b462363	381149	2024-07-30 11:26:47.343617	2024-07-30 11:26:47.343617	\N	duongthanhgiang@yopmail.com	\N	reset_password
106	c691514e-5e9c-4995-9938-15952b462363	819029	2024-07-30 11:39:48.84018	2024-07-30 11:39:48.84018	\N	duongthanhgiang@yopmail.com	\N	reset_password
107	c691514e-5e9c-4995-9938-15952b462363	995051	2024-07-30 11:43:23.148186	2024-07-30 11:43:23.148186	\N	duongthanhgiang@yopmail.com	\N	reset_password
108	c691514e-5e9c-4995-9938-15952b462363	760777	2024-07-30 11:48:35.892683	2024-07-30 11:48:35.892683	\N	duongthanhgiang@yopmail.com	\N	reset_password
109	c691514e-5e9c-4995-9938-15952b462363	160902	2024-07-30 11:48:49.974332	2024-07-30 11:48:49.974332	\N	duongthanhgiang@yopmail.com	\N	reset_password
110	2082eded-d0bd-46a5-a62d-1bed3839a6e9	105815	2024-07-30 11:54:07.620399	2024-07-30 11:54:07.620399	\N	phamgiangthaiduong1@gmail.com	\N	reset_password
111	c691514e-5e9c-4995-9938-15952b462363	735016	2024-07-30 11:55:26.758038	2024-07-30 11:55:26.758038	\N	duongthanhgiang@yopmail.com	\N	reset_password
112	c691514e-5e9c-4995-9938-15952b462363	933924	2024-07-30 11:55:49.147972	2024-07-30 11:55:49.147972	\N	duongthanhgiang@yopmail.com	\N	reset_password
113	c691514e-5e9c-4995-9938-15952b462363	411421	2024-07-30 11:56:03.57276	2024-07-30 11:56:03.57276	\N	duongthanhgiang@yopmail.com	\N	reset_password
114	2082eded-d0bd-46a5-a62d-1bed3839a6e9	113787	2024-07-30 11:56:12.575444	2024-07-30 11:56:12.575444	\N	phamgiangthaiduong1@gmail.com	\N	reset_password
115	2082eded-d0bd-46a5-a62d-1bed3839a6e9	709033	2024-07-30 12:02:32.991516	2024-07-30 12:02:32.991516	\N	phamgiangthaiduong1@gmail.com	\N	reset_password
116	c691514e-5e9c-4995-9938-15952b462363	966793	2024-07-30 12:03:45.670656	2024-07-30 12:03:45.670656	\N	duongthanhgiang@yopmail.com	\N	reset_password
\.


--
-- TOC entry 4269 (class 0 OID 17887)
-- Dependencies: 287
-- Data for Name: package_combo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.package_combo (id_combo_package, name, description, is_active, created_at, updated_at, price, name_vn) FROM stdin;
2	All packages	updated description	t	2024-06-16 09:40:25.950774	2024-07-03 16:08:31.891039	250000	Đầy đủ chức năng
\.


--
-- TOC entry 4271 (class 0 OID 17897)
-- Dependencies: 289
-- Data for Name: package_combo_package_extra; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.package_combo_package_extra (package_combo_id, package_extra_id) FROM stdin;
2	1
2	2
2	3
2	4
2	5
2	7
\.


--
-- TOC entry 4272 (class 0 OID 17900)
-- Dependencies: 290
-- Data for Name: package_extra; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.package_extra (id_extra_package, name, description, is_active, created_at, updated_at, price, name_vn) FROM stdin;
1	Calendar	Organize schedules effectively using services that provide event management, scheduling, and reminder features across various devices.	t	2024-06-16 08:28:47.212061	2024-06-23 10:12:11.682549	50000	Lập lịch
2	Guideline	Optimize household devices	t	2024-06-16 08:28:58.879556	2024-06-16 08:28:58.879556	50000	Hướng dẫn nhau
3	Education	Monitor educational progress	t	2024-06-16 08:29:05.370068	2024-06-16 08:29:05.370068	50000	Giáo dục
4	Finance	Finance involves managing income and expenses to ensure financial stability and prosperity within a household.	t	2024-06-16 08:29:11.82842	2024-06-16 08:29:11.82842	50000	Tài chính
5	Shopping	\N	t	2024-06-16 08:29:19.706657	2024-06-16 08:29:19.706657	50000	Mua sắm
7	Household	Household management focuses on organizing and maintaining household items and activities to create a well-ordered and efficient living environment.	t	2024-06-16 08:29:30.928406	2024-06-26 12:27:17.43813	50000	Vật dụng gia đình
\.


--
-- TOC entry 4274 (class 0 OID 17910)
-- Dependencies: 292
-- Data for Name: package_main; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.package_main (id_main_package, name, description, is_active, duration_months, created_at, updated_at, price, name_vn) FROM stdin;
1	Basic	 Provides a 3-month subscription plan.	t	3	2024-06-15 18:17:54.972062	2024-06-15 18:17:54.972062	100000	Gói cơ bản
2	Premium	 Offers the highest-tier package with a 6-month subscription duration.	t	6	2024-06-15 18:18:24.565244	2024-06-22 16:28:32.072219	200000	Gói cao cấp
3	Recommend for first try	 Includes a 1-month trial period for initial users.	t	1	2024-06-15 18:19:43.860005	2024-06-23 04:59:32.54623	70000	Gói khuyên dùng
\.


--
-- TOC entry 4276 (class 0 OID 17920)
-- Dependencies: 294
-- Data for Name: payment_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment_history (id_payment_history, payment_method, created_at, id_user, type, amount, id_order) FROM stdin;
3	VNPAY	2024-06-30 09:51:19.192463	bd94ba3a-b046-4a05-a260-890913e09df9	main	50000000	95876c1b-6768-4541-b24b-6438318a59a0
4	VNPAY	2024-07-02 16:49:10.861416	bd94ba3a-b046-4a05-a260-890913e09df9	main	50000000	51512296-614b-43cc-a1b5-79db2141d09f
5	VNPAY	2024-07-31 06:32:51.190107	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	main	100000	d129affe-0588-45ea-905c-0e5b9661736b
6	VNPAY	2024-07-31 06:33:54.518557	9e153f4a-7c30-4e6f-a1bd-157a6eea5885	main	100000	47fca40a-feda-4a95-bb5e-22ce73791c10
7	VNPAY	2024-08-01 17:11:26.057415	bd94ba3a-b046-4a05-a260-890913e09df9	main	100000	55264d5c-6733-4947-863b-5589b63c89b1
\.


--
-- TOC entry 4278 (class 0 OID 17928)
-- Dependencies: 296
-- Data for Name: payment_method; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment_method (id, name, code, url_image) FROM stdin;
\.


--
-- TOC entry 4282 (class 0 OID 17936)
-- Dependencies: 300
-- Data for Name: refresh_token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.refresh_token (refresh_token, id_user, created_at, expired_at, id) FROM stdin;
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE1ODMyODIsImV4cCI6MTcyMTg0MjQ4Mn0.QFbTi00d60jGI_6o6v-VSu6cNm-zkwHzcA2VrWNPOps	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-21 17:34:42.487608	2024-07-22 17:34:42	1008
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNTg0ODIxLCJleHAiOjE3MjE4NDQwMjF9.5nHYv_a4DLrvkbtAJA3W-uu2xL00YXZ4-LOW86a_QHc	28905675-858b-4a93-a283-205899779622	2024-07-21 18:00:21.53106	2024-07-22 18:00:21	1009
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE1ODUxNzUsImV4cCI6MTcyMTg0NDM3NX0.-0bkdnv2fN_3t5uQ3JvcqD5l33aQ7vmw7mzUc-CdouM	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-21 18:06:15.769872	2024-07-22 18:06:15	1010
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE1ODU3NDIsImV4cCI6MTcyMTg0NDk0Mn0.--0DKsaupcBfsGVP_Wgv1oS5aVELi6qhi4oKQrRb_qQ	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-21 18:15:42.253245	2024-07-22 18:15:42	1011
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE2MjQ1MjksImV4cCI6MTcyMTg4MzcyOX0.QgWWgGyvDGI8rkJsnu9AP1B0fEajuOklCAHV1R0Uh20	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-22 05:02:09.37746	2024-07-23 05:02:09	1044
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE2Mjk0ODgsImV4cCI6MTcyMTg4ODY4OH0.-O7lEX62NC0xWT_iQnKEcwQsEFM3-TObUAHmlzR27wQ	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-22 06:24:48.314155	2024-07-23 06:24:48	1045
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE2Mjk2MDksImV4cCI6MTcyMTg4ODgwOX0.OUbF0wtUYVQMHW4l2_iJsCzpN9T8H7rQAv-nTeeKfms	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-22 06:26:49.419807	2024-07-23 06:26:49	1046
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE2Mjk2MzQsImV4cCI6MTcyMTg4ODgzNH0.HZiF6uq5Eb5D0pPhBtsVFW7hbwbl-PwRgRiGtuhyUcU	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-22 06:27:14.613723	2024-07-23 06:27:14	1047
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE2Mjk2MzcsImV4cCI6MTcyMTg4ODgzN30.-c_8tIgr4UixkDwweBLpsL_tZ2cKhsBIbxm44_QEVBs	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-22 06:27:17.155238	2024-07-23 06:27:17	1048
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE2Mjk2MzgsImV4cCI6MTcyMTg4ODgzOH0.qMag4klumslbt-nuATutk5ZUD4rp3183PKbxbgsEJrk	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-22 06:27:18.601796	2024-07-23 06:27:18	1049
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE2Mjk4MDEsImV4cCI6MTcyMTg4OTAwMX0.cO6bZRFF8zaddfs2qu-lBwMeJ0JaCsGhSAD6NqBL9gE	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-22 06:30:01.707182	2024-07-23 06:30:01	1050
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE2NDcxMTMsImV4cCI6MTcyMTkwNjMxM30.heuiXq5-KTxYSpNom--mM0LgBJQqqrAWdCsjPQtKhbU	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-22 11:18:33.165523	2024-07-23 11:18:33	1051
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE2NTIzMDYsImV4cCI6MTcyMTkxMTUwNn0.gIz_uHV5ZC828VzwFzlD0TGb-WLTtwmUzfOX3oRXjtY	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-22 12:45:06.557913	2024-07-23 12:45:06	1052
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjUyNjM5LCJleHAiOjE3MjE5MTE4Mzl9.JPGeNj3gG-o9Uc6PEkOZ5M-twWeDViUbErBa0YUQExA	28905675-858b-4a93-a283-205899779622	2024-07-22 12:50:39.892706	2024-07-23 12:50:39	1053
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjUyNjQwLCJleHAiOjE3MjE5MTE4NDB9.fzxzss0XGQeky3LYZuBplfANcvhAoFw8Pb6JKMhZjko	28905675-858b-4a93-a283-205899779622	2024-07-22 12:50:40.043208	2024-07-23 12:50:40	1054
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE2NTI3MTIsImV4cCI6MTcyMTkxMTkxMn0.cr0YtPObLi-UsuKVYb25pkpfTl9JV5MG-QRpNGz27rM	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-22 12:51:52.678532	2024-07-23 12:51:52	1055
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE2NTI4MjgsImV4cCI6MTcyMTkxMjAyOH0.sm0kVFm0HEM0HV2ohdM-A4mKFGmSanMbrR8D7lQcrAc	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-22 12:53:48.970186	2024-07-23 12:53:48	1056
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE2NTI5NzcsImV4cCI6MTcyMTkxMjE3N30.J96DaOceXoU-ybVSHUurwYxN-DJ6X9RPF4fuwsvnuGk	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-22 12:56:17.120981	2024-07-23 12:56:17	1057
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE2NTMwNjcsImV4cCI6MTcyMTkxMjI2N30.ij1MoMWuCMC5l-dBU5eWAZxineosK1GUKBkfJsgb2aI	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-22 12:57:47.892046	2024-07-23 12:57:47	1058
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjUzMzE2LCJleHAiOjE3MjE5MTI1MTZ9._zvaPSkLUFIEGE7g5WnbZPrfv-7122Aj3s2d506MekE	28905675-858b-4a93-a283-205899779622	2024-07-22 13:01:56.125715	2024-07-23 13:01:56	1059
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjUzMzE2LCJleHAiOjE3MjE5MTI1MTZ9._zvaPSkLUFIEGE7g5WnbZPrfv-7122Aj3s2d506MekE	28905675-858b-4a93-a283-205899779622	2024-07-22 13:01:56.301079	2024-07-23 13:01:56	1060
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjUzNTAzLCJleHAiOjE3MjE5MTI3MDN9.xqn0sLS88yqQLKyBsUEa1TuigMwYtV0AbwSX3zoGaqM	28905675-858b-4a93-a283-205899779622	2024-07-22 13:05:03.028397	2024-07-23 13:05:03	1061
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjUzNTAzLCJleHAiOjE3MjE5MTI3MDN9.xqn0sLS88yqQLKyBsUEa1TuigMwYtV0AbwSX3zoGaqM	28905675-858b-4a93-a283-205899779622	2024-07-22 13:05:03.164678	2024-07-23 13:05:03	1062
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjUzNjAyLCJleHAiOjE3MjE5MTI4MDJ9.NpALtTNo3UGeey03s5JMZ5P09F17CO9di4AVQmohqL8	28905675-858b-4a93-a283-205899779622	2024-07-22 13:06:42.891494	2024-07-23 13:06:42	1063
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE2NTQ5NzgsImV4cCI6MTcyMTkxNDE3OH0.61YgCwI41ykXWvgqt56WadCkwjpT70AWMusA0wXEvV4	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-22 13:29:38.466595	2024-07-23 13:29:38	1064
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE2NTQ5ODEsImV4cCI6MTcyMTkxNDE4MX0.Xn6a_-uFBuj1eewb1VrTQC3porydohUz1ieC_xSs7zU	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-22 13:29:41.474353	2024-07-23 13:29:41	1065
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE2NTU1NTQsImV4cCI6MTcyMTkxNDc1NH0.RwK77CxNEGS7kzvH4m7ESv9WGmbtAId7EW8zi1Xy0Ts	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-22 13:39:14.850336	2024-07-23 13:39:14	1066
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE2NTU2MzUsImV4cCI6MTcyMTkxNDgzNX0.jPnF-F3eGvzlII6GotPQXV0d_lb9uRsn2EHyikgG9z4	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-22 13:40:35.840984	2024-07-23 13:40:35	1067
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE2NTU2NTcsImV4cCI6MTcyMTkxNDg1N30.SRkXKqrI28ATDv1H6kkv9dhHezxbUpUhrQBjzYIjcaI	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-22 13:40:57.308509	2024-07-23 13:40:57	1068
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE2NTU3MTcsImV4cCI6MTcyMTkxNDkxN30.YiB6baM9idUgX4dFnH2NgyxEv8nes8VcVhfsQ_ifsEU	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-22 13:41:57.584994	2024-07-23 13:41:57	1069
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjU1OTcxLCJleHAiOjE3MjE5MTUxNzF9.LX5dixinqpQJOO_7cv6C6YJafRuAPkHfNMae8oBoL7M	28905675-858b-4a93-a283-205899779622	2024-07-22 13:46:11.073214	2024-07-23 13:46:11	1070
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjU2MDA3LCJleHAiOjE3MjE5MTUyMDd9.wGzAGxQXnDv06Xn9WYaq2dJG80lcnfLY9yUWWBljh88	28905675-858b-4a93-a283-205899779622	2024-07-22 13:46:47.957415	2024-07-23 13:46:47	1071
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjU2MDA4LCJleHAiOjE3MjE5MTUyMDh9.Zi0Yx3DGQbvRp8g6sO2yz0Mu_-xz3TiTJXPA22hm0pk	28905675-858b-4a93-a283-205899779622	2024-07-22 13:46:48.051247	2024-07-23 13:46:48	1072
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE2NTYwNDUsImV4cCI6MTcyMTkxNTI0NX0.vO-YegbmuWofTR3m6vKoG3rzZXYcsgzSaLfwE3qSvIk	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-22 13:47:25.868679	2024-07-23 13:47:25	1073
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjU2MTQ2LCJleHAiOjE3MjE5MTUzNDZ9.xe8atHw0sjRLWqUf5M-3nE2zt1cwFafwqyGwwMcNwVo	28905675-858b-4a93-a283-205899779622	2024-07-22 13:49:06.88342	2024-07-23 13:49:06	1074
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjU2MTQ2LCJleHAiOjE3MjE5MTUzNDZ9.xe8atHw0sjRLWqUf5M-3nE2zt1cwFafwqyGwwMcNwVo	28905675-858b-4a93-a283-205899779622	2024-07-22 13:49:06.986407	2024-07-23 13:49:06	1075
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjU2MTkzLCJleHAiOjE3MjE5MTUzOTN9.S6r0nWL6DDutryG8sO-i5iwKNte6klhU2F-KE7cggOA	28905675-858b-4a93-a283-205899779622	2024-07-22 13:49:53.836208	2024-07-23 13:49:53	1076
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjU2MTkzLCJleHAiOjE3MjE5MTUzOTN9.S6r0nWL6DDutryG8sO-i5iwKNte6klhU2F-KE7cggOA	28905675-858b-4a93-a283-205899779622	2024-07-22 13:49:53.947383	2024-07-23 13:49:53	1077
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjU2MzM4LCJleHAiOjE3MjE5MTU1Mzh9.Rbve_0UGfQNyvi_tz2FvijsqHkxe-jdRMzxncITytGA	28905675-858b-4a93-a283-205899779622	2024-07-22 13:52:18.759975	2024-07-23 13:52:18	1078
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE2NTY4MDgsImV4cCI6MTcyMTkxNjAwOH0.vLWRlnJUrpvVyLTLzGs7fVxvqDOuX4_UAboDPvAwAk0	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-22 14:00:08.849044	2024-07-23 14:00:08	1079
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE2NTcxNDksImV4cCI6MTcyMTkxNjM0OX0.6luqkP_JD-czubXz4fQ_wMV5-THTbEJOgReR4cnnYk4	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-22 14:05:49.636334	2024-07-23 14:05:49	1080
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE2NTc4MTYsImV4cCI6MTcyMTkxNzAxNn0.0LGL1kugX3ePremBEG32B10oHxuTkHy3onAZERiTQ4k	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-22 14:16:56.854888	2024-07-23 14:16:56	1081
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE2NTg1MzksImV4cCI6MTcyMTkxNzczOX0.jgArK2u6HfXwx1NILCtnDk7QprqXYo4M_DY1clyzwxc	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-22 14:28:59.113756	2024-07-23 14:28:59	1082
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjU4ODkwLCJleHAiOjE3MjE5MTgwOTB9.vV6E9UD54YBkTOIPLRm84NerePplYj9Gl6GWqq651k0	28905675-858b-4a93-a283-205899779622	2024-07-22 14:34:50.625362	2024-07-23 14:34:50	1083
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjU5MDE3LCJleHAiOjE3MjE5MTgyMTd9.c4qGgbE0Nul3sJ8IJJS6riKTVoTio7twDFKyGMifyKg	28905675-858b-4a93-a283-205899779622	2024-07-22 14:36:57.960315	2024-07-23 14:36:57	1084
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjU5MDE4LCJleHAiOjE3MjE5MTgyMTh9.iHbORiG1E02OnK0Ok7IRx8Xk2blBZMQBarcsH3rQUWE	28905675-858b-4a93-a283-205899779622	2024-07-22 14:36:58.098757	2024-07-23 14:36:58	1085
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjU5NzA0LCJleHAiOjE3MjE5MTg5MDR9.bGqeIGVEM0L_b4H2NjMJj7cyXXVJqFVSoRzb-z5NKmA	28905675-858b-4a93-a283-205899779622	2024-07-22 14:48:24.236635	2024-07-23 14:48:24	1086
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjU5NzA0LCJleHAiOjE3MjE5MTg5MDR9.bGqeIGVEM0L_b4H2NjMJj7cyXXVJqFVSoRzb-z5NKmA	28905675-858b-4a93-a283-205899779622	2024-07-22 14:48:24.382433	2024-07-23 14:48:24	1087
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjU5NzYyLCJleHAiOjE3MjE5MTg5NjJ9.IR53z1uCmfjlNwAn6G37kVtJrrNpIA-qfI-ydDwkmyQ	28905675-858b-4a93-a283-205899779622	2024-07-22 14:49:22.718912	2024-07-23 14:49:22	1088
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjU5NzYzLCJleHAiOjE3MjE5MTg5NjN9.9JkcE4ZchJsF1AgwInMAwe9dF7eaw-qLNtEjRFlwkiQ	28905675-858b-4a93-a283-205899779622	2024-07-22 14:49:23.046582	2024-07-23 14:49:23	1089
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjU5ODA1LCJleHAiOjE3MjE5MTkwMDV9.e1DBeVdCXPwGBHWFAgezztINAQL1MYDj9_UrZdVQ1Rs	28905675-858b-4a93-a283-205899779622	2024-07-22 14:50:05.521327	2024-07-23 14:50:05	1090
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjU5ODA1LCJleHAiOjE3MjE5MTkwMDV9.e1DBeVdCXPwGBHWFAgezztINAQL1MYDj9_UrZdVQ1Rs	28905675-858b-4a93-a283-205899779622	2024-07-22 14:50:05.691553	2024-07-23 14:50:05	1091
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjU5OTAwLCJleHAiOjE3MjE5MTkxMDB9.N4VQrBC7amENyOEjBiLWaMdtFCGZj24iV7SJMhZX4lc	28905675-858b-4a93-a283-205899779622	2024-07-22 14:51:40.868226	2024-07-23 14:51:40	1092
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjU5OTAxLCJleHAiOjE3MjE5MTkxMDF9.BX1dAwgKsa3Z2QD6KosqHdOJNqcxcXDN7SNJGPC2oIQ	28905675-858b-4a93-a283-205899779622	2024-07-22 14:51:41.03947	2024-07-23 14:51:41	1093
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE2NjEwMjIsImV4cCI6MTcyMTkyMDIyMn0.7A16YTn9JTJXO-9E8_kK8lrtBG9InMcn_l8VDaLhHS0	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-22 15:10:22.543673	2024-07-23 15:10:22	1094
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjY2NDY2LCJleHAiOjE3MjE5MjU2NjZ9._aZHEcF5wKCk1FWOzjaYUCtceHOu9ZTVRweaMJ9Fr5k	28905675-858b-4a93-a283-205899779622	2024-07-22 16:41:06.977057	2024-07-23 16:41:06	1095
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjY2NDY3LCJleHAiOjE3MjE5MjU2Njd9.Y6mCsXc9qAQoWf57aARf5WTvHOpBT3QZKNUnOUp7L0U	28905675-858b-4a93-a283-205899779622	2024-07-22 16:41:07.099584	2024-07-23 16:41:07	1096
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjY2NzkzLCJleHAiOjE3MjE5MjU5OTN9.JnF3_vpL4xExkiFQF4sSNwmTuNEfQdIVweX2BgvEQ2I	28905675-858b-4a93-a283-205899779622	2024-07-22 16:46:33.559874	2024-07-23 16:46:33	1097
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjY3MjAxLCJleHAiOjE3MjE5MjY0MDF9.PcY9_e5H220ZQ0E0rDKlUNtCn0ieiTH_kFr_VfuEFP0	28905675-858b-4a93-a283-205899779622	2024-07-22 16:53:21.817727	2024-07-23 16:53:21	1098
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjY3NjE4LCJleHAiOjE3MjE5MjY4MTh9.pXmpNXLEw9-IYn4YIPIdn7QuKPjAQt27NfTeOlttkFE	28905675-858b-4a93-a283-205899779622	2024-07-22 17:00:18.679255	2024-07-23 17:00:18	1099
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjY3NjE4LCJleHAiOjE3MjE5MjY4MTh9.pXmpNXLEw9-IYn4YIPIdn7QuKPjAQt27NfTeOlttkFE	28905675-858b-4a93-a283-205899779622	2024-07-22 17:00:18.886109	2024-07-23 17:00:18	1100
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjY3Njg3LCJleHAiOjE3MjE5MjY4ODd9.HgOqFBBHqGX0idrzyjeBSzx9UfETFwZvbT9JyVGwzQc	28905675-858b-4a93-a283-205899779622	2024-07-22 17:01:27.887445	2024-07-23 17:01:27	1101
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjY3Njg4LCJleHAiOjE3MjE5MjY4ODh9.F_aOPYJXNxxjFBBsUCvra7_CA73FndT5wCdEiBDafww	28905675-858b-4a93-a283-205899779622	2024-07-22 17:01:28.011747	2024-07-23 17:01:28	1102
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE2NzE2NjYsImV4cCI6MTcyMTkzMDg2Nn0.tKpPPEsJXrRe50i5umWU695cC51479klZlvUs2Tsxgc	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-22 18:07:46.771991	2024-07-23 18:07:46	1103
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE2NzE5MDEsImV4cCI6MTcyMTkzMTEwMX0.TIWODLphYVbzI-1bwqDt7Md6ChsJKbLiK4TOjDfVCYs	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-22 18:11:41.540147	2024-07-23 18:11:41	1104
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE2NzI2MzQsImV4cCI6MTcyMTkzMTgzNH0.9JAmPwnkRfRjrXo2NYo-v1C6X0sHkzi_cogYo3wBPlA	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-22 18:23:54.659732	2024-07-23 18:23:54	1105
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE2NzI4MjcsImV4cCI6MTcyMTkzMjAyN30.qEA2wR5f9Bnu3y-QsXccnSz6r8kHOtD6MDKiyKc52zg	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-22 18:27:07.378544	2024-07-23 18:27:07	1106
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE2NzUwMTcsImV4cCI6MTcyMTkzNDIxN30.GE5v5_7oDc73ZLdRPJV7ogJyV_cV1N4Urh10ttFn48Y	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-22 19:03:37.864476	2024-07-23 19:03:37	1107
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE2NzUyMTUsImV4cCI6MTcyMTkzNDQxNX0.sY_ClrXWGzFKQFg9hncPECePVQTJJZMkke5Y4khjAxU	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-22 19:06:55.133335	2024-07-23 19:06:55	1108
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE2OTI0NzUsImV4cCI6MTcyMTk1MTY3NX0._MvxvY_WL3p-T64rYNy-sEw9gXTiRv6fs8xnU-Fw7vA	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-22 23:54:35.388268	2024-07-23 23:54:35	1109
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjkyODQxLCJleHAiOjE3MjE5NTIwNDF9.NHuouqHDnV382FNTXJJQ19eGzMQxAN9khjkvRUUaSKE	28905675-858b-4a93-a283-205899779622	2024-07-23 00:00:42.003028	2024-07-24 00:00:41	1110
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjkyODQyLCJleHAiOjE3MjE5NTIwNDJ9.D_nARQNSr8LYNM4D0BAOgG8Etgvutz11p8TH90GDKlA	28905675-858b-4a93-a283-205899779622	2024-07-23 00:00:42.110436	2024-07-24 00:00:42	1111
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjkyODQyLCJleHAiOjE3MjE5NTIwNDJ9.D_nARQNSr8LYNM4D0BAOgG8Etgvutz11p8TH90GDKlA	28905675-858b-4a93-a283-205899779622	2024-07-23 00:00:42.286353	2024-07-24 00:00:42	1112
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE2OTM5OTgsImV4cCI6MTcyMTk1MzE5OH0.DGsdVYvVkbcSYzmXNVFAWK91FgF_bn66kgtSgkKiUkY	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-23 00:19:58.267848	2024-07-24 00:19:58	1113
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjk0MDI0LCJleHAiOjE3MjE5NTMyMjR9.rlDPnb6LEt4Os1aeTWivQ0la65PUQj9-IR9-z9yFXaE	28905675-858b-4a93-a283-205899779622	2024-07-23 00:20:24.263432	2024-07-24 00:20:24	1114
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjk0NzY4LCJleHAiOjE3MjE5NTM5Njh9.FEC8v8NpGgmTROAUhqV5yX1nR5xN8Pcqa1hLJNQTe90	28905675-858b-4a93-a283-205899779622	2024-07-23 00:32:48.68401	2024-07-24 00:32:48	1115
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjk0NzY4LCJleHAiOjE3MjE5NTM5Njh9.FEC8v8NpGgmTROAUhqV5yX1nR5xN8Pcqa1hLJNQTe90	28905675-858b-4a93-a283-205899779622	2024-07-23 00:32:48.788359	2024-07-24 00:32:48	1116
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjk1NjQ3LCJleHAiOjE3MjE5NTQ4NDd9.DnwH2kis5FJR9A6_1JZ4gY9Xr0Ar5osS9LFEMAQ9IMQ	28905675-858b-4a93-a283-205899779622	2024-07-23 00:47:27.903275	2024-07-24 00:47:27	1117
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjk1NjQ4LCJleHAiOjE3MjE5NTQ4NDh9.pL1GCKX12bgIHPyR8PitU8mIzFs-Ymeo_ZeyQOnGS7c	28905675-858b-4a93-a283-205899779622	2024-07-23 00:47:28.042981	2024-07-24 00:47:28	1118
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjk3ODE4LCJleHAiOjE3MjE5NTcwMTh9._9xWi0I2vXlmDMZTPX9SzlB2ZIOXUDsJU3GLobZqSD8	28905675-858b-4a93-a283-205899779622	2024-07-23 01:23:38.624651	2024-07-24 01:23:38	1119
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNjk3ODE4LCJleHAiOjE3MjE5NTcwMTh9._9xWi0I2vXlmDMZTPX9SzlB2ZIOXUDsJU3GLobZqSD8	28905675-858b-4a93-a283-205899779622	2024-07-23 01:23:38.733293	2024-07-24 01:23:38	1120
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNzAzMDM3LCJleHAiOjE3MjE5NjIyMzd9.A0fZR063v6aB7ThWqbs9Rf3PCPSvaq_QgdVpsCE8elU	28905675-858b-4a93-a283-205899779622	2024-07-23 02:50:37.958466	2024-07-24 02:50:37	1121
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNzAzMDM4LCJleHAiOjE3MjE5NjIyMzh9.8U2LnW50GRqyLmMWWRCu5wmxPp2ad_hgnENyphHoNr4	28905675-858b-4a93-a283-205899779622	2024-07-23 02:50:38.146219	2024-07-24 02:50:38	1122
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNzAzMjU4LCJleHAiOjE3MjE5NjI0NTh9._tfUJBWLUsggtjWKmLJr1V1DeMqf_38F7hHdLWyH_2U	28905675-858b-4a93-a283-205899779622	2024-07-23 02:54:18.031713	2024-07-24 02:54:18	1123
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNzAzMjU4LCJleHAiOjE3MjE5NjI0NTh9._tfUJBWLUsggtjWKmLJr1V1DeMqf_38F7hHdLWyH_2U	28905675-858b-4a93-a283-205899779622	2024-07-23 02:54:18.137632	2024-07-24 02:54:18	1124
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNzA0MDgyLCJleHAiOjE3MjE5NjMyODJ9.BiLcdHK_-fgq7rzKekI51iz6CuAak8QszyyMLKPGqDc	28905675-858b-4a93-a283-205899779622	2024-07-23 03:08:02.798221	2024-07-24 03:08:02	1125
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNzA0MzA3LCJleHAiOjE3MjE5NjM1MDd9.t3o-_rzhT7Vl7w2Dx-8CTAk5KO40I0dZeNbhQYN101g	28905675-858b-4a93-a283-205899779622	2024-07-23 03:11:47.849177	2024-07-24 03:11:47	1126
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNzA2Mzk1LCJleHAiOjE3MjE5NjU1OTV9.jRveB0nKLMeWJqQfUqLXe7uUu8OUWw7I7kfd9JAvelc	28905675-858b-4a93-a283-205899779622	2024-07-23 03:46:35.555276	2024-07-24 03:46:35	1127
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNzA2NzA3LCJleHAiOjE3MjE5NjU5MDd9.7yU4anX8K9T6lciHncG4iOsE9KHgMNTej8t-XhLODLs	28905675-858b-4a93-a283-205899779622	2024-07-23 03:51:47.19662	2024-07-24 03:51:47	1128
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE3MDg4MDIsImV4cCI6MTcyMTk2ODAwMn0.hZAOldrdI5PWz8VIIFqrMQvxiBTVtOqUfb5eVjkohag	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-23 04:26:42.990851	2024-07-24 04:26:42	1129
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNzA4ODIxLCJleHAiOjE3MjE5NjgwMjF9.gSilcdiSGiFY11mYZSIxqqQ5732XMCv6POGLORjWOKk	28905675-858b-4a93-a283-205899779622	2024-07-23 04:27:01.544838	2024-07-24 04:27:01	1130
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNzA4ODIxLCJleHAiOjE3MjE5NjgwMjF9.gSilcdiSGiFY11mYZSIxqqQ5732XMCv6POGLORjWOKk	28905675-858b-4a93-a283-205899779622	2024-07-23 04:27:01.689792	2024-07-24 04:27:01	1131
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNzEwNzg3LCJleHAiOjE3MjE5Njk5ODd9._1MKXbOf03dSjlyXwjB--gT_h3Yl7F_Sh9Kr9zE03OU	28905675-858b-4a93-a283-205899779622	2024-07-23 04:59:47.191337	2024-07-24 04:59:47	1132
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNzEwNzg3LCJleHAiOjE3MjE5Njk5ODd9._1MKXbOf03dSjlyXwjB--gT_h3Yl7F_Sh9Kr9zE03OU	28905675-858b-4a93-a283-205899779622	2024-07-23 04:59:47.346158	2024-07-24 04:59:47	1133
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNzExNDcyLCJleHAiOjE3MjE5NzA2NzJ9.vqumqfya5pwHoMzU22iB38WUR2xybRt-8FEt1AEB3jM	28905675-858b-4a93-a283-205899779622	2024-07-23 05:11:12.596938	2024-07-24 05:11:12	1134
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE3MTY5OTAsImV4cCI6MTcyMTk3NjE5MH0.zjmIDNHvFle5UjKmQeJxfnLaKIhsaEKj8D9RLpuEIWI	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-23 06:43:10.381001	2024-07-24 06:43:10	1135
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE3MTc2ODAsImV4cCI6MTcyMTk3Njg4MH0.zRHZYBO3ApN1jlRGttDglTGS1-wPbIJ2AsmciEktFTI	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-23 06:54:40.676117	2024-07-24 06:54:40	1136
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE3MjYyMzYsImV4cCI6MTcyMTk4NTQzNn0.3W25p7U3lFD33vsrp3V61I74XqHYXeFnjQA_EbAeA0g	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-23 09:17:16.77657	2024-07-24 09:17:16	1137
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE3MjcyNTYsImV4cCI6MTcyMTk4NjQ1Nn0.eV4Idr-QG1lWh-nSGqBnQkgPmLUb5C3l9zfTotGQcxI	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-23 09:34:16.483817	2024-07-24 09:34:16	1138
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE3Mjk1MzksImV4cCI6MTcyMTk4ODczOX0.kenyL4yD3azyx-42Rb1D3qC8cV03ohepxATYA7UHS6o	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-23 10:12:19.951629	2024-07-24 10:12:19	1139
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE3Mjk2NDgsImV4cCI6MTcyMTk4ODg0OH0.bwh_Mj4bIiTZzKa8PSbhU1GAGipYz3FJ9RnvQknTaF8	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-23 10:14:08.204522	2024-07-24 10:14:08	1140
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE3MzAxNzksImV4cCI6MTcyMTk4OTM3OX0.NFXfY3F3M1ba_rPYFAog9d9b5y0LjX6TrGCJQDVn4HE	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-23 10:22:59.330009	2024-07-24 10:22:59	1141
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE3MzA2NjgsImV4cCI6MTcyMTk4OTg2OH0.0KY1OPZIxm4AkpQw0tmE8Nq8MXlI8Wh58Rbvkt8Yvmw	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-23 10:31:08.055334	2024-07-24 10:31:08	1142
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE3MzEwMTMsImV4cCI6MTcyMTk5MDIxM30.mkN8gjdfRd8FIvq5RwjzqAj5DJ39iGShmQ6_nuE3dcA	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-23 10:36:53.517151	2024-07-24 10:36:53	1143
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNzM0MDcwLCJleHAiOjE3MjE5OTMyNzB9.oMWS5Mbe9_FSv00BG1G0tIW2f9KN1c50ibtKpl9Ruqo	28905675-858b-4a93-a283-205899779622	2024-07-23 11:27:50.46668	2024-07-24 11:27:50	1144
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNzM0MDcwLCJleHAiOjE3MjE5OTMyNzB9.oMWS5Mbe9_FSv00BG1G0tIW2f9KN1c50ibtKpl9Ruqo	28905675-858b-4a93-a283-205899779622	2024-07-23 11:27:50.650572	2024-07-24 11:27:50	1145
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE3MzQwOTYsImV4cCI6MTcyMTk5MzI5Nn0.-74p2HTdIDHMJn7gXI0_LmvcudwqYaL89aIdiIB21eM	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-23 11:28:16.785797	2024-07-24 11:28:16	1146
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNzM0NTYzLCJleHAiOjE3MjE5OTM3NjN9.NXGTTdLvzuhklQjd9TPeX95ZgUg1zXXCerpcZ_m4wac	28905675-858b-4a93-a283-205899779622	2024-07-23 11:36:03.811829	2024-07-24 11:36:03	1147
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE3MzkzMTQsImV4cCI6MTcyMTk5ODUxNH0.84-JfGEDt7aNEV1x9PYm0aPIJi6V0_JtNYIAeVdnSJQ	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-23 12:55:14.602027	2024-07-24 12:55:14	1148
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE3NDU3NjgsImV4cCI6MTcyMjAwNDk2OH0.8wD-SYIsqFZ2jDPlK5Br2RwC_U0qwN-NyxuxCDipdcI	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-23 14:42:48.77179	2024-07-24 14:42:48	1149
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE3NDYwMjMsImV4cCI6MTcyMjAwNTIyM30.8Yp7l7jwwU3mmQkE9QaTZHTYMBR8QBQDVK3Nvbgc6Fk	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-23 14:47:03.527548	2024-07-24 14:47:03	1150
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE3NDYyNjYsImV4cCI6MTcyMjAwNTQ2Nn0.oSVMIFTso4-kdBBuW5-5VBOeSDwHeGdLexoesM2qF5c	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-23 14:51:06.077313	2024-07-24 14:51:06	1151
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE3NDk3NjEsImV4cCI6MTcyMjAwODk2MX0.KlBsbdMd6iGc5_DzWyOzoD_Z4srPX_mBwfzsnrwUAdU	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-23 15:49:21.591554	2024-07-24 15:49:21	1152
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE3NDk3NzgsImV4cCI6MTcyMjAwODk3OH0.8pfLyUn9-MMOiVpBUoppqBuPSQ0Zl073-33vyh2L0Ss	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-23 15:49:38.9379	2024-07-24 15:49:38	1153
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE3NTAwNjksImV4cCI6MTcyMjAwOTI2OX0.ZkPJuNzKGkyLFGxEmQxdRDOveKHRTUOgU1yjno7pjmI	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-23 15:54:29.326595	2024-07-24 15:54:29	1154
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE3NTEyMDEsImV4cCI6MTcyMjAxMDQwMX0.2ybSjiHXBjLZPtROMCBkCRTONozV5VYeB-COAnrnYGs	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-23 16:13:21.626676	2024-07-24 16:13:21	1155
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE3NTE2MjEsImV4cCI6MTcyMjAxMDgyMX0.-8zwM8EtkGA4Vqny0w30E4_waf6dt0u7YYPYQVbJxe4	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-23 16:20:21.333674	2024-07-24 16:20:21	1156
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE3NTQzODUsImV4cCI6MTcyMjAxMzU4NX0.S0T3O0W7yWYWU1a-4WNaxgVJ--CRlEhpy_l6Lr6Cx9U	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-23 17:06:25.622964	2024-07-24 17:06:25	1157
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE3NTYwNTcsImV4cCI6MTcyMjAxNTI1N30.2DhEMOq-zZHXoM09Cl2daTW78L2yVREACmlYjWVmuH8	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-23 17:34:18.140161	2024-07-24 17:34:17	1158
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE3NTYzNTYsImV4cCI6MTcyMjAxNTU1Nn0.BnxX1ifvlw3P3cBOpE4ky7ZpOSMB-dS_0MuVw8jUvnE	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-23 17:39:16.236821	2024-07-24 17:39:16	1159
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNzU2NDkwLCJleHAiOjE3MjIwMTU2OTB9.3dTvfwd2TqAaWeOWqlmbkUcd93gJwjEsC2Ic0VL3PVg	28905675-858b-4a93-a283-205899779622	2024-07-23 17:41:30.141034	2024-07-24 17:41:30	1160
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE3NTcxMzEsImV4cCI6MTcyMjAxNjMzMX0.P4jqWh0yVq30ZD7iYgZk8w8kU3y-EL31HM1LzQoxXbA	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-23 17:52:11.23155	2024-07-24 17:52:11	1161
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE3NTgxMjEsImV4cCI6MTcyMjAxNzMyMX0.fG35GloppEbvcjdmgHasIw4jYX1VPm5FItOzQXCBIsM	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-23 18:08:41.775116	2024-07-24 18:08:41	1162
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE3NzEzNDAsImV4cCI6MTcyMjAzMDU0MH0.Y_rbDXX8E-hBkJV4HEW2liNitkc-IvQm6Jnem8qp6P4	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-23 21:49:00.053653	2024-07-24 21:49:00	1163
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE3NzU2MDksImV4cCI6MTcyMjAzNDgwOX0.6lobVYy8jiYSxcSNNw5lsOLFpJlzuKtzzdI79J33lUU	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-23 23:00:09.782238	2024-07-24 23:00:09	1164
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNzc1NjE2LCJleHAiOjE3MjIwMzQ4MTZ9.f3vn27GWvsZMrxps7N7wZvldx_TndEHd-I8wkPpoTUE	28905675-858b-4a93-a283-205899779622	2024-07-23 23:00:16.663846	2024-07-24 23:00:16	1165
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNzc4NDU3LCJleHAiOjE3MjIwMzc2NTd9.fC_ascbLVdjOxwmJSSh_o5vUo4vB1vuWYdFZ41sMGgg	28905675-858b-4a93-a283-205899779622	2024-07-23 23:47:37.903232	2024-07-24 23:47:37	1166
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNzc4NDU3LCJleHAiOjE3MjIwMzc2NTd9.fC_ascbLVdjOxwmJSSh_o5vUo4vB1vuWYdFZ41sMGgg	28905675-858b-4a93-a283-205899779622	2024-07-23 23:47:37.915484	2024-07-24 23:47:37	1167
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE3Nzg1NTYsImV4cCI6MTcyMjAzNzc1Nn0.XLJoMHx4j2Aihon-wezIUHEvPjf0vQAupV3Mj6Y5-l4	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-23 23:49:16.058668	2024-07-24 23:49:16	1168
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNzgwNTMxLCJleHAiOjE3MjIwMzk3MzF9.1llwK6rRjqqCZ3NK3UL-F0AkFsD5yAWGHGWKaGtVlUg	28905675-858b-4a93-a283-205899779622	2024-07-24 00:22:11.949726	2024-07-25 00:22:11	1169
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNzgxMjM0LCJleHAiOjE3MjIwNDA0MzR9.7oRAjgX4I5aj3ROi7kcuRlLT0YSCNdGkk7787GCGESI	28905675-858b-4a93-a283-205899779622	2024-07-24 00:33:54.209646	2024-07-25 00:33:54	1170
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNzgxMjM0LCJleHAiOjE3MjIwNDA0MzR9.7oRAjgX4I5aj3ROi7kcuRlLT0YSCNdGkk7787GCGESI	28905675-858b-4a93-a283-205899779622	2024-07-24 00:33:54.35265	2024-07-25 00:33:54	1171
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE3ODM4MDEsImV4cCI6MTcyMjA0MzAwMX0.pYy2vYq6UJy-VyuwRB-hUzVs4XpXniAY17eSX9o7Vmg	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 01:16:41.982276	2024-07-25 01:16:41	1172
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE3ODM4MDIsImV4cCI6MTcyMjA0MzAwMn0.hEmutYypcqUSK8IyNMD_T3iC4475rMmypB5o5CUlQTo	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 01:16:42.118186	2024-07-25 01:16:42	1173
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE3ODM4MDIsImV4cCI6MTcyMjA0MzAwMn0.hEmutYypcqUSK8IyNMD_T3iC4475rMmypB5o5CUlQTo	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 01:16:42.387831	2024-07-25 01:16:42	1174
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNzg1NDc2LCJleHAiOjE3MjIwNDQ2NzZ9.cdMuvZiKcz7UstgIbhbI3iTfbNGfeRVpGm68mnYL0qY	28905675-858b-4a93-a283-205899779622	2024-07-24 01:44:36.59032	2024-07-25 01:44:36	1175
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNzg1NDc2LCJleHAiOjE3MjIwNDQ2NzZ9.cdMuvZiKcz7UstgIbhbI3iTfbNGfeRVpGm68mnYL0qY	28905675-858b-4a93-a283-205899779622	2024-07-24 01:44:36.698667	2024-07-25 01:44:36	1176
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE3ODY1MzcsImV4cCI6MTcyMjA0NTczN30.nnQ5hdbosFC1kTEg40G-dm5Vvj6woCz_HlL2lFuVgOI	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 02:02:17.989552	2024-07-25 02:02:17	1177
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE3ODY3MTEsImV4cCI6MTcyMjA0NTkxMX0.Vl9ScP3tqigxcWm_80GUIrmMWnYYtFfugrb9NJz_hWY	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 02:05:11.1266	2024-07-25 02:05:11	1178
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE3ODY3MTEsImV4cCI6MTcyMjA0NTkxMX0.Vl9ScP3tqigxcWm_80GUIrmMWnYYtFfugrb9NJz_hWY	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 02:05:11.265895	2024-07-25 02:05:11	1179
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNzg2ODMyLCJleHAiOjE3MjIwNDYwMzJ9.mCQjMUiGJKiQEjGB8YRyuzYjL8OKYzmwu4sX3-G_McI	28905675-858b-4a93-a283-205899779622	2024-07-24 02:07:12.053972	2024-07-25 02:07:12	1180
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNzg2ODMyLCJleHAiOjE3MjIwNDYwMzJ9.mCQjMUiGJKiQEjGB8YRyuzYjL8OKYzmwu4sX3-G_McI	28905675-858b-4a93-a283-205899779622	2024-07-24 02:07:12.327463	2024-07-25 02:07:12	1181
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNzg3MTAxLCJleHAiOjE3MjIwNDYzMDF9.Sw6KCkuYdXIY7evhhscRZWgpFKRbLgXXn4-fAKw7MsE	28905675-858b-4a93-a283-205899779622	2024-07-24 02:11:41.90552	2024-07-25 02:11:41	1182
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNzg3MTAxLCJleHAiOjE3MjIwNDYzMDF9.Sw6KCkuYdXIY7evhhscRZWgpFKRbLgXXn4-fAKw7MsE	28905675-858b-4a93-a283-205899779622	2024-07-24 02:11:41.984079	2024-07-25 02:11:41	1183
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNzg5Mzg0LCJleHAiOjE3MjIwNDg1ODR9.7HU6P_mm4mHva4GmN43r8TN_aETS8xAuqqdlJA38Uy8	28905675-858b-4a93-a283-205899779622	2024-07-24 02:49:44.146669	2024-07-25 02:49:44	1184
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNzg5Mzg0LCJleHAiOjE3MjIwNDg1ODR9.7HU6P_mm4mHva4GmN43r8TN_aETS8xAuqqdlJA38Uy8	28905675-858b-4a93-a283-205899779622	2024-07-24 02:49:44.305253	2024-07-25 02:49:44	1185
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxNzkxNjczLCJleHAiOjE3MjIwNTA4NzN9.PXk3xY42xAvjbKEkfwbnb_8hnRjXROdmMcfDeLKBRqo	28905675-858b-4a93-a283-205899779622	2024-07-24 03:27:53.959609	2024-07-25 03:27:53	1186
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE3OTI4NzksImV4cCI6MTcyMjA1MjA3OX0.I9vtWHx4HNrd0-u7dyNiE4JjteT4qnOoLjlvlgShmL0	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 03:47:59.193916	2024-07-25 03:47:59	1187
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE3OTM0NDUsImV4cCI6MTcyMjA1MjY0NX0.weTDPaPfUrQ9ljwkepNQsbqls-l73IvQwwq66a3XBvg	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 03:57:25.060011	2024-07-25 03:57:25	1188
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE3OTYyMDQsImV4cCI6MTcyMjA1NTQwNH0.v1BFK8FrDkpwbTL3rrJCYk9APXsMJREWdk_gO3zf8a4	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 04:43:24.037752	2024-07-25 04:43:24	1189
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE4MTE1NzgsImV4cCI6MTcyMjA3MDc3OH0.F26GgqxM7c9bJ5aETomDKZqtfe9rG1O7m8HS2Yjf_s8	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 08:59:38.27063	2024-07-25 08:59:38	1190
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE4MTI1MTgsImV4cCI6MTcyMjA3MTcxOH0.vQL1AK10hXtQZvondD4SqE3oDf07mp7Mzp40pSzKbN8	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 09:15:18.211273	2024-07-25 09:15:18	1191
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE4MTYyODUsImV4cCI6MTcyMjA3NTQ4NX0.YkV6JXdl8nP3MQGBukp0EG38Y-fJSB3Gj1jN9JywvGY	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 10:18:05.087199	2024-07-25 10:18:05	1192
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE4MTc0NTksImV4cCI6MTcyMjA3NjY1OX0.UMY0JB2FTKETwVLWN-JaRtLxA4rPjQppKbP33yGknpw	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 10:37:39.999236	2024-07-25 10:37:39	1193
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE4MTc0NzksImV4cCI6MTcyMjA3NjY3OX0.72FHAUAyuSX0jNOjzTCAggSLziQdZ8X6Zi_l0du0g1g	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 10:37:59.485804	2024-07-25 10:37:59	1194
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxODE3OTk5LCJleHAiOjE3MjIwNzcxOTl9.QDIz_jR0dvetzlUc6i2T3XuiwJi8N9epDlnV2OaWnwI	28905675-858b-4a93-a283-205899779622	2024-07-24 10:46:39.987379	2024-07-25 10:46:39	1195
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxODE4MDAwLCJleHAiOjE3MjIwNzcyMDB9.cmUy620ERSiwmFCohDgpP7gIhCaVOjlFW-EOc3xxPaM	28905675-858b-4a93-a283-205899779622	2024-07-24 10:46:40.094537	2024-07-25 10:46:40	1196
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE4MTgyNzQsImV4cCI6MTcyMjA3NzQ3NH0.orcizdiAJiQ2qi6hcnSB9co56-_hXu9oJhxrr8qYDrk	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 10:51:14.711548	2024-07-25 10:51:14	1197
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE4MTgyNzgsImV4cCI6MTcyMjA3NzQ3OH0.JYb2NR8gT7TA4QKih1BqC7O4Iu6VsxGV5JRda76TLyk	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 10:51:18.556464	2024-07-25 10:51:18	1198
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE4MTgzMDAsImV4cCI6MTcyMjA3NzUwMH0.UZxKTU7Vmk1XSLHCx_cu1VsvYzcxXbU9Nv9IyCzeWeU	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 10:51:40.944004	2024-07-25 10:51:40	1199
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxODE4MzM2LCJleHAiOjE3MjIwNzc1MzZ9.XLQQESBui6Rw2_8-7XXNgveB6Z2Da0cJtnSPESzFG_g	28905675-858b-4a93-a283-205899779622	2024-07-24 10:52:16.421627	2024-07-25 10:52:16	1200
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxODE4MzM2LCJleHAiOjE3MjIwNzc1MzZ9.XLQQESBui6Rw2_8-7XXNgveB6Z2Da0cJtnSPESzFG_g	28905675-858b-4a93-a283-205899779622	2024-07-24 10:52:16.483356	2024-07-25 10:52:16	1201
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxODE4NjEzLCJleHAiOjE3MjIwNzc4MTN9.lGWvVHT00m8MstLgs_gDf8OzJe-MtIlMGhgHaWpljGg	28905675-858b-4a93-a283-205899779622	2024-07-24 10:56:53.403909	2024-07-25 10:56:53	1202
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxODE4NjU0LCJleHAiOjE3MjIwNzc4NTR9.6u3XuMHERp2qps6UuxyLUDdB6gtmJoc5o1xvO8ufT-c	28905675-858b-4a93-a283-205899779622	2024-07-24 10:57:34.65001	2024-07-25 10:57:34	1203
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE4MTg5MzMsImV4cCI6MTcyMjA3ODEzM30.sWdQ8L61oyPvgqk0igGthBsl8YMwONnJdDaeQySTg18	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 11:02:13.264749	2024-07-25 11:02:13	1204
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxODE5NzI5LCJleHAiOjE3MjIwNzg5Mjl9.FPMpUBIizHGhCP7-ZWwGVof6zn4Bq98zboWs-Crq3Pw	28905675-858b-4a93-a283-205899779622	2024-07-24 11:15:29.129488	2024-07-25 11:15:29	1205
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxODE5NzI5LCJleHAiOjE3MjIwNzg5Mjl9.FPMpUBIizHGhCP7-ZWwGVof6zn4Bq98zboWs-Crq3Pw	28905675-858b-4a93-a283-205899779622	2024-07-24 11:15:29.234922	2024-07-25 11:15:29	1206
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxODIwMDc0LCJleHAiOjE3MjIwNzkyNzR9.CkQgx63PZ48skRzDUyyhUv858hwtgQWU7WeMRfW7v44	28905675-858b-4a93-a283-205899779622	2024-07-24 11:21:14.350058	2024-07-25 11:21:14	1207
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxODIwMDc0LCJleHAiOjE3MjIwNzkyNzR9.CkQgx63PZ48skRzDUyyhUv858hwtgQWU7WeMRfW7v44	28905675-858b-4a93-a283-205899779622	2024-07-24 11:21:14.479607	2024-07-25 11:21:14	1208
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxODIwMTYyLCJleHAiOjE3MjIwNzkzNjJ9.xjQYMQiM0w8CmvvgLxysSltZbY_Zp5eYHu9e35Khtog	28905675-858b-4a93-a283-205899779622	2024-07-24 11:22:42.266011	2024-07-25 11:22:42	1209
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxODIwMTYyLCJleHAiOjE3MjIwNzkzNjJ9.xjQYMQiM0w8CmvvgLxysSltZbY_Zp5eYHu9e35Khtog	28905675-858b-4a93-a283-205899779622	2024-07-24 11:22:42.473957	2024-07-25 11:22:42	1210
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxODIwMjA5LCJleHAiOjE3MjIwNzk0MDl9.P3tkNUnxwN3Y4Unw5GIB8f2Qd0PpvvpHxgQO5UyIhEI	28905675-858b-4a93-a283-205899779622	2024-07-24 11:23:29.500164	2024-07-25 11:23:29	1211
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE4MjAyODQsImV4cCI6MTcyMjA3OTQ4NH0.pk1idRu7gmo9KlehzVzFHGLLIW4IW9ACFpdLHfxr8Jk	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 11:24:44.615796	2024-07-25 11:24:44	1212
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxODIwMzE5LCJleHAiOjE3MjIwNzk1MTl9.HYs8dl6h7T98Yiabo8ei3Jx101MHXllyWxawTT99qAc	28905675-858b-4a93-a283-205899779622	2024-07-24 11:25:19.51776	2024-07-25 11:25:19	1213
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxODIwMzE5LCJleHAiOjE3MjIwNzk1MTl9.HYs8dl6h7T98Yiabo8ei3Jx101MHXllyWxawTT99qAc	28905675-858b-4a93-a283-205899779622	2024-07-24 11:25:19.695171	2024-07-25 11:25:19	1214
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxODIwMzQ5LCJleHAiOjE3MjIwNzk1NDl9.FDsUNT5N4vXXeresqrdiyVtvBRcGbxSnqXYiIJGljWM	28905675-858b-4a93-a283-205899779622	2024-07-24 11:25:49.677772	2024-07-25 11:25:49	1215
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxODIwMzQ5LCJleHAiOjE3MjIwNzk1NDl9.FDsUNT5N4vXXeresqrdiyVtvBRcGbxSnqXYiIJGljWM	28905675-858b-4a93-a283-205899779622	2024-07-24 11:25:49.834366	2024-07-25 11:25:49	1216
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxODIwNTUyLCJleHAiOjE3MjIwNzk3NTJ9.pP7XZ5n80tx4OufwTVOATWIbgYOt22JsOt3u0c2EUAs	28905675-858b-4a93-a283-205899779622	2024-07-24 11:29:12.02477	2024-07-25 11:29:12	1217
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxODIwNTUyLCJleHAiOjE3MjIwNzk3NTJ9.pP7XZ5n80tx4OufwTVOATWIbgYOt22JsOt3u0c2EUAs	28905675-858b-4a93-a283-205899779622	2024-07-24 11:29:12.158752	2024-07-25 11:29:12	1218
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxODIwNjUyLCJleHAiOjE3MjIwNzk4NTJ9.pHEzPLB02eRbN5NZgjhtqFUxq3r1bxda_4NN8qvm660	28905675-858b-4a93-a283-205899779622	2024-07-24 11:30:52.807002	2024-07-25 11:30:52	1219
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxODIyMTA0LCJleHAiOjE3MjIwODEzMDR9.mDkSiCqzkvYgh7N9hrv1etPlbqJO4Hj8T0vLaRhckZY	28905675-858b-4a93-a283-205899779622	2024-07-24 11:55:04.105165	2024-07-25 11:55:04	1220
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxODIyMTA0LCJleHAiOjE3MjIwODEzMDR9.mDkSiCqzkvYgh7N9hrv1etPlbqJO4Hj8T0vLaRhckZY	28905675-858b-4a93-a283-205899779622	2024-07-24 11:55:04.20678	2024-07-25 11:55:04	1221
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InBoYW1naWFuZ3RoYWlkdW9uZzFAZ21haWwuY29tIiwiaWRfdXNlciI6IjIwODJlZGVkLWQwYmQtNDZhNS1hNjJkLTFiZWQzODM5YTZlOSIsInBob25lIjpudWxsLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxODI1MDg4LCJleHAiOjE3MjIwODQyODh9.sGVD2PSgCHq0_P9nxASqSLPXa1aaiECCmLwnBoU7e7o	2082eded-d0bd-46a5-a62d-1bed3839a6e9	2024-07-24 12:44:48.024688	2024-07-25 12:44:48	1222
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRoYWlkdW9uZzAzMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiNjdlZWViZTUtNzc0Zi00ZGMxLThmMTEtNzdlZWY3YjYzMGRhIiwicGhvbmUiOm51bGwsImlzYWRtaW4iOmZhbHNlLCJpYXQiOjE3MjE4MjUxMjcsImV4cCI6MTcyMjA4NDMyN30.yCM7EjjCLn4WC9tASUcnrAwInsKz_gKBgCVnPgrI4T4	67eeebe5-774f-4dc1-8f11-77eef7b630da	2024-07-24 12:45:27.607338	2024-07-25 12:45:27	1226
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRoYWlkdW9uZzAzMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiNjdlZWViZTUtNzc0Zi00ZGMxLThmMTEtNzdlZWY3YjYzMGRhIiwicGhvbmUiOm51bGwsImlzYWRtaW4iOmZhbHNlLCJpYXQiOjE3MjE4MjUyMDUsImV4cCI6MTcyMjA4NDQwNX0.f8iYS27l_aTgqqe8yF9qNhUQs85ZDAzQxN4k_sl1Iis	67eeebe5-774f-4dc1-8f11-77eef7b630da	2024-07-24 12:46:45.951009	2024-07-25 12:46:45	1230
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE4MjUyMDgsImV4cCI6MTcyMjA4NDQwOH0.AbBLe40J3x0YxZ2tsYRY7ZzfGIKsdPb_O13GfIdwlJo	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 12:46:48.022719	2024-07-25 12:46:48	1234
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRoYWlkdW9uZzAzMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiNjdlZWViZTUtNzc0Zi00ZGMxLThmMTEtNzdlZWY3YjYzMGRhIiwicGhvbmUiOm51bGwsImlzYWRtaW4iOmZhbHNlLCJpYXQiOjE3MjE4MjUzMjIsImV4cCI6MTcyMjA4NDUyMn0.9_ZFuCJFasB0bSPPQUAc7l-xOLXRB0E40zhbUBQANz0	67eeebe5-774f-4dc1-8f11-77eef7b630da	2024-07-24 12:48:42.258124	2024-07-25 12:48:42	1235
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRoYWlkdW9uZzAzMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiNjdlZWViZTUtNzc0Zi00ZGMxLThmMTEtNzdlZWY3YjYzMGRhIiwicGhvbmUiOm51bGwsImlzYWRtaW4iOmZhbHNlLCJpYXQiOjE3MjE4MjUzNzEsImV4cCI6MTcyMjA4NDU3MX0.BVQ2D3kBFBpF3-VueNHxHC--fCdPqJNtvHLIUWTLkxQ	67eeebe5-774f-4dc1-8f11-77eef7b630da	2024-07-24 12:49:31.338151	2024-07-25 12:49:31	1239
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE4MjU1NzgsImV4cCI6MTcyMjA4NDc3OH0.X2iFV5yOU94PTasxoiHaPzAGera83bALKJ5NuX0a9vc	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 12:52:58.900159	2024-07-25 12:52:58	1243
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxODI1NzA3LCJleHAiOjE3MjIwODQ5MDd9.7xpCxSyn2oZvJRNcn5YfiB7ANplpyDslwZXdOtPILS0	28905675-858b-4a93-a283-205899779622	2024-07-24 12:55:07.385425	2024-07-25 12:55:07	1244
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRoYWlkdW9uZzAzMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiNjdlZWViZTUtNzc0Zi00ZGMxLThmMTEtNzdlZWY3YjYzMGRhIiwicGhvbmUiOm51bGwsImlzYWRtaW4iOmZhbHNlLCJpYXQiOjE3MjE4MjU4NzIsImV4cCI6MTcyMjA4NTA3Mn0.KWker6kEPZPcg66BH69EWSaeNCdmU3l1hRlKUvyFdTE	67eeebe5-774f-4dc1-8f11-77eef7b630da	2024-07-24 12:57:52.864958	2024-07-25 12:57:52	1245
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InBoYW1naWFuZ3RoYWlkdW9uZzFAZ21haWwuY29tIiwiaWRfdXNlciI6IjIwODJlZGVkLWQwYmQtNDZhNS1hNjJkLTFiZWQzODM5YTZlOSIsInBob25lIjpudWxsLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxODI1ODk4LCJleHAiOjE3MjIwODUwOTh9.XeUFF5VPWrrUOP1uQdUmRErWgWORS3MC_EQRS0-N4ew	2082eded-d0bd-46a5-a62d-1bed3839a6e9	2024-07-24 12:58:18.124477	2024-07-25 12:58:18	1249
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE4MjU5MzgsImV4cCI6MTcyMjA4NTEzOH0.F4Z3mgprW7Vy9jVmGOIdB-3y5uENwmYAg-WaI5iJdnk	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 12:58:58.409948	2024-07-25 12:58:58	1253
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE4MjU5NjMsImV4cCI6MTcyMjA4NTE2M30.MxunRo9Z66F4cJT1dtGIK83Hu9w5vx6sGuFNs5oY8fQ	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 12:59:23.947055	2024-07-25 12:59:23	1254
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE4MjY5OTgsImV4cCI6MTcyMjA4NjE5OH0.wJo7SY2Ar_drdqvdNX3cGRifM3Y1LWY_deVZeR1NSBs	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 13:16:38.414815	2024-07-25 13:16:38	1255
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE4MjcwMDAsImV4cCI6MTcyMjA4NjIwMH0.eL3NyoVNsRs4BIQgSapv-U102kQttKCYf73eavd4TQo	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 13:16:40.192577	2024-07-25 13:16:40	1256
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxODI3MTA2LCJleHAiOjE3MjIwODYzMDZ9.uyl07-uFppGsDVkvXD3rPsmM4MeBnVlDr7VeomKdx8g	28905675-858b-4a93-a283-205899779622	2024-07-24 13:18:26.107959	2024-07-25 13:18:26	1257
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxODI3MTA2LCJleHAiOjE3MjIwODYzMDZ9.uyl07-uFppGsDVkvXD3rPsmM4MeBnVlDr7VeomKdx8g	28905675-858b-4a93-a283-205899779622	2024-07-24 13:18:26.22957	2024-07-25 13:18:26	1258
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE4MjczNDIsImV4cCI6MTcyMjA4NjU0Mn0.D8r_L50U_DuIzkbucnUopM-1Sp150b7D1VR27zZxsYM	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 13:22:22.836493	2024-07-25 13:22:22	1259
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxODI3ODY5LCJleHAiOjE3MjIwODcwNjl9.omCSeAUa7SXPB8kA3-rT2YD0xZP-LFXLLDfQwwEKnWM	28905675-858b-4a93-a283-205899779622	2024-07-24 13:31:09.882319	2024-07-25 13:31:09	1260
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxODI3ODcwLCJleHAiOjE3MjIwODcwNzB9._Br5DCbS1T3s6kreiag2Ztpyh2UaByzeZuOggCPzgQI	28905675-858b-4a93-a283-205899779622	2024-07-24 13:31:10.014086	2024-07-25 13:31:10	1261
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxODI4MDAzLCJleHAiOjE3MjIwODcyMDN9.InKOCGdMoqjG6AgIaaTFk7im9sLBOAZjac-CeQGKjk0	28905675-858b-4a93-a283-205899779622	2024-07-24 13:33:23.92732	2024-07-25 13:33:23	1262
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxODI4MDA0LCJleHAiOjE3MjIwODcyMDR9.sO4rNRx0LM2FieRYLQQVmPQIVVG4Oi_hudp5ckSvxdY	28905675-858b-4a93-a283-205899779622	2024-07-24 13:33:24.13671	2024-07-25 13:33:24	1263
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE4Mjg0MzAsImV4cCI6MTcyMjA4NzYzMH0.E0a22wdkR3Ic4ZUofRfDCTPK-GMp43ba8MXZ4OHC-FA	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 13:40:30.867523	2024-07-25 13:40:30	1264
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxODI4NTcwLCJleHAiOjE3MjIwODc3NzB9.d7pKwb43bJrCHr-HQckHrB2Jlqj0QbYJSo2K458l8s8	28905675-858b-4a93-a283-205899779622	2024-07-24 13:42:50.392244	2024-07-25 13:42:50	1265
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InR0aGllbkBnbWFpbC5jb20iLCJpZF91c2VyIjoiMjg5MDU2NzUtODU4Yi00YTkzLWEyODMtMjA1ODk5Nzc5NjIyIiwicGhvbmUiOiIrODQ4ODY3MjUwNDQiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxODI4NTcwLCJleHAiOjE3MjIwODc3NzB9.d7pKwb43bJrCHr-HQckHrB2Jlqj0QbYJSo2K458l8s8	28905675-858b-4a93-a283-205899779622	2024-07-24 13:42:50.563362	2024-07-25 13:42:50	1266
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE4MjkxNDksImV4cCI6MTcyMjA4ODM0OX0.TBdjTm78rDdD5xAuE4MAo10tlCu8TzEskKDPqHWL3cA	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 13:52:29.573043	2024-07-25 13:52:29	1267
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRoYWlkdW9uZzAzMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiNjdlZWViZTUtNzc0Zi00ZGMxLThmMTEtNzdlZWY3YjYzMGRhIiwicGhvbmUiOm51bGwsImlzYWRtaW4iOmZhbHNlLCJpYXQiOjE3MjE4Mjk0NDksImV4cCI6MTcyMjA4ODY0OX0.Fd0V_v1TbfTOt-P68zkXgFGr4QXq0Q68uttHTwCul88	67eeebe5-774f-4dc1-8f11-77eef7b630da	2024-07-24 13:57:29.479599	2024-07-25 13:57:29	1268
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE4Mjk0ODQsImV4cCI6MTcyMjA4ODY4NH0.itTpWR_MjoP7v_kEz0GL3Eovf6i-rO6Hvd8G3-cgmBE	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 13:58:04.997906	2024-07-25 13:58:04	1272
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InBoYW1naWFuZ3RoYWlkdW9uZzFAZ21haWwuY29tIiwiaWRfdXNlciI6IjIwODJlZGVkLWQwYmQtNDZhNS1hNjJkLTFiZWQzODM5YTZlOSIsInBob25lIjpudWxsLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxODI5NTAzLCJleHAiOjE3MjIwODg3MDN9.ipFDMwIazk3zusSs_Ewr_nqkrmXc-ieiPgAeXR8Obyk	2082eded-d0bd-46a5-a62d-1bed3839a6e9	2024-07-24 13:58:23.962821	2024-07-25 13:58:23	1273
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InBoYW1naWFuZ3RoYWlkdW9uZzFAZ21haWwuY29tIiwiaWRfdXNlciI6IjIwODJlZGVkLWQwYmQtNDZhNS1hNjJkLTFiZWQzODM5YTZlOSIsInBob25lIjpudWxsLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxODI5NTIxLCJleHAiOjE3MjIwODg3MjF9.3KQ9wQuop3FIKUmBkJrkloEJb7Q4L1397GMD4kKLyNM	2082eded-d0bd-46a5-a62d-1bed3839a6e9	2024-07-24 13:58:41.406123	2024-07-25 13:58:41	1277
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE4MzA5MjEsImV4cCI6MTcyMjA5MDEyMX0.KRF45RFulD99IEW7QlT2q0t_2c_gmxHFcZ8wXTCT0YA	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 14:22:01.443467	2024-07-25 14:22:01	1281
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE4MzA5MjgsImV4cCI6MTcyMjA5MDEyOH0.JUs-A5Ei5gIacmDgZoQxHbORx7KrR5i-ArYSam42mLg	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 14:22:08.351887	2024-07-25 14:22:08	1282
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE4MzE5NTAsImV4cCI6MTcyMjA5MTE1MH0.a68ftQUIwLdrVuCQ-WiqJwgtKlcZ-SgxgmsIj20UELQ	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 14:39:10.616453	2024-07-25 14:39:10	1283
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InZjbHZjbHZjbEBnbWFpbC5jb20iLCJpZF91c2VyIjoiYTFjMWIxZmYtYTA4MC00ZjEzLThmNzAtNzg4ZmFkMjM1OWY3IiwicGhvbmUiOiIrODQ5NzEzMDgzMjMiLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxODMyNTY4LCJleHAiOjE3MjIwOTE3Njh9.zeX4V1DiLsF2F6bBkymImZ7gFRXsY5I6JivOmpoDFHM	a1c1b1ff-a080-4f13-8f70-788fad2359f7	2024-07-24 14:49:28.252796	2024-07-25 14:49:28	1284
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE4MzI2ODAsImV4cCI6MTcyMjA5MTg4MH0.C9-Urd00H9zBCzCW8LSak94cJYxbDKxl0sg9mkxBzUc	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 14:51:20.294468	2024-07-25 14:51:20	1285
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE4MzI3NjEsImV4cCI6MTcyMjA5MTk2MX0.goRhnurNk2mSHCTnG-M43MXnSZpjQPfmxEj_W_giXs4	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 14:52:41.625912	2024-07-25 14:52:41	1286
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE4MzQ1MzMsImV4cCI6MTcyMjA5MzczM30.PqclHf8AMST_ZdRWRxZ_gKkRIy2E3_5Zw0YSaso3g2Y	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 15:22:14.081132	2024-07-25 15:22:13	1287
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE4NDQzOTIsImV4cCI6MTcyMjEwMzU5Mn0.vcQ9iXqXoSyiSL2SF1HS9vlgg35urNpGC0G7zBfMZxQ	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 18:06:32.610213	2024-07-25 18:06:32	1288
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE4NDQ2MjUsImV4cCI6MTcyMjEwMzgyNX0.WeKlbivz0h5M7VWQPOGMgqSDdoSUEHCKOaKvweXNGh0	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 18:10:25.393931	2024-07-25 18:10:25	1289
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImN1Y2FpMTIzQGdtYWlsLmNvbSIsImlkX3VzZXIiOiI2Y2VmYzkyNC0xNDM3LTQ0YmQtODAzYS1kMmJlMjQ4ZTQ4NmIiLCJwaG9uZSI6Iis4NDk3MTEwODIzMSIsImlzYWRtaW4iOmZhbHNlLCJpYXQiOjE3MjE4NDQ2NTEsImV4cCI6MTcyMjEwMzg1MX0.9VwLpAYPv2unyWCdRMWq6a8wfvKZpmgpm8FxdqT3_nk	6cefc924-1437-44bd-803a-d2be248e486b	2024-07-24 18:10:51.618124	2024-07-25 18:10:51	1290
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImN1Y2FpMTIzQGdtYWlsLmNvbSIsImlkX3VzZXIiOiI2Y2VmYzkyNC0xNDM3LTQ0YmQtODAzYS1kMmJlMjQ4ZTQ4NmIiLCJwaG9uZSI6Iis4NDk3MTEwODIzMSIsImlzYWRtaW4iOmZhbHNlLCJpYXQiOjE3MjE4NDQ4NTcsImV4cCI6MTcyMjEwNDA1N30.FDzNiSxczoKx9Jr4Tfge0WBXXW3kGHTy5MtJbRgWiYs	6cefc924-1437-44bd-803a-d2be248e486b	2024-07-24 18:14:17.881359	2024-07-25 18:14:17	1291
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE4NDY0MDgsImV4cCI6MTcyMjEwNTYwOH0.ExfV_F7jffuPHezJEYQLjivtUmmzjX8XHPuUb3N_4HM	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 18:40:08.068833	2024-07-25 18:40:08	1292
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE4NDY0MjksImV4cCI6MTcyMjEwNTYyOX0.eDnH46qh4A3mE6Qyihlatnz-y3GGuRBthijbi8PAUsc	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 18:40:29.009805	2024-07-25 18:40:29	1293
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE4NDY0OTksImV4cCI6MTcyMjEwNTY5OX0.nIXPtLjhyN6R2SgIiBPcHSVYdLoSCD9W8jmczilcVTo	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 18:41:39.796495	2024-07-25 18:41:39	1294
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE4NDY1MDIsImV4cCI6MTcyMjEwNTcwMn0.BIUE5ICDYCjPn_2MgmSHcaTrjuIkj9sX6kki2vNLWzI	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 18:41:42.217705	2024-07-25 18:41:42	1295
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE4NDY1MTMsImV4cCI6MTcyMjEwNTcxM30.XUslbzgErVSDO0ZKBvTpxSntmF-d5efwZHOxUehoUp0	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 18:41:53.979521	2024-07-25 18:41:53	1296
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiYmQ5NGJhM2EtYjA0Ni00YTA1LWEyNjAtODkwOTEzZTA5ZGY5IiwicGhvbmUiOiIrODQ5NzEzMDg2MjMiLCJpc2FkbWluIjp0cnVlLCJpYXQiOjE3MjE4NDY1OTgsImV4cCI6MTcyMjEwNTc5OH0.6IR0d9EWyordFmwnPMRzFC8C3VnwDi9qHGh2X4R4nXw	bd94ba3a-b046-4a05-a260-890913e09df9	2024-07-24 18:43:18.094044	2024-07-25 18:43:18	1297
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InBoYW1naWFuZ3RoYWlkdW9uZzFAZ21haWwuY29tIiwiaWRfdXNlciI6IjIwODJlZGVkLWQwYmQtNDZhNS1hNjJkLTFiZWQzODM5YTZlOSIsInBob25lIjpudWxsLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxODQ2NjM5LCJleHAiOjE3MjIxMDU4Mzl9.LJIpJnlk8nlDGCC_OpME7aAKVhY6EVlnRe5_Oqg4Qtc	2082eded-d0bd-46a5-a62d-1bed3839a6e9	2024-07-24 18:43:59.201714	2024-07-25 18:43:59	1298
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InBoYW1naWFuZ3RoYWlkdW9uZzFAZ21haWwuY29tIiwiaWRfdXNlciI6IjIwODJlZGVkLWQwYmQtNDZhNS1hNjJkLTFiZWQzODM5YTZlOSIsInBob25lIjpudWxsLCJpc2FkbWluIjpmYWxzZSwiaWF0IjoxNzIxODQ2NzQwLCJleHAiOjE3MjIxMDU5NDB9.dk1FbLii8uu5uYPOn7FZ2iPkaxQ05CEYAWlCAawuAa4	2082eded-d0bd-46a5-a62d-1bed3839a6e9	2024-07-24 18:45:40.101296	2024-07-25 18:45:40	1302
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImJhbmhoYW90b2FuMjAwMkBnbWFpbC5jb20iLCJpZF91c2VyIjoiY2Y3MjNlOWYtZjc1YS00Yjk0LTk2MzQtNDM4ODBmMzI2NzQzIiwicGhvbmUiOm51bGwsImlzYWRtaW4iOmZhbHNlLCJpYXQiOjE3MjE4NDY3ODEsImV4cCI6MTcyMjEwNTk4MX0.IqxMlKPmvMs6gJ7BPFgC3ILP1aeSIChOqa2lN_rXRn0	cf723e9f-f75a-4b94-9634-43880f326743	2024-07-24 18:46:21.394466	2024-07-25 18:46:21	1306
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRvYW5AYXZpYW5zb2x1dGlvbnMuYWVybyIsImlkX3VzZXIiOiI4ZmZhNDhlNi1hY2RlLTQ0NWItYTg0NS05YzQxZTNlYmQ0ZWEiLCJwaG9uZSI6bnVsbCwiaXNhZG1pbiI6ZmFsc2UsImlhdCI6MTcyMTg0Njc5MiwiZXhwIjoxNzIyMTA1OTkyfQ.VLAtZfzT9vwqiSaSVD_GT4CbnJTmUNVYXJqiKQ57Mwg	8ffa48e6-acde-445b-a845-9c41e3ebd4ea	2024-07-24 18:46:32.119356	2024-07-25 18:46:32	1311
\.


--
-- TOC entry 4285 (class 0 OID 17945)
-- Dependencies: 303
-- Data for Name: room; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.room (id_room, id_family, room_name, created_at, updated_at, room_image) FROM stdin;
7	97	Phong ngu cua Giang	2024-06-27 19:01:37.442728	2024-06-27 19:01:37.442728	\N
17	96	Titki	2024-07-01 13:02:31.055742	2024-07-01 13:02:31.055742	https://storage.googleapis.com/famfund-bucket/household/room_bd94ba3a-b046-4a05-a260-890913e09df9_1719838947046
18	96	R	2024-07-02 07:49:46.247782	2024-07-02 07:49:46.247782	https://storage.googleapis.com/famfund-bucket/household/room_bd94ba3a-b046-4a05-a260-890913e09df9_1719906568547
19	96	R	2024-07-02 07:49:47.849163	2024-07-02 07:49:47.849163	https://storage.googleapis.com/famfund-bucket/household/room_bd94ba3a-b046-4a05-a260-890913e09df9_1719906584746
20	96	Ukkk	2024-07-02 13:04:08.447912	2024-07-02 13:04:08.447912	https://storage.googleapis.com/famfund-bucket/household/room_bd94ba3a-b046-4a05-a260-890913e09df9_1719925432846
22	96	Test new room	2024-07-17 01:53:20.239336	2024-07-17 01:53:20.239336	https://storage.googleapis.com/famfund-bucket/household/room_bd94ba3a-b046-4a05-a260-890913e09df9_1721181198914
23	96	Tt	2024-07-30 11:53:29.010219	2024-07-30 11:53:29.010219	\N
24	96	Sân thượng	2024-07-30 13:42:42.923273	2024-07-30 13:42:42.923273	\N
25	96	Phòng tắm	2024-07-30 14:02:10.722113	2024-07-30 14:02:10.722113	\N
26	96	Phòng xông hơi	2024-07-30 14:05:41.104467	2024-07-30 14:05:41.104467	\N
27	96	Phòng ngủ	2024-07-30 22:19:48.938051	2024-07-30 22:19:48.938051	\N
28	96	Phòng ngủ	2024-07-30 22:20:58.248346	2024-07-30 22:20:58.248346	\N
30	96	Phòng ngủ	2024-07-30 22:23:01.692938	2024-07-30 22:23:01.692938	https://storage.googleapis.com/famfund-bucket/household/room_bd94ba3a-b046-4a05-a260-890913e09df9_1722378181069
31	96	Hehe	2024-07-30 22:29:53.034503	2024-07-30 22:29:53.034503	https://storage.googleapis.com/famfund-bucket/household/room_bd94ba3a-b046-4a05-a260-890913e09df9_1722378592720
32	96	Hehe	2024-07-30 23:15:25.900707	2024-07-30 23:15:25.900707	https://storage.googleapis.com/famfund-bucket/household/room_bd94ba3a-b046-4a05-a260-890913e09df9_1722381325524
4	96	Phòng ngủ	2024-06-17 17:50:44.483156	2024-07-31 01:38:40.169748	https://storage.googleapis.com/famfund-bucket/household/room_bd94ba3a-b046-4a05-a260-890913e09df9_1722389919651
5	96	Bếp	2024-06-17 17:50:44.483156	2024-07-31 01:41:57.891069	\N
6	96	Bếp	2024-06-17 17:50:44.483156	2024-07-31 01:42:11.900157	https://storage.googleapis.com/famfund-bucket/household/room_bd94ba3a-b046-4a05-a260-890913e09df9_1722390131604
8	96	Phòng ngủ	2024-06-28 13:24:46.042918	2024-07-31 08:17:25.022024	https://storage.googleapis.com/famfund-bucket/household/room_bd94ba3a-b046-4a05-a260-890913e09df9_1719581860413
9	96	Phòng ngủ	2024-06-28 13:38:30.433448	2024-07-31 08:17:34.610278	https://storage.googleapis.com/famfund-bucket/household/room_bd94ba3a-b046-4a05-a260-890913e09df9_1719581909468
10	96	Hehe	2024-07-01 11:35:53.760392	2024-08-01 00:08:38.842547	https://storage.googleapis.com/famfund-bucket/household/room_bd94ba3a-b046-4a05-a260-890913e09df9_1722470918425
35	96	Phòng ngủ	2024-08-01 00:10:54.71968	2024-08-01 00:10:54.71968	\N
11	96	Hehe	2024-07-01 11:36:09.353962	2024-08-01 00:11:14.895421	https://storage.googleapis.com/famfund-bucket/household/room_bd94ba3a-b046-4a05-a260-890913e09df9_1722471074536
16	96	Hehe	2024-07-01 12:38:54.057626	2024-08-01 00:17:06.788109	https://storage.googleapis.com/famfund-bucket/household/room_bd94ba3a-b046-4a05-a260-890913e09df9_1722471426422
\.


--
-- TOC entry 4287 (class 0 OID 17953)
-- Dependencies: 305
-- Data for Name: shopping_item_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shopping_item_types (id_item_type, item_type_name_en, item_type_name_vn, icon_url) FROM stdin;
1	Pet Supplies	Đồ dùng cho thú cưng	https://lh3.googleusercontent.com/drive-viewer/AKGpihaDEJOZrOwMaR554S4QdMPuusyRPTwR4cwf2t5jaehGsmZ4mnszy2rU-X0yf2OC_iLOUfPFI-44TlqxmqSDmuMGKdA4e_akuok=s2560
2	Meat and Seafood	Thịt và Hải sản	https://lh3.googleusercontent.com/drive-viewer/AKGpihaH6tJY2gow76DFc2xpY8tcPZKA42j9IuOw3bK08iVbNfIDCk0F_uqvewlCe3r4_yPj9XIPnoetaf-ZqloAsI0z3-8p__bHzw=s2560
3	Dairy	Các nguyên liệu từ sữa	https://lh3.googleusercontent.com/drive-viewer/AKGpihZI0djaBIgIkVQ7HmhRor1kj3ydcdZzsynOK21JqFaUA3_Vf1OOl-nqdNbpLc5r4eG0fXfZFFRGWDzpGSTf2OS8CXSbMc1Zow=s2560
4	Bakery and Cereal	Bánh mì và Ngũ cốc	https://lh3.googleusercontent.com/drive-viewer/AKGpihZ5l2x9qhpd_BZYpdIkeKYxaVr2Qmh_QnWtzTUu5CcZTun_IQupwwUN2VpH5SI3vaQr1YjJvvsLvqNT0mxOC4-2oj-Y2sC8lR8=s2560
5	Personal Care	Chăm sóc cá nhân	https://lh3.googleusercontent.com/drive-viewer/AKGpihYBB9kqqKFISeIGA6xKM2epFT1FdNt_ZUh4t4NMLJcfh8m9BbOLSQ6EwGhhsHZdIN0m9lVongx3groI3Fr84RDH1q4DqGztkpc=s2560
6	Frozen Foods	Thực phẩm đông lạnh	https://lh3.googleusercontent.com/drive-viewer/AKGpihZ5s3LknUtLP59DkB00D2g5viVES2yMGVGLcz8ONnVHDb6id-HzinMYxXz6e7dqnltL719fJL2kUyuktTpdHGr2fVkw-qYC_Es=s2560
7	Condiments	Gia vị	https://lh3.googleusercontent.com/drive-viewer/AKGpihalXvtWCowx-iSygwdUXAEOu935uakKLi6VBNlZsMdvrLeKECklyuO1lygVyHW-qthkGLP-IGs7BJ8gVqmB_1sO6f3h3bWCwps=s2560
8	Beverages	Đồ uống	https://lh3.googleusercontent.com/drive-viewer/AKGpihZWXhoaHb8ddX6_AWxFbhpZS4kQp3UbjAKJjk8Xr_T5ovG6aCfF3tYU87jBcJxKMMMIQCh3f4ovXs6ldNZXBxteoY10L-_IEg=s2560
9	Car Accessories	Phụ kiện ô tô	https://lh3.googleusercontent.com/drive-viewer/AKGpihY3sK3RdTd_NXRR_bznPlDqRILHK-5Hu9K0G_AKzDfKTDiU4ZERuyV7OQFYpy02ZrSxUq5zvn1bumOVnb1zoFgVXOhHp8UWzjE=s2560
10	Mobile Accessoriesd	Phụ kiện di động	https://lh3.googleusercontent.com/drive-viewer/AKGpihZSfRvZ5vPvYDaDw4ME2Ad6VbBDlOAC4MNSif_Tuo3KAFIv2yEyplLgu2uyPoKRzgotJ1Yk8_WHF_rwVrWM3BnP7v0TYDBZEZU=s2560
11	PC Accessories	Phụ kiện máy tính	https://lh3.googleusercontent.com/drive-viewer/AKGpihaU158qfOwxggi5IO435gGinopR9xmdM2S_NNNgjDgoZUExp_g1FElN9wX8tmj5LJCn6LAr8QnmZ5Cy32f4So2mvWGGo8xDWAQ=s2560
12	Home Appliances	Thiết bị gia dụng	https://lh3.googleusercontent.com/drive-viewer/AKGpihauuvvDqxfq493vvS2HvAAgTxOhhmInXuaOq1lwuWnOmLOcmHdz0_fStbVYN56juoGEPDO8VnrIRBZfw0x8WLAACLQBXbeAFl0=s2560
13	Audio and Visual	Âm thanh và Hình ảnh	https://lh3.googleusercontent.com/drive-viewer/AKGpihbRCFCx2xZSpIROVaoue2yPHFJsuzeu_sTQqU4utwa5M0q93K23Rz-eRHRfulRGFy_H9habPypIJlYjOThC6od8U5yo7oHIRE8=s2560
14	Cameras	Máy ảnh	https://lh3.googleusercontent.com/drive-viewer/AKGpihZxf5HPXHVMN482nT5Aio4Etpni0jDGEPyRf7R-MerrZirgjn2dcVzejsgEzOYhrD96OrPtaNFkt78KhPfPCw2x7keSqdfBr1E=s2560
15	Gaming Devices	Thiết bị chơi game	https://lh3.googleusercontent.com/drive-viewer/AKGpihY-9iQ4u6V12ciUwEwyssNV_JArlKL0ZhhfgB6PDIaTHnWkMivi5XrZy91w5utMBXQIyfIgy1XRC7Xm6exBfKBX08P9136HEjg=s2560
16	Wearable	Thiết bị đeo tay	https://lh3.googleusercontent.com/drive-viewer/AKGpihY5kSdZNHqbWy2YgMVzCa9y9kxsADxZjjTmhtZ3wpz88Oq84VfAyIXwGcc9WS7DHIphXcuzptlhwiSP_4LJ-eqhKatMqsddfsM=s2560
17	Activewear	Đồ thể thao	https://lh3.googleusercontent.com/drive-viewer/AKGpihbJ7SAZAQNtpQipo47OloAW65HW_9e2XWCe1Rwyp3lepax66q6O_q2gLH_TBiF71FMrMKoYT1iZ-MlDQtIax9Okk-dwsz7VheY=s2560
18	Men	Nam	https://lh3.googleusercontent.com/drive-viewer/AKGpiha9jItVP1NR77KVGIjohxIEi-d7RF2JAieQ7Sin2qzDBnAp8wJ7f3sbDns5ECRegIfIm1rL8eZkJsmRXFpeguWPedBYNL8pM28=s256
19	Women	Nữ	https://lh3.googleusercontent.com/drive-viewer/AKGpihbmvfzQPw5qZM6sdNS7Qm4DXEUnZeiN2bemdkH9ODSaj7UtmlR3QeB8Jmv2ER7HzwdvRhAFQd5CDv7Om3jGewwG22r3NnLnTHs=s2560
20	Children	Trẻ em	https://lh3.googleusercontent.com/drive-viewer/AKGpihZ4wE-CMq2WTmiGc116EGATxuygWAucYmqUDev1WFLN6H0dM8kVbzyMn4KUxOLafjtW8Uw6JipxQ0TT0PZEG8okLTEBBAt23w=s2560
21	Footwear	Giày dép	https://lh3.googleusercontent.com/drive-viewer/AKGpihZ_jQUe9lLPrVErbzoKlTyyVH3p6iFC7wnJKlhHOwueo4zHKLjdvKKqWQiLxeGEFj8li8w9QbMKFK6E_xJuKfBvkS8K8QuouA=s2560
22	Accessories	Phụ kiện	https://lh3.googleusercontent.com/drive-viewer/AKGpihbC_kQm3hxtFaPZPNuC1L_d98VvrBkbod9BTcDl5qch1t_EYSa3NQlnzjC1hMQiy9xrgpfsh2wvI9CkfxN_cvQXEPT5s6D6KPc=s2560
23	Swimwear	Đồ bơi	https://lh3.googleusercontent.com/drive-viewer/AKGpihbjWkJNahsxxFAg2jdiBbq0sF0MEkbFa-KpOHorstpomriyL8w4m59B0BWm13mS-oBnf9xJbwTYn8j7cNLGjYNOeOEhCxLaG3E=s2560
24	Sleepwear	Đồ ngủ	https://lh3.googleusercontent.com/drive-viewer/AKGpihZ7oRTzLLcqqTOJS4WX21sSpkw8aIPdm-L5UD91f240s5uzHM1rO9fRfeCov7910l2T3Z19blibxBBxXcQshvlwZ2XSL3b--u8=s2560
25	Kitchen	Nhà bếp	https://lh3.googleusercontent.com/drive-viewer/AKGpihaTOODORFjhrYFKTMG_YCfF0NU1vRjZeLEFqatcxENYo5gVc8-I5uWh2TAZ-GIpzY0BSBb210FaXlZuspKHfB4ut8jbxTjsw9Y=s2560
26	Living Room	Phòng khách	https://lh3.googleusercontent.com/drive-viewer/AKGpihZXzSVd8K4FrlIEgkP9rCd-Lz7IbQseZV3uvKJtwapqhxMnA-gVfGrmEp0jFh6bPVfjjuNiie2g-Zy8jDoHmWt63kuqzlik2A=s2560
27	Bedroom	Phòng ngủ	https://lh3.googleusercontent.com/drive-viewer/AKGpihaxZ_z_wv2ITVhHdZxXW09CUq3HgV9x-YTu6fjo5ntLOU3kaoRzS7USPzh2C1lGvpPKBO_qUIoWoYuMWVFZ-VzcMLK6Wpfu4g=s2560
28	Dining Room	Phòng ăn	https://lh3.googleusercontent.com/drive-viewer/AKGpihZ0bJ6I6kJ9XVQnR_gmZAXKZ6vdXEa-r6MzUN2u5TwbSzKy5PYgjTGfdcBp44b4IgYcY3JzctHnp1MdoetRtQokKZpmaHKa1Sc=s2560
29	Home Office	Phòng làm việc	https://lh3.googleusercontent.com/drive-viewer/AKGpihYBop2qRR9lYWBlr5BgtoExKUvw46-oG88MyXFX8VliZWSAU1hw1hIsoqHja7-tnMMu0AcDu5ijZV8euT8Tran1VmHXsBu_mCM=s2560
30	Kid Furniture	Đồ dùng trẻ em	https://lh3.googleusercontent.com/drive-viewer/AKGpihYIFmv0p2mQHogRdt4rTMpa38M6VuNAQXZ1W0ybmeehsfcs8fqWFyakfsLQHJsoY12cgMx5VrokhOsR3LXAluv16KmMU0gSvjs=s2560
31	Outdoor	Ngoài trời	https://lh3.googleusercontent.com/drive-viewer/AKGpihajFQ8DgurqGOMlRwccpp4YKYgiVHYu-r9qTdRw0SuVIBKPtPxD4aIfG_IaCJ3fD7cn1ajJRrpANVaZB6A2Iqduyxk4BPrg-qY=s2560
32	Decor	Trang trí	https://lh3.googleusercontent.com/drive-viewer/AKGpihaRgQgM_onxG93nJ5DVs8PY_IY7lJ8Ofm4Al3588C9hp11BBZCnkGwPTz4UypySYCmOKjrYAyv7pk7z1Dvds7QJvPBhpQV7IhY=s2560
33	Eye Care	Chăm sóc mắt	https://lh3.googleusercontent.com/drive-viewer/AKGpihaCpuDZx7IywBkgXj53kFDG2IMRzqvYZNa_ROm_5XuVND3kDDiNdIW0akhFfRiCGt9cAIHpGfkiNWYOi5EK9W7laxhHDxoLsw=s2560
34	Skincare	Chăm sóc da	https://lh3.googleusercontent.com/drive-viewer/AKGpihaUU1tPHpL19wfGc1dCYtGaB3qhZtgsPdxFdicYu5bWNxdb7tZIH9oGipZv7V1eS-sKHh_ppKw817QPm3xuOJeCrj6CZGMOa98=s2560
35	Oral Care	Chăm sóc răng miệng	https://lh3.googleusercontent.com/drive-viewer/AKGpihZydT5NWQOfTZ_4h34vu3CMWAW-C63iLqX3_8TElNCabq5dH8oY_B3uVgbx4cbMRBiEG6I56cdQLIVXSwfdj_ZGXlu7XiLjPg=s2560
36	Vitamin	Thực phẩm bổ sung	https://lh3.googleusercontent.com/drive-viewer/AKGpihZ5MnpH7MYHQKnNyRsKY9Icl-PyVU0jsToRRkOC9wQ7QYyJu5tt68KV0ZtUKjAbHun9bD2uk5okn11NxoIXNcFzJHk7geaqi_I=s2560
37	Baby Care	Chăm sóc trẻ em	https://lh3.googleusercontent.com/drive-viewer/AKGpihbAzxLlY1QYJmwRUhctblrI4n43MB1yJVXns65I4xSSex7QKbrql5VMy3mDYIYudLVDM5n_2zPRPIho6bi_i0Tj2Hjdk2CnvA=s2560
38	Medicine	Thuốc	https://lh3.googleusercontent.com/drive-viewer/AKGpihb86IiwZHeY7tiC6huCns65RnXG2ToCaY0txZdh3V1-OmnsnPZYfa-PosmuUdodeMHy2bm4vmrtE3zAhHU3MrM5x8mRbE4UyQ=s2560
39	Medical Device	Thiết bị y tế	https://lh3.googleusercontent.com/drive-viewer/AKGpihZU9_ZXW7SZm1YVyO1wBFmPYF4KHtj7LbYtOCulQuC1Ce9Iu3qEE3RXQMpEGooh_yiWU1VaMDuPYm2X9sbDbLeTUyCm7os8-Pk=s2560
40	Health Aids	Hỗ trợ vết thương	https://lh3.googleusercontent.com/drive-viewer/AKGpihZWX2v09Ky4CDUAc1tQP0TF4Xw1h6zPhNG9hsjVIHpqTOpKcNpSsfhtWhGr0kxg5UqXDtjEfVTKNOfy5FBZJKFYv1U_2xS4pzY=s2560
\.


--
-- TOC entry 4289 (class 0 OID 17959)
-- Dependencies: 307
-- Data for Name: shopping_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shopping_items (id_item, id_list, id_item_type, item_name, description, quantity, is_purchased, priority_level, reminder_date, created_at, updated_at, price) FROM stdin;
3	3	2	cái giấy	string	2	f	10	2024-08-01 00:00:00	2024-07-09 18:19:09.290533	2024-07-09 18:19:09.290533	0
\.


--
-- TOC entry 4291 (class 0 OID 17972)
-- Dependencies: 309
-- Data for Name: shopping_list_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shopping_list_types (id_shopping_list_type, type_name_en, type_name_vn, icon_url) FROM stdin;
1	Grocery	Đồ tiện ích	https://lh3.googleusercontent.com/drive-viewer/AKGpihahGJF-dAf1yhQko8CVnyvFriHQCV5qlEvmMjMWs4OmrQ_JDF0TGtXP4Niw10R2MaIBl_pKnF12euCY_cexCTZ74cVRLf2oyRE=s2560
2	Electronics	Đồ điện tử	https://lh3.googleusercontent.com/drive-viewer/AKGpihaUEnaKPphCJn0Z-2awtyqkB-u2Ft1ok1UgVSSCi4xvFuWTpfPwhRkbCIONNOJ4KCSvL0qiLjfHVKcHuSlbt3MCxg8sLMgmo5A=s2560
3	Clothing	Quần áo	https://lh3.googleusercontent.com/drive-viewer/AKGpihb0mFk9lA_KBFPqChxgrV6bgpl_ZlR4gFyEHdJeuTYwppklOyw-DbSakTRb7bOoYpNHiqSa77sS-DuLF4weCJUlpY06PJbLDcc=s2560
4	Furniture	Nội thất	https://lh3.googleusercontent.com/drive-viewer/AKGpihZrhYKnXRk8P1S8XHRMuDDrZWkEQiUzxD6OL7HEWLV1_95NuRAYBMRyY0Q_iOUYZaMLitBqqnUPQLdEh3UPz9MkPHn45p0jVq0=s2560
5	Pharmacy	Thuốc men	https://lh3.googleusercontent.com/drive-viewer/AKGpihZL7hzC_4JG26e0VqzWk4D4sIwpcUDwu-2cQykYIBuq6aMD-Ak6rJOvuImraQU-9_KcjL3xaGfavtaYW98ZYb9chM92Pl1DvKY=s2560
6	Other	Khác	https://lh3.googleusercontent.com/drive-viewer/AKGpihYggGhyOFyUPRm7VyJcZLkBADL-GiGfZuengKF_62XJHmTLJHNHGV3e4YAH2T4yKH4HWH3BgibtYHjWQqJEQ7gehz5uKm-utcY=s2560
\.


--
-- TOC entry 4293 (class 0 OID 17978)
-- Dependencies: 311
-- Data for Name: shopping_lists; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shopping_lists (id_list, id_family, title, description, created_at, updated_at, id_shopping_list_type, status, id_expenditure) FROM stdin;
4	96	test	test shopping	2024-07-09 18:15:43.468335	2024-07-09 18:15:43.468335	2	IN_PROGRESS	\N
3	96	string	string	2024-07-09 18:13:20.803883	2024-07-09 19:01:45.513436	2	COMPLETED	\N
\.


--
-- TOC entry 4295 (class 0 OID 17987)
-- Dependencies: 313
-- Data for Name: subject; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subject (id_subject, id_education_progress, subject_name, description, component_scores, status, midterm_score, final_score, bonus_score) FROM stdin;
3	4	Đại số tuyến tính	GVLT: Nguyễn Văn A, GVTH:  Phạm Thị B	[{"component_name":"tssts","score":6},{"component_name":"Gg","score":0}]	in_progress	\N	\N	\N
6	4	Toán tổ hợp	GVLT: Nguyễn Văn A, GVTH:  Phạm Thị B	[{"component_name":"test","score":1.1}]	in_progress	\N	\N	\N
55	10	Test create new subject	Lorem ipsum dolosit amet	\N	in_progress	\N	\N	\N
10	1	Math 3		[{"component_name":"Test name","score":6}]	in_progress	\N	\N	\N
9	1	Math 1	Mathematics 2	\N	in_progress	\N	\N	\N
56	10	Test create new subject 01	Lorem ipsum dolosit amet	[{"component_name":"test point 1","score":5}]	in_progress	\N	\N	\N
14	10	Pop		\N	in_progress	\N	\N	\N
15	10	Pipi		\N	in_progress	\N	\N	\N
11	10	Ee		[{"component_name":"test test","score":5}]	in_progress	\N	\N	\N
12	10	Tesr		[{"component_name":"test tt","score":5}]	in_progress	\N	\N	\N
16	11	M1		[{"component_name":"Quiz 1","score":0},{"component_name":"Quiz 1","score":0},{"component_name":"Quiz 1","score":0},{"component_name":"Quiz","score":0},{"component_name":"quiz","score":0}]	in_progress	\N	\N	\N
13	10	Tt		[{"component_name":"123","score":2}]	in_progress	\N	\N	\N
52	47	Figma	Giang hoc Figma	\N	in_progress	\N	\N	\N
51	4	Ok		[{"component_name":"Ok","score":0},{"component_name":"Ok","score":0}]	in_progress	9.1	2.1	\N
53	4	Mathhhh	Oke	\N	in_progress	\N	\N	\N
5	4	Xác xuất thống kê 2	GVLT: Nguyễn Văn A, GVTH:  Phạm Thị B	[{"component_name":"Test","score":0}]	in_progress	\N	\N	\N
50	4	Figma		[{"component_name":"tsstwset","score":7}]	in_progress	\N	\N	\N
90	85	Mathematics	Advanced algebra and geometry	[{"component_name": "Homework", "score": 80}, {"component_name": "Quizzes", "score": 85}]	completed	75	88	5
91	85	English	Literature and composition	[{"component_name": "Essays", "score": 90}, {"component_name": "Projects", "score": 95}]	completed	85	90	2
92	85	Science	Physics and chemistry basics	[{"component_name": "Labs", "score": 78}, {"component_name": "Exams", "score": 82}]	completed	80	85	0
93	85	History	World history overview	[{"component_name": "Reports", "score": 88}, {"component_name": "Presentations", "score": 92}]	completed	80	87	3
94	86	Mathematics	Trigonometry and pre-calculus	[{"component_name": "Homework", "score": 70}, {"component_name": "Quizzes", "score": 75}]	in_progress	65	78	4
95	86	English	American literature	[{"component_name": "Essays", "score": 85}, {"component_name": "Projects", "score": 80}]	in_progress	75	80	1
96	86	Science	Biology and earth science	[{"component_name": "Labs", "score": 72}, {"component_name": "Exams", "score": 77}]	in_progress	70	78	0
97	86	History	American history	[{"component_name": "Reports", "score": 80}, {"component_name": "Presentations", "score": 85}]	in_progress	75	82	2
98	87	Mathematics	Calculus and statistics	[{"component_name": "Homework", "score": 85}, {"component_name": "Quizzes", "score": 88}]	completed	80	90	3
99	87	English	British literature	[{"component_name": "Essays", "score": 95}, {"component_name": "Projects", "score": 90}]	completed	85	92	2
100	87	Science	Chemistry and physics	[{"component_name": "Labs", "score": 88}, {"component_name": "Exams", "score": 90}]	completed	85	90	0
101	87	History	European history	[{"component_name": "Reports", "score": 90}, {"component_name": "Presentations", "score": 88}]	completed	82	87	4
102	88	Mathematics	Advanced calculus	[{"component_name": "Homework", "score": 78}, {"component_name": "Quizzes", "score": 82}]	in_progress	75	85	3
103	88	English	Modern literature	[{"component_name": "Essays", "score": 88}, {"component_name": "Projects", "score": 85}]	in_progress	80	87	1
104	88	Science	Physics and advanced biology	[{"component_name": "Labs", "score": 82}, {"component_name": "Exams", "score": 85}]	in_progress	80	87	0
105	88	History	Modern history	[{"component_name": "Reports", "score": 85}, {"component_name": "Presentations", "score": 88}]	in_progress	80	85	2
106	89	Mathematics	Basic arithmetic	[{"component_name": "Homework", "score": 75}, {"component_name": "Quizzes", "score": 80}]	completed	70	82	5
107	89	English	Basic grammar and composition	[{"component_name": "Essays", "score": 85}, {"component_name": "Projects", "score": 80}]	completed	75	82	2
108	89	Science	Introduction to science	[{"component_name": "Labs", "score": 80}, {"component_name": "Exams", "score": 85}]	completed	78	83	0
109	89	History	Introduction to history	[{"component_name": "Reports", "score": 88}, {"component_name": "Presentations", "score": 90}]	completed	80	85	3
110	90	Mathematics	Basic algebra	[{"component_name": "Homework", "score": 80}, {"component_name": "Quizzes", "score": 85}]	completed	75	88	5
111	90	English	Introduction to literature	[{"component_name": "Essays", "score": 90}, {"component_name": "Projects", "score": 95}]	completed	85	90	2
112	90	Science	Introduction to physics	[{"component_name": "Labs", "score": 78}, {"component_name": "Exams", "score": 82}]	completed	80	85	0
113	90	History	World history basics	[{"component_name": "Reports", "score": 88}, {"component_name": "Presentations", "score": 92}]	completed	80	87	3
114	91	Mathematics	Intermediate algebra	[{"component_name": "Homework", "score": 70}, {"component_name": "Quizzes", "score": 75}]	in_progress	65	78	4
115	91	English	American short stories	[{"component_name": "Essays", "score": 85}, {"component_name": "Projects", "score": 80}]	in_progress	75	80	1
116	91	Science	Earth science	[{"component_name": "Labs", "score": 72}, {"component_name": "Exams", "score": 77}]	in_progress	70	78	0
117	91	History	American history basics	[{"component_name": "Reports", "score": 80}, {"component_name": "Presentations", "score": 85}]	in_progress	75	82	2
1	1	Math 2	Mathematics	[{"score":9},{"component_name":"Homework 1","score":8.9},{"component_name":"Homework 1","score":8.9},{"component_name":"Homework 1","score":8.9}]	done	\N	\N	\N
118	92	Mathematics	Linear Algebra	[{"component_name": "Assignments", "score": 90}, {"component_name": "Exams", "score": 88}]	completed	85	92	2
119	92	Computer Science	Introduction to Programming	[{"component_name": "Projects", "score": 85}, {"component_name": "Quizzes", "score": 90}]	completed	80	88	3
120	92	Physics	Mechanics	[{"component_name": "Labs", "score": 78}, {"component_name": "Problem Sets", "score": 82}]	completed	75	80	0
121	92	Economics	Microeconomics	[{"component_name": "Essays", "score": 88}, {"component_name": "Presentations", "score": 90}]	completed	82	87	1
122	93	Mathematics	Differential Equations	[{"component_name": "Homework", "score": 75}, {"component_name": "Midterm", "score": 80}]	in_progress	70	85	4
123	93	Computer Science	Data Structures and Algorithms	[{"component_name": "Assignments", "score": 80}, {"component_name": "Exams", "score": 85}]	in_progress	78	82	1
124	93	Chemistry	Organic Chemistry	[{"component_name": "Labs", "score": 72}, {"component_name": "Quizzes", "score": 77}]	in_progress	70	75	0
125	93	Psychology	Introduction to Psychology	[{"component_name": "Papers", "score": 85}, {"component_name": "Class Participation", "score": 90}]	in_progress	82	88	2
126	94	Mathematics	Probability and Statistics	[{"component_name": "Projects", "score": 90}, {"component_name": "Final Exam", "score": 95}]	completed	88	92	3
127	94	Computer Science	Web Development	[{"component_name": "Website Project", "score": 95}, {"component_name": "Quizzes", "score": 90}]	completed	90	93	2
128	94	Biology	Genetics	[{"component_name": "Labs", "score": 85}, {"component_name": "Exams", "score": 88}]	completed	82	87	0
129	94	Sociology	Social Inequality	[{"component_name": "Essays", "score": 88}, {"component_name": "Group Project", "score": 92}]	completed	85	90	1
4	4	Math	Mathematics	[{"component_name":"D","score":2},{"component_name":"Uuuu","score":3},{"component_name":"Oooii","score":4}]	in_progress	9	9	10
130	98	Đại số		\N	in_progress	\N	\N	\N
131	99	Đại số tuyến tính 		\N	in_progress	\N	\N	\N
132	100	Đại số		\N	in_progress	\N	\N	\N
133	101	Math 1		\N	in_progress	\N	\N	\N
\.


--
-- TOC entry 4206 (class 0 OID 17462)
-- Dependencies: 223
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id_user, email, phone, password, language, twofa, created_at, updated_at, isphoneverified, isadmin, firstname, lastname, isemailverified, avatar, login_type, birthdate, genre, is_banned, salt) FROM stdin;
0bff9432-04f8-4fa3-8974-c1247d7695ad	kimchi123@gmail.com	+84971308231	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	\N	f	2024-07-24 18:05:40.058993	2024-07-24 18:05:40.058993	t	f	Bành	Toàn	t	\N	local	2002-06-20	male	f	9f86d081884c7d659a2feaa0c55ad015
c486da5d-a09f-4521-99f0-0003814c814c	banhhaotoan2001@gmail.com	+84971308620	dbdb497ab18dcf977afba55d999d76b00b63002db995af2ff8cdbfb89be13db8	\N	f	2024-07-24 18:23:51.353382	2024-07-24 18:23:51.353382	t	f	Bành	Toàn	t	\N	local	2002-06-20	male	f	c03134f418e96c92a6e2ae9b8bfe8278
df3f9f58-5821-4a95-a6cd-de8f7d79580d	banhhaotoan2001@gmail.com	+84971308620	3f4a820a553665ca4d0f113f79f4562e03ccb2f0cee751dffdb3e9d6c3e3807d	\N	f	2024-07-24 18:23:51.348572	2024-07-24 18:23:51.348572	t	f	Bành	Toàn	t	\N	local	2002-06-20	male	f	40ab780ca25c66226a2e2103bdebe2f0
addfb4ac-4895-4fec-be39-d3e935d94e2a	tam.dev.4693@gmail.com	\N	\\xc30d040903020e54c9ffa752cad06fd23601a54544e5cc91642100c455a8cfdf5278ffe2cc4c6bc9b62111a61da1f8e748bc359c188ea8e23449d73eb625ebdc7d5362caca79d0	\N	f	2024-06-20 16:08:10.459101	2024-06-20 16:08:10.459101	t	f	Tâm	Trần	t	https://lh3.googleusercontent.com/a/ACg8ocIsy4pOPhC-7RgIR_h2GXdFBdqlZCFW5kHaerL_6H2ZFPzdkw=s96-c	google	2011-02-27	male	f	9f86d081884c7d659a2feaa0c55ad015
386e7ca1-cbe5-4a61-8b1b-8e31643d6cc6	dtgiang20@clc.fitus.edu.vn	+84982900108	0b099a90425ff29b96b0f73d2b40e5be97beba31f722017f1c26041bdb32a46f	\N	f	2024-07-29 18:57:03.137373	2024-07-29 18:57:03.137373	t	f	Quảng	Linh	t	\N	local	1995-07-29	female	f	8bb7f3ff27e18f2df65818228f9a6e33
10ae4605-bd00-4f81-a599-a4f8f593c1a8	bhtoan20@clc.fitus.edu.vn	\N	\\xc30d0409030201471155db9bef3267d2410163a099a8d80af03b37ff053b69627caa8ac90fc37fa24f321c5557471b0b4e8db452a4c46227e8ed16adf4bfff531599450b25eb1c669dea9454cf2330d67749	vn	f	2024-03-28 04:03:40.365	2024-03-28 04:03:40.365	t	f	Toàn	Bành Hảo	t	https://lh3.googleusercontent.com/a/ACg8ocIxQAZ7XmRmdN1ppyPz7QVqRCIbh6u2G31gOrrt2QYP=s96-c	google	2004-07-15	female	f	9f86d081884c7d659a2feaa0c55ad015
2082eded-d0bd-46a5-a62d-1bed3839a6e9	phamgiangthaiduong1@gmail.com	\N	\\xc30d04090302096620f5eb0f99d279d24101f3d2da7411035832716ea452d75674d917b1a993950a352eab443f100920ff2d4a493a7e0d065fcc6a66bdd685be07b42c0d7ca2ae7a522d1b1f4e20fdbd2d21	vn	f	2024-04-02 15:00:57.069	2024-04-02 15:00:57.069	t	f	Dương	Phạm	t	https://lh3.googleusercontent.com/a/ACg8ocII5abzCQa4E4Z2N-YRqWy5ep1Cpcsn3rxtBkfCOGDI=s96-c	google	2006-07-07	female	f	9f86d081884c7d659a2feaa0c55ad015
67eeebe5-774f-4dc1-8f11-77eef7b630da	thaiduong032002@gmail.com	\N	\\xc30d04090302bbee8d7ee6cba33774d24101c8e66eefee5a07217d7c4db2f01a8b4054bb4cc75b28a22b179dc5ed12c17be746975caeed91997ab54642183b5f349e74ea22f87d606d4ce7e8af5b0ffd7a05	vn	f	2024-04-03 13:54:13.718	2024-04-03 13:54:13.718	t	f	Thái	Dương	t	https://lh3.googleusercontent.com/a/ACg8ocIfJxZjtlw50ZsvRWgM8cIJp5mW3zYmQw6jnGohBSoo=s96-c	google	2011-05-03	male	f	9f86d081884c7d659a2feaa0c55ad015
d127be7d-7e58-4090-a332-88a7cba778e4	bhtoan20@clc.fitus.edu.vn	+84971308624	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	vn	f	2024-06-09 13:07:53.259145	2024-06-09 13:07:53.259145	t	f	Bành	Toàn	t	https://static.vecteezy.com/system/resources/previews/020/911/740/non_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png	local	2008-10-26	female	f	9f86d081884c7d659a2feaa0c55ad015
28905675-858b-4a93-a283-205899779622	tthien@gmail.com	+84886725044	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	vn	f	2024-03-11 15:08:54.552	2024-03-20 20:24:06.62	t	f	Hiền	Thu	t	https://storage.googleapis.com/famfund-bucket/avatar/avatar_28905675-858b-4a93-a283-205899779622_1717948664029_77E37648-6EDA-406D-920A-2B32C9E3F0F5.jpg	local	2002-06-07	female	f	9f86d081884c7d659a2feaa0c55ad015
db31bfb8-ec15-4cb1-9cbe-ebe3edaca323	klong31122001@gmail.com	+84974649112	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	vn	f	2024-03-27 12:50:46.067	2024-03-27 12:50:46.067	t	f	Tang	Long	t	https://static.vecteezy.com/system/resources/previews/020/911/740/non_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png	local	2007-08-18	male	f	9f86d081884c7d659a2feaa0c55ad015
594b1d0d-86fe-4534-b1c7-52ec7a2667c3	tranthuhao70@gmail.com	\N	\\xc30d04090302a1d81678fb0f502a73d23601425ef30dc93089ac56e0ccc95c21bf9c786b3698e58eb619117404a5c20d8187937d2111c76a0759a5b69a53b103343ae671a29e79	vn	f	2024-06-08 15:38:39.043808	2024-06-08 15:38:39.043808	t	f	Hảo	Trần Thu	t	https://lh3.googleusercontent.com/a/ACg8ocL-T5eV34eNepeBlRwDwJ1dw2AKNrnkwR6VTZ1Uu5vm8gob04o=s96-c	google	2008-02-18	female	f	9f86d081884c7d659a2feaa0c55ad015
e05be2ad-8a6b-433d-8dd4-65efb36d4318	tthien20@clc.fitus.edu.vn	\N	\\xc30d0409030289b49b07c801d3907cd2360190501629ecfd8c198feb8e3fdca55b04ca9e1a98ea4b59273594db38f9b3197b7d101f748b0d318f40528b365cd3588b0106f3d42d	vn	f	2024-06-08 15:38:48.040008	2024-06-08 15:38:48.040008	t	f	Hiền	Trần Thu	t	https://lh3.googleusercontent.com/a/ACg8ocKuA9Ifzij_qRUK39yD1k_cTnh7SQ-MgS2_gEB0IZair21u5A=s96-c	google	2003-03-25	female	f	9f86d081884c7d659a2feaa0c55ad015
a86feee2-cb93-4a11-a724-35b2a0630b1e	mjkundta@gmail.com	\N	\\xc30d040903025f0c02916c72645267d23601c540374092e82a3f2f288b698adaa70359f044ef295901de701f9ba1ade1c37b665e3532879181ae6343cc939af814f3cb13e9892b	vn	f	2024-06-08 15:40:53.977638	2024-06-08 15:40:53.977638	t	f	Toàn	Hảo	t	https://lh3.googleusercontent.com/a/ACg8ocLFVA7t5HwYGRu2RExT20AMUFKS43XzKcMgbFZCr_aljNn_g9pp=s96-c	google	2017-09-04	male	f	9f86d081884c7d659a2feaa0c55ad015
006a77b5-7198-4046-9c0c-9732e4929d22	duongthanhgiang0.0108@gmail.com	+84982900108	6d84127849ad278da8703c3886ae806ce577158330bbc75b1e34d512427c6316	\N	f	2024-07-29 03:33:52.77112	2024-07-29 03:33:52.77112	t	f	Quảnh	Linh	t	\N	local	1995-07-29	female	f	f8bba7ef203fdcfc172872ed50f9ae34
28a399c7-b9b9-4ac0-93fb-197bc9ea7ef6	duongthanhgiang0.0108@gmail.com	+84982900108	3da119490089ea36f8df5b6e02d9a3e9feb4940d5034eb48c76d30e830cce6aa	\N	f	2024-07-29 02:55:32.471714	2024-07-29 02:55:32.471714	t	f	Linh	Linh	t	\N	local	1995-07-29	female	f	ec5eff1fadb4f0ab2ad3d6f9c258ddac
65c370fa-5aec-4569-90c4-60085677118d	duongthanhgiang.0108@gmail.com	+84982900108	aa56869fc061ceed749a24806b2946133b2694f0f26b892ee7ab96fc73b6c0c1	\N	f	2024-07-29 03:48:15.519953	2024-07-29 03:48:15.519953	t	f	Quảng	Linh Linh	t	\N	local	1995-07-29	female	f	29ebb188954778001436a4fe308dcf07
a6a98cf9-7c93-42e6-ba11-a7b3e8a74d52	dtgiang.cv@gmail.com	+84982900108	c47ead9d8353b6f6cadffffb983e9208e2b258e529f5b11192e7ee365e317ba1	\N	f	2024-07-28 23:55:14.6302	2024-07-28 23:55:14.6302	t	f	Quảng	Linh Linh	t	\N	local	1995-07-28	female	f	f7e8b17cb619aec009805aec895e3d49
582b8356-8618-413a-bcf4-94cbd644c370	duongthanhgiang0.0108@gmail.com	+84982900108	493ce726245a4d757e8e72742aca0ceecde567fcb82acaf6b0990d72186d00b6	\N	f	2024-07-29 14:25:32.12333	2024-07-29 14:25:32.12333	t	f	Quảng	Linh	t	\N	local	1995-07-29	female	f	a5d75542172dc50399fe10dcbf244eed
f86cc2fe-5c10-42c8-90ac-0e3989cfb155	dtgiang.cv@gmail.com	+84982900108	95362075f8e0b1c0234e8e42872fab8a54c2dd8ffd4c38525c89c1d9b4272173	\N	f	2024-07-29 00:24:11.063932	2024-07-29 00:24:11.063932	t	f	Quảng	Linh Linh	t	\N	local	1995-07-28	female	f	c0fe7794b705c9295863a806ddb59e9f
4aa89e9c-24c6-42a4-8eb1-49133eda8561	duongthanhgiang0.0108@gmail.com	+84982900108	60496db361bf48a4ec7a6e8a810da00c507da38c7730f5a7870d47d8af200386	\N	f	2024-07-29 00:39:14.147672	2024-07-29 00:39:14.147672	t	f	Quảng 	Linh Linh	t	\N	local	1995-07-29	female	f	29dc1d64d5f4bccedd8af3b3eb45a376
7405d1e3-1d8f-423a-ac78-eaa397f702e3	duongthanhgiang0.0108@gmail.com	+84982900108	3c0b0913bf02a21ed262cf16607ab60afe484672703408b7ea7bcdff2d0d46b5	\N	f	2024-07-29 03:29:44.738102	2024-07-29 03:29:44.738102	t	f	Quảnh	Linh	t	\N	local	1995-07-29	female	f	a14ba58774d664082f5c302f39e49afa
72c5b600-951b-4474-be43-8724c3991cf7	duongthanhgiang0.0108@gmail.com	+84982900108	9193c5fce97ad1e97d0b90b4ef5987c0aefe8fbfeea75da5d07b122f50358494	\N	f	2024-07-29 03:37:38.719062	2024-07-29 03:37:38.719062	t	f	Quảnh	Linh	t	\N	local	1995-07-29	female	f	74363537966292f1228a878954dd3ad2
5dd0517f-544d-4001-9cd9-c4f985c7a566	banhhaotoan2001@gmail.com	+84971308620	f1aafb07485942822a5e270b74f5910caba38d68f0e2e56777fcf821137a1d1d	\N	f	2024-07-24 18:23:51.373324	2024-07-24 18:23:51.373324	t	f	Bành	Toàn	t	\N	local	2002-06-20	male	f	c206f57fea4eef266f4863972ca49a15
99d2d0e4-8cbf-4fd8-9d70-4f5dee879d82	duongthanhgiang.0108@gmail.com	+84982900108	442954e7ef201f95d47b9ac9f68d39c927f79e7e039b0d8d5bb98f78afedc320	\N	f	2024-07-29 19:03:53.973219	2024-07-29 19:03:53.973219	t	f	Giang	Linh	t	\N	local	2005-07-29	female	f	623545b2b4fe52a5a90412646e0dbf84
82878f6f-42b9-44ec-a1bf-8342aa07e4fc	dtgiang.cv@gmail.com	+84982900108	646fe12e0030fd4fffa0b10a4d1392fa832e09c6a30df82046c366c1f2889c14	\N	f	2024-07-28 23:26:53.911013	2024-07-28 23:26:53.911013	t	f	Quảng	Linh	t	\N	local	1995-06-28	female	f	67b320bb603221fa238969081193bc59
bf9d1cbc-913a-429a-aa53-1077aa82eedc	dtgiang.cv@gmail.com	+84982900108	cd909caf1ef9d6ee7cc0cc28c2618ad94d569d6b2fc27b7f7154631e46939d8d	\N	f	2024-07-29 00:09:34.549198	2024-07-29 00:09:34.549198	t	f	Quảng	Linh Linh	t	\N	local	1995-07-28	female	f	d471e1f7fa96d3fb9610afd81480ff1a
a7592889-1999-4667-873a-c5c23132113b	dtgiang.cv@gmail.com	+84982900108	9b828ebad98ccc3a9876ca34bf41f090cba70aede100208627513de024d36db7	\N	f	2024-07-29 00:27:49.633823	2024-07-29 00:27:49.633823	t	f	Quảng	Linh Linh	t	\N	local	1995-07-28	female	f	528c73e1ae398ba065bc9a010964bd3a
cc0e58b3-7d97-403f-b16e-79437e5cb4ef	duongthanhgiang0.0108@gmail.com	+84982900108	2eb7b50003d7cac9250f0af121851ec0a1350def6c7cfa26f055cc02ebbc4b71	\N	f	2024-07-29 00:43:08.98235	2024-07-29 00:43:08.98235	t	f	Quảng 	Linh Linh	t	\N	local	1995-07-29	female	f	21161f94de35d4ccc495ec5b18e67c44
a8f669eb-06bd-4e3d-a3f9-5ad963f667c8	duongthanhgiang0.0108@gmail.com	+84982900108	a2ec981fb526d4e307a01168dcf34facddfae811725575366d3e17581f817046	\N	f	2024-07-29 02:23:25.073586	2024-07-29 02:23:25.073586	t	f	Quảng	Linh	t	\N	local	1995-07-29	female	f	bb1e3380067591d6c4993e5ff02fb075
5eca61cd-8efa-40cf-afe1-5e59bf7b131f	duongthanhgiang0.0108@gmail.com	+84982900108	41e8d17cbaaae1f56c28cff91f725ed63435f5fd902a76e1ef7e1495908d15a3	\N	f	2024-07-29 03:09:50.429747	2024-07-29 03:09:50.429747	t	f	Quảng	Linh Linh	t	\N	local	1995-07-29	female	f	6a6fac9dc4e608e8472d7bfd8da78ecd
86f2db34-e2db-4970-adad-74862cdc75c2	duongthanhgiang0.0108@gmail.com	+84982900108	54f6103c73aa4e78c5f9877a89a3d66bb85fdf1affefdf327be1a2b914395fb3	\N	f	2024-07-29 03:35:07.967528	2024-07-29 03:35:07.967528	t	f	Quảnh	Linh	t	\N	local	1995-07-29	female	f	b395aa628f4f49daf8c157268fa107dc
b0e23401-9e24-4be2-a0db-9a82281992e1	duongthanhgiang.0108@gmail.com	+84982900108	97c5f73bc16c6b41c2fe7a6ec7d83043c733880cd0b16d1b69ec5932db434b90	\N	f	2024-07-29 03:56:11.734859	2024-07-29 03:56:11.734859	t	f	Quảng	Linh Linh	t	\N	local	1995-07-29	female	f	1a64c62095e7f2db643d6b7efcf18fa1
661f81cf-4845-47c7-b8fc-fa2e045f7d28	duongthanhgiang0.0108@gmail.com	+84982900108	3e15e0269c22ef01b62a6f498877e4b06afa77cfd6d24563a7b6cc3f1479b893	\N	f	2024-07-29 18:29:41.876152	2024-07-29 18:29:41.876152	t	f	Quảng	Linh	t	\N	local	1995-07-29	female	f	6169c4cfd4181f56a629fe4b99542853
880c52ce-ef78-42dc-9a71-d175d4d8a437	dtgiang20@clc.fitus.edu.vn	+84982900108	a57a33eb102a93c7df31165a5e5347f6189850490923f6f4b3f8a987f2cd6f98	\N	f	2024-07-29 18:50:37.333027	2024-07-29 18:50:37.333027	t	f	Quảng	Linh	t	\N	local	2024-07-29	female	f	c0a51cbe69f43dba1143f8d6df8c1ce8
71be50ee-981e-469a-9e8a-920a9c7d4b49	adudarlk@gmail.com	+84971308323	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	\N	f	2024-07-24 14:54:01.915407	2024-07-24 14:54:01.915407	t	f	Bành	Toàn	t	\N	local	2002-06-20	male	f	9f86d081884c7d659a2feaa0c55ad015
6a4d0e20-d5b1-4eed-962e-43c559d9a5fc	banhhaotoan2001@gmail.com	+84971308620	bfc35fb607ee1723459ae5608f721700cff7cf85aa372e04c45dcdb144150025	\N	f	2024-07-24 18:23:51.182601	2024-07-24 18:23:51.182601	t	f	Bành	Toàn	t	\N	local	2002-06-20	male	f	82e29fde6c348cff60f50f26951d84af
90dbcab2-ed9d-44a0-a600-87d54b33dc84	banhhaotoan2001@gmail.com	+84971308620	baf886d191925bba61b74df193dfff8f9bac35960314dde47a5eeea13f62d6e1	\N	f	2024-07-24 18:23:51.289308	2024-07-24 18:23:51.289308	t	f	Bành	Toàn	t	\N	local	2002-06-20	male	f	c64f9ff818cffb7f7a9c63d03ec9b0a9
7892faac-a86a-4a6e-8e12-c0e6f4408d11	ngocanh27@yopmail.com	+84914552871	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	vn	f	2024-06-09 13:19:23.028716	2024-07-24 16:34:54.437219	t	f	Ngọc	Anh	t	https://static.vecteezy.com/system/resources/previews/020/911/740/non_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png	local	2012-02-13	male	f	9f86d081884c7d659a2feaa0c55ad015
8ffa48e6-acde-445b-a845-9c41e3ebd4ea	toan@aviansolutions.aero	\N	5f63ad8026a1a8789520326487e7833dec40368bd4074f6418960c628cbe9aa2	\N	f	2024-07-24 18:46:32.052799	2024-07-24 18:46:32.052799	t	f	Toàn	Bành	t	https://lh3.googleusercontent.com/a/ACg8ocK8MdVnZ349mbEJ7oqpM5A96ak6_l6BOb5dnDfNaaxnOA9Fvw=s96-c	google	\N	\N	f	beec5aba1bb2cf3b6fcc2b7ebd4f2d99
a522f6e2-3473-4666-92c9-45b351a91e0f	duongthanhgiang0.0108@gmail.com	+84982900108	b776899de3c684a6ac2fc980fb1c9c58e8e82ed3b21e30a94e19ce5d728ae590	\N	f	2024-07-29 00:46:24.303099	2024-07-29 00:46:24.303099	t	f	Quảng	Linh Linh	t	\N	local	1995-07-29	female	f	45936c6b61d428d196ba05bf62b6c860
4a7bc576-50a8-4bf6-820d-cbbb951933d2	duongthanhgiang.0108@gmail.com	+84982900108	6ba23eaa885879030cdaf5e662ae9140160e54309f28499bf882b04424aa0e20	\N	f	2024-07-29 19:09:07.530203	2024-07-29 19:09:07.530203	t	f	Giang	Linh	t	\N	local	2005-07-29	female	f	ac6f4677d420e9f154f4208ddf33efa9
9b951afe-c7ea-44b3-bace-00cd63ae6876	ducmanh1995@yopmail.com	+84987619324	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	vn	f	2024-06-09 13:19:23.107973	2024-07-24 16:30:33.501764	t	f	Đức	Mạnh	t	https://static.vecteezy.com/system/resources/previews/020/911/740/non_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png	local	2009-08-21	female	f	9f86d081884c7d659a2feaa0c55ad015
1138544a-f1bf-477d-8c44-1bf5278ad06f	duongthanhgiang0.0108@gmail.com	+84982900108	e0a14f3d764c77dd2c3d474d2c3909a72783f058a8856c7c2424f601e61a4f48	\N	f	2024-07-29 18:30:43.459957	2024-07-29 18:30:43.459957	t	f	Quảng	Linh	t	\N	local	1995-07-29	female	f	adcce4bafc2a754c818039a090cca358
27cabf67-e851-452d-a135-84a9b9e06392	duongthanhgiang0.0108@gmail.com	+84982900108	c3fa61c3656cb732684d33fa6bddd5a892c0be653fb085f2cc09a3dd7ee95eb1	\N	f	2024-07-29 00:30:00.285954	2024-07-29 00:30:00.285954	t	f	Quảng 	Linh Linh	t	\N	local	1995-07-29	female	f	77853ed8b2507d25ee6ba47b1e4962d0
101627d7-019e-4a58-b8c0-b30806db3780	phamgiangthaiduong2@gmail.com	+84918012345	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	vn	f	2024-04-03 06:29:50.049	2024-04-03 06:29:50.049	t	f	Dương	Phạm	t	https://static.vecteezy.com/system/resources/previews/020/911/740/non_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png	local	2001-12-15	male	f	9f86d081884c7d659a2feaa0c55ad015
29d5f6f6-24da-4cbd-87c1-2b7d6582039f	banhhaotoan2004@gmail.com	+84971308629	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	vn	f	2024-06-20 15:49:48.538064	2024-06-20 15:49:48.538064	t	f	Bành	Toàn	t	https://static.vecteezy.com/system/resources/previews/020/911/740/non_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png	local	2002-06-20	female	f	9f86d081884c7d659a2feaa0c55ad015
fd4c8c04-b031-4ed4-9faa-e23146a79c9a	thutrang.le97@yopmail.com	+84982536147	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	vn	f	2024-06-09 13:19:24.178169	2024-06-09 13:19:24.178169	t	f	Thu	Trang	t	https://static.vecteezy.com/system/resources/previews/020/911/740/non_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png	local	2008-10-27	male	f	9f86d081884c7d659a2feaa0c55ad015
1f315a84-6fde-4e41-a303-193dd8a6e54b	banhhaotoan2001@gmail.com	+84971308620	e3a44cb7aefda132fc0e992e28ff8acad60ba6f6a241edb93a60107a047491ac	\N	f	2024-07-24 18:23:51.375348	2024-07-24 18:23:51.375348	t	f	Bành	Toàn	t	\N	local	2002-06-20	male	f	55d38a5a18709566da7e7cd98d833c5b
9f71cef2-46a9-4a5f-aa89-310438b6710f	duongthanhgiang.2411@gmail.com	+84982900108	a63f9b6341190214826439c69a83ad4cd4bb5c0746eb7bc41ad305a0e7aaf97f	\N	f	2024-07-28 21:01:38.130766	2024-07-28 21:01:38.130766	t	f	Quảng	Linh	t	\N	local	1995-06-20	female	f	8ed1f7bc411f64f047e6e09c6c91086f
75043671-ccc4-4f11-87e8-7335a615c68e	duongthanhgiang0.0108@gmail.com	+84982900108	7978f6e8eb04c7278b80fd83b62e75f1fc77d0d1420ba7ccb54cb222c77cb808	\N	f	2024-07-29 01:01:01.9164	2024-07-29 01:01:01.9164	t	f	Quảng	Linh Linh	t	\N	local	1995-07-29	female	f	afaf7019f9eaf2978f6ecb1b144abde4
049224c7-cb27-42c3-9a3f-42df090c3f75	duongthanhgiang.0108@gmail.com	+84982900108	03fe3f9b400f0c1aa48bf5afbbbecd0f56c97796e903ec07426187998b080faf	\N	f	2024-07-29 19:03:24.25714	2024-07-29 19:03:24.25714	t	f	Giang	Linh	t	\N	local	2005-07-29	female	f	f4c0c26be6c87df7c41b796bb7daae2e
bd94ba3a-b046-4a05-a260-890913e09df9	banhhaotoan2002@gmail.com	+84971308623	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	vn	f	2024-03-11 15:09:07.654	2024-08-01 17:42:14.598924	t	t	Toán	Hảo	t	https://storage.googleapis.com/famfund-bucket/avatar/avatar_bd94ba3a-b046-4a05-a260-890913e09df9_1722534133738_cb57f87cf57dfff68dadf50e52c803ff.jpg	local	2002-06-05	female	f	9f86d081884c7d659a2feaa0c55ad015
a1c1b1ff-a080-4f13-8f70-788fad2359f7	vclvclvcl@gmail.com	+84971308323	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	\N	f	2024-07-24 14:48:56.822732	2024-07-24 14:48:56.822732	t	f	Bành	Toàn	t	\N	local	2002-06-20	male	f	9f86d081884c7d659a2feaa0c55ad015
6cefc924-1437-44bd-803a-d2be248e486b	cucai123@gmail.com	+84971108231	f8561b2a032bc4970b0e159b3737a44b4be7a3c2b8c2d9eb1adb8f792abbfb26	\N	f	2024-07-24 18:10:39.522402	2024-07-24 18:10:39.522402	t	f	Bành	Toàn	t	\N	local	2002-06-20	male	f	49bcec91698a3bd3de40d98c36e080db
d4cab358-191e-4a87-98a6-edb36ca8d821	congdanh.tran02@yopmail.com	+84908652317	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	vn	f	2024-06-09 13:19:24.370688	2024-06-09 13:19:24.370688	t	f	Công	Danh	t	https://static.vecteezy.com/system/resources/previews/020/911/740/non_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png	local	2017-11-13	female	f	9f86d081884c7d659a2feaa0c55ad015
eba531d6-415e-4d8d-9da0-1a0ead7f6f28	hoangnam.le@yopmail.com	+84915842963	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	vn	f	2024-06-09 13:19:23.783765	2024-06-09 13:19:23.783765	t	f	Hoàng	Nam	t	https://static.vecteezy.com/system/resources/previews/020/911/740/non_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png	local	2018-02-27	male	f	9f86d081884c7d659a2feaa0c55ad015
f66f158e-1076-44ae-b342-2334052eb60b	lananh.pham00@yopmail.com	+84974285136	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	vn	f	2024-06-09 13:19:23.850684	2024-06-09 13:19:23.850684	t	f	Lan	Anh	t	https://static.vecteezy.com/system/resources/previews/020/911/740/non_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png	local	2008-01-19	female	f	9f86d081884c7d659a2feaa0c55ad015
3db0256c-c406-4f5a-9e85-d5b2244f294a	anhdung.nguyen90@yopmail.com	+84902693518	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	vn	f	2024-06-09 13:19:23.976816	2024-06-09 13:19:23.976816	t	f	Anh	Dũng	t	https://static.vecteezy.com/system/resources/previews/020/911/740/non_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png	local	2003-03-16	female	f	9f86d081884c7d659a2feaa0c55ad015
0c29e181-a341-4796-8055-730a151b22ae	myduyen.nguyen94@yopmail.com	+84972418536	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	vn	f	2024-06-09 13:19:24.43363	2024-06-09 13:19:24.43363	t	f	Mỹ	Duyên	t	https://static.vecteezy.com/system/resources/previews/020/911/740/non_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png	local	2008-10-05	male	f	9f86d081884c7d659a2feaa0c55ad015
8a5ccf49-f775-4efe-a03c-36a39c5cfd95	ngocmai.tran@yopmail.com	+84909745128	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	vn	f	2024-06-09 13:19:24.691824	2024-06-09 13:19:24.691824	t	f	Ngọc	Mai	t	https://static.vecteezy.com/system/resources/previews/020/911/740/non_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png	local	2001-05-14	male	f	9f86d081884c7d659a2feaa0c55ad015
e6f375c1-f100-4f1e-86cf-bac589a4b4d6	hoanganh.nguyen96@yopmail.com	+84973261845	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	vn	f	2024-06-09 13:19:24.754848	2024-06-09 13:19:24.754848	t	f	Hoàng	Anh	t	https://static.vecteezy.com/system/resources/previews/020/911/740/non_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png	local	2018-11-22	female	f	9f86d081884c7d659a2feaa0c55ad015
0ad6f5b5-f6f8-4035-84d2-779966235b1c	linhchi.le2002@yopmail.com	+84948152963	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	vn	f	2024-06-09 13:19:24.816608	2024-06-09 13:19:24.816608	t	f	Linh	Chi	t	https://static.vecteezy.com/system/resources/previews/020/911/740/non_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png	local	2018-10-04	female	f	9f86d081884c7d659a2feaa0c55ad015
2ca8d27c-4e8c-4457-846e-5f5bb1afe103	minhkhai.tran@yopmail.com	+84917582436	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	vn	f	2024-06-09 13:19:24.879958	2024-06-09 13:19:24.879958	t	f	Minh	Khải	t	https://static.vecteezy.com/system/resources/previews/020/911/740/non_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png	local	2006-08-09	female	f	9f86d081884c7d659a2feaa0c55ad015
eb3604a4-1c26-4d9b-a144-8430fcedce9e	thao.nguyen93@yopmail.com	+84906317824	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	vn	f	2024-06-09 13:19:24.984193	2024-06-09 13:19:24.984193	t	f	Thảo	Nguyễn	t	https://static.vecteezy.com/system/resources/previews/020/911/740/non_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png	local	2008-07-06	male	f	9f86d081884c7d659a2feaa0c55ad015
d9ecc1a5-2a26-493e-8e6a-83d4e525fe50	thuhien21052002@gmail.com	+84971308623	371af335a32310d630d60a16a7004e4af82267ceb933e5768f3bd7b70b6a3f0a	\N	f	2024-07-30 05:01:37.535352	2024-08-02 01:02:41.191314	t	f	Hiền	Thu	t	https://storage.googleapis.com/famfund-bucket/avatar/avatar_d9ecc1a5-2a26-493e-8e6a-83d4e525fe50_1722560550093_87D4992F-55F4-4CFF-823C-9389A6772AB3.jpg	local	2002-06-20	female	f	474d0f595825409af71de7e68ce9add4
c691514e-5e9c-4995-9938-15952b462363	duongthanhgiang@yopmail.com	+84982900108	ac2c1e3380ea61e230feda40e28ffd65aea3bd20a415294f1df5afc9e2665c4d	\N	f	2024-07-29 19:38:38.334535	2024-07-29 21:22:54.28773	t	f	Linh	Linh	t	https://storage.googleapis.com/famfund-bucket/avatar/avatar_c691514e-5e9c-4995-9938-15952b462363_1722288070652_8D8460CA-7865-4F37-AA8F-AB9267E5A822.jpg	local	1995-06-20	female	f	a0b4dabece4b01f073d49ff0485a56e1
b02726ed-8833-4314-ba7a-3a2ed133c1b0	dtgiang20@clc.fitus.edu.vn	+84982900108	67d3b8221dcf1294f5b75a4abf2c0798b5dbab237cb9e2f155e469e5c86d122b	\N	f	2024-07-29 18:56:34.545915	2024-07-29 18:56:34.545915	t	f	Quảng	Linh	t	\N	local	1995-07-29	female	f	5f281eecd50af3ade19090a4917ea4c4
e4334118-dfef-4e5e-bfad-6a5db2e10d0b	duongthanhgiang.0108@gmail.com	+84982900108	11cfc98d116b10f9344cd9867e6a477a4999091a5b23c090102cef7059b3c8dc	\N	f	2024-07-25 16:17:32.94471	2024-07-29 21:13:18.110864	t	f	Thanh	Giang	t	https://storage.googleapis.com/famfund-bucket/avatar/avatar_e4334118-dfef-4e5e-bfad-6a5db2e10d0b_1722287523361_5B1FCDBB-9855-4928-BB30-D0A7B04C277C.jpg	local	1995-11-24	male	f	41e7808ca62950fc095eb8dbf1c9b877
178c7705-dfbf-4774-bcff-eff9baf8e9e9	duongthanhgiang.0108@gmail.com	+84982900108	3b226ed226ae7f135c3f1d592ee1f95dc7dfac38dc0f7adecb379d62b3659f13	\N	f	2024-07-29 19:09:07.584314	2024-07-29 21:16:24.126835	t	f	Giang	Linh	t	\N	local	2005-07-29	female	f	78ac1c4836d1742ae0d3802f8051f63a
6f77c48e-3273-429d-8b5d-395ec8fe2de8	linhdan.nguyen@yopmail.com	+84935712684	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	vn	f	2024-06-09 13:19:23.315121	2024-06-09 13:19:23.315121	t	f	Linh	Đan	t	https://static.vecteezy.com/system/resources/previews/020/911/740/non_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png	local	2008-05-02	male	f	9f86d081884c7d659a2feaa0c55ad015
39736911-800d-476b-b9ed-a7c0d9f2c0ff	minhtuan.pham99@yopmail.com	+84978126359	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	vn	f	2024-06-09 13:19:23.382266	2024-06-09 13:19:23.382266	t	f	Minh	Tuấn	t	https://static.vecteezy.com/system/resources/previews/020/911/740/non_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png	local	2005-06-09	female	f	9f86d081884c7d659a2feaa0c55ad015
3b5b6d2f-7038-4155-a81f-473ecfa93e64	tienthanh.nguyen@yopmail.com	+84941962758	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	vn	f	2024-06-09 13:19:24.498217	2024-06-09 13:19:24.498217	t	f	Tiến	Thành	t	https://static.vecteezy.com/system/resources/previews/020/911/740/non_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png	local	2011-07-12	female	f	9f86d081884c7d659a2feaa0c55ad015
f84d79c4-9b04-4dc1-b170-561ce8ec66c5	thuyngan.pham91@yopmail.com	+84936287154	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	vn	f	2024-06-09 13:19:24.562649	2024-06-09 13:19:24.562649	t	f	Thúy	Ngân	t	https://static.vecteezy.com/system/resources/previews/020/911/740/non_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png	local	2016-10-23	female	f	9f86d081884c7d659a2feaa0c55ad015
398b86a6-8e22-45a6-8676-e9fb2f3a7f35	duyhung.le01@yopmail.com	+84985137249	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	vn	f	2024-06-09 13:19:24.627199	2024-06-09 13:19:24.627199	t	f	Duy	Hùng	t	https://static.vecteezy.com/system/resources/previews/020/911/740/non_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png	local	2006-09-22	male	f	9f86d081884c7d659a2feaa0c55ad015
2ae945cf-3229-42bf-a121-2918ad736019	thanhtrung.vo@yopmail.com	+84984512796	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	vn	f	2024-06-09 13:19:23.517832	2024-06-09 13:19:23.517832	t	f	Thành	Trung	t	https://static.vecteezy.com/system/resources/previews/020/911/740/non_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png	local	2017-04-20	female	f	9f86d081884c7d659a2feaa0c55ad015
ac430758-0fc5-4f1c-a849-134fae1723d3	hongnhung.nguyen23@yopmail.com	+84907258316	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	vn	f	2024-06-09 13:19:23.582538	2024-06-09 13:19:23.582538	t	f	Hồng	Nhung	t	https://static.vecteezy.com/system/resources/previews/020/911/740/non_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png	local	2013-07-12	female	f	9f86d081884c7d659a2feaa0c55ad015
30598aef-51e3-4610-945f-4530edf86842	quangvinh.doan@yopmail.com	+84969314725	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	vn	f	2024-06-09 13:19:23.65022	2024-06-09 13:19:23.65022	t	f	Quang	Vinh	t	https://static.vecteezy.com/system/resources/previews/020/911/740/non_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png	local	2009-02-10	male	f	9f86d081884c7d659a2feaa0c55ad015
d03789c8-05a2-40b5-beb4-15ec1ff59c13	myhanh.tran98@yopmail.com	+84938527164	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	vn	f	2024-06-09 13:19:23.717003	2024-06-09 13:19:23.717003	t	f	Mỹ	Hạnh	t	https://static.vecteezy.com/system/resources/previews/020/911/740/non_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png	local	2005-12-05	male	f	9f86d081884c7d659a2feaa0c55ad015
743d7372-31ce-45a5-b999-c5f3b202b629	kimtuyen.tran2001@yopmail.com	+84961472835	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	vn	f	2024-06-09 13:19:24.045953	2024-06-09 13:19:24.045953	t	f	Kim	Tuyến	t	https://static.vecteezy.com/system/resources/previews/020/911/740/non_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png	local	2019-05-14	female	f	9f86d081884c7d659a2feaa0c55ad015
218f8efd-e453-4a68-b1b4-b54b71b9a04a	manhcuong.nguyen@yopmail.com	+84937158246	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	vn	f	2024-06-09 13:19:24.11304	2024-06-09 13:19:24.11304	t	f	Mạnh	Cường	t	https://static.vecteezy.com/system/resources/previews/020/911/740/non_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png	local	2009-06-08	male	f	9f86d081884c7d659a2feaa0c55ad015
53ccab15-ed6f-45de-9cdb-65d640131d4c	testmobiledemo123@gmail.com	+84982900108	124e71f06dccaad8ca9804b39bc5d669099cc289ee1d9a599df04be35094a511	\N	f	2024-07-30 13:12:05.256949	2024-07-30 13:12:39.553043	t	f	Giang	Giang	t	\N	local	2003-07-30	female	f	9a69a8ac1680990deedc2b552b285cfa
1c219416-f89a-47b1-a2b6-f89ec3139037	duongthanhgiang0.0108@gmail.com	+84982900108	55aa5ad3ae20906ab3e039f1493d2c12562f0051d7369e01f45bc49dde4ef0bd	\N	f	2024-07-29 18:39:16.251141	2024-07-29 18:39:16.251141	t	f	Quảng	Linh	t	\N	local	1995-07-29	female	f	bf710020fe7421d6ebe7dbb9fa341b92
cf723e9f-f75a-4b94-9634-43880f326743	banhhaotoan2002@gmail.com	\N	\\xc30d04090302358b1749ac025d1469d242010b9c60904a8f22ffcc9f88a705e1af55b0176630f1dfa9f96bde9fbca41f6407535ed9d2f1a6a259dd180d72132fff605185196ad826df5c41a8b4307781128a9a	vn	f	2024-06-08 15:41:49.084944	2024-07-28 11:07:01.773258	t	f	Bành Hảo	Toàn	t	https://lh3.googleusercontent.com/a/ACg8ocLPOJ7w4JsS50IHIN0obn0yLykiZf2kOu78i7m0P4u1039apes=s96-c	google	2020-11-11	female	f	9f86d081884c7d659a2feaa0c55ad015
a4b586c8-0f7a-4627-8403-fc09881c8eb6	kimngan.tran@yopmail.com	+84903825617	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	vn	f	2024-06-09 13:19:23.179298	2024-06-09 13:19:23.179298	t	f	Kim	Ngân	t	https://static.vecteezy.com/system/resources/previews/020/911/740/non_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png	local	2005-09-08	female	f	9f86d081884c7d659a2feaa0c55ad015
22982c99-db14-4521-8c90-1cefca3f513f	xuantruong.dev@yopmail.com	+84962481539	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	vn	f	2024-06-09 13:19:23.246166	2024-06-09 13:19:23.246166	t	f	Xuân	Trường	t	https://static.vecteezy.com/system/resources/previews/020/911/740/non_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png	local	2019-11-27	male	f	9f86d081884c7d659a2feaa0c55ad015
68427a25-ab77-47ee-a17a-f618ebca1d66	thuylinh.le2003@yopmail.com	+84916397428	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	vn	f	2024-06-09 13:19:23.450288	2024-06-09 13:19:23.450288	t	f	Thùy	Linh	t	https://static.vecteezy.com/system/resources/previews/020/911/740/non_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png	local	2011-11-05	male	f	9f86d081884c7d659a2feaa0c55ad015
ff55db45-0781-491f-9146-ff4a0c87a6cc	vinhphuc.pham27@yopmail.com	+84919462853	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	vn	f	2024-06-09 13:19:24.242292	2024-06-09 13:19:24.242292	t	f	Vĩnh	Phúc	t	https://static.vecteezy.com/system/resources/previews/020/911/740/non_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png	local	2002-08-26	male	f	9f86d081884c7d659a2feaa0c55ad015
25c42a91-bb44-4ea8-9dc3-0980d2987921	hoailinh.nguyen@yopmail.com	+84953178249	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	vn	f	2024-06-09 13:19:24.307256	2024-06-09 13:19:24.307256	t	f	Hoài	Linh	t	https://static.vecteezy.com/system/resources/previews/020/911/740/non_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png	local	2009-04-09	female	f	9f86d081884c7d659a2feaa0c55ad015
44d5d04d-25c5-4a8e-9328-bc8e90110d46	anhquan.le92@yopmail.com	+84981372465	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	vn	f	2024-06-09 13:19:25.184568	2024-06-09 13:19:25.184568	t	f	Anh	Quân	t	https://static.vecteezy.com/system/resources/previews/020/911/740/non_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png	local	2008-02-15	female	f	9f86d081884c7d659a2feaa0c55ad015
a1d62ba5-9cc1-4beb-9acc-cdba325c1b93	tuyetnhung.tran99@yopmail.com	+84902853617	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	vn	f	2024-06-09 13:19:25.253799	2024-06-09 13:19:25.253799	t	f	Tuyết	Nhung	t	https://static.vecteezy.com/system/resources/previews/020/911/740/non_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png	local	2014-07-18	male	f	9f86d081884c7d659a2feaa0c55ad015
9e153f4a-7c30-4e6f-a1bd-157a6eea5885	thuhien21052002@gmail.com	+84982900108	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	vn	f	2024-06-08 15:37:00.43323	2024-08-01 17:42:24.70726	t	f	Hiền	Thu	t	https://storage.googleapis.com/famfund-bucket/avatar/avatar_9e153f4a-7c30-4e6f-a1bd-157a6eea5885_1722534144049_p2.jpg	local	2019-01-05	female	f	9f86d081884c7d659a2feaa0c55ad015
9791d284-ff48-46c1-be1d-6fe12727a259	ductrung.tran@yopmail.com	+84967125834	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	vn	f	2024-06-09 13:19:25.321203	2024-07-13 09:56:07.757545	t	f	Đức	Trung	t	https://static.vecteezy.com/system/resources/previews/020/911/740/non_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png	local	2013-09-20	male	f	9f86d081884c7d659a2feaa0c55ad015
a945a041-317c-4e7b-85e0-02670230225a	quochoa.pham03@yopmail.com	+84975248163	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	vn	f	2024-06-09 13:19:25.056267	2024-06-09 13:19:25.056267	t	f	Quốc	Hoa	t	https://static.vecteezy.com/system/resources/previews/020/911/740/non_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png	local	2004-09-04	female	f	9f86d081884c7d659a2feaa0c55ad015
8f538109-63bf-431d-9fdb-3b5f05c72b04	mylinh.pham@yopmail.com	+84934962581	2e1392c88c915f6679ff915da2c034a8742b02a2454cb3a200a3889131b958fd	vn	f	2024-06-09 13:19:25.119793	2024-06-09 13:19:25.119793	t	f	Mỹ	Linh	t	https://static.vecteezy.com/system/resources/previews/020/911/740/non_2x/user-profile-icon-profile-avatar-user-icon-male-icon-face-icon-profile-icon-free-png.png	local	2019-11-07	female	f	9f86d081884c7d659a2feaa0c55ad015
2c9c3f3e-f7e1-4010-8108-99982359b2a3	duongthanhgiang.0108@gmail.com	+84982900108	04a9c6df5dc96ddb431f5ec6318b8e8689110357e8e1ee87399b8bad112ef800	\N	f	2024-07-29 03:56:42.550056	2024-07-29 03:56:42.550056	t	f	Quảng	Linh Linh	t	\N	local	1995-07-29	female	f	abddf0104a4648eb5b00eefb304c1dd7
ecf4f8e9-bbc1-48da-ac12-65630a2ed994	dtgiang.cv@gmail.com	+84982900108	d2c898431aab3fbb227f336c7927bfc5cd18655008571b83e40e2031b991ca9a	\N	f	2024-07-28 23:34:15.856974	2024-07-28 23:34:15.856974	t	f	Quảng	Linh Linh	t	\N	local	1995-07-28	female	f	39450eaad8be3ad975601826d554a24d
ec6b35cc-386d-428e-8e77-696768efdee9	dtgiang.cv@gmail.com	+84982900108	88f03dc40e628f39fc97330710c5c0720ca0a5cbeabfab5feb786ad1ad1700dd	\N	f	2024-07-29 00:17:16.341818	2024-07-29 00:17:16.341818	t	f	Quảng	Linh Linh	t	\N	local	1995-07-28	female	f	7f910bfa0f7f2652e933848338679703
fc71d97f-4a8d-4cd8-ab82-3a8b971031ba	duongthanhgiang0.0108@gmail.com	+84982900108	2facd4f1088acc4d7784d1d9c4764c33499dd4bcccbac193a1a6d250bdd2b43e	\N	f	2024-07-29 02:25:27.372302	2024-07-29 02:25:27.372302	t	f	Quảng Linh	Linh	t	\N	local	1995-07-29	female	f	bc36802d5373016a98c66bfff629e050
\.


--
-- TOC entry 4298 (class 0 OID 17999)
-- Dependencies: 317
-- Data for Name: utilities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.utilities (id_utility, id_family, id_utilities_type, description, image_url, value, created_at, updated_at, id_expenditure) FROM stdin;
1	96	2	adu dark	https://storage.googleapis.com/famfund-bucket/utility/utility_bd94ba3a-b046-4a05-a260-890913e09df9_1720207305114_1-giai-ma-nhung-khu-vuc-trong-nha-trang-bi-ma-am-nang-1434164951069.jpg	10000	2024-07-05 19:21:46.381033	2024-07-05 19:22:35.935538	\N
4	96	1	Mua khí gas	\N	10000	2024-07-09 17:27:01.555478	2024-07-09 17:27:01.555478	\N
5	97	1		\N	10000	2024-07-09 18:19:25.407294	2024-07-09 18:19:25.407294	\N
6	97	2	Mua gà	https://storage.googleapis.com/famfund-bucket/utility/utility_bd94ba3a-b046-4a05-a260-890913e09df9_1720549212655_4BACBCE2-4D06-42C0-BCFA-11F25A1FC05E.png	100000	2024-07-09 18:20:25.460353	2024-07-09 18:20:25.460353	\N
7	97	1	Mua khí gas	\N	10000	2024-07-09 18:20:47.958245	2024-07-09 18:20:47.958245	\N
8	96	1	Mua khí gas	https://storage.googleapis.com/famfund-bucket/utility/utility_bd94ba3a-b046-4a05-a260-890913e09df9_1720549265446_i88.jpg	10000	2024-07-09 18:21:06.554281	2024-07-09 18:21:06.554281	\N
9	97	2		https://storage.googleapis.com/famfund-bucket/utility/utility_bd94ba3a-b046-4a05-a260-890913e09df9_1720549368246_725EB995-9BFA-47C3-813C-AEC67FF6026A.png	1000	2024-07-09 18:22:57.75907	2024-07-09 18:22:57.75907	\N
10	97	2		https://storage.googleapis.com/famfund-bucket/utility/utility_bd94ba3a-b046-4a05-a260-890913e09df9_1720549481566_4103E223-9968-464C-A40C-0B59A0AC474E.png	10000	2024-07-09 18:24:42.353482	2024-07-09 18:24:42.353482	\N
11	96	3		\N	10000	2024-07-19 10:15:58.126837	2024-07-19 10:15:58.126837	\N
20	96	10	Tiền điện thoại	\N	50000	2024-08-01 09:19:55.200076	2024-08-01 09:19:55.200076	\N
3	96	2	adu dark	https://storage.googleapis.com/famfund-bucket/utility/utility_bd94ba3a-b046-4a05-a260-890913e09df9_1720545781957_070.jpg	100000	2024-07-09 17:23:03.386846	2024-07-09 17:23:03.386846	\N
21	96	9	Tiền truyền hình cáp	\N	400000	2024-08-01 09:21:04.859867	2024-08-01 09:21:04.859867	\N
12	96	2		\N	200000	2024-07-31 09:43:07.47309	2024-07-31 09:43:07.47309	\N
13	96	2		https://storage.googleapis.com/famfund-bucket/utility/utility_bd94ba3a-b046-4a05-a260-890913e09df9_1722490427976_FDC2B230-15E2-4FE3-8BB6-8FB676B60FCF.png	1000000	2024-08-01 05:33:48.594515	2024-08-01 05:33:48.594515	\N
14	96	8		https://storage.googleapis.com/famfund-bucket/utility/utility_bd94ba3a-b046-4a05-a260-890913e09df9_1722490556567_FAD47CB6-AF2F-42F5-B733-66D605821ACD.png	1000000	2024-08-01 05:35:56.933189	2024-08-01 05:35:56.933189	\N
15	96	3		https://storage.googleapis.com/famfund-bucket/utility/utility_bd94ba3a-b046-4a05-a260-890913e09df9_1722490608402_3A402F06-AC22-484F-BAD5-955FEC0974AC.png	500000	2024-08-01 05:36:48.839989	2024-08-01 05:36:48.839989	\N
16	96	10		https://storage.googleapis.com/famfund-bucket/utility/utility_bd94ba3a-b046-4a05-a260-890913e09df9_1722490767185_7D087897-CFC3-4B6E-BA2F-0786F98A1583.png	50000	2024-08-01 05:39:27.544534	2024-08-01 05:39:27.544534	\N
17	96	1		https://storage.googleapis.com/famfund-bucket/utility/utility_bd94ba3a-b046-4a05-a260-890913e09df9_1722490820188_oil.png	100000	2024-08-01 05:40:20.52689	2024-08-01 05:40:20.52689	\N
18	96	1		\N	100000	2024-08-01 05:48:53.091104	2024-08-01 05:48:53.091104	\N
22	96	8	Haha	https://storage.googleapis.com/famfund-bucket/utility/utility_bd94ba3a-b046-4a05-a260-890913e09df9_1722504264099_OIP.jpg	400000	2024-08-01 09:24:24.623539	2024-08-01 09:24:24.623539	\N
23	96	4		\N	10000	2024-08-01 09:26:16.430538	2024-08-01 09:26:16.430538	\N
24	96	10		\N	505050	2024-08-01 09:28:01.849788	2024-08-01 09:28:01.849788	\N
19	96	5	Tiền rác	\N	50000	2024-08-01 09:18:31.651048	2024-08-01 09:18:31.651048	\N
25	96	7		\N	404040	2024-08-01 09:30:39.290625	2024-08-01 09:30:39.290625	\N
30	96	2		\N	20000	2024-08-01 15:57:00.762075	2024-08-01 15:57:00.762075	\N
31	96	3		\N	200000	2024-08-01 16:02:20.219754	2024-08-01 16:02:20.219754	\N
32	96	3		\N	200000	2024-08-01 16:04:13.039722	2024-08-01 16:04:13.039722	\N
34	96	2		\N	1000000	2024-08-01 17:08:21.254382	2024-08-01 17:08:21.254382	\N
33	96	3		\N	200000	2024-08-01 16:06:07.479266	2024-08-01 16:06:07.479266	\N
35	96	1		\N	100000	2024-08-01 17:35:37.026559	2024-08-01 17:35:37.026559	172
\.


--
-- TOC entry 4300 (class 0 OID 18009)
-- Dependencies: 319
-- Data for Name: utilities_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.utilities_type (id_utilities_type, name_en, name_vn) FROM stdin;
1	Gas	Khí Gas
2	Electricity	Điện
3	Water	Nước
4	Internet	Internet
5	Garbage	Rác
6	Sewer	Cống
7	Heating	Sưởi
8	Cooling	Làm Mát
9	Cable Tv	Truyền Hình Cáp
10	Telephone	Điện Thoại
11	Security	An Ninh
12	Recycling	Tái Chế
13	Other	Khác
\.


--
-- TOC entry 4302 (class 0 OID 18015)
-- Dependencies: 321
-- Data for Name: v_user_id; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.v_user_id (id_user) FROM stdin;
bd94ba3a-b046-4a05-a260-890913e09df9
\.


--
-- TOC entry 4353 (class 0 OID 0)
-- Dependencies: 229
-- Name: calendar_id_calendar_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.calendar_id_calendar_seq', 75, true);


--
-- TOC entry 4354 (class 0 OID 0)
-- Dependencies: 231
-- Name: education_progress_id_education_progress_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.education_progress_id_education_progress_seq', 101, true);


--
-- TOC entry 4355 (class 0 OID 0)
-- Dependencies: 233
-- Name: education_progress_id_education_progress_seq1; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.education_progress_id_education_progress_seq1', 7, true);


--
-- TOC entry 4356 (class 0 OID 0)
-- Dependencies: 324
-- Name: famili_invitation_id_invitation_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.famili_invitation_id_invitation_seq', 1, false);


--
-- TOC entry 4357 (class 0 OID 0)
-- Dependencies: 235
-- Name: family_extra_packages_id_family_extra_package_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.family_extra_packages_id_family_extra_package_seq', 30, true);


--
-- TOC entry 4358 (class 0 OID 0)
-- Dependencies: 226
-- Name: family_id_family_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.family_id_family_seq', 117, true);


--
-- TOC entry 4359 (class 0 OID 0)
-- Dependencies: 236
-- Name: family_id_family_seq1; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.family_id_family_seq1', 1, false);


--
-- TOC entry 4360 (class 0 OID 0)
-- Dependencies: 237
-- Name: family_id_family_seq2; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.family_id_family_seq2', 1, false);


--
-- TOC entry 4361 (class 0 OID 0)
-- Dependencies: 238
-- Name: family_id_sequence; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.family_id_sequence', 1, false);


--
-- TOC entry 4362 (class 0 OID 0)
-- Dependencies: 240
-- Name: family_invitation_id_invitation_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.family_invitation_id_invitation_seq', 10, true);


--
-- TOC entry 4363 (class 0 OID 0)
-- Dependencies: 242
-- Name: family_roles_id_family_role_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.family_roles_id_family_role_seq', 39, true);


--
-- TOC entry 4364 (class 0 OID 0)
-- Dependencies: 245
-- Name: feedbacks_id_feedback_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.feedbacks_id_feedback_seq', 105, true);


--
-- TOC entry 4365 (class 0 OID 0)
-- Dependencies: 246
-- Name: finance_assets_asset_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.finance_assets_asset_id_seq', 6, true);


--
-- TOC entry 4366 (class 0 OID 0)
-- Dependencies: 247
-- Name: finance_assets_id_asset_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.finance_assets_id_asset_seq', 61, true);


--
-- TOC entry 4367 (class 0 OID 0)
-- Dependencies: 249
-- Name: finance_expenditure_expenditure_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.finance_expenditure_expenditure_id_seq', 247, true);


--
-- TOC entry 4368 (class 0 OID 0)
-- Dependencies: 250
-- Name: finance_expenditure_id_expenditure_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.finance_expenditure_id_expenditure_seq', 172, true);


--
-- TOC entry 4369 (class 0 OID 0)
-- Dependencies: 252
-- Name: finance_expenditure_type_id_expenditure_type_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.finance_expenditure_type_id_expenditure_type_seq', 252, true);


--
-- TOC entry 4370 (class 0 OID 0)
-- Dependencies: 254
-- Name: finance_income_id_income_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.finance_income_id_income_seq', 270, true);


--
-- TOC entry 4371 (class 0 OID 0)
-- Dependencies: 255
-- Name: finance_income_income_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.finance_income_income_id_seq', 194, true);


--
-- TOC entry 4372 (class 0 OID 0)
-- Dependencies: 257
-- Name: finance_income_source_id_income_source_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.finance_income_source_id_income_source_seq', 141, true);


--
-- TOC entry 4373 (class 0 OID 0)
-- Dependencies: 259
-- Name: financial_summary_summary_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.financial_summary_summary_id_seq', 5, true);


--
-- TOC entry 4374 (class 0 OID 0)
-- Dependencies: 326
-- Name: frequently_question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.frequently_question_id_seq', 1, false);


--
-- TOC entry 4375 (class 0 OID 0)
-- Dependencies: 261
-- Name: guide_items_id_item_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.guide_items_id_item_seq', 1, false);


--
-- TOC entry 4376 (class 0 OID 0)
-- Dependencies: 265
-- Name: household_item_categories_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.household_item_categories_category_id_seq', 8, true);


--
-- TOC entry 4377 (class 0 OID 0)
-- Dependencies: 266
-- Name: household_item_categories_id_household_item_category_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.household_item_categories_id_household_item_category_seq', 1, false);


--
-- TOC entry 4378 (class 0 OID 0)
-- Dependencies: 267
-- Name: household_items_id_household_item_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.household_items_id_household_item_seq', 45, true);


--
-- TOC entry 4379 (class 0 OID 0)
-- Dependencies: 269
-- Name: invoice_id_invoice_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.invoice_id_invoice_seq', 4, true);


--
-- TOC entry 4380 (class 0 OID 0)
-- Dependencies: 271
-- Name: invoice_items_id_item_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.invoice_items_id_item_seq', 13, true);


--
-- TOC entry 4381 (class 0 OID 0)
-- Dependencies: 273
-- Name: invoice_type_id_invoice_type_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.invoice_type_id_invoice_type_seq', 28, true);


--
-- TOC entry 4382 (class 0 OID 0)
-- Dependencies: 274
-- Name: key_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.key_id_seq', 1, false);


--
-- TOC entry 4383 (class 0 OID 0)
-- Dependencies: 275
-- Name: key_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.key_id_seq1', 1, false);


--
-- TOC entry 4384 (class 0 OID 0)
-- Dependencies: 221
-- Name: member_family_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.member_family_id_seq', 36, true);


--
-- TOC entry 4385 (class 0 OID 0)
-- Dependencies: 276
-- Name: member_family_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.member_family_id_seq1', 1, false);


--
-- TOC entry 4386 (class 0 OID 0)
-- Dependencies: 277
-- Name: member_family_id_seq2; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.member_family_id_seq2', 3, true);


--
-- TOC entry 4387 (class 0 OID 0)
-- Dependencies: 278
-- Name: notification_id_notification_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notification_id_notification_seq', 1, false);


--
-- TOC entry 4388 (class 0 OID 0)
-- Dependencies: 280
-- Name: order_family_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_family_id_seq', 1, false);


--
-- TOC entry 4389 (class 0 OID 0)
-- Dependencies: 281
-- Name: order_id_order_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_id_order_seq', 1, false);


--
-- TOC entry 4390 (class 0 OID 0)
-- Dependencies: 282
-- Name: order_id_order_seq1; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_id_order_seq1', 1, false);


--
-- TOC entry 4391 (class 0 OID 0)
-- Dependencies: 284
-- Name: otp_id_otp_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.otp_id_otp_seq', 117, true);


--
-- TOC entry 4392 (class 0 OID 0)
-- Dependencies: 285
-- Name: otp_otp_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.otp_otp_id_seq1', 1, false);


--
-- TOC entry 4393 (class 0 OID 0)
-- Dependencies: 286
-- Name: otp_otp_id_seq2; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.otp_otp_id_seq2', 44, true);


--
-- TOC entry 4394 (class 0 OID 0)
-- Dependencies: 288
-- Name: package_combo_id_combo_package_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.package_combo_id_combo_package_seq', 8, true);


--
-- TOC entry 4395 (class 0 OID 0)
-- Dependencies: 291
-- Name: package_extra_id_extra_package_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.package_extra_id_extra_package_seq', 7, true);


--
-- TOC entry 4396 (class 0 OID 0)
-- Dependencies: 293
-- Name: package_main_id_main_package_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.package_main_id_main_package_seq', 6, true);


--
-- TOC entry 4397 (class 0 OID 0)
-- Dependencies: 295
-- Name: payment_history_id_payment_history_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payment_history_id_payment_history_seq', 7, true);


--
-- TOC entry 4398 (class 0 OID 0)
-- Dependencies: 297
-- Name: payment_method_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payment_method_id_seq', 1, false);


--
-- TOC entry 4399 (class 0 OID 0)
-- Dependencies: 298
-- Name: payment_method_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payment_method_id_seq1', 1, false);


--
-- TOC entry 4400 (class 0 OID 0)
-- Dependencies: 299
-- Name: refresh_token_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.refresh_token_id_seq', 1332, true);


--
-- TOC entry 4401 (class 0 OID 0)
-- Dependencies: 301
-- Name: refresh_token_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.refresh_token_id_seq1', 1, false);


--
-- TOC entry 4402 (class 0 OID 0)
-- Dependencies: 302
-- Name: refresh_token_id_seq2; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.refresh_token_id_seq2', 27522, true);


--
-- TOC entry 4403 (class 0 OID 0)
-- Dependencies: 304
-- Name: room_id_room_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.room_id_room_seq', 35, true);


--
-- TOC entry 4404 (class 0 OID 0)
-- Dependencies: 306
-- Name: shopping_item_types_id_item_type_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shopping_item_types_id_item_type_seq', 40, true);


--
-- TOC entry 4405 (class 0 OID 0)
-- Dependencies: 308
-- Name: shopping_items_id_item_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shopping_items_id_item_seq', 4, true);


--
-- TOC entry 4406 (class 0 OID 0)
-- Dependencies: 310
-- Name: shopping_list_types_id_shopping_list_type_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shopping_list_types_id_shopping_list_type_seq', 6, true);


--
-- TOC entry 4407 (class 0 OID 0)
-- Dependencies: 312
-- Name: shopping_lists_id_list_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shopping_lists_id_list_seq', 5, true);


--
-- TOC entry 4408 (class 0 OID 0)
-- Dependencies: 314
-- Name: subject_id_subject_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subject_id_subject_seq', 133, true);


--
-- TOC entry 4409 (class 0 OID 0)
-- Dependencies: 315
-- Name: subjects_id_subject_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subjects_id_subject_seq', 1, false);


--
-- TOC entry 4410 (class 0 OID 0)
-- Dependencies: 318
-- Name: utilities_id_utility_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.utilities_id_utility_seq', 35, true);


--
-- TOC entry 4411 (class 0 OID 0)
-- Dependencies: 320
-- Name: utilities_type_id_utilities_type_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.utilities_type_id_utilities_type_seq', 13, true);


--
-- TOC entry 3865 (class 2606 OID 18063)
-- Name: discount PK_087926f6fec32903be3c8eedfae; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discount
    ADD CONSTRAINT "PK_087926f6fec32903be3c8eedfae" PRIMARY KEY (code);


--
-- TOC entry 3914 (class 2606 OID 18065)
-- Name: order PK_0b12b5d083c02c82edcdee13f75; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "PK_0b12b5d083c02c82edcdee13f75" PRIMARY KEY (id_order);


--
-- TOC entry 3881 (class 2606 OID 18067)
-- Name: feedbacks PK_11b07a1830cc1fc2b8ae7197ac6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedbacks
    ADD CONSTRAINT "PK_11b07a1830cc1fc2b8ae7197ac6" PRIMARY KEY (id_feedback);


--
-- TOC entry 3956 (class 2606 OID 18069)
-- Name: utilities PK_177a61f482f0e2368312707cc05; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilities
    ADD CONSTRAINT "PK_177a61f482f0e2368312707cc05" PRIMARY KEY (id_utility);


--
-- TOC entry 3893 (class 2606 OID 18071)
-- Name: finance_income_source PK_18ba99e684774fff78e5149d356; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.finance_income_source
    ADD CONSTRAINT "PK_18ba99e684774fff78e5149d356" PRIMARY KEY (id_income_source);


--
-- TOC entry 3970 (class 2606 OID 24710)
-- Name: frequently_question PK_5428319b3a732fa7fe9b15310ac; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.frequently_question
    ADD CONSTRAINT "PK_5428319b3a732fa7fe9b15310ac" PRIMARY KEY (id);


--
-- TOC entry 3879 (class 2606 OID 18073)
-- Name: feedback_metadata PK_565b952b6d3ecf5667c97d5c632; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedback_metadata
    ADD CONSTRAINT "PK_565b952b6d3ecf5667c97d5c632" PRIMARY KEY (metadata_key);


--
-- TOC entry 3924 (class 2606 OID 18075)
-- Name: package_extra PK_623b4f13a34cc1098cd669daf90; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.package_extra
    ADD CONSTRAINT "PK_623b4f13a34cc1098cd669daf90" PRIMARY KEY (id_extra_package);


--
-- TOC entry 3869 (class 2606 OID 18077)
-- Name: family_extra_packages PK_69bc37ea036c1e8eb36291a2e1b; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family_extra_packages
    ADD CONSTRAINT "PK_69bc37ea036c1e8eb36291a2e1b" PRIMARY KEY (id_family_extra_package);


--
-- TOC entry 3954 (class 2606 OID 18079)
-- Name: subject PK_6a78d4af7c4f73c256c43f00c40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subject
    ADD CONSTRAINT "PK_6a78d4af7c4f73c256c43f00c40" PRIMARY KEY (id_subject);


--
-- TOC entry 3936 (class 2606 OID 18081)
-- Name: shopping_item_types PK_75783d4b61c293f19977ec0df97; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shopping_item_types
    ADD CONSTRAINT "PK_75783d4b61c293f19977ec0df97" PRIMARY KEY (id_item_type);


--
-- TOC entry 3942 (class 2606 OID 18083)
-- Name: shopping_items PK_763ad253fd4db5f02ef77d116e2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shopping_items
    ADD CONSTRAINT "PK_763ad253fd4db5f02ef77d116e2" PRIMARY KEY (id_item);


--
-- TOC entry 3966 (class 2606 OID 24478)
-- Name: famili_invitation PK_7a959c28ee0168e26c85942d2bd; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.famili_invitation
    ADD CONSTRAINT "PK_7a959c28ee0168e26c85942d2bd" PRIMARY KEY (id_invitation);


--
-- TOC entry 3922 (class 2606 OID 18085)
-- Name: package_combo_package_extra PK_7bbf35b0b3c8487cd0f54fdc0d1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.package_combo_package_extra
    ADD CONSTRAINT "PK_7bbf35b0b3c8487cd0f54fdc0d1" PRIMARY KEY (package_combo_id, package_extra_id);


--
-- TOC entry 3950 (class 2606 OID 18089)
-- Name: shopping_lists PK_925a29868d29f8fe35db867ca25; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shopping_lists
    ADD CONSTRAINT "PK_925a29868d29f8fe35db867ca25" PRIMARY KEY (id_list);


--
-- TOC entry 3926 (class 2606 OID 18095)
-- Name: package_main PK_bfb3c50b304b00c26e0ec78f9a0; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.package_main
    ADD CONSTRAINT "PK_bfb3c50b304b00c26e0ec78f9a0" PRIMARY KEY (id_main_package);


--
-- TOC entry 3918 (class 2606 OID 18097)
-- Name: package_combo PK_c1b0dda5fd378d1c8f7bf7009f8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.package_combo
    ADD CONSTRAINT "PK_c1b0dda5fd378d1c8f7bf7009f8" PRIMARY KEY (id_combo_package);


--
-- TOC entry 3960 (class 2606 OID 18101)
-- Name: utilities_type PK_c7d13dacd4686cea97970e514de; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilities_type
    ADD CONSTRAINT "PK_c7d13dacd4686cea97970e514de" PRIMARY KEY (id_utilities_type);


--
-- TOC entry 3928 (class 2606 OID 18103)
-- Name: payment_history PK_cc2ad855101207078a4fc56df20; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_history
    ADD CONSTRAINT "PK_cc2ad855101207078a4fc56df20" PRIMARY KEY (id_payment_history);


--
-- TOC entry 3944 (class 2606 OID 18105)
-- Name: shopping_list_types PK_ce7a3f1b907aa179f9b3894350d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shopping_list_types
    ADD CONSTRAINT "PK_ce7a3f1b907aa179f9b3894350d" PRIMARY KEY (id_shopping_list_type);


--
-- TOC entry 3889 (class 2606 OID 18107)
-- Name: finance_expenditure_type PK_f36d12035cd95ab15fb96f7e146; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.finance_expenditure_type
    ADD CONSTRAINT "PK_f36d12035cd95ab15fb96f7e146" PRIMARY KEY (id_expenditure_type);


--
-- TOC entry 3968 (class 2606 OID 24480)
-- Name: famili_invitation REL_a77328118e1c86a4b9e33491f5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.famili_invitation
    ADD CONSTRAINT "REL_a77328118e1c86a4b9e33491f5" UNIQUE (id_family);


--
-- TOC entry 3871 (class 2606 OID 18113)
-- Name: family_extra_packages UQ_0711df05236f04c0d72a68664df; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family_extra_packages
    ADD CONSTRAINT "UQ_0711df05236f04c0d72a68664df" UNIQUE (id_family, id_extra_package);


--
-- TOC entry 3962 (class 2606 OID 18115)
-- Name: utilities_type UQ_171574b07d1359885e9502f4eb7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilities_type
    ADD CONSTRAINT "UQ_171574b07d1359885e9502f4eb7" UNIQUE (name_vn);


--
-- TOC entry 3883 (class 2606 OID 25926)
-- Name: finance_expenditure UQ_194eaa316e3f87e1ccfb079daf1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.finance_expenditure
    ADD CONSTRAINT "UQ_194eaa316e3f87e1ccfb079daf1" UNIQUE (id_utility);


--
-- TOC entry 3958 (class 2606 OID 18117)
-- Name: utilities UQ_19c413cc98dbde4feaabf61e60e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilities
    ADD CONSTRAINT "UQ_19c413cc98dbde4feaabf61e60e" UNIQUE (id_expenditure);


--
-- TOC entry 3932 (class 2606 OID 18121)
-- Name: room UQ_61fce2a10042f56cc0ff90cef67; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room
    ADD CONSTRAINT "UQ_61fce2a10042f56cc0ff90cef67" UNIQUE (id_room, room_name);


--
-- TOC entry 3946 (class 2606 OID 18123)
-- Name: shopping_list_types UQ_7989a7e61a59373515b3cc5c22b; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shopping_list_types
    ADD CONSTRAINT "UQ_7989a7e61a59373515b3cc5c22b" UNIQUE (type_name_en);


--
-- TOC entry 3964 (class 2606 OID 18125)
-- Name: utilities_type UQ_93b779c9ebfdba844c6c1657ad9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilities_type
    ADD CONSTRAINT "UQ_93b779c9ebfdba844c6c1657ad9" UNIQUE (name_en);


--
-- TOC entry 3938 (class 2606 OID 18127)
-- Name: shopping_item_types UQ_a25cdcd86abe29f3f98e2af90e5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shopping_item_types
    ADD CONSTRAINT "UQ_a25cdcd86abe29f3f98e2af90e5" UNIQUE (item_type_name_en);


--
-- TOC entry 3940 (class 2606 OID 18129)
-- Name: shopping_item_types UQ_a441dbbdd37ea8068341b896624; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shopping_item_types
    ADD CONSTRAINT "UQ_a441dbbdd37ea8068341b896624" UNIQUE (item_type_name_vn);


--
-- TOC entry 3948 (class 2606 OID 18133)
-- Name: shopping_list_types UQ_b4b27159bb699560490fdedc198; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shopping_list_types
    ADD CONSTRAINT "UQ_b4b27159bb699560490fdedc198" UNIQUE (type_name_vn);


--
-- TOC entry 3885 (class 2606 OID 26015)
-- Name: finance_expenditure UQ_c5ea38262d722a6b00e62ead008; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.finance_expenditure
    ADD CONSTRAINT "UQ_c5ea38262d722a6b00e62ead008" UNIQUE (id_shopping_list);


--
-- TOC entry 3952 (class 2606 OID 18135)
-- Name: shopping_lists UQ_c744d012a4f319192cee4190b45; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shopping_lists
    ADD CONSTRAINT "UQ_c744d012a4f319192cee4190b45" UNIQUE (id_expenditure);


--
-- TOC entry 3902 (class 2606 OID 18145)
-- Name: household_consumable_items consumable_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.household_consumable_items
    ADD CONSTRAINT consumable_items_pkey PRIMARY KEY (id_household_item);


--
-- TOC entry 3867 (class 2606 OID 18147)
-- Name: education_progress education_progress_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.education_progress
    ADD CONSTRAINT education_progress_pkey PRIMARY KEY (id_education_progress);


--
-- TOC entry 3873 (class 2606 OID 18149)
-- Name: family_invitation family_invitation_id_family_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family_invitation
    ADD CONSTRAINT family_invitation_id_family_key UNIQUE (id_family);


--
-- TOC entry 3875 (class 2606 OID 18151)
-- Name: family_invitation family_invitation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family_invitation
    ADD CONSTRAINT family_invitation_pkey PRIMARY KEY (id_invitation);


--
-- TOC entry 3861 (class 2606 OID 18153)
-- Name: family family_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family
    ADD CONSTRAINT family_pk PRIMARY KEY (id_family);


--
-- TOC entry 3877 (class 2606 OID 18155)
-- Name: family_roles family_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family_roles
    ADD CONSTRAINT family_roles_pkey PRIMARY KEY (id_family_role);


--
-- TOC entry 3859 (class 2606 OID 18157)
-- Name: finance_assets finance_assets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.finance_assets
    ADD CONSTRAINT finance_assets_pkey PRIMARY KEY (id_asset);


--
-- TOC entry 3887 (class 2606 OID 18159)
-- Name: finance_expenditure finance_expenditure_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.finance_expenditure
    ADD CONSTRAINT finance_expenditure_pkey PRIMARY KEY (id_expenditure);


--
-- TOC entry 3891 (class 2606 OID 18161)
-- Name: finance_income finance_income_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.finance_income
    ADD CONSTRAINT finance_income_pkey PRIMARY KEY (id_income);


--
-- TOC entry 3895 (class 2606 OID 18163)
-- Name: financial_summary financial_summary_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.financial_summary
    ADD CONSTRAINT financial_summary_pkey PRIMARY KEY (id_summary);


--
-- TOC entry 3904 (class 2606 OID 18165)
-- Name: household_durable_items fixed_assets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.household_durable_items
    ADD CONSTRAINT fixed_assets_pkey PRIMARY KEY (id_household_item);


--
-- TOC entry 3900 (class 2606 OID 18167)
-- Name: flow_watermarks flow_watermarks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flow_watermarks
    ADD CONSTRAINT flow_watermarks_pkey PRIMARY KEY (slot);


--
-- TOC entry 3906 (class 2606 OID 18169)
-- Name: household_item_categories household_item_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.household_item_categories
    ADD CONSTRAINT household_item_categories_pkey PRIMARY KEY (id_household_item_category);


--
-- TOC entry 3863 (class 2606 OID 18171)
-- Name: household_items household_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.household_items
    ADD CONSTRAINT household_items_pkey PRIMARY KEY (id_household_item);


--
-- TOC entry 3910 (class 2606 OID 18173)
-- Name: invoice_items invoice_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_items
    ADD CONSTRAINT invoice_items_pkey PRIMARY KEY (id_item);


--
-- TOC entry 3908 (class 2606 OID 18175)
-- Name: invoice invoice_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_pkey PRIMARY KEY (id_invoice);


--
-- TOC entry 3912 (class 2606 OID 18177)
-- Name: invoice_type invoice_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_type
    ADD CONSTRAINT invoice_type_pkey PRIMARY KEY (id_invoice_type);


--
-- TOC entry 3855 (class 2606 OID 18181)
-- Name: member_family member_family_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.member_family
    ADD CONSTRAINT member_family_pk PRIMARY KEY (id);


--
-- TOC entry 3916 (class 2606 OID 18183)
-- Name: otp otp_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.otp
    ADD CONSTRAINT otp_pk PRIMARY KEY (id_otp);


--
-- TOC entry 3930 (class 2606 OID 18185)
-- Name: refresh_token refresh_token_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh_token
    ADD CONSTRAINT refresh_token_pk PRIMARY KEY (id);


--
-- TOC entry 3934 (class 2606 OID 18187)
-- Name: room room_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_pkey PRIMARY KEY (id_room);


--
-- TOC entry 3898 (class 2606 OID 18189)
-- Name: financial_summary unique_family_date; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.financial_summary
    ADD CONSTRAINT unique_family_date UNIQUE (id_family, summary_date);


--
-- TOC entry 3857 (class 2606 OID 18191)
-- Name: users user_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT user_pk PRIMARY KEY (id_user);


--
-- TOC entry 3919 (class 1259 OID 18192)
-- Name: IDX_24fb0f1455ea9b3960adea4bfd; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_24fb0f1455ea9b3960adea4bfd" ON public.package_combo_package_extra USING btree (package_combo_id);


--
-- TOC entry 3920 (class 1259 OID 18193)
-- Name: IDX_4e6703bf394a3d7af840fd0707; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_4e6703bf394a3d7af840fd0707" ON public.package_combo_package_extra USING btree (package_extra_id);


--
-- TOC entry 3896 (class 1259 OID 18194)
-- Name: idx_summary_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_summary_date ON public.financial_summary USING btree (summary_date);


--
-- TOC entry 4018 (class 2620 OID 18197)
-- Name: member_family decrease_family_quantity_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER decrease_family_quantity_trigger AFTER DELETE ON public.member_family FOR EACH ROW EXECUTE FUNCTION public.decrease_family_quantity();


--
-- TOC entry 4020 (class 2620 OID 25031)
-- Name: family insert_finance_expenditure; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER insert_finance_expenditure AFTER INSERT ON public.family FOR EACH ROW EXECUTE FUNCTION public.insert_finance_expenditure();


--
-- TOC entry 4024 (class 2620 OID 18206)
-- Name: invoice_items trigger_update_invoice_amount; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_update_invoice_amount AFTER INSERT OR DELETE OR UPDATE ON public.invoice_items FOR EACH ROW EXECUTE FUNCTION public.update_invoice_amount();


--
-- TOC entry 4022 (class 2620 OID 18207)
-- Name: invoice trigger_update_total_amount; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_update_total_amount BEFORE INSERT OR UPDATE ON public.invoice FOR EACH ROW EXECUTE FUNCTION public.update_total_amount();


--
-- TOC entry 4021 (class 2620 OID 18209)
-- Name: education_progress update_education_progress_modtime; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_education_progress_modtime BEFORE UPDATE ON public.education_progress FOR EACH ROW EXECUTE FUNCTION public.update_modified_column();


--
-- TOC entry 4019 (class 2620 OID 18210)
-- Name: member_family update_family_quantity_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_family_quantity_trigger AFTER INSERT OR UPDATE ON public.member_family FOR EACH ROW EXECUTE FUNCTION public.update_family_quantity();


--
-- TOC entry 4023 (class 2620 OID 18211)
-- Name: invoice update_invoice_updated_at_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_invoice_updated_at_trigger BEFORE UPDATE ON public.invoice FOR EACH ROW EXECUTE FUNCTION public.update_invoice_updated_at();


--
-- TOC entry 3979 (class 2606 OID 18213)
-- Name: education_progress FK_08fd533f2a537656dfe6a39ad3e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.education_progress
    ADD CONSTRAINT "FK_08fd533f2a537656dfe6a39ad3e" FOREIGN KEY (id_family) REFERENCES public.family(id_family);


--
-- TOC entry 4008 (class 2606 OID 18223)
-- Name: shopping_items FK_1279f8b50d7245e13af3fab8a84; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shopping_items
    ADD CONSTRAINT "FK_1279f8b50d7245e13af3fab8a84" FOREIGN KEY (id_list) REFERENCES public.shopping_lists(id_list);


--
-- TOC entry 3976 (class 2606 OID 18228)
-- Name: household_items FK_14288da1f4af6438b12b8154178; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.household_items
    ADD CONSTRAINT "FK_14288da1f4af6438b12b8154178" FOREIGN KEY (id_category) REFERENCES public.household_item_categories(id_household_item_category);


--
-- TOC entry 3985 (class 2606 OID 25970)
-- Name: finance_expenditure FK_194eaa316e3f87e1ccfb079daf1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.finance_expenditure
    ADD CONSTRAINT "FK_194eaa316e3f87e1ccfb079daf1" FOREIGN KEY (id_utility) REFERENCES public.utilities(id_utility) ON DELETE CASCADE;


--
-- TOC entry 4014 (class 2606 OID 25989)
-- Name: utilities FK_19c413cc98dbde4feaabf61e60e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilities
    ADD CONSTRAINT "FK_19c413cc98dbde4feaabf61e60e" FOREIGN KEY (id_expenditure) REFERENCES public.finance_expenditure(id_expenditure) ON DELETE SET NULL;


--
-- TOC entry 3997 (class 2606 OID 18238)
-- Name: order FK_1b6d4c36bfc4406257ea18ca86f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "FK_1b6d4c36bfc4406257ea18ca86f" FOREIGN KEY (id_package_main) REFERENCES public.package_main(id_main_package);


--
-- TOC entry 3977 (class 2606 OID 18243)
-- Name: household_items FK_1d6981e55b514cadde7bd0f9edc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.household_items
    ADD CONSTRAINT "FK_1d6981e55b514cadde7bd0f9edc" FOREIGN KEY (id_family) REFERENCES public.family(id_family);


--
-- TOC entry 3998 (class 2606 OID 18248)
-- Name: order FK_1e662a2957bd101ce9799af5b59; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "FK_1e662a2957bd101ce9799af5b59" FOREIGN KEY (id_package_combo) REFERENCES public.package_combo(id_combo_package);


--
-- TOC entry 3999 (class 2606 OID 18253)
-- Name: order FK_200f6194460f392f21d1e08eb4b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "FK_200f6194460f392f21d1e08eb4b" FOREIGN KEY (id_user) REFERENCES public.users(id_user);


--
-- TOC entry 3971 (class 2606 OID 18258)
-- Name: member_family FK_238b32ca0213b65382e3a337e20; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.member_family
    ADD CONSTRAINT "FK_238b32ca0213b65382e3a337e20" FOREIGN KEY (id_family) REFERENCES public.family(id_family);


--
-- TOC entry 4002 (class 2606 OID 18263)
-- Name: package_combo_package_extra FK_24fb0f1455ea9b3960adea4bfd0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.package_combo_package_extra
    ADD CONSTRAINT "FK_24fb0f1455ea9b3960adea4bfd0" FOREIGN KEY (package_combo_id) REFERENCES public.package_combo(id_combo_package) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4000 (class 2606 OID 18268)
-- Name: order FK_2fca3384ca229ccdc266a23ec25; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "FK_2fca3384ca229ccdc266a23ec25" FOREIGN KEY (id_package_extra) REFERENCES public.package_extra(id_extra_package);


--
-- TOC entry 3972 (class 2606 OID 18278)
-- Name: member_family FK_3745e1acdf7a58a3a1717b57fa4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.member_family
    ADD CONSTRAINT "FK_3745e1acdf7a58a3a1717b57fa4" FOREIGN KEY (id_family_role) REFERENCES public.family_roles(id_family_role);


--
-- TOC entry 4015 (class 2606 OID 18283)
-- Name: utilities FK_39c873dfdb895c4b3d744dd60a0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilities
    ADD CONSTRAINT "FK_39c873dfdb895c4b3d744dd60a0" FOREIGN KEY (id_utilities_type) REFERENCES public.utilities_type(id_utilities_type);


--
-- TOC entry 3986 (class 2606 OID 18288)
-- Name: finance_expenditure FK_3aaa3162cee524817762c963526; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.finance_expenditure
    ADD CONSTRAINT "FK_3aaa3162cee524817762c963526" FOREIGN KEY (id_created_by) REFERENCES public.users(id_user);


--
-- TOC entry 3978 (class 2606 OID 18293)
-- Name: household_items FK_3c78dae27e337bba258129651ab; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.household_items
    ADD CONSTRAINT "FK_3c78dae27e337bba258129651ab" FOREIGN KEY (id_room) REFERENCES public.room(id_room);


--
-- TOC entry 4010 (class 2606 OID 18298)
-- Name: shopping_lists FK_3e755f6b7a9841687cbff01ff9c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shopping_lists
    ADD CONSTRAINT "FK_3e755f6b7a9841687cbff01ff9c" FOREIGN KEY (id_shopping_list_type) REFERENCES public.shopping_list_types(id_shopping_list_type);


--
-- TOC entry 4001 (class 2606 OID 18303)
-- Name: order FK_3ee680e936c2a81052734683f8d; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "FK_3ee680e936c2a81052734683f8d" FOREIGN KEY (id_family) REFERENCES public.family(id_family);


--
-- TOC entry 4011 (class 2606 OID 18313)
-- Name: shopping_lists FK_4c1e5efa33503ef18816ecf419e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shopping_lists
    ADD CONSTRAINT "FK_4c1e5efa33503ef18816ecf419e" FOREIGN KEY (id_family) REFERENCES public.family(id_family);


--
-- TOC entry 3974 (class 2606 OID 18318)
-- Name: finance_assets FK_4d4c03b039ff864e6f6331f8572; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.finance_assets
    ADD CONSTRAINT "FK_4d4c03b039ff864e6f6331f8572" FOREIGN KEY (id_family) REFERENCES public.family(id_family);


--
-- TOC entry 4003 (class 2606 OID 18323)
-- Name: package_combo_package_extra FK_4e6703bf394a3d7af840fd0707b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.package_combo_package_extra
    ADD CONSTRAINT "FK_4e6703bf394a3d7af840fd0707b" FOREIGN KEY (package_extra_id) REFERENCES public.package_extra(id_extra_package);


--
-- TOC entry 4016 (class 2606 OID 18328)
-- Name: utilities FK_504393f3802637a5794df5920ec; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilities
    ADD CONSTRAINT "FK_504393f3802637a5794df5920ec" FOREIGN KEY (id_family) REFERENCES public.family(id_family);


--
-- TOC entry 3981 (class 2606 OID 18333)
-- Name: family_extra_packages FK_55524babcef42716f85d162c47f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family_extra_packages
    ADD CONSTRAINT "FK_55524babcef42716f85d162c47f" FOREIGN KEY (id_extra_package) REFERENCES public.package_extra(id_extra_package);


--
-- TOC entry 3973 (class 2606 OID 18343)
-- Name: member_family FK_5f049421698995140fc1b7a63b5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.member_family
    ADD CONSTRAINT "FK_5f049421698995140fc1b7a63b5" FOREIGN KEY (id_user) REFERENCES public.users(id_user);


--
-- TOC entry 3989 (class 2606 OID 18363)
-- Name: finance_income FK_68a4b444157646c11be0b986e45; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.finance_income
    ADD CONSTRAINT "FK_68a4b444157646c11be0b986e45" FOREIGN KEY (id_created_by) REFERENCES public.users(id_user);


--
-- TOC entry 4004 (class 2606 OID 18373)
-- Name: payment_history FK_74de8eeb900bcc8ec5293b3a52e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_history
    ADD CONSTRAINT "FK_74de8eeb900bcc8ec5293b3a52e" FOREIGN KEY (id_order) REFERENCES public."order"(id_order);


--
-- TOC entry 3980 (class 2606 OID 18383)
-- Name: education_progress FK_84a855f55efb0c66383ff17aeb3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.education_progress
    ADD CONSTRAINT "FK_84a855f55efb0c66383ff17aeb3" FOREIGN KEY (id_user) REFERENCES public.users(id_user);


--
-- TOC entry 4009 (class 2606 OID 18388)
-- Name: shopping_items FK_90ba7379b3f9a9432bd10896d60; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shopping_items
    ADD CONSTRAINT "FK_90ba7379b3f9a9432bd10896d60" FOREIGN KEY (id_item_type) REFERENCES public.shopping_item_types(id_item_type);


--
-- TOC entry 4007 (class 2606 OID 18393)
-- Name: room FK_9b7109323e4f3c259c0e72d4ac7; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room
    ADD CONSTRAINT "FK_9b7109323e4f3c259c0e72d4ac7" FOREIGN KEY (id_family) REFERENCES public.family(id_family);


--
-- TOC entry 3990 (class 2606 OID 18398)
-- Name: finance_income FK_a72708fd600ad5a798509c7a0e4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.finance_income
    ADD CONSTRAINT "FK_a72708fd600ad5a798509c7a0e4" FOREIGN KEY (id_income_source) REFERENCES public.finance_income_source(id_income_source);


--
-- TOC entry 4017 (class 2606 OID 24482)
-- Name: famili_invitation FK_a77328118e1c86a4b9e33491f5e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.famili_invitation
    ADD CONSTRAINT "FK_a77328118e1c86a4b9e33491f5e" FOREIGN KEY (id_family) REFERENCES public.family(id_family);


--
-- TOC entry 3992 (class 2606 OID 18403)
-- Name: household_consumable_items FK_ab7cc27d018308d1cdbd35f5249; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.household_consumable_items
    ADD CONSTRAINT "FK_ab7cc27d018308d1cdbd35f5249" FOREIGN KEY (id_household_item) REFERENCES public.household_items(id_household_item);


--
-- TOC entry 3984 (class 2606 OID 18408)
-- Name: feedbacks FK_aeb2bc2c7e30b980c16c5bdffe9; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedbacks
    ADD CONSTRAINT "FK_aeb2bc2c7e30b980c16c5bdffe9" FOREIGN KEY (id_user) REFERENCES public.users(id_user) ON DELETE CASCADE;


--
-- TOC entry 4013 (class 2606 OID 18413)
-- Name: subject FK_bd45c33e1bb67b2efb0148bad5e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subject
    ADD CONSTRAINT "FK_bd45c33e1bb67b2efb0148bad5e" FOREIGN KEY (id_education_progress) REFERENCES public.education_progress(id_education_progress);


--
-- TOC entry 3975 (class 2606 OID 18423)
-- Name: family FK_c312627f224d28d78fb1b68f8e1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family
    ADD CONSTRAINT "FK_c312627f224d28d78fb1b68f8e1" FOREIGN KEY (owner_id) REFERENCES public.users(id_user);


--
-- TOC entry 3987 (class 2606 OID 26017)
-- Name: finance_expenditure FK_c5ea38262d722a6b00e62ead008; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.finance_expenditure
    ADD CONSTRAINT "FK_c5ea38262d722a6b00e62ead008" FOREIGN KEY (id_shopping_list) REFERENCES public.shopping_lists(id_list) ON DELETE SET NULL;


--
-- TOC entry 4012 (class 2606 OID 26008)
-- Name: shopping_lists FK_c744d012a4f319192cee4190b45; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shopping_lists
    ADD CONSTRAINT "FK_c744d012a4f319192cee4190b45" FOREIGN KEY (id_expenditure) REFERENCES public.finance_expenditure(id_expenditure) ON DELETE SET NULL;


--
-- TOC entry 4005 (class 2606 OID 18438)
-- Name: payment_history FK_d76a3c80388458a51ef888aa9c4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payment_history
    ADD CONSTRAINT "FK_d76a3c80388458a51ef888aa9c4" FOREIGN KEY (id_user) REFERENCES public.users(id_user);


--
-- TOC entry 3993 (class 2606 OID 18443)
-- Name: household_durable_items FK_deb0bba89205540b700df084307; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.household_durable_items
    ADD CONSTRAINT "FK_deb0bba89205540b700df084307" FOREIGN KEY (id_household_item) REFERENCES public.household_items(id_household_item);


--
-- TOC entry 3988 (class 2606 OID 25949)
-- Name: finance_expenditure FK_eff1066219bf88cd604ca0a8145; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.finance_expenditure
    ADD CONSTRAINT "FK_eff1066219bf88cd604ca0a8145" FOREIGN KEY (id_expenditure_type) REFERENCES public.finance_expenditure_type(id_expenditure_type) ON DELETE CASCADE;


--
-- TOC entry 3982 (class 2606 OID 18458)
-- Name: family_extra_packages FK_f10352652fae82be641f829ba57; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family_extra_packages
    ADD CONSTRAINT "FK_f10352652fae82be641f829ba57" FOREIGN KEY (id_family) REFERENCES public.family(id_family);


--
-- TOC entry 4006 (class 2606 OID 18463)
-- Name: refresh_token FK_fd79923e4359a26a971f841fb5e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refresh_token
    ADD CONSTRAINT "FK_fd79923e4359a26a971f841fb5e" FOREIGN KEY (id_user) REFERENCES public.users(id_user);


--
-- TOC entry 3983 (class 2606 OID 18468)
-- Name: family_invitation family_invitation_id_family_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.family_invitation
    ADD CONSTRAINT family_invitation_id_family_fkey FOREIGN KEY (id_family) REFERENCES public.family(id_family);


--
-- TOC entry 3991 (class 2606 OID 18473)
-- Name: financial_summary financial_summary_id_family_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.financial_summary
    ADD CONSTRAINT financial_summary_id_family_fkey FOREIGN KEY (id_family) REFERENCES public.family(id_family);


--
-- TOC entry 3994 (class 2606 OID 18478)
-- Name: invoice invoice_id_family_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_id_family_fkey FOREIGN KEY (id_family) REFERENCES public.family(id_family);


--
-- TOC entry 3995 (class 2606 OID 18483)
-- Name: invoice invoice_id_invoice_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_id_invoice_type_fkey FOREIGN KEY (id_invoice_type) REFERENCES public.invoice_type(id_invoice_type);


--
-- TOC entry 3996 (class 2606 OID 18488)
-- Name: invoice_items invoice_items_id_invoice_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_items
    ADD CONSTRAINT invoice_items_id_invoice_fkey FOREIGN KEY (id_invoice) REFERENCES public.invoice(id_invoice);


--
-- TOC entry 4171 (class 6104 OID 18493)
-- Name: flow_publication; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION flow_publication WITH (publish = 'insert, update, delete, truncate', publish_via_partition_root = true);


ALTER PUBLICATION flow_publication OWNER TO postgres;

--
-- TOC entry 4172 (class 6106 OID 18500)
-- Name: flow_publication discount; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION flow_publication ADD TABLE ONLY public.discount;


--
-- TOC entry 4173 (class 6106 OID 18501)
-- Name: flow_publication education_progress; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION flow_publication ADD TABLE ONLY public.education_progress;


--
-- TOC entry 4174 (class 6106 OID 18503)
-- Name: flow_publication family; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION flow_publication ADD TABLE ONLY public.family;


--
-- TOC entry 4175 (class 6106 OID 18504)
-- Name: flow_publication family_extra_packages; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION flow_publication ADD TABLE ONLY public.family_extra_packages;


--
-- TOC entry 4176 (class 6106 OID 18505)
-- Name: flow_publication family_invitation; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION flow_publication ADD TABLE ONLY public.family_invitation;


--
-- TOC entry 4177 (class 6106 OID 18506)
-- Name: flow_publication family_roles; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION flow_publication ADD TABLE ONLY public.family_roles;


--
-- TOC entry 4178 (class 6106 OID 18507)
-- Name: flow_publication feedback_metadata; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION flow_publication ADD TABLE ONLY public.feedback_metadata;


--
-- TOC entry 4179 (class 6106 OID 18508)
-- Name: flow_publication feedbacks; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION flow_publication ADD TABLE ONLY public.feedbacks;


--
-- TOC entry 4180 (class 6106 OID 18509)
-- Name: flow_publication finance_assets; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION flow_publication ADD TABLE ONLY public.finance_assets;


--
-- TOC entry 4181 (class 6106 OID 18510)
-- Name: flow_publication finance_expenditure; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION flow_publication ADD TABLE ONLY public.finance_expenditure;


--
-- TOC entry 4182 (class 6106 OID 18511)
-- Name: flow_publication finance_income; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION flow_publication ADD TABLE ONLY public.finance_income;


--
-- TOC entry 4183 (class 6106 OID 18512)
-- Name: flow_publication financial_summary; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION flow_publication ADD TABLE ONLY public.financial_summary;


--
-- TOC entry 4184 (class 6106 OID 18513)
-- Name: flow_publication flow_watermarks; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION flow_publication ADD TABLE ONLY public.flow_watermarks;


--
-- TOC entry 4185 (class 6106 OID 18515)
-- Name: flow_publication household_consumable_items; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION flow_publication ADD TABLE ONLY public.household_consumable_items;


--
-- TOC entry 4186 (class 6106 OID 18516)
-- Name: flow_publication household_durable_items; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION flow_publication ADD TABLE ONLY public.household_durable_items;


--
-- TOC entry 4187 (class 6106 OID 18517)
-- Name: flow_publication household_item_categories; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION flow_publication ADD TABLE ONLY public.household_item_categories;


--
-- TOC entry 4188 (class 6106 OID 18518)
-- Name: flow_publication household_items; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION flow_publication ADD TABLE ONLY public.household_items;


--
-- TOC entry 4189 (class 6106 OID 18520)
-- Name: flow_publication member_family; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION flow_publication ADD TABLE ONLY public.member_family;


--
-- TOC entry 4190 (class 6106 OID 18521)
-- Name: flow_publication otp; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION flow_publication ADD TABLE ONLY public.otp;


--
-- TOC entry 4191 (class 6106 OID 18522)
-- Name: flow_publication package_combo; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION flow_publication ADD TABLE ONLY public.package_combo;


--
-- TOC entry 4192 (class 6106 OID 18523)
-- Name: flow_publication package_combo_package_extra; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION flow_publication ADD TABLE ONLY public.package_combo_package_extra;


--
-- TOC entry 4193 (class 6106 OID 18524)
-- Name: flow_publication package_extra; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION flow_publication ADD TABLE ONLY public.package_extra;


--
-- TOC entry 4194 (class 6106 OID 18525)
-- Name: flow_publication package_main; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION flow_publication ADD TABLE ONLY public.package_main;


--
-- TOC entry 4195 (class 6106 OID 18526)
-- Name: flow_publication payment_history; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION flow_publication ADD TABLE ONLY public.payment_history;


--
-- TOC entry 4196 (class 6106 OID 18527)
-- Name: flow_publication payment_method; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION flow_publication ADD TABLE ONLY public.payment_method;


--
-- TOC entry 4197 (class 6106 OID 18528)
-- Name: flow_publication refresh_token; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION flow_publication ADD TABLE ONLY public.refresh_token;


--
-- TOC entry 4198 (class 6106 OID 18529)
-- Name: flow_publication shopping_list_types; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION flow_publication ADD TABLE ONLY public.shopping_list_types;


--
-- TOC entry 4199 (class 6106 OID 18530)
-- Name: flow_publication subject; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION flow_publication ADD TABLE ONLY public.subject;


--
-- TOC entry 4200 (class 6106 OID 18531)
-- Name: flow_publication users; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION flow_publication ADD TABLE ONLY public.users;


--
-- TOC entry 4201 (class 6106 OID 18532)
-- Name: flow_publication utilities; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION flow_publication ADD TABLE ONLY public.utilities;


--
-- TOC entry 4202 (class 6106 OID 18533)
-- Name: flow_publication utilities_type; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION flow_publication ADD TABLE ONLY public.utilities_type;


--
-- TOC entry 4203 (class 6106 OID 18534)
-- Name: flow_publication v_user_id; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION flow_publication ADD TABLE ONLY public.v_user_id;


-- Completed on 2024-08-02 02:00:01 UTC

--
-- PostgreSQL database dump complete
--

