PGDMP         1                |            famfund_database    15.7 (Debian 15.7-0+deb12u1)    15.7 (Debian 15.7-0+deb12u1) �   v           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            w           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            x           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            y           1262    17215    famfund_database    DATABASE     x   CREATE DATABASE famfund_database WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C.UTF-8';
     DROP DATABASE famfund_database;
                postgres    false                        2615    17216    aiven_extras    SCHEMA        CREATE SCHEMA aiven_extras;
    DROP SCHEMA aiven_extras;
                postgres    false                        3079    17217    pgcrypto 	   EXTENSION     <   CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;
    DROP EXTENSION pgcrypto;
                   false            z           0    0    EXTENSION pgcrypto    COMMENT     <   COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';
                        false    2                        3079    17254 	   uuid-ossp 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;
    DROP EXTENSION "uuid-ossp";
                   false            {           0    0    EXTENSION "uuid-ossp"    COMMENT     W   COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';
                        false    3            �           1247    17266 
   genre_enum    TYPE     Y   CREATE TYPE public.genre_enum AS ENUM (
    'male',
    'female',
    'non_specified'
);
    DROP TYPE public.genre_enum;
       public          postgres    false            �           1247    17274    homework_status    TYPE     O   CREATE TYPE public.homework_status AS ENUM (
    'pending',
    'completed'
);
 "   DROP TYPE public.homework_status;
       public          postgres    false            �           1247    17281    household_item_detail    TYPE     S  CREATE TYPE public.household_item_detail AS (
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
 (   DROP TYPE public.household_item_detail;
       public          postgres    false            �           1247    17284    household_item_details    TYPE     V  CREATE TYPE public.household_item_details AS (
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
 )   DROP TYPE public.household_item_details;
       public          postgres    false            �           1247    17287    household_item_record    TYPE     �   CREATE TYPE public.household_item_record AS (
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
 (   DROP TYPE public.household_item_record;
       public          postgres    false            �           1247    17290    household_item_update    TYPE     �   CREATE TYPE public.household_item_update AS (
	old_imageurl text,
	new_item_name text,
	new_item_description text,
	new_id_category integer,
	new_item_imageurl text
);
 (   DROP TYPE public.household_item_update;
       public          postgres    false            �           1247    17292    member_family_role_enum    TYPE     R   CREATE TYPE public.member_family_role_enum AS ENUM (
    'Member',
    'Owner'
);
 *   DROP TYPE public.member_family_role_enum;
       public          postgres    false            �           1247    17298    order_status_enum    TYPE     ]   CREATE TYPE public.order_status_enum AS ENUM (
    'PENDING',
    'SUCCESS',
    'FAILED'
);
 $   DROP TYPE public.order_status_enum;
       public          postgres    false            �           1247    17306    otp_type    TYPE     W   CREATE TYPE public.otp_type AS ENUM (
    'forgot password',
    'register account'
);
    DROP TYPE public.otp_type;
       public          postgres    false            �           1247    17312    shopping_lists_status_enum    TYPE     ^   CREATE TYPE public.shopping_lists_status_enum AS ENUM (
    'IN_PROGRESS',
    'COMPLETED'
);
 -   DROP TYPE public.shopping_lists_status_enum;
       public          postgres    false            �           1247    17318    status    TYPE     d   CREATE TYPE public.status AS ENUM (
    'failed',
    'successed',
    'pending',
    'refunded'
);
    DROP TYPE public.status;
       public          postgres    false            �           1247    17328    status_e    TYPE     f   CREATE TYPE public.status_e AS ENUM (
    'Failed',
    'Succeeded',
    'Pending',
    'Refunded'
);
    DROP TYPE public.status_e;
       public          postgres    false            �           1247    17338    status_enum    TYPE     i   CREATE TYPE public.status_enum AS ENUM (
    'Failed',
    'Successed',
    'Pending',
    'Refunded'
);
    DROP TYPE public.status_enum;
       public          postgres    false            �           1247    17348    subject_status    TYPE     M   CREATE TYPE public.subject_status AS ENUM (
    'in_progress',
    'done'
);
 !   DROP TYPE public.subject_status;
       public          postgres    false            �           1247    17354    type_otp    TYPE     ]   CREATE TYPE public.type_otp AS ENUM (
    'verify',
    'register',
    'forgot_password'
);
    DROP TYPE public.type_otp;
       public          postgres    false            �           1247    17362    users_login_type_enum    TYPE     `   CREATE TYPE public.users_login_type_enum AS ENUM (
    'local',
    'google',
    'facebook'
);
 (   DROP TYPE public.users_login_type_enum;
       public          postgres    false            �           1255    17369    add_default_categories()    FUNCTION     �  CREATE FUNCTION public.add_default_categories() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Insert the default categories 'Business' and 'Personal' for the new family
    INSERT INTO category_event (title, color, id_family)
    VALUES 
        ('Business', '#FF0000', NEW.id_family),
        ('Other', 'white', NEW.id_family);
    
    -- Return the new row in the family table
    RETURN NEW;
END;
$$;
 /   DROP FUNCTION public.add_default_categories();
       public          postgres    false            �           1255    17370    analyze_and_query_table_sizes()    FUNCTION     l  CREATE FUNCTION public.analyze_and_query_table_sizes() RETURNS TABLE("Table" name, "Total Size (KB)" bigint, "Table Size (KB)" bigint, "Index Size (KB)" bigint, "Live Tuples" bigint, "Dead Tuples" bigint)
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
 6   DROP FUNCTION public.analyze_and_query_table_sizes();
       public          postgres    false            �           1255    17371 ,   array_insert_at_index(json[], integer, json)    FUNCTION       CREATE FUNCTION public.array_insert_at_index(arr json[], idx integer, elem json) RETURNS json[]
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN array_cat(array_cat(array_slice(arr, 1, idx), ARRAY[elem]), array_slice(arr, idx+1, array_length(arr, 1)-idx));
END;
$$;
 P   DROP FUNCTION public.array_insert_at_index(arr json[], idx integer, elem json);
       public          postgres    false            �           1255    17372 ,   check_phone_number_exists(character varying)    FUNCTION       CREATE FUNCTION public.check_phone_number_exists(p_phone character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE
    phone_exists BOOLEAN;
BEGIN
    SELECT EXISTS (SELECT 1 FROM users WHERE phone = p_phone) INTO phone_exists;
    RETURN phone_exists;
END;
$$;
 K   DROP FUNCTION public.check_phone_number_exists(p_phone character varying);
       public          postgres    false            �           1255    17373 7   compare_passwords(character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.compare_passwords(input_password character varying, hashed_password character varying) RETURNS boolean
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
 m   DROP FUNCTION public.compare_passwords(input_password character varying, hashed_password character varying);
       public          postgres    false            �           1255    17374 J   create_category_event(character varying, character varying, integer, uuid)    FUNCTION       CREATE FUNCTION public.create_category_event(_title character varying, _color character varying, _id_family integer, _id_user uuid) RETURNS TABLE(id_category_event integer, title character varying, color character varying, id_family integer)
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
 �   DROP FUNCTION public.create_category_event(_title character varying, _color character varying, _id_family integer, _id_user uuid);
       public          postgres    false            �           1255    17375    create_users_from_table() 	   PROCEDURE     �  CREATE PROCEDURE public.create_users_from_table()
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
 1   DROP PROCEDURE public.create_users_from_table();
       public          postgres    false            �           1255    17376    decrease_family_quantity()    FUNCTION       CREATE FUNCTION public.decrease_family_quantity() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF TG_OP = 'DELETE' THEN
        UPDATE family SET quantity = quantity - 1 WHERE id_family = OLD.id_family;
    END IF;
    RETURN OLD;
END;
$$;
 1   DROP FUNCTION public.decrease_family_quantity();
       public          postgres    false            �           1255    17377    decryption(text)    FUNCTION     g  CREATE FUNCTION public.decryption(encrypted_data text) RETURNS text
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
 6   DROP FUNCTION public.decryption(encrypted_data text);
       public          postgres    false            �           1255    17378    delete_category_event(integer)    FUNCTION     �   CREATE FUNCTION public.delete_category_event(_id_category_event integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM category_event WHERE id_category_event = _id_category_event;
END;
$$;
 H   DROP FUNCTION public.delete_category_event(_id_category_event integer);
       public          postgres    false            �           1255    17379 $   delete_category_event(integer, uuid)    FUNCTION     �  CREATE FUNCTION public.delete_category_event(_id_category_event integer, _id_user uuid) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM member_family f WHERE f.id_family = p_id_family AND f.id_user = p_id_user) THEN
        DELETE FROM category_event WHERE id_category_event = _id_category_event;
    ELSE
        RAISE EXCEPTION 'User does not belong to the specified family';
    END IF;
END;
$$;
 W   DROP FUNCTION public.delete_category_event(_id_category_event integer, _id_user uuid);
       public          postgres    false            �           1255    17380 -   delete_category_event(integer, integer, uuid)    FUNCTION     �  CREATE FUNCTION public.delete_category_event(_id_category_event integer, _id_family integer, _id_user uuid) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM member_family f WHERE f.id_family = _id_family AND f.id_user = _id_user) THEN
        DELETE FROM category_event WHERE id_category_event = _id_category_event;
    ELSE
        RAISE EXCEPTION 'User does not belong to the specified family';
    END IF;
END;
$$;
 k   DROP FUNCTION public.delete_category_event(_id_category_event integer, _id_family integer, _id_user uuid);
       public          postgres    false            �           1255    17381    encrypt(text)    FUNCTION       CREATE FUNCTION public.encrypt(data text) RETURNS bytea
    LANGUAGE plpgsql
    AS $$
DECLARE
    key_bytea bytea;
BEGIN
    SELECT key INTO key_bytea FROM key WHERE id = 1;
    RETURN pgp_sym_encrypt(data, key_bytea, 'compress-algo=1, cipher-algo=aes256');
END;
$$;
 )   DROP FUNCTION public.encrypt(data text);
       public          postgres    false            �           1255    17382    encrypt_user_password()    FUNCTION     �  CREATE FUNCTION public.encrypt_user_password() RETURNS trigger
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
 .   DROP FUNCTION public.encrypt_user_password();
       public          postgres    false            �           1255    17383    encryption(text)    FUNCTION     q  CREATE FUNCTION public.encryption(data text) RETURNS text
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
 ,   DROP FUNCTION public.encryption(data text);
       public          postgres    false            �           1255    17384 N   f_add_component_score(text, integer, integer, integer, text, double precision)    FUNCTION     �  CREATE FUNCTION public.f_add_component_score(p_id_user text, p_id_subject integer, p_id_education_progress integer, p_id_family integer, p_component_name text, p_score double precision) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    new_component JSONB;
    current_component_scores JSONB;
    updated_component_scores JSONB;
BEGIN
    new_component := jsonb_build_object(
        'component_name', p_component_name,
        'score', p_score
    );

    SELECT component_scores INTO current_component_scores FROM subjects WHERE id_subject = p_id_subject;

    IF current_component_scores IS NULL THEN
        updated_component_scores := jsonb_build_object('component_scores', jsonb_build_array(new_component));
    ELSE
        updated_component_scores := jsonb_set(
            current_component_scores,
            '{component_scores}',
            (current_component_scores -> 'component_scores') || new_component
        );
    END IF;

    UPDATE subjects
    SET component_scores = updated_component_scores
    WHERE id_subject = p_id_subject AND id_education_progress = p_id_education_progress;

    RETURN updated_component_scores;
END;
$$;
 �   DROP FUNCTION public.f_add_component_score(p_id_user text, p_id_subject integer, p_id_education_progress integer, p_id_family integer, p_component_name text, p_score double precision);
       public          postgres    false            �           1255    17385 e   f_add_guideline_step(character varying, integer, integer, character varying, character varying, text)    FUNCTION        CREATE FUNCTION public.f_add_guideline_step(p_id_user character varying, p_id_family integer, p_id_guideline integer, p_name character varying, p_description character varying, p_fileurl text) RETURNS json
    LANGUAGE plpgsql
    AS $$
DECLARE
    new_step JSON;
    current_steps JSON;
    updated_steps JSON;
BEGIN
    new_step := json_build_object(
        'name', p_name,
        'description', p_description,
        'imageUrl', p_fileUrl
    );
    
    SELECT step INTO current_steps FROM guide_items WHERE id_family = p_id_family AND id_item = p_id_guideline;
    
    IF current_steps IS NULL THEN
        updated_steps := json_build_object('steps', json_build_array(new_step));
    ELSE
        updated_steps := json_build_object(
            'steps', (SELECT json_agg(e) FROM (SELECT json_array_elements(current_steps->'steps') UNION ALL SELECT new_step) AS dt(e))
        );
    END IF;
    
    UPDATE guide_items
    SET step = updated_steps
    WHERE id_family = p_id_family AND id_item = p_id_guideline;
    
    RETURN new_step;
END;
$$;
 �   DROP FUNCTION public.f_add_guideline_step(p_id_user character varying, p_id_family integer, p_id_guideline integer, p_name character varying, p_description character varying, p_fileurl text);
       public          postgres    false            �           1255    17386 n   f_add_guideline_step(character varying, integer, integer, character varying, character varying, text, integer)    FUNCTION       CREATE FUNCTION public.f_add_guideline_step(p_id_user character varying, p_id_family integer, p_id_guideline integer, p_name character varying, p_description character varying, p_fileurl text, p_index integer) RETURNS json
    LANGUAGE plpgsql
    AS $$
DECLARE
    new_step JSON;
    current_steps JSON;
    updated_steps JSON;
    temp_array JSON[];
    i integer := 0;
BEGIN
    new_step := json_build_object(
        'name', p_name,
        'description', p_description,
        'imageUrl', p_fileUrl
    );

    SELECT step INTO current_steps FROM guide_items WHERE id_family = p_id_family AND id_item = p_id_guideline;

    IF current_steps IS NULL THEN
        RAISE EXCEPTION 'No guideline found for Family ID % and Guideline ID %.', p_id_family, p_id_guideline;
    END IF;

    -- Chuyển đổi các bước hiện tại thành mảng JSON
    temp_array := ARRAY(SELECT json_array_elements_text(current_steps->'steps'));

    -- Chèn bước mới vào vị trí chỉ định trong mảng
    FOR i IN 1..array_length(temp_array, 1) + 1 LOOP
        IF i = p_index THEN
            temp_array[i] := new_step;
        ELSIF i > p_index THEN
            temp_array[i] := temp_array[i-1];
        END IF;
    END LOOP;

    -- Tạo đối tượng JSON mới từ mảng đã chỉnh sửa
    updated_steps := json_build_object('steps', temp_array);

    -- Cập nhật bước vào bảng guide_items
    UPDATE guide_items
    SET step = updated_steps
    WHERE id_family = p_id_family AND id_item = p_id_guideline;

    RETURN new_step;
END;
$$;
 �   DROP FUNCTION public.f_add_guideline_step(p_id_user character varying, p_id_family integer, p_id_guideline integer, p_name character varying, p_description character varying, p_fileurl text, p_index integer);
       public          postgres    false            �           1255    17387 A   f_add_member(uuid, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION public.f_add_member(p_id uuid, p_phone character varying, p_email character varying, p_role integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_family_id INT;
    v_user_id UUID;
    v_name_family varchar;
    result_message varchar;
BEGIN 
    SELECT id_family, "name" INTO v_family_id, v_name_family FROM Users WHERE id_user = p_id;

    SELECT id_user INTO v_user_id FROM Users WHERE phone = p_phone OR email = p_email;

    IF v_family_id IS NOT NULL AND v_user_id IS NOT NULL THEN
        BEGIN
            INSERT INTO member_family (id_user, id_family, created_at, updated_at, role)
            VALUES (v_user_id, v_family_id, NOW(), NOW(), p_role);
        
            UPDATE Users SET id_family = v_family_id WHERE id_user = v_user_id;
            result_message := 'Successfully added a member to the ' || v_name_family || ' family';
        EXCEPTION
            WHEN others THEN
                result_message := 'Failed to add member';
        END;
    ELSE
        result_message :=  'Invalid family ID or user ID provided';
    END IF;

    RETURN result_message;
END;
$$;
 t   DROP FUNCTION public.f_add_member(p_id uuid, p_phone character varying, p_email character varying, p_role integer);
       public          postgres    false            �           1255    17388 T   f_add_member(uuid, integer, character varying, character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.f_add_member(p_id_user uuid, p_id_family integer, p_phone character varying, p_email character varying, p_role character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_user_id UUID;
    recordCount int;
    result_message varchar;
    isMember int; 
BEGIN 
    -- Check if the user is already a member of the family
    SELECT COUNT(*) INTO recordCount FROM member_family WHERE id_user = p_id_user AND id_family = p_id_family;

    -- Find the user's ID based on phone or email
    SELECT id_user INTO v_user_id FROM Users WHERE phone = p_phone OR email = p_email;
   
    SELECT COUNT(*) INTO isMember FROM member_family WHERE id_user = v_user_id AND id_family = p_id_family;

    -- If the user exists and is not already a member, insert into member_family
    IF v_user_id IS NOT NULL AND recordCount != 0 and isMember = 0 THEN
        BEGIN
            INSERT INTO member_family (id_user, id_family, created_at, updated_at, role)
            VALUES (v_user_id, p_id_family, NOW(), NOW(), null);
           
            result_message := 'Successfully added a member to the family';
        EXCEPTION
            WHEN others THEN
                result_message := 'Failed to add member';
        END;
    ELSE
        result_message := 'Invalid user provided or user already a member of the family';
    END IF;

    RETURN result_message;
END;
$$;
 �   DROP FUNCTION public.f_add_member(p_id_user uuid, p_id_family integer, p_phone character varying, p_email character varying, p_role character varying);
       public          postgres    false            �           1255    17389    f_change_firstname(uuid, text)    FUNCTION     �  CREATE FUNCTION public.f_change_firstname(user_id uuid, new_firstname text) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM users WHERE id_user = user_id) THEN
        UPDATE users SET firstname = new_firstname WHERE id_user = user_id;
		RAISE NOTICE 'Updated successfully.';
    ELSE
        RAISE EXCEPTION 'User does not exist';
    END IF;
END;
$$;
 K   DROP FUNCTION public.f_change_firstname(user_id uuid, new_firstname text);
       public          postgres    false            �           1255    17390 -   f_change_firstname_lastname(uuid, text, text)    FUNCTION     �  CREATE FUNCTION public.f_change_firstname_lastname(user_id uuid, new_firstname text, new_lastname text) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Kiểm tra xem người dùng có tồn tại không
    IF EXISTS (SELECT 1 FROM users WHERE id_user = user_id) THEN
        -- Cập nhật firstname và lastname nếu người dùng tồn tại
        UPDATE users
        SET firstname = new_firstname, lastname = new_lastname
        WHERE id_user = user_id;
		RAISE NOTICE 'Updated successfully.';
    ELSE
        -- Nếu người dùng không tồn tại, hiển thị thông báo lỗi
        RAISE EXCEPTION 'User does not exist';
    END IF;
END;
$$;
 g   DROP FUNCTION public.f_change_firstname_lastname(user_id uuid, new_firstname text, new_lastname text);
       public          postgres    false            �           1255    17391    f_change_lastname(uuid, text)    FUNCTION     �  CREATE FUNCTION public.f_change_lastname(user_id uuid, new_lastname text) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM users WHERE id_user = user_id) THEN
        UPDATE users SET lastname = new_lastname WHERE id_user = user_id;
		RAISE NOTICE 'Updated successfully.';
    ELSE
        RAISE EXCEPTION 'User does not exist';
    END IF;
END;
$$;
 I   DROP FUNCTION public.f_change_lastname(user_id uuid, new_lastname text);
       public          postgres    false            �           1255    17392    f_change_password(uuid, text)    FUNCTION     �  CREATE FUNCTION public.f_change_password(p_user_id uuid, p_new_password text) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM users WHERE id_user = p_user_id) THEN
        RETURN 'User does not exist.';
    END IF;
    
    UPDATE users SET password = p_new_password WHERE id_user = p_user_id;
    
    RETURN 'Password changed successfully.';
EXCEPTION WHEN OTHERS THEN
    RETURN SQLERRM;
END;
$$;
 M   DROP FUNCTION public.f_change_password(p_user_id uuid, p_new_password text);
       public          postgres    false            �           1255    17393 G   f_change_status(text, integer, integer, integer, public.subject_status)    FUNCTION     |  CREATE FUNCTION public.f_change_status(p_id_user text, p_id_subject integer, p_id_education_progress integer, p_id_family integer, p_status public.subject_status) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_result TEXT;
BEGIN
    -- Kiểm tra xem người dùng có trong gia đình và môn học cụ thể không
    IF NOT EXISTS (
        SELECT 1 FROM member_family
        WHERE id_user = p_id_user::UUID AND id_family = p_id_family
    ) THEN
        RETURN 'User ID or Family ID not found in member_family.';
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM subjects
        WHERE id_subject = p_id_subject AND id_education_progress = p_id_education_progress
    ) THEN
        RETURN 'Subject ID with Education Progress ID not found.';
    END IF;

    -- Cập nhật status cho môn học cụ thể
    UPDATE subjects
    SET status = p_status
    WHERE id_subject = p_id_subject AND id_education_progress = p_id_education_progress AND EXISTS (
          SELECT 1 FROM member_family
          WHERE id_user = p_id_user::UUID AND id_family = p_id_family
      );

    -- Kiểm tra xem có hàng nào được cập nhật không
    IF FOUND THEN
        v_result := 'Status updated successfully for subject ID ' || p_id_subject || '.';
    ELSE
        v_result := 'No update performed.';
    END IF;

    RETURN v_result;
END;
$$;
 �   DROP FUNCTION public.f_change_status(p_id_user text, p_id_subject integer, p_id_education_progress integer, p_id_family integer, p_status public.subject_status);
       public          postgres    false    1261            �           1255    17394 K   f_check_order(uuid, integer, integer, character varying, character varying)    FUNCTION     n  CREATE FUNCTION public.f_check_order(p_id_user uuid, p_id_order integer, p_amount integer, p_responsecode character varying, p_transactionstatus character varying) RETURNS json
    LANGUAGE plpgsql
    AS $$
DECLARE 
    returnData JSON;
    valid_user int;
    valid_package int;
    valid_order int;
    status_payment varchar;
   	p_id_family int; 
    p_expired int;
BEGIN 
    SELECT id_package, status, id_family INTO valid_order, status_payment, p_id_family FROM "order" WHERE id_order = p_id_order and id_user=p_id_user; 
    SELECT expired INTO p_expired FROM package WHERE id_package = valid_order AND price = p_amount / 100;

    IF status_payment = 'Pending' THEN
        IF p_expired is not null THEN
                IF valid_order > 0 THEN 
                    IF p_ResponseCode = '00' THEN
                        UPDATE "order" SET status = 'Succeeded' WHERE id_order = p_id_order;
                        returnData := json_build_object('RspCode', '00', 'Message', 'Success');

                        if p_id_family is not null then 
                        	update family set expired_at = now() + INTERVAL '1 month' * p_expired where id_family = p_id_family;
                        end if;
                        
                    ELSE 
                        UPDATE "order" SET status = 'Failed' WHERE id_order = p_id_order;
                        returnData := json_build_object('RspCode', '00', 'Message', 'Success');
                    END IF;
                ELSE
                    UPDATE "order" SET status = 'Failed' WHERE id_order = p_id_order;
                    returnData := json_build_object('RspCode', '01', 'Message', 'Order not found');
                END IF;
            ELSE 
                UPDATE "order" SET status = 'Failed' WHERE id_order = p_id_order;
                returnData := json_build_object('RspCode', '97', 'Message', 'Checksum failed');
            END IF;
        ELSE
            returnData := json_build_object('RspCode', '02', 'Message', 'This order has been updated to the payment status');
        END IF;
    

    RETURN returnData;
END;
$$;
 �   DROP FUNCTION public.f_check_order(p_id_user uuid, p_id_order integer, p_amount integer, p_responsecode character varying, p_transactionstatus character varying);
       public          postgres    false            �           1255    17395     f_check_otp_by_email(text, text)    FUNCTION     %  CREATE FUNCTION public.f_check_otp_by_email(p_email text, p_otp_code text) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
declare
	v_user_id uuid;
    v_valid_otp BOOLEAN;
begin 
	SELECT u.id_user INTO v_user_id
    FROM users u
    JOIN otp o ON u.id_user = o.id_user
    WHERE u.email = p_email
    AND o.code = p_otp_code
    AND o.otp_type = 'forgot password'
    AND o.expired_at >= CURRENT_TIMESTAMP;

	IF v_user_id IS NOT NULL THEN
        v_valid_otp := TRUE;
    ELSE
        v_valid_otp := FALSE;
    END IF;
	RETURN v_valid_otp;
END;
$$;
 J   DROP FUNCTION public.f_check_otp_by_email(p_email text, p_otp_code text);
       public          postgres    false            �           1255    17396     f_check_otp_by_phone(text, text)    FUNCTION     %  CREATE FUNCTION public.f_check_otp_by_phone(p_phone text, p_otp_code text) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
declare
	v_user_id uuid;
    v_valid_otp BOOLEAN;
begin 
	SELECT u.id_user INTO v_user_id
    FROM users u
    JOIN otp o ON u.id_user = o.id_user
    WHERE u.phone = p_phone
    AND o.code = p_otp_code
    AND o.otp_type = 'forgot password'
    AND o.expired_at >= CURRENT_TIMESTAMP;

	IF v_user_id IS NOT NULL THEN
        v_valid_otp := TRUE;
    ELSE
        v_valid_otp := FALSE;
    END IF;
	RETURN v_valid_otp;
END;
$$;
 J   DROP FUNCTION public.f_check_otp_by_phone(p_phone text, p_otp_code text);
       public          postgres    false            �           1255    17397    f_cleanup_expired_otps()    FUNCTION     �   CREATE FUNCTION public.f_cleanup_expired_otps() RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Xóa các bản ghi trong bảng otp có expired_at < ngày hiện tại
    DELETE FROM otp
    WHERE expired_at < CURRENT_TIMESTAMP;
END;
$$;
 /   DROP FUNCTION public.f_cleanup_expired_otps();
       public          postgres    false            �           1255    17398 �   f_create_calendar_event(uuid, integer, character varying, character varying, timestamp without time zone, timestamp without time zone, text, boolean, integer, text, text, integer, text, text, text)    FUNCTION     #  CREATE FUNCTION public.f_create_calendar_event(p_id_user uuid, p_id_family integer, p_title character varying, p_description character varying, p_time_start timestamp without time zone, p_time_end timestamp without time zone, p_color text, p_is_all_day boolean, p_category integer, p_location text, p_recurrence_exception text, p_recurrence_id integer, p_recurrence_rule text, p_start_timezone text, p_end_timezone text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_id_calendar integer;
BEGIN
    INSERT INTO calendar (
        time_start,
        time_end,
        is_all_day,
        id_family,
        created_at,
        updated_at,
        description,
        color,
        title,
        category,
        location,
        recurrence_exception,
        recurrence_id,
        recurrence_rule,
        start_timezone,
        end_timezone
    )
    VALUES (
        p_time_start,
        p_time_end,
        p_is_all_day,
        p_id_family,
        NOW(),
        NOW(),
        p_description,
        p_color,
        p_title,
        p_category,
        p_location,
        p_recurrence_exception,
        p_recurrence_id,
        p_recurrence_rule,
        p_start_timezone,
        p_end_timezone
    )
    RETURNING id_calendar INTO v_id_calendar;

    RETURN v_id_calendar;
END;
$$;
 �  DROP FUNCTION public.f_create_calendar_event(p_id_user uuid, p_id_family integer, p_title character varying, p_description character varying, p_time_start timestamp without time zone, p_time_end timestamp without time zone, p_color text, p_is_all_day boolean, p_category integer, p_location text, p_recurrence_exception text, p_recurrence_id integer, p_recurrence_rule text, p_start_timezone text, p_end_timezone text);
       public          postgres    false            �           1255    17399 B   f_create_education_progress(text, integer, text, text, text, text)    FUNCTION     �  CREATE FUNCTION public.f_create_education_progress(p_owner_id_user text, p_id_family integer, p_id_user text, p_title text, p_progress_notes text, p_school_info text) RETURNS TABLE(message text, result_id_education_progress integer)
    LANGUAGE plpgsql
    AS $$
DECLARE
    l_message TEXT;
    l_id_education_progress INT;
begin
	IF NOT EXISTS (
        SELECT 1 FROM member_family WHERE id_user = p_id_user::uuid AND id_family = p_id_family
    ) THEN
        RETURN QUERY SELECT 'User you typed does not belong to the family', NULL;
    END IF;
	
	insert into education_progress(id_family, id_user, title, progress_notes, school_info)
	values (p_id_family, p_id_user::uuid, p_title, p_progress_notes, p_school_info)
	RETURNING 'Success' AS message, id_education_progress INTO l_message, l_id_education_progress;

	RETURN QUERY SELECT l_message AS message, l_id_education_progress AS result_id_education_progress;
END;
$$;
 �   DROP FUNCTION public.f_create_education_progress(p_owner_id_user text, p_id_family integer, p_id_user text, p_title text, p_progress_notes text, p_school_info text);
       public          postgres    false            �           1255    17400 G   f_create_expenditure(text, integer, text, integer, numeric, date, text)    FUNCTION     �  CREATE FUNCTION public.f_create_expenditure(p_id_user text, p_id_family integer, p_id_created_by text, p_id_expense_type integer, p_amount numeric, p_expenditure_date date, p_description text) RETURNS TABLE(id_expenditure integer, id_family integer, id_created_by uuid, id_expense_type integer, amount numeric, expenditure_date date, description text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    INSERT INTO finance_expenditure (id_family, id_created_by, id_expense_type, amount, expenditure_date, description)
    VALUES (p_id_family, p_id_created_by::uuid, p_id_expense_type, p_amount, p_expenditure_date, p_description)
    RETURNING 
	finance_expenditure.id_expenditure,
	finance_expenditure.id_family, 
	finance_expenditure.id_created_by, 
	finance_expenditure.id_expense_type, 
	finance_expenditure.amount, 
	finance_expenditure.expenditure_date, 
	finance_expenditure.description;

EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END;
$$;
 �   DROP FUNCTION public.f_create_expenditure(p_id_user text, p_id_family integer, p_id_created_by text, p_id_expense_type integer, p_amount numeric, p_expenditure_date date, p_description text);
       public          postgres    false            �           1255    17401 ?   f_create_expenditure_category(uuid, integer, character varying)    FUNCTION     �  CREATE FUNCTION public.f_create_expenditure_category(p_id_user uuid, p_id_family integer, p_category character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_exists BOOLEAN;
    v_expenditure_details JSONB;
    v_max_id INTEGER;
BEGIN
    -- Truy vấn expenditure_details từ bảng finance_expenditure_type
    SELECT expenditure_details INTO v_expenditure_details
    FROM finance_expenditure_type
    WHERE id_family = p_id_family;

    -- Nếu không tìm thấy expenditure_details, tạo một đối tượng JSON mới
    IF v_expenditure_details IS NULL THEN
        v_expenditure_details := '[]';
    END IF;

    -- Tìm id_expense_type lớn nhất trong expenditure_details
    SELECT MAX((category->>'id_expense_type')::INTEGER) INTO v_max_id FROM jsonb_array_elements(v_expenditure_details) AS category;

    -- Nếu không tìm thấy id_expense_type, gán giá trị 0
    IF v_max_id IS NULL THEN
        v_max_id := 0;
    END IF;

    -- Thêm một loại chi tiêu mới vào JSON với id_expense_type lớn nhất + 1
    v_expenditure_details := v_expenditure_details || jsonb_build_array(jsonb_build_object('category', p_category, 'id_expense_type', v_max_id + 1));

    -- Cập nhật lại expenditure_details trong bảng finance_expenditure_type
    UPDATE finance_expenditure_type
    SET expenditure_details = v_expenditure_details
    WHERE id_family = p_id_family;
END;
$$;
 w   DROP FUNCTION public.f_create_expenditure_category(p_id_user uuid, p_id_family integer, p_category character varying);
       public          postgres    false            �           1255    17402 ;   f_create_expenditure_type(uuid, integer, character varying)    FUNCTION     �  CREATE FUNCTION public.f_create_expenditure_type(p_id_user uuid, p_id_family integer, p_name character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_exists BOOLEAN;
    v_new_id INTEGER;
BEGIN
    INSERT INTO finance_expenditure_type (id_family, expense_name)
    VALUES (p_id_family, p_name)
    RETURNING id_expense_type INTO v_new_id;

    RETURN v_new_id;
END;
$$;
 o   DROP FUNCTION public.f_create_expenditure_type(p_id_user uuid, p_id_family integer, p_name character varying);
       public          postgres    false            �           1255    17403 D   f_create_family(uuid, character varying, character varying, integer)    FUNCTION     �  CREATE FUNCTION public.f_create_family(p_id_user uuid, p_description character varying, p_name character varying, p_id_order integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
    new_id INT;
    result_message varchar;
    recordCount int;
    p_expired_at timestamp;
BEGIN
    SELECT expired_at INTO p_expired_at 
    FROM "order" 
    WHERE id_user = p_id_user AND id_order = p_id_order AND status ='Succeeded' AND id_family IS NULL; 
    
    IF p_expired_at > NOW() THEN
        SELECT COUNT(*) INTO recordCount FROM users WHERE id_user = p_id_user;
        
        IF recordCount > 0 THEN
            BEGIN
                INSERT INTO family (quantity, description, created_at, updated_at, "name", owner_id, expired_at)
                VALUES (0, p_description, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, p_name, p_id_user, p_expired_at)
                RETURNING id_family INTO new_id; 
            
                INSERT INTO member_family (id_user, id_family, created_at, updated_at, "role")
                VALUES (p_id_user, new_id, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'owner'); 
                
                UPDATE "order" SET id_family = new_id, updated_at = NOW() WHERE id_order = p_id_order;
                
                result_message := 'Successfully created family: ' || p_name;
            EXCEPTION
                WHEN others THEN
                    result_message := 'Failed to create family';
            END;
        ELSE
            result_message := 'Invalid user provided';
        END IF;
    ELSE 
        result_message := 'Invalid order';
    END IF;
    
    RETURN result_message;
END;
$$;
 �   DROP FUNCTION public.f_create_family(p_id_user uuid, p_description character varying, p_name character varying, p_id_order integer);
       public          postgres    false            �           1255    17404 @   f_create_finance_income_source(uuid, integer, character varying)    FUNCTION     �  CREATE FUNCTION public.f_create_finance_income_source(p_id_user uuid, p_id_family integer, p_category character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_exists BOOLEAN;
    v_income_details JSONB;
    v_max_id INTEGER;
BEGIN
    IF NOT v_exists THEN
        RAISE EXCEPTION 'User is not a member of the specified family.';
    END IF;

    -- Lấy thông tin về nguồn thu nhập hiện có
    SELECT income_details INTO v_income_details
    FROM finance_income_source
    WHERE id_family = p_id_family;

    -- Nếu không có nguồn thu nhập nào, khởi tạo nguồn thu nhập là một mảng JSON rỗng
    IF v_income_details IS NULL THEN
        v_income_details := '[]';
    END IF;

    -- Tìm id lớn nhất của nguồn thu nhập hiện có
    SELECT MAX((source->>'id_income_source')::INTEGER) INTO v_max_id FROM jsonb_array_elements(v_income_details) AS source;

    -- Nếu không có nguồn thu nhập nào, thiết lập id mới là 1
    IF v_max_id IS NULL THEN
        v_max_id := 0;
    END IF;

    -- Thêm nguồn thu nhập mới vào mảng JSON nguồn thu nhập
    v_income_details := v_income_details || jsonb_build_array(jsonb_build_object('id_income_source', v_max_id + 1, 'category', p_category));

    -- Cập nhật thông tin nguồn thu nhập vào bảng
    UPDATE finance_income_source
    SET income_details = v_income_details
    WHERE id_family = p_id_family;
END;
$$;
 x   DROP FUNCTION public.f_create_finance_income_source(p_id_user uuid, p_id_family integer, p_category character varying);
       public          postgres    false            �           1255    17405 T   f_create_guideline(character varying, integer, character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.f_create_guideline(p_id_user character varying, p_id_family integer, p_name character varying, p_description character varying) RETURNS TABLE(id_item integer, name character varying, created_at timestamp without time zone, updated_at timestamp without time zone, id_family integer, step json, is_shared boolean, description character varying)
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_exists BOOLEAN;
BEGIN
    SELECT EXISTS(
        SELECT 1 FROM member_family
        WHERE id_user = uuid(p_id_user) AND member_family.id_family = p_id_family
    ) INTO v_exists;
    
    IF v_exists THEN
        RETURN QUERY
        INSERT INTO guide_items(name, created_at, updated_at, id_family, step, is_shared, description)
        VALUES (p_name, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, p_id_family, null, false, p_description)
        RETURNING guide_items.id_item, guide_items.name, guide_items.created_at, guide_items.updated_at, guide_items.id_family, guide_items.step, guide_items.is_shared, guide_items.description;
    ELSE
        RAISE EXCEPTION 'User ID % or Family ID % not found in member_family.', p_id_user, p_id_family;
    END IF;
END;
$$;
 �   DROP FUNCTION public.f_create_guideline(p_id_user character varying, p_id_family integer, p_name character varying, p_description character varying);
       public          postgres    false            �           1255    17406 G   f_create_household_item(text, integer, text, text, integer, text, text)    FUNCTION     �  CREATE FUNCTION public.f_create_household_item(p_id_user text, p_id_family integer, p_item_name text, p_item_description text DEFAULT NULL::text, p_item_category integer DEFAULT NULL::integer, p_item_type text DEFAULT 'durable'::text, p_item_imageurl text DEFAULT NULL::text) RETURNS public.household_item_details
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_is_member BOOLEAN;
    v_household_item_id INT;
    v_result household_item_details;
BEGIN
    INSERT INTO household_items (id_family, id_category, item_name, item_description, item_imageurl)
    VALUES (p_id_family, p_item_category, p_item_name, p_item_description, p_item_imageUrl)
    RETURNING id_household_item INTO v_household_item_id;

    IF p_item_type = 'consumable' THEN
        INSERT INTO household_consumable_items (id_household_item, quantity, threshold)
        VALUES (v_household_item_id, 0, 0);
    ELSIF p_item_type = 'durable' THEN
        INSERT INTO household_durable_items (id_household_item, condition)
        VALUES (v_household_item_id, 'new');
    ELSE
        RAISE EXCEPTION 'Invalid item type. Must be "consumable" or "durable".';
    END IF;

    SELECT hi.id_household_item, hi.id_family, hi.id_category, hi.item_name,
           hi.item_description, hi.item_imageurl, hci.quantity, 
           hci.threshold, hdi.condition, hic.category_name
    INTO v_result
    FROM household_items hi
    LEFT JOIN household_consumable_items hci ON hi.id_household_item = hci.id_household_item
    LEFT JOIN household_durable_items hdi ON hi.id_household_item = hdi.id_household_item
    LEFT JOIN household_item_categories hic ON hi.id_category = hic.id_category
    WHERE hi.id_household_item = v_household_item_id;

    RETURN v_result;
END;
$$;
 �   DROP FUNCTION public.f_create_household_item(p_id_user text, p_id_family integer, p_item_name text, p_item_description text, p_item_category integer, p_item_type text, p_item_imageurl text);
       public          postgres    false    1231            �           1255    17407 P   f_create_household_item(text, integer, text, integer, text, integer, text, text)    FUNCTION     �  CREATE FUNCTION public.f_create_household_item(p_id_user text, p_id_family integer, p_item_name text, p_id_room integer, p_item_description text DEFAULT NULL::text, p_item_category integer DEFAULT NULL::integer, p_item_type text DEFAULT 'durable'::text, p_item_imageurl text DEFAULT NULL::text) RETURNS public.household_item_details
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_is_member BOOLEAN;
    v_household_item_id INT;
    v_result household_item_details;
BEGIN
	IF NOT EXISTS (
        SELECT 1 FROM room WHERE id_room = p_id_room AND id_family = p_id_family
    ) THEN
        RAISE EXCEPTION 'Room with given id_room and id_family does not exist.';
    END IF;

    INSERT INTO household_items (id_family, id_category, item_name, item_description, item_imageurl, id_room)
    VALUES (p_id_family, p_item_category, p_item_name, p_item_description, p_item_imageUrl, p_id_room)
    RETURNING id_household_item INTO v_household_item_id;

    IF p_item_type = 'consumable' THEN
        INSERT INTO household_consumable_items (id_household_item, quantity, threshold)
        VALUES (v_household_item_id, 0, 0);
    ELSIF p_item_type = 'durable' THEN
        INSERT INTO household_durable_items (id_household_item, condition)
        VALUES (v_household_item_id, 'new');
    ELSE
        RAISE EXCEPTION 'Invalid item type. Must be "consumable" or "durable".';
    END IF;

    SELECT hi.id_household_item, hi.id_family, hi.id_category, hi.item_name,
           hi.item_description, hi.item_imageurl, hci.quantity, 
           hci.threshold, hdi.condition, hic.category_name
    INTO v_result
    FROM household_items hi
    LEFT JOIN household_consumable_items hci ON hi.id_household_item = hci.id_household_item
    LEFT JOIN household_durable_items hdi ON hi.id_household_item = hdi.id_household_item
    LEFT JOIN household_item_categories hic ON hi.id_category = hic.id_category
    WHERE hi.id_household_item = v_household_item_id;

    RETURN v_result;
END;
$$;
 �   DROP FUNCTION public.f_create_household_item(p_id_user text, p_id_family integer, p_item_name text, p_id_room integer, p_item_description text, p_item_category integer, p_item_type text, p_item_imageurl text);
       public          postgres    false    1231            �           1255    17408 B   f_create_income(text, integer, text, integer, numeric, date, text)    FUNCTION     �  CREATE FUNCTION public.f_create_income(p_id_user text, p_id_family integer, p_id_created_by text, p_id_income_source integer, p_amount numeric, p_income_date date, p_description text) RETURNS TABLE(id_income integer, id_family integer, id_created_by uuid, id_income_source integer, amount numeric, income_date date, description text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM member_family AS mf
        WHERE mf.id_family = p_id_family
        AND (
            mf.id_user = uuid(p_id_user)
            OR mf.id_user = uuid(p_id_created_by)
        )
        GROUP BY mf.id_family
        HAVING COUNT(DISTINCT mf.id_user) >= 1
    )
    THEN
        RETURN QUERY
        INSERT INTO finance_income (
            id_family,
            id_created_by,
            id_income_source,
            amount,
            income_date,
            description
        ) VALUES (
            p_id_family,
            uuid(p_id_created_by),
            p_id_income_source,
            p_amount,
            p_income_date,
            p_description
        )
        RETURNING finance_income.id_income, finance_income.id_family, finance_income.id_created_by, 
		finance_income.id_income_source, finance_income.amount, finance_income.income_date, finance_income.description;
    ELSE
        RAISE EXCEPTION 'User ID or Created By ID not part of the specified family.';
    END IF;
END;
$$;
 �   DROP FUNCTION public.f_create_income(p_id_user text, p_id_family integer, p_id_created_by text, p_id_income_source integer, p_amount numeric, p_income_date date, p_description text);
       public          postgres    false            �           1255    17409 Z   f_create_invoice(uuid, integer, integer, character varying, date, character varying, text)    FUNCTION     �  CREATE FUNCTION public.f_create_invoice(id_user_param uuid, id_family_param integer, id_invoice_type_param integer, invoice_name_param character varying, invoice_date_param date, description_param character varying, fileurl_param text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
  invoice_id integer;
BEGIN
  INSERT INTO invoice (
    id_family,
    id_invoice_type,
    invoice_name,
    invoice_date,
    description,
    imageurl,
	total_amount
  )
  VALUES (
    id_family_param,
    id_invoice_type_param,
    invoice_name_param,
    invoice_date_param,
    description_param,
    fileurl_param,
	0
  )
  RETURNING id_invoice INTO invoice_id;

  RETURN invoice_id;
END;
$$;
 �   DROP FUNCTION public.f_create_invoice(id_user_param uuid, id_family_param integer, id_invoice_type_param integer, invoice_name_param character varying, invoice_date_param date, description_param character varying, fileurl_param text);
       public          postgres    false            �           1255    17410 4   f_create_invoice_items(uuid, integer, integer, text)    FUNCTION     �  CREATE FUNCTION public.f_create_invoice_items(p_id_user uuid, p_id_family integer, p_id_invoice integer, p_items text) RETURNS TABLE(id_item integer, id_invoice integer, item_description character varying, item_name character varying, quantity integer, unit_price numeric, total_price numeric)
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
 v   DROP FUNCTION public.f_create_invoice_items(p_id_user uuid, p_id_family integer, p_id_invoice integer, p_items text);
       public          postgres    false            �           1255    17411 7   f_create_invoice_type(uuid, integer, character varying)    FUNCTION     �  CREATE FUNCTION public.f_create_invoice_type(p_id_user uuid, p_id_family integer, p_type_name character varying) RETURNS integer
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
 p   DROP FUNCTION public.f_create_invoice_type(p_id_user uuid, p_id_family integer, p_type_name character varying);
       public          postgres    false            �           1255    17412 B   f_create_order(uuid, integer, integer, character varying, integer)    FUNCTION     U  CREATE FUNCTION public.f_create_order(p_id_user uuid, p_id_package integer, p_amount integer, p_method character varying, p_id_family integer) RETURNS integer
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
 �   DROP FUNCTION public.f_create_order(p_id_user uuid, p_id_package integer, p_amount integer, p_method character varying, p_id_family integer);
       public          postgres    false            �           1255    17413 "   f_create_room(uuid, integer, text)    FUNCTION     u  CREATE FUNCTION public.f_create_room(p_id_user uuid, p_id_family integer, p_room_name text) RETURNS TABLE(id_room integer, room_name character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY INSERT INTO room (id_family, room_name) 
                     VALUES (p_id_family, p_room_name) 
                     RETURNING room.id_room, room.room_name;
END;
$$;
 [   DROP FUNCTION public.f_create_room(p_id_user uuid, p_id_family integer, p_room_name text);
       public          postgres    false            �           1255    17414 r   f_create_shopping_item(uuid, integer, text, integer, integer, integer, timestamp without time zone, numeric, text)    FUNCTION     �  CREATE FUNCTION public.f_create_shopping_item(p_id_user uuid, p_id_list integer, p_item_name text, p_quantity integer, p_id_item_type integer, p_priority_level integer, p_reminder_date timestamp without time zone, p_price numeric, p_description text) RETURNS TABLE(id_item integer, id_list integer, item_name character varying, quantity integer, is_purchased boolean, id_item_type integer, priority_level integer, reminder_date timestamp without time zone, price numeric, description character varying)
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
 �   DROP FUNCTION public.f_create_shopping_item(p_id_user uuid, p_id_list integer, p_item_name text, p_quantity integer, p_id_item_type integer, p_priority_level integer, p_reminder_date timestamp without time zone, p_price numeric, p_description text);
       public          postgres    false            �           1255    17415 1   f_create_shopping_list(uuid, integer, text, text)    FUNCTION     �  CREATE FUNCTION public.f_create_shopping_list(p_id_user uuid, p_id_family integer, p_title text, p_description text) RETURNS TABLE(id_list integer, id_family integer, title character varying, created_at timestamp with time zone, updated_at timestamp with time zone, status character varying, description character varying)
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
 t   DROP FUNCTION public.f_create_shopping_list(p_id_user uuid, p_id_family integer, p_title text, p_description text);
       public          postgres    false            �           1255    17416 4   f_create_subject(text, integer, integer, text, text)    FUNCTION     �  CREATE FUNCTION public.f_create_subject(p_id_user text, p_id_education_progress integer, p_id_family integer, p_subject_name text, p_description text) RETURNS TABLE(id_subject integer, subject_name character varying, description text, component_scores json, midterm_score double precision, final_score double precision, bonus_score double precision, status public.subject_status)
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
 �   DROP FUNCTION public.f_create_subject(p_id_user text, p_id_education_progress integer, p_id_family integer, p_subject_name text, p_description text);
       public          postgres    false    1261            �           1255    17417 7   f_create_user(text, text, text, text, text, text, date)    FUNCTION     �  CREATE FUNCTION public.f_create_user(p_email text, p_phone text, p_password text, p_firstname text, p_lastname text, p_genre text, p_birthdate date) RETURNS uuid
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
 �   DROP FUNCTION public.f_create_user(p_email text, p_phone text, p_password text, p_firstname text, p_lastname text, p_genre text, p_birthdate date);
       public          postgres    false            �           1255    17418 �   f_create_user(character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.f_create_user(p_gmail character varying, p_phone character varying, p_password character varying, p_firstname character varying, p_lastname character varying, p_language character varying, p_login_type character varying, p_avatar character varying) RETURNS uuid
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
   DROP FUNCTION public.f_create_user(p_gmail character varying, p_phone character varying, p_password character varying, p_firstname character varying, p_lastname character varying, p_language character varying, p_login_type character varying, p_avatar character varying);
       public          postgres    false            �           1255    17419 &   f_delete_asset(text, integer, integer)    FUNCTION     �  CREATE FUNCTION public.f_delete_asset(p_id_user text, p_id_family integer, p_id_asset integer) RETURNS text
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
 ^   DROP FUNCTION public.f_delete_asset(p_id_user text, p_id_family integer, p_id_asset integer);
       public          postgres    false            �           1255    17420 &   f_delete_calendar_event(uuid, integer)    FUNCTION     �   CREATE FUNCTION public.f_delete_calendar_event(p_id_user uuid, p_id_calendar integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM calendar
        WHERE id_calendar = p_id_calendar;
        RETURN TRUE;
END;
$$;
 U   DROP FUNCTION public.f_delete_calendar_event(p_id_user uuid, p_id_calendar integer);
       public          postgres    false            �           1255    17421 B   f_delete_component_score(text, integer, integer, integer, integer)    FUNCTION     o  CREATE FUNCTION public.f_delete_component_score(p_id_user text, p_id_subject integer, p_id_family integer, p_id_education_progress integer, p_index integer) RETURNS jsonb
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
 �   DROP FUNCTION public.f_delete_component_score(p_id_user text, p_id_subject integer, p_id_family integer, p_id_education_progress integer, p_index integer);
       public          postgres    false            �           1255    17422 3   f_delete_education_progress(text, integer, integer)    FUNCTION     6  CREATE FUNCTION public.f_delete_education_progress(p_id_user text, p_id_family integer, p_id_education_progress integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM education_progress
    WHERE id_education_progress = p_id_education_progress;

    RETURN 'Delete Successfully';

END;
$$;
 x   DROP FUNCTION public.f_delete_education_progress(p_id_user text, p_id_family integer, p_id_education_progress integer);
       public          postgres    false            �           1255    17423 ,   f_delete_expenditure(text, integer, integer)    FUNCTION     �  CREATE FUNCTION public.f_delete_expenditure(p_id_user text, p_id_family integer, p_id_expenditure integer) RETURNS boolean
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
 j   DROP FUNCTION public.f_delete_expenditure(p_id_user text, p_id_family integer, p_id_expenditure integer);
       public          postgres    false            �           1255    17424 1   f_delete_expenditure_type(uuid, integer, integer)    FUNCTION       CREATE FUNCTION public.f_delete_expenditure_type(p_id_user uuid, p_id_family integer, p_id_expenditure_type integer) RETURNS void
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
 t   DROP FUNCTION public.f_delete_expenditure_type(p_id_user uuid, p_id_family integer, p_id_expenditure_type integer);
       public          postgres    false            �           1255    17425    f_delete_family(uuid, integer)    FUNCTION     �  CREATE FUNCTION public.f_delete_family(p_id_user uuid, p_id_family integer) RETURNS character varying
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
 K   DROP FUNCTION public.f_delete_family(p_id_user uuid, p_id_family integer);
       public          postgres    false            �           1255    17426 6   f_delete_finance_income_source(uuid, integer, integer)    FUNCTION     �  CREATE FUNCTION public.f_delete_finance_income_source(p_id_user uuid, p_id_family integer, p_id_income_source integer) RETURNS void
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
 v   DROP FUNCTION public.f_delete_finance_income_source(p_id_user uuid, p_id_family integer, p_id_income_source integer);
       public          postgres    false            �           1255    17427 7   f_delete_guideline(character varying, integer, integer)    FUNCTION     �  CREATE FUNCTION public.f_delete_guideline(p_id_user character varying, p_id_family integer, p_id_guideline integer) RETURNS text
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
 s   DROP FUNCTION public.f_delete_guideline(p_id_user character varying, p_id_family integer, p_id_guideline integer);
       public          postgres    false            �           1255    17428 E   f_delete_guideline_step(character varying, integer, integer, integer)    FUNCTION     �  CREATE FUNCTION public.f_delete_guideline_step(p_id_user character varying, p_id_family integer, p_id_guideline integer, p_step_index integer) RETURNS text
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
 �   DROP FUNCTION public.f_delete_guideline_step(p_id_user character varying, p_id_family integer, p_id_guideline integer, p_step_index integer);
       public          postgres    false            �           1255    17429 /   f_delete_household_item(text, integer, integer)    FUNCTION     �  CREATE FUNCTION public.f_delete_household_item(p_id_user text, p_id_family integer, p_id_household_item integer) RETURNS text
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
 p   DROP FUNCTION public.f_delete_household_item(p_id_user text, p_id_family integer, p_id_household_item integer);
       public          postgres    false            �           1255    17430 '   f_delete_income(text, integer, integer)    FUNCTION     2  CREATE FUNCTION public.f_delete_income(p_id_user text, p_id_family integer, p_id_income integer) RETURNS boolean
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
 `   DROP FUNCTION public.f_delete_income(p_id_user text, p_id_family integer, p_id_income integer);
       public          postgres    false            �           1255    17431 (   f_delete_invoice(uuid, integer, integer)    FUNCTION     8  CREATE FUNCTION public.f_delete_invoice(id_user_param uuid, id_family_param integer, id_invoice_param integer) RETURNS text
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
 n   DROP FUNCTION public.f_delete_invoice(id_user_param uuid, id_family_param integer, id_invoice_param integer);
       public          postgres    false            �           1255    17432 6   f_delete_invoice_item(uuid, integer, integer, integer)    FUNCTION     �  CREATE FUNCTION public.f_delete_invoice_item(p_id_user uuid, p_id_family integer, p_id_invoice integer, p_id_item integer) RETURNS void
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
 z   DROP FUNCTION public.f_delete_invoice_item(p_id_user uuid, p_id_family integer, p_id_invoice integer, p_id_item integer);
       public          postgres    false            �           1255    17433 -   f_delete_invoice_type(uuid, integer, integer)    FUNCTION     �  CREATE FUNCTION public.f_delete_invoice_type(p_id_user uuid, p_id_family integer, p_id_invoice_type integer) RETURNS void
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
 l   DROP FUNCTION public.f_delete_invoice_type(p_id_user uuid, p_id_family integer, p_id_invoice_type integer);
       public          postgres    false            �           1255    17434 $   f_delete_member(uuid, uuid, integer)    FUNCTION     X  CREATE FUNCTION public.f_delete_member(p_id_current_user uuid, p_id_user uuid, p_id_family integer) RETURNS character varying
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
 c   DROP FUNCTION public.f_delete_member(p_id_current_user uuid, p_id_user uuid, p_id_family integer);
       public          postgres    false            �           1255    17435 (   f_delete_otp_by_email(character varying)    FUNCTION       CREATE FUNCTION public.f_delete_otp_by_email(p_email character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM otp
    WHERE id_user IN (SELECT id_user FROM users WHERE email = p_email and login_type = 'local')
    AND otp_type = 'forgot password';
END;
$$;
 G   DROP FUNCTION public.f_delete_otp_by_email(p_email character varying);
       public          postgres    false            �           1255    17436 (   f_delete_otp_by_phone(character varying)    FUNCTION       CREATE FUNCTION public.f_delete_otp_by_phone(p_phone character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM otp
    WHERE id_user IN (SELECT id_user FROM users WHERE phone = p_phone and login_type = 'local')
    AND otp_type = 'forgot password';
END;
$$;
 G   DROP FUNCTION public.f_delete_otp_by_phone(p_phone character varying);
       public          postgres    false            �           1255    17437 )   f_delete_refresh_token(character varying)    FUNCTION     �   CREATE FUNCTION public.f_delete_refresh_token(refresh_token_value character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM refresh_token WHERE refresh_token = refresh_token_value;
END;
$$;
 T   DROP FUNCTION public.f_delete_refresh_token(refresh_token_value character varying);
       public          postgres    false            �           1255    17438 %   f_delete_room(uuid, integer, integer)    FUNCTION     N  CREATE FUNCTION public.f_delete_room(p_id_user uuid, p_id_family integer, p_id_room integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM household_items WHERE id_room = p_id_room;
        
    DELETE FROM room WHERE id_room = p_id_room AND id_family = p_id_family;
	
	RETURN 'Delete room successfully';
END;
$$;
 \   DROP FUNCTION public.f_delete_room(p_id_user uuid, p_id_family integer, p_id_room integer);
       public          postgres    false            �           1255    17439 7   f_delete_shopping_item(uuid, integer, integer, integer)    FUNCTION     	  CREATE FUNCTION public.f_delete_shopping_item(p_id_user uuid, p_id_family integer, p_id_list integer, p_id_item integer) RETURNS text
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
 x   DROP FUNCTION public.f_delete_shopping_item(p_id_user uuid, p_id_family integer, p_id_list integer, p_id_item integer);
       public          postgres    false            �           1255    17440 .   f_delete_shopping_list(uuid, integer, integer)    FUNCTION     �  CREATE FUNCTION public.f_delete_shopping_list(p_id_user uuid, p_id_family integer, p_id_list integer) RETURNS text
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
 e   DROP FUNCTION public.f_delete_shopping_list(p_id_user uuid, p_id_family integer, p_id_list integer);
       public          postgres    false            �           1255    17441 1   f_delete_subject(text, integer, integer, integer)    FUNCTION       CREATE FUNCTION public.f_delete_subject(p_id_user text, p_id_family integer, p_id_education_progress integer, p_id_subject integer) RETURNS text
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
 �   DROP FUNCTION public.f_delete_subject(p_id_user text, p_id_family integer, p_id_education_progress integer, p_id_subject integer);
       public          postgres    false            �           1255    17442    f_find_user(uuid)    FUNCTION       CREATE FUNCTION public.f_find_user(p_id_user uuid) RETURNS text
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
 2   DROP FUNCTION public.f_find_user(p_id_user uuid);
       public          postgres    false            �           1255    17443 7   f_generate_invitation(uuid, integer, character varying)    FUNCTION     a  CREATE FUNCTION public.f_generate_invitation(p_id_user uuid, p_id_family integer, p_code character varying) RETURNS text
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
 k   DROP FUNCTION public.f_generate_invitation(p_id_user uuid, p_id_family integer, p_code character varying);
       public          postgres    false            �           1255    17444    f_generate_link_invite(integer)    FUNCTION     �  CREATE FUNCTION public.f_generate_link_invite(p_id_family integer) RETURNS character varying
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
 B   DROP FUNCTION public.f_generate_link_invite(p_id_family integer);
       public          postgres    false            �           1255    17445    f_generate_otp(uuid)    FUNCTION       CREATE FUNCTION public.f_generate_otp(owner_id uuid) RETURNS character varying
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
 4   DROP FUNCTION public.f_generate_otp(owner_id uuid);
       public          postgres    false            �           1255    17446 '   f_generate_otp(uuid, character varying)    FUNCTION     �  CREATE FUNCTION public.f_generate_otp(p_id_user uuid, p_email character varying) RETURNS character varying
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
 P   DROP FUNCTION public.f_generate_otp(p_id_user uuid, p_email character varying);
       public          postgres    false            �           1255    17447 4   f_generate_otp(character varying, character varying)    FUNCTION     5  CREATE FUNCTION public.f_generate_otp(p_id_user character varying, p_email character varying) RETURNS character varying
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
 ]   DROP FUNCTION public.f_generate_otp(p_id_user character varying, p_email character varying);
       public          postgres    false            �           1255    17448    f_generate_refresh_token(uuid)    FUNCTION     �  CREATE FUNCTION public.f_generate_refresh_token(id_user uuid) RETURNS character varying
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
 =   DROP FUNCTION public.f_generate_refresh_token(id_user uuid);
       public          postgres    false            �           1255    17449 1   f_generate_refresh_token(uuid, character varying)    FUNCTION     �  CREATE FUNCTION public.f_generate_refresh_token(id_user uuid, refresh_token character varying) RETURNS character varying
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
 ^   DROP FUNCTION public.f_generate_refresh_token(id_user uuid, refresh_token character varying);
       public          postgres    false            �           1255    17450    f_generate_unique_uuid()    FUNCTION     �  CREATE FUNCTION public.f_generate_unique_uuid() RETURNS uuid
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
 /   DROP FUNCTION public.f_generate_unique_uuid();
       public          postgres    false            �           1255    17451 =   f_get_all_education_progress(text, integer, integer, integer)    FUNCTION       CREATE FUNCTION public.f_get_all_education_progress(p_id_user text, p_skip_amount integer, p_items_per_page integer, p_id_family integer) RETURNS TABLE(id_education_progress integer, id_user uuid, title character varying, progress_notes text, school_info text, created_at timestamp without time zone, updated_at timestamp without time zone, avatar character varying, firstname character varying, lastname character varying)
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
 �   DROP FUNCTION public.f_get_all_education_progress(p_id_user text, p_skip_amount integer, p_items_per_page integer, p_id_family integer);
       public          postgres    false            �           1255    17452 /   f_get_all_invoice_items(uuid, integer, integer)    FUNCTION     T  CREATE FUNCTION public.f_get_all_invoice_items(p_id_user uuid, p_id_family integer, p_id_invoice integer) RETURNS TABLE(id_item integer, id_invoice integer, item_description character varying, item_name character varying, quantity integer, unit_price numeric, total_price numeric)
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
 i   DROP FUNCTION public.f_get_all_invoice_items(p_id_user uuid, p_id_family integer, p_id_invoice integer);
       public          postgres    false            �            1259    17453    member_family_id_seq    SEQUENCE     �   CREATE SEQUENCE public.member_family_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;
 +   DROP SEQUENCE public.member_family_id_seq;
       public          postgres    false            �            1259    17454    member_family    TABLE     �  CREATE TABLE public.member_family (
    id_user uuid NOT NULL,
    id_family integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    id integer DEFAULT nextval('public.member_family_id_seq'::regclass) NOT NULL,
    role public.member_family_role_enum DEFAULT 'Member'::public.member_family_role_enum,
    id_family_role integer DEFAULT 1 NOT NULL
);
 !   DROP TABLE public.member_family;
       public         heap    postgres    false    221    1240    1240            �            1259    17462    users    TABLE     ;  CREATE TABLE public.users (
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
    is_banned boolean DEFAULT false NOT NULL
);
    DROP TABLE public.users;
       public         heap    postgres    false    3    1267    1267            �            1259    17476    view_users_role    VIEW     $  CREATE VIEW public.view_users_role AS
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
 "   DROP VIEW public.view_users_role;
       public          postgres    false    222    223    223    223    223    223    223    223    222    222    1240            �           1255    17481    f_get_all_member(uuid, integer)    FUNCTION     9  CREATE FUNCTION public.f_get_all_member(p_id_user uuid, p_id_family integer) RETURNS SETOF public.view_users_role
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
 L   DROP FUNCTION public.f_get_all_member(p_id_user uuid, p_id_family integer);
       public          postgres    false    224            �            1259    17482    finance_assets    TABLE     �  CREATE TABLE public.finance_assets (
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
 "   DROP TABLE public.finance_assets;
       public         heap    postgres    false            �           1255    17491 ,   f_get_asset(text, integer, integer, integer)    FUNCTION     �  CREATE FUNCTION public.f_get_asset(p_id_user text, p_id_family integer, p_page integer DEFAULT 1, p_items_per_page integer DEFAULT 10) RETURNS SETOF public.finance_assets
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
 q   DROP FUNCTION public.f_get_asset(p_id_user text, p_id_family integer, p_page integer, p_items_per_page integer);
       public          postgres    false    225            �           1255    17492 $   f_get_calendar_detail(uuid, integer)    FUNCTION     `  CREATE FUNCTION public.f_get_calendar_detail(p_id_user uuid, p_id_calendar integer) RETURNS TABLE(id_calendar integer, title character varying, description character varying, time_start timestamp without time zone, time_end timestamp without time zone, color text, is_all_day boolean, category integer, location character varying, recurrence_exception character varying, recurrence_id integer, recurrence_rule character varying, start_timezone character varying, end_timezone character varying)
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
 S   DROP FUNCTION public.f_get_calendar_detail(p_id_user uuid, p_id_calendar integer);
       public          postgres    false            �           1255    17493 $   f_get_calendar_events(uuid, integer)    FUNCTION     �  CREATE FUNCTION public.f_get_calendar_events(p_id_user uuid, p_id_family integer) RETURNS TABLE(id_calendar integer, title character varying, description character varying, time_start timestamp without time zone, time_end timestamp without time zone, color text, is_all_day boolean, category integer, location character varying, recurrence_exception character varying, recurrence_id integer, recurrence_rule character varying, start_timezone character varying, end_timezone character varying, name_category character varying)
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
 Q   DROP FUNCTION public.f_get_calendar_events(p_id_user uuid, p_id_family integer);
       public          postgres    false            �           1255    17494 %   f_get_category_name(integer, integer)    FUNCTION     �  CREATE FUNCTION public.f_get_category_name(p_id_family integer, p_id_expense_type integer) RETURNS text
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
 Z   DROP FUNCTION public.f_get_category_name(p_id_family integer, p_id_expense_type integer);
       public          postgres    false            �           1255    17495 7   f_get_detail_education_progress(text, integer, integer)    FUNCTION     V  CREATE FUNCTION public.f_get_detail_education_progress(p_id_user text, p_id_family integer, p_id_education_progress integer) RETURNS TABLE(id_education_progress integer, education_progress_info json, subjects_info json)
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
 |   DROP FUNCTION public.f_get_detail_education_progress(p_id_user text, p_id_family integer, p_id_education_progress integer);
       public          postgres    false            �           1255    17496 5   f_get_detail_subject(text, integer, integer, integer)    FUNCTION     A  CREATE FUNCTION public.f_get_detail_subject(p_id_user text, p_id_family integer, p_id_education_progress integer, p_id_subject integer) RETURNS TABLE(id_subject integer, subject_name character varying, description text, component_scores json, midterm_score double precision, final_score double precision, bonus_score double precision, status public.subject_status)
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
 �   DROP FUNCTION public.f_get_detail_subject(p_id_user text, p_id_family integer, p_id_education_progress integer, p_id_subject integer);
       public          postgres    false    1261            �           1255    17497 `   f_get_events_for_family(uuid, integer, timestamp without time zone, timestamp without time zone)    FUNCTION       CREATE FUNCTION public.f_get_events_for_family(p_id_user uuid, p_id_family integer, p_date_start timestamp without time zone, p_date_end timestamp without time zone) RETURNS TABLE(id_calendar integer, title character varying, description character varying, time_start timestamp without time zone, time_end timestamp without time zone, color text, is_all_day boolean, category integer, location character varying, recurrence_exception character varying, recurrence_id integer, recurrence_rule character varying, start_timezone character varying, end_timezone character varying)
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
 �   DROP FUNCTION public.f_get_events_for_family(p_id_user uuid, p_id_family integer, p_date_start timestamp without time zone, p_date_end timestamp without time zone);
       public          postgres    false            �           1255    17498 2   f_get_expenditure(text, integer, integer, integer)    FUNCTION        CREATE FUNCTION public.f_get_expenditure(p_id_user text, p_id_family integer, p_page integer, p_items_per_page integer) RETURNS TABLE(id_expenditure integer, id_family integer, id_created_by uuid, expense_name character varying, amount numeric, expenditure_date date, description text)
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
 w   DROP FUNCTION public.f_get_expenditure(p_id_user text, p_id_family integer, p_page integer, p_items_per_page integer);
       public          postgres    false            �           1255    17499 /   f_get_expenditure_by_id(text, integer, integer)    FUNCTION     8  CREATE FUNCTION public.f_get_expenditure_by_id(p_id_user text, p_id_family integer, p_id_expenditure integer) RETURNS TABLE(id_expenditure integer, expense_name character varying, id_family integer, id_created_by uuid, id_expense_type integer, amount numeric, expenditure_date date, description text)
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
 m   DROP FUNCTION public.f_get_expenditure_by_id(p_id_user text, p_id_family integer, p_id_expenditure integer);
       public          postgres    false            �           1255    17500 7   f_get_expense_by_date(uuid, integer, character varying)    FUNCTION     �  CREATE FUNCTION public.f_get_expense_by_date(p_id_user uuid, p_id_family integer, p_expense_date character varying) RETURNS TABLE(id_expense_type integer, expense_category text, expense_amount numeric, description text, name text)
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
 s   DROP FUNCTION public.f_get_expense_by_date(p_id_user uuid, p_id_family integer, p_expense_date character varying);
       public          postgres    false            �           1255    17501 3   f_get_expense_by_date_range(uuid, integer, integer)    FUNCTION     �  CREATE FUNCTION public.f_get_expense_by_date_range(p_id_user uuid, p_id_family integer, p_days_range integer) RETURNS TABLE(id_expense_type integer, expense_category text, expense_amount numeric, description text, name text, expenditure_date date)
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
 m   DROP FUNCTION public.f_get_expense_by_date_range(p_id_user uuid, p_id_family integer, p_days_range integer);
       public          postgres    false            �           1255    17502 7   f_get_expense_by_month(uuid, integer, integer, integer)    FUNCTION       CREATE FUNCTION public.f_get_expense_by_month(p_id_user uuid, p_id_family integer, p_month integer, p_year integer) RETURNS jsonb
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
 s   DROP FUNCTION public.f_get_expense_by_month(p_id_user uuid, p_id_family integer, p_month integer, p_year integer);
       public          postgres    false            �           1255    17503 -   f_get_expense_by_year(uuid, integer, integer)    FUNCTION     �  CREATE FUNCTION public.f_get_expense_by_year(p_id_user uuid, p_id_family integer, p_year integer) RETURNS jsonb
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
 a   DROP FUNCTION public.f_get_expense_by_year(p_id_user uuid, p_id_family integer, p_year integer);
       public          postgres    false            �           1255    17504 H   f_get_expenses_with_pagination(uuid, integer, integer, integer, integer)    FUNCTION     w
  CREATE FUNCTION public.f_get_expenses_with_pagination(p_id_user uuid, p_id_family integer, p_days_range integer, p_page_number integer, p_items_per_page integer) RETURNS json
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
 �   DROP FUNCTION public.f_get_expenses_with_pagination(p_id_user uuid, p_id_family integer, p_days_range integer, p_page_number integer, p_items_per_page integer);
       public          postgres    false            �            1259    17505    family_id_family_seq    SEQUENCE     }   CREATE SEQUENCE public.family_id_family_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.family_id_family_seq;
       public          postgres    false            �            1259    17506    family    TABLE     %  CREATE TABLE public.family (
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
    DROP TABLE public.family;
       public         heap    postgres    false    226            �           1255    17517    f_get_family(uuid, integer)    FUNCTION        CREATE FUNCTION public.f_get_family(p_id_user uuid, p_id_family integer) RETURNS SETOF public.family
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
 H   DROP FUNCTION public.f_get_family(p_id_user uuid, p_id_family integer);
       public          postgres    false    227            �           1255    17518 -   f_get_finance_expenditure_type(uuid, integer)    FUNCTION     1  CREATE FUNCTION public.f_get_finance_expenditure_type(p_id_user uuid, p_id_family integer) RETURNS SETOF jsonb
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
 Z   DROP FUNCTION public.f_get_finance_expenditure_type(p_id_user uuid, p_id_family integer);
       public          postgres    false            �           1255    17519 *   f_get_finance_income_source(uuid, integer)    FUNCTION     &  CREATE FUNCTION public.f_get_finance_income_source(p_id_user uuid, p_id_family integer) RETURNS SETOF jsonb
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
 W   DROP FUNCTION public.f_get_finance_income_source(p_id_user uuid, p_id_family integer);
       public          postgres    false            �           1255    17520 $   f_get_finance_summary(text, integer)    FUNCTION     j  CREATE FUNCTION public.f_get_finance_summary(p_id_user text, p_id_family integer) RETURNS TABLE(id_summary integer, id_family integer, summary_date date, total_income numeric, total_expenditure numeric, daily_balance numeric, weekly_balance numeric, monthly_balance numeric, yearly_balance numeric, current_balance numeric)
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
 Q   DROP FUNCTION public.f_get_finance_summary(p_id_user text, p_id_family integer);
       public          postgres    false            �           1255    17521 4   f_get_guideline(character varying, integer, integer)    FUNCTION     �  CREATE FUNCTION public.f_get_guideline(p_id_user character varying, p_id_family integer, p_id_guideline integer) RETURNS TABLE(id_item integer, name character varying, description character varying, id_family integer, step json, is_shared boolean, created_at timestamp without time zone, updated_at timestamp without time zone)
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
 p   DROP FUNCTION public.f_get_guideline(p_id_user character varying, p_id_family integer, p_id_guideline integer);
       public          postgres    false            �           1255    17522 9   f_get_guideline_step(character varying, integer, integer)    FUNCTION     �  CREATE FUNCTION public.f_get_guideline_step(p_id_user character varying, p_id_family integer, p_id_guideline integer) RETURNS json
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
 u   DROP FUNCTION public.f_get_guideline_step(p_id_user character varying, p_id_family integer, p_id_guideline integer);
       public          postgres    false            �           1255    17523 1   f_get_guidelines(text, integer, integer, integer)    FUNCTION     �  CREATE FUNCTION public.f_get_guidelines(p_id_user text, p_id_family integer, p_page integer, p_limit integer) RETURNS json
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
 m   DROP FUNCTION public.f_get_guidelines(p_id_user text, p_id_family integer, p_page integer, p_limit integer);
       public          postgres    false                        1255    17524 >   f_get_guidelines(character varying, integer, integer, integer)    FUNCTION     �  CREATE FUNCTION public.f_get_guidelines(p_id_user character varying, p_id_family integer, p_page integer, p_limit integer) RETURNS TABLE(name character varying, description character varying, created_at timestamp without time zone, updated_at timestamp without time zone, total_items integer)
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
 z   DROP FUNCTION public.f_get_guidelines(p_id_user character varying, p_id_family integer, p_page integer, p_limit integer);
       public          postgres    false            �            1259    17525    household_items    TABLE     �  CREATE TABLE public.household_items (
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
 #   DROP TABLE public.household_items;
       public         heap    postgres    false                       1255    17532 5   f_get_household_item(text, integer, integer, integer)    FUNCTION     %  CREATE FUNCTION public.f_get_household_item(p_id_user text, p_id_family integer, p_page integer, p_items_per_page integer) RETURNS SETOF public.household_items
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
 z   DROP FUNCTION public.f_get_household_item(p_id_user text, p_id_family integer, p_page integer, p_items_per_page integer);
       public          postgres    false    228            �           1255    17533 3   f_get_household_item_detail(text, integer, integer)    FUNCTION       CREATE FUNCTION public.f_get_household_item_detail(p_id_user text, p_id_family integer, p_id_item integer) RETURNS SETOF public.household_item_detail
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
 j   DROP FUNCTION public.f_get_household_item_detail(p_id_user text, p_id_family integer, p_id_item integer);
       public          postgres    false    1228            �           1255    17534    f_get_ids_member(text, integer)    FUNCTION     �  CREATE FUNCTION public.f_get_ids_member(p_id_user text, p_id_family integer) RETURNS SETOF uuid
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
 L   DROP FUNCTION public.f_get_ids_member(p_id_user text, p_id_family integer);
       public          postgres    false                       1255    17535 -   f_get_income(text, integer, integer, integer)    FUNCTION     +  CREATE FUNCTION public.f_get_income(p_id_user text, p_id_family integer, p_page integer, p_items_per_page integer) RETURNS TABLE(id_income integer, id_family integer, id_created_by uuid, income_name character varying, amount numeric, income_date date, description text)
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
 r   DROP FUNCTION public.f_get_income(p_id_user text, p_id_family integer, p_page integer, p_items_per_page integer);
       public          postgres    false                       1255    17536 6   f_get_income_by_date(uuid, integer, character varying)    FUNCTION     �  CREATE FUNCTION public.f_get_income_by_date(p_id_user uuid, p_id_family integer, p_income_date character varying) RETURNS TABLE(id_income_source integer, income_category text, income_amount numeric, description text, name text)
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
 q   DROP FUNCTION public.f_get_income_by_date(p_id_user uuid, p_id_family integer, p_income_date character varying);
       public          postgres    false                       1255    17537 2   f_get_income_by_date_range(uuid, integer, integer)    FUNCTION     �  CREATE FUNCTION public.f_get_income_by_date_range(p_id_user uuid, p_id_family integer, p_days_range integer) RETURNS TABLE(id_income_source integer, income_category text, income_amount numeric, description text, name text, income_date date)
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
 l   DROP FUNCTION public.f_get_income_by_date_range(p_id_user uuid, p_id_family integer, p_days_range integer);
       public          postgres    false                       1255    17538 D   f_get_income_by_date_range(uuid, integer, integer, integer, integer)    FUNCTION       CREATE FUNCTION public.f_get_income_by_date_range(p_id_user uuid, p_id_family integer, p_days_range integer, p_page_number integer, p_items_per_page integer) RETURNS TABLE(id_income_source integer, income_category text, income_amount numeric, description text, name text, income_date date, total_pages integer)
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
 �   DROP FUNCTION public.f_get_income_by_date_range(p_id_user uuid, p_id_family integer, p_days_range integer, p_page_number integer, p_items_per_page integer);
       public          postgres    false                       1255    17539 *   f_get_income_by_id(text, integer, integer)    FUNCTION     /  CREATE FUNCTION public.f_get_income_by_id(p_id_user text, p_id_family integer, p_id_income integer) RETURNS TABLE(id_income integer, id_family integer, id_created_by uuid, id_income_source integer, amount numeric, income_date date, description text)
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
 c   DROP FUNCTION public.f_get_income_by_id(p_id_user text, p_id_family integer, p_id_income integer);
       public          postgres    false                       1255    17540 6   f_get_income_by_month(uuid, integer, integer, integer)    FUNCTION     �  CREATE FUNCTION public.f_get_income_by_month(p_id_user uuid, p_id_family integer, p_month integer, p_year integer) RETURNS jsonb
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
 r   DROP FUNCTION public.f_get_income_by_month(p_id_user uuid, p_id_family integer, p_month integer, p_year integer);
       public          postgres    false            	           1255    17541 ,   f_get_income_by_year(uuid, integer, integer)    FUNCTION        CREATE FUNCTION public.f_get_income_by_year(p_id_user uuid, p_id_family integer, p_year integer) RETURNS jsonb
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
 `   DROP FUNCTION public.f_get_income_by_year(p_id_user uuid, p_id_family integer, p_year integer);
       public          postgres    false            
           1255    17542 #   f_get_income_name(integer, integer)    FUNCTION     �  CREATE FUNCTION public.f_get_income_name(p_id_family integer, p_id_income_type integer) RETURNS text
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
 W   DROP FUNCTION public.f_get_income_name(p_id_family integer, p_id_income_type integer);
       public          postgres    false                       1255    17543 F   f_get_income_with_pagination(uuid, integer, integer, integer, integer)    FUNCTION     L  CREATE FUNCTION public.f_get_income_with_pagination(p_id_user uuid, p_id_family integer, p_days_range integer, p_page_number integer, p_items_per_page integer) RETURNS json
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
 �   DROP FUNCTION public.f_get_income_with_pagination(p_id_user uuid, p_id_family integer, p_days_range integer, p_page_number integer, p_items_per_page integer);
       public          postgres    false                       1255    17544 $   f_get_invitation_code(uuid, integer)    FUNCTION     �  CREATE FUNCTION public.f_get_invitation_code(p_id_user uuid, p_id_family integer) RETURNS TABLE(id_invitation integer, id_family integer, code character varying)
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
 Q   DROP FUNCTION public.f_get_invitation_code(p_id_user uuid, p_id_family integer);
       public          postgres    false                       1255    17545 ,   f_get_invoice_detail(uuid, integer, integer)    FUNCTION     �  CREATE FUNCTION public.f_get_invoice_detail(p_id_user uuid, p_id_family integer, p_id_invoice integer) RETURNS TABLE(id_invoice integer, id_family integer, id_invoice_type integer, id_invoice_type_name character varying, invoice_date date, invoice_name character varying, description character varying, imageurl text, tax_amount numeric, amount numeric, total_amount numeric, created_at timestamp with time zone, updated_at timestamp with time zone)
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
 f   DROP FUNCTION public.f_get_invoice_detail(p_id_user uuid, p_id_family integer, p_id_invoice integer);
       public          postgres    false                       1255    17546 :   f_get_invoice_item_detail(uuid, integer, integer, integer)    FUNCTION     "  CREATE FUNCTION public.f_get_invoice_item_detail(p_id_user uuid, p_id_family integer, p_id_invoice integer, p_id_invoice_item integer) RETURNS TABLE(id_item integer, id_invoice integer, item_description character varying, item_name character varying, quantity integer, unit_price numeric, total_price numeric)
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
 �   DROP FUNCTION public.f_get_invoice_item_detail(p_id_user uuid, p_id_family integer, p_id_invoice integer, p_id_invoice_item integer);
       public          postgres    false                       1255    17547 "   f_get_invoice_types(uuid, integer)    FUNCTION     K  CREATE FUNCTION public.f_get_invoice_types(p_id_user uuid, p_id_family integer) RETURNS TABLE(id_invoice_type integer, type_name character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY 
        SELECT it.id_invoice_type, it.type_name
        FROM invoice_type it
        WHERE it.id_family = p_id_family;
END;
$$;
 O   DROP FUNCTION public.f_get_invoice_types(p_id_user uuid, p_id_family integer);
       public          postgres    false                       1255    17548 /   f_get_invoices(uuid, integer, integer, integer)    FUNCTION     e  CREATE FUNCTION public.f_get_invoices(p_id_user uuid, p_id_family integer, p_page integer, p_items_per_page integer) RETURNS TABLE(id_invoice integer, id_family integer, id_invoice_type integer, id_invoice_type_name character varying, invoice_date date, invoice_name character varying, description character varying, imageurl text, tax_amount numeric, amount numeric, total_amount numeric, created_at timestamp with time zone, updated_at timestamp with time zone)
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
 t   DROP FUNCTION public.f_get_invoices(p_id_user uuid, p_id_family integer, p_page integer, p_items_per_page integer);
       public          postgres    false                       1255    17549    f_get_member(uuid)    FUNCTION     �   CREATE FUNCTION public.f_get_member(p_id_user uuid) RETURNS SETOF public.users
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY SELECT id_user, email, phone, language, firstname FROM users WHERE id_user = p_id_user;
END;
$$;
 3   DROP FUNCTION public.f_get_member(p_id_user uuid);
       public          postgres    false    223                       1255    17550    f_get_monthly_revenue()    FUNCTION     �  CREATE FUNCTION public.f_get_monthly_revenue() RETURNS TABLE(month date, monthly_revenue numeric)
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
 .   DROP FUNCTION public.f_get_monthly_revenue();
       public          postgres    false                       1255    17551     f_get_role_member(uuid, integer)    FUNCTION     �  CREATE FUNCTION public.f_get_role_member(p_id_user uuid, p_id_family integer) RETURNS character varying
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
 M   DROP FUNCTION public.f_get_role_member(p_id_user uuid, p_id_family integer);
       public          postgres    false                       1255    17552    f_get_rooms(uuid, integer)    FUNCTION     �  CREATE FUNCTION public.f_get_rooms(p_id_user uuid, p_id_family integer) RETURNS TABLE(id_room integer, room_name character varying)
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
 G   DROP FUNCTION public.f_get_rooms(p_id_user uuid, p_id_family integer);
       public          postgres    false                       1255    17553 4   f_get_shopping_item(uuid, integer, integer, integer)    FUNCTION       CREATE FUNCTION public.f_get_shopping_item(p_id_user uuid, p_id_list integer, p_page integer, p_items_per_page integer) RETURNS TABLE(id_item integer, id_list integer, item_name character varying, quantity integer, is_purchased boolean, priority_level integer, reminder_date timestamp without time zone, price numeric, description character varying, id_item_type integer)
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
 w   DROP FUNCTION public.f_get_shopping_item(p_id_user uuid, p_id_list integer, p_page integer, p_items_per_page integer);
       public          postgres    false                       1255    17554 4   f_get_shopping_list(uuid, integer, integer, integer)    FUNCTION     "  CREATE FUNCTION public.f_get_shopping_list(p_id_user uuid, p_id_family integer, p_page integer, p_itemsperpage integer) RETURNS TABLE(id_list integer, id_family integer, title character varying, created_at timestamp with time zone, updated_at timestamp with time zone, status character varying, description character varying)
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
 w   DROP FUNCTION public.f_get_shopping_list(p_id_user uuid, p_id_family integer, p_page integer, p_itemsperpage integer);
       public          postgres    false                       1255    17555 *   f_get_statiscal_expenditure(uuid, integer)    FUNCTION     >  CREATE FUNCTION public.f_get_statiscal_expenditure(p_id_user uuid, p_id_family integer) RETURNS TABLE(month_year text, total_expenditure numeric)
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
 W   DROP FUNCTION public.f_get_statiscal_expenditure(p_id_user uuid, p_id_family integer);
       public          postgres    false                       1255    17556 %   f_get_statiscal_income(uuid, integer)    FUNCTION       CREATE FUNCTION public.f_get_statiscal_income(p_id_user uuid, p_id_family integer) RETURNS TABLE(month_year text, total_income numeric)
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
 R   DROP FUNCTION public.f_get_statiscal_income(p_id_user uuid, p_id_family integer);
       public          postgres    false            �           1255    17557 /   f_get_step_image_url(integer, integer, integer)    FUNCTION     u  CREATE FUNCTION public.f_get_step_image_url(p_id_family integer, p_id_guideline integer, p_index integer) RETURNS text
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
 i   DROP FUNCTION public.f_get_step_image_url(p_id_family integer, p_id_guideline integer, p_index integer);
       public          postgres    false                       1255    17558    f_get_summary()    FUNCTION     B  CREATE FUNCTION public.f_get_summary() RETURNS TABLE(total_users integer, total_families integer, total_orders_succeeded integer, total_orders_pending integer, revenue_last_6_months numeric, total_revenue numeric)
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
 &   DROP FUNCTION public.f_get_summary();
       public          postgres    false                       1255    17559    f_get_users_info(text[])    FUNCTION     n  CREATE FUNCTION public.f_get_users_info(ids text[]) RETURNS TABLE(id_user uuid, firstname character varying, lastname character varying, avatar character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT u.id_user, u.firstname, u.lastname, u.avatar
    FROM users u
    WHERE u.id_user = ANY(ARRAY(SELECT UUID(unnest(ids))));
END;
$$;
 3   DROP FUNCTION public.f_get_users_info(ids text[]);
       public          postgres    false                       1255    17560    f_get_users_infos(uuid[])    FUNCTION     �  CREATE FUNCTION public.f_get_users_infos(userids uuid[]) RETURNS TABLE(id_user uuid, email character varying, phone character varying, language character varying, firstname character varying, lastname character varying, avatar character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT u.id_user, u.email, u.phone, u.language, u.firstname, u.lastname, u.avatar
    FROM users u
    WHERE u.id_user = ANY(userIds);
END;
$$;
 8   DROP FUNCTION public.f_get_users_infos(userids uuid[]);
       public          postgres    false                       1255    17561    f_getfamily(uuid, integer)    FUNCTION     �  CREATE FUNCTION public.f_getfamily(p_id_user uuid, p_id_family integer) RETURNS SETOF public.family
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
 G   DROP FUNCTION public.f_getfamily(p_id_user uuid, p_id_family integer);
       public          postgres    false    227                       1255    17562 '   f_handle_forgot_password_by_email(text)    FUNCTION     �  CREATE FUNCTION public.f_handle_forgot_password_by_email(p_email text) RETURNS text
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
 F   DROP FUNCTION public.f_handle_forgot_password_by_email(p_email text);
       public          postgres    false                       1255    17563 '   f_handle_forgot_password_by_phone(text)    FUNCTION     �  CREATE FUNCTION public.f_handle_forgot_password_by_phone(p_phone text) RETURNS text
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
 F   DROP FUNCTION public.f_handle_forgot_password_by_phone(p_phone text);
       public          postgres    false                        1255    17564 5   f_handle_invitation(uuid, integer, character varying)    FUNCTION     n  CREATE FUNCTION public.f_handle_invitation(p_id_user uuid, p_id_family integer, p_code character varying) RETURNS text
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
 i   DROP FUNCTION public.f_handle_invitation(p_id_user uuid, p_id_family integer, p_code character varying);
       public          postgres    false            !           1255    17565 Z   f_insert_component_score(text, integer, integer, integer, text, double precision, integer)    FUNCTION     �  CREATE FUNCTION public.f_insert_component_score(p_id_user text, p_id_subject integer, p_id_education_progress integer, p_id_family integer, p_component_name text, p_score double precision, p_index integer) RETURNS jsonb
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
 �   DROP FUNCTION public.f_insert_component_score(p_id_user text, p_id_subject integer, p_id_education_progress integer, p_id_family integer, p_component_name text, p_score double precision, p_index integer);
       public          postgres    false            #           1255    17566 q   f_insert_guideline_step(character varying, integer, integer, character varying, character varying, text, integer)    FUNCTION     �  CREATE FUNCTION public.f_insert_guideline_step(p_id_user character varying, p_id_family integer, p_id_guideline integer, p_name character varying, p_description character varying, p_fileurl text, p_index integer) RETURNS json
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
 �   DROP FUNCTION public.f_insert_guideline_step(p_id_user character varying, p_id_family integer, p_id_guideline integer, p_name character varying, p_description character varying, p_fileurl text, p_index integer);
       public          postgres    false            $           1255    17567 6   f_is_user_member_of_family(character varying, integer)    FUNCTION     �  CREATE FUNCTION public.f_is_user_member_of_family(p_id_user character varying, p_id_family integer) RETURNS boolean
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
 c   DROP FUNCTION public.f_is_user_member_of_family(p_id_user character varying, p_id_family integer);
       public          postgres    false            %           1255    17568 <   f_mark_shared_guideline(character varying, integer, integer)    FUNCTION     v  CREATE FUNCTION public.f_mark_shared_guideline(p_id_user character varying, p_id_family integer, p_id_guideline integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE guide_items
        SET is_shared = NOT is_shared
        WHERE id_family = p_id_family AND id_item = p_id_guideline;

        RETURN 'Guideline shared status successfully toggled.';
END;
$$;
 x   DROP FUNCTION public.f_mark_shared_guideline(p_id_user character varying, p_id_family integer, p_id_guideline integer);
       public          postgres    false            &           1255    17569 e   f_modify_score(text, integer, integer, integer, double precision, double precision, double precision)    FUNCTION       CREATE FUNCTION public.f_modify_score(p_id_user text, p_id_subject integer, p_id_education_progress integer, p_id_family integer, p_midterm_score double precision, p_final_score double precision, p_bonus_score double precision) RETURNS jsonb
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
 �   DROP FUNCTION public.f_modify_score(p_id_user text, p_id_subject integer, p_id_education_progress integer, p_id_family integer, p_midterm_score double precision, p_final_score double precision, p_bonus_score double precision);
       public          postgres    false            '           1255    17570 5   f_remove_score(text, integer, integer, integer, text)    FUNCTION     9  CREATE FUNCTION public.f_remove_score(p_id_user text, p_id_subject integer, p_id_education_progress integer, p_id_family integer, p_score_name text) RETURNS text
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
 �   DROP FUNCTION public.f_remove_score(p_id_user text, p_id_subject integer, p_id_education_progress integer, p_id_family integer, p_score_name text);
       public          postgres    false            (           1255    17571 %   f_reset_password_by_email(text, text)    FUNCTION     �  CREATE FUNCTION public.f_reset_password_by_email(p_email text, p_password text) RETURNS boolean
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
 O   DROP FUNCTION public.f_reset_password_by_email(p_email text, p_password text);
       public          postgres    false            )           1255    17572 %   f_reset_password_by_phone(text, text)    FUNCTION     �  CREATE FUNCTION public.f_reset_password_by_phone(p_phone text, p_password text) RETURNS boolean
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
 O   DROP FUNCTION public.f_reset_password_by_phone(p_phone text, p_password text);
       public          postgres    false            *           1255    17573 !   f_schedule_cleanup_expired_otps()    FUNCTION     ^  CREATE FUNCTION public.f_schedule_cleanup_expired_otps() RETURNS void
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
 8   DROP FUNCTION public.f_schedule_cleanup_expired_otps();
       public          postgres    false            +           1255    17574 N   f_update_asset(text, integer, integer, character varying, text, numeric, date)    FUNCTION     �  CREATE FUNCTION public.f_update_asset(p_id_user text, p_id_asset integer, p_id_family integer, p_name character varying, p_description text, p_value numeric, p_purchase_date date) RETURNS public.finance_assets
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
 �   DROP FUNCTION public.f_update_asset(p_id_user text, p_id_asset integer, p_id_family integer, p_name character varying, p_description text, p_value numeric, p_purchase_date date);
       public          postgres    false    225            ,           1255    17575 �   f_update_calendar_event(uuid, integer, character varying, character varying, timestamp without time zone, timestamp without time zone, text, boolean, integer, text, text, integer, text, text, text)    FUNCTION     	  CREATE FUNCTION public.f_update_calendar_event(p_id_user uuid, p_id_calendar integer, p_title character varying DEFAULT NULL::character varying, p_description character varying DEFAULT NULL::character varying, p_time_start timestamp without time zone DEFAULT NULL::timestamp without time zone, p_time_end timestamp without time zone DEFAULT NULL::timestamp without time zone, p_color text DEFAULT NULL::text, p_is_all_day boolean DEFAULT NULL::boolean, p_category integer DEFAULT NULL::integer, p_location text DEFAULT NULL::text, p_recurrence_exception text DEFAULT NULL::text, p_recurrence_id integer DEFAULT NULL::integer, p_recurrence_rule text DEFAULT NULL::text, p_start_timezone text DEFAULT NULL::text, p_end_timezone text DEFAULT NULL::text) RETURNS TABLE(id_calendar integer, title character varying, description character varying, time_start timestamp without time zone, time_end timestamp without time zone, color text, is_all_day boolean, category integer, location character varying, recurrence_exception character varying, recurrence_id integer, recurrence_rule character varying, start_timezone character varying, end_timezone character varying)
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
 �  DROP FUNCTION public.f_update_calendar_event(p_id_user uuid, p_id_calendar integer, p_title character varying, p_description character varying, p_time_start timestamp without time zone, p_time_end timestamp without time zone, p_color text, p_is_all_day boolean, p_category integer, p_location text, p_recurrence_exception text, p_recurrence_id integer, p_recurrence_rule text, p_start_timezone text, p_end_timezone text);
       public          postgres    false            -           1255    17576 Z   f_update_component_score(text, integer, integer, integer, text, double precision, integer)    FUNCTION     ;  CREATE FUNCTION public.f_update_component_score(p_id_user text, p_id_subject integer, p_id_education_progress integer, p_id_family integer, p_component_name text, p_score double precision, p_index integer) RETURNS jsonb
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
 �   DROP FUNCTION public.f_update_component_score(p_id_user text, p_id_subject integer, p_id_education_progress integer, p_id_family integer, p_component_name text, p_score double precision, p_index integer);
       public          postgres    false            .           1255    17577 e   f_update_education_progress(integer, integer, integer, integer, character varying, character varying)    FUNCTION     <  CREATE FUNCTION public.f_update_education_progress(p_id_user integer, p_id_subject integer, p_id_education_progress integer, p_id_family integer, p_subject_name character varying, p_description character varying) RETURNS TABLE(updated_subject_name character varying, updated_description character varying)
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
 �   DROP FUNCTION public.f_update_education_progress(p_id_user integer, p_id_subject integer, p_id_education_progress integer, p_id_family integer, p_subject_name character varying, p_description character varying);
       public          postgres    false            /           1255    17578 E   f_update_education_progress(text, integer, integer, text, text, text)    FUNCTION     3  CREATE FUNCTION public.f_update_education_progress(p_id_user text, p_id_education_progress integer, p_id_family integer, p_title text, p_progress_notes text, p_school_info text) RETURNS TABLE(id_education_progress integer, id_family integer, title text, progress_notes text, school_info text, created_at timestamp without time zone, updated_at timestamp without time zone)
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
 �   DROP FUNCTION public.f_update_education_progress(p_id_user text, p_id_education_progress integer, p_id_family integer, p_title text, p_progress_notes text, p_school_info text);
       public          postgres    false            0           1255    17579 G   f_update_expenditure(text, integer, text, integer, numeric, date, text)    FUNCTION     r  CREATE FUNCTION public.f_update_expenditure(p_id_user text, p_id_expenditure integer, p_id_created_by text, p_id_expense_type integer, p_amount numeric, p_expenditure_date date, p_description text) RETURNS TABLE(id_expenditure integer, id_created_by uuid, id_expense_type integer, amount numeric, expenditure_date date, description text)
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
 �   DROP FUNCTION public.f_update_expenditure(p_id_user text, p_id_expenditure integer, p_id_created_by text, p_id_expense_type integer, p_amount numeric, p_expenditure_date date, p_description text);
       public          postgres    false            1           1255    17580    f_update_expenditure_summary()    FUNCTION     a  CREATE FUNCTION public.f_update_expenditure_summary() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE financial_summary
    SET total_expenditure = total_expenditure + NEW.amount,
        current_balance = current_balance - NEW.amount
    WHERE id_family = NEW.id_family AND summary_date = NEW.expenditure_date;
    RETURN NEW;
END;
$$;
 5   DROP FUNCTION public.f_update_expenditure_summary();
       public          postgres    false            �           1255    17581 D   f_update_expenditure_type(uuid, integer, integer, character varying)    FUNCTION     �  CREATE FUNCTION public.f_update_expenditure_type(p_id_user uuid, p_id_expenditure_type integer, p_id_family integer, p_name character varying) RETURNS void
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
 �   DROP FUNCTION public.f_update_expenditure_type(p_id_user uuid, p_id_expenditure_type integer, p_id_family integer, p_name character varying);
       public          postgres    false            2           1255    17582 D   f_update_family(uuid, integer, character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.f_update_family(p_id_user uuid, p_id_family integer, p_name character varying, p_description character varying) RETURNS character varying
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
 �   DROP FUNCTION public.f_update_family(p_id_user uuid, p_id_family integer, p_name character varying, p_description character varying);
       public          postgres    false            3           1255    17583 I   f_update_finance_income_source(uuid, integer, integer, character varying)    FUNCTION        CREATE FUNCTION public.f_update_finance_income_source(p_id_user uuid, p_id_income integer, p_id_family integer, p_name character varying) RETURNS void
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
 �   DROP FUNCTION public.f_update_finance_income_source(p_id_user uuid, p_id_income integer, p_id_family integer, p_name character varying);
       public          postgres    false            4           1255    17584 ]   f_update_guideline(character varying, integer, integer, character varying, character varying)    FUNCTION     o  CREATE FUNCTION public.f_update_guideline(p_id_user character varying, p_id_family integer, p_id_item integer, p_name character varying, p_description character varying) RETURNS text
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
 �   DROP FUNCTION public.f_update_guideline(p_id_user character varying, p_id_family integer, p_id_item integer, p_name character varying, p_description character varying);
       public          postgres    false            5           1255    17585 q   f_update_guideline_step(character varying, integer, integer, integer, character varying, character varying, text)    FUNCTION     �  CREATE FUNCTION public.f_update_guideline_step(p_id_user character varying, p_id_family integer, p_id_guideline integer, p_index integer, p_name character varying, p_description character varying, p_fileurl text) RETURNS jsonb
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
 �   DROP FUNCTION public.f_update_guideline_step(p_id_user character varying, p_id_family integer, p_id_guideline integer, p_index integer, p_name character varying, p_description character varying, p_fileurl text);
       public          postgres    false            6           1255    17586 R   f_update_household_consumable_item(text, integer, integer, integer, integer, date)    FUNCTION     {  CREATE FUNCTION public.f_update_household_consumable_item(p_id_user text, p_id_family integer, p_id_item integer, p_quantity integer, p_threshold integer, p_expired_date date) RETURNS text
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
 �   DROP FUNCTION public.f_update_household_consumable_item(p_id_user text, p_id_family integer, p_id_item integer, p_quantity integer, p_threshold integer, p_expired_date date);
       public          postgres    false            7           1255    17587 =   f_update_household_durable_item(text, integer, integer, text)    FUNCTION     �  CREATE FUNCTION public.f_update_household_durable_item(p_id_user text, p_id_family integer, p_id_item integer, p_condition text) RETURNS text
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
 �   DROP FUNCTION public.f_update_household_durable_item(p_id_user text, p_id_family integer, p_id_item integer, p_condition text);
       public          postgres    false            8           1255    17588 J   f_update_household_item(text, integer, integer, text, text, integer, text)    FUNCTION     �  CREATE FUNCTION public.f_update_household_item(p_id_user text, p_id_family integer, p_id_item integer, p_item_name text DEFAULT NULL::text, p_item_description text DEFAULT NULL::text, p_id_category integer DEFAULT NULL::integer, p_item_imageurl text DEFAULT NULL::text) RETURNS public.household_item_update
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
 �   DROP FUNCTION public.f_update_household_item(p_id_user text, p_id_family integer, p_id_item integer, p_item_name text, p_item_description text, p_id_category integer, p_item_imageurl text);
       public          postgres    false    1237            :           1255    17589 S   f_update_household_item(text, integer, integer, integer, text, text, integer, text)    FUNCTION     1  CREATE FUNCTION public.f_update_household_item(p_id_user text, p_id_family integer, p_id_item integer, p_id_room integer, p_item_name text DEFAULT NULL::text, p_item_description text DEFAULT NULL::text, p_id_category integer DEFAULT NULL::integer, p_item_imageurl text DEFAULT NULL::text) RETURNS public.household_item_update
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
 �   DROP FUNCTION public.f_update_household_item(p_id_user text, p_id_family integer, p_id_item integer, p_id_room integer, p_item_name text, p_item_description text, p_id_category integer, p_item_imageurl text);
       public          postgres    false    1237            ;           1255    17590 B   f_update_income(text, integer, uuid, integer, numeric, date, text)    FUNCTION       CREATE FUNCTION public.f_update_income(p_id_user text, p_id_income integer, p_id_created_by uuid, p_id_income_source integer, p_amount numeric, p_income_date date, p_description text) RETURNS TABLE(id_income integer, id_income_source integer, amount numeric, income_date date, description text)
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
 �   DROP FUNCTION public.f_update_income(p_id_user text, p_id_income integer, p_id_created_by uuid, p_id_income_source integer, p_amount numeric, p_income_date date, p_description text);
       public          postgres    false            <           1255    17591    f_update_income_summary()    FUNCTION     M  CREATE FUNCTION public.f_update_income_summary() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE financial_summary
    SET total_income = total_income + NEW.amount,
        current_balance = current_balance + NEW.amount
    WHERE id_family = NEW.id_family AND summary_date = NEW.income_date;
    RETURN NEW;
END;
$$;
 0   DROP FUNCTION public.f_update_income_summary();
       public          postgres    false            =           1255    17592 c   f_update_invoice(uuid, integer, integer, integer, character varying, date, character varying, text)    FUNCTION     �  CREATE FUNCTION public.f_update_invoice(id_user_param uuid, id_invoice_param integer, id_family_param integer, id_invoice_type_param integer, invoice_name_param character varying, invoice_date_param date, description_param character varying, fileurl_param text) RETURNS TABLE(id_invoice integer, id_family integer, id_invoice_type integer, invoice_date date, total_amount numeric, description character varying, imageurl text, created_at timestamp with time zone, updated_at timestamp with time zone, invoice_name character varying, old_imageurl text)
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
   DROP FUNCTION public.f_update_invoice(id_user_param uuid, id_invoice_param integer, id_family_param integer, id_invoice_type_param integer, invoice_name_param character varying, invoice_date_param date, description_param character varying, fileurl_param text);
       public          postgres    false            >           1255    17593 o   f_update_invoice_items(uuid, integer, integer, integer, character varying, character varying, integer, numeric)    FUNCTION     N  CREATE FUNCTION public.f_update_invoice_items(p_id_user uuid, p_id_family integer, p_id_invoice integer, p_id_item integer, p_item_name character varying, p_item_description character varying, p_quantity integer, p_unit_price numeric) RETURNS TABLE(id_item integer, id_invoice integer, item_description character varying, item_name character varying, quantity integer, unit_price numeric, total_price numeric)
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
 �   DROP FUNCTION public.f_update_invoice_items(p_id_user uuid, p_id_family integer, p_id_invoice integer, p_id_item integer, p_item_name character varying, p_item_description character varying, p_quantity integer, p_unit_price numeric);
       public          postgres    false            ?           1255    17594 @   f_update_invoice_type(uuid, integer, integer, character varying)    FUNCTION       CREATE FUNCTION public.f_update_invoice_type(p_id_user uuid, p_id_family integer, p_id_invoice_type integer, p_type_name character varying) RETURNS void
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
 �   DROP FUNCTION public.f_update_invoice_type(p_id_user uuid, p_id_family integer, p_id_invoice_type integer, p_type_name character varying);
       public          postgres    false            �           1255    17595 8   f_update_room(uuid, integer, integer, character varying)    FUNCTION     �  CREATE FUNCTION public.f_update_room(p_id_user uuid, p_id_family integer, p_id_room integer, p_room_name character varying) RETURNS TABLE(id_room integer, room_name character varying)
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
 {   DROP FUNCTION public.f_update_room(p_id_user uuid, p_id_family integer, p_id_room integer, p_room_name character varying);
       public          postgres    false            @           1255    17596 �   f_update_shopping_item(uuid, integer, integer, character varying, integer, boolean, integer, timestamp without time zone, numeric, character varying, integer)    FUNCTION     �  CREATE FUNCTION public.f_update_shopping_item(p_id_user uuid, p_id_item integer, p_id_list integer, p_item_name character varying, p_quantity integer, p_is_purchased boolean, p_priority_level integer, p_reminder_date timestamp without time zone, p_price numeric, p_description character varying, p_id_item_type integer) RETURNS TABLE(id_item integer, id_list integer, item_name character varying, quantity integer, is_purchased boolean, priority_level integer, reminder_date timestamp without time zone, price numeric, description character varying, id_item_type integer)
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
 ?  DROP FUNCTION public.f_update_shopping_item(p_id_user uuid, p_id_item integer, p_id_list integer, p_item_name character varying, p_quantity integer, p_is_purchased boolean, p_priority_level integer, p_reminder_date timestamp without time zone, p_price numeric, p_description character varying, p_id_item_type integer);
       public          postgres    false            A           1255    17597 K   f_update_shopping_list(uuid, integer, character varying, character varying)    FUNCTION     *  CREATE FUNCTION public.f_update_shopping_list(p_id_user uuid, p_id_list integer, p_title character varying, p_description character varying) RETURNS TABLE(id_list integer, id_family integer, title character varying, created_at timestamp with time zone, updated_at timestamp with time zone, status character varying, description character varying)
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
 �   DROP FUNCTION public.f_update_shopping_list(p_id_user uuid, p_id_list integer, p_title character varying, p_description character varying);
       public          postgres    false            B           1255    17598 W   f_update_subject(text, integer, integer, integer, character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.f_update_subject(p_id_user text, p_id_subject integer, p_id_education_progress integer, p_id_family integer, p_subject_name character varying, p_description character varying) RETURNS TABLE(id_subject integer, id_education_progress integer, subject_name character varying, description text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM education_progress WHERE id_family = p_id_family AND education_progress.id_education_progress = p_id_education_progress) THEN
        RAISE EXCEPTION 'Family or education progress not found.';
    END IF;

    RETURN QUERY
    UPDATE subjects
    SET 
        subject_name = COALESCE(p_subject_name, subjects.subject_name),
        description = COALESCE(p_description, subjects.description)
    WHERE subjects.id_education_progress = p_id_education_progress
    AND subjects.id_subject = p_id_subject
    RETURNING subjects.id_subject, subjects.id_education_progress, subjects.subject_name, subjects.description;
END;
$$;
 �   DROP FUNCTION public.f_update_subject(p_id_user text, p_id_subject integer, p_id_education_progress integer, p_id_family integer, p_subject_name character varying, p_description character varying);
       public          postgres    false            C           1255    17599     f_update_user_avatar(uuid, text)    FUNCTION     1  CREATE FUNCTION public.f_update_user_avatar(p_id_user uuid, p_new_avatar text) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Cập nhật avatar
    IF NOT EXISTS (SELECT FROM users WHERE id_user = p_id_user) THEN
        RAISE EXCEPTION 'Update failed: No user found with id_user = %', p_id_user;
    END IF;

    UPDATE users
    SET avatar = p_new_avatar
    WHERE id_user = p_id_user;

    -- Trả về thông báo cập nhật thành công
    RETURN 'Update successful: User avatar updated for id_user = ' || p_id_user;
END;
$$;
 N   DROP FUNCTION public.f_update_user_avatar(p_id_user uuid, p_new_avatar text);
       public          postgres    false            D           1255    17600 3   f_update_user_profile(uuid, text, text, text, date)    FUNCTION       CREATE FUNCTION public.f_update_user_profile(p_id_user uuid, p_firstname text, p_lastname text, p_genre text, p_birthdate date) RETURNS public.users
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
    DROP FUNCTION public.f_update_user_profile(p_id_user uuid, p_firstname text, p_lastname text, p_genre text, p_birthdate date);
       public          postgres    false    223            E           1255    17601 :   f_validate_otp(uuid, character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.f_validate_otp(p_id_user uuid, p_otp character varying, p_email character varying) RETURNS boolean
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
 i   DROP FUNCTION public.f_validate_otp(p_id_user uuid, p_otp character varying, p_email character varying);
       public          postgres    false            F           1255    17602 G   f_validate_otp(character varying, character varying, character varying)    FUNCTION     �  CREATE FUNCTION public.f_validate_otp(p_id_user character varying, p_otp character varying, p_email character varying) RETURNS boolean
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
 v   DROP FUNCTION public.f_validate_otp(p_id_user character varying, p_otp character varying, p_email character varying);
       public          postgres    false            G           1255    17603 '   f_validate_user_mail(character varying)    FUNCTION     7  CREATE FUNCTION public.f_validate_user_mail(p_mail character varying) RETURNS boolean
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
 E   DROP FUNCTION public.f_validate_user_mail(p_mail character varying);
       public          postgres    false            H           1255    17604 (   f_validate_user_phone(character varying)    FUNCTION     A  CREATE FUNCTION public.f_validate_user_phone(p_phone character varying) RETURNS boolean
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
 G   DROP FUNCTION public.f_validate_user_phone(p_phone character varying);
       public          postgres    false            �           1255    17605    generate_invite_code()    FUNCTION     �  CREATE FUNCTION public.generate_invite_code() RETURNS character varying
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
 -   DROP FUNCTION public.generate_invite_code();
       public          postgres    false            �           1255    17606    generate_key(integer)    FUNCTION       CREATE FUNCTION public.generate_key(length integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
    random_key VARCHAR;
BEGIN
    SELECT gen_salt('md5') || substr(md5(random()::text), 0, length) INTO random_key;

    RETURN random_key;
END;
$$;
 3   DROP FUNCTION public.generate_key(length integer);
       public          postgres    false            �           1255    17607    generate_unique_invite_code()    FUNCTION       CREATE FUNCTION public.generate_unique_invite_code() RETURNS character varying
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
 4   DROP FUNCTION public.generate_unique_invite_code();
       public          postgres    false            "           1255    17608 $   generate_unique_invite_code(integer)    FUNCTION        CREATE FUNCTION public.generate_unique_invite_code(p_id_family integer) RETURNS character varying
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
 G   DROP FUNCTION public.generate_unique_invite_code(p_id_family integer);
       public          postgres    false            9           1255    17609    get_active_sessions_defaultdb()    FUNCTION     �  CREATE FUNCTION public.get_active_sessions_defaultdb() RETURNS TABLE(pid integer, usename name, datname name, client_addr inet, client_port integer, backend_start timestamp with time zone, state text, query_start timestamp with time zone, state_change timestamp with time zone)
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
 6   DROP FUNCTION public.get_active_sessions_defaultdb();
       public          postgres    false            I           1255    17610 &   get_all_category_events(integer, uuid)    FUNCTION     �  CREATE FUNCTION public.get_all_category_events(p_id_family integer, p_id_user uuid) RETURNS TABLE(id_category_event integer, title character varying, color character varying, id_family integer)
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
 S   DROP FUNCTION public.get_all_category_events(p_id_family integer, p_id_user uuid);
       public          postgres    false            J           1255    17611    get_all_family(uuid)    FUNCTION     u  CREATE FUNCTION public.get_all_family(p_id_user uuid) RETURNS SETOF public.family
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
 5   DROP FUNCTION public.get_all_family(p_id_user uuid);
       public          postgres    false    227            K           1255    17612    get_category_event(integer)    FUNCTION       CREATE FUNCTION public.get_category_event(p_id_category integer) RETURNS text
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
 @   DROP FUNCTION public.get_category_event(p_id_category integer);
       public          postgres    false            L           1255    17613 !   get_category_event_by_id(integer)    FUNCTION     M  CREATE FUNCTION public.get_category_event_by_id(_id_category_event integer) RETURNS TABLE(id_category_event integer, title character varying, color character varying, id_family integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT * FROM category_event WHERE id_category_event = _id_category_event;
END;
$$;
 K   DROP FUNCTION public.get_category_event_by_id(_id_category_event integer);
       public          postgres    false            M           1255    17614 '   get_category_event_by_id(integer, uuid)    FUNCTION     2  CREATE FUNCTION public.get_category_event_by_id(_id_category_event integer, _id_user uuid) RETURNS TABLE(id_category_event integer, title character varying, color character varying, id_family integer)
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
 Z   DROP FUNCTION public.get_category_event_by_id(_id_category_event integer, _id_user uuid);
       public          postgres    false            N           1255    17615 ,   get_events_for_family_on_date(date, integer)    FUNCTION     �  CREATE FUNCTION public.get_events_for_family_on_date(selected_date date, family_id integer) RETURNS TABLE(id_calendar integer, datetime timestamp without time zone, description text, id_family integer, title text)
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
 [   DROP FUNCTION public.get_events_for_family_on_date(selected_date date, family_id integer);
       public          postgres    false            O           1255    17616 $   get_package_info_by_id_user(integer)    FUNCTION     �  CREATE FUNCTION public.get_package_info_by_id_user(id_user integer) RETURNS TABLE(id_package integer, expired_at timestamp without time zone, package_info jsonb)
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
 C   DROP FUNCTION public.get_package_info_by_id_user(id_user integer);
       public          postgres    false            P           1255    17617    insert_finance_expenditure()    FUNCTION       CREATE FUNCTION public.insert_finance_expenditure() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    expenditure_details JSONB;
BEGIN
    expenditure_details := '[
        {"id_expense_type": 1, "category": "Food & Dining"},
        {"id_expense_type": 2, "category": "Transportation"},
        {"id_expense_type": 3, "category": "Utility Bills"},
        {"id_expense_type": 4, "category": "Education"},
        {"id_expense_type": 5, "category": "Healthcare"},
        {"id_expense_type": 6, "category": "Entertainment"},
        {"id_expense_type": 7, "category": "Travel"}
    ]'::jsonb;

    INSERT INTO finance_expenditure_type (id_family, expenditure_details)
    VALUES (NEW.id_family, expenditure_details);

    RETURN NEW;
END;
$$;
 3   DROP FUNCTION public.insert_finance_expenditure();
       public          postgres    false            Q           1255    17618    insert_income_sources()    FUNCTION     ;  CREATE FUNCTION public.insert_income_sources() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO finance_income_source (id_family, income_details)
    VALUES (
        NEW.id_family, 
        '[
            {"id_income_source": 1, "category": "Salary"},
            {"id_income_source": 2, "category": "Business"},
            {"id_income_source": 3, "category": "Investments"},
            {"id_income_source": 4, "category": "Freelance"},
            {"id_income_source": 5, "category": "Rental"},
            {"id_income_source": 6, "category": "Other"},
            {"id_income_source": 7, "category": "Pension"},
            {"id_income_source": 8, "category": "Gifts"},
            {"id_income_source": 9, "category": "Royalties"}
        ]'::jsonb
    );

    RETURN NEW;
END;
$$;
 .   DROP FUNCTION public.insert_income_sources();
       public          postgres    false            R           1255    17619    p_create_role()    FUNCTION     �   CREATE FUNCTION public.p_create_role() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN 
    EXECUTE 'CREATE ROLE ' || NEW.role;
    EXECUTE 'GRANT CONNECT ON DATABASE famfund_i2wq_a3fq TO ' || NEW.role;
    RETURN NEW;
END;
$$;
 &   DROP FUNCTION public.p_create_role();
       public          postgres    false            S           1255    17620    p_delete_member(uuid, integer) 	   PROCEDURE     S  CREATE PROCEDURE public.p_delete_member(IN p_id_user uuid, IN p_id_family integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM member_family WHERE id_user = p_id_user AND id_family = p_id_family) THEN
        DELETE FROM member_family WHERE id_user = p_id_user AND id_family = p_id_family;
    END IF;
END;
$$;
 R   DROP PROCEDURE public.p_delete_member(IN p_id_user uuid, IN p_id_family integer);
       public          postgres    false            T           1255    17621 $   p_delete_member(uuid, uuid, integer) 	   PROCEDURE     �  CREATE PROCEDURE public.p_delete_member(IN p_id_current_user uuid, IN p_id_user uuid, IN p_id_family integer)
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
 m   DROP PROCEDURE public.p_delete_member(IN p_id_current_user uuid, IN p_id_user uuid, IN p_id_family integer);
       public          postgres    false            U           1255    17622    p_delete_role()    FUNCTION     �   CREATE FUNCTION public.p_delete_role() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN 

	EXECUTE 'DROP ROLE IF EXISTS ' || OLD.role;

    RETURN OLD;
END;
$$;
 &   DROP FUNCTION public.p_delete_role();
       public          postgres    false                       1255    17623 /   p_update_role(uuid, integer, character varying)    FUNCTION     b  CREATE FUNCTION public.p_update_role(p_id_user uuid, p_id_family integer, p_role character varying) RETURNS character varying
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
 c   DROP FUNCTION public.p_update_role(p_id_user uuid, p_id_family integer, p_role character varying);
       public          postgres    false                       1255    17624 '   p_validate_otp(character varying, uuid) 	   PROCEDURE     �  CREATE PROCEDURE public.p_validate_otp(IN code character varying, IN id_user uuid)
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
 R   DROP PROCEDURE public.p_validate_otp(IN code character varying, IN id_user uuid);
       public          postgres    false            V           1255    17625 S   update_category_event(integer, character varying, character varying, integer, uuid)    FUNCTION     �  CREATE FUNCTION public.update_category_event(_id_category_event integer, _title character varying, _color character varying, _id_family integer, _id_user uuid) RETURNS TABLE(id_category_event integer, title character varying, color character varying, id_family integer)
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
 �   DROP FUNCTION public.update_category_event(_id_category_event integer, _title character varying, _color character varying, _id_family integer, _id_user uuid);
       public          postgres    false            W           1255    17626    update_family_quantity()    FUNCTION     M  CREATE FUNCTION public.update_family_quantity() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
        UPDATE family SET quantity = (SELECT COUNT(*) FROM member_family WHERE id_family = NEW.id_family) WHERE id_family = NEW.id_family;
    END IF;
    RETURN NEW;
END;
$$;
 /   DROP FUNCTION public.update_family_quantity();
       public          postgres    false            X           1255    17627 &   update_financial_summary_expenditure()    FUNCTION     B  CREATE FUNCTION public.update_financial_summary_expenditure() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE financial_summary
    SET total_expenditure = total_expenditure + NEW.amount,
        current_balance = current_balance - NEW.amount
    WHERE id_family = NEW.id_family;

    RETURN NEW;
END;
$$;
 =   DROP FUNCTION public.update_financial_summary_expenditure();
       public          postgres    false            Y           1255    17628 *   update_financial_summary_expenditure_mod()    FUNCTION     ~  CREATE FUNCTION public.update_financial_summary_expenditure_mod() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF TG_OP = 'DELETE' THEN
        UPDATE financial_summary
        SET total_expenditure = total_expenditure - OLD.amount,
            current_balance = current_balance + OLD.amount
        WHERE id_family = OLD.id_family;
    ELSIF TG_OP = 'UPDATE' THEN
        UPDATE financial_summary
        SET total_expenditure = total_expenditure - OLD.amount + NEW.amount,
            current_balance = current_balance + OLD.amount - NEW.amount
        WHERE id_family = OLD.id_family;
    END IF;
    RETURN NULL;
END;
$$;
 A   DROP FUNCTION public.update_financial_summary_expenditure_mod();
       public          postgres    false            Z           1255    17629 !   update_financial_summary_income()    FUNCTION     3  CREATE FUNCTION public.update_financial_summary_income() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE financial_summary
    SET total_income = total_income + NEW.amount,
        current_balance = current_balance + NEW.amount
    WHERE id_family = NEW.id_family;

    RETURN NEW;
END;
$$;
 8   DROP FUNCTION public.update_financial_summary_income();
       public          postgres    false            [           1255    17630 %   update_financial_summary_income_mod()    FUNCTION     e  CREATE FUNCTION public.update_financial_summary_income_mod() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF TG_OP = 'DELETE' THEN
        UPDATE financial_summary
        SET total_income = total_income - OLD.amount,
            current_balance = current_balance - OLD.amount
        WHERE id_family = OLD.id_family;
    ELSIF TG_OP = 'UPDATE' THEN
        UPDATE financial_summary
        SET total_income = total_income - OLD.amount + NEW.amount,
            current_balance = current_balance - OLD.amount + NEW.amount
        WHERE id_family = OLD.id_family;
    END IF;
    RETURN NULL;
END;
$$;
 <   DROP FUNCTION public.update_financial_summary_income_mod();
       public          postgres    false            \           1255    17631    update_invoice_amount()    FUNCTION     �  CREATE FUNCTION public.update_invoice_amount() RETURNS trigger
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
 .   DROP FUNCTION public.update_invoice_amount();
       public          postgres    false            ]           1255    17632    update_invoice_updated_at()    FUNCTION     �   CREATE FUNCTION public.update_invoice_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;
 2   DROP FUNCTION public.update_invoice_updated_at();
       public          postgres    false            ^           1255    17633    update_key_value() 	   PROCEDURE     i  CREATE PROCEDURE public.update_key_value()
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
 *   DROP PROCEDURE public.update_key_value();
       public          postgres    false            _           1255    17634    update_modified_column()    FUNCTION     �   CREATE FUNCTION public.update_modified_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW; 
END;
$$;
 /   DROP FUNCTION public.update_modified_column();
       public          postgres    false            `           1255    17635    update_role_on_member_family()    FUNCTION     �  CREATE FUNCTION public.update_role_on_member_family() RETURNS trigger
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
 5   DROP FUNCTION public.update_role_on_member_family();
       public          postgres    false            a           1255    17636    update_total_amount()    FUNCTION     �   CREATE FUNCTION public.update_total_amount() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Tính tổng amount + tax và gán vào total_amount
    NEW.total_amount := NEW.amount + NEW.tax_amount;
    RETURN NEW;
END;
$$;
 ,   DROP FUNCTION public.update_total_amount();
       public          postgres    false            b           1255    17637    update_updated_at_column()    FUNCTION     �   CREATE FUNCTION public.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$;
 1   DROP FUNCTION public.update_updated_at_column();
       public          postgres    false            �            1259    17638    article    TABLE     �  CREATE TABLE public.article (
    id_article integer NOT NULL,
    id_article_category integer DEFAULT 1 NOT NULL,
    id_enclosure integer DEFAULT 1,
    title character varying DEFAULT ''::character varying NOT NULL,
    link character varying DEFAULT ''::character varying NOT NULL,
    content character varying DEFAULT ''::character varying NOT NULL,
    "contentSnippet" character varying DEFAULT ''::character varying NOT NULL,
    guid character varying DEFAULT ''::character varying NOT NULL,
    "isoDate" character varying DEFAULT ''::character varying NOT NULL,
    "pubDate" timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE public.article;
       public         heap    postgres    false            �            1259    17652    article_category    TABLE     �   CREATE TABLE public.article_category (
    id_article_category integer NOT NULL,
    name character varying DEFAULT ''::character varying NOT NULL
);
 $   DROP TABLE public.article_category;
       public         heap    postgres    false            �            1259    17658 (   article_category_id_article_category_seq    SEQUENCE     �   CREATE SEQUENCE public.article_category_id_article_category_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ?   DROP SEQUENCE public.article_category_id_article_category_seq;
       public          postgres    false    230            |           0    0 (   article_category_id_article_category_seq    SEQUENCE OWNED BY     u   ALTER SEQUENCE public.article_category_id_article_category_seq OWNED BY public.article_category.id_article_category;
          public          postgres    false    231            �            1259    17659    article_id_article_seq    SEQUENCE     �   CREATE SEQUENCE public.article_id_article_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.article_id_article_seq;
       public          postgres    false    229            }           0    0    article_id_article_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.article_id_article_seq OWNED BY public.article.id_article;
          public          postgres    false    232            �            1259    17660    calendar_id_calendar_seq    SEQUENCE     �   CREATE SEQUENCE public.calendar_id_calendar_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.calendar_id_calendar_seq;
       public          postgres    false            �            1259    17661    calendar    TABLE     D  CREATE TABLE public.calendar (
    id_calendar integer DEFAULT nextval('public.calendar_id_calendar_seq'::regclass) NOT NULL,
    id_family integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    time_start timestamp without time zone NOT NULL,
    time_end timestamp without time zone NOT NULL,
    color text,
    is_all_day boolean DEFAULT false NOT NULL,
    category integer NOT NULL,
    recurrence_id integer,
    title character varying(255) DEFAULT 'New Event'::character varying NOT NULL,
    description text DEFAULT ''::text,
    location text,
    start_timezone character varying(255),
    end_timezone character varying(255),
    recurrence_exception character varying(255),
    recurrence_rule character varying(255)
);
    DROP TABLE public.calendar;
       public         heap    postgres    false    233            �            1259    17672    calendar_id_calendar_seq1    SEQUENCE     �   CREATE SEQUENCE public.calendar_id_calendar_seq1
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.calendar_id_calendar_seq1;
       public          postgres    false    234            ~           0    0    calendar_id_calendar_seq1    SEQUENCE OWNED BY     V   ALTER SEQUENCE public.calendar_id_calendar_seq1 OWNED BY public.calendar.id_calendar;
          public          postgres    false    235            �            1259    17673    category_event    TABLE     �  CREATE TABLE public.category_event (
    id_category_event integer NOT NULL,
    id_family integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    title character varying(255) DEFAULT 'Default Title of Category Event'::character varying NOT NULL,
    color character varying(255) DEFAULT '#000000'::character varying NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);

ALTER TABLE ONLY public.category_event REPLICA IDENTITY FULL;
 "   DROP TABLE public.category_event;
       public         heap    postgres    false            �            1259    17682 $   category_event_id_category_event_seq    SEQUENCE     �   CREATE SEQUENCE public.category_event_id_category_event_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ;   DROP SEQUENCE public.category_event_id_category_event_seq;
       public          postgres    false    236                       0    0 $   category_event_id_category_event_seq    SEQUENCE OWNED BY     m   ALTER SEQUENCE public.category_event_id_category_event_seq OWNED BY public.category_event.id_category_event;
          public          postgres    false    237            �            1259    17683 	   checklist    TABLE     �  CREATE TABLE public.checklist (
    id_checklist integer NOT NULL,
    id_family integer NOT NULL,
    task_name character varying(255) NOT NULL,
    description text,
    is_completed boolean DEFAULT false NOT NULL,
    due_date timestamp without time zone DEFAULT now() NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    is_notified_3_days_before boolean DEFAULT false NOT NULL,
    is_notified_1_day_before boolean DEFAULT false NOT NULL,
    is_notified_on_due_date boolean DEFAULT false NOT NULL,
    id_checklist_type integer DEFAULT 1 NOT NULL
);
    DROP TABLE public.checklist;
       public         heap    postgres    false            �            1259    17696    checklist_id_checklist_seq    SEQUENCE     �   CREATE SEQUENCE public.checklist_id_checklist_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.checklist_id_checklist_seq;
       public          postgres    false    238            �           0    0    checklist_id_checklist_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.checklist_id_checklist_seq OWNED BY public.checklist.id_checklist;
          public          postgres    false    239            �            1259    17697    checklist_type    TABLE     �   CREATE TABLE public.checklist_type (
    id_checklist_type integer NOT NULL,
    name_en character varying(255) NOT NULL,
    name_vn character varying(255) NOT NULL,
    icon_url text
);
 "   DROP TABLE public.checklist_type;
       public         heap    postgres    false            �            1259    17702 $   checklist_type_id_checklist_type_seq    SEQUENCE     �   CREATE SEQUENCE public.checklist_type_id_checklist_type_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ;   DROP SEQUENCE public.checklist_type_id_checklist_type_seq;
       public          postgres    false    240            �           0    0 $   checklist_type_id_checklist_type_seq    SEQUENCE OWNED BY     m   ALTER SEQUENCE public.checklist_type_id_checklist_type_seq OWNED BY public.checklist_type.id_checklist_type;
          public          postgres    false    241            �            1259    17703    discount    TABLE     2  CREATE TABLE public.discount (
    code character varying(255) NOT NULL,
    percentage integer NOT NULL,
    expired_at timestamp with time zone DEFAULT now() NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE public.discount;
       public         heap    postgres    false            �            1259    17709 ,   education_progress_id_education_progress_seq    SEQUENCE     �   CREATE SEQUENCE public.education_progress_id_education_progress_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;
 C   DROP SEQUENCE public.education_progress_id_education_progress_seq;
       public          postgres    false            �            1259    17710    education_progress    TABLE     �  CREATE TABLE public.education_progress (
    id_education_progress integer DEFAULT nextval('public.education_progress_id_education_progress_seq'::regclass) NOT NULL,
    id_family integer NOT NULL,
    id_user uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    title character varying NOT NULL,
    progress_notes character varying NOT NULL,
    school_info character varying NOT NULL
);
 &   DROP TABLE public.education_progress;
       public         heap    postgres    false    243            �            1259    17718 -   education_progress_id_education_progress_seq1    SEQUENCE     �   CREATE SEQUENCE public.education_progress_id_education_progress_seq1
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 D   DROP SEQUENCE public.education_progress_id_education_progress_seq1;
       public          postgres    false    244            �           0    0 -   education_progress_id_education_progress_seq1    SEQUENCE OWNED BY     ~   ALTER SEQUENCE public.education_progress_id_education_progress_seq1 OWNED BY public.education_progress.id_education_progress;
          public          postgres    false    245            �            1259    17719 	   enclosure    TABLE     �   CREATE TABLE public.enclosure (
    id_enclosure integer NOT NULL,
    type character varying NOT NULL,
    length character varying NOT NULL,
    url character varying NOT NULL
);
    DROP TABLE public.enclosure;
       public         heap    postgres    false            �            1259    17724    enclosure_id_enclosure_seq    SEQUENCE     �   CREATE SEQUENCE public.enclosure_id_enclosure_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.enclosure_id_enclosure_seq;
       public          postgres    false    246            �           0    0    enclosure_id_enclosure_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.enclosure_id_enclosure_seq OWNED BY public.enclosure.id_enclosure;
          public          postgres    false    247            �            1259    17725    family_extra_packages    TABLE     �   CREATE TABLE public.family_extra_packages (
    id_family_extra_package integer NOT NULL,
    id_family integer NOT NULL,
    id_extra_package integer NOT NULL
);
 )   DROP TABLE public.family_extra_packages;
       public         heap    postgres    false            �            1259    17728 1   family_extra_packages_id_family_extra_package_seq    SEQUENCE     �   CREATE SEQUENCE public.family_extra_packages_id_family_extra_package_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 H   DROP SEQUENCE public.family_extra_packages_id_family_extra_package_seq;
       public          postgres    false    248            �           0    0 1   family_extra_packages_id_family_extra_package_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public.family_extra_packages_id_family_extra_package_seq OWNED BY public.family_extra_packages.id_family_extra_package;
          public          postgres    false    249            �            1259    17729    family_id_family_seq1    SEQUENCE     �   CREATE SEQUENCE public.family_id_family_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;
 ,   DROP SEQUENCE public.family_id_family_seq1;
       public          postgres    false            �            1259    17731    family_id_family_seq2    SEQUENCE     �   CREATE SEQUENCE public.family_id_family_seq2
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.family_id_family_seq2;
       public          postgres    false    227            �           0    0    family_id_family_seq2    SEQUENCE OWNED BY     N   ALTER SEQUENCE public.family_id_family_seq2 OWNED BY public.family.id_family;
          public          postgres    false    251            �            1259    17732    family_id_sequence    SEQUENCE     {   CREATE SEQUENCE public.family_id_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.family_id_sequence;
       public          postgres    false            �            1259    17733    family_invitation    TABLE     �   CREATE TABLE public.family_invitation (
    id_invitation integer NOT NULL,
    id_family integer,
    code character varying
);
 %   DROP TABLE public.family_invitation;
       public         heap    postgres    false            �            1259    17738 #   family_invitation_id_invitation_seq    SEQUENCE     �   CREATE SEQUENCE public.family_invitation_id_invitation_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE public.family_invitation_id_invitation_seq;
       public          postgres    false    253            �           0    0 #   family_invitation_id_invitation_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE public.family_invitation_id_invitation_seq OWNED BY public.family_invitation.id_invitation;
          public          postgres    false    254            �            1259    17739    family_roles    TABLE     �   CREATE TABLE public.family_roles (
    id_family_role integer NOT NULL,
    role_name_vn character varying NOT NULL,
    role_name_en character varying NOT NULL
);
     DROP TABLE public.family_roles;
       public         heap    postgres    false                        1259    17744    family_roles_id_family_role_seq    SEQUENCE     �   CREATE SEQUENCE public.family_roles_id_family_role_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.family_roles_id_family_role_seq;
       public          postgres    false    255            �           0    0    family_roles_id_family_role_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.family_roles_id_family_role_seq OWNED BY public.family_roles.id_family_role;
          public          postgres    false    256                       1259    17745    feedback_metadata    TABLE     �   CREATE TABLE public.feedback_metadata (
    metadata_key character varying NOT NULL,
    "totalFeedbacks" integer DEFAULT 0 NOT NULL,
    "averageRating" double precision DEFAULT '0'::double precision NOT NULL
);
 %   DROP TABLE public.feedback_metadata;
       public         heap    postgres    false                       1259    17752 	   feedbacks    TABLE       CREATE TABLE public.feedbacks (
    id_feedback integer NOT NULL,
    comment text NOT NULL,
    rating integer NOT NULL,
    id_user uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE public.feedbacks;
       public         heap    postgres    false                       1259    17759    feedbacks_id_feedback_seq    SEQUENCE     �   CREATE SEQUENCE public.feedbacks_id_feedback_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.feedbacks_id_feedback_seq;
       public          postgres    false    258            �           0    0    feedbacks_id_feedback_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.feedbacks_id_feedback_seq OWNED BY public.feedbacks.id_feedback;
          public          postgres    false    259                       1259    17760    finance_assets_asset_id_seq    SEQUENCE     �   CREATE SEQUENCE public.finance_assets_asset_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.finance_assets_asset_id_seq;
       public          postgres    false    225            �           0    0    finance_assets_asset_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.finance_assets_asset_id_seq OWNED BY public.finance_assets.id_asset;
          public          postgres    false    260                       1259    17761    finance_assets_id_asset_seq    SEQUENCE     �   CREATE SEQUENCE public.finance_assets_id_asset_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.finance_assets_id_asset_seq;
       public          postgres    false    225            �           0    0    finance_assets_id_asset_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.finance_assets_id_asset_seq OWNED BY public.finance_assets.id_asset;
          public          postgres    false    261                       1259    17762    finance_expenditure    TABLE     �  CREATE TABLE public.finance_expenditure (
    id_expenditure integer NOT NULL,
    id_family integer NOT NULL,
    description text DEFAULT ''::text,
    id_created_by uuid,
    id_expenditure_type integer,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    amount integer DEFAULT 0 NOT NULL,
    image_url text,
    expenditure_date timestamp without time zone DEFAULT now() NOT NULL
);
 '   DROP TABLE public.finance_expenditure;
       public         heap    postgres    false                       1259    17772 &   finance_expenditure_expenditure_id_seq    SEQUENCE     �   CREATE SEQUENCE public.finance_expenditure_expenditure_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 =   DROP SEQUENCE public.finance_expenditure_expenditure_id_seq;
       public          postgres    false    262            �           0    0 &   finance_expenditure_expenditure_id_seq    SEQUENCE OWNED BY     q   ALTER SEQUENCE public.finance_expenditure_expenditure_id_seq OWNED BY public.finance_expenditure.id_expenditure;
          public          postgres    false    263                       1259    17773 &   finance_expenditure_id_expenditure_seq    SEQUENCE     �   CREATE SEQUENCE public.finance_expenditure_id_expenditure_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 =   DROP SEQUENCE public.finance_expenditure_id_expenditure_seq;
       public          postgres    false    262            �           0    0 &   finance_expenditure_id_expenditure_seq    SEQUENCE OWNED BY     q   ALTER SEQUENCE public.finance_expenditure_id_expenditure_seq OWNED BY public.finance_expenditure.id_expenditure;
          public          postgres    false    264            	           1259    17774    finance_expenditure_type    TABLE     �   CREATE TABLE public.finance_expenditure_type (
    id_family integer NOT NULL,
    id_expenditure_type integer NOT NULL,
    expense_type_name character varying(255) NOT NULL
);
 ,   DROP TABLE public.finance_expenditure_type;
       public         heap    postgres    false            
           1259    17777 0   finance_expenditure_type_id_expenditure_type_seq    SEQUENCE     �   CREATE SEQUENCE public.finance_expenditure_type_id_expenditure_type_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 G   DROP SEQUENCE public.finance_expenditure_type_id_expenditure_type_seq;
       public          postgres    false    265            �           0    0 0   finance_expenditure_type_id_expenditure_type_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public.finance_expenditure_type_id_expenditure_type_seq OWNED BY public.finance_expenditure_type.id_expenditure_type;
          public          postgres    false    266                       1259    17778    finance_income    TABLE     �  CREATE TABLE public.finance_income (
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
 "   DROP TABLE public.finance_income;
       public         heap    postgres    false                       1259    17788    finance_income_id_income_seq    SEQUENCE     �   CREATE SEQUENCE public.finance_income_id_income_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.finance_income_id_income_seq;
       public          postgres    false    267            �           0    0    finance_income_id_income_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.finance_income_id_income_seq OWNED BY public.finance_income.id_income;
          public          postgres    false    268                       1259    17789    finance_income_income_id_seq    SEQUENCE     �   CREATE SEQUENCE public.finance_income_income_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.finance_income_income_id_seq;
       public          postgres    false    267            �           0    0    finance_income_income_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.finance_income_income_id_seq OWNED BY public.finance_income.id_income;
          public          postgres    false    269                       1259    17790    finance_income_source    TABLE     �   CREATE TABLE public.finance_income_source (
    id_family integer NOT NULL,
    id_income_source integer NOT NULL,
    income_source_name character varying(255) NOT NULL
);
 )   DROP TABLE public.finance_income_source;
       public         heap    postgres    false                       1259    17793 *   finance_income_source_id_income_source_seq    SEQUENCE     �   CREATE SEQUENCE public.finance_income_source_id_income_source_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 A   DROP SEQUENCE public.finance_income_source_id_income_source_seq;
       public          postgres    false    270            �           0    0 *   finance_income_source_id_income_source_seq    SEQUENCE OWNED BY     y   ALTER SEQUENCE public.finance_income_source_id_income_source_seq OWNED BY public.finance_income_source.id_income_source;
          public          postgres    false    271                       1259    17794    financial_summary    TABLE     �  CREATE TABLE public.financial_summary (
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
 %   DROP TABLE public.financial_summary;
       public         heap    postgres    false                       1259    17804     financial_summary_summary_id_seq    SEQUENCE     �   CREATE SEQUENCE public.financial_summary_summary_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.financial_summary_summary_id_seq;
       public          postgres    false    272            �           0    0     financial_summary_summary_id_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.financial_summary_summary_id_seq OWNED BY public.financial_summary.id_summary;
          public          postgres    false    273                       1259    17805    flow_watermarks    TABLE     T   CREATE TABLE public.flow_watermarks (
    slot text NOT NULL,
    watermark text
);
 #   DROP TABLE public.flow_watermarks;
       public         heap    postgres    false                       1259    17810    guide_items    TABLE     �  CREATE TABLE public.guide_items (
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    id_family integer NOT NULL,
    is_shared boolean DEFAULT false NOT NULL,
    id_guide_item integer NOT NULL,
    steps json,
    name character varying(255) NOT NULL,
    description text
);

ALTER TABLE ONLY public.guide_items REPLICA IDENTITY FULL;
    DROP TABLE public.guide_items;
       public         heap    postgres    false                       1259    17818    guide_items_id_guide_item_seq    SEQUENCE     �   CREATE SEQUENCE public.guide_items_id_guide_item_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.guide_items_id_guide_item_seq;
       public          postgres    false    275            �           0    0    guide_items_id_guide_item_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.guide_items_id_guide_item_seq OWNED BY public.guide_items.id_guide_item;
          public          postgres    false    276                       1259    17819    guide_items_id_item_seq    SEQUENCE     �   CREATE SEQUENCE public.guide_items_id_item_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;
 .   DROP SEQUENCE public.guide_items_id_item_seq;
       public          postgres    false                       1259    17820    household_consumable_items    TABLE     �   CREATE TABLE public.household_consumable_items (
    id_household_item integer NOT NULL,
    quantity integer NOT NULL,
    threshold integer NOT NULL,
    expired_date date
);
 .   DROP TABLE public.household_consumable_items;
       public         heap    postgres    false                       1259    17823    household_durable_items    TABLE     �   CREATE TABLE public.household_durable_items (
    id_household_item integer NOT NULL,
    condition character varying(255) NOT NULL
);
 +   DROP TABLE public.household_durable_items;
       public         heap    postgres    false                       1259    17826    household_item_categories    TABLE     �   CREATE TABLE public.household_item_categories (
    id_household_item_category integer NOT NULL,
    category_name character varying(255) NOT NULL
);
 -   DROP TABLE public.household_item_categories;
       public         heap    postgres    false                       1259    17829 )   household_item_categories_category_id_seq    SEQUENCE     �   CREATE SEQUENCE public.household_item_categories_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 @   DROP SEQUENCE public.household_item_categories_category_id_seq;
       public          postgres    false    280            �           0    0 )   household_item_categories_category_id_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public.household_item_categories_category_id_seq OWNED BY public.household_item_categories.id_household_item_category;
          public          postgres    false    281                       1259    17830 8   household_item_categories_id_household_item_category_seq    SEQUENCE     �   CREATE SEQUENCE public.household_item_categories_id_household_item_category_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 O   DROP SEQUENCE public.household_item_categories_id_household_item_category_seq;
       public          postgres    false    280            �           0    0 8   household_item_categories_id_household_item_category_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public.household_item_categories_id_household_item_category_seq OWNED BY public.household_item_categories.id_household_item_category;
          public          postgres    false    282                       1259    17831 %   household_items_id_household_item_seq    SEQUENCE     �   CREATE SEQUENCE public.household_items_id_household_item_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 <   DROP SEQUENCE public.household_items_id_household_item_seq;
       public          postgres    false    228            �           0    0 %   household_items_id_household_item_seq    SEQUENCE OWNED BY     o   ALTER SEQUENCE public.household_items_id_household_item_seq OWNED BY public.household_items.id_household_item;
          public          postgres    false    283                       1259    17832    invoice    TABLE       CREATE TABLE public.invoice (
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
    DROP TABLE public.invoice;
       public         heap    postgres    false                       1259    17841    invoice_id_invoice_seq    SEQUENCE     �   CREATE SEQUENCE public.invoice_id_invoice_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.invoice_id_invoice_seq;
       public          postgres    false    284            �           0    0    invoice_id_invoice_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.invoice_id_invoice_seq OWNED BY public.invoice.id_invoice;
          public          postgres    false    285                       1259    17842    invoice_items    TABLE     o  CREATE TABLE public.invoice_items (
    id_item integer NOT NULL,
    id_invoice integer NOT NULL,
    item_description character varying(255) NOT NULL,
    quantity integer NOT NULL,
    unit_price numeric(10,2) NOT NULL,
    total_price numeric(10,2) GENERATED ALWAYS AS (((quantity)::numeric * unit_price)) STORED,
    item_name character varying(255) NOT NULL
);
 !   DROP TABLE public.invoice_items;
       public         heap    postgres    false                       1259    17848    invoice_items_id_item_seq    SEQUENCE     �   CREATE SEQUENCE public.invoice_items_id_item_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.invoice_items_id_item_seq;
       public          postgres    false    286            �           0    0    invoice_items_id_item_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.invoice_items_id_item_seq OWNED BY public.invoice_items.id_item;
          public          postgres    false    287                        1259    17849    invoice_type    TABLE     �   CREATE TABLE public.invoice_type (
    id_invoice_type integer NOT NULL,
    type_name character varying(50) NOT NULL,
    id_family integer NOT NULL
);
     DROP TABLE public.invoice_type;
       public         heap    postgres    false            !           1259    17852     invoice_type_id_invoice_type_seq    SEQUENCE     �   CREATE SEQUENCE public.invoice_type_id_invoice_type_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.invoice_type_id_invoice_type_seq;
       public          postgres    false    288            �           0    0     invoice_type_id_invoice_type_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.invoice_type_id_invoice_type_seq OWNED BY public.invoice_type.id_invoice_type;
          public          postgres    false    289            "           1259    17853    key    TABLE     P   CREATE TABLE public.key (
    id integer NOT NULL,
    key character varying
);
    DROP TABLE public.key;
       public         heap    postgres    false            #           1259    17858 
   key_id_seq    SEQUENCE     {   CREATE SEQUENCE public.key_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;
 !   DROP SEQUENCE public.key_id_seq;
       public          postgres    false            $           1259    17859    key_id_seq1    SEQUENCE     |   CREATE SEQUENCE public.key_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;
 "   DROP SEQUENCE public.key_id_seq1;
       public          postgres    false            %           1259    17860    member_family_id_seq1    SEQUENCE     �   CREATE SEQUENCE public.member_family_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;
 ,   DROP SEQUENCE public.member_family_id_seq1;
       public          postgres    false            &           1259    17861    member_family_id_seq2    SEQUENCE     �   CREATE SEQUENCE public.member_family_id_seq2
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.member_family_id_seq2;
       public          postgres    false    222            �           0    0    member_family_id_seq2    SEQUENCE OWNED BY     N   ALTER SEQUENCE public.member_family_id_seq2 OWNED BY public.member_family.id;
          public          postgres    false    294            '           1259    17862     notification_id_notification_seq    SEQUENCE     �   CREATE SEQUENCE public.notification_id_notification_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;
 7   DROP SEQUENCE public.notification_id_notification_seq;
       public          postgres    false            (           1259    17863    order    TABLE     P  CREATE TABLE public."order" (
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
    DROP TABLE public."order";
       public         heap    postgres    false    1243    3    1243            )           1259    17873    order_family_id_seq    SEQUENCE     �   CREATE SEQUENCE public.order_family_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;
 *   DROP SEQUENCE public.order_family_id_seq;
       public          postgres    false            *           1259    17874    order_id_order_seq    SEQUENCE     �   CREATE SEQUENCE public.order_id_order_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;
 )   DROP SEQUENCE public.order_id_order_seq;
       public          postgres    false            +           1259    17875    order_id_order_seq1    SEQUENCE     �   CREATE SEQUENCE public.order_id_order_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;
 *   DROP SEQUENCE public.order_id_order_seq1;
       public          postgres    false            ,           1259    17876    otp    TABLE     u  CREATE TABLE public.otp (
    otp_id integer NOT NULL,
    id_user uuid,
    code character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    expired_at timestamp without time zone,
    otp_type public.otp_type DEFAULT 'register account'::public.otp_type NOT NULL
);
    DROP TABLE public.otp;
       public         heap    postgres    false    1246    1246            -           1259    17884    otp_otp_id_seq    SEQUENCE        CREATE SEQUENCE public.otp_otp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;
 %   DROP SEQUENCE public.otp_otp_id_seq;
       public          postgres    false            .           1259    17885    otp_otp_id_seq1    SEQUENCE     �   CREATE SEQUENCE public.otp_otp_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;
 &   DROP SEQUENCE public.otp_otp_id_seq1;
       public          postgres    false            /           1259    17886    otp_otp_id_seq2    SEQUENCE     �   CREATE SEQUENCE public.otp_otp_id_seq2
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.otp_otp_id_seq2;
       public          postgres    false    300            �           0    0    otp_otp_id_seq2    SEQUENCE OWNED BY     B   ALTER SEQUENCE public.otp_otp_id_seq2 OWNED BY public.otp.otp_id;
          public          postgres    false    303            0           1259    17887    package_combo    TABLE     s  CREATE TABLE public.package_combo (
    id_combo_package integer NOT NULL,
    name character varying NOT NULL,
    description character varying,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    price integer DEFAULT 500000 NOT NULL
);
 !   DROP TABLE public.package_combo;
       public         heap    postgres    false            1           1259    17896 "   package_combo_id_combo_package_seq    SEQUENCE     �   CREATE SEQUENCE public.package_combo_id_combo_package_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.package_combo_id_combo_package_seq;
       public          postgres    false    304            �           0    0 "   package_combo_id_combo_package_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.package_combo_id_combo_package_seq OWNED BY public.package_combo.id_combo_package;
          public          postgres    false    305            2           1259    17897    package_combo_package_extra    TABLE     �   CREATE TABLE public.package_combo_package_extra (
    package_combo_id integer NOT NULL,
    package_extra_id integer NOT NULL
);
 /   DROP TABLE public.package_combo_package_extra;
       public         heap    postgres    false            3           1259    17900    package_extra    TABLE     s  CREATE TABLE public.package_extra (
    id_extra_package integer NOT NULL,
    name character varying NOT NULL,
    description character varying,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    price integer DEFAULT 500000 NOT NULL
);
 !   DROP TABLE public.package_extra;
       public         heap    postgres    false            4           1259    17909 "   package_extra_id_extra_package_seq    SEQUENCE     �   CREATE SEQUENCE public.package_extra_id_extra_package_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.package_extra_id_extra_package_seq;
       public          postgres    false    307            �           0    0 "   package_extra_id_extra_package_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.package_extra_id_extra_package_seq OWNED BY public.package_extra.id_extra_package;
          public          postgres    false    308            5           1259    17910    package_main    TABLE     �  CREATE TABLE public.package_main (
    id_main_package integer NOT NULL,
    name character varying NOT NULL,
    description character varying,
    is_active boolean DEFAULT true NOT NULL,
    duration_months integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    price integer DEFAULT 500000 NOT NULL
);
     DROP TABLE public.package_main;
       public         heap    postgres    false            6           1259    17919     package_main_id_main_package_seq    SEQUENCE     �   CREATE SEQUENCE public.package_main_id_main_package_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.package_main_id_main_package_seq;
       public          postgres    false    309            �           0    0     package_main_id_main_package_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.package_main_id_main_package_seq OWNED BY public.package_main.id_main_package;
          public          postgres    false    310            7           1259    17920    payment_history    TABLE     _  CREATE TABLE public.payment_history (
    id_payment_history integer NOT NULL,
    payment_method character varying DEFAULT 'vnpay'::character varying NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    id_user uuid NOT NULL,
    type character varying NOT NULL,
    amount integer NOT NULL,
    id_order uuid NOT NULL
);
 #   DROP TABLE public.payment_history;
       public         heap    postgres    false            8           1259    17927 &   payment_history_id_payment_history_seq    SEQUENCE     �   CREATE SEQUENCE public.payment_history_id_payment_history_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 =   DROP SEQUENCE public.payment_history_id_payment_history_seq;
       public          postgres    false    311            �           0    0 &   payment_history_id_payment_history_seq    SEQUENCE OWNED BY     q   ALTER SEQUENCE public.payment_history_id_payment_history_seq OWNED BY public.payment_history.id_payment_history;
          public          postgres    false    312            9           1259    17928    payment_method    TABLE     �   CREATE TABLE public.payment_method (
    id integer NOT NULL,
    name character varying NOT NULL,
    code character varying NOT NULL,
    url_image character varying
);
 "   DROP TABLE public.payment_method;
       public         heap    postgres    false            :           1259    17933    payment_method_id_seq    SEQUENCE     �   CREATE SEQUENCE public.payment_method_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;
 ,   DROP SEQUENCE public.payment_method_id_seq;
       public          postgres    false            ;           1259    17934    payment_method_id_seq1    SEQUENCE     �   CREATE SEQUENCE public.payment_method_id_seq1
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.payment_method_id_seq1;
       public          postgres    false    313            �           0    0    payment_method_id_seq1    SEQUENCE OWNED BY     P   ALTER SEQUENCE public.payment_method_id_seq1 OWNED BY public.payment_method.id;
          public          postgres    false    315            <           1259    17935    refresh_token_id_seq    SEQUENCE     �   CREATE SEQUENCE public.refresh_token_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;
 +   DROP SEQUENCE public.refresh_token_id_seq;
       public          postgres    false            =           1259    17936    refresh_token    TABLE     9  CREATE TABLE public.refresh_token (
    refresh_token character varying NOT NULL,
    id_user uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    expired_at timestamp without time zone NOT NULL,
    id integer DEFAULT nextval('public.refresh_token_id_seq'::regclass) NOT NULL
);
 !   DROP TABLE public.refresh_token;
       public         heap    postgres    false    316            >           1259    17943    refresh_token_id_seq1    SEQUENCE     �   CREATE SEQUENCE public.refresh_token_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;
 ,   DROP SEQUENCE public.refresh_token_id_seq1;
       public          postgres    false            ?           1259    17944    refresh_token_id_seq2    SEQUENCE     �   CREATE SEQUENCE public.refresh_token_id_seq2
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.refresh_token_id_seq2;
       public          postgres    false    317            �           0    0    refresh_token_id_seq2    SEQUENCE OWNED BY     N   ALTER SEQUENCE public.refresh_token_id_seq2 OWNED BY public.refresh_token.id;
          public          postgres    false    319            @           1259    17945    room    TABLE     2  CREATE TABLE public.room (
    id_room integer NOT NULL,
    id_family integer NOT NULL,
    room_name character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    room_image character varying
);
    DROP TABLE public.room;
       public         heap    postgres    false            A           1259    17952    room_id_room_seq    SEQUENCE     �   CREATE SEQUENCE public.room_id_room_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.room_id_room_seq;
       public          postgres    false    320            �           0    0    room_id_room_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.room_id_room_seq OWNED BY public.room.id_room;
          public          postgres    false    321            B           1259    17953    shopping_item_types    TABLE     �   CREATE TABLE public.shopping_item_types (
    id_item_type integer NOT NULL,
    item_type_name_en character varying(255) NOT NULL,
    item_type_name_vn character varying(255) NOT NULL,
    icon_url text
);
 '   DROP TABLE public.shopping_item_types;
       public         heap    postgres    false            C           1259    17958 $   shopping_item_types_id_item_type_seq    SEQUENCE     �   CREATE SEQUENCE public.shopping_item_types_id_item_type_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ;   DROP SEQUENCE public.shopping_item_types_id_item_type_seq;
       public          postgres    false    322            �           0    0 $   shopping_item_types_id_item_type_seq    SEQUENCE OWNED BY     m   ALTER SEQUENCE public.shopping_item_types_id_item_type_seq OWNED BY public.shopping_item_types.id_item_type;
          public          postgres    false    323            D           1259    17959    shopping_items    TABLE     {  CREATE TABLE public.shopping_items (
    id_item integer NOT NULL,
    id_list integer NOT NULL,
    id_item_type integer NOT NULL,
    item_name character varying(255) NOT NULL,
    description character varying,
    quantity integer DEFAULT 1 NOT NULL,
    is_purchased boolean DEFAULT false NOT NULL,
    priority_level integer DEFAULT 1 NOT NULL,
    reminder_date timestamp without time zone DEFAULT '2024-07-22 04:56:48.806'::timestamp without time zone,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    price integer DEFAULT 0 NOT NULL
);
 "   DROP TABLE public.shopping_items;
       public         heap    postgres    false            E           1259    17971    shopping_items_id_item_seq    SEQUENCE     �   CREATE SEQUENCE public.shopping_items_id_item_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.shopping_items_id_item_seq;
       public          postgres    false    324            �           0    0    shopping_items_id_item_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.shopping_items_id_item_seq OWNED BY public.shopping_items.id_item;
          public          postgres    false    325            F           1259    17972    shopping_list_types    TABLE     �   CREATE TABLE public.shopping_list_types (
    id_shopping_list_type integer NOT NULL,
    type_name_en character varying(255) NOT NULL,
    type_name_vn character varying(255) NOT NULL,
    icon_url text
);
 '   DROP TABLE public.shopping_list_types;
       public         heap    postgres    false            G           1259    17977 -   shopping_list_types_id_shopping_list_type_seq    SEQUENCE     �   CREATE SEQUENCE public.shopping_list_types_id_shopping_list_type_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 D   DROP SEQUENCE public.shopping_list_types_id_shopping_list_type_seq;
       public          postgres    false    326            �           0    0 -   shopping_list_types_id_shopping_list_type_seq    SEQUENCE OWNED BY        ALTER SEQUENCE public.shopping_list_types_id_shopping_list_type_seq OWNED BY public.shopping_list_types.id_shopping_list_type;
          public          postgres    false    327            H           1259    17978    shopping_lists    TABLE     �  CREATE TABLE public.shopping_lists (
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
 "   DROP TABLE public.shopping_lists;
       public         heap    postgres    false    1249    1249            I           1259    17986    shopping_lists_id_list_seq    SEQUENCE     �   CREATE SEQUENCE public.shopping_lists_id_list_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.shopping_lists_id_list_seq;
       public          postgres    false    328            �           0    0    shopping_lists_id_list_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.shopping_lists_id_list_seq OWNED BY public.shopping_lists.id_list;
          public          postgres    false    329            J           1259    17987    subject    TABLE     �  CREATE TABLE public.subject (
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
    DROP TABLE public.subject;
       public         heap    postgres    false            K           1259    17993    subject_id_subject_seq    SEQUENCE     �   CREATE SEQUENCE public.subject_id_subject_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.subject_id_subject_seq;
       public          postgres    false    330            �           0    0    subject_id_subject_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.subject_id_subject_seq OWNED BY public.subject.id_subject;
          public          postgres    false    331            L           1259    17994    subjects_id_subject_seq    SEQUENCE     �   CREATE SEQUENCE public.subjects_id_subject_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;
 .   DROP SEQUENCE public.subjects_id_subject_seq;
       public          postgres    false            M           1259    17995    user_info_view    VIEW     �   CREATE VIEW public.user_info_view AS
 SELECT users.email,
    users.phone,
    users.language,
    users.firstname,
    users.lastname
   FROM public.users;
 !   DROP VIEW public.user_info_view;
       public          postgres    false    223    223    223    223    223            N           1259    17999 	   utilities    TABLE     �  CREATE TABLE public.utilities (
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
    DROP TABLE public.utilities;
       public         heap    postgres    false            O           1259    18008    utilities_id_utility_seq    SEQUENCE     �   CREATE SEQUENCE public.utilities_id_utility_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.utilities_id_utility_seq;
       public          postgres    false    334            �           0    0    utilities_id_utility_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.utilities_id_utility_seq OWNED BY public.utilities.id_utility;
          public          postgres    false    335            P           1259    18009    utilities_type    TABLE     �   CREATE TABLE public.utilities_type (
    id_utilities_type integer NOT NULL,
    name_en character varying(255) NOT NULL,
    name_vn character varying(255) NOT NULL
);
 "   DROP TABLE public.utilities_type;
       public         heap    postgres    false            Q           1259    18014 $   utilities_type_id_utilities_type_seq    SEQUENCE     �   CREATE SEQUENCE public.utilities_type_id_utilities_type_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ;   DROP SEQUENCE public.utilities_type_id_utilities_type_seq;
       public          postgres    false    336            �           0    0 $   utilities_type_id_utilities_type_seq    SEQUENCE OWNED BY     m   ALTER SEQUENCE public.utilities_type_id_utilities_type_seq OWNED BY public.utilities_type.id_utilities_type;
          public          postgres    false    337            R           1259    18015 	   v_user_id    TABLE     4   CREATE TABLE public.v_user_id (
    id_user uuid
);
    DROP TABLE public.v_user_id;
       public         heap    postgres    false            S           1259    18018    view_all_users_details    VIEW     S  CREATE VIEW public.view_all_users_details AS
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
 )   DROP VIEW public.view_all_users_details;
       public          postgres    false    223    223    223    223    223    223    223    223    223    223    223    223    223    1267            T           1259    18022 
   view_users    VIEW     �   CREATE VIEW public.view_users AS
 SELECT users.id_user,
    users.email,
    users.phone,
    users.language,
    users.firstname,
    users.lastname,
    users.avatar
   FROM public.users;
    DROP VIEW public.view_users;
       public          postgres    false    223    223    223    223    223    223    223            �           2604    18026    article id_article    DEFAULT     x   ALTER TABLE ONLY public.article ALTER COLUMN id_article SET DEFAULT nextval('public.article_id_article_seq'::regclass);
 A   ALTER TABLE public.article ALTER COLUMN id_article DROP DEFAULT;
       public          postgres    false    232    229            �           2604    18027 $   article_category id_article_category    DEFAULT     �   ALTER TABLE ONLY public.article_category ALTER COLUMN id_article_category SET DEFAULT nextval('public.article_category_id_article_category_seq'::regclass);
 S   ALTER TABLE public.article_category ALTER COLUMN id_article_category DROP DEFAULT;
       public          postgres    false    231    230            �           2604    18028     category_event id_category_event    DEFAULT     �   ALTER TABLE ONLY public.category_event ALTER COLUMN id_category_event SET DEFAULT nextval('public.category_event_id_category_event_seq'::regclass);
 O   ALTER TABLE public.category_event ALTER COLUMN id_category_event DROP DEFAULT;
       public          postgres    false    237    236                       2604    18029    checklist id_checklist    DEFAULT     �   ALTER TABLE ONLY public.checklist ALTER COLUMN id_checklist SET DEFAULT nextval('public.checklist_id_checklist_seq'::regclass);
 E   ALTER TABLE public.checklist ALTER COLUMN id_checklist DROP DEFAULT;
       public          postgres    false    239    238                       2604    18030     checklist_type id_checklist_type    DEFAULT     �   ALTER TABLE ONLY public.checklist_type ALTER COLUMN id_checklist_type SET DEFAULT nextval('public.checklist_type_id_checklist_type_seq'::regclass);
 O   ALTER TABLE public.checklist_type ALTER COLUMN id_checklist_type DROP DEFAULT;
       public          postgres    false    241    240                       2604    18031    enclosure id_enclosure    DEFAULT     �   ALTER TABLE ONLY public.enclosure ALTER COLUMN id_enclosure SET DEFAULT nextval('public.enclosure_id_enclosure_seq'::regclass);
 E   ALTER TABLE public.enclosure ALTER COLUMN id_enclosure DROP DEFAULT;
       public          postgres    false    247    246                       2604    18032 -   family_extra_packages id_family_extra_package    DEFAULT     �   ALTER TABLE ONLY public.family_extra_packages ALTER COLUMN id_family_extra_package SET DEFAULT nextval('public.family_extra_packages_id_family_extra_package_seq'::regclass);
 \   ALTER TABLE public.family_extra_packages ALTER COLUMN id_family_extra_package DROP DEFAULT;
       public          postgres    false    249    248                       2604    18033    family_invitation id_invitation    DEFAULT     �   ALTER TABLE ONLY public.family_invitation ALTER COLUMN id_invitation SET DEFAULT nextval('public.family_invitation_id_invitation_seq'::regclass);
 N   ALTER TABLE public.family_invitation ALTER COLUMN id_invitation DROP DEFAULT;
       public          postgres    false    254    253                       2604    18034    family_roles id_family_role    DEFAULT     �   ALTER TABLE ONLY public.family_roles ALTER COLUMN id_family_role SET DEFAULT nextval('public.family_roles_id_family_role_seq'::regclass);
 J   ALTER TABLE public.family_roles ALTER COLUMN id_family_role DROP DEFAULT;
       public          postgres    false    256    255                       2604    18035    feedbacks id_feedback    DEFAULT     ~   ALTER TABLE ONLY public.feedbacks ALTER COLUMN id_feedback SET DEFAULT nextval('public.feedbacks_id_feedback_seq'::regclass);
 D   ALTER TABLE public.feedbacks ALTER COLUMN id_feedback DROP DEFAULT;
       public          postgres    false    259    258            �           2604    18036    finance_assets id_asset    DEFAULT     �   ALTER TABLE ONLY public.finance_assets ALTER COLUMN id_asset SET DEFAULT nextval('public.finance_assets_id_asset_seq'::regclass);
 F   ALTER TABLE public.finance_assets ALTER COLUMN id_asset DROP DEFAULT;
       public          postgres    false    261    225                       2604    18037 "   finance_expenditure id_expenditure    DEFAULT     �   ALTER TABLE ONLY public.finance_expenditure ALTER COLUMN id_expenditure SET DEFAULT nextval('public.finance_expenditure_id_expenditure_seq'::regclass);
 Q   ALTER TABLE public.finance_expenditure ALTER COLUMN id_expenditure DROP DEFAULT;
       public          postgres    false    264    262            !           2604    18038 ,   finance_expenditure_type id_expenditure_type    DEFAULT     �   ALTER TABLE ONLY public.finance_expenditure_type ALTER COLUMN id_expenditure_type SET DEFAULT nextval('public.finance_expenditure_type_id_expenditure_type_seq'::regclass);
 [   ALTER TABLE public.finance_expenditure_type ALTER COLUMN id_expenditure_type DROP DEFAULT;
       public          postgres    false    266    265            "           2604    18039    finance_income id_income    DEFAULT     �   ALTER TABLE ONLY public.finance_income ALTER COLUMN id_income SET DEFAULT nextval('public.finance_income_id_income_seq'::regclass);
 G   ALTER TABLE public.finance_income ALTER COLUMN id_income DROP DEFAULT;
       public          postgres    false    268    267            (           2604    18040 &   finance_income_source id_income_source    DEFAULT     �   ALTER TABLE ONLY public.finance_income_source ALTER COLUMN id_income_source SET DEFAULT nextval('public.finance_income_source_id_income_source_seq'::regclass);
 U   ALTER TABLE public.finance_income_source ALTER COLUMN id_income_source DROP DEFAULT;
       public          postgres    false    271    270            )           2604    18041    financial_summary id_summary    DEFAULT     �   ALTER TABLE ONLY public.financial_summary ALTER COLUMN id_summary SET DEFAULT nextval('public.financial_summary_summary_id_seq'::regclass);
 K   ALTER TABLE public.financial_summary ALTER COLUMN id_summary DROP DEFAULT;
       public          postgres    false    273    272            4           2604    18042    guide_items id_guide_item    DEFAULT     �   ALTER TABLE ONLY public.guide_items ALTER COLUMN id_guide_item SET DEFAULT nextval('public.guide_items_id_guide_item_seq'::regclass);
 H   ALTER TABLE public.guide_items ALTER COLUMN id_guide_item DROP DEFAULT;
       public          postgres    false    276    275            5           2604    18043 4   household_item_categories id_household_item_category    DEFAULT     �   ALTER TABLE ONLY public.household_item_categories ALTER COLUMN id_household_item_category SET DEFAULT nextval('public.household_item_categories_id_household_item_category_seq'::regclass);
 c   ALTER TABLE public.household_item_categories ALTER COLUMN id_household_item_category DROP DEFAULT;
       public          postgres    false    282    280            �           2604    18044 !   household_items id_household_item    DEFAULT     �   ALTER TABLE ONLY public.household_items ALTER COLUMN id_household_item SET DEFAULT nextval('public.household_items_id_household_item_seq'::regclass);
 P   ALTER TABLE public.household_items ALTER COLUMN id_household_item DROP DEFAULT;
       public          postgres    false    283    228            6           2604    18045    invoice id_invoice    DEFAULT     x   ALTER TABLE ONLY public.invoice ALTER COLUMN id_invoice SET DEFAULT nextval('public.invoice_id_invoice_seq'::regclass);
 A   ALTER TABLE public.invoice ALTER COLUMN id_invoice DROP DEFAULT;
       public          postgres    false    285    284            ;           2604    18046    invoice_items id_item    DEFAULT     ~   ALTER TABLE ONLY public.invoice_items ALTER COLUMN id_item SET DEFAULT nextval('public.invoice_items_id_item_seq'::regclass);
 D   ALTER TABLE public.invoice_items ALTER COLUMN id_item DROP DEFAULT;
       public          postgres    false    287    286            =           2604    18047    invoice_type id_invoice_type    DEFAULT     �   ALTER TABLE ONLY public.invoice_type ALTER COLUMN id_invoice_type SET DEFAULT nextval('public.invoice_type_id_invoice_type_seq'::regclass);
 K   ALTER TABLE public.invoice_type ALTER COLUMN id_invoice_type DROP DEFAULT;
       public          postgres    false    289    288            C           2604    18048 
   otp otp_id    DEFAULT     i   ALTER TABLE ONLY public.otp ALTER COLUMN otp_id SET DEFAULT nextval('public.otp_otp_id_seq2'::regclass);
 9   ALTER TABLE public.otp ALTER COLUMN otp_id DROP DEFAULT;
       public          postgres    false    303    300            G           2604    18049    package_combo id_combo_package    DEFAULT     �   ALTER TABLE ONLY public.package_combo ALTER COLUMN id_combo_package SET DEFAULT nextval('public.package_combo_id_combo_package_seq'::regclass);
 M   ALTER TABLE public.package_combo ALTER COLUMN id_combo_package DROP DEFAULT;
       public          postgres    false    305    304            L           2604    18050    package_extra id_extra_package    DEFAULT     �   ALTER TABLE ONLY public.package_extra ALTER COLUMN id_extra_package SET DEFAULT nextval('public.package_extra_id_extra_package_seq'::regclass);
 M   ALTER TABLE public.package_extra ALTER COLUMN id_extra_package DROP DEFAULT;
       public          postgres    false    308    307            Q           2604    18051    package_main id_main_package    DEFAULT     �   ALTER TABLE ONLY public.package_main ALTER COLUMN id_main_package SET DEFAULT nextval('public.package_main_id_main_package_seq'::regclass);
 K   ALTER TABLE public.package_main ALTER COLUMN id_main_package DROP DEFAULT;
       public          postgres    false    310    309            V           2604    18052 "   payment_history id_payment_history    DEFAULT     �   ALTER TABLE ONLY public.payment_history ALTER COLUMN id_payment_history SET DEFAULT nextval('public.payment_history_id_payment_history_seq'::regclass);
 Q   ALTER TABLE public.payment_history ALTER COLUMN id_payment_history DROP DEFAULT;
       public          postgres    false    312    311            Y           2604    18053    payment_method id    DEFAULT     w   ALTER TABLE ONLY public.payment_method ALTER COLUMN id SET DEFAULT nextval('public.payment_method_id_seq1'::regclass);
 @   ALTER TABLE public.payment_method ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    315    313            \           2604    18054    room id_room    DEFAULT     l   ALTER TABLE ONLY public.room ALTER COLUMN id_room SET DEFAULT nextval('public.room_id_room_seq'::regclass);
 ;   ALTER TABLE public.room ALTER COLUMN id_room DROP DEFAULT;
       public          postgres    false    321    320            _           2604    18055     shopping_item_types id_item_type    DEFAULT     �   ALTER TABLE ONLY public.shopping_item_types ALTER COLUMN id_item_type SET DEFAULT nextval('public.shopping_item_types_id_item_type_seq'::regclass);
 O   ALTER TABLE public.shopping_item_types ALTER COLUMN id_item_type DROP DEFAULT;
       public          postgres    false    323    322            `           2604    18056    shopping_items id_item    DEFAULT     �   ALTER TABLE ONLY public.shopping_items ALTER COLUMN id_item SET DEFAULT nextval('public.shopping_items_id_item_seq'::regclass);
 E   ALTER TABLE public.shopping_items ALTER COLUMN id_item DROP DEFAULT;
       public          postgres    false    325    324            h           2604    18057 )   shopping_list_types id_shopping_list_type    DEFAULT     �   ALTER TABLE ONLY public.shopping_list_types ALTER COLUMN id_shopping_list_type SET DEFAULT nextval('public.shopping_list_types_id_shopping_list_type_seq'::regclass);
 X   ALTER TABLE public.shopping_list_types ALTER COLUMN id_shopping_list_type DROP DEFAULT;
       public          postgres    false    327    326            i           2604    18058    shopping_lists id_list    DEFAULT     �   ALTER TABLE ONLY public.shopping_lists ALTER COLUMN id_list SET DEFAULT nextval('public.shopping_lists_id_list_seq'::regclass);
 E   ALTER TABLE public.shopping_lists ALTER COLUMN id_list DROP DEFAULT;
       public          postgres    false    329    328            m           2604    18059    subject id_subject    DEFAULT     x   ALTER TABLE ONLY public.subject ALTER COLUMN id_subject SET DEFAULT nextval('public.subject_id_subject_seq'::regclass);
 A   ALTER TABLE public.subject ALTER COLUMN id_subject DROP DEFAULT;
       public          postgres    false    331    330            o           2604    18060    utilities id_utility    DEFAULT     |   ALTER TABLE ONLY public.utilities ALTER COLUMN id_utility SET DEFAULT nextval('public.utilities_id_utility_seq'::regclass);
 C   ALTER TABLE public.utilities ALTER COLUMN id_utility DROP DEFAULT;
       public          postgres    false    335    334            t           2604    18061     utilities_type id_utilities_type    DEFAULT     �   ALTER TABLE ONLY public.utilities_type ALTER COLUMN id_utilities_type SET DEFAULT nextval('public.utilities_type_id_utilities_type_seq'::regclass);
 O   ALTER TABLE public.utilities_type ALTER COLUMN id_utilities_type DROP DEFAULT;
       public          postgres    false    337    336                      0    17638    article 
   TABLE DATA           �   COPY public.article (id_article, id_article_category, id_enclosure, title, link, content, "contentSnippet", guid, "isoDate", "pubDate") FROM stdin;
    public          postgres    false    229   �c                0    17652    article_category 
   TABLE DATA           E   COPY public.article_category (id_article_category, name) FROM stdin;
    public          postgres    false    230   ��                0    17661    calendar 
   TABLE DATA           �   COPY public.calendar (id_calendar, id_family, created_at, updated_at, time_start, time_end, color, is_all_day, category, recurrence_id, title, description, location, start_timezone, end_timezone, recurrence_exception, recurrence_rule) FROM stdin;
    public          postgres    false    234   ��                0    17673    category_event 
   TABLE DATA           l   COPY public.category_event (id_category_event, id_family, created_at, title, color, updated_at) FROM stdin;
    public          postgres    false    236   ;�                0    17683 	   checklist 
   TABLE DATA           �   COPY public.checklist (id_checklist, id_family, task_name, description, is_completed, due_date, created_at, updated_at, is_notified_3_days_before, is_notified_1_day_before, is_notified_on_due_date, id_checklist_type) FROM stdin;
    public          postgres    false    238   "�                0    17697    checklist_type 
   TABLE DATA           W   COPY public.checklist_type (id_checklist_type, name_en, name_vn, icon_url) FROM stdin;
    public          postgres    false    240   ��                0    17703    discount 
   TABLE DATA           X   COPY public.discount (code, percentage, expired_at, created_at, updated_at) FROM stdin;
    public          postgres    false    242   ��                0    17710    education_progress 
   TABLE DATA           �   COPY public.education_progress (id_education_progress, id_family, id_user, created_at, updated_at, title, progress_notes, school_info) FROM stdin;
    public          postgres    false    244   ��                0    17719 	   enclosure 
   TABLE DATA           D   COPY public.enclosure (id_enclosure, type, length, url) FROM stdin;
    public          postgres    false    246   ��                0    17506    family 
   TABLE DATA           ~   COPY public.family (id_family, quantity, description, created_at, updated_at, name, avatar, owner_id, expired_at) FROM stdin;
    public          postgres    false    227   �B                0    17725    family_extra_packages 
   TABLE DATA           e   COPY public.family_extra_packages (id_family_extra_package, id_family, id_extra_package) FROM stdin;
    public          postgres    false    248   �D                0    17733    family_invitation 
   TABLE DATA           K   COPY public.family_invitation (id_invitation, id_family, code) FROM stdin;
    public          postgres    false    253   NE      !          0    17739    family_roles 
   TABLE DATA           R   COPY public.family_roles (id_family_role, role_name_vn, role_name_en) FROM stdin;
    public          postgres    false    255   hF      #          0    17745    feedback_metadata 
   TABLE DATA           \   COPY public.feedback_metadata (metadata_key, "totalFeedbacks", "averageRating") FROM stdin;
    public          postgres    false    257   fH      $          0    17752 	   feedbacks 
   TABLE DATA           b   COPY public.feedbacks (id_feedback, comment, rating, id_user, created_at, updated_at) FROM stdin;
    public          postgres    false    258   �H                0    17482    finance_assets 
   TABLE DATA           �   COPY public.finance_assets (id_asset, id_family, name, purchase_date, description, created_at, updated_at, image_url, value) FROM stdin;
    public          postgres    false    225   �P      (          0    17762    finance_expenditure 
   TABLE DATA           �   COPY public.finance_expenditure (id_expenditure, id_family, description, id_created_by, id_expenditure_type, created_at, updated_at, amount, image_url, expenditure_date) FROM stdin;
    public          postgres    false    262   �R      +          0    17774    finance_expenditure_type 
   TABLE DATA           e   COPY public.finance_expenditure_type (id_family, id_expenditure_type, expense_type_name) FROM stdin;
    public          postgres    false    265   �[      -          0    17778    finance_income 
   TABLE DATA           �   COPY public.finance_income (id_income, id_family, id_created_by, id_income_source, description, created_at, updated_at, amount, income_date) FROM stdin;
    public          postgres    false    267   /\      0          0    17790    finance_income_source 
   TABLE DATA           `   COPY public.finance_income_source (id_family, id_income_source, income_source_name) FROM stdin;
    public          postgres    false    270   �i      2          0    17794    financial_summary 
   TABLE DATA           �   COPY public.financial_summary (id_summary, id_family, summary_date, total_income, total_expenditure, daily_balance, weekly_balance, monthly_balance, yearly_balance, current_balance) FROM stdin;
    public          postgres    false    272   %j      4          0    17805    flow_watermarks 
   TABLE DATA           :   COPY public.flow_watermarks (slot, watermark) FROM stdin;
    public          postgres    false    274   ~j      5          0    17810    guide_items 
   TABLE DATA           |   COPY public.guide_items (created_at, updated_at, id_family, is_shared, id_guide_item, steps, name, description) FROM stdin;
    public          postgres    false    275   �j      8          0    17820    household_consumable_items 
   TABLE DATA           j   COPY public.household_consumable_items (id_household_item, quantity, threshold, expired_date) FROM stdin;
    public          postgres    false    278   n      9          0    17823    household_durable_items 
   TABLE DATA           O   COPY public.household_durable_items (id_household_item, condition) FROM stdin;
    public          postgres    false    279   Tn      :          0    17826    household_item_categories 
   TABLE DATA           ^   COPY public.household_item_categories (id_household_item_category, category_name) FROM stdin;
    public          postgres    false    280   �n                0    17525    household_items 
   TABLE DATA           �   COPY public.household_items (id_household_item, id_family, item_name, id_category, id_room, description, item_imageurl, created_at, updated_at) FROM stdin;
    public          postgres    false    228   o      >          0    17832    invoice 
   TABLE DATA           �   COPY public.invoice (id_invoice, id_family, id_invoice_type, invoice_date, total_amount, description, imageurl, created_at, updated_at, invoice_name, tax_amount, amount) FROM stdin;
    public          postgres    false    284   Pp      @          0    17842    invoice_items 
   TABLE DATA           o   COPY public.invoice_items (id_item, id_invoice, item_description, quantity, unit_price, item_name) FROM stdin;
    public          postgres    false    286   Cq      B          0    17849    invoice_type 
   TABLE DATA           M   COPY public.invoice_type (id_invoice_type, type_name, id_family) FROM stdin;
    public          postgres    false    288   �q      D          0    17853    key 
   TABLE DATA           &   COPY public.key (id, key) FROM stdin;
    public          postgres    false    290   9r                0    17454    member_family 
   TABLE DATA           m   COPY public.member_family (id_user, id_family, created_at, updated_at, id, role, id_family_role) FROM stdin;
    public          postgres    false    222   \r      J          0    17863    order 
   TABLE DATA           �   COPY public."order" (id_family, status, id_package_main, id_package_extra, id_package_combo, method, created_at, updated_at, id_order, id_user, price, bank_code) FROM stdin;
    public          postgres    false    296   �s      N          0    17876    otp 
   TABLE DATA           b   COPY public.otp (otp_id, id_user, code, created_at, updated_at, expired_at, otp_type) FROM stdin;
    public          postgres    false    300   �v      R          0    17887    package_combo 
   TABLE DATA           v   COPY public.package_combo (id_combo_package, name, description, is_active, created_at, updated_at, price) FROM stdin;
    public          postgres    false    304   �z      T          0    17897    package_combo_package_extra 
   TABLE DATA           Y   COPY public.package_combo_package_extra (package_combo_id, package_extra_id) FROM stdin;
    public          postgres    false    306   h{      U          0    17900    package_extra 
   TABLE DATA           v   COPY public.package_extra (id_extra_package, name, description, is_active, created_at, updated_at, price) FROM stdin;
    public          postgres    false    307   �{      W          0    17910    package_main 
   TABLE DATA           �   COPY public.package_main (id_main_package, name, description, is_active, duration_months, created_at, updated_at, price) FROM stdin;
    public          postgres    false    309   g}      Y          0    17920    payment_history 
   TABLE DATA           z   COPY public.payment_history (id_payment_history, payment_method, created_at, id_user, type, amount, id_order) FROM stdin;
    public          postgres    false    311   p~      [          0    17928    payment_method 
   TABLE DATA           C   COPY public.payment_method (id, name, code, url_image) FROM stdin;
    public          postgres    false    313         _          0    17936    refresh_token 
   TABLE DATA           [   COPY public.refresh_token (refresh_token, id_user, created_at, expired_at, id) FROM stdin;
    public          postgres    false    317   6      b          0    17945    room 
   TABLE DATA           a   COPY public.room (id_room, id_family, room_name, created_at, updated_at, room_image) FROM stdin;
    public          postgres    false    320   s�      d          0    17953    shopping_item_types 
   TABLE DATA           k   COPY public.shopping_item_types (id_item_type, item_type_name_en, item_type_name_vn, icon_url) FROM stdin;
    public          postgres    false    322   u�      f          0    17959    shopping_items 
   TABLE DATA           �   COPY public.shopping_items (id_item, id_list, id_item_type, item_name, description, quantity, is_purchased, priority_level, reminder_date, created_at, updated_at, price) FROM stdin;
    public          postgres    false    324   J�      h          0    17972    shopping_list_types 
   TABLE DATA           j   COPY public.shopping_list_types (id_shopping_list_type, type_name_en, type_name_vn, icon_url) FROM stdin;
    public          postgres    false    326   ��      j          0    17978    shopping_lists 
   TABLE DATA           �   COPY public.shopping_lists (id_list, id_family, title, description, created_at, updated_at, id_shopping_list_type, status, id_expenditure) FROM stdin;
    public          postgres    false    328   t�      l          0    17987    subject 
   TABLE DATA           �   COPY public.subject (id_subject, id_education_progress, subject_name, description, component_scores, status, midterm_score, final_score, bonus_score) FROM stdin;
    public          postgres    false    330   �                0    17462    users 
   TABLE DATA           �   COPY public.users (id_user, email, phone, password, language, twofa, created_at, updated_at, isphoneverified, isadmin, firstname, lastname, isemailverified, avatar, login_type, birthdate, genre, is_banned) FROM stdin;
    public          postgres    false    223   ��      o          0    17999 	   utilities 
   TABLE DATA           �   COPY public.utilities (id_utility, id_family, id_utilities_type, description, image_url, value, created_at, updated_at, id_expenditure) FROM stdin;
    public          postgres    false    334   ��      q          0    18009    utilities_type 
   TABLE DATA           M   COPY public.utilities_type (id_utilities_type, name_en, name_vn) FROM stdin;
    public          postgres    false    336   ��      s          0    18015 	   v_user_id 
   TABLE DATA           ,   COPY public.v_user_id (id_user) FROM stdin;
    public          postgres    false    338   ��      �           0    0 (   article_category_id_article_category_seq    SEQUENCE SET     W   SELECT pg_catalog.setval('public.article_category_id_article_category_seq', 21, true);
          public          postgres    false    231            �           0    0    article_id_article_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.article_id_article_seq', 3352, true);
          public          postgres    false    232            �           0    0    calendar_id_calendar_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.calendar_id_calendar_seq', 42, true);
          public          postgres    false    233            �           0    0    calendar_id_calendar_seq1    SEQUENCE SET     I   SELECT pg_catalog.setval('public.calendar_id_calendar_seq1', 143, true);
          public          postgres    false    235            �           0    0 $   category_event_id_category_event_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.category_event_id_category_event_seq', 34, true);
          public          postgres    false    237            �           0    0    checklist_id_checklist_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.checklist_id_checklist_seq', 84, true);
          public          postgres    false    239            �           0    0 $   checklist_type_id_checklist_type_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.checklist_type_id_checklist_type_seq', 1, true);
          public          postgres    false    241            �           0    0 ,   education_progress_id_education_progress_seq    SEQUENCE SET     [   SELECT pg_catalog.setval('public.education_progress_id_education_progress_seq', 94, true);
          public          postgres    false    243            �           0    0 -   education_progress_id_education_progress_seq1    SEQUENCE SET     [   SELECT pg_catalog.setval('public.education_progress_id_education_progress_seq1', 7, true);
          public          postgres    false    245            �           0    0    enclosure_id_enclosure_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.enclosure_id_enclosure_seq', 1744, true);
          public          postgres    false    247            �           0    0 1   family_extra_packages_id_family_extra_package_seq    SEQUENCE SET     `   SELECT pg_catalog.setval('public.family_extra_packages_id_family_extra_package_seq', 27, true);
          public          postgres    false    249            �           0    0    family_id_family_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.family_id_family_seq', 2, true);
          public          postgres    false    226            �           0    0    family_id_family_seq1    SEQUENCE SET     D   SELECT pg_catalog.setval('public.family_id_family_seq1', 1, false);
          public          postgres    false    250            �           0    0    family_id_family_seq2    SEQUENCE SET     D   SELECT pg_catalog.setval('public.family_id_family_seq2', 1, false);
          public          postgres    false    251            �           0    0    family_id_sequence    SEQUENCE SET     A   SELECT pg_catalog.setval('public.family_id_sequence', 1, false);
          public          postgres    false    252            �           0    0 #   family_invitation_id_invitation_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('public.family_invitation_id_invitation_seq', 10, true);
          public          postgres    false    254            �           0    0    family_roles_id_family_role_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.family_roles_id_family_role_seq', 39, true);
          public          postgres    false    256            �           0    0    feedbacks_id_feedback_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.feedbacks_id_feedback_seq', 98, true);
          public          postgres    false    259            �           0    0    finance_assets_asset_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.finance_assets_asset_id_seq', 6, true);
          public          postgres    false    260            �           0    0    finance_assets_id_asset_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.finance_assets_id_asset_seq', 12, true);
          public          postgres    false    261            �           0    0 &   finance_expenditure_expenditure_id_seq    SEQUENCE SET     V   SELECT pg_catalog.setval('public.finance_expenditure_expenditure_id_seq', 247, true);
          public          postgres    false    263            �           0    0 &   finance_expenditure_id_expenditure_seq    SEQUENCE SET     V   SELECT pg_catalog.setval('public.finance_expenditure_id_expenditure_seq', 130, true);
          public          postgres    false    264            �           0    0 0   finance_expenditure_type_id_expenditure_type_seq    SEQUENCE SET     _   SELECT pg_catalog.setval('public.finance_expenditure_type_id_expenditure_type_seq', 11, true);
          public          postgres    false    266            �           0    0    finance_income_id_income_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.finance_income_id_income_seq', 265, true);
          public          postgres    false    268            �           0    0    finance_income_income_id_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.finance_income_income_id_seq', 194, true);
          public          postgres    false    269            �           0    0 *   finance_income_source_id_income_source_seq    SEQUENCE SET     Y   SELECT pg_catalog.setval('public.finance_income_source_id_income_source_seq', 35, true);
          public          postgres    false    271            �           0    0     financial_summary_summary_id_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.financial_summary_summary_id_seq', 5, true);
          public          postgres    false    273            �           0    0    guide_items_id_guide_item_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.guide_items_id_guide_item_seq', 14, true);
          public          postgres    false    276            �           0    0    guide_items_id_item_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.guide_items_id_item_seq', 1, false);
          public          postgres    false    277            �           0    0 )   household_item_categories_category_id_seq    SEQUENCE SET     W   SELECT pg_catalog.setval('public.household_item_categories_category_id_seq', 8, true);
          public          postgres    false    281            �           0    0 8   household_item_categories_id_household_item_category_seq    SEQUENCE SET     g   SELECT pg_catalog.setval('public.household_item_categories_id_household_item_category_seq', 1, false);
          public          postgres    false    282            �           0    0 %   household_items_id_household_item_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.household_items_id_household_item_seq', 24, true);
          public          postgres    false    283            �           0    0    invoice_id_invoice_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.invoice_id_invoice_seq', 4, true);
          public          postgres    false    285            �           0    0    invoice_items_id_item_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.invoice_items_id_item_seq', 13, true);
          public          postgres    false    287            �           0    0     invoice_type_id_invoice_type_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.invoice_type_id_invoice_type_seq', 28, true);
          public          postgres    false    289            �           0    0 
   key_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.key_id_seq', 1, false);
          public          postgres    false    291            �           0    0    key_id_seq1    SEQUENCE SET     :   SELECT pg_catalog.setval('public.key_id_seq1', 1, false);
          public          postgres    false    292            �           0    0    member_family_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.member_family_id_seq', 18, true);
          public          postgres    false    221            �           0    0    member_family_id_seq1    SEQUENCE SET     D   SELECT pg_catalog.setval('public.member_family_id_seq1', 1, false);
          public          postgres    false    293            �           0    0    member_family_id_seq2    SEQUENCE SET     C   SELECT pg_catalog.setval('public.member_family_id_seq2', 3, true);
          public          postgres    false    294            �           0    0     notification_id_notification_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.notification_id_notification_seq', 1, false);
          public          postgres    false    295            �           0    0    order_family_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.order_family_id_seq', 1, false);
          public          postgres    false    297            �           0    0    order_id_order_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.order_id_order_seq', 1, false);
          public          postgres    false    298            �           0    0    order_id_order_seq1    SEQUENCE SET     B   SELECT pg_catalog.setval('public.order_id_order_seq1', 1, false);
          public          postgres    false    299            �           0    0    otp_otp_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.otp_otp_id_seq', 1, false);
          public          postgres    false    301            �           0    0    otp_otp_id_seq1    SEQUENCE SET     >   SELECT pg_catalog.setval('public.otp_otp_id_seq1', 1, false);
          public          postgres    false    302            �           0    0    otp_otp_id_seq2    SEQUENCE SET     >   SELECT pg_catalog.setval('public.otp_otp_id_seq2', 44, true);
          public          postgres    false    303            �           0    0 "   package_combo_id_combo_package_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.package_combo_id_combo_package_seq', 8, true);
          public          postgres    false    305            �           0    0 "   package_extra_id_extra_package_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('public.package_extra_id_extra_package_seq', 7, true);
          public          postgres    false    308            �           0    0     package_main_id_main_package_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.package_main_id_main_package_seq', 6, true);
          public          postgres    false    310            �           0    0 &   payment_history_id_payment_history_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.payment_history_id_payment_history_seq', 4, true);
          public          postgres    false    312            �           0    0    payment_method_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.payment_method_id_seq', 1, false);
          public          postgres    false    314            �           0    0    payment_method_id_seq1    SEQUENCE SET     E   SELECT pg_catalog.setval('public.payment_method_id_seq1', 1, false);
          public          postgres    false    315            �           0    0    refresh_token_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.refresh_token_id_seq', 1102, true);
          public          postgres    false    316            �           0    0    refresh_token_id_seq1    SEQUENCE SET     D   SELECT pg_catalog.setval('public.refresh_token_id_seq1', 1, false);
          public          postgres    false    318            �           0    0    refresh_token_id_seq2    SEQUENCE SET     G   SELECT pg_catalog.setval('public.refresh_token_id_seq2', 27522, true);
          public          postgres    false    319            �           0    0    room_id_room_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.room_id_room_seq', 22, true);
          public          postgres    false    321            �           0    0 $   shopping_item_types_id_item_type_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.shopping_item_types_id_item_type_seq', 40, true);
          public          postgres    false    323            �           0    0    shopping_items_id_item_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.shopping_items_id_item_seq', 4, true);
          public          postgres    false    325            �           0    0 -   shopping_list_types_id_shopping_list_type_seq    SEQUENCE SET     [   SELECT pg_catalog.setval('public.shopping_list_types_id_shopping_list_type_seq', 6, true);
          public          postgres    false    327            �           0    0    shopping_lists_id_list_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.shopping_lists_id_list_seq', 5, true);
          public          postgres    false    329            �           0    0    subject_id_subject_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.subject_id_subject_seq', 129, true);
          public          postgres    false    331            �           0    0    subjects_id_subject_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.subjects_id_subject_seq', 1, false);
          public          postgres    false    332            �           0    0    utilities_id_utility_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.utilities_id_utility_seq', 11, true);
          public          postgres    false    335            �           0    0 $   utilities_type_id_utilities_type_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.utilities_type_id_utilities_type_seq', 13, true);
          public          postgres    false    337            �           2606    18063 '   discount PK_087926f6fec32903be3c8eedfae 
   CONSTRAINT     i   ALTER TABLE ONLY public.discount
    ADD CONSTRAINT "PK_087926f6fec32903be3c8eedfae" PRIMARY KEY (code);
 S   ALTER TABLE ONLY public.discount DROP CONSTRAINT "PK_087926f6fec32903be3c8eedfae";
       public            postgres    false    242            �           2606    18065 $   order PK_0b12b5d083c02c82edcdee13f75 
   CONSTRAINT     l   ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "PK_0b12b5d083c02c82edcdee13f75" PRIMARY KEY (id_order);
 R   ALTER TABLE ONLY public."order" DROP CONSTRAINT "PK_0b12b5d083c02c82edcdee13f75";
       public            postgres    false    296            �           2606    18067 (   feedbacks PK_11b07a1830cc1fc2b8ae7197ac6 
   CONSTRAINT     q   ALTER TABLE ONLY public.feedbacks
    ADD CONSTRAINT "PK_11b07a1830cc1fc2b8ae7197ac6" PRIMARY KEY (id_feedback);
 T   ALTER TABLE ONLY public.feedbacks DROP CONSTRAINT "PK_11b07a1830cc1fc2b8ae7197ac6";
       public            postgres    false    258            �           2606    18069 (   utilities PK_177a61f482f0e2368312707cc05 
   CONSTRAINT     p   ALTER TABLE ONLY public.utilities
    ADD CONSTRAINT "PK_177a61f482f0e2368312707cc05" PRIMARY KEY (id_utility);
 T   ALTER TABLE ONLY public.utilities DROP CONSTRAINT "PK_177a61f482f0e2368312707cc05";
       public            postgres    false    334            �           2606    18071 4   finance_income_source PK_18ba99e684774fff78e5149d356 
   CONSTRAINT     �   ALTER TABLE ONLY public.finance_income_source
    ADD CONSTRAINT "PK_18ba99e684774fff78e5149d356" PRIMARY KEY (id_income_source);
 `   ALTER TABLE ONLY public.finance_income_source DROP CONSTRAINT "PK_18ba99e684774fff78e5149d356";
       public            postgres    false    270            �           2606    18073 0   feedback_metadata PK_565b952b6d3ecf5667c97d5c632 
   CONSTRAINT     z   ALTER TABLE ONLY public.feedback_metadata
    ADD CONSTRAINT "PK_565b952b6d3ecf5667c97d5c632" PRIMARY KEY (metadata_key);
 \   ALTER TABLE ONLY public.feedback_metadata DROP CONSTRAINT "PK_565b952b6d3ecf5667c97d5c632";
       public            postgres    false    257            �           2606    18075 ,   package_extra PK_623b4f13a34cc1098cd669daf90 
   CONSTRAINT     z   ALTER TABLE ONLY public.package_extra
    ADD CONSTRAINT "PK_623b4f13a34cc1098cd669daf90" PRIMARY KEY (id_extra_package);
 X   ALTER TABLE ONLY public.package_extra DROP CONSTRAINT "PK_623b4f13a34cc1098cd669daf90";
       public            postgres    false    307            �           2606    18077 4   family_extra_packages PK_69bc37ea036c1e8eb36291a2e1b 
   CONSTRAINT     �   ALTER TABLE ONLY public.family_extra_packages
    ADD CONSTRAINT "PK_69bc37ea036c1e8eb36291a2e1b" PRIMARY KEY (id_family_extra_package);
 `   ALTER TABLE ONLY public.family_extra_packages DROP CONSTRAINT "PK_69bc37ea036c1e8eb36291a2e1b";
       public            postgres    false    248            �           2606    18079 &   subject PK_6a78d4af7c4f73c256c43f00c40 
   CONSTRAINT     n   ALTER TABLE ONLY public.subject
    ADD CONSTRAINT "PK_6a78d4af7c4f73c256c43f00c40" PRIMARY KEY (id_subject);
 R   ALTER TABLE ONLY public.subject DROP CONSTRAINT "PK_6a78d4af7c4f73c256c43f00c40";
       public            postgres    false    330            �           2606    18081 2   shopping_item_types PK_75783d4b61c293f19977ec0df97 
   CONSTRAINT     |   ALTER TABLE ONLY public.shopping_item_types
    ADD CONSTRAINT "PK_75783d4b61c293f19977ec0df97" PRIMARY KEY (id_item_type);
 ^   ALTER TABLE ONLY public.shopping_item_types DROP CONSTRAINT "PK_75783d4b61c293f19977ec0df97";
       public            postgres    false    322            �           2606    18083 -   shopping_items PK_763ad253fd4db5f02ef77d116e2 
   CONSTRAINT     r   ALTER TABLE ONLY public.shopping_items
    ADD CONSTRAINT "PK_763ad253fd4db5f02ef77d116e2" PRIMARY KEY (id_item);
 Y   ALTER TABLE ONLY public.shopping_items DROP CONSTRAINT "PK_763ad253fd4db5f02ef77d116e2";
       public            postgres    false    324            �           2606    18085 :   package_combo_package_extra PK_7bbf35b0b3c8487cd0f54fdc0d1 
   CONSTRAINT     �   ALTER TABLE ONLY public.package_combo_package_extra
    ADD CONSTRAINT "PK_7bbf35b0b3c8487cd0f54fdc0d1" PRIMARY KEY (package_combo_id, package_extra_id);
 f   ALTER TABLE ONLY public.package_combo_package_extra DROP CONSTRAINT "PK_7bbf35b0b3c8487cd0f54fdc0d1";
       public            postgres    false    306    306            �           2606    18087 /   article_category PK_80eca30c73666399732c971f800 
   CONSTRAINT     �   ALTER TABLE ONLY public.article_category
    ADD CONSTRAINT "PK_80eca30c73666399732c971f800" PRIMARY KEY (id_article_category);
 [   ALTER TABLE ONLY public.article_category DROP CONSTRAINT "PK_80eca30c73666399732c971f800";
       public            postgres    false    230            �           2606    18089 -   shopping_lists PK_925a29868d29f8fe35db867ca25 
   CONSTRAINT     r   ALTER TABLE ONLY public.shopping_lists
    ADD CONSTRAINT "PK_925a29868d29f8fe35db867ca25" PRIMARY KEY (id_list);
 Y   ALTER TABLE ONLY public.shopping_lists DROP CONSTRAINT "PK_925a29868d29f8fe35db867ca25";
       public            postgres    false    328            �           2606    18091 (   enclosure PK_9315ffa5c03ebfc99fcf98e7f72 
   CONSTRAINT     r   ALTER TABLE ONLY public.enclosure
    ADD CONSTRAINT "PK_9315ffa5c03ebfc99fcf98e7f72" PRIMARY KEY (id_enclosure);
 T   ALTER TABLE ONLY public.enclosure DROP CONSTRAINT "PK_9315ffa5c03ebfc99fcf98e7f72";
       public            postgres    false    246            �           2606    18093 *   guide_items PK_a75b121d60f690c17d2d04a8a10 
   CONSTRAINT     u   ALTER TABLE ONLY public.guide_items
    ADD CONSTRAINT "PK_a75b121d60f690c17d2d04a8a10" PRIMARY KEY (id_guide_item);
 V   ALTER TABLE ONLY public.guide_items DROP CONSTRAINT "PK_a75b121d60f690c17d2d04a8a10";
       public            postgres    false    275            �           2606    18095 +   package_main PK_bfb3c50b304b00c26e0ec78f9a0 
   CONSTRAINT     x   ALTER TABLE ONLY public.package_main
    ADD CONSTRAINT "PK_bfb3c50b304b00c26e0ec78f9a0" PRIMARY KEY (id_main_package);
 W   ALTER TABLE ONLY public.package_main DROP CONSTRAINT "PK_bfb3c50b304b00c26e0ec78f9a0";
       public            postgres    false    309            �           2606    18097 ,   package_combo PK_c1b0dda5fd378d1c8f7bf7009f8 
   CONSTRAINT     z   ALTER TABLE ONLY public.package_combo
    ADD CONSTRAINT "PK_c1b0dda5fd378d1c8f7bf7009f8" PRIMARY KEY (id_combo_package);
 X   ALTER TABLE ONLY public.package_combo DROP CONSTRAINT "PK_c1b0dda5fd378d1c8f7bf7009f8";
       public            postgres    false    304            �           2606    18099 &   article PK_c726e79e438d70a3b944687b642 
   CONSTRAINT     n   ALTER TABLE ONLY public.article
    ADD CONSTRAINT "PK_c726e79e438d70a3b944687b642" PRIMARY KEY (id_article);
 R   ALTER TABLE ONLY public.article DROP CONSTRAINT "PK_c726e79e438d70a3b944687b642";
       public            postgres    false    229            �           2606    18101 -   utilities_type PK_c7d13dacd4686cea97970e514de 
   CONSTRAINT     |   ALTER TABLE ONLY public.utilities_type
    ADD CONSTRAINT "PK_c7d13dacd4686cea97970e514de" PRIMARY KEY (id_utilities_type);
 Y   ALTER TABLE ONLY public.utilities_type DROP CONSTRAINT "PK_c7d13dacd4686cea97970e514de";
       public            postgres    false    336            �           2606    18103 .   payment_history PK_cc2ad855101207078a4fc56df20 
   CONSTRAINT     ~   ALTER TABLE ONLY public.payment_history
    ADD CONSTRAINT "PK_cc2ad855101207078a4fc56df20" PRIMARY KEY (id_payment_history);
 Z   ALTER TABLE ONLY public.payment_history DROP CONSTRAINT "PK_cc2ad855101207078a4fc56df20";
       public            postgres    false    311            �           2606    18105 2   shopping_list_types PK_ce7a3f1b907aa179f9b3894350d 
   CONSTRAINT     �   ALTER TABLE ONLY public.shopping_list_types
    ADD CONSTRAINT "PK_ce7a3f1b907aa179f9b3894350d" PRIMARY KEY (id_shopping_list_type);
 ^   ALTER TABLE ONLY public.shopping_list_types DROP CONSTRAINT "PK_ce7a3f1b907aa179f9b3894350d";
       public            postgres    false    326            �           2606    18107 7   finance_expenditure_type PK_f36d12035cd95ab15fb96f7e146 
   CONSTRAINT     �   ALTER TABLE ONLY public.finance_expenditure_type
    ADD CONSTRAINT "PK_f36d12035cd95ab15fb96f7e146" PRIMARY KEY (id_expenditure_type);
 c   ALTER TABLE ONLY public.finance_expenditure_type DROP CONSTRAINT "PK_f36d12035cd95ab15fb96f7e146";
       public            postgres    false    265            �           2606    18109 -   checklist_type PK_fc37505dfe98590ca60fc8963de 
   CONSTRAINT     |   ALTER TABLE ONLY public.checklist_type
    ADD CONSTRAINT "PK_fc37505dfe98590ca60fc8963de" PRIMARY KEY (id_checklist_type);
 Y   ALTER TABLE ONLY public.checklist_type DROP CONSTRAINT "PK_fc37505dfe98590ca60fc8963de";
       public            postgres    false    240            �           2606    18111 &   article REL_4a9c65f15f9d864613a9273aef 
   CONSTRAINT     k   ALTER TABLE ONLY public.article
    ADD CONSTRAINT "REL_4a9c65f15f9d864613a9273aef" UNIQUE (id_enclosure);
 R   ALTER TABLE ONLY public.article DROP CONSTRAINT "REL_4a9c65f15f9d864613a9273aef";
       public            postgres    false    229            �           2606    18113 4   family_extra_packages UQ_0711df05236f04c0d72a68664df 
   CONSTRAINT     �   ALTER TABLE ONLY public.family_extra_packages
    ADD CONSTRAINT "UQ_0711df05236f04c0d72a68664df" UNIQUE (id_family, id_extra_package);
 `   ALTER TABLE ONLY public.family_extra_packages DROP CONSTRAINT "UQ_0711df05236f04c0d72a68664df";
       public            postgres    false    248    248            �           2606    18115 -   utilities_type UQ_171574b07d1359885e9502f4eb7 
   CONSTRAINT     m   ALTER TABLE ONLY public.utilities_type
    ADD CONSTRAINT "UQ_171574b07d1359885e9502f4eb7" UNIQUE (name_vn);
 Y   ALTER TABLE ONLY public.utilities_type DROP CONSTRAINT "UQ_171574b07d1359885e9502f4eb7";
       public            postgres    false    336            �           2606    18117 (   utilities UQ_19c413cc98dbde4feaabf61e60e 
   CONSTRAINT     o   ALTER TABLE ONLY public.utilities
    ADD CONSTRAINT "UQ_19c413cc98dbde4feaabf61e60e" UNIQUE (id_expenditure);
 T   ALTER TABLE ONLY public.utilities DROP CONSTRAINT "UQ_19c413cc98dbde4feaabf61e60e";
       public            postgres    false    334            �           2606    18119 -   checklist_type UQ_2911ed68e84cd3b0de1d2008009 
   CONSTRAINT     m   ALTER TABLE ONLY public.checklist_type
    ADD CONSTRAINT "UQ_2911ed68e84cd3b0de1d2008009" UNIQUE (name_en);
 Y   ALTER TABLE ONLY public.checklist_type DROP CONSTRAINT "UQ_2911ed68e84cd3b0de1d2008009";
       public            postgres    false    240            �           2606    18121 #   room UQ_61fce2a10042f56cc0ff90cef67 
   CONSTRAINT     n   ALTER TABLE ONLY public.room
    ADD CONSTRAINT "UQ_61fce2a10042f56cc0ff90cef67" UNIQUE (id_room, room_name);
 O   ALTER TABLE ONLY public.room DROP CONSTRAINT "UQ_61fce2a10042f56cc0ff90cef67";
       public            postgres    false    320    320            �           2606    18123 2   shopping_list_types UQ_7989a7e61a59373515b3cc5c22b 
   CONSTRAINT     w   ALTER TABLE ONLY public.shopping_list_types
    ADD CONSTRAINT "UQ_7989a7e61a59373515b3cc5c22b" UNIQUE (type_name_en);
 ^   ALTER TABLE ONLY public.shopping_list_types DROP CONSTRAINT "UQ_7989a7e61a59373515b3cc5c22b";
       public            postgres    false    326            �           2606    18125 -   utilities_type UQ_93b779c9ebfdba844c6c1657ad9 
   CONSTRAINT     m   ALTER TABLE ONLY public.utilities_type
    ADD CONSTRAINT "UQ_93b779c9ebfdba844c6c1657ad9" UNIQUE (name_en);
 Y   ALTER TABLE ONLY public.utilities_type DROP CONSTRAINT "UQ_93b779c9ebfdba844c6c1657ad9";
       public            postgres    false    336            �           2606    18127 2   shopping_item_types UQ_a25cdcd86abe29f3f98e2af90e5 
   CONSTRAINT     |   ALTER TABLE ONLY public.shopping_item_types
    ADD CONSTRAINT "UQ_a25cdcd86abe29f3f98e2af90e5" UNIQUE (item_type_name_en);
 ^   ALTER TABLE ONLY public.shopping_item_types DROP CONSTRAINT "UQ_a25cdcd86abe29f3f98e2af90e5";
       public            postgres    false    322            �           2606    18129 2   shopping_item_types UQ_a441dbbdd37ea8068341b896624 
   CONSTRAINT     |   ALTER TABLE ONLY public.shopping_item_types
    ADD CONSTRAINT "UQ_a441dbbdd37ea8068341b896624" UNIQUE (item_type_name_vn);
 ^   ALTER TABLE ONLY public.shopping_item_types DROP CONSTRAINT "UQ_a441dbbdd37ea8068341b896624";
       public            postgres    false    322            �           2606    18131 /   article_category UQ_b0a808c4235154154a1ccb2d792 
   CONSTRAINT     l   ALTER TABLE ONLY public.article_category
    ADD CONSTRAINT "UQ_b0a808c4235154154a1ccb2d792" UNIQUE (name);
 [   ALTER TABLE ONLY public.article_category DROP CONSTRAINT "UQ_b0a808c4235154154a1ccb2d792";
       public            postgres    false    230            �           2606    18133 2   shopping_list_types UQ_b4b27159bb699560490fdedc198 
   CONSTRAINT     w   ALTER TABLE ONLY public.shopping_list_types
    ADD CONSTRAINT "UQ_b4b27159bb699560490fdedc198" UNIQUE (type_name_vn);
 ^   ALTER TABLE ONLY public.shopping_list_types DROP CONSTRAINT "UQ_b4b27159bb699560490fdedc198";
       public            postgres    false    326            �           2606    18135 -   shopping_lists UQ_c744d012a4f319192cee4190b45 
   CONSTRAINT     t   ALTER TABLE ONLY public.shopping_lists
    ADD CONSTRAINT "UQ_c744d012a4f319192cee4190b45" UNIQUE (id_expenditure);
 Y   ALTER TABLE ONLY public.shopping_lists DROP CONSTRAINT "UQ_c744d012a4f319192cee4190b45";
       public            postgres    false    328            �           2606    18137 -   checklist_type UQ_d0b2cf0fc681c90682cc9384e3a 
   CONSTRAINT     m   ALTER TABLE ONLY public.checklist_type
    ADD CONSTRAINT "UQ_d0b2cf0fc681c90682cc9384e3a" UNIQUE (name_vn);
 Y   ALTER TABLE ONLY public.checklist_type DROP CONSTRAINT "UQ_d0b2cf0fc681c90682cc9384e3a";
       public            postgres    false    240            �           2606    18139    calendar calendar_pk 
   CONSTRAINT     [   ALTER TABLE ONLY public.calendar
    ADD CONSTRAINT calendar_pk PRIMARY KEY (id_calendar);
 >   ALTER TABLE ONLY public.calendar DROP CONSTRAINT calendar_pk;
       public            postgres    false    234            �           2606    18141     category_event category_event_pk 
   CONSTRAINT     m   ALTER TABLE ONLY public.category_event
    ADD CONSTRAINT category_event_pk PRIMARY KEY (id_category_event);
 J   ALTER TABLE ONLY public.category_event DROP CONSTRAINT category_event_pk;
       public            postgres    false    236            �           2606    18143    checklist checklist_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.checklist
    ADD CONSTRAINT checklist_pkey PRIMARY KEY (id_checklist);
 B   ALTER TABLE ONLY public.checklist DROP CONSTRAINT checklist_pkey;
       public            postgres    false    238            �           2606    18145 0   household_consumable_items consumable_items_pkey 
   CONSTRAINT     }   ALTER TABLE ONLY public.household_consumable_items
    ADD CONSTRAINT consumable_items_pkey PRIMARY KEY (id_household_item);
 Z   ALTER TABLE ONLY public.household_consumable_items DROP CONSTRAINT consumable_items_pkey;
       public            postgres    false    278            �           2606    18147 *   education_progress education_progress_pkey 
   CONSTRAINT     {   ALTER TABLE ONLY public.education_progress
    ADD CONSTRAINT education_progress_pkey PRIMARY KEY (id_education_progress);
 T   ALTER TABLE ONLY public.education_progress DROP CONSTRAINT education_progress_pkey;
       public            postgres    false    244            �           2606    18149 1   family_invitation family_invitation_id_family_key 
   CONSTRAINT     q   ALTER TABLE ONLY public.family_invitation
    ADD CONSTRAINT family_invitation_id_family_key UNIQUE (id_family);
 [   ALTER TABLE ONLY public.family_invitation DROP CONSTRAINT family_invitation_id_family_key;
       public            postgres    false    253            �           2606    18151 (   family_invitation family_invitation_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY public.family_invitation
    ADD CONSTRAINT family_invitation_pkey PRIMARY KEY (id_invitation);
 R   ALTER TABLE ONLY public.family_invitation DROP CONSTRAINT family_invitation_pkey;
       public            postgres    false    253            |           2606    18153    family family_pk 
   CONSTRAINT     U   ALTER TABLE ONLY public.family
    ADD CONSTRAINT family_pk PRIMARY KEY (id_family);
 :   ALTER TABLE ONLY public.family DROP CONSTRAINT family_pk;
       public            postgres    false    227            �           2606    18155    family_roles family_roles_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.family_roles
    ADD CONSTRAINT family_roles_pkey PRIMARY KEY (id_family_role);
 H   ALTER TABLE ONLY public.family_roles DROP CONSTRAINT family_roles_pkey;
       public            postgres    false    255            z           2606    18157 "   finance_assets finance_assets_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.finance_assets
    ADD CONSTRAINT finance_assets_pkey PRIMARY KEY (id_asset);
 L   ALTER TABLE ONLY public.finance_assets DROP CONSTRAINT finance_assets_pkey;
       public            postgres    false    225            �           2606    18159 ,   finance_expenditure finance_expenditure_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.finance_expenditure
    ADD CONSTRAINT finance_expenditure_pkey PRIMARY KEY (id_expenditure);
 V   ALTER TABLE ONLY public.finance_expenditure DROP CONSTRAINT finance_expenditure_pkey;
       public            postgres    false    262            �           2606    18161 "   finance_income finance_income_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY public.finance_income
    ADD CONSTRAINT finance_income_pkey PRIMARY KEY (id_income);
 L   ALTER TABLE ONLY public.finance_income DROP CONSTRAINT finance_income_pkey;
       public            postgres    false    267            �           2606    18163 (   financial_summary financial_summary_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY public.financial_summary
    ADD CONSTRAINT financial_summary_pkey PRIMARY KEY (id_summary);
 R   ALTER TABLE ONLY public.financial_summary DROP CONSTRAINT financial_summary_pkey;
       public            postgres    false    272            �           2606    18165 )   household_durable_items fixed_assets_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.household_durable_items
    ADD CONSTRAINT fixed_assets_pkey PRIMARY KEY (id_household_item);
 S   ALTER TABLE ONLY public.household_durable_items DROP CONSTRAINT fixed_assets_pkey;
       public            postgres    false    279            �           2606    18167 $   flow_watermarks flow_watermarks_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.flow_watermarks
    ADD CONSTRAINT flow_watermarks_pkey PRIMARY KEY (slot);
 N   ALTER TABLE ONLY public.flow_watermarks DROP CONSTRAINT flow_watermarks_pkey;
       public            postgres    false    274            �           2606    18169 8   household_item_categories household_item_categories_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.household_item_categories
    ADD CONSTRAINT household_item_categories_pkey PRIMARY KEY (id_household_item_category);
 b   ALTER TABLE ONLY public.household_item_categories DROP CONSTRAINT household_item_categories_pkey;
       public            postgres    false    280            ~           2606    18171 $   household_items household_items_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY public.household_items
    ADD CONSTRAINT household_items_pkey PRIMARY KEY (id_household_item);
 N   ALTER TABLE ONLY public.household_items DROP CONSTRAINT household_items_pkey;
       public            postgres    false    228            �           2606    18173     invoice_items invoice_items_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.invoice_items
    ADD CONSTRAINT invoice_items_pkey PRIMARY KEY (id_item);
 J   ALTER TABLE ONLY public.invoice_items DROP CONSTRAINT invoice_items_pkey;
       public            postgres    false    286            �           2606    18175    invoice invoice_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_pkey PRIMARY KEY (id_invoice);
 >   ALTER TABLE ONLY public.invoice DROP CONSTRAINT invoice_pkey;
       public            postgres    false    284            �           2606    18177    invoice_type invoice_type_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY public.invoice_type
    ADD CONSTRAINT invoice_type_pkey PRIMARY KEY (id_invoice_type);
 H   ALTER TABLE ONLY public.invoice_type DROP CONSTRAINT invoice_type_pkey;
       public            postgres    false    288            �           2606    18179 
   key key_pk 
   CONSTRAINT     H   ALTER TABLE ONLY public.key
    ADD CONSTRAINT key_pk PRIMARY KEY (id);
 4   ALTER TABLE ONLY public.key DROP CONSTRAINT key_pk;
       public            postgres    false    290            v           2606    18181    member_family member_family_pk 
   CONSTRAINT     \   ALTER TABLE ONLY public.member_family
    ADD CONSTRAINT member_family_pk PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.member_family DROP CONSTRAINT member_family_pk;
       public            postgres    false    222            �           2606    18183 
   otp otp_pk 
   CONSTRAINT     L   ALTER TABLE ONLY public.otp
    ADD CONSTRAINT otp_pk PRIMARY KEY (otp_id);
 4   ALTER TABLE ONLY public.otp DROP CONSTRAINT otp_pk;
       public            postgres    false    300            �           2606    18185    refresh_token refresh_token_pk 
   CONSTRAINT     \   ALTER TABLE ONLY public.refresh_token
    ADD CONSTRAINT refresh_token_pk PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.refresh_token DROP CONSTRAINT refresh_token_pk;
       public            postgres    false    317            �           2606    18187    room room_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_pkey PRIMARY KEY (id_room);
 8   ALTER TABLE ONLY public.room DROP CONSTRAINT room_pkey;
       public            postgres    false    320            �           2606    18189 $   financial_summary unique_family_date 
   CONSTRAINT     r   ALTER TABLE ONLY public.financial_summary
    ADD CONSTRAINT unique_family_date UNIQUE (id_family, summary_date);
 N   ALTER TABLE ONLY public.financial_summary DROP CONSTRAINT unique_family_date;
       public            postgres    false    272    272            x           2606    18191    users user_pk 
   CONSTRAINT     P   ALTER TABLE ONLY public.users
    ADD CONSTRAINT user_pk PRIMARY KEY (id_user);
 7   ALTER TABLE ONLY public.users DROP CONSTRAINT user_pk;
       public            postgres    false    223            �           1259    18192    IDX_24fb0f1455ea9b3960adea4bfd    INDEX     t   CREATE INDEX "IDX_24fb0f1455ea9b3960adea4bfd" ON public.package_combo_package_extra USING btree (package_combo_id);
 4   DROP INDEX public."IDX_24fb0f1455ea9b3960adea4bfd";
       public            postgres    false    306            �           1259    18193    IDX_4e6703bf394a3d7af840fd0707    INDEX     t   CREATE INDEX "IDX_4e6703bf394a3d7af840fd0707" ON public.package_combo_package_extra USING btree (package_extra_id);
 4   DROP INDEX public."IDX_4e6703bf394a3d7af840fd0707";
       public            postgres    false    306            �           1259    18194    idx_summary_date    INDEX     V   CREATE INDEX idx_summary_date ON public.financial_summary USING btree (summary_date);
 $   DROP INDEX public.idx_summary_date;
       public            postgres    false    272            5           2620    18195    family after_family_insert    TRIGGER     �   CREATE TRIGGER after_family_insert AFTER INSERT ON public.family FOR EACH ROW EXECUTE FUNCTION public.add_default_categories();
 3   DROP TRIGGER after_family_insert ON public.family;
       public          postgres    false    227    388            6           2620    18196    family after_insert_family    TRIGGER        CREATE TRIGGER after_insert_family AFTER INSERT ON public.family FOR EACH ROW EXECUTE FUNCTION public.insert_income_sources();
 3   DROP TRIGGER after_insert_family ON public.family;
       public          postgres    false    593    227            2           2620    18197 .   member_family decrease_family_quantity_trigger    TRIGGER     �   CREATE TRIGGER decrease_family_quantity_trigger AFTER DELETE ON public.member_family FOR EACH ROW EXECUTE FUNCTION public.decrease_family_quantity();
 G   DROP TRIGGER decrease_family_quantity_trigger ON public.member_family;
       public          postgres    false    413    222            4           2620    18198 #   users encrypt_user_password_trigger    TRIGGER     �   CREATE TRIGGER encrypt_user_password_trigger BEFORE INSERT OR UPDATE OF password ON public.users FOR EACH ROW EXECUTE FUNCTION public.encrypt_user_password();
 <   DROP TRIGGER encrypt_user_password_trigger ON public.users;
       public          postgres    false    223    223    415            7           2620    18199 %   family trg_insert_finance_expenditure    TRIGGER     �   CREATE TRIGGER trg_insert_finance_expenditure AFTER INSERT ON public.family FOR EACH ROW EXECUTE FUNCTION public.insert_finance_expenditure();
 >   DROP TRIGGER trg_insert_finance_expenditure ON public.family;
       public          postgres    false    227    592            ;           2620    18200 2   finance_expenditure trg_update_expenditure_summary    TRIGGER     �   CREATE TRIGGER trg_update_expenditure_summary AFTER INSERT ON public.finance_expenditure FOR EACH ROW EXECUTE FUNCTION public.f_update_expenditure_summary();
 K   DROP TRIGGER trg_update_expenditure_summary ON public.finance_expenditure;
       public          postgres    false    561    262            >           2620    18201 (   finance_income trg_update_income_summary    TRIGGER     �   CREATE TRIGGER trg_update_income_summary AFTER INSERT ON public.finance_income FOR EACH ROW EXECUTE FUNCTION public.f_update_income_summary();
 A   DROP TRIGGER trg_update_income_summary ON public.finance_income;
       public          postgres    false    572    267            <           2620    18202 3   finance_expenditure trig_update_expenditure_summary    TRIGGER     �   CREATE TRIGGER trig_update_expenditure_summary AFTER INSERT ON public.finance_expenditure FOR EACH ROW EXECUTE FUNCTION public.update_financial_summary_expenditure();
 L   DROP TRIGGER trig_update_expenditure_summary ON public.finance_expenditure;
       public          postgres    false    600    262            =           2620    18203 7   finance_expenditure trig_update_expenditure_summary_mod    TRIGGER     �   CREATE TRIGGER trig_update_expenditure_summary_mod AFTER DELETE OR UPDATE ON public.finance_expenditure FOR EACH ROW EXECUTE FUNCTION public.update_financial_summary_expenditure_mod();
 P   DROP TRIGGER trig_update_expenditure_summary_mod ON public.finance_expenditure;
       public          postgres    false    262    601            ?           2620    18204 )   finance_income trig_update_income_summary    TRIGGER     �   CREATE TRIGGER trig_update_income_summary AFTER INSERT ON public.finance_income FOR EACH ROW EXECUTE FUNCTION public.update_financial_summary_income();
 B   DROP TRIGGER trig_update_income_summary ON public.finance_income;
       public          postgres    false    602    267            @           2620    18205 -   finance_income trig_update_income_summary_mod    TRIGGER     �   CREATE TRIGGER trig_update_income_summary_mod AFTER DELETE OR UPDATE ON public.finance_income FOR EACH ROW EXECUTE FUNCTION public.update_financial_summary_income_mod();
 F   DROP TRIGGER trig_update_income_summary_mod ON public.finance_income;
       public          postgres    false    603    267            C           2620    18206 +   invoice_items trigger_update_invoice_amount    TRIGGER     �   CREATE TRIGGER trigger_update_invoice_amount AFTER INSERT OR DELETE OR UPDATE ON public.invoice_items FOR EACH ROW EXECUTE FUNCTION public.update_invoice_amount();
 D   DROP TRIGGER trigger_update_invoice_amount ON public.invoice_items;
       public          postgres    false    286    604            A           2620    18207 #   invoice trigger_update_total_amount    TRIGGER     �   CREATE TRIGGER trigger_update_total_amount BEFORE INSERT OR UPDATE ON public.invoice FOR EACH ROW EXECUTE FUNCTION public.update_total_amount();
 <   DROP TRIGGER trigger_update_total_amount ON public.invoice;
       public          postgres    false    609    284            9           2620    18208 %   checklist update_checklist_updated_at    TRIGGER     �   CREATE TRIGGER update_checklist_updated_at BEFORE UPDATE ON public.checklist FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
 >   DROP TRIGGER update_checklist_updated_at ON public.checklist;
       public          postgres    false    238    610            :           2620    18209 4   education_progress update_education_progress_modtime    TRIGGER     �   CREATE TRIGGER update_education_progress_modtime BEFORE UPDATE ON public.education_progress FOR EACH ROW EXECUTE FUNCTION public.update_modified_column();
 M   DROP TRIGGER update_education_progress_modtime ON public.education_progress;
       public          postgres    false    607    244            3           2620    18210 ,   member_family update_family_quantity_trigger    TRIGGER     �   CREATE TRIGGER update_family_quantity_trigger AFTER INSERT OR UPDATE ON public.member_family FOR EACH ROW EXECUTE FUNCTION public.update_family_quantity();
 E   DROP TRIGGER update_family_quantity_trigger ON public.member_family;
       public          postgres    false    599    222            B           2620    18211 )   invoice update_invoice_updated_at_trigger    TRIGGER     �   CREATE TRIGGER update_invoice_updated_at_trigger BEFORE UPDATE ON public.invoice FOR EACH ROW EXECUTE FUNCTION public.update_invoice_updated_at();
 B   DROP TRIGGER update_invoice_updated_at_trigger ON public.invoice;
       public          postgres    false    605    284            8           2620    18212 (   calendar update_updated_at_before_update    TRIGGER     �   CREATE TRIGGER update_updated_at_before_update BEFORE UPDATE ON public.calendar FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();
 A   DROP TRIGGER update_updated_at_before_update ON public.calendar;
       public          postgres    false    234    610                       2606    18213 1   education_progress FK_08fd533f2a537656dfe6a39ad3e    FK CONSTRAINT     �   ALTER TABLE ONLY public.education_progress
    ADD CONSTRAINT "FK_08fd533f2a537656dfe6a39ad3e" FOREIGN KEY (id_family) REFERENCES public.family(id_family);
 ]   ALTER TABLE ONLY public.education_progress DROP CONSTRAINT "FK_08fd533f2a537656dfe6a39ad3e";
       public          postgres    false    3964    227    244                       2606    18218 (   checklist FK_0d76c2ea5be60421a137288b9eb    FK CONSTRAINT     �   ALTER TABLE ONLY public.checklist
    ADD CONSTRAINT "FK_0d76c2ea5be60421a137288b9eb" FOREIGN KEY (id_family) REFERENCES public.family(id_family);
 T   ALTER TABLE ONLY public.checklist DROP CONSTRAINT "FK_0d76c2ea5be60421a137288b9eb";
       public          postgres    false    227    3964    238            )           2606    18223 -   shopping_items FK_1279f8b50d7245e13af3fab8a84    FK CONSTRAINT     �   ALTER TABLE ONLY public.shopping_items
    ADD CONSTRAINT "FK_1279f8b50d7245e13af3fab8a84" FOREIGN KEY (id_list) REFERENCES public.shopping_lists(id_list);
 Y   ALTER TABLE ONLY public.shopping_items DROP CONSTRAINT "FK_1279f8b50d7245e13af3fab8a84";
       public          postgres    false    328    4075    324            �           2606    18228 .   household_items FK_14288da1f4af6438b12b8154178    FK CONSTRAINT     �   ALTER TABLE ONLY public.household_items
    ADD CONSTRAINT "FK_14288da1f4af6438b12b8154178" FOREIGN KEY (id_category) REFERENCES public.household_item_categories(id_household_item_category);
 Z   ALTER TABLE ONLY public.household_items DROP CONSTRAINT "FK_14288da1f4af6438b12b8154178";
       public          postgres    false    228    280    4029            /           2606    18233 (   utilities FK_19c413cc98dbde4feaabf61e60e    FK CONSTRAINT     �   ALTER TABLE ONLY public.utilities
    ADD CONSTRAINT "FK_19c413cc98dbde4feaabf61e60e" FOREIGN KEY (id_expenditure) REFERENCES public.finance_expenditure(id_expenditure);
 T   ALTER TABLE ONLY public.utilities DROP CONSTRAINT "FK_19c413cc98dbde4feaabf61e60e";
       public          postgres    false    4008    262    334                       2606    18238 $   order FK_1b6d4c36bfc4406257ea18ca86f    FK CONSTRAINT     �   ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "FK_1b6d4c36bfc4406257ea18ca86f" FOREIGN KEY (id_package_main) REFERENCES public.package_main(id_main_package);
 R   ALTER TABLE ONLY public."order" DROP CONSTRAINT "FK_1b6d4c36bfc4406257ea18ca86f";
       public          postgres    false    296    309    4051                        2606    18243 .   household_items FK_1d6981e55b514cadde7bd0f9edc    FK CONSTRAINT     �   ALTER TABLE ONLY public.household_items
    ADD CONSTRAINT "FK_1d6981e55b514cadde7bd0f9edc" FOREIGN KEY (id_family) REFERENCES public.family(id_family);
 Z   ALTER TABLE ONLY public.household_items DROP CONSTRAINT "FK_1d6981e55b514cadde7bd0f9edc";
       public          postgres    false    228    227    3964                       2606    18248 $   order FK_1e662a2957bd101ce9799af5b59    FK CONSTRAINT     �   ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "FK_1e662a2957bd101ce9799af5b59" FOREIGN KEY (id_package_combo) REFERENCES public.package_combo(id_combo_package);
 R   ALTER TABLE ONLY public."order" DROP CONSTRAINT "FK_1e662a2957bd101ce9799af5b59";
       public          postgres    false    304    296    4043                       2606    18253 $   order FK_200f6194460f392f21d1e08eb4b    FK CONSTRAINT     �   ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "FK_200f6194460f392f21d1e08eb4b" FOREIGN KEY (id_user) REFERENCES public.users(id_user);
 R   ALTER TABLE ONLY public."order" DROP CONSTRAINT "FK_200f6194460f392f21d1e08eb4b";
       public          postgres    false    296    3960    223            �           2606    18258 ,   member_family FK_238b32ca0213b65382e3a337e20    FK CONSTRAINT     �   ALTER TABLE ONLY public.member_family
    ADD CONSTRAINT "FK_238b32ca0213b65382e3a337e20" FOREIGN KEY (id_family) REFERENCES public.family(id_family);
 X   ALTER TABLE ONLY public.member_family DROP CONSTRAINT "FK_238b32ca0213b65382e3a337e20";
       public          postgres    false    222    227    3964            #           2606    18263 :   package_combo_package_extra FK_24fb0f1455ea9b3960adea4bfd0    FK CONSTRAINT     �   ALTER TABLE ONLY public.package_combo_package_extra
    ADD CONSTRAINT "FK_24fb0f1455ea9b3960adea4bfd0" FOREIGN KEY (package_combo_id) REFERENCES public.package_combo(id_combo_package) ON UPDATE CASCADE ON DELETE CASCADE;
 f   ALTER TABLE ONLY public.package_combo_package_extra DROP CONSTRAINT "FK_24fb0f1455ea9b3960adea4bfd0";
       public          postgres    false    4043    306    304                        2606    18268 $   order FK_2fca3384ca229ccdc266a23ec25    FK CONSTRAINT     �   ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "FK_2fca3384ca229ccdc266a23ec25" FOREIGN KEY (id_package_extra) REFERENCES public.package_extra(id_extra_package);
 R   ALTER TABLE ONLY public."order" DROP CONSTRAINT "FK_2fca3384ca229ccdc266a23ec25";
       public          postgres    false    307    296    4049                       2606    18273 '   calendar FK_3361adf88cf76886600ea7c5454    FK CONSTRAINT     �   ALTER TABLE ONLY public.calendar
    ADD CONSTRAINT "FK_3361adf88cf76886600ea7c5454" FOREIGN KEY (id_family) REFERENCES public.family(id_family);
 S   ALTER TABLE ONLY public.calendar DROP CONSTRAINT "FK_3361adf88cf76886600ea7c5454";
       public          postgres    false    227    234    3964            �           2606    18278 ,   member_family FK_3745e1acdf7a58a3a1717b57fa4    FK CONSTRAINT     �   ALTER TABLE ONLY public.member_family
    ADD CONSTRAINT "FK_3745e1acdf7a58a3a1717b57fa4" FOREIGN KEY (id_family_role) REFERENCES public.family_roles(id_family_role);
 X   ALTER TABLE ONLY public.member_family DROP CONSTRAINT "FK_3745e1acdf7a58a3a1717b57fa4";
       public          postgres    false    4002    255    222            0           2606    18283 (   utilities FK_39c873dfdb895c4b3d744dd60a0    FK CONSTRAINT     �   ALTER TABLE ONLY public.utilities
    ADD CONSTRAINT "FK_39c873dfdb895c4b3d744dd60a0" FOREIGN KEY (id_utilities_type) REFERENCES public.utilities_type(id_utilities_type);
 T   ALTER TABLE ONLY public.utilities DROP CONSTRAINT "FK_39c873dfdb895c4b3d744dd60a0";
       public          postgres    false    336    4085    334                       2606    18288 2   finance_expenditure FK_3aaa3162cee524817762c963526    FK CONSTRAINT     �   ALTER TABLE ONLY public.finance_expenditure
    ADD CONSTRAINT "FK_3aaa3162cee524817762c963526" FOREIGN KEY (id_created_by) REFERENCES public.users(id_user);
 ^   ALTER TABLE ONLY public.finance_expenditure DROP CONSTRAINT "FK_3aaa3162cee524817762c963526";
       public          postgres    false    223    262    3960                       2606    18293 .   household_items FK_3c78dae27e337bba258129651ab    FK CONSTRAINT     �   ALTER TABLE ONLY public.household_items
    ADD CONSTRAINT "FK_3c78dae27e337bba258129651ab" FOREIGN KEY (id_room) REFERENCES public.room(id_room);
 Z   ALTER TABLE ONLY public.household_items DROP CONSTRAINT "FK_3c78dae27e337bba258129651ab";
       public          postgres    false    320    228    4059            +           2606    18298 -   shopping_lists FK_3e755f6b7a9841687cbff01ff9c    FK CONSTRAINT     �   ALTER TABLE ONLY public.shopping_lists
    ADD CONSTRAINT "FK_3e755f6b7a9841687cbff01ff9c" FOREIGN KEY (id_shopping_list_type) REFERENCES public.shopping_list_types(id_shopping_list_type);
 Y   ALTER TABLE ONLY public.shopping_lists DROP CONSTRAINT "FK_3e755f6b7a9841687cbff01ff9c";
       public          postgres    false    328    4069    326            !           2606    18303 $   order FK_3ee680e936c2a81052734683f8d    FK CONSTRAINT     �   ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "FK_3ee680e936c2a81052734683f8d" FOREIGN KEY (id_family) REFERENCES public.family(id_family);
 R   ALTER TABLE ONLY public."order" DROP CONSTRAINT "FK_3ee680e936c2a81052734683f8d";
       public          postgres    false    296    3964    227                       2606    18308 &   article FK_4a9c65f15f9d864613a9273aef1    FK CONSTRAINT     �   ALTER TABLE ONLY public.article
    ADD CONSTRAINT "FK_4a9c65f15f9d864613a9273aef1" FOREIGN KEY (id_enclosure) REFERENCES public.enclosure(id_enclosure);
 R   ALTER TABLE ONLY public.article DROP CONSTRAINT "FK_4a9c65f15f9d864613a9273aef1";
       public          postgres    false    229    3992    246            ,           2606    18313 -   shopping_lists FK_4c1e5efa33503ef18816ecf419e    FK CONSTRAINT     �   ALTER TABLE ONLY public.shopping_lists
    ADD CONSTRAINT "FK_4c1e5efa33503ef18816ecf419e" FOREIGN KEY (id_family) REFERENCES public.family(id_family);
 Y   ALTER TABLE ONLY public.shopping_lists DROP CONSTRAINT "FK_4c1e5efa33503ef18816ecf419e";
       public          postgres    false    3964    227    328            �           2606    18318 -   finance_assets FK_4d4c03b039ff864e6f6331f8572    FK CONSTRAINT     �   ALTER TABLE ONLY public.finance_assets
    ADD CONSTRAINT "FK_4d4c03b039ff864e6f6331f8572" FOREIGN KEY (id_family) REFERENCES public.family(id_family);
 Y   ALTER TABLE ONLY public.finance_assets DROP CONSTRAINT "FK_4d4c03b039ff864e6f6331f8572";
       public          postgres    false    3964    227    225            $           2606    18323 :   package_combo_package_extra FK_4e6703bf394a3d7af840fd0707b    FK CONSTRAINT     �   ALTER TABLE ONLY public.package_combo_package_extra
    ADD CONSTRAINT "FK_4e6703bf394a3d7af840fd0707b" FOREIGN KEY (package_extra_id) REFERENCES public.package_extra(id_extra_package);
 f   ALTER TABLE ONLY public.package_combo_package_extra DROP CONSTRAINT "FK_4e6703bf394a3d7af840fd0707b";
       public          postgres    false    306    4049    307            1           2606    18328 (   utilities FK_504393f3802637a5794df5920ec    FK CONSTRAINT     �   ALTER TABLE ONLY public.utilities
    ADD CONSTRAINT "FK_504393f3802637a5794df5920ec" FOREIGN KEY (id_family) REFERENCES public.family(id_family);
 T   ALTER TABLE ONLY public.utilities DROP CONSTRAINT "FK_504393f3802637a5794df5920ec";
       public          postgres    false    334    3964    227            
           2606    18333 4   family_extra_packages FK_55524babcef42716f85d162c47f    FK CONSTRAINT     �   ALTER TABLE ONLY public.family_extra_packages
    ADD CONSTRAINT "FK_55524babcef42716f85d162c47f" FOREIGN KEY (id_extra_package) REFERENCES public.package_extra(id_extra_package);
 `   ALTER TABLE ONLY public.family_extra_packages DROP CONSTRAINT "FK_55524babcef42716f85d162c47f";
       public          postgres    false    4049    307    248            "           2606    18338 "   otp FK_5b899a36a6177f5c582dbfaeaad    FK CONSTRAINT     �   ALTER TABLE ONLY public.otp
    ADD CONSTRAINT "FK_5b899a36a6177f5c582dbfaeaad" FOREIGN KEY (id_user) REFERENCES public.users(id_user);
 N   ALTER TABLE ONLY public.otp DROP CONSTRAINT "FK_5b899a36a6177f5c582dbfaeaad";
       public          postgres    false    223    300    3960            �           2606    18343 ,   member_family FK_5f049421698995140fc1b7a63b5    FK CONSTRAINT     �   ALTER TABLE ONLY public.member_family
    ADD CONSTRAINT "FK_5f049421698995140fc1b7a63b5" FOREIGN KEY (id_user) REFERENCES public.users(id_user);
 X   ALTER TABLE ONLY public.member_family DROP CONSTRAINT "FK_5f049421698995140fc1b7a63b5";
       public          postgres    false    222    223    3960                       2606    18348 7   finance_expenditure_type FK_61f1607573a427834154fd2d689    FK CONSTRAINT     �   ALTER TABLE ONLY public.finance_expenditure_type
    ADD CONSTRAINT "FK_61f1607573a427834154fd2d689" FOREIGN KEY (id_family) REFERENCES public.family(id_family);
 c   ALTER TABLE ONLY public.finance_expenditure_type DROP CONSTRAINT "FK_61f1607573a427834154fd2d689";
       public          postgres    false    265    227    3964                       2606    18353 -   finance_income FK_6295debcc02c75fddf2e0c8c8a2    FK CONSTRAINT     �   ALTER TABLE ONLY public.finance_income
    ADD CONSTRAINT "FK_6295debcc02c75fddf2e0c8c8a2" FOREIGN KEY (id_family) REFERENCES public.family(id_family);
 Y   ALTER TABLE ONLY public.finance_income DROP CONSTRAINT "FK_6295debcc02c75fddf2e0c8c8a2";
       public          postgres    false    3964    267    227                       2606    18358 '   calendar FK_62d1aba636f781e495e450a8f05    FK CONSTRAINT     �   ALTER TABLE ONLY public.calendar
    ADD CONSTRAINT "FK_62d1aba636f781e495e450a8f05" FOREIGN KEY (category) REFERENCES public.category_event(id_category_event);
 S   ALTER TABLE ONLY public.calendar DROP CONSTRAINT "FK_62d1aba636f781e495e450a8f05";
       public          postgres    false    3978    236    234                       2606    18363 -   finance_income FK_68a4b444157646c11be0b986e45    FK CONSTRAINT     �   ALTER TABLE ONLY public.finance_income
    ADD CONSTRAINT "FK_68a4b444157646c11be0b986e45" FOREIGN KEY (id_created_by) REFERENCES public.users(id_user);
 Y   ALTER TABLE ONLY public.finance_income DROP CONSTRAINT "FK_68a4b444157646c11be0b986e45";
       public          postgres    false    267    3960    223                       2606    18368 (   checklist FK_6aa4c3616af8dc16a9b9f66ceb1    FK CONSTRAINT     �   ALTER TABLE ONLY public.checklist
    ADD CONSTRAINT "FK_6aa4c3616af8dc16a9b9f66ceb1" FOREIGN KEY (id_checklist_type) REFERENCES public.checklist_type(id_checklist_type);
 T   ALTER TABLE ONLY public.checklist DROP CONSTRAINT "FK_6aa4c3616af8dc16a9b9f66ceb1";
       public          postgres    false    3982    240    238            %           2606    18373 .   payment_history FK_74de8eeb900bcc8ec5293b3a52e    FK CONSTRAINT     �   ALTER TABLE ONLY public.payment_history
    ADD CONSTRAINT "FK_74de8eeb900bcc8ec5293b3a52e" FOREIGN KEY (id_order) REFERENCES public."order"(id_order);
 Z   ALTER TABLE ONLY public.payment_history DROP CONSTRAINT "FK_74de8eeb900bcc8ec5293b3a52e";
       public          postgres    false    296    311    4039                       2606    18378 *   guide_items FK_7711341859e007dbf8eb232546d    FK CONSTRAINT     �   ALTER TABLE ONLY public.guide_items
    ADD CONSTRAINT "FK_7711341859e007dbf8eb232546d" FOREIGN KEY (id_family) REFERENCES public.family(id_family);
 V   ALTER TABLE ONLY public.guide_items DROP CONSTRAINT "FK_7711341859e007dbf8eb232546d";
       public          postgres    false    275    3964    227            	           2606    18383 1   education_progress FK_84a855f55efb0c66383ff17aeb3    FK CONSTRAINT     �   ALTER TABLE ONLY public.education_progress
    ADD CONSTRAINT "FK_84a855f55efb0c66383ff17aeb3" FOREIGN KEY (id_user) REFERENCES public.users(id_user);
 ]   ALTER TABLE ONLY public.education_progress DROP CONSTRAINT "FK_84a855f55efb0c66383ff17aeb3";
       public          postgres    false    223    3960    244            *           2606    18388 -   shopping_items FK_90ba7379b3f9a9432bd10896d60    FK CONSTRAINT     �   ALTER TABLE ONLY public.shopping_items
    ADD CONSTRAINT "FK_90ba7379b3f9a9432bd10896d60" FOREIGN KEY (id_item_type) REFERENCES public.shopping_item_types(id_item_type);
 Y   ALTER TABLE ONLY public.shopping_items DROP CONSTRAINT "FK_90ba7379b3f9a9432bd10896d60";
       public          postgres    false    324    4061    322            (           2606    18393 #   room FK_9b7109323e4f3c259c0e72d4ac7    FK CONSTRAINT     �   ALTER TABLE ONLY public.room
    ADD CONSTRAINT "FK_9b7109323e4f3c259c0e72d4ac7" FOREIGN KEY (id_family) REFERENCES public.family(id_family);
 O   ALTER TABLE ONLY public.room DROP CONSTRAINT "FK_9b7109323e4f3c259c0e72d4ac7";
       public          postgres    false    320    3964    227                       2606    18398 -   finance_income FK_a72708fd600ad5a798509c7a0e4    FK CONSTRAINT     �   ALTER TABLE ONLY public.finance_income
    ADD CONSTRAINT "FK_a72708fd600ad5a798509c7a0e4" FOREIGN KEY (id_income_source) REFERENCES public.finance_income_source(id_income_source);
 Y   ALTER TABLE ONLY public.finance_income DROP CONSTRAINT "FK_a72708fd600ad5a798509c7a0e4";
       public          postgres    false    267    270    4014                       2606    18403 9   household_consumable_items FK_ab7cc27d018308d1cdbd35f5249    FK CONSTRAINT     �   ALTER TABLE ONLY public.household_consumable_items
    ADD CONSTRAINT "FK_ab7cc27d018308d1cdbd35f5249" FOREIGN KEY (id_household_item) REFERENCES public.household_items(id_household_item);
 e   ALTER TABLE ONLY public.household_consumable_items DROP CONSTRAINT "FK_ab7cc27d018308d1cdbd35f5249";
       public          postgres    false    278    228    3966                       2606    18408 (   feedbacks FK_aeb2bc2c7e30b980c16c5bdffe9    FK CONSTRAINT     �   ALTER TABLE ONLY public.feedbacks
    ADD CONSTRAINT "FK_aeb2bc2c7e30b980c16c5bdffe9" FOREIGN KEY (id_user) REFERENCES public.users(id_user) ON DELETE CASCADE;
 T   ALTER TABLE ONLY public.feedbacks DROP CONSTRAINT "FK_aeb2bc2c7e30b980c16c5bdffe9";
       public          postgres    false    258    223    3960            .           2606    18413 &   subject FK_bd45c33e1bb67b2efb0148bad5e    FK CONSTRAINT     �   ALTER TABLE ONLY public.subject
    ADD CONSTRAINT "FK_bd45c33e1bb67b2efb0148bad5e" FOREIGN KEY (id_education_progress) REFERENCES public.education_progress(id_education_progress);
 R   ALTER TABLE ONLY public.subject DROP CONSTRAINT "FK_bd45c33e1bb67b2efb0148bad5e";
       public          postgres    false    330    244    3990                       2606    18418 4   finance_income_source FK_c31258b3f88371c38ed5dc3a1fe    FK CONSTRAINT     �   ALTER TABLE ONLY public.finance_income_source
    ADD CONSTRAINT "FK_c31258b3f88371c38ed5dc3a1fe" FOREIGN KEY (id_family) REFERENCES public.family(id_family);
 `   ALTER TABLE ONLY public.finance_income_source DROP CONSTRAINT "FK_c31258b3f88371c38ed5dc3a1fe";
       public          postgres    false    270    227    3964            �           2606    18423 %   family FK_c312627f224d28d78fb1b68f8e1    FK CONSTRAINT     �   ALTER TABLE ONLY public.family
    ADD CONSTRAINT "FK_c312627f224d28d78fb1b68f8e1" FOREIGN KEY (owner_id) REFERENCES public.users(id_user);
 Q   ALTER TABLE ONLY public.family DROP CONSTRAINT "FK_c312627f224d28d78fb1b68f8e1";
       public          postgres    false    223    3960    227            -           2606    18428 -   shopping_lists FK_c744d012a4f319192cee4190b45    FK CONSTRAINT     �   ALTER TABLE ONLY public.shopping_lists
    ADD CONSTRAINT "FK_c744d012a4f319192cee4190b45" FOREIGN KEY (id_expenditure) REFERENCES public.finance_expenditure(id_expenditure);
 Y   ALTER TABLE ONLY public.shopping_lists DROP CONSTRAINT "FK_c744d012a4f319192cee4190b45";
       public          postgres    false    328    262    4008                       2606    18433 &   article FK_ce62257492361fd2d2d6ef909df    FK CONSTRAINT     �   ALTER TABLE ONLY public.article
    ADD CONSTRAINT "FK_ce62257492361fd2d2d6ef909df" FOREIGN KEY (id_article_category) REFERENCES public.article_category(id_article_category);
 R   ALTER TABLE ONLY public.article DROP CONSTRAINT "FK_ce62257492361fd2d2d6ef909df";
       public          postgres    false    3972    230    229            &           2606    18438 .   payment_history FK_d76a3c80388458a51ef888aa9c4    FK CONSTRAINT     �   ALTER TABLE ONLY public.payment_history
    ADD CONSTRAINT "FK_d76a3c80388458a51ef888aa9c4" FOREIGN KEY (id_user) REFERENCES public.users(id_user);
 Z   ALTER TABLE ONLY public.payment_history DROP CONSTRAINT "FK_d76a3c80388458a51ef888aa9c4";
       public          postgres    false    3960    223    311                       2606    18443 6   household_durable_items FK_deb0bba89205540b700df084307    FK CONSTRAINT     �   ALTER TABLE ONLY public.household_durable_items
    ADD CONSTRAINT "FK_deb0bba89205540b700df084307" FOREIGN KEY (id_household_item) REFERENCES public.household_items(id_household_item);
 b   ALTER TABLE ONLY public.household_durable_items DROP CONSTRAINT "FK_deb0bba89205540b700df084307";
       public          postgres    false    3966    228    279                       2606    18448 2   finance_expenditure FK_eff1066219bf88cd604ca0a8145    FK CONSTRAINT     �   ALTER TABLE ONLY public.finance_expenditure
    ADD CONSTRAINT "FK_eff1066219bf88cd604ca0a8145" FOREIGN KEY (id_expenditure_type) REFERENCES public.finance_expenditure_type(id_expenditure_type);
 ^   ALTER TABLE ONLY public.finance_expenditure DROP CONSTRAINT "FK_eff1066219bf88cd604ca0a8145";
       public          postgres    false    4010    265    262                       2606    18453 2   finance_expenditure FK_f09067b982c4e8b060c9aea3850    FK CONSTRAINT     �   ALTER TABLE ONLY public.finance_expenditure
    ADD CONSTRAINT "FK_f09067b982c4e8b060c9aea3850" FOREIGN KEY (id_family) REFERENCES public.family(id_family);
 ^   ALTER TABLE ONLY public.finance_expenditure DROP CONSTRAINT "FK_f09067b982c4e8b060c9aea3850";
       public          postgres    false    262    3964    227                       2606    18458 4   family_extra_packages FK_f10352652fae82be641f829ba57    FK CONSTRAINT     �   ALTER TABLE ONLY public.family_extra_packages
    ADD CONSTRAINT "FK_f10352652fae82be641f829ba57" FOREIGN KEY (id_family) REFERENCES public.family(id_family);
 `   ALTER TABLE ONLY public.family_extra_packages DROP CONSTRAINT "FK_f10352652fae82be641f829ba57";
       public          postgres    false    227    248    3964            '           2606    18463 ,   refresh_token FK_fd79923e4359a26a971f841fb5e    FK CONSTRAINT     �   ALTER TABLE ONLY public.refresh_token
    ADD CONSTRAINT "FK_fd79923e4359a26a971f841fb5e" FOREIGN KEY (id_user) REFERENCES public.users(id_user);
 X   ALTER TABLE ONLY public.refresh_token DROP CONSTRAINT "FK_fd79923e4359a26a971f841fb5e";
       public          postgres    false    317    223    3960                       2606    18468 2   family_invitation family_invitation_id_family_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.family_invitation
    ADD CONSTRAINT family_invitation_id_family_fkey FOREIGN KEY (id_family) REFERENCES public.family(id_family);
 \   ALTER TABLE ONLY public.family_invitation DROP CONSTRAINT family_invitation_id_family_fkey;
       public          postgres    false    253    227    3964                       2606    18473 2   financial_summary financial_summary_id_family_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.financial_summary
    ADD CONSTRAINT financial_summary_id_family_fkey FOREIGN KEY (id_family) REFERENCES public.family(id_family);
 \   ALTER TABLE ONLY public.financial_summary DROP CONSTRAINT financial_summary_id_family_fkey;
       public          postgres    false    272    227    3964                       2606    18478    invoice invoice_id_family_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_id_family_fkey FOREIGN KEY (id_family) REFERENCES public.family(id_family);
 H   ALTER TABLE ONLY public.invoice DROP CONSTRAINT invoice_id_family_fkey;
       public          postgres    false    227    3964    284                       2606    18483 $   invoice invoice_id_invoice_type_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_id_invoice_type_fkey FOREIGN KEY (id_invoice_type) REFERENCES public.invoice_type(id_invoice_type);
 N   ALTER TABLE ONLY public.invoice DROP CONSTRAINT invoice_id_invoice_type_fkey;
       public          postgres    false    288    284    4035                       2606    18488 +   invoice_items invoice_items_id_invoice_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.invoice_items
    ADD CONSTRAINT invoice_items_id_invoice_fkey FOREIGN KEY (id_invoice) REFERENCES public.invoice(id_invoice);
 U   ALTER TABLE ONLY public.invoice_items DROP CONSTRAINT invoice_items_id_invoice_fkey;
       public          postgres    false    4031    284    286            �           6104    18493    flow_publication    PUBLICATION     |   CREATE PUBLICATION flow_publication WITH (publish = 'insert, update, delete, truncate', publish_via_partition_root = true);
 #   DROP PUBLICATION flow_publication;
                postgres    false            �           6106    18494    flow_publication article    PUBLICATION TABLE     B   ALTER PUBLICATION flow_publication ADD TABLE ONLY public.article;
          public          postgres    false    229    4310            �           6106    18495 !   flow_publication article_category    PUBLICATION TABLE     K   ALTER PUBLICATION flow_publication ADD TABLE ONLY public.article_category;
          public          postgres    false    230    4310            �           6106    18496    flow_publication calendar    PUBLICATION TABLE     C   ALTER PUBLICATION flow_publication ADD TABLE ONLY public.calendar;
          public          postgres    false    234    4310            �           6106    18497    flow_publication category_event    PUBLICATION TABLE     I   ALTER PUBLICATION flow_publication ADD TABLE ONLY public.category_event;
          public          postgres    false    236    4310            �           6106    18498    flow_publication checklist    PUBLICATION TABLE     D   ALTER PUBLICATION flow_publication ADD TABLE ONLY public.checklist;
          public          postgres    false    238    4310            �           6106    18499    flow_publication checklist_type    PUBLICATION TABLE     I   ALTER PUBLICATION flow_publication ADD TABLE ONLY public.checklist_type;
          public          postgres    false    240    4310            �           6106    18500    flow_publication discount    PUBLICATION TABLE     C   ALTER PUBLICATION flow_publication ADD TABLE ONLY public.discount;
          public          postgres    false    242    4310            �           6106    18501 #   flow_publication education_progress    PUBLICATION TABLE     M   ALTER PUBLICATION flow_publication ADD TABLE ONLY public.education_progress;
          public          postgres    false    244    4310            �           6106    18502    flow_publication enclosure    PUBLICATION TABLE     D   ALTER PUBLICATION flow_publication ADD TABLE ONLY public.enclosure;
          public          postgres    false    246    4310            �           6106    18503    flow_publication family    PUBLICATION TABLE     A   ALTER PUBLICATION flow_publication ADD TABLE ONLY public.family;
          public          postgres    false    227    4310            �           6106    18504 &   flow_publication family_extra_packages    PUBLICATION TABLE     P   ALTER PUBLICATION flow_publication ADD TABLE ONLY public.family_extra_packages;
          public          postgres    false    4310    248            �           6106    18505 "   flow_publication family_invitation    PUBLICATION TABLE     L   ALTER PUBLICATION flow_publication ADD TABLE ONLY public.family_invitation;
          public          postgres    false    4310    253            �           6106    18506    flow_publication family_roles    PUBLICATION TABLE     G   ALTER PUBLICATION flow_publication ADD TABLE ONLY public.family_roles;
          public          postgres    false    4310    255            �           6106    18507 "   flow_publication feedback_metadata    PUBLICATION TABLE     L   ALTER PUBLICATION flow_publication ADD TABLE ONLY public.feedback_metadata;
          public          postgres    false    4310    257            �           6106    18508    flow_publication feedbacks    PUBLICATION TABLE     D   ALTER PUBLICATION flow_publication ADD TABLE ONLY public.feedbacks;
          public          postgres    false    4310    258            �           6106    18509    flow_publication finance_assets    PUBLICATION TABLE     I   ALTER PUBLICATION flow_publication ADD TABLE ONLY public.finance_assets;
          public          postgres    false    225    4310            �           6106    18510 $   flow_publication finance_expenditure    PUBLICATION TABLE     N   ALTER PUBLICATION flow_publication ADD TABLE ONLY public.finance_expenditure;
          public          postgres    false    262    4310            �           6106    18511    flow_publication finance_income    PUBLICATION TABLE     I   ALTER PUBLICATION flow_publication ADD TABLE ONLY public.finance_income;
          public          postgres    false    267    4310            �           6106    18512 "   flow_publication financial_summary    PUBLICATION TABLE     L   ALTER PUBLICATION flow_publication ADD TABLE ONLY public.financial_summary;
          public          postgres    false    272    4310            �           6106    18513     flow_publication flow_watermarks    PUBLICATION TABLE     J   ALTER PUBLICATION flow_publication ADD TABLE ONLY public.flow_watermarks;
          public          postgres    false    274    4310            �           6106    18514    flow_publication guide_items    PUBLICATION TABLE     F   ALTER PUBLICATION flow_publication ADD TABLE ONLY public.guide_items;
          public          postgres    false    275    4310            �           6106    18515 +   flow_publication household_consumable_items    PUBLICATION TABLE     U   ALTER PUBLICATION flow_publication ADD TABLE ONLY public.household_consumable_items;
          public          postgres    false    278    4310            �           6106    18516 (   flow_publication household_durable_items    PUBLICATION TABLE     R   ALTER PUBLICATION flow_publication ADD TABLE ONLY public.household_durable_items;
          public          postgres    false    279    4310            �           6106    18517 *   flow_publication household_item_categories    PUBLICATION TABLE     T   ALTER PUBLICATION flow_publication ADD TABLE ONLY public.household_item_categories;
          public          postgres    false    280    4310            �           6106    18518     flow_publication household_items    PUBLICATION TABLE     J   ALTER PUBLICATION flow_publication ADD TABLE ONLY public.household_items;
          public          postgres    false    228    4310            �           6106    18519    flow_publication key    PUBLICATION TABLE     >   ALTER PUBLICATION flow_publication ADD TABLE ONLY public.key;
          public          postgres    false    4310    290            �           6106    18520    flow_publication member_family    PUBLICATION TABLE     H   ALTER PUBLICATION flow_publication ADD TABLE ONLY public.member_family;
          public          postgres    false    4310    222            �           6106    18521    flow_publication otp    PUBLICATION TABLE     >   ALTER PUBLICATION flow_publication ADD TABLE ONLY public.otp;
          public          postgres    false    300    4310            �           6106    18522    flow_publication package_combo    PUBLICATION TABLE     H   ALTER PUBLICATION flow_publication ADD TABLE ONLY public.package_combo;
          public          postgres    false    4310    304            �           6106    18523 ,   flow_publication package_combo_package_extra    PUBLICATION TABLE     V   ALTER PUBLICATION flow_publication ADD TABLE ONLY public.package_combo_package_extra;
          public          postgres    false    4310    306            �           6106    18524    flow_publication package_extra    PUBLICATION TABLE     H   ALTER PUBLICATION flow_publication ADD TABLE ONLY public.package_extra;
          public          postgres    false    307    4310            �           6106    18525    flow_publication package_main    PUBLICATION TABLE     G   ALTER PUBLICATION flow_publication ADD TABLE ONLY public.package_main;
          public          postgres    false    309    4310            �           6106    18526     flow_publication payment_history    PUBLICATION TABLE     J   ALTER PUBLICATION flow_publication ADD TABLE ONLY public.payment_history;
          public          postgres    false    311    4310            �           6106    18527    flow_publication payment_method    PUBLICATION TABLE     I   ALTER PUBLICATION flow_publication ADD TABLE ONLY public.payment_method;
          public          postgres    false    4310    313            �           6106    18528    flow_publication refresh_token    PUBLICATION TABLE     H   ALTER PUBLICATION flow_publication ADD TABLE ONLY public.refresh_token;
          public          postgres    false    4310    317            �           6106    18529 $   flow_publication shopping_list_types    PUBLICATION TABLE     N   ALTER PUBLICATION flow_publication ADD TABLE ONLY public.shopping_list_types;
          public          postgres    false    4310    326            �           6106    18530    flow_publication subject    PUBLICATION TABLE     B   ALTER PUBLICATION flow_publication ADD TABLE ONLY public.subject;
          public          postgres    false    4310    330            �           6106    18531    flow_publication users    PUBLICATION TABLE     @   ALTER PUBLICATION flow_publication ADD TABLE ONLY public.users;
          public          postgres    false    223    4310            �           6106    18532    flow_publication utilities    PUBLICATION TABLE     D   ALTER PUBLICATION flow_publication ADD TABLE ONLY public.utilities;
          public          postgres    false    334    4310            �           6106    18533    flow_publication utilities_type    PUBLICATION TABLE     I   ALTER PUBLICATION flow_publication ADD TABLE ONLY public.utilities_type;
          public          postgres    false    4310    336            �           6106    18534    flow_publication v_user_id    PUBLICATION TABLE     D   ALTER PUBLICATION flow_publication ADD TABLE ONLY public.v_user_id;
          public          postgres    false    4310    338                  x��[o�ؕ/�,}
����	PT�~ќ��.�e[�%K�-�,V�H�H��ȲJO�iA�FNA0��it����t�� ������'���&��UU�3�g2]V��]��k��.��[�
�[{��w��	_>}J~J)���Tz���gK)�b��ӯR�{�R��٧�w��峟�����IS4c&H��`����q���osq;����d/�aP9۩�j�0�<�R�;��$�q�v~�KeH6lKwg.H�����������oe������4���/Uy��ߊ���?R��4�c�tTӰ5�QCn��M�5t�m;-͖5K1d�2uY�U�t,����:������(��P�����S������a�C����a�Ûr����\lm�+�����`����5����/^]��~������ɣ8��<y$f�>��|�_z��_%]����3\ԧ_fI�}�ȧ�t�|#�?�����obix�\��x���s��Hj����	|���}i���̻:��#��Œ5gG5�Mw���E�W� �f5�0mf	�f����a6���>�b��/��+Y?y�&�^��d��v,�39`�m���W��6�k��tB/L��b4��^RO�z=x�aɶ���:�eغ
_��f(�����;���r,�8��5M�,~�ݚj�+�`i�/�ͽU����zv��tN��o`�룄�kܑV����G�r�qx m'�dp��BI�A �������x���i�����M2�N%(�q�� �Z�8�H�A'>	aN/aMzG�v�Y�]�W��4�.��9�̇[�����'�.N:���h�y�����xE��_$/��^��n)��ă���Q<���tT�>�p_��rЖ��C�=���d�6���'p�h�VA�H�Q��ć��2�M7�(v-���/��x�$���P��y��0[uLK65��߻�Y�H�y�1��n�>Z�F�@����xJ�>
���gO�ki"m�w�������ox�X�h��}����_@��X���o��h�|'���pP.x}ܓғG�7pL�h<�+�<�T�%��"��	��X��p6��;���g�/�.+�9�)���R��(�Q�v�ք'� ��N>��w�'�O�/�?Il��>B����I$�pHL:��0���ǋ��'�;R�� H�����v$�@t7�^OK�p�)u�-0.-[(�Z�?ʚj�㈳�tݵk�g���l�%k�-;���?XQ���&gy�pS�^O>�_�p��?�>�WX�B�ђ�U�&�9�$� (�h&�0<��:/��7o��%��њ'�o��l7�Fɶ���/>��_������˧_�R���D!:�s����р�>��=�[�곸0k�>�3�����=|��~�������!mW`p|�O�s�X�|�>qܒ:n&�m	ƅ�(�����dI������:�����M�b[]Wk��?A��ϸ=A���^�Zp�ڶ��*�C���@�����\/��̚u��m���i�޾?�}�n����2�OC)+����)���
N���H�ł���	�w �Gm\ďIoh�ƿ�<��~v�"K�D��2�����;8��#���ʚW�V+�0k�ZY3k�Fo��<�;t�`�Ft/�}A[<-4������с��n|�8��g݂�>�Ygx�1���:`#�1��4i�Q�p/�4Lz�%*+�iۺ)��pM8�\���w��rW�W�����7����nYa�A�~��}��r��t�_�i��/�`��4���}L��X�&[}C�[�;p�����[Lg��`�|^ù�w`
*G����7��ŅY���ف)��C��Px2�'�O>���Ͼ���k7��ғo�J�' z���t��]Kj�m
����<y �/�F3/T��KRgͬ�o0��6b�^�n-%��89l�Qd�U����T���C��\�9���7�ݽM�aI1v�	w�P���Y�?>��S���f�؋�oa]�G�����S
 �Av�) ���}�,;ߒ�>��R��tO|�������l���U��w���0�擏!��1ˋ�S:vv�E\�u@ǜ�UtE�8wɹ�$ֹ.��z��apP㞄O����4�N��=uT���Ļ��aHw�1$��2|o�6�po6�����]�-�'��lj�iȞȦ����n��^S����]c�o�ly��]w��`!(� n`�L �lDa<W�������0 ��Ala����PĽ8
��[����#o�䭈@Bi@Zn�4�����cR�Ђ����\�I�i=����6/w��(~��a{�!-�*鱅�D���!�$"�q�=e�#�h0i2T��k%�`S	1`끡qP�B��[Kۦy
_��(��N[Q8�f؎n��:N���k�F�leuW?^����>�}�u���sP֫œ'���h�P&qg��Aކط9 ���v�ȣ�C�P��GQ|�G��?��O]�頋����ݹ����p�)I�2I���.:���g���27CAQS��0A��D]�Za��{�1��g�^���4ӘÜ> ���Ii����:�"��v]M��(�!k���M����,7���~�����`�`ݾ6�{K�C�#i�������!��Q�����E�Bݼ<�e"��/J����C�ġ5N� �L�b~W�������}��&~�����s: |$i�G��L�N.�]\�T��R��(3;� �f�~EF�??Gq�0o�5��Ⱥ�h,�i�I��pf�q��{�<��}:i�Z`,����w׬w������I�A�PV0�d�0���U;Zw7}x�~i��r�ZY�����V�b�M~�l��itL��1��˷ k/���8����r�T��.��n�W��o�D��A�s��,��Av>��w
�;>�S�	�,mt���q,�����/��%�>�z"F^��R�/�}�
�=��Á��(f�Fp�w�^�O!:�4����	&J�|,G#DƠ�)��ȩGL$P�`�	A���,�莫�S���iS�lM�Ed�/�P���Qbr`޼#wF���W>��J|wzJ��dʰ�.,�����x��:�^HApP�+�%��r�ח,�d�1�Sz	=�@v���S��3�V��ZD�x=���A��^���b�X��}�K�i��ͼG��ve�|j��0x�����sI��<�^�K��	��\X�����*_��&`�A�;������z�
��=�l������n�z�����	��yRP��T��Zm�Qǳ=M��}X��lZ�k��h�90��T�.�ei!����˫~Ѝ��x�fk��<�Z�4 +(:�P3~�����A�fJ_��-25}��Nc����b��st���Ipz�`�ɟ"���Cu��I"���e˗�Q�ޠ=7���[ւ��9���eClv%�����U�9JaT܌��A!k������?g����^
S��9�z#b��(mqd��DL����N���Kk\��L������]Ͳ��m���[~z'�dE6�9*�6tK�i����L�o.u���®��>�,�M�Պ}J@��Ev��"F	&���}<�������8��d����L	+^�<߀_�W��(���'<:��0�e��fއ{x��>�F(���H����H�c]����vwR�4�`Z�R:��.~g��aZ/�^g�)�eV������,E�Y�2ͩ�a�v�Dᱯ��ד�{ӻ�;e�y)ǴO>ݒ5�a��Ο����]����6`�Y,���O{e�U��-��a��n�*�&�"�C�X���/?D�O�̹���N�DrϧK#�Sjr��O'j=�-JG��%^s2�fH��q3?���1�G�B�5S��f�p�\��Q�}�1�^�������(�f�]�}
��0.LWLS�[W��m�����դ��ܸ�ݲ���r,x1z�b��1BO���`�}��\�2l`��' q]���4���qTB�G��G�R&����ү	�u�%����E�_YY�yӜ7�W�E\�    U/������yiM�J $3F���.�k�"t�w�"�p̈́O���T.�fhx�'>��#8\������Ħyj�t�[�|jY`?�q��8n���k���^���V�u�q->4���6:�b�7:�"���g�P��s6ٻb�JL�ŏe��|�� �w���񱁾WO�6*�P���"�`�:�F9:�����e��*�����0�"8^�]��rs��c5��2:�]��EֶI�3"�ȝE?�6l�aܞt?<>1�*8:"��uw3�ʠ�"�.��&���yA�3����n����
�ʶf�
�]]�Z��Y8�c�����=�Ʈu���Ŋ�ς�"���'E��!�34)�1�(Cy��~e	`T�O�W��./�> ���_�����\�|�J���%��[�����j���taVE����]���J�m���s~>�����j�V����'�P��h���F@���أln%����)�UrZd�ԺA׋��iQ��t�}��6Co[���7U����lXŉ���]S��lݲo����޵��5���Q�eDצ�9(3���=_����S�ΕOD��`��	�_�� ���\l�9��GZ�e,$��7�fHY�꓈��/s�amĢ>�>)1�^�+�����3.�G�P��v������}��Ջ�¬��%x�e�`�щ@���_�T�F����i�H���dLB�N�Q9�̓H+5��9�T��Se��I�;�W�@�-Ӱ0�*;�jʺf�A"E��#�w�����K����?ȎZ�^�V9���X�6��#��}�($xd\�}��W���
W��V>p��M�G��`8T�Z�v�0���xxv)�Ca��ʋ��c�̻��$���5�Sp���7vQ�JM�3�I�¬��&xYD���hӬy�Q��tT,�*���Be�3�d!��< �挱�^@�^r�On=���"g���4������ �8h^�.ӶU�4tGT��R����ozw֚��m�P]ZY�7�fV�8_����~
O�Q�Bc8�����A�K)��+Ƨ�->ΊӐK�|�o/���;6���S��Ϋg��¬�h#xY
��`�*�(Kn���p�!-va���p?��E�V)�~���N��EK�e� �� >A���3Aw�����Bf�w�z&�Eߴ[͸�㫚l�����+��1���Ө��mE�j�Kwvz���C%](�3K(Y��E����S"��q���#���"�W�8��eR%����ߖ���"����RB��Ӕ�`��ͼ��w҇��L�Y[ ]�Ո�J�Y���a7��{2�<1�Ԁӹ�����q,8�0<�I��}1"Lp$G �.����T�N~=X��OU�_)J1m�Qv��^��ԍ �%o}5T�M����x�Z�5�2��X�JF^@�ӓ�#��H��F��0�icp�x�2l���Ds��g(�h�V����AuD^E(�Rs3�a�-�U�R��n��B��e���y��\Q�!N�W�&������o�5�馗�~�;�]�,'���� E#����S
j@���? ����=p8�� ]�wLy\�_�:�e)j^�l�����������֏����o�on{w����۩��H8������ݠkP�C8�1!_OE�Ef�3�s���͗�a�a���"�B�$i�k��ɬN�����x`=�p�"����-�qUA'�ąY�<�nIܖT���-��=0���&�<���� �"�;����?��	ʎY���\�M:ǒ �&�b<����~�ۅ'����H��(LQ�Y5r�7K������%y��g�{��`w�w�����9�J
&���3-"K�������y���7�b>���M���F�Ⱥ�N#��
}J(�RIJ)��S��;�Z *^vN>�P����I\��j�iMv7���j(�A���1U|XN⌘�@��º�7"��GE>�d�u��ꕈ��7L�<�2�B�eZ�lۚ��w�� ����J��s<J6�[���&�����s�"��-9�EYx�SW�O�^2�veAq�,�0ſ��SKm�[����)� �49;��qŜ{��y���9��$���0�?�� ��2N�����tA@���!�ZF`#JGH\R%@��jq�3�v�뇃��Z�E�H�+�eBH��xG8���qI����F��6
�)�;e�f����S55���W��\S�7�Z����ӄ��W���=�ِ��[�i'H"i��<��8]v�N�f�^*���w�#�;0����	U@���8��Č��o{+�r>�G���R� ]?�4�R�Ik^�9�#�&�p���@ ��Ёz�pWC�r�����y��T)͋a��F��Y��Vϥ��/���B��l��t��޶�⽡��t6��f��%����3�V����G�?��S�ry/�܊�����Mދ��y/>�P��^�9s=�g��XLD�x�i���!/<�)H��&/�xH�Q��G/`����O���$V^���r�_�3Qk�|�a{Lx}����r�`+c���"�0|���mk��T1;�C)�";a�Y�bgK��1��&H�0���k4�[�^�bag��D�Q�w~�c��b��dB��[�Re��랣���~����D�)�Њ�eݬsL��[˷���H5�њ���U�ݐ������[M�x~���ӈ(j{(@M'G��S*��T����� �S	@v��DTCQ���:���?nT3� ���)�.��`�N��%�|J��x�����M�h��"y��cz%��U�����bLJ��Sd&�jL���v`8<���TL;���ݴ���F�մU[kڊby�め����vm������>�}н.�[�G7��k�U��X�}F�,�h���qv�.W�ծ�E��`�O��3�`_p�.�IBbL,�l��D�-��xI�0����C�gi{����y������_�N�kK�%/��n`x�}�Q&v��ae�/C���'��q�H�L��B/�-�iQ0dK��1�\ÈU���B���FĦg�d��/��ln�y�um�˷x��=�=?26�Q�wgi�JvkMu�z�n$�ߡ�ܐL�D	"��z��R�յk�}����)<��͘��ǡ�����8k�I��f�᩽-A<�f!�^���.�g������7����iϡ7���S>ʀ�A�Þג��/=��W�c[5ѢS�;M��j��44��\U����]�+�.���L5����dۺ6:���L���V�-u��G���s��H(�TqV����m�y�6¥�)�#��nl.4����״�?.�5�U�a�*�zHN��!�8l�Ch��\��_�H�O�/Wi��R�"P����g�5�1���a)��@J�@���C?hw�I��p)2�Oa��gD 1elI�����LA`׳�/싦B~�Ȩ�
�G����*(s�Δ��SeG�s ��(u�d'ZXN�~���l3�{��P�X+��5Dq���쳶��ăFF,,B���m)ֺ���S�Od^F��B@���'C��P4ʲJ�����s�o[�ϧ��N�Y�ro�lI���Nϐ��-�(����av=i��j�h��������PڦE���7���E��JMJ�7��	���p܉T�9ɝ���"-ڑ���������n�{�n.�+��w�A��
O��ǰ(���OH����¯#�zJ��(�|�"iq_�e.2)?િ�E'���\ua9�YYY*A00}�:F�o���y>XH�ď�p���N��Fc�&WP�ы�ɧ�����~oM)Χሾ����Q���0��J����B�0�v"�6��W�AN�Ŕ���6�l��S3e3��ӖF���Jʬk.8��R��u�Ud8ns^Kյ�2��wo��F�^�]��������UJ�+�Bl�1�S*Vg��:�Z�.>�F�%�=�D��1���[��	��|iu�fޑi\����D�7�y�X��0�#^6�|��    `d�R��"�U�K���KR�Eo��`ԁ�`�Mj��&8Փ���	�!���� ����s3����Đ)G�6���5Sj����NK�ձZ�ꩊa*���{
������غ�C�����=s�}�wuo%�~�{#<Z[r��^��K�����<8jctc�`��œ�B�n�+�CAˆdE��:*��+�i��,-J�}�P�P:bN�d?�#ё{�!�l@Qn�r䡐 ��RM���tUqc^u�R\�0�#T^���C�!j�F�A)�q�1,��)����P��W���awI&y�>.w�f9N��v�]���c�4���� �^]�7$�^��B�d�;��6��S 4˖�)@�]��?\����߾~��/��^k!h�#�;�W ��1��a�m8�+J��]��}�կ[p.j��enHX�y���a���"�,}����ݟ�۔ت&�ʼ����taVG��,��OE���ɀj��Z��؄C2w�wN�)�"��L�d��e��01|���*HGd)P�4�9�P�&U?����T���)u�Pl����k��n(��2Z9 �5d�Tt�V��.u��>�}�UO�E+��ol�w�=��uEa�!ؐ�T0�N���ɿ������&�,�(��Fh�l1�'=��1ۂ��-R��ؽ����K7�*�U՝�7\\��/˄���� F�"-;��2����2����O3F>��Z&��F�xh��<@G��M��Rꕇ���!K��+�Nʹ��|ϔX�Yѭ;�~d��Ȯ��,GW��������@ݾ��|�ƍ���J&f��~��7���.��%��~�=���u*���bP]ߊT��s�T��T3���!97s����E����1o�ѾX\��m/�v�i:�%R2�wj��xv ��?��o�7G:�4Isw�p":������x�DĪ��S�<u?��S,�QUE5n`��p���l���������{;��z�oo_�֒���)��X������,:y�겓����g�I-��ϳF�/��H�<����| K4��_3� ���* on�2���e��^j�z�^�Y!?�Q��S�5�|z
_�T(����f����\k�M�4띈���)�!��b9���c�4(s#5G�Ѱ�
V�}�ݻu�T]�\���Ɗw�x���8�i��!s
�=��3�.� �8}�Y5����sc"��=n����~9. �("��E(�组�I�8g��e�[dc�$�)�ݘ���gxhr�E�L�~��4�|J��y�L˕.���5V�S�)���al>߿E�����M�����	`���O/�b�2lH�}"G`Pi��K�i�^�WLm��FA"i��l)�8����b�56���`Q=n���;�׫	�$A:�A���cѤ�tL|]_;��LQc:<��(�����/�l�_����!U=<���I���b�ZIG'M�.��x�����������ԮqvRT\�5�/kl�0�o��#�N?E�K�A��h���n�^Oc0A�O�9Y��lx�֜���S:���h��ۘq�t�sݒa9TM�e˱$��&�:v��j�<���v�x�}��]�yx��_-���
L�k���MԀ�񃫕�v/R��әx٧��4(�z�ڐW�dC��.J|���(�%b
��q��j]X�Zܡ�M��"C�����.R�ϧ�O��e��|��!p^��}�[�k欀F�ʆ�,܎�:o��c�Ep������ܝ��m\t(����wJC����uck����+�{�7����Z�ټ��*[�ia�`�1�Z�;�������qrc��+�rdU��X%��+��&U��������i��L��D��B��J-����9ie�A-������0�zR2e1";7s�&|��[V>e����3 �¬��!xw(�z�_��t�c�2܊>�9�9_0�[K0���q�"�NB�c��vb�1͕���e�Pk�L?��=P�UY�o�ᨶ�q_x�
����k�m>�h����a_��w7w|c��@�'�CH39:�����'-��˗T���}�uä?.g�L@_��i`��cnK�a1�pLٷ����1�	�#,]��^��VUO��D#������`\2|]� &#pȄ9�{�i�`)���>��sE�1�][F�`��ȶ���{�6r�_]�z?5}����t��^Ѫ=��IN)<j����f�󔘶����������y�DST��Fަ��%m"r���pϾ5��;�<������W��-A�K� �
��P�ϒ�;�="��{�>�g����0k x^neq��S����3�c1lb���Q��c�Z�l������
�fܧqa��q�LBG5æ<H"��A4��p0y?��}��r�z���	��m���5�_U�LUW4ݑ��n�QTm_i馢���]�i�j�p�>C���E��p�m�1�����W[�j2ڷ[��h�nb[���D����J�*����_�� Ǟ�C�M��!!�c2���S��-"�d��L�ŝ7@Mߩټ=!=�u༝�f
��f���{A�����Y-�%Τ��.ſ����s�ɩYrq~7|؇_�H���!s<ɘ&^%��5�|�;v=?�¿p�B�j�m�ST��tPQ��qD���%렎yT��:�^w�V�ѕ�����޼�P����>s)U�(˪��+� �F2�����iӍS�tд)�H�]�`��2��y�f���֪�j�~�Jf��44<B�AZ`�!2/�*/��v�c%�F�/�nu�[^�Hy;O��#�M�#�?��!sor���6ak/x�Xл��N��Ϸ�Ӷ	0���=�Y[N��?#�۠ӎ[mp31�jY�ٌ�O=��p���ᨫ���ל��`���W�~�Z��������߃"|��D�P(Da$ i~��?)1�b߷��진�J��$��]������|J��y�l���b��%g��p��̫^#r���t	D��gQO��� ����-�Q
�C��7���C0�d��t.&�)�R�65Cu�rӵ�<rj)�&�Eg�RݺV�֕���h�}7k�nw�#+0�V��������3�/\=v�& X��I�a����
��>y_������9[r�ڟ��xeA �TD�*�㖱��m�9?����vF#Mqa�D$��R���C}*L��Ǫ���W���H�'��<����S?�еƚnp96i��p��y=ʐ��A��q=h��,eR&��4��Ϩ��'�0�S�֣���{@���j��8��8�x9-Mv-�~�6�ܓ�ks��f�v��w�n������=wdn��).�T�^����jBn7�"p���RK��k��}��ٯ���3�X�"����}�N)�F�.'*)��Hr^����d������В�0k"h	^v1�G���-%^\W
γg�.�އ���D#���(�8V������@�'2�����~9��S�u�r{Gp����d�?XY5-S֋z���n���w}�@yp��n�Q�t���-g�bg�פ��D,��Q[�G�b�?P�� i �eG�i�q~��E�N!ln�M�sHb�Zqԕ��K�n䧨>�@�.O�%��S�	�s�NхY!=���9ƒ����q���^uI�foC�V���\HK�h�27DYB������gR.�	,�ɢ�p�aO�B�&�����=����O� 7'�G�eD�a5��M3
��X��W�_5�i�\��t��O��8nz'���ˎ^��8�[��>��N��ã�+N���7iD�^F��A�G�-@���n��V'�nI���E�W�3��0k"	^h?��{O�[4~x"�9-�3��(i�*u�Ԏ4�g��]b��d���̡:"6NZF�)1�=ѥ�^�낾fJ�1\�;:R�V�H�n��U0���l���*앫��ޭ':�y��l�+[+i���-��.:��|E�͟�Ѿ�S�)������ܤ����Y��\�2b޴��P�1yJ�����i��    �yǦ�ve��)���:�fMcF���\�I�tБ��i�9�E�
�`������Lv䃎�D�sm�p+{�F��z-1�;�TL��
�OR�
��d�f�0�M�T4ױ��l�U
d�f�. �rн�90o�F����_A�yQ�؈��*�y�$�c�,��~�$L�9~Xx4hx
�Y!��H������7�"q�1�7-�����VB������̥���gI�g^5��H�/̚&�I5���x�B��ªA��iL��ÓIU�XZϥ�0�>���6:�8i�'c�A ްY_/�&cO�fjN/����VA7��u���y�'��$ܽcw�n{x#S�$�-�l%Ӊ���x�>��0��<wp������MZBbb"~��H�0E2ە�p��)�a,둁\`�����Y�B=����#�P<����#��0*��T��.�&6�\�0#Čf0r�Np����@�f��e�cЛn�i[�خb:�n��O���𺜶k�YG��L�cVm�Ϛ�o��VKV��:��SO��oc�O�{��v�	�Q�W�w��#��(��%s�"�9ʱt��O�{��K����4��.(���"�d��^�G�\��*���q��%�u��y_��B%���ڼ���T�����i����?�1����>ɨ��-�����M���|�� �b���m���C;��q��XxW]]��~��]�=�5��S��F眂l�h��ص��[�|�8���������ޭ���c�������
��#�
�HO���1.7�V7g��X[��#��^��*����)�K0�ȲRM*��/̚*�3��e�ܭ����"z��{�EN��[�9��ne�Ť�F>��m<�� b='�����p��k@�p�p�ыL5�zd~���aA/bv3_5SC�4�U-V/]1U۪Y.9�*Ǚ�a�-m�>x�6��^T.�ު��s
s�>�O��W��8r��O ������i���'���V!ҥ踵5�^PI��\�9^�\�uJ��Sz�S.ꔋ�G��;F�\�b?��Q?&q)�G��Q�x�iBy�#�N��(��q��)����\�(�8&�
�eyZS�����o�B폚m������?_5���H�e�u,Y�m�YƬ�Y��*����\���a?�:rk�r���T-,)��"�P�HBdv�#���P�Y��T���1�7��^>�cV4��~&�*�%ǐ
ǋ�zr)S�\�	�U�.������W[�/�Z
�+�<�g�;�*�]�O����sbCL��(L1���j"__�]5�^�o�0����zmx|���eۦO������\We��0M��\_lm5��ޝ�0[����ln*;��X6���"��$d�	< ��b�,wrK���"[���!�MiaE�/}�;��<����g��	��uB\�yN-ye58�� �A�D�RQԙ��ؕ"��AKV>�y��U�-�� 1�4�/ٸj���$6�ak(��ʖ*��H@$쐒	��y�e�	�4G��Do4�T����������4���֠�-�\*8�8�c�D��_�0�~���[�|}gw��p��@�-D�zZ�����a��/Q��8�Q��O����!7��f]heD�S/X,@��5 f
�1n#)�DjyL\�1�5Z��xR g�e��ې�Z��<ٍ��e~a��P-��mL�#'C߉� wP?K�bu�tVQ�	!� ��b]^�wV�	�<�XS�5��NZ�{F�R�}e�/m��t8�L[<�N�n�C��9�j������Fv{���N�_y�U�>T�"lA�w8�A�BXl@���&�'B 㹜j��ƦZ]Z<�u�Q��3�n��$����ջ�T�Q�	��3�XO9N�-�� ��8b�89�^	!6i�M�J:;�l��GT��S���"#1�X�i�J7�$sr��	,;�2Mޛ"�� �v����[������������7�f��Ǌ?5���0�̾���)Y�֩y�r�I;�N�/�d��TZ���' h}f#�[p�9%h7:L2��������K>�����!�4,䉡`:���$�R����1C���Y��p�*��#����p���?$�(�G�/q?IEi���;��w*�\�A���R������SUCvM�m3G2��f�Eq�:��c�z;+�^s���°SQȂq7�,��x-�X@��ڎ( rk&A�>�Z��TlC�7O�>轺�y?b������|Yp��������)�/�l/Xb�x]�W_% �/�Z�瀗��$���8R#�F*q�!=׿�H\��`�h	e�	id2x�E�fG�K�v��R+AZ*�X�?�&;�*�sLC�����}t����nn���ݫw7��-1�o�H���>?Q��>����(�\�M�oc|w���Kd��w��7��2Җ���͔��Ҽ�� �����âj�R��InU�&��`C����C�3�ك�o|pѯĘ<NrbK�a+$�3bhR��V�'T�A��S�]��T����&"��Ґm��e�P�Qe��S��wF����y#�u�����%��ؔ��x�-�p3rQ�k��n�T���t��0��	L�`�g
�R��,Wg��A���*,'O�=�	�a��������k>7�^�ěH��T	�6�wT��U/g%���q.�Ds�3���5}e�6b�{T��� �I�c��o�r�wݰ�z�JS<�Bz������`�%��+cTV��۵�����p)Q���������M�{Xv�6�7�h8~ܼC�Zu�
�'�����D���̦GenV4:"�E�� >���`T	�'־��)���*���(�����3@*�'{Ul�fޫ��h�/+�=Ii�\i /�������ޢy�J���rRL�1�8���t�d��,AH��Vnj�t��rLt߂fʩ�rة�5M�4P�elȮ�y�Q�L8W-r�rfCSU,���yd�ۆ�j�W�[�Ⴧܨ|~��_i�1r���b�TE4 Æ�HpBG����X�I?�$l���$���������h������ɷ>gP����uʍ�4�|')d��������JzYQ�I�j劊�x1O9��E[����D�/)�I��؏�8�/f���\1/��l�^���M��>"?R*C�u���Q@�U�6��0"B̜����������ig������[J���+��}��V�5'��e��=�7�WQ��"7Pr'D�0L�(�N-|dP$��M���I�F�-���C�o�uy��"�W֝��\�)_���K�l���c�)�I0� 鶉��;9x	(F�B�T�q��U�Xg���%�;��ن�Z������`�1�є��s\���\M��&�W�,D�-�����?�W��ɹ�sP-�d�eL��E���`<�{�q5�'{�īt@LY�Ղ�ͱKHB�����?�\<�c�[ԐX�ߋ�x�=�!x^n����_JD�:�A��tIt@�l�Ğǿzmu'�!��~� 鈋��;��P/�W�:G��}ô�5��:���F�	�k6�/W5Õ-��}B[�ݞ;ܺ2�\{]e���N�֍�r����"
ACNR'
Bh��B����fz�38!ʋ��G�����Qk�:�Ö�tmlrQ�D��27������dΝ%���ޚ6��ۜ��f�߈B��|[䣛�Oؙ';Bg�<�Gp	�gH�W7'��!��!����Ĉ1e+�ص����3ܺt�S;Bٓ��n��l���w����W-k��"sqem��0ڹv�T	H*����Yy����q_�lJ�K�+S䷱+I߹��.�_4E,�L-�ʚ�d6�0�xn�]���J��t!,���2Fǔ���6����7�j�@�(��
�P�G�O
��Ȭ��?�XSj-,�#>��;�^^�����\^n���ٓ������{���N��\ʡ�0�̂}W�Xl���=��W[����Ì����bJka%�'��Q$��M1�$y?./���;?��j    ��}0r}@,	�0?� �H�3���I(�����x8���""�]� C@̈2q#&5j��bȩN��{DG!Ƕe�ֵ⽣�Ԕ����&�����Z���^%�x���c�q�d5)|�,����q�v_��]|r����) %���kA�Q^Ü����'U
%�R0�.�d/N(�Uhfc�ڶgL��oȮ�3t@�)鐠�,�k>o(M�/��AǛ�T&ro���9�FD�%�e>沚�u�]�#J������d����b���4U5M;�ɲ]�te[u�[��Z2����(Nkuѐ�n<�z��f��j�˺�ŅU������*�X���d�R��
�|�9Ì?R�1�;�
̸#
���&�SJ$#�r��t_>��\�ӓ{rY���`yI��mۙ�%������ǰ�� 4Q�[!9_l7��_}��N%�iΉj~�ꪲ�*F��0�cw�W3k�F�p_�^=����e?��GE�0�E�O�.� .���YǢA�q
��gd�Ϣ� �q�����y�G)���9���~6��9��0w�J_��O!���1[l�3�A��Ȋ��q��/'�7d	���"R�X��8#��L��TD�ɳ��>�x�)��Ŋ	O��A��"��2s�RjW{u�X~�{C	�������Ͼ_�}"]O`��61�5�q���J1΅R.3�$B�	��&C�ӆ'���*ABn�<0M���Y5�*�B��ʜa���U�N�ғ^҉_���O�0��(3�s�PX���}&��B���-�9yد�T���� $@�@�AAn.F-�:��S�V~\i��Ȗk*��v�3ʽ��s�}��wwo���j��[FY����G/~D��?��f����!�|�}�p�\wjs��/c�a�sB��/~��''�&/>��F��?)�_���I��h��0�H,��~�	��^��X[,��7��8�5�D�����&.Jxϥj�{uf/\xCu ��e/Q���db�7��P�f=Fh	�L����9�t���zQC��>:=L���*�Z9���Ev���:���׎L����ʖ�/�V�2���(F`��@>(m��*
-��7NG�R�Ȅ�5�M#4��&\+"��� ns��Ԓ����;E�{�� �(Ǧ��������J��t�6��~���W�l8��c1�0������_����U��D���S���f�Cb�6�#a�ֳ/�K�����3u��\2tѴ�}���~?[�^W���.:����A��r���dSu��
��f;�a���GR6�2���g��r੺����şct��g��̓���|��1X�	�J?����۔�2� ���+���l)�0�`B��gV�u �Q���L}<f�,�O+�I�w�T�qKԏ��é�Ȝ#r����^��?U
��A;M���ͫB-��d׵s�U4�6�pQې��9�f�:����W�R��C$�F�pĜ�\�����1�'{B>�T�Kf#�����@�ȗ��͙�Q,)����<,�i��/�:��u�~�^ 6.�܄�p��\S~X?0�9����E6�k;�6a���)P�7����}콃��p�#4�=n�L�Y�
���ZM��E~״��A�*g���ђ[udUu��WV�@�P?�����5,�]��5��߭����#�px�� @k���b!	��a�?��5%|�h\N�c�I9���t�8a�J��sK����ߊ�v�����ZP�xk^����Ķ�_�u0��c���,v�P�N)U2`�Y`��a㺿�������R��S+�a�:dr�z��s8#��S]�]�h��;z�ޮ[!�k�m����q���v�Qg�|>^Q�8*_j��wR1��H��;�7M5����`�!N"7��+sY�� �'��r	uC2�bH���N��?�y��vQ2W��*�y�t�6[�/�:�f�Xعf2�ܻ�0%��o���wA�tE[!"Fsn��Z^��4�dS�#�y$]�E���V�COu���9lw3_qu�8�RUKvs�9�4-լ�ѝ;G�53��<Z	�]9��ݪ06²P�l���{��	��E�<>�I��(��A����_]pZjBr��"�u�f�ғ��������kY�&�9�k�!�=��e	�QTxo�����R������*71A4����0�V�ʇوw���s8թ���Ò�8�k��'򠺚�N�8��t�k0�l��y���Qxs�J{3^���s�0�`5P�]��A�i�+�u�� _�'g��.
��������_0�������U��sU9��p��ݓ?I���f�������6'�z�,�!����Ϩ�,#�� ���uF��z�)��J�q8�끄[�n��*~�|$MVu]Xl���u9@n��W��m�;��׻=���SJ13!d���N�2�Pq	o�=�b�!<+�h$Tu?��1��1�K<�
�5^>��W�w#b�/]�>���X�p�v���X�_˲��"s3��=]���hM�ݶƼ��Iw�ëL!��a���0�����Z��M�^��u;e<#�F"*��Y[7G��Ve]s��)���u���������o�[ؗ�/[�JY�����GV ��o�^�M�#+@��F���ީ�p��譙'������ݜ7��8 ��F�` 3	�RB���c�R< n�Q��U]��O!�e�8�v��T��A\�tƤ>H7���؈�RJON���<���c��@���m	2H�f���#MuF���X��h�����
�hZ$5R\Gujz>��=#��U�D��:N6����),�d�IE+�G*j����)`L-!Z�?�q����F��`̂$�Z/G�I�)�D+L�,��_��A� g�*;���%��7�㒚�gVYR~a�E ���X҇ݜ�HG>�6�A�SG/+}���ϑ���?��D`�%w�،�@�<�G�� ��Uׇ{%x�͂������
�.�K�����~ˣ� �N6��.�������8�Q7x;4C�[j��;�ý��i//T��G��e��E�4�Y&���nHG$�D�+̰RJ���tX�U:�C��?}@``$��[��1��`p�}����e��)�񪎋�.U\�11�!�#�l�+b"����%��jJ�mO'�O��L�W�$�ǅ�j�w�����Q��|���ɔQ3���_1UXR���)n��uٲt�xo�����|���k�������~w�`}9�t<�cO��ԥ2ݫ�5���b��!aꉅCXw}ԕ����A��|�30~������%H:���;i�>7�NN��IaE2)Ș_�uE�";	�֡�H���=L{0���.���f�,l�[��5�6�4�.�ii��6��u�T4]WU۱]G�M��u45GTj�^S7�Zv�T�P�w�F5�t��Ҕ;�c�"<���Z�S,������}�G�hqN\����(��
�_]�O��[d���+E�����]9���gG ŅY1 ��\m���(�,[�H����=LFm#b,{�ލ,c��L6�l���o2�T�K�d�'��B���X���)��ث��:؎5]?���B��^��nǻ���l���V5���5lD�JU׋F���\�}��Rz�ߧ}�}L.Q�f����j$O/?�o��B?�OW���
0v����v^��2���p�Z���{xKoAʺlϛ�b����¬��לY�f��<�
�uL��FE�j�9��bA$v1�A�cF������6�y�(}q�T5��E1���P]Y7@aM�E:�b�&@���;r��Fpca������'ǫ��@H"#�Z��I��9Jˉ�Q�fZ�Ţ� �'c,��,�������e\�6օVR�6vQ�F~d�<�r.��/Dr�6ᴴ���!��-���$K]�${CA�'����5CQ���L��C���]~�v�j�ڷ�7-����.�����ei�D��*�g ��]�B�t����ݝ��87�}}�7��ۻ�uʴ,���B˥����xNZ����    �EW�O�����5�]��{�̾�"X���$X!�2����7@:�"I�2�/?��<3� ɬ*҄�w���"�õ�)}I��GQ�.p��J3�J��B�H}r�FD�v3Ė�Hm����+t_�wj�{����S����;Z�Ҝ��J �lYumW�2�&G���my���fѦ�=X�[���Y�$�Wx��r�y>]"އ��ao��)�� �GI�f��A�-��J�qF�\p�4-N��-�W�A�O:�xn�ݚ�E��)|��ja���A\Ne�+��P"B����;���X������z�a�x<1I��D�c�"&A.{r���CCM3�������L��\8\L7o�JMuX�7����/e���v�oxݥa��Y�9���U�KQ���sbh���"98�����>�׉-������1g/2|<��O�5���71@���zI?��Ud���2�Z?�y���5�����Q�Et���"�T�l��ː_�W�7�j�=~�!j�Cհ�m!L�O.��0f��L5�T��jz�c�VSU}��wu��4E�,͖m�4��9u���A�׋W�n�wnɪ�Zw{�ۣ,A-LA�ln��#OHؘ����)��(�N®BtG��p(�0���Iw��������K��̻<���ò��M:j�IG]���Z�� 0����g�R��("�(��b�0�I%�a8_���g>L�e
�����5����KV5��j���S阏���D������44C�-Ǳ������R��r}�~й���/���7�7�W+n�+n�+Kf	z�b������==_�q;;�ڧ��������ү�Qr�B@G��1�Mi/f����%��[�벪�͇j��PQKQW�1�1���Vˢ��f�����"��?��t�R����5ؔ���#ᒮ�ٹ^)�U3�o�7���Ey��Z�r�v�Y�@�^ϔ�`|2��Ň��c^���%ZS-������?�+B1�9i�xɋ�������1�(�)Yx ������7� ��H�2N�qOZ;�4h1$:�̀�د�t���"��Z�f�ګ���YTGTJ�L	x�x�-�����ʣ�'i^K�ͨz�+7��3��d����CT�H���c�`�;Sk&
.�;�3Xt}�H��8z�k�:6$�]�.�$��rp�s���k�^�wm�yxo�s�-Qş�r�)n�I��Nct����1�2t٨[`(Π��W\�S�@_�K[���:jU<�P��Jk��'�mq����ݷ�E��aBPI\��LU�1f�L+ﳅ^�=4:p���JL�}(���)�B`ī��L3�Ǝ'.�.LՀ��^��\�MPm�,V<S�]�
�(k銪��k�f�6}�~��n=���Km�v��y�?*�g>��mp�sE�C��rbpaQ���SJ̝�bo8�,l!j���AW�/���g�>��t�^��qfg&�H.��3�����W$+Os���&�@�A�:=p�6�H�G�Mע^�w��*�욢{������ש��(+������������]+*@"B�71���R~�y��!�tE\����|>�]�N��F�a��"PP^�2�vi�Ψ������Spp}ԐVaO��
�`����&r[��'�`z��J���2G�ȰVh�O�
��)iфfRA�쩦|С����i�يMAE�>���L9�t�c:Ja��9o8R_�#kz^�fj�U��`���W�֕���[����Ⱥ9���ǟI��nH֘��Xbp�cu���^����$"�
3�r�8�?#�R�ʩ�3�l��d�@���4ۋ��*/��I\�ECM3g�A ��L퐧I%y�ͤMb�!!�����	L
��~�����\�MU!S��.�dj[+�v]h��s�{��++�������N�p�z~�'w&��!��(@y^X�ʳ�S��� y/X�灥4����2h�Xe\]Zp��.݌/B&���:��ca:�����|��A��1q��pP"��w�uעӓ���ZϹ�5�tT0Fg�j��R��ز�Z��R��5v>��<��֑����t��KGǝS�����3�B�_�Ҁ~�a,S�ԩ.��Q�}N�������N�����,%���9X��d�.�H��x�wpZo"Wea?�`�����cw#�o{WS���[�ӓ�0{�D�p7�0r�Q$9U�L�g[3o��(���m*]�n�v"�M��O����0^v�h�F�1�GWo�φm��.�~`���ۃF1�[�2>r+�+����DP��R�ߊF�:S�l��Mů)��T�xÓ��HJ�4hH�=7�n��B��z`�83ky��6�� &��@���%$<�0�pT:?�d����4�9�T*p��Y|p�MvEd�B�RrQ��)#��Ց޼��8X^7;͕hg�SM%h��U��VX�J4N?s.��lF�����[���t#o�̊�8��?�Y;;.�au�_Exc��%���H�9Uș�A�ܙ���Xo���V{X���6F�!�&%�{�
��D\��ɵ��	wC��ķ����v�q�7)�'zZ�6}&%C1������+y��o����H54Ͷ����\6-���4@	��b�r�v[{�KіZ�u��ջ�.��f���%�g`�$''�]�%�Jo�Rc ����٪�l�PCa������ԙ݉�Xw�H+*+5��j,�Iϩj��V�s3��-�]�ܑ'd�)ąY�o�rU��AcW�b,r��[D�l��U=Â%�5��§�긝�ط!F~,CCvq���(�Tw���TS�Rul�vT��,Gu��\�B�]˖m�}�-Sq��;7��{W���ˁ�~o����J̊�U�͵Oѿ'Q��Z9�!x4��D���U��S<a,-�
����-���������1S�5N����
�����M\����ԙ7�	�U=fQCQOՙ�������ڀ'�3�C��+b]x�w<�Clzq�R��|=�Q�A~Gٽg?��M�Znx�����Q��4�����&�����0'��@���k��x�9�FPL#�3�1m[6M���-�.W�����]�\m�j7TC޺������{D��_�Q�$"��g �T�iy��J�����~��Jbl�9Q��M�$����kT�<��C��j���kj�/1��dv��Gu���9��g�taw���uь�)q��8�!�=���ҁ�7�I���ړ2L� �������p�˖�����@ӎ;��.ml��j�k����X�����w��M;{̓v�9ܸ���v�/��Ϯ�E_>���R�GHO�E�s�x��I����z�1�MqcxB��D��8������d���$��>�幆��X��3Y<3W$�޿�c��ͼ?wr�B~J?�y�t_�O�0������>��xp��&����8�g�"W��z��S�&�=�!T�c�D^\�?��0=�C�f�ŋ��)�zaeSD�ݸ�n,�Cu5��ڃ�~[6TӖ�νj�~s�]{��y}kee�����Vwy�|"�2�=d�����b�SwE��I*��/������={J!�z�LN�%±N� ���f�
������gEcqn�=����e���w^7^�qa5�ߘ�} �&3���?�'#�;)l!�fEo=AiF�å�$Ci��Ov�W�)A5�	%��2��&��J*'�O�=�DSy}D�Y�pa�4�&�O@w]�6� 	�϶m]�L���Q[����Zs�����^��=��m�Ch[jRB�XM�l�K���{��R��QN�O�T�g�x]������H����$n<L�I����(>q�������y�����心�.�U�֌y�L���֨���Z;�2�q5�S��}���U��㏙��mޤ�~;����6.�A�^���
�oFj�Pٹ�6�-[S�]��nh������{������6�'����_���|2��C,V�g��X�Sk��	����У
qj��ɋ��O��<ԉQ��E�D^���q�_���:��,,�3�DyB����K~%�U�R�y�L��    ��P�V���Oτ=�>�8�`:����vp#�m~4�aT�Lcx�'В'@�*Xf�g�|Ŕ������D�u�82�H�r V2X���h!;�������};y�`�ڂw�7X=V�x� j�AF!�ېpި������ <�0����y�
�X|BX�"�0V��9`���Nv+��)@{#.����{�^V`c�P�T`qaU؞Ym7vD���9vW���^�;�m��Ԇ� �R�e/�C�3�����||���\�,�;�>���Ȯf�Ʃ�(u�f-�G���Mg�h݌�����ke�t��a[��B2������/����2n��� ���2�I��-�0�aF>D$<�tJ.��5eU��Y��"�j���P��|�\�ԓ��-k�>o���!_qa�
���T�n2{@ [L�3���R����ԋG^����_L�I��!YΔ�
<����_ŷ��3L���\EmTѮ3<��Z���k財9�PQ�>5g|������C��l�z�u��'��vɮ��k�)	�I`�bt.4��7B����R��|��0�n�a��t�`��B�vUè*����~���Z{#(RIQv*�Q!ƴ��{��>?�k�G+5LHQ�hd}�l���F]��h&������c:��^��@����H����ه"�.!
َ��
�=�c!�?mR)���j��We�9�����d�p���7�!�I�#x"z�V�}��o���
݌"sEx?��<��+Q�.�t3�\�<k�F2��
��YeNS`��sfzךд���5�8��6a�Q�)����~\���Iq�S���j�^�(m�^*o�a�6��p����� ��ݗ<1a����I�SŻ�w	ٞ�5�y�3���T���h����q�71���0㓶��	��v$q V�l[S-�C��	��5��a�����t�
'-�uE|׋2� y�	���W+��bت�Q�Z�a��ڲi��d�"-��d庸��6�������b�i��g�� u�5x/EWc�+���i�#�t76���aY{�U���H�K�;��LARfR3L����j���BZk�a��@�l_�-$���Q둢��-��� ?�k���r/j�Vx(-����Z��;5�/<
}�.;��ѠJ�KFA�)]fN��A�l�Wm�QeK��O�v�ή��i����]>�9�ϭk���L[9J�F���G��CH.hT�����=�����w�-Xd��Հ���A�?!�oP��ҟ��>�N���Ϊ#`��@�LV�4���24J��"�� 3��/#�PRi���$�,G�̨��\��t����f�����E&����{��~�8�ˆ
9f�Ԫ��d�����e�F�N�fm���rZ�ٝ��f ���䲒,�?��v�g9z�U�礴Ϩ�*�.�J�2W=ع���Lm�@WF�P�p�^С�T��f��"�*�#Nm��=�M$�����y0s0v=wЮI�^P��ق�dU#TQ&N?8"�%��a�#к�ϛ1�i��A�\g!GE��!���9K�T�BA�F�>A�#�̑Cbg�>�ޕ�O�̅b���):�Ӧ防i9
�Q�E?�ngݧ�V���G���S�Uk�{З�����������T��-K�U�i%Gt����l�2Xm��N������&�z�筁vvb:�?��y�:�?��w���8]<�XU<�y�S��b�`O@�x��%]|Y[:z0�އ���<�4F21X_|���Hw��'�pc�Z�<ٖi( ��+��b3C�M�]+�Euz~��\���Tn������9I��;�m�D	�]�LҨR����Z�c��R��X5����59��F��	>��"�}�Q�½�ϼ�l���ߴf`rk3gu��sk��`&`,fn�"�Uf�[Ax!t��׻��]R�ق��PZ�#$�庩�
D^i�W"�8y�*%�~��Q�c���5�37t���v9U�S��z�Ȏ�p�/�y�Y��Z��u1�\
6ׯ�6Z禪�<8F�.:b���/	W�u-5
�ZD*���?����Z�K�,-K��g��w�����ob�T�]��?����gM.@��3���v�\�Yd���@VX�o�gޑ9~`��6P}�� ˦�;>ܿ�fS�����4�rT��q�&�SM[w�<�fee���]U^�ԋ���N�jV���޻�0lW-$�#L�w��!23�8�J�It�#KTV����50?����\�g[e;�b�T�;a���,��^���gq�
�Yb��}+��``�v�Ñ�G�Md�k]�8�,�~��qy%^��/j.lv�`�(  �x��s���>��Z"��e˯�o�0�#��-3�"�f����v=9X8=^ު��R��<�]��|q���"�(բ����S����cĵ�'������5E_�>z1�?#�� HR!K�����'�Ui�[^ɪ4ly���9��*i�R�EըeD;����){�.؀D��JQ�s���C�[�NA����>�Z\�A�_�^�w;��eV��+�m�O�ǿ2�6�)����++���t�zŅ���a{.K{l��[�I@>��M>P�A���󉘌���tHV1uYD���[
ɺ�M�X�
��,Y�n=��f,�>�0�<�SYH��hi7�{i���y0y0|�OD�Ŷ~�j>�
%"���-7Q�U�N����_���%�H�U}ݙ�A>}�Ɂ\A uM.{)-�̙���e��FO"#�ʹ�7�Za������������������v���a�ۮ)k���f�q3�%_���������Xk�,���m^��o;�v�-Qyf�~�+��^���7��8�@�I�czbP���&�A,�wIi�`kM�	􂳐>�;�����+�2{<��gf�+á�J�{[�}��D	D7/�D /��H�/u�!Ёo�*x��v����������ȃ^;�J�l�ɩ]hB�6W�U_�5U�5�l���]}�74G�]GuY�l��6'�`͙{��˯�������W�gs�cb>�a�cS�|����p��&+\�<z��J�$O��yj�cA�/x#�94 �"1}T�d���/�����>��N�HB���v�xŁ<�-����.���)2)z��@pcA10����,7�� 䀕�Na>�@������Φ6�k<� �ضik���D����"k�H=ۺ�d-U7.n��V;���_ڸ�V��nZX�CU�o�4Q����SP��7Y��I$ǜ����Y	X��/?���������A��	� h��l�R>�A���ܟ�	�zڌ5{V����`�`�Z\�C��(
���N������q!*K�<�"�c�60���-w�^��́�-���sOh���k�؆�^����g�μ��y�.�o+������b��%[��\+�7ѱ���+�Q-1`I�K[z~�����@�)�A6� >����c|��`�G4,mm������G�����=��@ҒЋ1F(t�y�a�d���M	@��69�K�\���9H&&�<�ކem�ox�ng��Gȱ"R-WU��n���<����7�*j�zrR�s�^UV}��_q����%��cD����s+��c�CweS1�aq_�����D���z^>Zj���ק�������=��aӋ���]�c�e�i7.�OkL<=����!F��+�S}Oo�6q�V���b`q �
Vk�6��V(���!2�PƑ��A�^$K)�ԹN��w㊼,&�z�xN@�9��GW�{ Y�n�0!��l��.3�E.�5�w���鮭Ɇ�
����Y�W��*������v�³�����x�N�a����瓗�%u��a���K�}�q�S<N�&�)�uõ�H����HV�Gi��8�Ķ�����3��y�O;��VkϪ��.[�`�`�f�M��C\���;x_![m�M/HF� �$c�>���Ά�h*���DK$�[f�����+s%H]͘��ڕ&MM�ceW<9�+Y�uGv\    Sl�l��������qy�l�[������F���Mg����s�h�W�8P��m�A.d�$�Ũ�(p���B���) �"Wb4���3����=���������5kܯL�y0q0t����)���0(w�^�S����ar��oqm�����<U~F��fܽI4�]�4IjRW��Ï:��Z�4��XD���V��C�uɶ�23SG�Ζ��]l��sk%��=����z���Ll=<F�~;���;b�`�ș,��b�$�܉uH[$D��h[��b�Y3v���P���*O���K�b�M��?�,N�$�����y0F0I;wl^�~a��V�m�^���È���o�
�Q����آ�����ا��kv��JⰊ�D2�r�!�-(��@��#��>�
�杇(�t��HPZ��Ȗ�q��t��TrZ�u.uk7+�Z]����E��
Ǎ���n��"��N���~205jW�^U�n�i��>�
2	,��l5>������?�
d9)E5r���<�{}�9��O�fؒ8���t���A4%hN&�$�Q�2"��{1�[I J�%s�C��(��r���φ�z̹'4�$�&���Z��/^g�.g�3,h�h���Vc!j/�/�sN��o�����B��/!�Y<݋a�5�|)Z�?���C�c�`��9z�1hL�߀m���h�$!�E�CK���]�y�'��I��gcV�D��`�`�.�|��T 86���]��eI K��-N��0¹���"�7��]�Zr��6	'U�lȐ:���Ѳ�S�s,Nu\��q�p3�xZxu���j�fk�Ut���>JC��χG)50  �Pưĝ=����Et$9�7���l��[��e2�T�1��L�������iKSG������#��Pr��k��#��lu���͍����Z�C�X�m�� m��(4�>��dsI��l�M����ߡ����+���5�M]7�fu�ҁb����\9\8�?�^/\,'{�I��\λ}�e����&D�y$�ҌĮ�
 ]���M�o6H�.�%�<�r*3p�RTf#-��F�R��j؍��T��	#�Fw|�+^"!8�v����BO�v3r�O�:�v�y�������/ٺ%���3l��̏������R����^�p��i�͡U�F\�3�駳�C�u�֡���1b�؟{�*<����*�]8~^٘�̵��L����ܤq"B�ȃY�qj��$��m�!���DA��s����\��Q-���+7;H+�r��A Ay�d2;s��jcdC<����9��m��$w �
�%�0ͬ������OK�t���������n��n�KB��|�P`&�~0fA�yK���;���<��EUG"�|ًAQ��@��`��M��:c�D��o��}�9�6JŚ�F���@��RO���jR�8�b�굡o��@�:r7��$�M��@�D��N��{�;�Xu������&����NU���F\s4]�
�9�������Ms��,�o�Ӌ ��!��R�q�����_b��aD��G2����[�;��0R�Ux?U�s���?�2𹁗��gq�O7[cK�AҺ� eI�@�L� y�A��W�`౲v�[�F� `Z2�D2�eB3��uCc�+�@��?gh�e~��� _�+����F�p#Q�{U��qS�Eқ+z�m��>�|������#��Q��c��߆�3�.���;�".�=�{��LZ�"�0��~ �c�6�RH�?H7>'kj2��V,Z'b�%�T����"����lw=D���܌��|���������ƣ�
[xd�p��ֲ��n{�������h���PUs�q�
�R/
A�����;xӇ��A��U1�����+)�vye�I��-�8�H�D����g��?�^�L'�HE��^��mX��Ժ����?��fn��F�e��q�L�,��+��0���H���VX=@�q�
vу��TE�^�$�Q�x�,>}����w!Ox�S>> ɘ���^&0�4G�ۙ�:�<�/���X;��Z7�AgU���0R�٨��$��[�㠪D�$Vġ���"�P"L7��`>��$�Fv��}�MS*/�'�5�v��6j��){F7;�y��e�fUgV�_��`U`[v� ��^S*���U؝K$z�k���^3�M(��f(W=�CD2�<�j&�t�	w.檇�Pt?�c(���#>�f�ڗ�c���y_k_)�MiU���o�-G�j���������)jZ�9Z��`W�T4.��",I5M��7��\�˗!��������T�ib�R�Y]c��۩ā<�X�â'��<bšC<F�(V����Hjl*��T���ʝ�/양�Ί�����xx8�͆���E&4M�/V@���L˰xyM��\혢{�]�ͪ�����߄���;;�镽b�r���Ko��`����91�O��"w�@NF��؛�s���ަ�����:&�8V�.3��)�r�'MB��U<K�`�`�nn�H�P���@A�){�g}����B-#�T�-�ʡ+و�dD{�é&�=�`��̖�h�	ᕮ�r>.P��*���rs��m,z�_��{r�����x����D�@3v�>�����ב_96�js2RJ��N��%������_BnsD s�3����Ҥ�/y�)�Y?��aVdޣ�I!���!s]"�G���"��>\�7�1i���[iFv�7x�j�B��B�0����`�P����1ՋMh�� ���*3RG�q���h���:�ٹ��#ۯ_�����wc�M����S#��}�8�r}`<�Y[�ݽ�|(�W�|�U�M�*AT ��'(B��
|�Y0 ��0�Kx(L� ���k����G�Zr}�g�>��%�yXY`}Q	���.�/H���i��w���1<�����
�)B��G�~���9�h�q��$�N���m�x���H���b������lh�#[�h�Rt��
[;�]�x[?q�V��K��r�� 7'�ܯ���o���5�d�|%�jǌ|�1��Y��Cц�D6���篇�Z܋��$���=�s|������k��2���$��<�8X�F���WAO?���'i@e�EY4�	e��LW�:Џy�d��������Hl[vy�	mxp2��8�n�2�hM|���n�����+ﺹ��\Y���Y����d����b)<�� �D1� �ü⻿��`�0�W(A=Z$��Z�V	Q�)�&�����ob��I��_	��gr��f
��Z,�%���@�QϑlTB��E|*�4-,�Pܚ����f�p~� (�`�G���V*a�����ܠ��T�l��i\�q�,$s�=#�1�m��Ƽ�l<���leW>5����9}gqs7؏�[;���YF.��;��+��TI�v�����JRǃ~�7�=}>�2��v/��j씼�-�m�h�3�����$OhI�V����o~ ��m�@P�JyE��:���۞�@�\a���&�U/Nx��7|�q�풇���x� ���H�� z�_�^V�Z��E�&31��M�
Q-j�e�P-����c������rc�U߲������pm˩6��x���z��~���Tz�v�  *"
 ��7:����B��N�^.���&�C�dW���o�0��a.��ԙ�}����i�W�YsX�������M��l]��@ַ��w�[���5�qN���[�jla��bkW�K�TF��w?�Y+_p�3ٶ+��p�]�0팶x����n�<e�Z�{��|y����&_�+Otm �;��cpR�t��+v�w��Ua�3��o�6`�F�MU��7F�!�p�uc6�D���fH�1 j���NmJ&-H�5�<�OkI�@l,�b>	�s��Xl/�����Q{�k�)4p���})�ǸZy�6æ�/<@��B����<�QC�<��a�8��4V��)�2ad'�~�U&���s���LR    ~x�G�F֊p�zkk��m���mi��n���tfܣ�ތ1F�f暝�o��|Ma(l,�Hrʩ��@Cah8�!
�<6�B�D[���O�I�����	%�#?�gx�)��kŝ5�Y}�o̒ā<X4ص�;(�8��Q�H�&G�~���}���Qj\�h��6DO�|̤U�><Y��a�Ϟ��V�z��'4]惕�F�r�L4�-S|���]��f���wUo�Q\�辧y���K�}\�m6�M�+4��S��>�W[�Ù8��� [D�I|w⠤��(Z(u����L�y�O��'��i��Q=(�@�l��m���j�`��"r3��i³��Q%
=�qk�A+ �GDՊ3(4�Ք�Kb~�\n|$7[@��Lhi�H(mǓ�f��d˶��b/V3��ݙ�ʞ\��*{����j娶I�ӵt[?�^��Hny���ߍ"{;��c���nvA��.��Dx�r�/�Oߠ$E"�i�}I�nm&��o���x�l!�;%F��y0X0[�j����t�}��WS�pBZ�+�\�\*zq���q���-��):�*P��$�J��j�r�.Q]{�c�*��|y�ί5�KMh��ꭰ�{�z̀��_������7ݨY!��+�JG��U��F�j���Qu�V=j0w�m ��78a~o�rUXW�L�>�ć�ի�.sK��AT=��诪#d����y�2\���h��9�ō?�|O۵����F��y�hfז�ۗЫ���F��y&! V�։6�x��{�W�"�PS�.Bj|(�u渜�i/ ?��>���F��:jNF��/5ihے/j_�t�0���[�)���Ɵݬܫ�Ѿ��o:���f�Ѩ�xͭ��t�p��k�w�eO*e�B C_�ð���Y�L*5m��x1��x'� �-�;�&5Sf����駟�C�Κ��S�@l,Zŧ�|�UmA�4T�ץ	�:�ڌqA�ؠ��kX��̽��#���;U����z�	nn��q9�KV4�G�m�UUAbI�ݬ��be�1_��wk�����J�]�N�lv�^G�*-4j�*MXz���ՠ�������ר]�퀋�$d�:���bN<�Ł�'p��q$ \�V��;6�?닍)&�^�zէS2������flҶ �F�$q V��&#���7�x$��t��{�S2J�­_�0�C �_#D��V��?�sD�@�K:Ȑ�.����2��S��Ļb5���&���at�U_���f��m̹�����9��~@�_��\�5g�&V-�0=��P�m{���R@�Y�n���ϥ��_��B>u���ߧ[{�9��8՝5G���@l,NGʒ/�$퀀��9����3o������Fbh�X��']�9C��0`�֠7�*�P^X�bC����3���J�2��<��@P�"��e��� ���.
/���YQ��^�~���T��j�)��A�
�2MEj�}M��_�K��&�]���BjP���f�@���m��E�\���)}���${h~��Ł<ؐ�,�����H!����g���K^�$rM(�
K�ϸ�1�V�"��M	sO칠<�]��J�"W�f��s�!�7��#�������y �3�2��\,j��嫲��fFǴ�e4��CY�?V����~���+;U�hcQ;���;[�ߴ�e=(�ݐz�?�� O�	P6$ @��#v���˗�&Z��S����o�ޟ{��,����Ӱ�8"p1�@��5��.Ĥt��!{�	R�7�yBlR/�Ɂ?:���=��E(p�n�����v���dg��J���iX�+ۖ+>���U�c��:�g�u���x�����N3��������e	�Q��SjPi���`��*N\��]vop[86��и���Er�^p$W9�b��� �E=�HU?ƚ��ҏl��_���3��}�S��I�sfM�~QБā<�ހ�v�<�s���^��K��Q&kǋK�J�j%��#$<;�̳�\xϰ�unMt�	,��薙���H�mÐ����n��|��|[�M�mM�N)S1-kы���Wʑ{a9�v���.WVR�'�,Y��#�1�l�!�}0�٬�=���PR���e��g4��R��6B�)�"�Ƨ�<4F0S�s_�M	;۔���B&�
Π鉦9���~�=�.f��@l,�έ�<x����z�6]�~�<��(���;wI���a�B��ٷ���������g��>UH2a׆��X�����a&�Ug�s���ݻp��׭�{�W��Ƚq���IW�$���׽2�t�+wl����_	�t�-��,�#R�1�����ck�x%P�`J��&�SG�y��U9�i���h}���� ۚ>�'��LNpz�Pm_�-�y�A/�1s[��[ jB̢�{&�*F����M�,��v���ΛJʈ���,.��-^�2
�Lp�	L������Y'���L��m��ş��ީ�=�k���c�u��~5ݳ�C����B��A� �®�(��,.3�Z��ĤF�8p�~�naC�jBK#������ތ�'�	NᨙnJ�@6�b�ܪ���kxa̮G� αY�{#U`s�"$o���IxBi��Q�!\�.����
Ȳ�]�"�5�l%�G�z�M�0WS���Q�U�6H��l�PM5��c8�͝DCq�&1�N�������/;�W�N6vn���u �����U\�[�� �>��xC|��b��4�e[0Q�|�ZP�$(~Yt�D� ��c���
��5ҹ��0o(��y?�08S

�`���<������$Ӥ=fW�`�`�nn���/��h����_�)P�����[��#Ȫ�N�!2�ղk��G�:žhN�l��:�y��r*��W�5EU��ۿ��^)��e%�F�h5�㙆bk���g1����|x����7������Nr[IC66��S��+0��B^�%*+���-%�~Q�I�?�
�q -g��n�}���3w_{Nb��t��H�e�v�[��T�3��1�f�'c9�Qm�ؑā<�-3^[����v�G��Iu�}9�����F;�K%�k=���`k`^�w����0���=R�%����Z�ؙ2$�0��f��i]g"�5M�q�Ń��^��]]qL�d� ]Îɮ�����Y[�;�k�v�ĳ�u�y�}e^4R���/Ɉ*�H�lO*��8��B�U�g�E-Q+ƿ�7�/8I�q�D��-π��}��'��I�Fn��-��2�T���K�R֘�|i;ť�y[4j�8k��d ��;�r�g,^Ozމ��N���Sv�a$������
��uىY�,�̈yU�?Y�R�ի���l�U}��!���t
�ۈ�!�AY���{͎�.���4w���g���.��I��z��!sj�p�4�?@�1��]�����W��w��k�R���9Zf��3�24w��A�<ϓVb�G�>�y0O0RT�����{��yч���V���k�f+�}���Ͳ�+O�qP"�&e3[U���6�)Z���ё�j�9�0�e۶L�y���ɚf3St,h����5�,U�vq}�rsq��>^�<.�8��%X��/�o <��"��-�~/��M2�a`�LD_�M�l��G^���"�n��{]{��m`h
xS�H:���g߰U &���7�CE�뉦2��:��>F���$u��[��>ir�M��|l?ﳅ��x6YT��p�-��Bb�&0�{�����N7�֨�������-��Ȟm�rѶ�"�W4S�un���ZZV{4���/}��<:pn�ʇ���;@��"�x���ۀ��Kg���߽
D���O�5"$nb���`-�v����ݟ��i���5H��ii���Ƀ�t�.6qZ�Ƥ~<�����=��άM+ƍQ牫6��l �}�;��X�&)ޱ��%�E���і~ �+�M�m6�+�_n®�bu(}�KwXp[�n�]�]�7Ѿg��h�~0    ����〥��l��+[��I�5E�ܢ���F����Ĺ�;>V��j���В�Y���C��W	����O���zP���p��L�3�ÙL4��|Ё��+���z��49'���1�&�O��>��gy�S��IZ{V7F��y0306��������.$�x#E�+�j�?NE  0��R',zA<��և��s��-�1Z��1aA�m:�+���>SW2[�{�h�+s�JX��t��<����^S��]�G�*E]`�)@8��������9�Z��A� ���l}(�����&)3XHr�Rĕ�"�9�nA��d ������6�85Ӟ�蒄2غSf[9>���O5E��Nw_{%@䒈�q1
�q�
���Dp5B�(�v	�Kl=p]��m��esw�	��K��ڍ�N����b�,L�a��
�YN�T�������wr�D��z��D]�OUC���w���P/�@\D3����ȳ{���%���]�HD�#J2��:!�Mҗ���Q,8{�n�If`Ҟ�q������/�N����З�����O[�3|��5 T����(���H�Uk���V�l�w<�D>`P�ZQ5"O�\�2e�2�!c�zVj���u���v��y�`=*W�����N�/1��#AQ�ç0qp�k����tX}
�\D)��HN��U�yb�f0`�/a�KA*{��๷�ݛ&v����˛������C@\��@�? ʣǉP-��{B�1�7P�IՇ��i�| [��5��j�ٻ�`���$��N�~P�g'=�D6�����c�W5�b��}+�.KŃ����U��X�Sb�(َ��5
�2�&>����W���U@�]D�D�X���?��활��D��:MI2�5�ż'�O� �������4�&�A�t��@	����E?!.�`g|e����Θ{.�[yF������+�Ml���L�����.F��,,i��!;�����[���Ug�z6tUUڍ���N�+o�w�dt�YkJ��
�꼄�o������p�
�? 4 M,!�ԁA;AK�e�6�{���
(	β�)��[����q���������޿;z��J�f��6������L��[��)9���onE�Wc��"�oφ�+�|�w`g���x�iOz�MzMa��i)����,%+�{�Ջ��v�����(��|������΁���Pa>�a�/z?��	^z
���������2�O�0�K��P��"�\\�_����|.�����4T�UG?�s�Qs@x� ~h�G��J5�ט��SSd��1���Z �s��y�$=M���{52���	'���BvUSy�>4��2�+�g��f�^�Q��~��k�n�|'���X��H�{�G�=�W]� �7��1GD3��S���;Q���\.��p��Z <��Qĉ�4Q�!r�Dj�f�����C��2��}*C7�♞����=�����M�:��˒ā<��6���W��(H� W	B���$�
[K�v�5���A�U )��ش�e`G`��}vJ9�c�o|8-��.2�����
��dC�Wa�u��)��X�"]2�����̙<�(��U_i;7��q��/��jyJh\�(�5�m��((H�^�|)A�#�iT�����~6�捕l������~A;�S*��" �m�*/��I�OD(ht%��G���>�'yJH4ٌ)��v2�O8ȯ��/��e�h��.�ۅ	��,q�9�5��K�C�"�^��]-p�¾q_nwkr�0���+�]O8��:�7]v\˱�pU�PU6U��6�T�檺�FY䚵���+�����m�.4֚-m?���sH�$1��]��k���z؜�)��i�!(�>a�0���W$,�����8�v0��M�Cޑ��S����	]�Ȇ6K ��%��Ab)0%f�bB��>����N���(�=�Ӛ�8�;k4�5RwO���gR���;n�]�8�D#t���Zd���P������=XY��i���8�ce���Y&�4��Z�l�� (oլ�Tj�`na��/6�����^p5���B��OC!��J��t��D�{`�Q�0M̟t���?�Д~�PV.��8n.#�91�i"��tq�RR�T�$���RskL�lH��*��>����Mw���}�K�4�y��K���q�c�M��o�(8J�<���rD%�����5$1j�g�q6����}�sN`r��d����� %�U��]֪
E�lɚ��������1�j�-�[�'�I�u;��ls�~�pc�6Ty�[t9Wy����H[�¨_S�`����5��: �#]�B�/%bW�$�v޻;��L��9�۳����`4`:6��=H� s3T8=�A�IBm��Y`àm��W�.妏R�7]�ca��^���f� b����lE�N:��œTHrZ.1�h���Y���5y�toٸ�7��J�Z�&�X!b�f�R���J�ڞ�X�3#�
�a��*`)��t���ń�Z��HǴ��G�J1P\���}<w�"HV��ZȯC(z���yEZ�fr��Ls�'mT���Ys#oJ�@�l�I�
)�A┣(�;��H��^4��[�\��b!ƫH�\�r�b	���q����S��4UVdõm�=wCݱ�V&�9m��iY�nu�ҷ;�s-���"��� ��)�""m�7��eO�l��c�����
��U�&�����Ѥ,���7i�M��C�b��6'���qNd	l"!tW� �x�펧<s3,�2��$�������nR}V�7DF�g0��(���וt�j̳�.�w_&�X�ĢR��Qo��߀]�㬑�g+�?��e�QkC�]VmY�%��I��_`�gA`6kl�D篌ۓV�..-D��Ym5�	����@
�g�[T�����
1BW �bb�=��4���vBn>�0��9"��xn�O�9�J8ͩ.:���R�3�맚�i���4��O,��
�?U#!�L�l��"���=���){�=�y��mD��/�d��g>�D����j����!�"���dͧ��� ���v7�bg����J�4�D(����WȲ�����ܴ��EG���w_���>cᑀ���ߋ\%�J`K���s���	�p�������·��1�B����.������75>����`��S�b�Y2�6pG�1�������Mxډf�J�+j�����~������. Y��� \W�J��p�*�]��[�v+�UŘ�+����%f_ҏ`1A_�_���4��-�4� F)��b��$�m��'<u@Q�0W)��u��	�_�%�tp��\��+���X�2��;��&��3A-6A,��Zn5�K���!��Z��$+)N���^v�-��.�9L1��y���q�sNdufu�*��ȱ���тz�aǟm]͊��/�/{�������j+�'��"������#x����l �.�J�&*2tTT���`H4����f����m|���~�ﾦ.�&�+�{l���"%F�+ $8��Оg�=��ͥc&�t\�i�z�&Ε	�|�E^=�q�>��`yD��+c-��'E�D�t,Rp�7��M��1�(��-?�mWv!�Ӓ���DK��Յ�j�cf.��s�Eg��Wv���9����/$�"���CCI?������)D� 7����P���zv#�c�B�&��OƮ���5I"�2�@�;�ĝC�##�7,��	� ��]UWGi�@L�������n�gSUP`\!�jv7!v2 ew���e+[P��Y`P5Nk��,�fP1xAM�U[6���@�m�[3���׵��+'�����u��5�^�s��B�% fC�K����|���"����!�?����aҠ�\�\��i)�m��P x���=bv%����HFxH����������(C/*�S|�B7�A�u�    �
9�f�6%Zg�+"m�;td?���Ϧl[�+ۚ��d�y圖+;=�8mw��ܪ~��h�m�Hb�c��$��y�nx��Qwv��է���E�o����k��o�ֈ�@:��^�Wj~��jq.;^�GPb�����Aw=�;��lM����9\�6$q &�e3����B>ϼ��W!����)<��8��JN��n/&~7c�z��N��Tޒ�ʦm���j.79�zF��n=`wi�v7O�_��\m,�J�GHh�HZ(��+�Ζ�tPk{�F-jՂ~X�"z�3i>��k�� �;~��������@�N��|\)/��8�Md|y/nb��+i��j��tā<X؆���4K !d��k��Mu�*�w�.=��%�8��� r1^n�3U�--[�]�7��]}�\v���x�7�j��!�Q\Y}D��w��^vV����N9�k���uuau��ϗ�z��1�?@<v��1G� ����Ɓ�U���{B�-�~��4� d�H��i��Zf �f��A�� M41C �=�~Y��k���נ��A<Ɣ�t� �1�bq ���~��AS(�@����b1^�{�V)X��
��۶�XZco�S�� }j�z� �G�|��P�����=M�B���V��T��6Ű���W���]\��?ܾ|un�y{�nқܠ�v�� �k�����d�,�VPJ�3s��A�I��(a��^@tpC�ů
�E�w3���_�뉥Y�hj"�!ژ�{v7��3;6U}�����p��q��G��@���F�4���K��$���3&Zr�ok�g�V �a'�)��'�9�#�YFDfH`W��j {t-�3�̶ӌvV??]Z�/.��;�b�<���lG�{Mn��d��A�����)�Ёq(H�D���X��ȡ ��g�� mMH��~�d��Dꀮ �B#�8~�N&����[��L�����H���`3 �@��y���C��Nݺ�(��R���ɘr�FJ��1P�s��Y�3M�fV�j��TU�[���ɮm�⳩eͲ�ֻ�������W�V�_�L	�B�σ�����q2'x�=,�B�TS�%���ⅷDj�]���2W-�,�_��?���|�D�HXuj�c[��	���>�`�m ���"�����gH�yT��	��@�ݤ��b&�ҳ>����2n_��`�`�jܘ�#y}�$�?�:��f}���顽6�L��9�}��G�D�ی��w>�Dv�σF�+
3ZSF�+�������rhW[��~��߿���	�Ņ&�=p��C��o8�	E��"e�d�#�v�q;	��;/.o\�ƅ���w-�ܯ�����⻸��nq�k�L4ҷ�ne&�a<Ŵfp��@�Н5�!��$�����4*(��K8�a�I?I`�{@ʂBе�3K�m�	�H��6t�C�{�<���p:9�sLh�62n��;�SDy�i�����mE�'����*��V��d�p�8\Pk+K+�M��S�����k1��H��	����}3��3ˠ�ķ����u�ɟ�"!����`�q�A#����2*�0n�P^.>��0��i�{�z�Y��[�y]wsNN7��b��E���3��M�14��rgh!���dw��-,<�>xಡ	��n(7�w;�xC����a�����ɹm��-C����fn�>m{��*��6�p��]=9Jղ���W!����c��`�����d���Z��(�'ك�F��f���d���>�3���㘁�r5lS�Y�U�R�h)��*ށ��%��2!��XS�ܪ�'`Iы�Y'LA9MG7�1�OrΉR �/{5�Q�(�a���ȎiX��d5��y�]Y�9��N���;�7���O��4��'T�dBjm�J����ɬ]$"�6��1����$�U��r������N)��;�qz@����)N���4̞� Gi�8���3�մ��� c,�hp��|���J?�g�2�f�oc'���7 �$�q���g�e��Vu'WޣN>��Qr���x��Ke�c	��4�Te��g��;nV����Ɂ�Xjw�����a�|�U�B;Z��\@��mQ������7�����o��B�< 5������Z�PJ����E��|Րw�	��(���z53��RC�w�j�nË¶T%k ��c��{�3׎"��a�b�-y�>�z�����Mr&PF#�n��}e �hvO(����=$~�����|����,@7���Q<VP4���f��bx�YE�B�e󼪑�Mv*�(UCh�4�E0T�]Y�\K�u.d��F��J_���=�Uy��Z�^,;�����7�\�
���aA��,?��������DYJb+8�%���q/�\��_
�v&��
��.�q�Ŭ叀7�	��gx�O9���ڳ�1�k�,Wȃ͂�Z�B�T�b���k�e>�ŁsRD��+Z)��V�L$\�x-�5�e,h�hq�|�.�䀪�dy��6�z7  �B��y�Nя"�zM�L��,G�ƴ���m�,���U��q�v��d��<�0�����st�x��>��hsp�ҏ@��8)(m���ݛ6:��,�J����#�cB�8t�]?���J���>�`�{��v;��m0������M*w���iҕ�l����0����i�$��]�`�`�6'���oń
j����1<�@���q�
z����>[�m��d�r��d�:�w�m`�\S|v5;k��f�/���[�������޼%�ڃ.g����i.�<�px������w�^ւd%��э��\I�Ϫ*���
���\���D8`���q�UbU~&���v�0�Q�sqՁ�k��89�{
��-;�{�;巭1�h����>]�W��뙁��fkO�sMd(�f�@Ҳ-�|쳛�q����٫V�����Tzۥ���4�Ѐy���n9LtqKX^�LBdc�94��C��`��5P1G�+ȼ{�*���7� �xX�#�g� �=��)L��a��B�AG9�����D����԰E��_�gb��s�m��5ѵE�+�L/lo�y�XF6���g�(7���8�庚#ۦ&2��bgU��h]K��aԷ/獮��� 0�<�h�l'�/7p�����h��mb���>�)B�����!Q�oD�p~h��#]!����,	q��g���	���ʬ�����@f:��%9k-W�M�K��� L�A���ZU�ċ�<|
8��Yf�V�w;�D{��w �%�f�	I�g#3���N{��(7�.7��^�X��Ά	Iޔ���K���j$}�_�hx�u�������e���3x�?� ݿ��A������i0��{�����7*�FDLbI\�'7��M		R?���}��L��I�ق�K7�jm��öG���(���ܤ-�e@�m(�����y�и���bK<�Ҫ�b]�F#DϠ���e2�Y'�i[y�9I���5�Y�۷�����EX������e%3�g�z(͵�zM�u�&���a#x�x�/�N5�.�n��[1!����)wA'@���e���.9����TY	�JEԢ�B�5�BD����T�n�C5��2)��R�*R�O���z�� �� a�x�RϨ�>�9�*e*�.��#6%��,m{\�^-\]����}p��^�='��{��9�K��Wݻ��o�U���V0����3���7A����gIHa���6�Y��@yՆ[�5Iȃ��i��$epsxأ7�]s5F�>��P��a���z��a��$�60A���ه�����y�pF��������{�x�pjY���Ao�Hu����m%�����7��o��+�2��]�_ ��W(u:H�����G�/�Y1��ۘ|:��{�M���[q�	J�ˍ�]+�Ӌ�Ny�?����3�;��%~��L�Y����g��ƥŔ8-�"�J�s�qAZz�<4�՗qc���5U2�k�D���R�U�Ϣ�{�2vt�z�S�,Q�F�)z	    ���9JV�ǩ\f{T�+��ҵtK3e����Vܬ����|{��]�ɝ�e�٬:gIGn�)�������C�gC-�*|l���e\���uX�9V��K��}�(���nh���"=L�O �aN ��d3I�A�yP�d��,��i���b CM 2T�V�F�/u*������"F�)>dv,�MK[^ۋXxF� vv}9����]S�B��ۤ��5��锸��y">ێ8�댱Ǩ�GU/�p6��j��u�2��5�(��+ٺ��mf�m\����Ũw�nwV*K�Ur^��g2a
Ht�GƠ���l�oz���>�6�*��azB�;bL#�I�(Q�	m�t,���^���H�H�]j��Q��VBY�N���}+�0�,N3�� �m#�Q�HV��$q fo
�� ��ۛ�:��yrh�����+wQ��/[c�)Va���k�4�u������c�������r+�UKsdU�\TQ���dݘ���r�WWL3�U�������^�(n�F�)m�xH*z}"I�*T�p'���
�6�-�.m�-��Ze��b
��������3�C�i-D$ߴJ-�˞�<��Oz��,ۼ�a�EM�`�`�Vn�k�õFr�9_M�Up[;�\���_�y�rL���#������3VcBײǕM�t�g�VeCA6�=��q����U����q:�_K/摆����d?�q:�4�0[��v�e޿�%Ҡh���V��ͦ�E�<��l��]����}Q*L\��ܞ�mOgz&-i\�z zR��ڹ�[�j�X�O",�&x�e\��>�$^4ލ�Y�)c���=�3Cǒz
Hy�� ,�'�YxFA�b��z}���Eoɿ�6�0k��pC�LHtta�^6/�j��+[ꞿY�R0��w�DQ����i�Ca��}�wo��N%����8)����R��N�+`�t�
, N�
��q��d�+9S�>��|�Y�S����y�A�D��#�^]pw��$le������3�/h��v�9�ۂlI����".$]BT�m;�vȌ��be��Lzމ���j.�P���\��M�2-U��>ר�22��w/����k�U_m��E�q���2Ŗ ��Z���V6��v��gH�
vY@ſ
P]�M���Q�@V������Ϻ�|f;��;f ���qb�����vE\$�xW�7G�$��y2��@c�s<a�@۠�WaT%q �	V��4��a�D�Qְe�D�Z��dSpٌ��h$�՚�,ְðeT���ڐkB����3��Nzމl�e�����{�s�Ts�f�e�g�Q3�"���^�l�?h.��fq]�J�l7�5"΢�ً��P��u��!r��S�a5��^IL��ר����d_Er봘6;� ��!�2" /�=����L�>�:¸��<�3.m 'K��S\�X�B,pڃ�� +�o��C��y\���7�^@�D��"{��7�*"G�G�1,���1�|F���T]6UU�-�ʺ�5/^�\u�p�B?�ik�|��SVF�s�C6��kT2@r:�`�Ҟ���D�+�4��
�k&�@�9˔��w�^Wf9�̋O}��^G��(�����z�פ�`��Ċ�.x�75D��iQ0��W�(Ah\/8 w�H6�$i�-��KnU��� �
;g�V3�<?���n��G+��ޟ�[�l[N��~�lG'�_��;G��s��v��1C��O���v����k���1XDW�չ�\N���EJ���>�й7^Xަ�V��P� ��o�=��Ԥ����4�=�۞��M�ݨ����2�3��i��G��	*����0k���/!�f��Re�U�\n��- �G���gL�������d$�z�����*��'��:�@L�\��h� �ҿ�f��idEKf+�<mU7_m���f��k�&��c���s������)��b�&��B�g�1��
��s����U���ķ���Q���L��[p�D�!�쳽����y:\D.8�8����8x�����PP�;��j��t�_��Pt�Xv��֝<��c��-kr�PeC���.�l�, �\ba��܌���\dBf�e��
���	J=��+����j�W����������v�ٟ7�SM�t6�K��P�Ġ�pu`<�����e$Q�*�ZIi���`f�c��?�jV ��C/�(�>f"ֺ�ya��i�b>�fr��	�r���Xc�0X������p_~��C_���~��?XSK�p�>x�-����1z�Fي9#�e�pE�F�.re㊅���'�A��58��%&4b8U���L��-Mv-��M;������o�֣���q�{�U7Rй.����/=��Ɓ���$Kc���ݴ��_�9;W�) a��B��@>)ZA1��������I�g�RG�`�`�fn�w	/:vÁ�苠sC�QD��Ę�i��������|�cE&��]TV����U';�&I	��]�t�%��4k����YV��ޫ󚥫nmW�M-^:Oy��M�:yo�&�[D)����΃$�����"���$����]:ED� S�ld&��nu��1iN֬1�,�H�@	�ɂ��W�f��b��$�}A[
.)�����#p�E��|�|*���ø��+s�%���څ��5B�$엡���E
��W�Ld��b8ِlS�Ȥ�)p{��MÍtUٱt�j��u<��3������v�`Wk�^o��������wX�r�v<oH����c���OE�(~'w�#�j��"��8���!��)�g��텀�z����s<i�Ƭ�̚�}3��`�`�6�-��qi���RL���҂_��g�O��/�
����=�eڗo����H}��V��\�Cŗ*4�չ:�nf��?����-�RU��[��]^\(%ǰ�*��n�e�Tt�9��bM�t��;g�վ�Y��Y�F�h����	�C�:���Xi�2�%�{�q�W�O{��N7���k`Wz�j�J=�qw��?��g'r��d��g��!HN��)�x�f��z�'���Z�f�\�����_Eh�� ����{��¾�R��J����"����`ƈ��I�+�0����`�*a���=�%u4t2�l;��.4�e���vuf����g7k�F]kW�h�h��\鞿zu�./&m� ��
c�6�p$�F1F��m�&�e[#b&bT�A7Lm��K��؏/1�?��_�i]چ+�xh6H?�G<�.!�K?��=�{깝�bmְ���8�8��+vs�<y�@���)u��)xD@碏��+O|@�mୂ8�F��\jjm8%�1�nA(Ы�%�.:T�'@(AD�o��-|l5[�x�W�Ю�T�`t�h�mWљ]����ÖbYs�L3EU��־����P���y�x��Ԣ����;Z;��$
+�$O!f���:�7��I�b%S��[�7��>ČꗤlY�$O�[Z\f�f���������?�(3�y0`fƺ2����1+�<D����@�p,A�U����x;��)�?�I���� ��<u��3�C<�ժ��l<��Z]��͌�T.2��#>��jۓu�4��Zn����5���;�����Rp��*�J�si��k�+�����A&��m��#F�(G����b͓7[݇|�^풜�������w �����S��i�$��0��)-$!S��nX�%-nXa+ �j�����et\J��GSfg�cw%���x�y���6|#��c�=���]8��yE�q��fMۿ�Ȟ�6dfȺ���&~��Y���ō��yI�֎��7{���l&�^�D�|��'���wш1K�wEeI�+F���y�����8E��	�%�����D�e&��o�	fwROj���=�C�0z�VZ�Y�1Tf/�MI�"���0dBn�<���D_���Z��q�ɶ-o��ȃF�,�ة��@�v�ܖnh�i9����    �uJ%�Qm��d�})�=�<eӴ�涖��ʫ��Û㶼P1+Atuz��|���6����M��j��n�� �R�w_��5r?,U�d3|���CZ2��A��w���q�$�O�0�@-��,��7�����M�tk�����`q`wzn`̢t�w���K����~��������5�y�P�fRY�3��F�sB�@��Q�V,|+�jd77]���x;���[�?�UN��ӭ������Ћr�����/)s[���8`}��v��`&A&f��YHΥ\�$���B)�k�������{~{��uɍȚ5���.l#��`
`F���F���ݹWZ*Hڈ�Ҙ�WBj2�f�j*I�L������NQ�̈Px��'4/a7��~48�A�SeK�mqL5���^���5kei�_�����Z�z��L�9[UL���pK�@u�V��6t;�G�F_�!��YG�rEp������4�?L�HDԫ����h�XO�D6�4jc�d��7j~ �Fm��?�ׯJ(Ċ��j�d�zS��>Iq����e2�����{;ݘ���vpX��{n��@1x���8#���6�x�	�~d������eۚ|k��Ե���vY��}��evPׯOk7����A�y|�stu�vt�7�B��f4A2!e(P���$�%jj����Mb�O�M|�T �ЖԪ(�T������9bk ��:�����@� d�$f�.�TB�f!�s@��K��_�x���}����!ac�>Y	�H�#�J�r�	�$ iE
T��C��*ժ�1��ȑUA��P�e*��<t���IR�@J��V��ʪ�S�)����Ӻ΄�C5���~�Ȯ�ⳙ7u�-w����ZemŰ/�����?��+������sl�xw��Д#9�q;�.J��A����&h�M���8��ٚF7��q�dV���=�]$�_���YuD�ȃ݃�۹S�ۀ�Y�B���Ub�h��4<dƁ$�w��i8����u�����A�c��e2���:���**s�m˴lױ-We۽"�̔p�m�ye؎�f��u�{{��*�u��k�:� �R���W�ڭ$��kr�ux��%���%}���,�A�TH�~��T�_�p�Ǎ�ۦ8���qr �^ؒ�@� ]��$�`�� ��[�ÿd��\����6���j�)ׁ
�̄�"2�L�"3 DK�EXB�@E����Ռ�t�	�9N��T<�O(����k;�j���?<�kضcd�Ѭ�Uּ�-ca�XR��������P��jr$��>��B8#a������
�ei��KHUE
[�w��~ܼ��J~`f�H͌̀�D.&�0 ������VI�G���19�!>�[Ir-p@ Y�m�yX`-ps��,਩D!��R�����I`� h�z��%P���R���� �p�B�W7=�(�#O?��{]8?ٲ�,,�6��jV�cgck)j����W�Z�Z^n�4ҵ��c!�$��^�$��"6��������MrE��a7p��aٜ*? �lhԺ
�a� �'^:%��'��Pp}���4S;m�lV�QƊ�`��X%��y��M��5�����x�~@20��z���h������n�W����������<�m��(X��X���������=���=�X�ܪ��y^\���[�v�Gw�H���6�A��U�:��0��j��o����ZH�ہPG��y*�*�~13n��W�8�9��,{��f�a(�-�y�)�,5�� �z�&�p���<���n����6��\��aWj���0���ǀXW���Ot�	���G�L�8#ʊ�ZF��]�L�)ʆ�(�㸚�U++1��At��s��_��|�X(�-������`P�Z��`�Ǡ��.'=V<)R���g�������@Z*�A����{�7�#]���	�� ���K���^��Jz��,2�k�IYO{�`c00�q�lc���ݣn7z������P=���Y�Vr%��NQ�vI6ڒXY�ۊXq�⋑�ժDCȽ~��I:/�Zx���mni��U#�^�&�jP��@��(lB�Ѵ,q�Цw�x����q��
{��v��St���Z*�R�V�$��C�Dd��l�-$�7r��y��.�b�%\�]�]k�|�v,�y���ڞ�w��l_N54_6G�����Ry�d)y�y{'�~WH�lHЙ32T|�i��M���V���x��b �G���4T��ʙP<M�7K�IM���SeQ�_�7��
�[���ds���>֏�1�a/��1�.�*�@6�"� m���N���^a�P��X�1�˟8�ހ5a�-d�C@)��.��@� 3��k��9�d���4�g��^�$�T��j?<	���y0�e:��:z���������9���vx�$�\;������S��!��1i�Y�ia��<^����K-�����<��Z#����J08`x7@R©�8��c����`G
̃܃�Oh��h���E�[�^�p�C��K���>���s�~+:��j�c���� '�8݁*mb�'��1tRrN:��ĳ���tð��A<h'���F$Q=Ms�y���݂Qyi�}gmX&��3}���^��8��U��ф��/E
��ٯ3�gr��xi��g})����DR���=л��Tʚe,�5ok?P�Ͳ�-�m|�ئO�l{a��;R|a9��c�P�.ۢ88�ٖ�dJ ;n�<��������Q�"�"�Ë�b�L��ó�zi�ΰ���k��yZ^@�a�yq~�<��W��/���|}s���$�Wޅ�G8g̊���O[������T+ ��t�:��!�c<")X/�ͅ��H�����0�۾X��ܠ��7����6�����ǃ&��'�ے��W�I��]t4�t�`�/`-���c���UCP�Z:Liʋn���YK�յ������0�f[��;���Н.$=�qm*c`>h��}�3N(�l��5���ݛ��j�ڝ}s�"0�G�����L�5D-�@כoc
���M�� �������Fb#���<o�Y �FWM���/�9/8�=���"�w��?�T�逜���h��1�o����u�;V�DW�wʗ�Q�B��o��}�˛����OE�.3J�|f��v2�I���d��2ƟRz��x A4@��ɴ�mY�����h��M���S�e��>���ɿ�Һ?E�Ł"sPi��L� �����+La�=����_�V���ّ��JLX�i�7�GBv���� ��"	�Tau��'�e�Q��qɗ��efU��������窎�z����yK�+ǧ��%��^�r������N�/�����7b��1	j҅"am)K�)VG����M��[:����V�����~@
D�8�&x.�����%����/����<������w��;R����([+@2��^�+�T�/��)�_���9h@f�����w��S[+�X<� ��c�O�o�$Tu�u�={=��8o���|���]iF��vЪml��.$��y[�`�mN�������;��^^��jq]��ȥ�絈��&3f��|1�FP�D@��_�&--V	�U����  X¹7	S��Z���|�l�i*����{��H#w�ڤ�
U|�M�"�P����5�-qV�^X͢Mip�����/��ѵr�0�M���K�.vZ95��o�H ��K�Ǳ�z���Q�Źf�_�k�c��%Wu�s+훟7��t��Փ��=�;��[ˑ3�n"�OF�Z9��q+ʶ���akl&sb��R�Z�˔L[U��۸~���
����I���o/:�6�B�+���n�`S?�g��̾��وƲ��Q�́>,�cBn�����W�0bz�����~���M���q�Eq `�
�3'$�N=�2&A���_�&�t�Cu4���i{�N��>At���376w���t��V2�#    O�P @�7-�$��IpP�U��l���fHMA�i`d�KH�&.V�����5K��M1,�D�)�~?����-�Qa�)���<$J������)�����؟��?�f��Ghv]�Q�*��� ��mv˶�'��e8/{\�Ѵ�\8�ڌ� �0����[����nZ�m���?��/���a��\6�nuX�U���d��ka%v�L,')��ȋ"�pt�R�nu�z������,Ǚ���< &��(ѓJ�B�z�Ed�7�P}����>?P#�oq6NmI���bC�&_І9�aO��;���`�*����0,^@�8��aj=&�$�=��Ϩ�'�Y����ES\O54���4�Λ�2B��bc��ܹ�:_���'��lǮ\�9z4�؄����� v��R������Qx5b]/�+*��+�8՘S��1�,��	���������{PYߌEӺ=(��?P+�6���@a����	FZ�!{
6b�mՀi���c/ހa-?4�!�RYF8p�3t5N-�$�G�X����tkj���n���/7���1�6�j���>��\��=G|v��k{���,{/��+��/W��˞S����~x�2^6�A���b�����P[��8ŀ<͌Tpo4eJdg�l�hz�t��_�XT�A��I�}_���sY��bަ�pq�v��)<^A�����7%n���sO%C*2�^��6�a&oØ{A�CO�����c�"aA�������3���_FD΅f����ns�t<M5]�W���z���ѹ�tO/��he3���5�p����m�ӈX�%��x5e$���ӡ\�hŊ�q���Q���������g���+��b����ߎn���Q�C�eM�����{:�8P��� z�T�҅D;g!a[�_̗7)��?���Ԁ��sؔ���{��@�&v�9���t�YSZ�j��3�������Vm�1�m�����t�Z�����˓��a�L���`�JT��({-&{S�
�oq>q�3oX�I:'�>o��5ǕmB����1M�8�|�Z(<�{���I������hN6�:�8P{����dF�a�{��u	�9�&a�&y��gH��Թo��H���M���b_�B��6'Z���4�?l��vo�]3��ͨv�-�l��:>`+���[�"V��W=G8��n�y���l��/�ύ�3��7�֞ɥ>q�ϟ��� l�t� ,i��	���C88s�֘{��J���W���1��mH�쯯��0��Q�R�u@4�����u�����|�E[���]��E}�)�Qā"XQ�|h:�͵�m��M��2{ռ0�Ǜ��idځ�8Qy���o�))�4�;	BL���߇gr�|��/0��{Z�ᅭUl=����wN���h��Z�j<�?���w�?��ݽ�ݍ��}�=����ɧ�_����I�Ƅ�q�1��-�o-OY���� �!3)��O $�B�떲}{�dg��>�}郬��"���x�E(��g:�h�Mr���'D.��ŋ2H{M;��~��ʉ7�Nˏ�����F�ҧ���r\�O���.e�
��Z�~��x���=�������{r�U}��p�v���ə��g��gO�܎������Uh���0i�:3c�M�m֖78cTv�%Ʃ|�s��	}rn3u�>9��a#��ѳ�p/�A?EI�k���7� #�W!W����c�x�m��;���2T��{���)���7�yg�&�r�J�E� `
t�[Z��e�eX�jZ��������W�����F|��XN"���A� ��#�9F=_�y�L@AIz��[�UJ�Io�j�w�IP���R-�D�>�s��A�Ԝ%P� ��ޮl�E�E�AF��IY9	E�	�#	�̛�a���s�7�[�j$��^%�*%]�W��f�fJi��{p���߰��+~��Z3�!��gYDV�l�g�*;%7k��՘�3�{y��º�X[�4����=o<ݺ�==Oٰ3����vp�k6��d���i�����-�b⏈̰UE�6^����󓍕���L�����	���w�?�nM�&ڢ~�=��`�a71{��b=n�Z�1<`k�>�Y�����׿H�wxg��`9�h���T�өI4���BU����ƶ�DuTvF��{������"�"��ߨ��vpv��l�\�G�����2:�h'Y��
j�+kU��-��ȰA�Y1&���"�?��j���&ב9gߌ��Z|�4�N���x쮫��-tij?�
���SNe-4a���	q����*P���ev����bNi^��`b�ʛ�{88ե�y ���s9��r��������3j�%%��Kx>XsO5=΂�>{Z��:�޼h�k�֯��]gd_�3s�~p=J���>���	ѥQ����y��rا��1�b�8�t��ڰ��"��� �LV%�j{aw3��c!�h�7�r���WùMG����`/A_m�cO�՞�+�S��fo�sMy
�D0ךʿ�"�l�`u�GRwa�?���qf<�JjE��]�D�S�B�
y��5u��B�SY�c�Y�]H�6���.]����U���0�%������߽6Tܸ�@����f�	qU�#"���s6 ̪V���{!��<�����fU�j�4�x��T�)� �Yn9�&�O�)~ՒF�N%wFj��;�{Č�x���Z��Coq�Y5��\Ǳ!��;���mY�g��jCj9�TʜJ�ʛou�����-��4���Օ�S�P��]�<�d�2�D�4�����'��C�6������Kf��U'#cc�xvd���3٠�wK�.c� +��y����`t@�6w���Q�_8l��#���Jo�҆t�W��&$0�.f^Wjo*AV���!���$�|��� �h?�Մ���5Qyq��*�t�5�	��݋��1}s4���GW7Ձ���]/���w(]��^y9j֚�kU�2<z�w0<9o�'�����%����*��  2)��gx+�r)��3ǞÐ�E�"�l?$q)���d��+�M���D*�E0��)x��X�`�`���Wxcn�ò��� W�m��s�7f��|nf��̨���fj��,����YN9�m�l[���뻪��<kk�����F��j��T�\>Y~2Z��z�����](%c��tC8�sd]JUԐ�6\�tAJ(��x�i����e�P o�ik���bBgXr����Ґ���;e�����b�
�����j+�@L&�_����'����6�t��D/�i�!��b�^u�ܸn!-�I�u %d����
�W�?aW�Ԣ�r�9\b&�h]e��,�slK�|հ<���l�R=��6��-/�}<�w����9$���i�p�\������j�\  �e���L�Y#�����l�3n��%��-z<���$%Y2+O��0��N�U�#�,ܐcʲPx�o��d]R�)�ܶ��� ��hȇ�`L2RtK y��D}�I� :��0��ĮAۆF*1�5]�kmB�Mq4Qڰ�|z<�K̨�`Du���a����]��wa�E����L9ۣ�m��fަ���o��n#v��:Q7N�,��F�7�MN��!V�&�	6?y�)������Ն5!*Yl�0��
$��~]��	�����ͷO���Ξ�8�/�`�����-w�zaU����)�pcL�S�Ħ��JEMv�lf��������y[�k�9�I���3�6{��hV7߅&���j�U�U��ܖk�����V.�����N�I��ioxX���{�	v7�>�U�M&��r���?L��K|��Wr:��pR�_MM�����Տo�s��-!J�S�o��G�I�Ǹ�F�	����I�N�]�:�ζ�Fzt����9�����T����d�m��־ũfTM�a�y��QH*���a��a��g'ol{}�v���'�˰���O����LɄ�9��IK
u���$���dV�����!�b�3�2C    d�#~�+�l����/�L��q��Ƹ��2m	A*�V�^��ˠ�#���Ta2�c+�@� �Y�Y����&;�����ـ�_�i����0��h
C�p&<u��	r���S"s�j��e�f?�eY�f�@�t��,_w�0M�ga��z�f��kȟ�yL�
�/֢������9���<�<Z�]��.n�AI�8��jD&?m%Ee-���_G2=�N�P���׀cә�f80��A���%Q�'��>���q����*�1н�_�<Nn>WX�z�o.��$�0�YB�Om���>}��]�(�]��H/
mj̉����˧Z�x�w�+���>曎jFQ�
/*~�({��7�#=(�]�m�"w���ռ��j��>=_�:Ww��o���o��|�pba��Z�N�!����Y44K������G��T�$��ø����	�2��N�8P�
e���Ь�=���4�3�o{�����X~M�I�#�8�A��#u O��.�`g�e������o�W�QY\W�4-�� ������-�i�,�3}����.?�z�膕�������ђY.��^`jGᝈ��HH����YE�b>��Q�7���w��j��`Am�G &�64g�BR8�?%��4^�Lؘ��C7��8� �M�����d�(;ef�F�v�,�<�1�>vXL��ԯ
�q(��}��U�9��nXBmS�K�oo�x:�Z?֯{�z�gvv�^ܚ���Ͷ�J���K��v|bl��r:xz��g��F�CLɫJ�O�ݢ$7`�0����&n�lVVp0Y���G%@�s�� +�q�9����(�eEw���
:;�q�;1�vÄ߿~՗|������4:�0 �<;��� ��ɱF�	V�D��v�|Ma3�rF�_ɵ8)����M���MuM�����~^~��f7�z_��ˍ����R��$�"8� иC�i����.%�_�}c��x�p���#����
D6��q�'|r���U�$����'���Y����M6[ي8Pc�0M�X�M��v�q�O�OB��O�}�qL�B \G�\̓3<�Q�1��	�'Ķ�>����E���BStvjDkީ�]���m��$����^n����SYj=�c��hW���e?�p������g��V����q�|௼F�����>yi���J(¯0,������IVѱ܃Q��D��"�\&���( �����%�p���[�S���DZƢ6	��q���''�8KND�	j7�7�����G��շ9E	��!pr��,&p���H�vg�Q5�X�n��m8�����g1�Ue��V-CKfYy�ؓ����V���͗Iy�z�o���;f��3�5���D���oL]BZ�tjN��Bd�\4��\Y�c��!L{P73���\��EcҀy�8P�����
�8���X����W��"��l2-�������ʁ�,��2[��8��	�� ��EL��j+��=]������ٜ�,s�Ȍ
e�P״-]w]��4�4|�tm�� z�舿���t��s�7���}�;ر��dg��۔��3���2ԄG|��Ҕ��Ȩ��!�T��o�2Ѣghh0�Y�=F]�"Gj���p \I��Sb��6Y(j�ǛZ(|Ps����s͹�'G=�E�t��za#��XE����QzmM:=^��I��ìq�	@P:j��p�~�B�l��=��3*+����3n�t��U�s����F���d�j�e+X�8/�;��R�N������ � ��K� TI�� ���?&�&X�^�Y������*�WƎ	��(�Qx�Ŗ�4����W���5t���~{�	e����)(�9e1
�7!�\��!�E�,���*�|�����<��� ��Y��)Ѐ�ڪ2W;FZ�,Fm(߀�[k�eovp)8��0���
���gT���^Ks4_5�+Ǹ�V�Z���fU�1M��5�1mr��2��7���Aw�鲹�l&��׻�+����)��d�'Y��"�g����r/'��{��>w�D��@Y�+Q�Zj�i�	`�$�h
�p_*��M�1�� �e��f@>|s�@M�ӿ�G�]J��=1�Sl޶��"�~��`�
Jf�������x=�0?�s�;SZ�$� n����H�)Z��nZ�1�0!n^�Q�9���$��{0I�q18��2n~Nҏ�\fƝ���;ǖ�0?�65?���%�tO[����Փ5�~��?ݾ8j��9	���f�Փ���˘q�@+�L-]�GA<!"/1�X�/}��lc֥)�i�O�f���ʆ7lId����WDe�,֢=9�Yh~���b�LW��lQ"+AWJAT�%��l�(싀A��m�uz�jD�Ӱ� _O z˲@<�s�ؙa�K6(�Vx�
�g9ӳs����X�}�Ŷ0�>�04�OG�<�T��d?���]a���<lܧ���Ϟ;�*�L ;m�(�oX�0���'z�K[%�3_��c�err���k�~$��mK؀�>S�Dy����=��{�aYY�E�_4&�w�"�^�����EI��$��mڒ$�9w?����8?��c�.;�Kܜ����\�9�F�Z������f���XyC̸���7��핃S�����|Yih�8Сa�Ԫ�����5�:��q�5A;?���B�XNX���t����t῵x��#�����,TT� ˜(��w7<��*@r�n�@�(�����E��<���!3
aU�Nr��VD΀�'$�Gj=Bt lE-o`�9�7o}���wL{��EW�9:�����4�v}���L=7c4Xn�Qk�Z�]^j�WGs)�f���%ML]_��ʟ���?���)�
�f��89ɨ)��y��3�~�r�U=;A%~�B��?�5y�7/9��F���]z��Ā޸���A����j�LRO��"��M�U ��jc�A�0ʤ1��`�v�`���8���S�<��Ӳ�����kӃ#g��b���LNO��{���sYSN�WE����R�+!���h����~��J���R��	�O�2���?�.��Յ�&*Y�ֽ)��`@����o��}>����B�ǕIp1������-���3���]��j/h�Lgt9T�E\��R�S";��z���2���hZ"].�_�5׬X��<�uU�2}U�<��̷�M�k-<��֟���|��V5mYNAl��������`���UCq45�'|�̡�tA8�Y_�r��M����{�>Y�4��Ԭ����j�r����x�R�HK���=N���ǀ��7_����K� �pܘ�Ĺ6�v��ҁ>�ؙ������f4�L��N�ڎ'jb�m��*X9L�Z�U��k4��k{վ��������(�Be�ږy�L����+q�I1g��l=��j�-�}����+W��!��2��VrԷʻ=(!�e�J�x��1��7�O���_J��0���(��c`�����GS&"�;��)��vs�-���T3n����u�On�n@�[MJ���&Q!�9��'���-^ops�Z`� ��E����iI�)c>'��	@ݠ�#ǜ��y^k�m�(�t��-fi��g__��lO/�?\T^T��w��͋���N�h����vp��	���e��[7��E+��|�C���')iW��Ӏ���mf@�kJ49;�~�(ϣn��KV��V���3�?���� [�7��{~�v�^/�<9y�<z�{@^įt^Q����=�8g�\-;
�� Ï7����+��&��-��a}`;��;�C��
t�Cb�aO�~����^mF/�8Jv��]ƺZ�f��s����p����Z��쪷�tE�u��	8TK^��t� �+	.\�̰�zA5�UĂ9��Kio�2`������`�`�I����Y 3�&G���-��	�j����e�2Y
̃�(: k�1���E��
^���z�tA����w�ڟ��
6-�l!�`Z�16i&p����D��c��z�|]�o}�)J	�    ��fJ��t�{�u�R]ݱ�g/?�S�ɵ�bwt�7�v�gWKz�D�nZa��w������*�TPn+�O�r=R�*!0%���#�h��z p\z�B���z�� �b���p�"�_�e���d/x��&�r���ݗ�ҹ+�N��	����F���G��a�j[h���rh�7_O��.4����S"�0M;��o���}U���򎙩�6�'+��;[��u��jAS�W+��GR�L,u�֑�].>M	�-e5��ҩT�xb�w�^�4�o	�{�Y{��v�R�ͷN1')���h/�,3��݊�R�Iԍ*JQ�@��D�I���T0�{Ŕ|�'���ޔg��K�|*����q62A��|<4C]�0���ɰ����3j��fl��s��eXP��	,�k���p����^��ht]~�>7���Et�,�K�I�v:8�u�:�1��QINn�\12&�Fw.�v�x�%6��`�Yz�n�Ǖw	שۀ3n�:Ł"�Z�t��y���x+q&pqbg�m�-�)�8�ѩ���xcq0��w�B-���aq��/|�SϨ��,��]g���F�a��V,�7-O�,MS=�Km���l�>������sլz��It�M����������5j���Z(��bAq�enKyR�)����*�[�K����*��&��N������V�?�"�m���`cA���{S����=h�"w�~�6x@���?Sn��$����y���A�P�3��N�(n��Ψn����:h%V暨�m��3��r*����ph��D���ϟƻQ��k{�R�����&���$�%ec��V'��S����񓒀��%w gy�L�����UB�1�X��^��z@J���0�}���ʩ�b�gu��F_W�`�@Ŝq�h�b^��#��h�y��?껪#��h��v_Y9�"o{�U�]��������Iw5 ���~޶�����'���Yei]%��ì+�䫆e����S��W�P0a3�$�˘r�l�����3`ם�T%��x�������㜄pB]�E����������0K�Ҡ��·a�pU�S������A�U^��$P�e�7��Eg�9�A���qC�]շy� |�C�����`���<��\==\�
��ff���d�}�F���8�ٕ@]��>A�U��L�Nc���O"β8ܿ���|��%���8���)�.�\
�#��z i��/jޢ6��sq��4ڃ�+�~xi�f#���`�:���!��@+_�X�rLLk�DT�d!lj!�j�ې=�8��􁕵��@\����9�m~W��`��YP��r=յS|v��&���m����'+/�../���&�K���:so^G�\D�U�q������`��)���U����C(����&�]be��`��-����E0���~a��md���M���y�.�����Q�	a�h�	�[����+e�x�h��Zӵ���]ӆ�;?������z�����<�N�뽳��f�}���0KA5�>7��] ĥ9Q�b�����)r����\R����_%�5qSd��� �PB=���FK3錎���s��g�7�X���'���du�2�I:bW�`����i�y��	nm�Y�vO�NFVf�t� ��n,9�G�H#ehT�
���!�2��Щl� BJ�ę>��Si#��x��r����z3�)l3�yR�m�������竆���M��U���V�9]hk�^���������\�hT�_ƽ~�c�2������c-�\�fr6�UЖr�S+,�S��?�.L,	��?w���3�0�&;@���ZJ[�B���!$��n)���OVlqK�Ep `K�,WCL��[Q6o�|��͗��!�0Ķ�� �D.x�9�oq�U�\7��E��;B���(Ox���K#*�,��ɨ�6|v����uS�p�o�)(�� ���\���2��͸�?��Zϖ�/w�ʛ�U�����SUN��ƅ��w!Y�]�gs���	:?P�	�n&��)0
��R�?�W�KU��p!i6Uj̿�^�U:-����0��̨D�
VM�_�s_�LGW�����;y+�G��ˣ�����ъ��q�����2�n�f�	�/��u��|���y�K*�=����g�p�B�ǫN�7����C�ww|Ϣ-믽h3M�����`�@M����Ѽ2i�t:���f?s�RǶpjk�8	�U+��e��q�-ʱ��:]u�̔wFλ_bFu����m�(�5l͵��,�5�(�؜��2|��{m�����%�l���ߩ,N_�e�\LaB����Jݑu[�-H�Еǫ_�H�R��:�Xt�ݙ��3S��O������g�iI���n��R9�LA!�@ �{��a>��i���ڢ���#q��TޚJNp71&���88�v۹ćING ��9y�f<팺\�������'�F쳝Wq������ړ���isXo�W�PN Cx����K�I�2A|�	 ߆fk:[ � ����a�uH��X�7��|H}Q����q����.|�˛���� �8� <��g�L�l�?�>+3<��TBf;~�7;㈦Z?�a;D� ̠N��pp����7�Tvb8 j�zN���^l&Mr��H]4]�XpQ���N���U��.Lr��Cr*�����:�'�5G]�Ϯ����[�����:n��(���5Y��$�V�VB�Ia0~B S�G�T�X2�Y�˜h�+�|pŁ�+o�~/��ǐ�ӽ�Ў�"X0Pd�)r�b;Է4�G~;u��Ui+�?�p��z��5-sM�3~2��Ab���.Ѷ~��o���N9+ȡ}�^� 5��������|���|e��E������p�d��sE�:���I.d�Z}����f�E_�s!�#�_�t#�﷭j�(�7Q2i���e�3{Y��z_󓮬R��u��(�]�p�g��m��|̠ޯ �t��}��`*�Ԁ���R�5q��
f� d���ow�Y�5�����O澹��}��%��P��Qgs�]�ϻO��[�����b�;��4?ڻ�Qb�B��:������J9��k�6�p� L��i�<�����l��E�%�PǢ$������� ~�X�q�=o}r����|�����玮-��P��*z��
��R��~�Tm��Y��	%^ra��ՙ���!����l��M,M ����Q{s'�����V`�\�/&1w�-���?�k���;04Ou<�N?�vNu7��ڊu��.'����]og=�t頝=�i���ڍ���f�T�{e��LѾS#j|�� R�˾Px`��#�a�1E��T�\T9����`ф��@A�u�0�)�X�و����p��Ph��v�9�M�ׇ'iGj�OT�j����>�љ���ߵ'���T]]��9ӟ��1�O�N�m�r�m�/��:{�y,38L�ml(ϰ�d���������%uٰk���0�� �ؗh4���U� ���.�j�����E]�x'��� �~�[�V�R�#���`���ZV�L��I�K�g��:9"D���dʣ�  �ML4���G���� �J�P-瘨9\b��J'�]�T7�黾惘c�檞iY��'XwY(�7q��c��L[цm��y��W2�y�8��$�a�P1;�mq���t��0�2^M���o�pD3�3o���|3�qT8P=B��3�ܚ3��->�Ǹ?�O5ց�e�_4&�NG�`rA������S"g��Y��&	��<9;#�����Kʉ{
�Bϡ�#�|�sϨ�,�H��]�n�{�LOUӲ�;�T��A�s*�YT�NڗZ/�n9�����03sfR�Tfv�w�6(��A�� aMEЅ�Y�]�ً!kȂA1�^^�hxD�w:�^�2���-�{c� ��fiP��K���"�G�,C�q��RL���x[�
h��^����o� ���d��-ؙ�ʓp�!���泏�p�U���mi��    4GI8��~[�}WW}�O�1=M�M&[^��O�+������m]mE'Õ�,�����ŭj�neXO��eD7���^���W�XU�-e���P�M-�]K-(�������pʻ�e�Ѣ���_�%]�| 	�&+�"�������A������E�$c��G�
=3�|�ٴ������xn�9�4�;Xn)���b�f���L'�Q�4�~�d�,�a��kn����6�8�/�TNW��Qe��Y��Z[���[g�ۍ�� �W�5S�s)�,	�C�b��j�ܣc���Fb�(&o�]��v�a�raP�2�L�г��C��y������dچ�����X0Mr.ӓQ^Xz;LO������׭�4�4|��R��	G�\Dm����C��9���w&M�V���v<��MC��+I�i�U��j-�U��X�+">���Z�����Q�dO}r|~��wt�b��\Ƙ��$�|�o9�Jq<H��w}�X�O��&n}s�&zdb��|RK`�����nf�'+��h�w*?P3Jc6�Z��O�89�ؼ�&�dI3uy��^؇<�4ʝ�ڪ�����.�v�"��G09<E�I;���|���:��˙Gu��<[�!ݴͼ�2�j�bk�b�[ۨx�]~~�)�X{���%I�!/�i�)�kq�~�ر�*G,�	��ߐ�;}��i�XG1D��LWS�$�ʓ<������~1*���/ ��&��Z(|02o	��ԅ���$��Qā"�5�S���e�MY ��-��"�h�y��5����Wb��1<'Ne�SΚ�l�4�&��D�wSwA]W�m�c��m�7�ț�j�i��,���z~��r���X���k��9�`�I�|��������^S�;�d��4g�o�͉�(��_�"78@��NSҐ�'���真v�Zm-���֗(���v�Cou�j54�K��2%���$^�w�p;���_NC� �5�Z��"�����ȯh��Ƌ���|����d��Ef��� Ofi�	��S�XZW��ɜۣ��������~������Q����G���a�$�v�������d�ӝ��}�����~�52k;�Z�M%�0Q�!7���b��n��i�R/#������}ʲ����>I��(�@l/�*��v����?'XBa.Mx��z�E a�a�$�p���v�?�J)b�����
,l/
����j4�����P��x�U.ˮ
e�d��4�ajhzG��h���sSm:��W5㠖�<���wF;u���z�9��λ�]�|=��e���b���R�S��^u$���%u� WU��kАz�呍���y~ �pO�.k��X�$+���E����~�8f�x�ݍh�!x⿊|�Ą2�x�s��8mNVO��m6H��&i� � ���%�����@f?��nzA�^�4|�7T��->{�ِO��Ϟ��h��aS=Y=���s9�:^��A�^a���&�΍��q���줆F�>�.+�4+'9�!��c�d�
�.�._Ҽ�D��$��Vā"�8�'�Vx|F�/e)�6�Vԓ�����Iӗ�'S�Ƌh��o�%`��Ī��+��u��U@4�\ma+3{B��7�Tu�,�v�M z�l��]��-F�^�6$�|�g
�}W�<����Ym����aT��x��;���c�\��{�Y�H�r�L-��G�Wo��%xH	�b5dZ\����*ޙ6Ub9�=����0t���̤S���;�oi���:T��	<�"��F���o��Fē��4�H���S�,ٍA��� S^�h�j1[��o�6��,��r�Y�
u�"���k�� ;��"U�:�7�N��5g{��h;��ql���)�Vy�s�S�y����s�a	�L%����cӼ��ݿ!�u��/�]�Q�d�φ�t{�_�Qā"�2����� �8��2��͛��\��,�����t3�@M�>��������HF
���)����dZ{���Zw�\�T=�tl�G��G�֝�g����04�݁yl�|��9���Y��jaJ�K�l!�(X�{�8���K$�dϾ��ҏ̵��j�lO�L�@E�v�]��8��[����ɛ�E�4��r?r�M�j΢~G ���������5�x�3�*���AQ[��go�����8j%q7����h�s��S��kl>�ǩt���pz>F�w�¬����
�Q2��y[8��O�m�CF=ײ�3/Ó]�Z_������}2�>��C%����A��=:��ʹ>�^6t���DK�Df�o2t�Ls�p���_��o���[p�~�D�1�&Y|��e����7Q�V1-��`*�b�"X`P`�p�g�$0�71�ށ���	�i��c��HÕ�����
Nn�_#l���jw T��`�a��O��/�z��1��tm����H�t�����o��I�,�P]������ԇW��qx�i���y��v�W�	<iy�?��d��٤� ���1�ؗGLQ~/ؔH@Z�i_E�dNY�L%7�.�1�����'���W�	��Vā"�j�w[&w_!��$���Lg�*��6�x8P�F��jE[J�-�� uXi��k����wzV�xl���5�f�����E>��i�ex�g�V�Lr̜��[����y��묫Ϟ�\t�)'jWk�w�̻n�`��Գb ���i�.2��%�q��=J�h��*'2D��	�n�G���*[��q�*�"mPe����D60��K7-"��v����f���'X0��!�*E�z3�����Q�-��<���f65��*+(e/r}x��O���~;o������'�G�/��k�Z��a]������� ��R}���1��	��M��Z*�W���	��[����j��	���5g0�$�H������M:��)���������P�h�F�}�0)�5U[�� S�q��4�-d8k���'ʇ8a����|`��@o �>���Ƥ�@��b� ����n0�J�sX9��w8���ڈ��b8?�#�RYl�Ϯ��E�ֶ��"묺��m�ۧ���ҭ֮����0����O��z+�Y�]�+�'Pz��X�D�qG�N�ك�6���[�~;"��0��#��?)!%@�Ʈ����/ΒZB��hNƾ�"�t�Zz�ǉ}�,n���r1��l�_ 9�&8���LM<�9��V��n2�+��+`�i�Ʊ����#O���!����3�2��j0�W���[��:�ǢZfxl:�l���6m:/ZW�Q/i��m�k�ݭ�������,[#�}^f��U�-��&oq2i)k�ΎD"���cC[Fy=&�M��������Et���B�H�jb"H�K',޻��e_�lo����l~��4ۿ��_�72���\	.I-�4�DR�$�j��8��b�o��)X9D�L`~G>�\���0z#$���R��˚b��s ��k�4���Y�I�	8L4�OO�L\������D_>����f|p��>���N({��\ =T�q4����R�}l�mB��,�`����!�l��a�!v�`VS���W-�\�,V���V�9�X���o����(?�nd�ӿݿ�{(��g{��I#ᗺUȨ���B�����k��*@'!�g_��p��[��{���tz�(�M*4�k�yM���%�f��5jզS^n���9�|8�	ib��4��L�u�/\n"�)cm���aꜚ\�	A�k�+�V]����̜�I{kQ�xd+�@�"��.^m/��?�8(?2�ԩ�o�7���p�i*�,:���a:;#�� I�����- };I��5,��ɜ�|�l�x���Cm�3ra:6Bu�t��H��/�ǰ���j�_>�3��s�.��~�&��1��=8%%�d<s	m��4�U�*9s��Qx2�̽A"L	�2�O������
�O����$]��
���k�Ĕ���F�bN��ϣޏ��;��oo1ي8P�;�����<�E��1~��C����-��1��&�h�    |¶E��$��3�N�n�#��t��U�n	�� �[Ӓ*����h!l#=���r�s�ܬ~qu�K��C������c��X�3}77�x�j�*�;Ѱ����ir�����FP�V��i�	�$(K�$Oxhvxy��B��z�r��&Q���g�)j0=�%Ft�0/f��+�8BS��?���	;����w� p�^ � fo����yһĹ���m��֤vc|�?8�E��C�;}4N��H4Ω��<Ͱ���s�ʌ:�B�J�\ݯ�M�����:��B
�d:�jϥ[����tln퇃$X���xS[]�ۙ��o��-$[$�Y�̨����`��v�ڈJ�R�������3M88���wc
�e	H�:�7},<��I�U���\ٷ;�ā"�y���U؋+@�
��M�F��
����O�v���Dk�98�
�{H#��%�ə�~�sMQH�$��Nu�؛cx^�7۲4�Vm�g��g/7��فv�v��뗫�{G���������{%H���I�Lֈ{��vj0��s�$| <�F�"pD��M��F����G�t��@.���<B^���q ��Ô�}ss�T�=�m��f��q�t�.���xhƔ�{����1��S<�-����~;�lq��:��9N1��'5�]$l�H�UH=r_�}��]?�g�.�/�F'�\E//�ϖՕ��\hy$��G�
E	�G%|@�V��.���=����ƨ���(	8ٓ��5��X�b��`�s�dU��hv�/���g^Y �$�ׇ|o�K�,��" �')���E��A�&�m���	~�'��,��?�A�0��!~�-��-fcI3[ X�"���.^���[�zBg;�L�2�Ry�Ϊ��\֏�g˗G���A�R6	�;o��Q�8����6����|�Q9ڼ/����"��y�1� ���m���P�^z��"K�����s��"aKiw�q/P7�]�?F�w��z]�}��\�#[�js *���sh~�����N/໹�Ɬ����-'o�Q{i�;�;�W�s=x�O�e9O�(��^��.s	�=V�-򢋧 �o��;-Hʞ�;�%?:j��^t-��3��,L���&A[�"a�a�1Ol��D�ˢ��f΁���4o>���e �V��
�e���af��W{}����ӂ������6�|�tg;���ҥ�J�5��<�P]�Wu-O7s����+��qgky��0�=_Z�=��3P�c{�}E^��b�0�����%9 k`�0�E��᧽>�A�CF�ո��ֺ��]��e��P2H��Fx(�}�U���.��)Lz:��m��~a����x�t�#堝$Q�M�N�J�P$1zL�0�����#u�,,�B&N�v��,Vk#*�yW#�u��`M1u��I?1��̴�k���H����Fn�W�"��(��Z�gq�]�Og�uT�ׯ/"�&��O�lfȴa�8%6q��,��2��Q'֏��Rc:����+cr���;h!��r }�?�F�/�}ݫ���\��E����1����s��rr:̑�1xo|�

�|.($�>)�߽�a�l<
��f�AM'(�s�b����/z�sϠ`�Ϫ���j��r��@�̘s �$���WT�VЉ[����g�������͹�^>�ܬG�uk�bw�۵����L%������`�'�y-��.�a,at��]�1�Ud_Hj���F����OՋ�t�9��+�ԓ��C��{�Iٶ��l�)lS+P.��
֖���s�bB ���c~�#�r��o
��]vgՠ��@HO�a>Y�zo8��s�tҙ�<�Mf�Ig�6��[b�o�y���qg?��AY=�F�^�pE�����u�k�4K�Їy�'�ۏ[��7b�V-�fN RHn~��wД�ߗ
��_v�������qI�H��7nX���op�(+S{Q��ں�8�GG�1��u����8�����?V6�;�h��o>W�1{��D�M��i����~_%Nbi�3G�s�u 8�ӳh9�7����N�{�q#h��8��[C��vz���֮q����u���u�*������pu��i�CU#��GS�����%T�"&����#A��A�T���v]�������`��v�Cಓ2-ќl��I�x����*H=�൝ iQA���(�sൺV^ {��:�2�%��� -d��^'�[F�F���d��0�9gҐ[�Z �Ƴk�&.���K������NW*C�lи��w�X�s -�ѡA����G}�]�{�PR~I���٣��(Š�����I�x���}�y�+����t��G��5�}��9
��Zoњ�w�Z8P����t�ŘF��!�Ru��-���&jL��`�A��c���T�}{��i3�t�����_�Ws(M��T��a����6����ӧꋕ�z�i٬]q��1Dy��3�B�}�Ѿ�[�3�������O�R�+<��i5N�OMl1d���b]u;MǑ�#��Ų�.��8���/���^�)�2o��9@G�ZXP��Nw��)�@rĢ��U6��Є�i�W���%`U�n��MkKs������:�L:���l�̖�����b 3�gr�΋��n����Vk��_[�����)AQ��K����nU*D��ug�g?NbΙ�Y��t|ۧ%���Rf��瘇P�NJ���)�zS��� �a��\DJ�*v�aU��"����±U���td/���֖13�N�� �0�8~��j�}�:e����P��礽�gr�v��VO���l.�-/�o��y-ȶmն�W��	4ˆyK�;۝��r㸽U�z�F{w�-��n��O�� 厉VP���́��iG!|IQ����P�H��Z�4B�!*A7�)D�� nbn25�h��$��B8P��4�+��H9� O����#���=S���������d7�V �d_QyqJ��	��D3�8�O���N���|R&�4tN5]��}��m�z^������������zy;�4�6����K���!�Ŝ����`�]2��_��j(MiYҒ����]�]�Gs�p��.W���<�����c�A�j����0����u���'ۄ�7$�ة���(�caX��� 5#Y����Y�;����5�p�@����D�`���8���2�&t۪zv�^?�G/jn�l�U��'�.}v�_(cloT�kd�9|n��4�3 �=�z���L	��$�X�#b��l��Z�J	!�q�<��5�Px�w5g	��G[4��MЮ"ag�ck�ǘZ�$� � ��3f�����6�|>f �ƭZM��S;C��0�=mU�`\B����"��F9"�a���Ms�|	�y\ce�~ƛ����O��8��,����y����up�st��:�����:��b�8��z�a>ح�ue�]��64D~��B����M	��b����� �����K���:����=ʪYƔ�Z(��*"#�7
И";�<&��TM�N$��خ�të*Ԧ�n� d���x�eA�ՠ���
�H��S����;�|�H<iw�yLNuo鎩���-#�Cf?=X�ӵӞu�h��j[U{�i������d��]3�#�}�Q7�E���ͧ� I�#y��G&eb)
Ӌ߇ e��aĝ��x�i�m3�V0L�y����~:4�C���/�Ps���H5L�$Љ	��H��Ü0�*�30A�-���3Y��PZ=zYj�v_}�
ZA��&��9�~uTU�'ݵ�A��:��ӝ�D����
��p���/^.��k���� e�,f !��Lx�-�3��&��<!��9�V�,frj�Z4�E��,?P��b�������h�D�1\1�LI���f�Þ��EQf�O��X�D�U@����LeBL􆞷���眉��a�Y���Atq���DUUwϳL��T��Y o3�M�L���s�������W;�܎�Z�s�hM�L����Z`�H�(}-�l��#>�/�@t��f� B�Dj�8��X�    e��F������}ss�D��� ��9�@�(�]�d��5 ���`2W+���MLCz{�X���8}>&�M������	;�(�1�~NC3�Ig���
��D�h�j��iZ���A����ޮ�{������Y��Nw���d����#�UUH���ҁ�� C�h+o#<�S�e
�gu�י�<Ȃ�v}sѾc�9?P[ ��H`�g��C0g/�Y����h�o��l�i����[�C����U"+cV���s8_(g ?�ig��0��as�2���j��i��M5ܭo�d��h��m�>[>>��j��x=] �X��-��~��ZKw!�����h�t�Z� �K�@�	߲��(�TwkB�PxH�2_�ʆ�[�'Z��"l�n��+m��V�W"�I?Q��r�Z�m�I|3<�!������j�U�����hH���,d���f�gWQ����Z�8JF�:��TӁѧ�-�y=]ϋ��/5ۻ�/#mk͹6���g��|L��� 4A�~�I���h!0K�� ��J���������������~>� ���N��Q���ͅ���9ɞ�%΢��9 �(�� -�
'�`����Fē��H����$5�]��*��J$x������C��K�j�@ڝ�p���d:�]���s|�S��FH��:{��k����yMI��r�җ-=ԛ;���vm��KYSBD6�?���p�5"��U*)��g�Z#א�k�\�2���UO'�a'GP.��U�w��%��l�"��$"����/Ɠ���w>gI��X4��<}8c�B������n�vI*�ޮ�N��p�t�h�	d��Z[��:�]�ݜ�[oƙT���Zf�y�vc�38�����u�w�GmkT{"�|�]�3G�AX�ĭ�T&��R�*���@�0 ���
�F��@�HKHE�͠�D�
����HYz���R�FQ}���fn�%�	ǚD�8�8P�����?>�B	��߱��s}�Ps����D�L�y�j��1]p�qB�db���;�K��`k�ĵ�b0��#�r��K��Vk��]3��I��������vm�#e����� )�Fs��5��k�Leڛ��r�L����ٖx����iӃ���=Y����'ыE0,�VzaJ�?�y.�6�J�}8�`$�*{Ԙ^��P�=	�1馁ꅝwl��S���j:�����˗�z�S�/�A��e�滚cy*s����k�,��˵�`ck9�.��jc��ȳ�l� �q���_���_	{�_q�;M�haw�'�h�w���+)+p��29I����A� D�P�� �±=�稉��!�Nq���~{�D�j�n��-A�,�;F��@�l����,.7������&ƭc�S �H6��@��ؒq�YI�Sh`+������]�=�-l�e����Vf������OFv���Ҹ�8-��s֮�#� a���QYY����B�n���WM���$,x�tQSl�ot�
��߃�d�SZD�T��dc c���7��9o$L3�v��xJ`7��0��֦�`��%�?x��ĵ��T�Y�n�Y�׌[q�v���h�jk��:��'����O���m�����N��_׵���Lq����հ!�i�J��݄��q�u���9	T�����2<R�� ��	{��B-�W�7_w�MI8�"���?B�s�x������)n-ާ{�Y�u�^�&�[���`@#��	?e*І�6��)�L���؝��L� ���s�L���4''WX��H��@�!-�pH�����|�#|��F���8X����}�u�ZU�=1�b�B�&ru ��`?��)8������%q���L��A�*���Ǹ4"|N��	��;���Qჸ�w��lh���W��x��=�]��Z���-L�r��1ˢ�H��'��a���y=��xgC# P���>ֈh@z,X`��8�囘�.�I=Ƨ���t��=H��g7�P�n�{n�������v�*,?8G�l�X�|���E0v��_Jx� :��L j[��eÛoaJ
T�a� d�)(t>C��7��yW� |ى�S"=���^�8������8�Xt���ټ2ͿaAx��Ukjy���r���{,�tff��H�!�+�9#��9�L��
��2� ��y�I��ܞ�\�|��H��]o���w�u���lf*�髥���W*Hq�q#t�͟���CO��/��i��k[%��Xī�	�3p�!M��l C�_��3�O�^ׅ�ÿ�y�ܭ	���YE�@Lh�[���������%7w ��C����a�o�Ӵsj�p���� ���!�ku��%��3���3�L��|���i�����9ٚ��d���]u�~�\w*q���V^�S Y)���� 2A0*�W0E2��(�(͏�W<QzЖ���k�I�2�B)-�#�� b��7��9ʑ<��eq�] �*�x8���C>�^J���YCt�}2��c��T��,�G A�
�zȦ��}J hog��9���r�ԃ]����t�e��[⳥�jA_;J�jϼ��ho}p�x~���vby%�@�T.o��` D�m�ѝK��R�1��ԝ�0����y7�4�Pa�d��>��Ǉzc�!��:��oLF�q����/�R����lRT޺��W��7�AB�GM����ZU��O<���N7c"N�"X��rt�#�f���Boct}tjo�A��le�\O����K�x�8a��Y.$<AC�7�3�a�P���L�5� ��N�̗TQ@�D�k�%�z��|��szpr�ڧ}&���m�GLSű��=,��uDW��]iR�����?����V��u����yj({B��,�K�&�(�i�9 �m�7��a��H�.{ɼ���dy����n�a����`%3�\�5��~/	A��7�~�?ĝ������)�6�/�ħ.@v���hµ�Di��ܚ���I`���-U4\�����*�J��$D֛��Ġs!|%�ɠC�g��,��-�Hʶ}�0U��E�m�%��^z�]����m�NW-���$sK^�#�m�sҠ�G���G엾M�<'L��S��0j��8�vG�ɿ�b+�WX�/%��B�ow�w
YR�E˹SR��"l� �fa���&<���.>=��B�����{��F�+m���+
}�3�Xr����C��:��R�Q,���*�,R���A�1�``A��gd:��I���6������	��w���.V�Ю�$���9�nQ%��]{����Y�z)�ŏ�ǝ�ѝ�s���bѧ=Ļ�C�o�*-9�_��w�,���i�חm՝z'q]�v�.v�8�ޭ��B]����Z���®�N�6�9�w;R����إ-�פ�8΄%E��^W�	j�+�G�p<���cL#���]�9�z��?[���[	y�>��~���o��O>��p.���#q�q��@!;�I;��u#f���0���6��$`�f_��J �i�j�A5�T+Νuܙ��e�� -�V����q�Y�ULu�q4����w�l>^zz�pOֲ�����G��"�]$����t�A�e^?����̻Ƣ��%8���&�����anc���<�0v���-���q��ғu��yM���ˊ��Ϥ���Π)�'� ��3���c��7a�}O��]�b0���x�$fa����(Vcu��g҅f܃.e��uMO�4,ٲ���(g�|�\W�}e�ʾt������*7�R�n�HO<?�t�,�z���jdej^��a���61\ET�d��/����<��p�r�x;���k�z���7���E0�
f���1���_x (�Eǋh�K�����{�$: A��Wl�@N?�A��.:�`�]r����_w��g�m�	LL.
y�,���x����ޖ���9ߝ��#�vW�W�1&���_l��;�5��'{�9���5���`�8R+$`�`l�9W-����#��K�f����4�pP�4۹"���'�    `J�@��XG�:3��:����������^s���8��ߕ'OVvN���;W�����,�܅��n��Yn�̻�x�#��Ā��CG��zl�����P�n�uF�M�G��݈AV\5&���=S�����u���P��S@_!g��u�J%�GW�Ǽ�PZDÅ/m�i�&!�e@�!v�>���G��H�p'�����8I���Պ�T�ݝf9y-osFX����pUC��_��Ey�ihz��8n>�-��ό��>>Y:;�sh��5�M��@�I9߇;a�K���A����Bq��� |~m}$2Q�&JH"ua�ҏp�{���&)�;�4jJ����A��ң-L��1>6�O���c�:�u�2���4*�8�]�r<w$�I���������3���^ժ
���n�闎.�4>FQ������$���Ń��ى���������+��?��~�����B�D��l(N_��ג�}Yf�(Z!"�q�Oɩ��ٮ�� �Vq%I���&y4MA����Q�L03�6M�u2$q��bN±/�H&O۹��	�*�$*��X�L��T�����!Ѭ����V��[��A[�;��:���3<[��A�H"��0#@vt��l��Z�T��<;ZW�gZG9iF�W[��d��!6i|]���--�7�R�$a:�}�s�>�j�0��-kS[l=����!�{ׂ��4Of�5$5eʵ��Q��&�^�KBc1�QǬ�H
+/��=��i0��sǞ�>�z�&����bq�YǝI��mT��pEL	�]YW��*N�lǢr��O�W��`�ɾ{;O�⿈{�G��0�:���u���v�Nܫ�q��l��u��&����̞�Y6�8��&A��p������m3�tN���cfLU��H�>���i͕޲ǽcq͚mtQP'���`�����GKu,h<��'��D�Z@��׼39����;�/#
KL���j�=*���0G�>]�27�Z�ћ+Ȳp��g��܍���3^�a9&�?�5E��e���kz|��x�p��j�??���ws���#�nda:�`N�䟶����2���KZ�L}m�<:5�:sWjH8��~MEFwQx�2h��v
�1�f?߽�f֜�v���2��� ?J E���:��֥1�1�B+��m�q"x� ��Ai!�"�{!�=s�����\c�����B
wq��Jc��@+ý��
O���������AS�(�q�йXko�������n�v����<�1N{�P-B��_�}ݮ{�[�Ws㺦h(ZQ��1�x9�P��Qn����SD�|����<�=J^�BT �8��kH��8�@�tl���#=ZbK��,y%&TK�e<T��*�s"��I=��-�����aF/:~�#8� �<���=�IR�.A�hQ��u�㤟װX���>k\U�++���{�Y#���:�<�l�����(���c�nkXv��dO�@	`�8�X��	<�̳<Wz�΅.�8@l�+�Q:C��c��嗢�����7N)��{c!����i�V��a�_ȤbsRhl� f�fD4�F��Z��;���x3�4�Q��uv�8��+z��#�՝�t�ī�+����nt�����z,T���__N)z�u�c�G�f����+�p��,&*D����q$Z���xǢ�*�>�g �bcS�0�Q0��=C�q�y�_���y&�D���ӾB4�(s��7S�;%��FA��������Uڲ�;�l��y�q-�Պ�d��V����U��o��v�t�������^e�.i�Џ�b�k^įq;'����/j
���� H�I�<�'C�������O,��(���ǽ��P��2�D�Ņ���եj���K�	��K�Z������g�ۋ��G�@-���C-��y��^_�u�jOfVm�-P��e�����0ٴ,+�l)E�ŝ�e�����^���$����<E<R"�5������ ���#�A	ܑv��ˉ`Y������*��EF?����~�; !ʺ�A��d$�+�� 2��\�q�����o�}�z�P��oȵ��)$�o��U��%���a&2]>8E�*U�w5{r����f1H�CN��� �z��{m���m�U4S�)�e��|oK��F�`&�]4�U�xk���`kU5��ןw��춾���h�d0�-i��Q��,�mI�^�M`��2!<9Rs�>�F91Q��Y�(#B����0�����A1�{��{���׉y�����Nn�f��1I����%'�b_}��ѓ��'Po��V��X�L��6ͶjS�F��at4��{��h���&��z0�hH��S�;�Ɍ�������mٗ<E��wn�L]m�˥�F�V��f�,ܿ���.��l��k�A��t|���/ YG m���}�]14�UE4E�/��U�Lv�hE��4G##�!}V��&J�y�����c����9Z�nH�S&r��FU�fSzDQ�)K�a-�ּjX%t�be韼�g�+��4�|�c3���r�&DiT���&��㒲���Y�s���̤H��M.��E���5庺�ٗ'�n��/+;K�cn�̶��1�e������Ҋfֱ�v�MΒ�	�~#�1?bN�+��ў�>�-�G����룀PC��K�-N���ne�PK�W�)3-̡-1zU�%�or�/�5x��fRQ�$��4��84X,����[��'{�k�~u�z��r��)XY���c59J"��͛�ZR?�	3�P7��A�k�xx������ +�ּi��h����KH\�ŀz���q��.�;u���'�yǮϦ� �Q��0�O��3m��Є~�9�.v�#$�2&��y���i3�l?Y;q�ZP���\6����`�|�}���Y��!o`���X� ,����ˇ��Dwd^%r{J��4�T8����G#M�i�F�����K9Wz��+�*�<���T�d�=�K��KB�jT�L�hQN��o�3��hjH˧�侇�J!���4l.�T0�>�M��e*�3��������5`�j'��M0M�u�b��Ϫc�˺�Ԩf��ݳ�l��O�8�6�|���F,-{��'�BOS�mac��!e�9oㄱ&����8ì�z�5zO��埤�n x�I��m��F9 E��ڶ}��7`'�$�8'�	���Dċ�`�q._s���ީz�
�`jS�7G-7G�f[����N�%��ɧI.3|��(��0�ԋ�O]Z�_�ݔ�L����3i�.��v ��%�[����7��I���n�GAmu?�.���8��A�%�*^�dX��<kG�9�2B�J��<�o��O�SxU��@dW;�������/s�nb�Pg<�3ގ�q׏;Au���>���pV��y�)�h�����r6�������Y�-�S�R�=�ic�y��fR�ēH��nAjd��V4�z�Է���ˋ��wg�/9�x -2qxW�iY����EU��b�+,�=��]bi/��f��/ޣ�E��O�o�cr���fO�d���/9�%o�����_���]�K�yBs�B�]����p^�@�F�����k�QZ�F�a�O4/A[�\����k���� ��Z�}��j��>P���r6�\�8X���i���Yv�@���f&�m�6��]�+��r�XӐu��d�M\���`�81��zk夵�lci�
{�Zm$�q�ɂ�͹b�eZ�-���U0�>KA�L�%~�0�13�ݦhU��&�����c��L;ׄ���V�(w��������+�Y�5�uk���#�Lq]T\���~8�Y��<*�&ZM�[�̭����O�w���!����`o5G�h��3}�3�\��Aԭ3���d��UG�4�4,]6mދܴ�_�!@u!<vן��-DWե�N��=��<^��t���9�̯3���y2���X����U�aT-�,�k� 8k	�����qC~�p
Y^�ڄ���"
���p|�    �pvyѕ	�������b��!GWA$aTT��"����7?���	T؇�QL�pO��\��%t��2�6��hQ�Z��A|���f��E���}�q�w\����#-�^�� _�6`/���V�Z���^8����/�����=���������(�o�����������wr����0������H�K���7|q_^���g�Dx�IK=�!���Qƅ�'��E#\E�֫A��=;{ʝ�������3��ƽr����	�&n�.YM֠k�>�\��&���vɔj<��{�1�����Qh��Z��\�T_z�ƞ��:�jj�U3;����m��N'>��Qh ��yME�
#��Q��쉼�~����>��/-fBݣ�J�%��6�V�3��l7���������Jۡ����J��ltz��4[�ݵ!y:���N/D�Ӟ�<cE�(��
���+-�i�m�(aF����w+�)��yHU���$.0��P�4&�I�`���/9���3Dil{����X�B���Ih���e䙔P�}_�;_7�t�pK)�������jge�x��,���:��TGS\����l������ {���ӨL''A�5G��B!|���?�}�\��� Q����/0U�Q��bǻ����:^���wB?�
���ӼH�&8b#�r�ӯ��h���i$fv&��;k��U,͔uc�׫r_��a�=��Z�)k�ƽ1�d�xA��`�1�Ý��ã�C�Ъ�#.]-8�q0۵wO�}ORd�Y;�h��ۚ���XH4!�<{4�e6\�U���uﻕ��-��3�i�aԑ�����$�0O,�y��	�a��8�@���S�2����mu�aЖq`���oW�H�U��q�(�'wt�����9����^�yA���g�q3d�v��sa�'�'���G�s{[?im�U�\���r!$�b���(ۑK�ȁ�؅��De�������%����9j�
���}O|��UU{^�'���&��Z:d�j�JM�x{�glw�2��u2T�>�ݴ?��+Hy�gR3qR'����K��ۺ�4�-��>�Vw�+�κW_m�z�f����E�k!�Ĕ�nʓLY���/�/P9��B�P>摩�0�b }���<ǝ�TV,8��Q(�#�L,T �t�iJ�>H�߾�����>*^,��G����t����o7�C��1�Z��Q��z�r�Y�eЙ4BQT[��������\��n�Ⳮ%r�'��ƶ�4�2��<��:�f^>��L��Z�A��K+���:h"`�Y
�.�w_�����mC����"p�0�|>R���sw���/|g�n#L7���[��w)�#69��/0�Q����y܈��/ܼ�`�Ó�8lU�A5�F�U��6�f"F���K���x^w��Q8���uv�5mK65�ي��~��]Dj�n��S����&��U��̵��Xl4��<�
���r<��)K�P{'�.���@�q<�(l��]�S�9����!T��*�.���d��?��^>e�&~����*b���
J�=ޟ�u̯� ���N�SI�X��uƚ-" |EudôR_F�
�Uz��n���c���>^=:<>�*K����7��� ;§>�H���dǋ�	� s܎6��;d`S�`��}ie}e�\�J��Hw LyaW�� >~�	���n��1Y�9�91d��ynӢyP���H�_��=�q
�9��B���K��P�u�f擮�Rv�\�u�=_��T�M���о>�~����0X�0���
B��S�5��?��g�6���/��FRd���P&�B�S���2���),d;�}��,�z�k ��P�� �Ru�i�;;�ۈtV�������UA-�Ҵ�x҈(�^;JQ�*<&rSNO$�1y�?��;9��\���h��[�����&sr@-e�54��)ck�Z��ns�'��gѥ��'W����vgwTI�\YT6:	x�����p�g���!�P���a�	�0C+�����+�E�N�b�'�vПy��6�<BGTn��c>��wsjw��T*P��Lb*/0�UQg�-i�5��-D*�l87���2���O��[V��sZ/K�U�%D! ̳�©�{�*�(6��Y�r�F�M�3㡼���t;g��VME��3fiV�\�����(�f��-Me^�˃���}�s���-����t�@V̓�	@��Մ&E�A"�$Ч��^��a�I�}/
��~�3�*e+����2��J��<t�xD`��U��ѹ,����=��H�؝WGm_����j�S"�PO��@��1R�
;���QP	��vb�,FTq<�ݶ��3;c�X���X�nTL�q�lWq�J`��*qʸ���D�Q�q��kO�z�Z��ձ����jc���u���)��y����ȩ���@��Q5�[%+V?
'Y���t�_���;8Ml��J ��5$�6cx#����E��6�M�
0�n==�rb���`�w�y�6�q�!�5^`z��^����|���K3�4y���)q=u��m:������kl<�r��>����; �qR�^������3iy��j�\%�O.�NUV�&�qM�!�p�ʆ�
o�`GwAoy��Zzf7�������v����a��%6Z"��/E��b���|1�����e���t2J.��Դ�\���=�N~;%�/�*B>�ӹV� #i%�-�����/��$c�ds�� �:�X��z�|��"�1�*�ߗ���]��y6ۨ3	����Rm�Vm�����3|�9�O����Q����҂Ǚk����^5���@Q��;��q-��a\��u�B��	I^r�q+����ψ!�����%D�{�q�[B\l��zL�UDb#ܱ���sh�qI�ݐ^9��7�B"���4�T�� S�W&F��SI�v0�r�K�ݮ��4��!bm{����o�k��3uZr�%��Bd���U���2�fc�U���|6e�j�W�B����3�P���6��������kWqe���<5N,7�Be=�����j�ז���K邕![�����ɤys��2�-��CR追��3}�B�&>�}�ވ��k4C�!6��l)k�`	�}��S��l��BT��:C"S`hlz��d�`<��v1}y�gB�O*�����}��1UweGS�A3Ų�����*;k�݅��c/��B�{�,�4�k9�&�k+T����ѕ��B�L�-����Ծ���H:��0��֞)&v�7�a�LƲ�A��={�/�����\�^~���v�i� *y�diMZ� F���;-�� ;�7S[(@t%D�~�LSh��pRy����⣫zA��l�Τ#`I���@�;���)3wƖm�,�n�n�f8;ϏΏ������� ���z0��ͭ�؛ӥ`O$rVX;5���+����+s�c���I�aY�8�ǻ��JS*�ց�B��Ԗ$.0E@�GWJ��Ux/ny��SE���v��i,D9M�v�c�&W���huzx��q�4�b~�-��I5�}TfZY&?%4�q�חmh��):�SѬ�EPݣ���-w��qe'�Y�T��y�tm0�+G��r�Ό��1��-x��6�4(�S�By�p�$��d���o?�Qՙ��yc�)͒�fG!P�K��n:d驪喟�$8 ��'����l�x��=����Mwx������Q��ͭ�IS�ؔ�vl�H���1k��h����V�be�bg�|i���lo�ec�uB4���퓁�2��r~Mʩ�"V��yG��7�����V��/�
��<v0����[���-y����3�TD�Fi��t����Z�o0��o��*��y#S�x��� �1��4�E6Fl�/&����C.�~(C۔�MF��:oҭ�JA6��?��a����؝E�q��f��+.���)�}�_�=��{nm^%ϕ�����V�?��o?`�q��-��(f:� b������    u�^dk7��@��D>�ʜ݆��Ǹ���RV3�ye�:�~�iBU����ݐ��S���uly��gl��u�H4s�]�ɩx�	��5ef���\��J�:�'�8�S+�|	�2gKf�ݦh�»��L�s�쇰zt)���m�L}Y�]vl[D	��T����6���V�ܧ�Æ���;�� l[�e�l�lۇ-R/7�Kl��&��-�����w������aF�L! P��È1���W�н��7��.�^
�'�5U�$.<04��V逊�G�Cy�"���,yT�>�Љ��([��r��K��J(�(��,l����XC��0
n}��4�{���#�:3�MGg_��J�1,�`�m�q��Q�U7�ٍӓP���^X<b]���KbG}aj���
� y%p*�^��Au(4�鞑"���@G~9�u l���Ϊ\<��}�{���B�/��i���4��_�0��iHk`�v�X���$�E�p|����U��iԛ}�h�u>�;�"����{d�?�[,�=ۨ3)c�6��F�;�Tǐm׵�wl�(��Q��8ع8=9�.�틧��x4��_���h��"�/�.7\b��^�;�~�<�}�	n[����7r�����򱒷ǎ��	��&>�JgV�,ȹ���^q�)��G�A�4��RG�*�'V�x�G�B���d,w<ަ���jN<���,�����ψ�74'<ۮ�UM�*��٦���g�c�l��b�?mE-1�Y�x��������s�J��n�kn�QxӇ�&��:�|73�@LAb����K�6�n(���י��0��
 7]��;���/U~n>�G}G�q?2��bݚ��[q�i1&���8Ɖ�a)z�!���[{Q� ���)l�T����;_�ق��Vr~x�y��k��^��ųό���w\�TU��4�)z ������Zܺ�w�<y�5W�k�Vv�=@��c�r�������rvI?yT�ONƐڋyA%w?����~����f�K��<�#���4��,��w2��!��J(�D��Y�K�0�3��*3R�N�L�1y�|�,O�<�{���zs�vS�ү�	1sv/��}�+`G�"s"c������c|�,ˮ᪲��:g)Tm�h���β�tU9�-ul]�^�;9P6H�!�*Ē�$��8� <^�5+�OϮ�5n����kŏ����鉜��C�����kuv	S�	Y�!���g�����5Z��mXR�;��C];���)�9�v�CZ���c��}��Ϡ#�{ݚ!w�^t����M�,�X�p�[����9~�|��]_-?gO���K�0�淿Z��W�������u�<h#�f���٩�M�������U�sVLbr�0\l��v�$[^�׃n@V�x����̺F�Y��D�2y�+�9��e�� ��8��%��8A����/���db7�o$�Qk��j�pQ+!X��8��0�"SA��L��*��ۍ>�i)P����Z2�`���M�Ty�P~r��<���۵-��t�;���Y�[A��tT��3��$��Hvm|a�`>�c�3���r%�ίC�N��i�#]�"+N�ʆ�7ƽ9q���l�Y� ��W�'�Ay��&|/
�=M��M��L�&�i�� a���Z�<m^e�>2!���$G�I	�y?yx���C�5՞�i� A!��}�����(�@-�%��f���bF��~i�������E}���ַ�`yU�/�ݍΓ�� W�=��*&X�!�Uq@��O"A��nST t�eX�r���|��"S���qOt_"��.5{ޜ�[��-��i:�����a2U�f�u�MR�����_�������G�<v%`�T��`�l+�e���y"�vsA����a&�j����X���4eK�\��Ʉ��� ���|v*��ek����q���d-�e/
�1��Nv�$f�Ύׄ6�^
i����D_xQ�a��W�����K��>F�ɶ���Ȭ9;P�W&�2r�V>����������8���_`�#d){IV��Xl�X30,|���򋄢[Z˼�|��0Ķ�:�q�_G�P�v�6dD���翨ǽ� ����d�#�M=[����ىb+��;��gC������N�r��Y�dg����X[��'�/LS�>ϙ�٥���[����}��0��R$��-�q�ntqE��:J~y9���=R.��$m��=r���X��!<����tAEy�gw����	TT�	�~��N`��E©��&u���?���e�@֫�?��b>�gai{���56'?���:s��E�n5��Nh� ��Z���#�do�('Q}��],7�o�g�n�������ч��n� ���q�9��e�%mYڟ�01�a?�q�f���߂���|��޼*��6�<�@eh����Բdlct�<]�I��Vi"H���!�.`���!�D���f1�}����v�0Uy_4��������^��-��\&{��«�`��8���>�Ӛ�	��dzlO�s�U�,[3:;^7��ӂ���A�g���qOt�r7�>c�B}�CSG4sA���3���1�L��>�!��9�a���S:��?�C�� ��|����]�5��R�`��د]?Y?�e��hS��㸉9U����߼�P�*�0��b˲f]��P�>|��:��;�&�㨜_�I�X.~��;2����l��>o(��x^E\`J��9�Y��DrF��o�Crۡ����o�tT�G�k7kE9aC^3�چ�~)k�a˶a�s�1��H���ʢ�<6+���I�ްV���ф.F%��|��&7��z�x�jV��=�ےΙ�2��EhX��B2Ya/|�}<B0y�E��ȅ*z���y72��m^S����[q���$�1&��E'1���&2�in��"�>;{�S���0��Y��sI��krB�^=/)B��[ުF����P��WC���%4MA�`��3��%�Zk��I}�$�^17������'\�]_�E �+!�š���#���1�O�e����S�\p���ڦ��7�18��W�O*�Ŋy���)Ev�-y��ٌS�.4x��&�A'��iC�~�s%Uٹ\�Z�fv��d~0��{��f� b�7�1TW�-(q��υ��.T�3oq��i7w���ĭ�Fq�\�����e'��#���U�����x5`Y��hr�O}�S!Տ ��3�V8�QF�{<�6��D�;;�����Ӵ�N����^�bw�/�y	����9�9K��9�ӂ߆k(G����	���l}��fRA����ìLǰ�:�^�v`����������^9����G�fGAS�7�g�?� �,��T5 �4@�ӽ���Un����[(4���X���E��:� J��<e,��(�ӛ.L������5U3��Q����hdm���){!����M��C�[�r�3U-���2�L�W��b�A|[64E�+��ʾ^��3�T5fX��PG�5���/ɕÅ����F��?>}�hx�F��"ESS$E%9D�Ka�Wp��8��'�tD�2&`��{�τPY��q<���O�`�<������ù�;1�;���TFL�1�,di�nّ���B������k��;��Z�y@�Q���i�d��HHM<���a�V3�b0���A��T2EuMuL��T�L?;E� ��O��[��zV}�w����H�O�(�6Tw�}�lo�T�l�zbp��A<�7��
	�N(O���eC����b�4&�1\����9������l�������w'�yV&M��h�䘃G]��r�����L��x�U`X�C%��T�ni��w[����!�����1����J�*�S������T̳�psp`�.�r6��]��JT�Ɓ�p/Rb�!�1�HB-���Y!83�GX���7�	�R7h���?߽Ij�3��b�D��a�S/��1ύ�Z@����.�tB��g���k��2��4d@M��t{)���Y��г�35    �v�I�0|?�jM/�Z��L�uX-,~蹚���lt������q_��Kue��b����g���S���5�;�^�cB�~Y��-��$�F�\�,�fq^���S&%D^%'����F,�n����p�x:e�6��a�wh*w/��*w^�����]L�1�0[�xE��K����2�P����E�����=�[{�+ܒ،�|Ll�|��Ϭ ��GRU�S3z���7���STZG5Ef'�.>��]��4���z�W�iga+jl����F�n��c���Q��$�OW�������	��6��jT�3^���dɢ�l}���u_��U/k^��q�jq���3�s����*i�$��G����+RR̬�DFލ�NG0�@�A텬b�3:��)���LYlY�x�f��^�ח��͍�N��J��x�i7ڪ��=�z� e��	�\�e&N�����4�'Xj�5�3p,�h�(��R��nŸ�-2sDϐa��T�����X��*��lq_���J����R޳���c��qU���b�ٲ�>'�б8l�.�_T��|"�,��pQ�>%:ٜ�|�R���.�1[&��ہL�'����(;�l5�����U�d��W��9��L�~����X��O�IzZ�<�V`CD-(�3G��R_���!�2��#-]Hi���4�� ��9 	�U�_��x%��9W����.������J?�J� S�G���Ŧ1o��ǡ]��n�h f����!۪�Ǽ�^��5Q[�Mx_�P~,�l2#f�=�"fa�aW��7|x�-��8�3)9T.2���e۶]�5U��5 �z��1�D_wU�(����A����l�6�^o��5���o3�i���i!��ϥ܊��h��'�9�4����?����&�ɫ<���[
|��ae
h��E��'V%�v��Ĩoϳޱ�fU���F!�L���j��7�R�%����[�>�$�+y��ڡԗa�U��R��h׷dȥv�v���Fʰ��@��b�߷{V�cC�̧4抸�e�:�&]�Weg��NW�[�02%�o\������`mo���>��Z����φߡ��\ro�gr�]��Z��hA������?���7_IxJ59Q/2�g�Z�U1��27/�HB���(�:\|�go��݃tf�ˆ>��Ö_`���~��2i��@��GH��l��7�h�|
s ��Ҏ�Ӄ̀Gg6��a0�)�b"�����*S-�}���3��6�aƎ`j�8����bY�!�Fc��o�6ז���kukp��f��H�7$��Nq�s!��I~���|�8i����y��Rnð�wPCj�E5��@f��$���Z�]�ww�`k�1�Y���zyT��Fdf�?�d�^k��o(�ڄ ����̷ݣf���)A���7�����n�T���&�	��3C<�y�������_zd�-��a�ْ/2��-�cU�V�p��.�۲�T/���jmpZ_j�O�������4�n!r�k1�}��NX��;�w(��_�a&�g. �v�B>�Y�Ąl�p��S�"P�QkOb0Wz���$0�5�ye����x�a"^���'��s����6M�Oy�+�'���Ro��Fo�	�����MeDt������闦&����saƓ3k�s�n�����V�������9�)ձW�"�����2���t�5L\�%0��瘭0Z��^z<ŅA�t{���.�%Ƽ���Ob_�LK0�ϼ�����O�P��Bt��g�[��J3��S�|��ON=u?/��S��.�mԙ��4Ϙ�U�<C�4]Q��3�S�Tŷ<͔mKqd��lk:s�
F�;w���gċ��J簳�d��o ��'	V�"y4:% `&�6����uBT����C��7c�`$@cu��NL#*�˘f��e��p�*�~����W�<{-���̹����w*�yUS�ys��P\`��Yz����y����������a&����Fϧ�j ��$�b��Ms�b��j�������H���K��[o��ͬ��Ћ���ӓ���JU�óځ�ּȞ<�ـ5!>��s��%{�EQؐ��+��y��O0��g����!�}l `m�Ͱ0��t�t>��y���b9�<�8�<)����&�e3G(�y�|m��I(G���������[�՚��bP�chC:'����0������(�`�|��3Ӳm-�ұ�����ϮR��l}s{�ݻ�غ>�7����dЯ��\�����Deb��'��M������d�1^�^������f�s_zma��!���ac�A1�����Ϊ�M�'4u��%U)�ߵ!Nw�<�NCX�W�؎>g)J�5@�,��ޟ2N�
l�`c����+�����a���q�Ho1�Lݙ����4,Ǳ4UW5�֬J�7�3O	�*6{�.��:8M� )�m�ص������ZP_�wW�u6�v�!	K�7�5B\�|`&��PH��lG�*�h�D�!�����5Kv�["���*�|���
�-(`��H?ϕޅ9ܽ��Z�`r�9x��G�����*�W}�q�����;�`+:�>Zm�}d
��K����M+����^[�Q��w�6�}"j!W�t��T�ͮ \��w�Q�+���Mt�AWMGa��ip��,\��T��]�2T:�僠�u~��|�^�)��}i3�8�pLb0�0a�� �3�!�}���0`Vbŋ�Ä�;��0��y��t�Mm4�,uc��A�Qe��v�F)���]�Ž	zV��y�o��H�Sc��X+mް'��2�����|aQ?�!���Wi�hv%XFَ%��Թy�O�Z��8�e68$<#b0g_FTz��}���F6��F�;��s��bJ|��Q�ٔMJ���i:�%[��gv��1ҭuos#�q"�xqse{���\]��H��W�|�*8�~Ǐ��4�(�e�

����̆���ݟeUĚ׌ys��H�S�TD/A�`���Q_a��G�h���Ea�	��Q�h�ޔy�6�|�uz	�t���]@�����d�G�+)�������3�D��\0AղT�qL�`�)�|2O�S�*c�E��b��r��=_���]�ڰ���J6��7\�HQ�� �L��m3����ce�!�/��r�����%�q9s���_^I�x� z��@����I-�}�X@�!Hw���6���� z�y�'���;>��Џ�ƛ�1Χ�H��x�4�(-���f�� ��^�$S���&�B�k�z���܃��S�s���e�7B�|v�k����v�WpJX͇��K+��|FEo¶�dgU�u�2��7Ս�%����L�_��u�=�V�c�u�����z��/��[�gB�k���^vI�A���T�*3��q��!,|����?��9�Ig���2'1'H,��bk����MR���s����C`����c�Jߑą���晥EI�j1��|r�a޿1��

=�V�+��N��ivi���Z';��D)D��SD�qy}��CM�i�z������YU�̪���g�⸦g�ٙ����5�bB���i�E�ͭ������G�I���5��8{/��x�������Kg!��tp�5-a^d�z�,;��@��׽�X�S���tn#���N7_�my���8|z�?�&� �Gbi�f��5Wz���=˼a��<��%q��J:m1�]�;�®�&��𖪘��N��Z��>@����'���WQ�S7�7���C/�(�����|�Ŧ���<`7�r�`���fF;6MJSuUÖ]ǯTl�7���<�s:��i��lK+|$w7���.NW������ax���Ot<�)̱^%��t�����e<�Z`�',4W�.��r(&�)v�e2��8.�>㰾ُy�2�WVU�H��/0e�HY��"�@gH��60�_F�GR��+�R���srF��*��QK�!���;m#W� ��G[��)��-b��!�2�b��[�`F�dcExC,ð]�d    ��Z�g����,�T/��zvbm[�����y6�����{�ڝj�9��-���;泅jX�Yg���Z��:�D%e$!\E�cjB�'/2f~�/<�#��!�N"�g�AD��G�Jo�ߗ4��te�����tRS'[0%K��:lb��/��6D3��8���������J�f�|�|_�Jo�v�%��"Ɖ�M8�g�xX�߆�1zF1����7���Z���n�XJ�rf�/�i[6]�e���O[�Ѭ��5ݺ8�_�qO����]����f���W�N]TΧ������"#H�O�����2P~� ΀�?0=�M�M&��Y���X?����ZݞQ���rp�������D
�}K�����M��j��9� Up���"֬ 䴍	C�5��i%�j�@�XW=��$ձ 2�h{T�:p�=Q�ؽ��x�㧃ꎂ��-۪b˪��b0�.���'��p�z���O�Ý��?��~�-Wr��PQYx��7-8�8L�:y"ձ�fD��b�5 ����^k,�s���i()��ּf�+��Bv�L�	a)�"��`��i��c�4G��`�����(��y@�hQmjOr�Ō<Hr��&����1�}�e�
D]�b��1P&�U���]�gV�0U]U�pUU�,��̊��U�gޯ�Y�);�MpEñ��<٭[�K���� �_n<i�U�$G�E���Af�2߶���]����K�F`Ć !�7�� "g2]�S���׎��c9�9������ E?��W.je�d|���&�Ԕ�Y;�ۀ:o���x�:q�m���֌��RD}�:l���סdic�"����_A��=�.G��I'H��.6lУ9b����C_�X����6-��[UMUּ��Y�m)��Pifi��r�?3�5�hD����/�ϏUv&<��7�}����xnG�)��6 �"I&οo�ddI�/1>D80|�G(W7�Q ��%'QFT(��۬R_�7���MV��|_���@~�i�M�J���A�ߥ./w�4���-���%��L�\�!�̌�.�p��4GV�ɲ���h���ܽ`��ێ?��E�	�i�eۜ{� f���⒫���;����a{}uU���=�..s.Pq���қc�x"2^�0�
y
ɠ�����U�c���r]�a�+vr�,t��\5���ɚ�8� �\M���*��3�'YϨ/ �&��mI\`�KP+K/-Ad��D�[B{X�~��/�����5Sr�a��v�i�g�(�;S��@�τU"L $�p�a�]vA<�]�cFmf�S�5��s���+w�x_s�2e� ��M�p�Y�n�b�~�F��T��v�pwNk���\*������\V��J�WQ���+�%iU��-h�ԩ��i3'��ܘ���?�=�Q��Aﳎ����U����6֢X0Z�Ԋ�G�>��#��u)�S������)�e�<���>\ȵ�n�t�|/�䀟ke!K�=*�ڮ�`�
�f��k�g3�R���hi�	���Ȝ	x������� �#�)G@,��V0~�w�qG1�D����jj���mC�-]�]W6-�皪s�@3
�HZX�����㣃Eu+�Ck�l@m��+�hc�=B�Mf�R����I�*��,�}����L0�(8�Ǉ8)��CS�����d��:'��H�u�{D�߹����?��guޘ7�0e6��,�J�j��g7ޏ|���(��a������������ݘO8;���E[XY�0�P���cf�@��t��g�]����Ϥ��{�h)�0[� �.>[��L�O/��J��W���+͕�gO��8�?�%@�C��_���Y�e��MG߾}�����تՉ5��߫1�_Q*"�1��	�m<=����K"3�C���~;��~�8����ل����>#�ܼd�6!�x����<�+n��)��i��eZ� �شLj�pLă35$Ǥ�+v�&�[��z)����3*}�[��U�v��ժi;��[d+��˶��n+ܳW����m<�v�ã��r�ի\�ի�Zֳ�`�*���//YI0,%�#���Ȱ��H�R3���5��U�=�E8-y=�p4���ðU�EP�E
�L�ܟ����oqH(���OU�s��	��ڗݒf̫����ے�f٥���!�����p��6v�4	R��z�1�W�������8�:46[�LP�r� ��ϸA@�:춴-ت��z�Sl�*�%�w�,vV��}�l^>m/�d��ś�B���!�gAyا�<����t8��g�� �䩨5L�D�tȰ췉y�i��s��黯_�����Jo�c޵df�K��]f{�k����`h�SZ�2(t` ��[����FE��4kا���m��WQJ���͗Sۀ��~%$��P;r�������Y�N���N�*v���fT�~�g�Eslٱ5a�+�V�ң�N�<�,�[K���Y����q6`�[;���bZV���2�z� ,��/�$͓E�4J�Y�
�Z��VYձ� ��v�R1!��7T��
�\�m}���Cjz^�����b�Yni��ܚ�Y���!P��v>�[��|x`����\;'%�y��@cW����ү?��6����[^t&�f�V�jA�m�q#d7t][a�N�X���E}�J�����nG=�*[y޵�ԉ�R��_�{ˬѐ���7������>���EM��`��83���͔=��rg�5��W�� m�L�e+e��n#�&�o>�M�����q�,lI-_M8��8aAeG�1q�:��^Ғ[��{�V����Ψ#l�a�f#B�.(�f5{�j��"3�єm[�K]��w�^��ʥ*w�\uϯ�Osu�l�O2�	k��u}� iy�7������OT'|���nQ*%�p�o?�B�.�Y	�Z��
Eo�ݭ$�UIu��qmq���l��}��rZ��%�u���f�)x�D�,f|Y<Y6��#�op3c�l �@�`�b>�*�iaz
�Ӭۍ>����������1T[�m(0pu��mM�4�)��=��kEo�Ͻ�F����ف����
4�'����3�*i�<��%\nb%6��}�A?�AC��q��mc^������J
�8������-#}C��^�u���5�2�_`�Gh([+�ٚ���7+�e�0IJ\2]1]���Q���r)�4��6�`"+@��f�4{��U�͖�lt�� ��1�F��l\�3fB^^q���L�lG�+gUS�l�p�3�3;���P_ ێ`�v�p���z�^�V�������z�u��Z�\�R}B<�У�d(i�b��u����j��MY�:����d�A���S�N4��N#N0JZF��<�aڄ� ]""�#/�(X�]���?��Bw�k�p��l� 𕭗��)ݦ�6�x/丄>��8N��Uy�! .�ix�z�r�˭�] �1S�Ex���� "J��U�a��f�ؗ����j��":�B�~�lcˑM(W\��>�/�?�_jn���s{����f�}�A浃�~���?	 �K���d��T�&���d�B\1o���)O��F���~ߐ��g���	Tt�р������%�y-���R#�R��@�ufTk���Y�)�g���EJ��NRkV��}r0��f����̷��h��p�i�K��{���ē��cI�u�YTQW�;�~,�]�Ȥ���:�]P�V�]���S�^_��ҮƓ'yKy��DZ6��|+� ����0�#��B���$��'-������-a�3Z;�5���+�2vp<��RYP��*��$Yy����S(����ӧ���$.���\ˬ�V\	W�(`�aS��|J['kLl�� #�;�=$���"�>�j��؈2�(נi�U�(��V1���#�
|��U�`g�[?E��K���홢p*�'k*b��-�й湊l[�6er^c�-Cъƅ��������D;��z��vO��ʸ�]{up-����b	Ӷ��B�UXVb�g_    ����`�0-��@ڙ��� �$	�2��s�7��G�:����H����u�N�d��w��nұ�0��w��x���~T}v�z0�|	�Wr� �'�@Ɔ���Nѕn\��)zr{N۸��^���N������Ț똲�r�&�a�Q4ѷ��Yhv���UNV����� �و��A@>Z	�~���n��T
p5`��Tc�."/ݖ�I�q��E,S�AA���䋾�`��J�j�ߨ�i;�����8����F�����,�J��:�1WN���x��]��
:���Ö�l�k��E�8����P�}�QJE�0�6�3�����������
�@��ǣ2?C/��y��o��T�V���Q�u�w��y����l�Dg9����Q��[�)ʳ�������κ�y�k
�����E/�"�L�HȅD��F��ׇkؤJ/.�?�t7�$�C�{B>�{�@pcJ�&&�_�v�o�#޵tf�jM�yu�x.O{��%D�L�ݿ ��ى�����e�����8l���z�0uL�^[��  0��Tc��,�Á�o�Y�@�v�ϞS+��O3}y�.Keǡ�8����Ϩ��zQ�Ѻ�&�����z�a/�򠲗U8Z"��9\(J'@8�9N_F�~%�V6�J��ˋ��d�*�t���Ի��P����z����K�\�M���ґ��6�O�\��p<�a1Û���Gp&�c �u�O�+���5H�Fd���IG@,�~c�մ�U���5��Q��:����T�t�w�@׫�n��r�;���/�5���5Y}�4�ͽޮ�h������,�;e�zͣ��,K�;=L�l��G�1xm�X���0�Xi�2�Ih@�{�|������֭I`fq�ɬ6U-���������CWS:;ǋ�"k;d���%56W��83A:}�BK�mbJ�.�e��M��v�q�^� ��Q�@��3�05Wv5��8 QAQY��k\,��*ͧG���iO����҄��o�޽Ϗl��㍜M�	��=�gC:��+�*���a�s�A�@� 8����a�oϕވ��+�ʖ ��9��Ӗ�����]���A�iȿݼlI�ۼ5�)�Zt|�C��ןM��@�@�T�r`�`�	:�x3R�nPSQ��,���:��4�U٪�N��uGU� 0e�qM��}�M�)���d�ts�l}ceyQ�<�޺�v#G�E\�u�`&KY2��4ŷ��0X�����fV8M��A�0��F��+�L��?���s����G��}vMk�� �~RY�픠j�Y���hjna櫤
�N�4�r��-ғD�B-��P�4�5Hذ�,�T{?��F8�gk�e[��8���!�P��y���/1�7W��.���ZTӬ�P;=m�n_?ie�����V��A���C�3���� $Nu?_,:�V.�6c SP8|���s^�}q��`��cZ�^	��s_~���/(5�A�oa��n��ը��b���x�����T� �vKK��1�"��a� ֘:/�f���C��v����Ӕ�f��Osk{�}�8
�k��tjن���$��k�L�:�
��Bw�7�j�W,�m�L�u`�p]M������=���ǽ��UCk8��M��KD����7�IK��˚=�GZ#K.սA���_�����}OT����5���"���m�aR���o2�k����\a~k'���P~єyu��_`��;
p�P+	��!o �+7/��%�Ѷ����f"�m��f��;	�d�sO-�l�84aN���=�PIa #h����H��44�c�`�u��W~�7�q�`���`KfV�T�2]�@��@6]��!���F,��(��Ӷ�(/_��k'W�y�o^.h���*R��׻�gh�$�
G(v_��Q2?;>�g�T8� b�# �;O���sް&�,��� //2tc��;:�J{�[�6�Y㽬���/���
���T�x�PG4����uL�k#���Azԅ١�q���HN��f> �!б�O��&�m��)6$n��/��h�8%�X@���Ϥ��{�e��X�e���Q%UנXb��'�5�=�,�&g�9�/���T����`㤟M���<Do>�˒mgZԂ�vz*2-�������UEN=XT"�t�(�$	 .X�Å���q�]q��-�4ᣇ�J�(��_�+�u|?r�j�9�|���
U1;�_��	��ϥ�~):�ݼ���`>&G	�Nw�_�@�:�Tu*�!'U`3A&DO�d��x� �p��}6MU���5c��w|��ٯw�nF)�jh p�M�aRM]+�(,7v��V/�gǋ�q�a.v�G9~_�]�}��k��1�%�<Ҳ�Gฝ6F��i53�mD7OBP�5��KRB��b�����p ��K���	�)�����|�F�_S��(��K�G&D>5QD�<�BT�G<H	��u���t�M%�a"���Z�\O�9��O���-	��
  c�g��_�`�ws��wb���������Z�Ίװh����b����`yu`ƞ�֗Obg;��:�[�s�V��[�rΥ͐P,�"���K�+� ������[z�-f��|�׹�
�9,���&��8Wz{��^�<���4U��*.%���j�%~dx�ү�P����LN<�!f�=���{�a �mJ81�I!	�P�-�<��]׋)���ڹ�&ӓ�բ%��ͨ���OyϽ�w�\�V�r��ѧ������bT�L9t4!EW���T�d����
$�J�&�ʄϣ&mo�#ݱLe��μ��Wjے���7�:��0}{aa,M���;`�㤑8��78�!*����� ���z��}kN;��s���]c�Zz�tv����n1�&ch�'��P��rPȆ������UFho��ݶ����E�l���g��j��� �B38��j'��&A �D3uq��/��~��ZD��k�[��92�/S+#
��z\�"�J�� �Cd#	�g���;0����;�$:&�E�,��	7��܏x˾>��{C���]�ܰ���/�z�>�1։�����b�>@ 8s��'�%~���4��I;����V�[����	�aSn��t[v'��,[�)���3�i[��7��v`�穗�낎/[p�<���_>��%ȸ֢������Y&�c����ʕ��;ιq�1�&vp�!NE+�#$o��ݿ�f֜7�yMWX~�),���������Pi�M �U�<E)q
��	��o��*�7k)J`�4"ű9�ێ04`'ja�~�%�o7����n��Gp�#U/Z���'{q�_�K�/�Ue���j�Z�lͼ�����Q~� +��]Mj��^�>IU̝�S�'���]��������"@yuP�qFHT��ԁ`\�͓��E��T���0�PH�W"ܼ���P��|2}B�2���ਆ�` ��0�~�0����dn���3j��U��]��y�ckg����*�e3�ptS�u�íTGU��7�5�Vϖw̽h`w���cc����.2�h����o\��E�C�� �����qh�> ��%Z a�0��[K;���B��c�!U-�$�o�݃LfUL�G�q��*a�:������2�Q˽a�ն �M��X4�-�	�bM�{��0��w�8����
#h���F�,Ⱥ���nM2h����r��|��׬<\�/[9��nk��ra������"}�P��Hq
&jQ���ą���jHlhtZҦ!�H�ʬ/K�/�¹��Cq&���b`{�|!�,���9ܱPgt��{��m��I�_�XXs���ٝ�"���~ �Xe�zZ�t��g�̥'���5������T��'�?�g���94�>j���wz�Y-F��������*?'e�6�	oQ�̢E]?�7vUo�����b�٬d�3S�0�(����?���~�뫛�����?���i_N\��Ɇ��J�)Sf�Z-���0z�$��$vS�˗j��J��~m����Fgq_    �l_ ����� ;�Ew���o��Y�8�&M�2�m�����&7e����Dj��X9����h���o�=��N�������}��g?ƫ^�ɺ��4���U�NLM�L�]+l_:����<�������)W��Ro�L��ȥ��ӷ�_�ެG��H}N��@s[�ɨ�}������}�ziDF�]�UfdVV?�0��!���@GWj�RK"89HB�����?��%���=�#���,��G �̊*�p3w[>�
�L�'�P)��ο[�<6Ȟ����%�dxs��C&�;����t�F�K4�R?�x}/�^4BVro^�F{�؊�����}����������N��� �E��=�� F��Ens#gQ/p��Sj9�ƍu��6�~-C��wG�JR}tm�W/��Cg}�;����'�;��1x��C������L�W�T�u,H���"�Z\��ʠ���'ytٻy�	�|6z����gGٛ��d;#�������<�=H�����O���Lw	��R��np���{��W�wQ�-d��vRno��� ��=�D: �m���h�1ew���,�1�>��-�7=õ��<_/��Q6��)�O�4�S}�9��]��
����.h�y��t��;u6�����a'|�"@e؟���Ê	�$p�7�f)�@�G� ����&|�LH���pD�;8�{�OY�yۚ����".0$��o��W��:r�d��+���6����5�7[�*2F�A�V�;��S�S,��-����E��ʦ�h%MuMKb9o/+;�qŽX2�Z'���V���qp��ʥ�n�w�L���ێYHp�꒸P(�C�>(�'��a �we3����X�(��
^`�B`��hC�������_���<�mi1�������7����70�to��-��<[9^�йW�껮#�gg<?���U�Ym���P�[����th�O��� /C19Ғ��#L&�o.9ܝ�< ����g�����O��XȄ��f~�ޑ��̦�)Y��y{lnC\`N�ߞpB�S����m�O�YhZ�R-L�k�消���MԆJm���+���S*�:s����}�6�.U}����du��U���c����~����Ku'�0�(Nȝ]�k�L'irz�e$��c���;!-!�bD?Sn���d�t��>-Ŀ�D��+�ܼf/�i���=N��S*���N_�+:��e�X���������g�4��'�@K�	0ph3)N:`D�}x��9����,Cә:�:CBu5�Sm��z㱗��ry�z�����g��2X���.;Gd�,(KUQm"���T�S��0T��Z�>o�V��X�G�n��md-M1����W_��ޝ��J�d���Mf.wj�q�i�T|7��D#��X�D�ڰ�I]�0j��4@m"���L�
�|��欭P�j�L��n6�6w�R���C�lC���acڪeAe�j���k¾Ӽ�<a�^*^T_�7�7�
�z�j���� ��$�GH�Ty�'�y�u��,��@<bF��Z�sȧ�;">d:2a�hִ(�&��P�����Ú�J����ژ����m������iMG0����d�(���>b`9"��}�gd,\x���T/�7�$����}�l]u�5�}�y6��T���@�<��xq�08�9nU�yM�p�g\�)�������HU�/6�J-6�F���"=�����v������b2$�̩c��L�	5���ӞT�* ��`�g2A_��~�Om�y9	6�'*���1�ȩ٧����kjW��写�W̝o0�"\��V�/];lt����.�����@�*�����t�C�^�ooX���Z��p��K}j�R�Jaz��$����k���I��1Z�Jن��,�i�
���@������,7_��wz��%�i�3���~��"3�.Nˎ���);N�T���',��&F1U��݄�Y2M�Ц�����2���"�06$�h��H�0��MM���� �;����� �2T�y!�ej�Qg/:��m]_Z_\�26��v��u�6ܪR��'�*��>JTߍz�Z]`` n��R��Z�Y�F����sH�������R�)B���'�wx�9?���hq
ǀ_��c|7:!�&4�1�8���	L�	���8���ΰ��6f����C����V��~&C9��=f���6HH�)@}����q��"4A�Io��\�彦Oa��nj>�};���)he�l�ڪoX@#�+lّng.Z�k���ʋ���s�^����r�r��k��L�x_ovz5+I�8�t�����)*�%|�I1'��E!�扊` ��姈� �)`;���a������ޏ��t!Vr��0��Z�����"��rH��s��Q�1sM�~��hh"V��0`a���6τg� �P�H|{� 0�"�K��?iq�YsW�ɚodR���d*���/��|/7��z�r���>��cs7m��Z�q�v6�W/�g�za�h�9�ak!u��+
��s43u{D�kZ����,��*[�<�"i�j����
b�i ��f>X7�"���`+�Z�o�����u��)�O`x�$�'�&6sS���@riv��`ڄ'�F]}��S��Kj�~�ޘ~� ��o8�ޮ�B6�F�ݔ݇�c9�e7Ep�.��MK5MC~xv�~wo�szjk�j�����7W_�钌AOA���IC��✮,����!;�1QT��Z@�'h�Ⱦ������ﳋPe��)E�.s��v~Ħ*��n!I�\�=}��Jo�r�phװr�ڀW�\��EpT��q����;y��fX�*����  G�Нd�`�v\R�.vǈWf7��=��(� ��F����y����Bh����B��m����8>���g���	Nx��nV�A���wl7^�Cgp���z�B,s�޼+Ye9h�J���]��K��Q�~N����VAr��� <�'�fD���ҡmK�-(������5�,�md�U�6�H�
k4���_�����������dߍ��ۆ3��b�d)��@>�ۆ��E�������D��91�(dG��Jx�_Mt�Z��j�lKmx&d�,p�;Sd/�h�fV��Q�T��ɒy����4��{fR��'�谹�q��l��^��{�VU��uv>}�ŃlCނ��C�S�d�\A��6�-_ �k�5Z������#������?�����<�B��d]n�?���T<e��mw4�k)�S.�R�A�Wm4;�/4�<�\�}�*ظq\����mtM- :��s@���a��t�K:��w~*��D���5��# �l��=;+x��-E[g�����z�Zx]\md(�������d�bCH��-i�"P� �V?&\�:��mR�+�2c�BЬ��k�~�H2�P��T�J��C���?��Ȏ=̹ߏH�z�A�#�C{�)�SPb`�\�������N�9�i ��;c���G�R!��[�mڦi�VJ�^�<��L�V]��U���c:��컻{�'������s��P�Z�ZIE�Z��� n&"[m����ld�0��|J�#,�c�����~b��N$���M8�r�\����|�a���4ՙKlZ��1UQ�i&UE�i��{���6����<s����"rN�o%/a"T�[��;�sH�S(� �Z�0�'<���[�N;𔊨���r��d����R]#0LKuL�VM���ض��Y�LWO{�R�x�Z������N��^9'-Ҥf�C'P�ڏK=xpz�}HuC�+-z�α�v�bs,ϗ���S�ݟ�%5���;���@��4P'�s�N��k�i�\Ƣ!ܐ�!�Ʃ�w!�F���V���)�� ���2d�ͅ2cՀZ$��[��`ٜ��bZ�nˉU7�G�U]7T�Q-�0����
�2*㚵rv��\>�;��^�����S��T��(��
�e�~Lz�P�˧	�W�#r�b���    �ݟ��I���L�L�Ϩ:�LTG]˭I-�1:��G�̜�O�t�7�y�v nu8���'ӵc�P˴� cn2�V@y,6<!F���d��4����ۖk@����Y��^��.�� �,?+Nr�سK���ns�X[�X]�K�8I�X J(-��!"��G�Ƌ�o�ב����Yܼ|��<��W\y,�~$��s���t8>̹߇d�Z����9��������:ji�|�٣v����G�6lZ�̜�����Lkf�N9�����K�jf�U���Qfَ���s�~}P�-���A��^|�~";x�~���h�mQ�	��� �_3I'�y�@���L�燘�x}
��U�F[�3��z��s�ގ��l�&��r��5o�9���)��7z7"l� ћ��Ɏi��a4�S0���c}Sl��dtߦ�����؞�za�3\?(���t��|M�^�b[��e�2s��o�W���7��W�µ1��D�d�5�r��i""��|���ga��~�P,��"���3�!{�գ�p\��3�����b�2&��5oj��p��S��&6��Ij�֑S�~��U}�@?��1&�p�l��w�aG�a:���m�Ţ�@#nJz�����U�V��zV¥��Aӈ�g϶�����|�2��K��@��QX`
�F�}�H�wv�{����k�hM
J>^`���[�)j3���p�V!�r{���L�n��E\��]��P�-۾kl'�Ȼ�خ���T@���9g�U��<[i�T�p�]���|dȋ!��d�C�0t8��o��'&	r�Y���y��ǜ��y{���/0�qI}�����L�<�۞A�3hM?���u,��|߰��Н�U�,�X�lSu]�W}��b�Z� yw[;*���r���4����vk}4u<��'ksG)��;�\>�d�����DBw�G#�#+b�O�����5�0jP�q�M�c�xFS�퇼�8{�纖���s�T�������n��oz\�M�Գ��m����_h�a];ٻ8;�3S<H�}q���@�[�@����q;�h�:y�R։�(ƅ8ԛ,�!{���tv��+�����^�Aw'�u������[Z��#�P�HPE/#�of7���y;V�tԒ]�^P�ʖX���pTf�	�)c�l��~���nq�=��qv�̿JQ+!x �6eq ��7����M*T�xj�$��5����辥sH�ysL0�_����{�ݠ��U��.nH2�Q�ʘ�0g���4�ff%"v�]�7���݊�n���0� ��AI�b�=��MvrYqX0�е���Y�单��^���-V�W_ludM9�b��\�ǹ��G�8X�m���!&8F^�`q���86+��E	�#� W7�p|�'8)��Ř7�y{��$S~�)at_:�A�Y=noX=��;���m�똩���� xS<�F�u�ulǁ2¢喼��=Nz�����W@6������pu�{�X^���^/� HJx8�X��()=/J1������b������㜛U�^����rph 1A��U�Q*���m��V)C�����R�'04f�+[h�A/~C0ED�KZ��3;�;��v��8�U�cK�e+�OȞ����|�"h�I�k+	�i(���l��o8���O��:%�ݤ~��y��6�kb�}��X�e�==�N�n#|ꅕ��s�R�Oq��re;/�`�}o���{�+'�G`�� ������'2�l�t�B�oL��� ڭ)�cs�8	�\��M���X�]�t��ym�W�U��ۄB0t鸜丑�IV����q[�!lT0a��أ�퇼�S�i��,̢Q(�ZP�
�"��=C�L���e��<=���O��ht[+A���Bj�L|Z�"�^f��DrL(N��
�_`��4�&t��	ܘ��3T+'n0�;\AqbjO�vpʳ�ٴ�v���/0%#4�a�����.�t�?�ֳ�@D�"��+ˏ��p���xr��O1����г["�8|���G��j��{� P�Gֳ�fz��T����ڦa�墮���a)�a���WtETE�����ˋ�����Y�<���z�Eq]o�
����n�'�$|�Z����Z���Ro_S�{��pP�|��߼��E���IO�8 �Z�b���!�P�4�-�C�#�'��}�s@� '��c�DE>��\�|��BW��q�
���
�83�DqH;Ó�4��b[Cb���~;�H�^��\]=nMWO��p�䍣E��ޝF��:f�d#��̖�뚥�>�6��л����cd��>|�^�v6:m�~X;�V�ǆ-Cv�Sv>�$�r�R["�J�d^,�c)HR�L8��Ҋ�\�0�o!�R�˽��y�W݀�s�pKIW��İ��c��G�G`�(����q�=2&tmb�/ 0�[ ��]���u�t���x�1�ԑ����o�NPB?�|�T��b��j;��:����yvV{6:�/͒�����;��zy�s ���0�[j�H��|�F]�qe�P|Aa�7uX�G��2�"��U7�č%@��!��LG�5�J��g���7��_`zF�þ�q�^�TY��3��l��YE�r$9�����7��L��h�j�U�.���J�V`.e1p	��Qs��qW�~�r��]m�v�Z��y��G�L^ )G��J��-5�g���g��B>b]�˳�T:�0_��� ��C �Oޙ)ݳtJ����	������mS�ϐ�~U�Y#�S$f�7_$o����/0������]��m�􋙱br�1�T��%v�i����kZ��Z�m��ө�:��/��ٻ�����Չ��e�G�,Uj�ls��{��[5, �Ư�	�����-��0"S�.;��!�"|��:�˽ӓ����:�̓�7�(wq����2�"�r�|֔�ń�p�Ov�w��ͿOb����P�0����z��k��Y��3���f�)�F�Ol����]�t�5�}�̬����ӧ��C�(�u�d���N�Ma#zS�牓���? �F�<��~	Dк�C\�`-nR���$ď��^5�c8��#k��U#��.3->��S�6�<!���5��~P3��������(f�U��]�45`��7�6�H�@��� ܚ��'L��J�i1nMVjj�E���-s���M�O�并�ێjڮ���Z��۾��æ��lO� z�Y�w�Μ���d\l�.�w7�.�V��f��[M&�a�����PL���"��ցm���;�l QE^^_�y�YMP�v{ע���7aE"T�n�-5+�� Y�x}�$H]� f�<�#~��g��v�������Qm��6S���s�����/�2�(�SKu�ŜNp�0}W�+ؼb�u�: h*�l��0?��ǁ̌��;�`��,��a��fV��A�3��������lR�g��3�S����GV�i��O;����T��	ѵ�\�A7Q�bt�B�YD^/�T-�m̘閬&��������J�"Ft~�}��� =���C��}I���ּ��kcT�_`*JiC�ȭ'��xUU^�'o#;�&1Jj�x�LpUa�}l 140\7[B�.c�!��:�����9j�d��^�P(m���mv$��Y�2�xt�����N9:m��;��rswјP�9�J*�p�/��-����h���]
�?���#�Y���Ɨ�H�V:3&#�>J��0]=��	O����[�Y~q��+��L3���P�
����a�>�'e#b��j���-�rC �N���2��m�;���z��Y&;7�����e�N����e5Ou=��3t��jMol6��f�_v��6ý�)v�%&��9*7��}'�h�������_0Ӵ[�bѺ�ۯ~�~�~� ���&�ã[� q�	�?��s�;���kYK�y�g�����LK)]hZ�5�Ք��(2-<ք3�-���Ű�8^Ʋ�醝R!!3��.�.�F��s������Ǿ�5z�nEK��    n���p�v^�l�8�(�D�ގ�T�y0���0DW�B�]r��M)D��
��� [c3I��G����V2e�2�v|�K�/0բ�i�c�q�xW����x3��H��\S�y�;q��՘�X%�fVi)�
�U,2�Ԅ4����*���i�ݗՃ�҅�PuW�����6(<��V
��_7���5�+1l���m���-aL)�%w_�ِ�/H�0rr�2o^�����������2F�Q��S2�j7����a�E���&?��xSC��=�u(�em?��5mҼ�:f�A�v;j��Q�0�SF̍R[e��`r����CO�w�#�b�Ez����3���iikv��[�s�1�J��Z�Q|�"X������dl-	c��!c�Zѹ#�O.;�u��+ǋ`%$#��CJR!�?�Ð����9�^
��Ĝ3{���/0e�Rvӽ�d�m;��wB�}�;� ��vx��X�z�;�U,�q|�2�Rضn8e�.y�a[L�\��#,��3�`�����Q����g�e��}З�S���MdMXW����Kn"��+2o��~�U����A�7�~㙪�O"�Ԡ��>�EJ�U!��D���9���3tZ���"�7<�S�L�Yia���z!+��,Wf��o�םX�(�0�ym�X�Qąl� ��{,Uf`˟"�A�#oq�?����w�6G���hyR '��8�s�US;��������x�.����!�^�������gu�)w�b7�4����^�����|�3�����e��X�Fj��k�W�)��[]��p��֎DT� ���#\�_،]��/�y�U����� ��	gx��a^9>B���w@��{h�J�>��h��a�e�l��:�'Rj`��w����+�@�/�p8����ҋ��0?�^9=m����4�]��N�jU|����q���Ox���zF���N
����B;j�4��nV�]��jo��q��]���'��a���Ix�(@Y���?�+��� ?�vl8K*�I�۠ݠ�����'���M�Z6nX�n�LnOk��t�����?�0�MqF��`�S�{���c��Q���3Ӈ![~������ B x�B���s�� �Ր!��$���To~;��X%�ji!ت���*P�BC�v��b��V		���\��a*�w���u�q��4GK>���r�C���Y��O�f��\�_߭����|�8��l�_C�1�}���1ˆ�h�� ֈ��H�C�L���	ʻvt�FK�*�`V����$ ����ޤ�-Ջ���;m��D`b�����'���=c�Q�cҲ�ؙ�GC��&�g��0�3�vꑧ<7���i��a+39�nSdWe�0�C�]��خ�W�>��=(lW�͆�8��R�VC�ht�6��?
  �-�^�Pq�����vJ��A�+m�D^�d�=T?���ڤ{��Q���C,?� ��"�bHv\�o4s��W���z��N�4D���%���vY���p�%�)AvI4�'v�2r��m�)Ͽ8�`���q{���;TT$٦���tCw�⇺�O�f��Z�z~-�{�����8
� \��/A�'�`\*�ГRA�o3�q,X��~���X��+��GX��刂�y�p��D�+ӂ"����E�� �nm�1\��(�SMB$X&{�XB@�&�td��2�P5�L�\���&l���Fx;T����w�ѧ�SiL�,�����[�ʾ��E�W���vxF��~VА�R�n�����ptb�=)���(�)|�F)x"nK�hy:�~�JY��	�I�����(Â*�=$���O��7�R1��ܻ:�{�ɴ~�Cn�����~,����yFn����
M���ݢm�N�	�jC����4cN�M�����������M�w,=+~}����^�6V�٠`U�5���G��hF��D"F�:4���!, �BRq�2�
V�=LB4�j���c�ߚDz�v㏔z�̚��d�Y��dƿM.�r���P�e�5�o���i-����p��"vpA�u�W�`(h(]U�����[��`޵K��v�0�j���]�=in�X�ۍ6�1�Ь6؞��쇚c8��=��,�J������T�`�h���E���ޥլ_7:��ӥ��T!�":DUx�����_��I�"�&<����;j��S	V�7����}
��Uo`��w{ÙHIZ�5wm�"��H��rrψOr23����$/Ɗ"��z�Kz�IU�`� L�);��l䄋�P�J�&R���>dF���n4��F�!����0A�\;+�go�P:(��6��U��Ǝ�S�uV ~� q�j�gC�f��<
���!^�!��"����(����6֤]�� ]yG&rߒ'��>o���h2_\��v�1��`��t��O����D\�oQ+�TuӍq����Sw���Ҳ2���~�;�;��\&�ܪk��Hfu����Oz�����ze���v��9Z�y��NL[!�!�eJ�O`�m�8��K��h�T g������E�
e����B�5u	cy�-bՁW�Mi0
��ܫ	~�+'��(%�Y���2��!y�lp5���!H�:�h�Ϩh����*G��CQMϷEv������d-=�-z�~{ms���]�v�w�ny*��0e��bF��n�|��7d@� EAr�+�F�V�5��]���οy�9t:�S�z�w~��,��:j�-	�;���ԑP*�;X��7��Z��ܟ �+�cA}���V�	�=c�cV��C Ѷ���x짪S*zFh��Z��C34W�|�|1=��H\�����s��q�ڿz��-.�R�I��J��^N�䌃��M +
�s&]�B�g޲��&O"�����|sj8�;S�5�!�gD�f��א�{����G�" �J�A:uH�������ta� �K�~�DP� fB����gH���-�2͘S;-�u}C7t��m���i��ox���4��TK7(�g��<��ܳ��E�ʆcl�,Z�{5w�2���$-y���S>��i�b$3`�)�Xr���vh�W\aezy.�X����Cece��H��4N�?�qb�S.�"�F� t�3�bY�yÞ7����E���H��\�)cn����7����We:$�;!i����7?S�J- ׺�ց@[	���Q��cd�W��j�AF`��n4��m�v:�/���F���{fn�R�Ylý���o�<��YO�pP��4�>�|3M*��䐻�LZp���}bjLs��j����;9��̴j��>�4�>0�[�sr��g �����6@��*�g5�H��-���<0�> UK�a��V��L�="!��~���׬l��ÎS�>��U�#��n<���E0m͵��rtÉ�g֟����E���Zg���eiye� |�QL(��
THT�y�9�W2Q5�#�Zi�PDц��fJ�zͰD�c.{�x�o6[� !f;��.C:_��".��]����֠�7P��^t(?1�8���������_aF��8�j���3�ߔ�e2�� ���c���B˷]��-[�M�y������{Y���`{kM�tV����%�Tk�9r�@��q	�`��W��7ހO�Q1����|�^wls�	1�I|G)�, ��Buq��A�l��P�?d�$�5g�9`�H�s;��-��B��gl� X���F����L9�@�`̬�3���s�ɲ�cJ��&�n�py�~������Kޞ}RK�(Q~BT�3^�#���"�ѭ����nP�2=0->��-�#-_��XJb*	6��Ӻg����m��>�����˶�UR0�~��4٬٤ީӆ=C�}@������+����B!]w|J�*��R�a��A�Z�]R=S3U'�\?P}�A��a�#̶�������bc�3��z�R��^��T��,�U�C�>�c%�W�cANr� ��A�։��p�qK�����d�$�@P�*�@`���    �G�=�U^�~cP3�Sy��vn���S�S�W-�;1�B���)G7;iG��ہmbl�RS��b۷��W��Y��fp����a��m:t��fx�����&�O/���]8P�嫣�`�������~MD
 ����B�oU*�a�X�%z`��y�����V����ĵ�0Zv�| �V�\@�4<�.{pvL�����>�:���7o�bq���u���6�a䍑j?����݉sC��<��2��Ac�%`u�M� ���J�G��F�L�H5ST�G�PM�o��neTΣ��^���;U社��t�Y>:�-�q���n�U�q;%+��a�=w��@F��H���s?	��#'P� ��쯯=����w�Q�x$�r�^�͞�sc�]����5V2im��Vm�".|`{���ݜ܏u]Yo�p8w�V�c����H_���ZH7tV�$�,�ZE_�݀�7�oVB�Ѭ������6��ݦ���B�\�V�cjP1�	3�w�52��ZW�F��z�Ek�g�{�Z�W��PW���֏N�O��� �@h��o?�V�7����p���ʛ_���6���o�����Cf��!≿Q`W~�c���]��ۇ�	��#���,,Lx�/VG��S���ޣG�N�@>q����".|`����r�a�@l@��_b���Ǐ"�.���ֈه�P��.*���t��Z@�"��j�S��e��Ž�p�m��ڸ����ԞW��v�������o��3g5�Z+�ak�{:h;���i��9]�ܥ����OM�����CfH��o8?>$��Gچ��͗.�k:���o�V�x�0M��l�~�t��O��������P��X8��(u��+,���S*�m���B h�W<Z	�5���F�6�tQ������hf:j��uS{�yt�9a��:�C��y��1�8�jk��H�V,��&�[{���J ba��:�^��m����M���6S�ޓ�ծ�ʨض��:{Ѯ���k�]Π�v�r��_m������}y���E�O�TJ���R��y�AO��[�;�)5���X�*a�"dW%�n(���ͯ��B�vĠ
[Zv��v�X����"2h�B���$	P,����cd���Ls�L�W~��;���".0�tH5�����Z)�A�^G����2�x�? Kp�;*0�3���!�;�}���rh�|���0,�3�A���c�U`�Y�x��>���b�OPH��'�&�������uΞ���͚.=�>�k�+���`p�]��^nm\,�A��Y7i�vW�P0o]6��I�~��Z�Ｘ�^�#�!�\� ��=��M���S��B�~��VL�Ļ^Q�/��a7�U���3ܳ�����mw�>���nN�r��p3����p^D\�U�W�E�k׋kݔ���3�[ݼnL��S~J�l���� /�p�Z8� �O�oTY��|�)�ؗ�P1t��  �%��Z�pu��?�j�[��f:\�=����Zڹ�7�g�QQ{vн޹Ȏ�Ajy��v�Wy9��ɧg4�g'�$_lC��@��o�<�C��!����}un����d�QL_���9�ʌ��'Ύ��J#�r��CݛV���!e�7���Sw��]�Y��~�^m��7@��x_Y_ڙ0e�����8�5���հA���M[33A%��z-���B����L8R=���<˱�՗�7_lＨ������V���xy�j���MG�찹��&7�Y�X�D桡�/;y�1C;��6i�ZE��<Rs��vQ%�ŏ��8�n>�%iS�~!j�q�bOl�d�r��(��6<8�\��{��I��Y����kƨf�L�|�,#w� � �:�m��f��`�3��A��Pn��kflz�e�i4
�@h۟����Fy:�OLN���c7�r�\�>땚��du����>��6U�i"ߟ�RY����<���_e�X�A��gyߢ���u������ �pM=�١�'�	�w�2��="����G�e�éO>�}�dٔ��xu�oU��&B1,�T�+�Z�ʹl_7�q�g��E�b�t�ڌxJ��-�h��o�&�n�Z�#�b�ǅ��%g�d_]�.oW�]�Z���3�V"�e�/7��_���i/�����/ڼ�o �-��'�3�so�y�MQ !L����޽�M�$�OÜ@�).01�I̭�"j�.�\݈OB~�D<7�����:����9wLopRD2�ؠj����ab�|E�E���Kw��4ǁ0��˪�g��m�Y��4�{K{�k��T�C���n������e���KH0H�R�Z^9l{�GQ� 6���P)��%�D�����G��>f.@>�k���l�js�	�'"<PO<��!�e.����K$���	z-.0�6H�휛2D�J�q����ܽ��&*��I`��[��3S���D��-x�L����+�K{���+���������zt����n��l/��+G{��*'����>��©_�Vv^��=__�ǧQiQ> ݴN��I��=�ׅ@i��������.� @�5�P��
��d�Q������^.6t��wx�u9,7x� 2s���K�,�r��cݗj��n�������Sv����-Uy���1���H����sjm�[����kQ�ED���h��M�n&�i!���7���݀�������� �E����7Enl#��;�M� ��9�nz����_,�aX��B!t-�a���;6�|�6�v���m����(���pa���`�dE�֨��GL֍<��� �wo�'Yih�Mu;�����T��ۖ���5-}�c#|�"Ce[�@����q��E��I����6�r���ܷB�ߴ����*>^`�o����U�.�+�o޴�i�S{�$�[�G�FMへz�J����YC2��B��yv��(�ݣ���~xu��x'��ofe�a�Bz���F+���������Lz'����7x[��3ՙ���;:ӏyc8X�*���t����x6�H�Q&��#�2�N<�Ҹy�{L0�$(Do�H�I�`0��O����
��t���x���r ,�#�ˌ��fs�iOM׷l�3���V���R��r�P�EK�:������gm�~�.k�/�Ef��[G�sY=7K��u~x%MW��g��^"�<��A��Z*� ��-���@�#Y� �8Ib����P�Iu����ؠ�ЀM�JTs��+�r��i�(����L��d?w<��D�~�'�`¤�%��\b����Y�wi�Sm���]CL��}F�3�.cO��l�N-z�z�j��D�F�sM�vuK�4����7��`k�cwq��n.���^�k��G�;�~����s)obYO��b��9�|
���=��__C�BX��\@����m�A��Z���U�x�i�Z\-��G��p>cǺ�d�Й?�Q�3�ڂ��u�؂��';7�٪�fq����I L�Ի�3|��~�!������?�n��k��w�v����x{R�9��֫K#MUn]<��$󟬵./z�`���!0�3�[Ƕa�t|�fu�B��oh��q���+���:�0}4��mKD��E�;!f�-��-��V0�R�~$;%0x14|M^e�Zab��U �Q/[��,�1�z�����c�}˵�FN�w�p�*�Ϯv����Yq&�	�����A��P�I6��	[!̡ �΃O�"J-1oy/n�g��D[����|�EP.ص�1��L��OV���XqŃO���9)�2(5��^�E��r.&v�&<���YU8h�s4���&/�FPm�c;Z��1�n�i��k�0D1j8����w��ce��m�_4������l�;�A�T8:|Oֵ��O�e���� ��II�$�޸E��zC8�JB�/c�>O�"�6�-^Y�������v�Sk"�Y�Um�V���r���T�ez��D'�%:Aa\3�H��.v>��6o5��b�DZ�&}� =�Z8:�]�    D?@��x���4޴�9/j�f8��_�Se�g�gTԃ���������t7`��Vm��v�
�|z%`[&��OE��`�	j+�6��o�ty��	jr��w�k�k.�7w�8=����D����H�G���j|ǵ�}t �� ��/���[��^��}��15�R����Pu���-�}�i��b7,��h��R3�Ȼe�G����ZfP=Y�٧�+��J��}ܨ�hj��m"z�N�8I�M� 4��>Q��1����L:ٽ�<&���F�`�y�	����� ���&|g�LS���K��>pt:�<3g��C6��	��t�	q�M����Ў�N)G ��܂n��^/�܌�Pw��P{r�%5�<����-.z�NtztU>]�]�vך�j��T�Dn���I��\��#�+�������������`��1�C���,��o��!6t?���˲<,�������	��^<���DJ�LJ˟���V�v�t͵��ٙ�@��H�ubM�p�3���s�:~5�G<Y㚙�pZo8�|F�:zn`�픈q<#HuF������5�mi��S͒_(���;��UO�mմy4�t���,_Սƪ�tyy�\-�,�N�� ���=^+*(S�3Eq]�K%e�P�fT���#�ۤU�2TНkЉo�x'سH�_t��n��?��Ġ�T ���~E_>wmpmk����zX�u�z��y�<��;\�픔���w�d�*@�����߼��@~I�h��=7m�q�)� �y��y�飦��)j1L�ʚ/�Tw��E�ܨo^�<}Y9�o�)_�x�_Ww�4!rv4iu(*/*F%���Br&R�T�|�{�!y�u{���D-�>mk���7Æ�.���>cѕ��	�[�`�us;�~�EKUԒ:4N8_mw  �_-���g/2�rRf��������I��6�Y�1�A�F�1�c������-�^C�'p�j�o�&v]~~�w#�a|bU�NW�-(��������s��<!G,��#['�Z�rQj$�� ���הJ��"��b#�6��>�~-qW�B��Zӡ��P� �$�lHj�$0^U�lW� "�({%4�������L��Cl��ݴX�	�L��������K�&,���ۓzd�Ӕq�*�OЊ��1���dku�ѧQ���z�������Y�FAom���S?�����y"�^&,D,rǝ�_����R���x�3�~ܜ�>ܡ�K�>��x�R�iJ�#�l�9U�\�?7�&�ʻ4�{F��4&�F�[�2s��21S�7���r��	9.2:\�`w�	����ϕ��'5*Zǐ�	�HR;r;��������l1��G�F�0b�v�����y�-��ZV�u����oNKZyu�;A[��xډmɫ�����GKZ�K&��Hu����Y�(�؁:���15>��GD�/�.�D����=�i�\le���um��t؊��ԏ�l������O�B�<x;/xS�)�^pL�4���	w�EX���`s�&\CBP�םl���N�s�V0�G�4S����xm�b��^Q[<\l,���˔�A���W�|ܑ�*���J����`�y�?�.=9`��!���-!P
��~����KEL��<��U�xk��ӛ���qTk�6Fi
mE\`C@5O�����)S8ut�`�����	����&�����n�#j�Q�Q�� 
:*��x��:�����̝٬��W//���j�����_n��v wRj��຋��[����,�RČ�^k��T���ǯ�-
[m�M3��v�u��- K�s�w{v3�=YkL�*C�/.0�!�g�y�0aw1 �}�`�S؎��ԩ�����w�&�*/!���?�S�CM��+vC�6�?.�|4��)�g0[7s����y��r�s4���G�k�_��|�LjT�M]�ǽ�x�����ơ��;�����-��(P�B ~4�Bf�	Kf��t၀����E3�^R�o.��f|wI�Ue�G$.|���#rr���F��4�l�(GA�!�����<,�u����Nk���N@,��L#s��h��������6p�v`4��FSuCmwZ��-�?�[�5��|Լf\3u�U]h*��Y�$��C��,���t��WWV_���TgЪ��&���b��m9K��yZlG�#�v�؋���( �5����ڜ��
uh �����ߝ�O��
��XfwtW丠g�Q���IQy,�>n�T�j�f�(4�;��s�Z!i��7�ý����O
�VxQ�Jc���tl�5S�|2�<׵��I�����ʺ�Xi�DFmy1<(�Hu\�+���o>IE��[�ZK��>�+�v�z��g6�y)��(�ޓ��a�)�R3ޑo��B^�8���
i�B�tg#�Bgt�o�"9�}E\���	��YB���ۅҳ|\���,/%'Z��7c@0�����C�;ԙc�nX̎	'忡��[�۴���I�?)��Q���J�% ���檾�Z��9��9+��欄��Ѣk��W�Ϯ���r�Ϋ5�0���A^���D�B"�Pn�NM;(^%�����Ư+�#��ׯ������{-D��B�R�D����CS-��ؘ��@�}/�i֤��%�u�kyv����,_�pS�X�?)��7��S�F���FD���?m����4	UP��^bGx0ԍ�m-P�D%E����Z6�.cO�چ݆<�p��=�wml@(�R>g
l�YO��zx}�[����.�����v/�#*b2�c/��&r�V<6(T,��\�w���y��1Kǳ��b#�I��B�J�V��߂f M��B�����Ѓ�� ���j��5i������\VXc��FX�".0�%������z����M�Gp3����c5�����"ч�y��\��1��'<[;���[P�Ξo��R��}�;��u�Dh5T6.<7��u�Ɇ���ͦQ�2ܿ�l�ݨSb�[��Z�=��U��U۶�X���>�����EM����n�����t�B��ԫ$��5yVUj�&��ڒ�&Ǟ����-7-�P����rÆ�����;y�>?K�M>-3s��9��B�%� %S��Х��L�	���Upt[ܺ�OM�(D���ȌL
�$�H`�"�9rmD��,;k�9�X���0_ҥ���V^w%����./b�\���~��;Z�Z�zg+WN�?��R��/C��q�b0$vg�7筝�㔬�c���׸���{@���?�b0O�
NJ~[؅qB�K� ?�ֲ,0���?�WV/sބ�����/0�"p���v�0qPR�q-�ȯGxWX`��?������4B��4E�#�s��z/!Lj��ܫf�����w��5�|]�*��j��O7,�P}����d�"��>���/F����3�l+R7�J2��Y��E�%��d@ݘ
vTꇗ"���aC�&v����]�%� f#���0BL�IS@*��.�]�����z?�*��Qm���L�w����Kl#�~����0���a�w\�4���Z��(評������j3�2ei�z����,v���g�*;�|�1mq�1�2+\Q�0�w7N�����n��/
����w��`�c$��ɋ����7� {D�p;n �ye�ʥ��"�.��01��7���o��(��k�/n*)�b��(�z#y����9)�c�1B_�Z��#��I��@��I�Y�}��(���1E���-],-#������j6�z�>������꺇���f�2��]j��Zw����ٽ��6�wR��@hc�ۭ���߀A�jW�)A�O��.A�r��qK�M����B�/rHnYjP�wtb��9Yq���M	5��ׁe��0�t���.���� =S�y���4���R��Nf߄��U�J�j`\lMbU���s��İ-Xs3���������b�P!~�lA/m��ܱWϵN�u����rxt�q��u=�    �;�&�(��R�M8K@BBx\ݠF���n��=����/Z�}�ٽx����������N������R��h.��|�+i�����(w���L3	��9O�*��R�{��Qǲ���	��ɭ^���P��4{$f��Y���I�4�4*�g���o��V��@�B-��ۚ��:Fր��sP|��Z��\G�E�����zz"TO���*��s$����&/�nS[հ
��G�b����z�F�,��u  ��t�1Σ�%���!w��!ײ��SR�7�{������cI�o�vE�,l���w���)�V�dpub�uL�X��.�$^�"6�%�խ��;>��r�s|�6㏎�2?ҍ�g�I��K��������Y;p�o7�:&K[-���������!��z����q,�l�%3*,
R���R�b~c�%�ؼk3���UI�:��쀩�L�F�[�c�g(Z����zj��`�]\Lu(���#.b#����%�� ;�W� �4`w�=��P�nԩ���a�����|w2��\�՗�����j�Ůc�/N�
)QQ�t��6�7�_�j��f̛ǀ�g$�X�BK��v��!���~W�W=h��H�ҏ��Q��?Â2(%��� |�S����eLj�i$M5�1�$lP�7D���@����]S��m!�9p�×n��4��G��k��g;�k��lf��w�;L��/m�1\ö<��A�{E�9�~`:�긮�ھǽ@�ӽ�D���O{K���b�ew��TT�U+���&9���~5i/J[���������R �]t5� ���$HL�|�I��<# �ca��È=���7�HP�Ц|o�,�) H�ys�H4q��)a|GJ��.�+ꄂn�/�N
���+�gސ�d�w��b�^�ʲ�R�G��/a��g[D��g;(�6�t�i����S^�w�\p4����j0�Um�C�� r˨��V!:����Z�[__������ts�b��4��_br��g"(���a�Gp@����)�q��)ǐ�h�1��YDgWj�<��hごL���!�۹���T���n��5o����t��0����'���c�9i��T�	OcS�;t���G[=B�>ḟga^X&ž��� ��llB��Õ�7�ѱTӡ����8k�K��n<o��:�����QҎd��� �YfM�6(N1Ԁ�.It@�д'ݼh�w�ų��R�p<!?.h���<�AH�
g@F~����p��=t>�r��/ �[��D���� �lK��oM׳�������6��lCW��}]�z���Q�޹^��[{{ū���I�X����'
Q"7�����t׏&��<�u��n �"�."�h瓸�ܿ������n�Р�;���q�1��U� #���oJy��W�Է3R~d芸��k�P��X�@�]�U,ܐg��8�O�&��"Ȕ����g!�uL6Rۆq�Q�����e"h
Z\�26(���o]�j>	�AK�5͆
�Ka��̸���ft�vRj����Y�h�Փ4޲Z"Z�fEz�3@|"���=�M�@��l
P�G%ב`���	%��S��~�(g���z��#��	�kq��鄽���a��,uR�$���S��!5`n� b��0�PbQ)�@�֫�>&mc��L����a�RD�RTeg�xW�)CW+�r���V��s5U��m�T-τ�ӉK�m��z�t����_>,�������R
$��?f� ��@���,ׂ&�S/�ң.��{b��i�_�	W�z]l��T,BҊ��%-w��]L�Т<��a�HuU�?m��
�[���=�YߛTK֗��ּ5��4q�i*��UO
J�`!F��_�f;K� %��D �dԐ��5q�OB+K�Nhb�3����2�ϓy�g�������#@�nfS��j爙��
�M��k�:j��a��aنjx�p�l7s��ں�lx�A�|����[�mY�i-�䁺0l$��W�{J,,pZ?J/��ꆚHS}Ne3�ɂ��,@x����F?AD>��/?n=��=��޿P�V�5o;��;�����z��zN"Ѭ�-V��g�L���m����%��F'��1���)1�+�A9OF:8�b"δр6�l ��b�<M��Y>y�ey�j9�'��v�z;gw}�-??r��h�V��ݰ!�$�0���-��@:M�Zʷ�˶��I8��jy�"�6b�o]g��2UX��؆x6��E��1��!*_�ҹ܃���	����i�����n`!���F��U��݂���7�9�HF	|�@�Μ.2�G)5;#�����&(ɚ�<Gw}K|�̬��݅��3k���F�j��t�4\��3A *~�ǲG�h��'-�4`L��)�|� ~��f�& YX���8L�����$���`��\��{VR��6��@��L�t����j萘�Pf��xt�2[�^4j�Oāæ�t_�-t�d
j�h��%�_�-v]��ݭ�pH�'�FP)1��Ё�+�B��U�S�Z�H����}��v����\���+��`t���Am��Ucm�i펡�����ɒF`C�����U�H9*���(�R.��:��r���l�#���^�wx��/������hꜝ{��Q�t�3��	3�[���t��?��}]S�ض��&�l�xC�}S_���-�a��F	l�̦~��m�1��Q�4��z�+G��no����F�����b{ݨ?;�������)������hd���}Zc�L�~A/>'�O)�$�`��HˑXF<@�z�"���Q`���$�Pu�۪�th �`��rf�3?��_�K�@�A
cCݗ�D�"N���DH%Y�I�O��Hx�O�I#X�H=蜶�j��#(�'t٣�Ä_��w}��1�������߽�:��-k�����ʋj�z\�O�)��/�fEz�q&v�L�͟ �R�G��М
�1ޏ�eq}$��&`.b�E\E���Za�����^$5}X����;���=�t��Y�~�	�ayX�J�[���9�-;UB��/"򀯜=�븮�n[Y��
Ǜ�Au��a���lAߎ��B
 	�"� ���R���Y)%<! v��x$����/J���	N�"��ȑ��_��ꓰ*� 4X��5m�����0�V�}�!�P������A�NY=�y˘7�Q���z[���&�\�AM�[�b�w�-C%{p]ou���Z9�ȸ���Ef}� ���*_��L����.�9�����<Š��Z#�.��zѬU�Q�Щ+%����j���#�$��<��P�mlU��ek�`�XjnU���E�c߲�ܰ�3���v�*����7�8C�uJ��О���my�R�Ӓ.�I�b.|h��i2 >���RP�pS!w��DS��^6���������2���T	1x�-0�j	fZ�Xg���gk�8ŘӨ��<G�=M5]_�+k��?}�7�z5:)w�����ՠ���W����4��ˡ�8�_����š�J���ڛŽ� *�{���IG����Xd.��8C�ECT�m��8�-�`{�5y&1xYynb��H+=<L�]C&eXe�\�*O�EBird��o!�Y��0�O1�Tj��X�o��f�=s���̃��A��t�x���>ѱ�H����$> ��֯���/� �
bnd�T#��	���}�_����V��b`7�F؏Q4��InB�3ʎ5�{�Ӟ���
g���(���L�9�kB����8n�:T�L�`��6o>n15����Az�p< ��ëa������؃�˵=���j�oi�<��YS��[�kbm�u����\=/�V��w֨������uŗ-���E$V�S��7���'��8�M�&Tb^�.LIF��`�J�%I8�[R\�߈�3���Wl�K-����S�髏 ��T� ��'M� ^E�6 ��8�˽W3{ɖԜ�p�]S������{+.��x��
wx?P��P���    �L�8R��5��:�0�r�U����I=�̚�v�i:��o&��A�����aB���_�������Yg�^\�>i-��3~�<�F� �r���0�e��pZT� +���Tc|[j��\����n��_����0�PB�v]|�����j��v��1�����C��_�b��/$4��饉$0���I�m�2R�`;#cJ���OP��+�Ϩeo=�4����8>8n�k������Ҡ_������]-�z�u�&���o��r�M�^D!�Ȑ]�v�P
��D�� �þ ����iV)P�@¿�F3�gz���u\���
H@�G1g��C��$P��3���x�"��n措�+����t��5n�c��挴������V�^T��*�z�;ᑺ�F�I`պ�֡�	�l��h����k�W02;��&�~��L�7����~Ө$��J�k���}]|����Hua�r��y����(m�-s_�N���%\j�ke���v[�{[՞���Z� ���������[�����1���{a2�ܓ�{!!�/G>+�(�ר L�P>��ry�ߑ��"&�G �".0�&��w���RCQG�g��+���A�7w�+�9_@E�V����f�C"@w�tR;1�'e��z�i��@V�������a��g�u{d��y��+eQՊv��\����ū���wԶ��S���Sz�R�.$���#v�ϔ0>"��.����B� �/P�pF�GU�/ �0_z��x���P&�#��G>��@�� 
r�V�	�Þ���:m���L�����ݜ븹�Ҡ�U֞��okI\�G����ٟE��$s�S+
3u %q^�l`3Q�k�NA�eK˦�ӏ<F�~�of�٩�5v٠�;÷��Q�T�1|�#Ws�����~��z~��/�W΁y����AG��9����['{��]���O�H�����n�c�)T9FCn^�_���札�:<�Х��i�L�?&�<�F��S����튝y˚׆�ܶ".��X���ZZ��?�`z������<�	����J���*�0�Hq"Q�ǯ�-�=�ӜZ�Y��n9TKz��C��Q�/��o��e��j��ML[3��}�'M�����6��u��w޴K�ah�X��_b��Qp$���$\{^��!�wSTjB=���5��ؼ�+3��{��X@�_�24�mj��p.�.�m��(�xc�����XF��T�#R�.�s���޻���]i���_Qh�'�J��E����%Y�fI��X,�e��(�H]��	� �F�`�&N�>��F��� �n�z��?9{��wqE�˴��<� �1Ey�e���<�yQ����)m�=�s���,7����|�֌j �R��ć2>�Bv\��#�u�'���wwC
���W�;��oS�<KS5���j����!��m߭��LΛ�ΚQ߉w�w��vw��~.�Ӭ���|P��i_V1-�gN��I�VPp� u��G߁\p1i��$i��)��4��&Wz ��%�ӄ|)梑�`
T ?��u������/dY�[ ��u�
��
	W�{��42��ʓmR��qԗ���#N�#�t�.z�z�����؁�3�o1_y�wd�<�����E��j=���u��,�5LS5#=�|G�m�n64մ]K5,�̆��p�4<�с��m�{��O�۫O����t`�o�����LՑMI̔d���B���+j�В LQJ"o��wnl�|��/c�sAS��}��\es4t{A� Sο`�H��'y8z%����T{|T�/�|��HݾEo�5h:m�)�ɼ!�?y�T��H1��ی��j`�e膡;��j�Y���m�~h�1���o�v|����vf������Ҋ��8��/76KP,�u�9�楲�`���R$1%B�mQd���6l��4�l��C*r�2O��G��1��̣	q�/D!껦[E\	��P�	�Y���Pw��e�e��m�:0^�3^���B�-��,���^��	����]
2��/n 樓q�*�L	����s���n��	�J���k�-5PrR�2���wt���-���.]v,n�,c^����.�l������l�p���晿���t6���z�����h^��� 㑶Y���L����O�T�(K1�Ai��� }祀�3����@�����`�L��QFcn�n������/�:��h�Od�S�̨=2j��~�-e����{3)m��V̩d���9)؟X,�)�gPۣ�K�3p2"}���H�~F��������Gh�����{_aF^ʢ8m�,��rn�����e���l�U��G׋��:x�d�J;rT��U�T�ǧ���z8G,�Z�ϋ�w?�88�	�][��o�#��>Dn&i?�um�P���\�a�Bpuе!��5-�l����߽�O����[��ܞ"�`V���M(/t��G�Ί��a��/��BH%C�Դ�}�v!�!�O��ԼN�������"�-�զ�Wk՛u���hgu9�wHٶ��⫞M�U��Uέ���{j�ۏ/ہi;�{O��o��{��V�8K�'��q�b�e|���:��6aX�C^�OJ��Q��E��1bxJ�Xx/i�a��A�������Z���Y`��-��_�ȱ5�:��F�:��4�4�l-?�g��|���_+x&��7���3w[��@T�DJj=Z4�iW[�Bݻ�k�ժ3;�ѱ!à$@@�ƂOv�u!�g�jVg��xu<?_|yfh�i7{��X�o��KX�́�	�de�<,��9�m��V���	�c�+�S��)���T�ꌐ��pq�!���e�k�s��ʗ-�����)�f�:Y�U;�at�����}}.sP?x��"��Da��4��t�� :�Aw!���������p Sw���3:����٣	��r}6�j�� �-�j�di��Ɇ���z���?�\���J����;2���+�&�}�&���]r�g�P?��!p���1Dk|�#!�'AJ�������L�
�V��M��J�-�\0܉g#��Y�Afc_��/p��s���/��j��Vh#?�T�7��L����e���q�?�;A�#������U,n��uf��v�0k]5�u�8��}��}C|y�j�z�2n��,�>;H63��?-i�~�+�IDl�9y�{r f�q����u�8�Z��S�>����%�t Y������2��N�g��w��G�LE�%��F���7���
4c<�'���.[�6��)�f�&Y��ׄ��{%}�F�`�ϩ����:�*�}��"v�mEC��"N� ^>��A���h��y�m�Ɓ��Y��;[�/^5���Uj���rI�RbkN`���)��9�����M��T���Rp�MOy�d�,+�rC.+�W�y�5Fd���gb	xUb�E���y�w�({q�Qn�R׆m�!�����:���J;NDJ���rί�:���mtOh��J2�G�u���dT��S!��j0��G��̎vV�c�z�皪�qYe�ٯ��d^���^�{����Vo�q��$O�"O��MG+�y�)��4#MLTP�Ye9�6R�)�r���~+NH����f0LS1��?g���:�8:���0���ĵ�/�8lG��ڃ��;_ò1N��e�X���6#(i�عe0"u�	7<��v���vWrix�X� \`��Z�6��J5���#�jf��
ws��M��M��M��(>�U���VV�����/�w�����쫮��-����56q�$bu�,RG,�sېE)z�zTևY�˭�1s�%�y����Fx�ɂ֋��'(�M[D-<Ѥ�4_���^E�	��w{'�_�������m�(MA��JJ��i {إ�_��&�D�R�7��G�n��~�.Ž#۲U�p4��Ѫ�[u��xo_�y����������(᭒�F�Ñ��k������ǭ9A�@;00�Id��YI����3�cT6�-����m�2@�D�?����%%-|�Z���    /�`��8�V�i��Sz��|AX_�1�J��Ii��y�6=Ӵc���j: ��@���Q��G0��b�.6����{����&�3��%�D*P9�e�'����������ճk�i__y��j��qR���l��$�qG=�� ���l��A��
I}@|���A�C���X�B�C0� kK��v��*OE�2 �A����p�%��.̆����~��Hb�[�+�dAu�Ţg	;�$Ht3J���������c�j�+�ڄ�1��ϑ��0l��0�]��bl��ik��Nm�D�>� ��!Hb>��4��g�Zm'���v��2�{�Q����ۚjz�{m_ӫJ�\f���u�=�z�������t�t�"���Q����iO���PPI|�b��hc:"�P����Q�!o�0\��}�"yv��.��,hD�<#�sʒ��'�n�i=ȴ.`�0k_�Գ~���o��wh �]�p��j�t��kB�!�oW��l(���'��m(�~�}�I��J�W�~1����U�<}P�bO�<D@� �.�����!H �y�^I���V��W�q���W�������.s����A%�R��_�'W{�gG��n�>�,�FO�AB��
b�_�N�4�s�$9��)�t�e� ��q�q�B�[�
}�Px�tocBi�q���¹�a�g�:$��704d�(��|[�Ri�j�L_�ʏW����2~R�3���{�7�W�yy�ӱwh�s�U�?r�u��T�Jn�1�%\�B����_aq�j[I�A����0r�* �^��(��n�ʹ�8������e���Y��O������z�y;��n�)�Z���+c�H�0�l_�t��x�
b.� ��X���ӒWvnML�Z�P�s5p�had�uJ����z��]��J+V�3�\�H�*�0S��꿣2����St���^}�YuGX<��V���	9�C�;8��0����;x��n�,�w<O|���x���������A���l�;�x����u|�#_����\U}W�|N��C)*�n^	�ȥ���!?X�/"�R�z;���ox��+��o�7='���|�"/11@�j�p|�
��������k����җ��\�ku�^��^	�eڵeR���b�)66�Y:��@U�i�xH�7b5�D�å]ٿV;HL?T1NE�wqv[]L�.}��m�34O|�*�������U��նWZ{֮z�_�����,��)J(��C/��%�L�Q���d�,�f9��Ə�ggA��E�\��7�|�C��;[x��@�p+�u�34�Nm�vp?:$^l� ��)���~��
��� �J�d�-�6�j)�wnF�.f$[ـJ?�nY����i�πq��>u�du���.76������\��'�g��1�!��@J5�i\�]$�Úˈ��W �F�:�Ӹ�
�D�|"q
G5!:�uh��٘9����1������G�(w��%�Ӽ��T��(��<B@�./�I U[���X��r�<-����
Ke�AF�2T^U5J�A��Z�5�>�z%v��g<��صqX���.�CWMC3�gۯ�Ͻ��e��w~m�XZ_~�l��<��)V�9 �i���#�![�A+�Qa�=vG��U�j�\1�GAʞ��{�ȂyuTf�ˬ����E��P�.	�C��Çy�w�(e�r,sAopq��,�3�^�0F��Qm��"�@`r���0�͂��@�pX�/\�M��GiPM�p�j���G~ϰ�m�1,_5u�)>W��35��g�˵KO�XmM߾.Ep�����|��+Ϸ]�!yP��bex�\�#��۳5�����J�4�H*P
�3����tG���z�2����%����>⇻s����ûm��f�F2��!H%KmC�3 �mR�l{�JTz]ج~N +�1�����@�e�&2�m�v
0��J+΁������"W����h�kA#����1�~��Tݶ,��w�6y/���X�/�孕 �v�'�v��Y�	Cײ����< Orȝ11!$j���M�����?d����!	o �. ;�~}*�}��kdHF�}%Q<� ��P�����5�Ax��~��p��Z�MkA�nK�:����&�,��|����DL9�/���F��Dbjop���N;ݷ/�����X��Dj��ր�
]A�3��A4"��իU�c����c��q<õT׷m���b��֟�7��Q���.�l��krt�sd��=�!O��S�_FRry�h�։VU�Ҝ�jt\�#΋\�4��I�Ɲ&x������/<ن��f�m�_0"ؐ�ז��x�]'��b�җq)9��0;�:�x�OK$e�%�5	���u8G���c.'�3d� ר���k̘�9���صD�h���t���g׭jf֑q,��>�9�������[M>��CCMҏ�"w:�Z��^�į<����1E(����B���rt( ,�ǐ˅��o�?-_<�"�1�a��`o����>�h˅@�Ymj��X�.9gi\��8�3a���>
mb+kR4��Mj��wkFc�����24�wU��y!��5�2+W�l}�����כ�ᳵ��Z�B[

��bM���*%�g���S83������o�)Q�/�v� �����B��Lf��*�بcz(����4��lT��u�w�esaޠ3IA|�#�%8�e�Vd$r.hE� ߥ������9�'6��{b�wsF[:d��ax�Hnj�먖�y*л�9Ze�J�ļ�pw/�����8�WWl�UB˂��V���P����a�bi����,@�A��w��D���(Wxtr�$Q��(�ۚB!֬M��@����ኒma���B!b��Ĳj��r	冾���"�%�j�6j��'�4�U���7��쏁:��q��Hj��&�S�R6�V1�q7���n��e)w�|��@L��6�
�?�LW��S�d{�ċ�[֓�#�%�tfJ��uj@�O����#�
�)q�rT��o�@���z�S,D�v�ߙ���V9-Fg�0��Q�׉c�� =��|�c}��5
YțHd+�f�F��ڡ@�Cv�����|��U<p��Um��r��.�q��B��}��E݊$�}���܂�FW)�l������ن��U3����~��l�z�|k�Փ��~��ΕL9)��ԙWT��CX�z�gEK�c�:��A2�<�r�S}�L=_�o[@ƚ��Ԫ�pL��b��6_{(�y_�U6C��u���	�b9����~�eNۀ�"��+��8�uTϙ�#t�� 몦��g�����A,Kh���q��8JIr��N�ٗjC�'>;vE��ܲV��';Ã^��<���Od���$��u2���߱�����8R��<KBS\L���r�B��Y̬OH��O\$�]�튔�^��s\��V�̠�b��\C#���OEZE����*�����$�1�it�� 7�mAT
��!.ǡ�~ЅF/��5��Ѫ!X�c��Mk9ιey�빪iY���U-�����������^�����W%�ʴy8Ά,,���z��#�~[@�+C��^V��@@�`�@>j��e�$
`H|t���MA^M1���W�{�w�`e�3l�
X��G�OH�T�:tx�4���4�A)��Ϛbo&o������v(��	�PA�/#�)�Z�,�Q1�"��{>�j�a���D�s-��-.��̯�ٶ���������œ��_/^-�q���������J�~��k ������b��g1�JM���C�o��WS��C��b�kЭ��2��uk�^����U�	�<�}f!#�1� _��� ��@;��.#��S�*aރ?����V���e�c*�rbQ5t��L�an^�٭�s��N6ַ�'+��鹻�ۃ��b9��My�YCye��l�L��o���A�7��;�����ŝ��h88�&7��Nf���>��Q��,�i���>����,]��Sm�=�%@�% ]90d��8R#�    ����Η�	�k}�:Č��	BJC�*��VfV���F�
ߵU�mN��S95�N_x�i�Xc�r�����N�9�:��\�1�R�0���:�q��Q������@/&���Y�
U��/	��|4q�)���	�������7����,���V\���O
�AFtm�7��\b���D���}}dw�iɧYOA+�^W b�%�0|�ր��[&?���Nԋ�^`&���16�K�[�[ w��a�ϾkW����k=�
��?���͍d�*��#(�C�@��C��b��!	��V�jPH�T�P%���)��*�}�#w�\Ɔ�s���fsӧ١.١K�F[�}���Cm��Ulo��Zi[�P�e^
|R�$��n4��X8���d��]x���RA���e�c����^�B��\e�H����FM�g���h��
���5����}�z��i��
z�^�}~�������`7��
�@9b�(J�A�l��~�y��7)'l�:�w��kd�h���|���Vj����
�7�.�han<y^�`��#�|�#x�{]�r�ݙVuw
[&�����WK�p7B�;�ň�T�\0?��i[��"J���و.AP��C���2���q�ك=u1�U��ŝ�gA�_��;;l��O��ɱ*����~
���F�9�˥(G��9E�y8��J0݀��Q�SWY�g)g
$�<�7p�5<�4��q͂�Ǧ͊bi���(�{s'I����i�$^�J�W���^O{G�^�|'3�[�KIM� �j���ZK�� }{�%���]��D�Q��A�U��,=�d������&�/q%ש���~��hҗ��(bL��-S�M��M�Z?�Csig�H͏��^���;;�S8kq .!�	����oD���C�(��a�Mvъ��HbBt�%L�� ��.u�� \�a<�/��6��QY�h�lC$է�e����/�Z6���5K��y��[d���P*��Z���^���O���xOKhy�PN��b�L0���� ��.S�~#�3��l���f�m�֙�|��Y�4�y����B�H ?��,�*��~��lo��Y��Iv�?>�(�P�4����K$&ȥ�(��9��V�%�oE���;��c-�T�n�|��^�?���E>�3���S��� �U/����<'4e�p������%�ּ��j@��3iB��� �F�4L����w��|�Լ���S{{����7�Wk�
6.�
�i�k�Sh�?Y�h�m����gi�X�p5�4x'�lZU\/O.�כQo���~}�����c���<��i��37j��Yw��Z�R�T`�BA����&�(�������!V3�c,���`A�f�ȿ�t�s���6 �	��Ū��h ��}4r+\6Wd7'�+���+�Hm��u�o 5'2߅Ì��ܙ ��:�qS�F�qq9q��?����@� �� �'H9��W���6��v��h����@t&��gW����nvv6��� u.�^���`_����k�{�=���w��Ql�E��d�3��V�(γ߽���[������z���dW���ʕ��>�I�$���Uel�v���=�b�-�Cй�}�ӟ+4����籩�
��s�CT���`t�Ag28��r�.�F=��A;����FUr�c#�ww�u�g-�$]�W_�\�J��(Z��@]��� �A���Q��"�܀���_T}���͟�F�D�I�y%%c����{~>P��������?O�
����r�6aN+��R��#L��r���jH��r�� #�j�G�.�~x�O=�Fbx��b�%?m!�9���1l�Zg��#�h@ik�誣��r�Y��{t�7�Ke�@�#P�fM�{i>��l�^�:��^\��r�r���$H�dV�Q^?Uց�YԹ�/�n�v �k��<)y�5�ʓ�9��J��������q�c�u�2��W��B�5�v����G�s��rzȔ�C����!�ހ#�-_}�Ϗ-�����xS��?$�+�v={��Cu_m�+��)�M!���S�1d��q�NV���=F�q����G&n���{�%>���^>9�<X�8��v�����S��/�M�����Q�E���[W����؀�:$b��k��pҌ
g�M<��r��f%�v++�5�>i�)~C��p����l��3��1UY�#��X�H~�B}�Ox/V!��@׾=�
����9�lD������#�+����bM��D��$l�Ig�	b��	�Z��!��#KE<l=���i�g�� �>�:g�ۆa�*;�5�ٴ���K�����j�ܪ�ã��y��I�Si�d���6���񁽾��D�6���112��࠭7.M'?ް!j����~��:~� �� �G�8a�{{��e�bQ$;%��'ME|�̊�F�V['I^X���2��S���u:������Ec3˔��:��V�b5����g �l5b|�U7�I�j��;�̌&x�.������,K�U��|����0[{�+�;���:kW�٩����R�:pv�C\��[?8���y��d�.����p�a���9��=G�~�R����U�� ZA���|�����.��2�iq�!ǹ+rVD�9�82-��E�u��b���3$h�rЉϠE;�
��P�OI,z܌�w��.S��fV�D2^�t���?c/;����^y���*�|5�ٷ������,�ի�����F���rm�w��N9r*m���#Zh���"�)�)V~�
���O�^^��n��l:��>������5NB`��V�K��U�p�ӣ���X�M�k*o�s�qUp�����}$ �8��������]\dv�� �I�I�l��A�����M����vk1�_>��X�>݊���|1��-�U�.����U���^���$|"��߄�zV�&�ɂap �'x+T��__M:Fkd���)z>�P�Gxd>��k�������-wr�ǐr<>A���r��W�˄��I� "�~��ף�SN�տ���-9�3'��&��p�{Hi���Y��|�yvu~����{�n+��n۪���lxU=R���u]^v���Y�~Z�_l���;
	Ll\)�i�kF��!��%T.�i��<1����L�l�g!'$�śR�C�%L�0:�_E��4�as�`� l�8������]��2�l�;�5N`(�f���q8��RŴS�6���n �x�P)*�-��\4�I ��0j���OA� �Y6:��"��(��#Tf�a�^1G{���x�y���l
�f�e� C#>�Z��Ζ���q�0��]��cq�[/��/,�9�	���H
���HCo��xl�	�j��eԏ9�W�w��?Y����|X��0%�@�#��|�!��_cuˆl9�6�g(�fȄ�ql���.�=�H��"R��a������!��+(42ՅH��g�B�bg�Q��F�t�6�4�y�պZfy���0`�bC�y�㺎�:��>��j\�?H�ˎ;n��7�V�ֆO���ֿ���p��jE��9j�/s܂n�\1�2� G��=�#���,���ɗb�c�`��n��כl:��m/X��j�"�`�C �����bH� �t��ӡ��+����%����
t8 e��S�i8Pax���>��p��7q'p�H�B��W@G�_�p'�Ѳ@��.dE��[��hªt˨jU/w̭��^^\������*��L�*v����m�l�D}v"���ۓ�$��5�@��/؁̎�>m���- L�lJTlE��i��}1�������}�a��zr(�ˡ$�� �}�FZjW���	q��A�ԣ��>Q`�M#m�e�1��le_���t!@&�p-��Yr!�w5����֌�k�:�s�������P�Gh�ࢲ���\���� �����|���x�����'k����+���4B��O2�,a�������@5�浠��f�R�tZ���Jwk�L�S����)��̖����    �dК�`�8���/�A4��k;�dt_�\t\�vE�u�E2W��x��@�&�;��^$�N�+Q�R�\�a�1g?:ף '�5��T�p��֫�{�6���ݥ8��/�v�҃��6;y���4����c�s�� %�dV#������o,"7��M}�+���_F"x�z����yow��dkq!�3�=T]_0k����I$�(�8��������e�gBv���+@��Sl�,<T/��궤{�j����݄�����c�*Ч���5���Ћ�m�~��m'����E9��ZZ��'�,F�	�(�����������E�ae�����9��"QU�΁�k?R� �	˂Aއ~�w�e�������)*ɻ��,�t���K��D�����$Zi4����x��M����=gF�w��,��{���U��S�j��^�����ݽ�֦Sb���W�&L%'����)w�c>z x5.�kX�s��c�h�EH�=����"A�Mv;��i}�s>_{�w}_+U�Y����F�W��k־��@,����[_~��.��_�Y6��0�;Aژ�;�.�t����u� ���c�}> n!�V�<�q��/��f�Ջ���X�f������]=M�y�]�^�Ωno�m���g�We�^�E�.�)�s����K�m�k�re��seZF��E2іę��Gbԣ+�)�q�l�������b�Mi2NF�d\�*y�U�;nF`O_���;!G�0=�Fj˩pk��n��ǃ2�=x�=����&O�VM}�>�쨲�7 {�˼CMefe�ϖW5�񪵶���}r���q��m���DG���*[���J��ʳN<�zJB?_��� /�$���JLd� �����O!J��'���J�b*V�m��M��ʔM� �jm<i�)���0��\ӯ-Eiމ���,��.��A���x<�=i��uU���ά:�	ǭO[���合i��*�b�e[���s���{�_�����	�b��j����W�l볪i�y��<�O�γ݃~p����A>{�P9�FQcvi�i'���t;���|�������_9����gK�Uj�Y��S�"�`�՝]�V.N�ӊ���v���X���FMg��E���)?91�҈$5g��켢,�{�>���Q�ϳ=�g�ϺQ���>�����}�;\<��~x�l�6�"Tb3!Rc��Rvnr�+�U.�UJ�ձq}�|�{3�-J�B	�U�݋�kݚ�B��to�y-� �������*͛��/�]��0����f���W%7�e,A�{��?�[�Ab3�`V�u,���F5�������l|��b�f�������ώU9�:z�_����ݫ�y���~g���T�~8�4��ײN#J��N�}�.N�ܘ���V�&R� �w�C��:/Α��Jpht��#��h�������Šϙ���|����]�Qٺ��-�Qނ #�[ۺ�S���& �R������J�6(g̦��0��-dV��(�c�g��k�+p�Ǭ��t7���D<�B��c[�i���ⳭW�;͝���6���/��F|z]:������H�
C
��{N��%}�m���$h��2�&��Cz/(ϲ��j�9l��=b�	;�{��������(d۷�پ]ؾ]ӝ0���έ�a�b�ۉ8i 19���O���9�(�x=VC[�@9���� d����Y-�m�)��ϘW5�p�Ǎ~x�k��4f��jؖ/>�^��������:�X��H̗���oʖ[$�Dt��m��<Į�;�x+�M�#���E猡���)wJ�ًw[Y)�3���8���Ni���O_�BO&�re2_{@�z�����И�r�3'���'�`q�eMor�P��ͧ'�����z�rԄ܀B��+���	6�ڋ��:�{w�j-����6�=��uV��3?��~d��Y`7��V�0�T�Eުk�:ϥ����w�*6f�<=�8����������].��A�}yٰm�#!�[q(�Y=f�r�0?��C�s�1�,`,b��RsJB��� ^^n�kD��	����7�,8�B�����^9uc. �ٸ���_0�s��<��tiKY��]�VT�@�-
o�,�̋sJ7f޷!0�Sn�U���l4�f~w��pJ7�ס"NU������X��������9�W�}�)Um�[�ڃ듃n;}w������W�M
^-�Lx��5��\��K`.6vw@��;��9�^��g՚��7]8>��'W*8�,��h
h<ٗ�~su+�,�T����w�w�2e��'�i�"�`��e���G�$Vts��A҇nQ�y�kuHx%���*����f�]E�T���|��Y42�$^5(�{?���Y�G(�]����g�*����z�|�g]��\;k'%6!q=b7�E$�נU�-�;�:����Y�������;�:����X��ks�l'���Q��|^��:�'���Oj�����-i��7� u5�,��%�Kxr��u��	���͛���+|7�_ν#�>���~�`��@�\��!�������a6 7�����Rc_�2L����\b�Ќ���k63"�)O3l���깶��.��f?2��u�W�;����z�r���ҵ�-����Ca�hzv�,s_'j�J,�Stނt�e?���A6����h�F�7f�b`�y���ޤ���a����D)�����8�U�?2u�S�����,���q�5Ȼ*GH��>-way�bm��8 �Ƅ��T��Tc������P��6 ��n>�'��#48@�]2��j dn�?�:�\8r��ٟU����v�_��0xr|'���m��᮲��������9��#^*��5�_9e ���]����������F�����1� ���������)#��}��������Ek�_�K���"����kt�����7��k��#�8�	L�ʮ�Qz���2Hy��<�ES��\T,7t��&���p��/��QV���s����i���n2�]���Yx�6T0�c��C5��l�u���z�����l:����������>�C}K��G��D̕#9"_�{+�R| ���,b�e��Kp$��Ri��������p���Z�#gr�̕�g�NhՀs!t����)���<�X�E�ƍ8P�A���(�|4������^ -]5 �A�4�
�C�-:34��)=�V-�~��`t�����N+I/��i�*�h^�����U�:���lK�ht�Z��ю��R�o<�<�^�V䜅���<lE��9���{�A�*OXP��0c�SZ�	��dd-��+>�M����	�4�"����}@�r/�N�s����ĝ��/��d=6?ɩ�vA��O��t�( !R�W�7�d���Dxd�*n�!�Ede���bS��ΐDhej��q��e�H�����Q�����=SSMϤĂ�3۰+�ɋ���voWq�/�^FO_4ow��9�m,�h!�"yX�M��<4 67Jz�������F���n.ΙOKF�N�q�x~`5�_"1v즀��/�h���n���i�v���L+l9RaK7�J��� ��0�9ҽ��@D�צ����5@�t�@���lզ4�iW�y��f8��q�z�,�7]C��ip|ۭh=_>�=}�o/m�$[��u#�M���n�uj��Y$��:ƅ;�  ���͔+j��j��ϖ���Hp8i#�)	� o�i9j���}�wvG�L>���Z�'�\�fل[*�O;qk.P���3�%D�'�.o'?TI��$��49��toCvn�*����ixL�j�]g3c55�d�j���wM�e"�3�Yw��xA�jqٰ,g��z��՟���C�?`�@:�"��T�m*�Y����<�$�cH
tOK���s�EȐ���>�-� >E��)V��L^��>����*�d@�+�t4y^m+X�ݨ�������Ąz�����sG*��Kt!z��C���6    �u?v	���.��6�4��� |	4_I;D���3 �s��!���2�l�6��*kN�>ͯ���Rv��:x��k�o�<K�ՔS��� /��s# �i0�L�OTY!�2p�95:��v��Is�� 4��!�\��muh�7V�A�%���	V������e��4c��{t�3Zo�ZmK���W�è��V��ܝ8D'b+�6@T7j�1h�������9@:gNƵ(ҁ��&;J�5��ef0j���ai��xnB+��zgke�]��j�ɋ�����ӗ�ig�|�(:hd�^���[��L��@�oĚ��D$��-�#��>$^*Rj%�3��E��wsTV��JJ�Ceچ�P(x+B@�������9���|�#z��5�riN�'��f�$����|�n�4v�I�86cf$G��(%ѿi|~쮡Iڢ`P.�����5�:�^���+���f��<�c���la��f+W�������օv�m?��\�\�O'Шf�DkX�67q�`�&B�� ��n��*Ȝt��:rsJ�z��"c��R� �z�����$p1eM�uR��ã��2;�'��L'�o��ݠ���x�i"�VV��?��*wt����4滸4� ��2�?�ji�9�q:�eC@�+m����x�|V53���̆;%@���U��W�ݕn3�Ύ��ѳ��W��x�Y��a�a��ݧQ"Χ�))¼:Q��C�5襤�J}x&����,a�uМ�o�ɕ�(㎲���k����ҫ��`:�+�*���kP�7kGq#M�#�1�hq�%��4�!�B)ͱ�!ԇ�$�{�hd�ZEB�F��P������φ+*��W��y�v�Hs�����z^_]l�7��R�����[|@񆇀���4�_{ϺQ��}���	~*�{���T�H���{g]�'R�{��:Q��1�AoП����u�Dq�]��O�?Q��2� ���ý�;]���iނa.���M|���
��U;�������2�e���3QrJ�LٍU��u�Y
 ���,T��� !఍�z�X�"oN5	����k����読k��lU>ʂ�������+��q�<�xn����^s��@z�|a��[sr���K��VD�����#��s.G 2N��
�[̵o��S�n��$c�1?�'��%-�������E|�̔��]ێqp�K��܏�Z-"m�y�,�Fx�4PM��QsY9"P�poGuH�(�@/@�X5��K�C�`��k�����Y��z������F�E�~�l��`x�]�Z>У�[E|�R7U������vVL�8ު�!
�P�F��4:���	�dLe�����d�g��/�JL�������a�q�,D���Ȩ��;�D��!��ؔo/<BfG�{�7S�@E3�b��P8
��M����R���H3�NW]S�)��d3�j ��9��v4�j�\�<l$�;��lEGCo�dq �>wx��t�o�7����-d-ble��/��y��?�{	�܂o�@'��&�F�l?�f�k\�u .���J'cC�u���7J���o����+E������뽰;�6��L���/�A��T����������$��g�D^Hj� �y�.+��g�N��Y�̍	$ʷ�A�9��!('B<�sr�͊8��|��d��12N��N��؇.k�g�jk����rt�"n`;y�v��Y���Vh7���#q	`O�r}���@+-��`UbBs¯��w��3�.�{$	�Pz4��(��,��	�ݧ�\��|���}��1{��ٴ%d�A�߫I�&Eg^��C�����Qa�JC���lj����s�}h�����%-��d�0�4�S�O÷�Y�]]g�gqiqQ<L=߱��jY6o�����ǵW��Z7���a��n;'�m�*s'ǿ�l�}|�[��a�>��sʋlp8�3z�Q=�	��X����8�$f>��('R�=�a��W��=/�rf���qJŇ��<�Q���[�{t빚+�.oG˭^�D���Kwį'e	��2��~�Msb�c7l��%A%HR�#�͠�ҵ@{8`S���c�~5��^j�sSw�z�g��Nx~Q��
JH��wh�3Ԫ�Oݼ{t���.����ʦ��Dk�,��6	�\=�E\<�OxX��e�N$��}��\ڼ��Ox�Ŏ�v�#��kQ ���@8�#���8kUXT�	2�$������>�G����T�Q�v�ʿ`� "�@bA�M0�c-��W�K�I�i8����w�#Z3�����ϼ�&�^�g0�:�0
{����R��V�̾��3��YA�f�4���A��[��{�긶K��ؖ�V4����Z�hi�U/�V�\��rD+���Vn��,X���yA���O����!�̜����}x.zl�}
TR�O��s>_�����W^9����)�1��_0���h����3^�YP�垔?sh1�P�l��\��WT�YYܘ�~�g*;@Rh�r��܉y! �T�!1��yNX�H�����p8&1��d �jqig��n���"|v8c���UAt+A���Űs1�z�x\]�]�7�2��P`G�tL?����ٽ)�xo���Q=!�0��$�R� )����Ea������J0jҒ��=���U+�d�G"~1|2D��,��#8"��$��%�oBb	�a�az�):�		�(�:L�=R��� b@LP���c�s��N0�b3�\�M�z��}k�K��_|6����@o�n��.��.nn�[����·�'J�389��˕ഉ))�y{e�kn{�,����[��߀�#0LD���Ҁ]��	�&�lH�
����q-6iMKYRB���X���X�Cy$�-�xP~�b;I4� ��4,�x���[0V��jG 7���8㸳�Z�R,���8塡�Z��z�^|�L��zzn�7N�����������k�*&��!T%��({�UFى��Z:f�\��7�|D�ѕ���f���_p�G�|�-z��V�x�J�V�Z���v�U|��K'�j�Y=�ea�9��e�<E%�V7���S�����<�RH_L�I��%�O�.�v{�a!�\�� 75�4�3��ޮf�wt��C��������cm{+�nb__y�j�+�f&L���;���),e��9<���:8[���of$Ɗ�'�j�@/�XP��e,_��o	�V��OZa�q�w��f<�h���H��خ��!Q«�j����7,z���_�^��l���	�9ϯFh@��t�i�7� Ľ�����j��3حD������;����꘶�z�G��2��V��9��ϬW�;�˭��U��=�Ŀ���6���o������?��N�*���|�'J<|��Wd^Z@`	T	�=�_P�b�Χ��sIJd����E_b��c�~2_{ �x�U2�)�H���d�d�Nm�E}ayv��� �����7���Bi?�� G�˔�{?���1:�E=�`}c#�������j,FV�)T��	`���]]g'{'5WgsؽR}��3<�u}յ�7������Z��_Y�}#��5�x��؝nm��A&mN9do/h�e����A޳�NzW�w�hO�<�Oy3����i�.�[9J]���b|>���E+��d[�!0-2M�v9b�/�jn��'�y�p&Ш���>���Ml����P9��O��c�ū�՚��k��cKC��{�哀 ~6�����������Rr`�E�Γ����&
� c Q�Kgs����e���g�u:??��	������jtfq��g� h���:g���ǔ�Ӕ��Ѹ�=�㫇jm,6bS�9_�X��>V�l�2O0e�3e�L�+��F J���4N��O��T��1>�(��S�zc*�h�a���#��ÇFTgm��!F��،8���JE��\d_^�T�:Y=�+QЉz�z���2	d0���Ʋ�{/��-�����E������K:�	�)#� is��������g��    5١Z9,�?:=������h������`�A��E8H�{z�,}k1���q���t�L�	͑�8(�R��02L�v��Fȋ|��j@�����e��|W,�C�u��ޡ� O��ځ�R ����E�	z���=�������:�嫶g��u5ͪ�ȼ�`9?���>y�6�������r�Z/�ҝ ���0Dy�6�}r��[��ْ�,8!.�\z�N0*76��+�,����[LmpCQi��g�����/��6�?epP��;�"n3����I�x��F���0�����2���CK�]��!nH)�;�7�q�!�=��Z�V����,:nK��0��P�𪊗�ϝ���nb�:�$ϟX�{��#�6�����F��Q+n}�G�S9�H}�V	�����rwx���XݞD�az'߬b���`K����!�)��m�Ȏ�)ѣ��RG#&����N����z7H�~�����Iث
}�i^v�i�[�� ����8J(����V1�|��g��جÉ�@��ezIӵ\�#۩�1�-=I��M��z��8Xm��x�|(ǜ�l=i-��%͍DHXZы�˫�Ă�4��xhh�J��&n�L�)���#ь��c�ɶ4��ƖnL���F���Tyw⾢�4)'*�N_)l�`wǣ������ߞ���kQM�	'�BB%6��@�;a� |�3��C���3�;�d��_t�tl[ͮ�������橾��㑺<���Q�����N£���i;��~S>噑2D#���0'�.�&hlr�8���[4`��8�:�3�fyQ�B)���H��U������1������g��zA'N��}�����poJ�ђ��st��D���F2r�C�_Ey*����{3<�e�X����0�g�@�t�S-M���:^U��������݋���굵��G%�[�)�?�������$�^�+����J~�	�Itk��7W?�P�x@�~׫Y�H����,K_0�$4�nն�^[y9�~�z�LB��?氃-T @O�-)PR��L#A`c��Ř��`�&쾃L�^�5[q��z��i��}�Ң�B��sL�O�i�4�Zd���q�}6�]n/�{�c�-o�x��{��r{jP&�� DHZP5�����'xft8���+��ob!n�Ӕ&{� ��)Di��i�ț��c}^�5X�'}h7|/�V6@s����G��� �pt�s�[��B��N�b��=?�T�NCι�]�h�n�u�60l���<or�6Q�~X�λȊwPQ��.���l>�=#������,'0�3�t���iZC��i2t�,�:���T4���p{�{�n���ŋ�P6m�k�8m�o�J���K��4�r�)	�H���d��d��ׄ�F]�eR�mB�ȫ%�KH0+?�;�����M��Lr�ME|�v � ���4mEq�����h�x�� ��N*�� u,�S��4(@��i�~1��b��k6��1)�a:�=v3^����F?F��\��jY�;��l�Z�g{+��i�Uqxj��_�Z9{q��'K�݃]�D�56CT"���9CQk��.)���3
IO��8���KC �p����9�Y\��b"T�yi�D�!u��dZ`�P��=�{��,]9n�l�,n�(A�t����"PW�6_,�=^)4�|�y�H3���Fuς�4iVr#���F���6�%f���\A������v�9�v��!�K\��|�gU��/_u���i��u��n�ve� ��Q��c1<������$��rX��S�5W5	��b�|ܴ�SGHdc)���-��`J�+�����9�d���x��z���z��2��������_0S$(���փ^��W��3��I5��/�ɾx�,��^7��"�X�M�DEA����D<s�i �Ks�Yތ����:��p#st�r'��,^�z�M�.7��+�����ە��F�|g��'>{��/���Ɣ�#�O��� °oBq���\���)k��k��_}��]0�b�\Ѱ���E�ݯq����C�̷�0�Q��U���[e*���sh��2ǊM�6MО�<��7��[��k���l@�uK�u�)>Z����t�^=9�W^%�ë��N�%#�Wn�mC�_��v��q?;cNoQ ~_��'�n��|)���*��V�voL�`�&t�ǵ�Js-� ���|���}�Z��˹M�j)�f��14�p\RŜ�g� �&�e��p��9������_C!νG�,TD/A�*���ò��<ݪ.x<���lz�c��w�^�vš�J�,�R�
w����k��k���<�g�Y����v�$;?>���{+Q`n'ZPJ������:�|��b� ��&y�,�rr�h\ω�;��0�A��ȫ�E��upk�>�Os�P���m��:�3&�ˈ���oh��k�Rą���<�Q�`�%%K&��
�Ĕ�)�0YF*Jt�ħ�P���L��}��%f���$h"O\/��Pu5�e��j���}���u]s*����]���=�]����ŭ|Wv&���dD�4�
{9Y����3&a��"b�����򮲑�Q/EMՠ#:�-�9���L�k���Z��Dw�k�
���o�e����>���PH��1+(���z�L��֠�?=�Bb����a��u�����c�cY~E�����N*����TMc��Z`s�Y7+s�.���86Z�^��ޯo�'F[�S��$��+���XY�4��(�}��o����$e�mt��<X�2��+�*�l[(*��8X�lFَ��!!�������n�ޖ�t"����xV�T����oX5WI�� �@d�-�>�;J?����=�9\�T@$�?p���Yw���A�6��nE���G��1�̛�:�5�"�Pì�z����G��纚^�J�q⭥�������u�̮�vVd�tJ` � (� ���1A!�N܌�0�#(ע�1׏XU��<����F%�ꦜ�Gr�9QT/��n �?�Bv{�����;_����|QC�Em���GC~��k�EH��{���,��um��|�4$ҳe:taa��9�ł�`8�mĮH|���-CcXܻ�u�t�V��ͽ��d����ً��C?h�4J�S�oQ:h��v�ܠ�������=�:v+���+�+�8��ϑd9�S��x �y_KR:�t}A3�qTS_0����԰�?
^�ōD}��?��Ŗ�ō��M� �1$���95"��LH2`�z������qc��Uf3<�p}nx��We�0�_y�0����k^�Y/uG��9)�*g�KG��&���,�CRij��}��3(�IX���0���M,ȋxBR��UT67؆��/r¢�֌H�|$r�\�M- ����SS_0�������~��,X�c�U�ζ�v�F���������\:8�/s3���*�{]6
9�^5����={�B�\|]��g�r7}�܈�ϝӝ�ӧ/��+g���l\�j�#6Z qJCN��4h�SZ���!�� ���^�Tfƞu<���%�&�v�@n���X�61�9����mx5�@��]�l)6�o�� �a�xz(�Mؿ�[L1��lX-�a@�rH-G @��E[�0�A*�ۊ�9+���u�ٖ��Y؊¶a����ђ,�0�Ȣ<�b�m?w��z��vr�Խ�8ҍh�8�;��]VX�=��i���0:[8}n)���y������Ac��_��,�2�`\�^����X�#o�ԧ@e>�#ۂ���X��I���PqJ��!u?�T�7�Z���ل�1��4Л�&O<��
��\� �����V�]C�ֆ���`�8<ڞ��3����jx��?3S��q�[�47�m�/����_><0e��!D4�x]v�FS@�1vh$�f��:
�{�&�5Zj2�\Mo���p��T��u :�m1]_��OUtS�-��?;.��G�i9~��>�_q���80��E��^�9smI��
�"�y�ag�r    *�1�� ����:��g��[\Ք�3ϯ*��^7.OO�gɓ�ti�:}��{���4�v����a�a�n�N�����ߕ'�T�='`IE���������,�_��"G/˦��z����v�w�v��G�t{��#����3gӭ��W;��߂=�W��BN�7Q�ߒ%�����p��:�y9�Ɖ�bE�2����`S�j4�d����9��9��!��4�uT�75�ٴ�y��lj�4�j��½���m}s��|-X�?��K�m��� ��rTE(������FҶD�IN�%��N@��W�,:���ًSV( �]UY�a��[��|����XW25��`����c+�v�b��kG�1p5"���5��p�R;�#�ю�Py��F2W�� !=��aeZD�ed�c�êVD���p`��#���5�٤{�+W��k��W#�7�'�u�I�eW]Q��-U��i�f�bBH�b�����\����(�q�
���=�=$`xA�H��x���n�z��>�6�����R��{I˧�3%d_0�%J��7 �X�{z��AÑkEt��~�$(�k��H>q�j,l��e����P�q#�G=�t��,
�A/J�P�-�Sm��͢*�j����r�N��I�yed�پ~qzZ�[�y�WNkl�#�)(OTk�)��P��A��,��7����e)FN�e�N��^��S�����c q��������͜H�k(��H�f�l8������t5D�PB��+�Qx�KcN\�o�&��$� ��n"�5d�B*�Ԁ`4�҂"J3+*y��5f0уx+��,�j��9��2���_5�$5}ۮ�ml-��u�+�������Ѱd�R�K�x����5�D�|5��=���ʃE����Q�s���@�[��!��KB�U�`�k~!��:b��oc���}�_�bTƖ��|�a��=�s9�29ըK���`�UۏI���ϔ�N�#7c�Ë�n�yA�Idɴ�c�T�A4 ���i�S7�N.q t�а�~_��5��D��S/8�o��t����y��;�W�]��y`P�z}�j~Z�g�0u^��hn0IADE*^p��Y� ��Z8	�s��a��MS֯�x�����!�J̸����#.{N�9��Sp5_�؞�~��|�Nn�3��>�pc�-R�� ���}�~#f�7�����l��\�>Q�&�M;��F����[ubT,���س��]vz�mؚ�?/}ӷl�4]��4�*�,I��,X�'��맛�V��\/�j3#1�)K
xp����&"�8G���G���@;�료j�v��z C�,�g�p���2�p���.	+9&�;M�'�:H�ԡn_Qh���d���sM�)����������eĞ%.�m�-�J���#Δu)	jGn`8����l���c���@ɮ��������F`������[�����	I�C)߈=l���:s�~�����E������M�TW�H��'���d���{gw��
��AR<	��Xd5.otEn�!��~�l�� L���42��m]� 1��Đ���/<�@�I�J��V[�~��dZ^4#�"]�]/Ů� �jOul�0'�i�nUT���a��Z�zI�u�r�k]g������d��A� ۍ���|I����Ӡ�c�߂X+��s��:o�$���ti��M=5�~��u/k��$wZh�ʡ�L�j���ք75�5��?���2�Rs�
n�(ʳ7 u�l�i:�]՜fuF3Z�&a������Z⳧f��j��®w�X;�r}-Kd�y��s�Z�F���l������?ވ ��R_<~E]yZ0���e\m��D
^��̝��z�F�0�^*Kᑂ���K��O�k��t��瘽`��u�<E|���E#���aS�������^A#=�@�H�3Boy$����7*�a�G��a��]�)��hz����*3��lZ�~��j#T�l�a���7,�uLղM�{���UM�dY�|�w1�}r_,���|���m��+?8�-��|`~���]%eQ�?�2�D�k��l��i������.�	�_(�I�DZ!�8�k�V�u!˶�Ci�6o�*��G IA[�k�Y���%�֔�*��N��
��� Qn�f+��u�_�����A�Cj����N�W�"��;�8�������y��Z6���,>�U	��勭Ucy�j���{�/Õ�~*����O�$���ko#ו6���D�9����~�|�.�.ݺK�E()�-��"�(Q�N&�$F0A޸��Iz2��x^�F�J�?|~�Y���E�lWSR[��8���v�������g�@���Fl���\�h��c��j6K��Y�����T��8�gΘ*�-S�����j�uI�]/�J1��7�;�a7�2g�Q�
�atT�c�����ՠμ�Nq頨d�y�f3˂68�'= �Jms���K���ɧI���YL3_��V�O�=|O~KKBy<�j+��>�y]����J�8N�V窢�7B+�B˲:~-�k���g�J��*_��9�}�K�y*  (�_����q�G_���s�v�e��%���נ���x�����U<kIez���ֳq�n�3��vT�3����ؗd�x��<��Ź�^���A�]Q�]C@�vyJ�}Ҡ��*��̏RZ���ŧ����������f�P��҂/ԹS �U��(wx�)�n�7K�*�4�S�ɞ���)��ƺ�o/���s'/�]v�������b��EჀKE8P Wlx-�Tf%Q���,�j5j��k�k8DۃZ�qB*�.�L�!����2O��dx����,4�e�'�9���O?�&.��u+�S�A%�Fx
c)8��$�O@"�:yZl�bdG�JM�����yʀ��!����j�q���mZ&��n)��I0ϲmp�r��|�[\s:��f�����'C���[���q�9��-1�����B�m���8;1�� ܕO	4?feeT=��J���`�L�)qu�ndKe0��ܙ���g�sϜ�ڤt����U�*l�W�@��`#�����Q�y��?Ol��L��D�+����|q����	�5ڔ���v�#b��ꪃ=p�<�75=�C6��۽�/�EZt�]>{z<ڈ�G�QU��h3Vq#�L:���s�V+>��!eZ��\����o�Y����g����U*^60��1@�bL�3S�_�? �\��,<�9܉��p���� �/6��a�l���ÿ".N�	;zށ�8a���J�^iF��XV���th��{�Ѧ����鉗�t�iB��U�lc�ӵ-7/��l��y֮���mƕ�Ys�m=�m�p��~��~p6��/�WϮ ��f;R����G�6��:�*�_��R�#^�7��N�a�fojjƓz�s�Y�p�6kj��h��)��2�,6��F?<+�_~��OŅ���E��� ߏ��d��"����!<�73�=@�D���9%x�T�i1�+0�����݅����R���-D�} �����W��y��)��9�[�u'/�i�HY>nTjkJ��i/<[��{��6.�Q�c��D~�lֱ�E�؆e�>�@7�k|I�/�_�2цR�ʮ(r�E���/���OB3
�:��=n�����J6��^���Q��,����X�D�{b�sA��=�bLOL�"�8�v0��WzXz�� a^��}��Z�b%�g��f̩�������c����@�۳E������71����bԜӍ�}�p(1r�I�"l��������u#-#�,
r�biH�e	u'O���m������%+��a|N���,➀�ń�g�"��Q�_�^1���7���j�oLrJ��mBO5���NSL�l���1����S3_�v�ao�����S�Z-�n�Ӷ�����\NT_���{9�]�OaQz;��\r�lri��zHHN#��@8jQ��Yp[i��+x��J�
JDSN1r�a�Ʃi�� y�q���������T��9�Q�љ	r���y�R��2uִf�1Z    &.��1\�RG0Ih}2��9����ס�x#|�4I1*NYla|�����[��1~�H,��^���*~̠F3�!w��R��Y娷���g�����涴�m�4�L�����Z<P7��07KE�-W;��F�zç�i�7ȃ&0�C���fPs�����nG��2�"@As?���%S�J@�U��ՙ�c���	lV-:�FcNQ^ udD����J�/>�v���
1r*���l�.C,?}g޷��)7!ĬZY��a�f�4����rةt���R�隁}�t��͟MU��k/:{�¼ۚ[ٽ4ݧ}�2��y�(��ь*�� �oKC"R����z!%�J�o2%� ����l�1UJ�+:�R����3�>�����
i�j������� *�
K��>��񚺒�q���Fjbw&umb���������Q��fa��:����n9�m(v�\W�l��4C~���饝M�l�~�<_}y���e�*~�r8�7���)�%���[�iE�`��bDmySP���!z��2>����-����z��21��/Ѿ���,�G<S�����y"���y"�q�Q؈D�v�M.�9�Us�1�~�I�-���5�ތ`����uF'R�)������%�"c��ÝV�B�;�єƤG /�����ώ��-�j�ۺ�;��/w��?2�'��~F��-j�½n.�M$��j���!�b�����x[e|��)z9�^Ju��J�_����C��=(=ľM�3��E>���N&��2D�2�z3�[��pq�H���j�H��H��2yJp�X
���Xˇmz�ѦU=�2=C�5�.-��cǴ\����*J�˛3�σ�Z�t����G��nX��g���^Q?\Υ�j�L���~�A-�g*��zT�1��AV���5���]�cܷ3��7�;����î�7�_�(�#,6��ߡ�M�xdD��)��M���#n�J�1IcP�q8,�&���т =l h5��79�ch9�gꁧ�#��T�tM8�ӳ,Ƕ=��]�r��T,��:�c�8��G��mΌ�N�u�]?�_�-���;;��`���^l���P�O�i�v�aGX{M�M,QhǗ��L�/��y8����BB�թ5ç-����A����^��?���Z.�㑆:��	���Zưl7�xѭ�� �!)�(E��VJ�̻��y3ɓ�W[J��Rhd�����25NN�ᔤ[�|�����Nn2�;�7���,Q<�ن�ph��ئ�*�.O1Ͷ��!��(6^�t��ʁ�⤺�=��U'ZM�M���t9d �'(���sV�~Ul7����B��iT�ɛ�!Z@»�ؖ9HUES%�)E���"�}�^~�3�O���w�k��LͲ��h�i=�^t���o�ɑ1E3�7_ē8	�i|�s��D2���9�ަtJNaG+�����&��;�k�̸�!M����h�R�ol7o�Y;�X0z�;/����OW΍�����H��%��4���c$�3��� �5�a�mՒ>�n���?	���pgv�R�Q�j�Ց�(c������۔y���-�G�+'�?��^QH�#��^%o<�E�:����;�#�(���R1���,�}��˕��$"�Oܤ�7�lo(�N��Q�s6׽��Ny2����1A���ݼ]w��]m//�[����f9V_����g�<bF�МB���$Lp����֘>e�D%6���'B4_�HƋ5�*�Y=]�f�Q��.��������!�0�I�ݨ��D�q�mМ��SކʄLØӤ�md�����ҥq��8�QC������c�(-�F>#��O�Q�~��h2G�y�^�#>{��ע���D����/͕ʚZֺ�#q��3"&b����c�O�ͽ�b��P�+=V�5�H��g�x:{�7b�&�	<kD�}ϧ^z?�11����^�Dy�#:��T�I޲���"��@w�ey��|��E��Y{J_4@�N�p&=ͳ2 ��~��g^��n8opb���cN�̷�ڦ�v��9��زۻ��k�Df�W��i�k��]��r^<�[��Af-H�^ ��o�˘��:q뭺����V��vFn��0�����!��L�%+�֬f�Z7&y4�U�Z�?^��ވ]�X&�ż���8���$��_!�q���L�G��+sq�n��O;���e��7Yl� V[��g+7����_[(7¹��ʡ�����칱*�lC�S��)�>��3'X������8ǒ`Z�X� C�ɸԜ�u,� ���$br;�e���;pq���؉�O��x؞3՛�x���h c�l��A�kp���Q�"e���91k(��`ƕҎO?���M"Ɓ��`� ���9	$:NU��b�9Qn3���tmӅצ��ipr�-�Y��)�
�����h�������F�ͪe\'G����ū�\�e����Ėb�5ư6�K1@��n}���*�9�˖RJ�����}X���7�Ԃ�M�����Bٳ돁��"l������L�Cj�
���ެ6�@�e�h.�Q]����x]p���'Ş8�y�:��
k�ҿV*	u�L���>�`T�m9��My�-����穦�ؖ���g+/�J[R����Kw�������񎾕՟o��ox��V�^���
��Y��M���<��e�;Il�V��C��n����=t���"�|�twf
pJw"Zñ?Ӹ��bt�{�ȬF#	~'l��&'������2�9(eRX`�;���] �� ��-�"��#�\�a�L=����=�<�����xc�S5�٧�`)*���i�]��Stw׻x�^���m�~��Y=[����|~0TiŦRZ�}��M��I|O��l����#"]$���Ɣh�Y��=@#>�ݣL��dMJOY��Ôl��I�lQ
��e<$�2�I�0��\��4�O!�e�E�p0RR�'�#�9���w��4��1��k��^Y/Lݣ<�#?��3�Ћ���3�9��k\UO�=k%^s�˶bEP�'a���̓�qqsgM�l�%!J��J��Fz0Ŵ8�)�z<|4��؇<����H��*�����H��p�rG�Շ�=+���d[ȬT�DI;�M��y��0�c���H�4a3�4�IhhhI@�1�
�w��d¶:�u	�NR�0M>7��w��x3lCGM���=��T,Dб��3� G_ɑEƆ��WY\]^]�<�?L^���{'�!�D�`�`����@L��߼F0���0c��2`VL��B�y�M�A���c�$��p(]{)����?��;��#"0���{~N� �_0��?�/�"�<����_���t'c�j� �������\kdDd^@Z��r�H��pWN���p��71�����zΒ�������`Y8,Ww`Wu����׸;��SU�W�_v��/����s��hI>�oô�ǋ���lmcj�&�Tb�o+ɨ��z"���v��)���l�Z�2'�j��ά:�ְ���	��U��ˀ��T4�λEQC0���)jO��e5�;�5�$8Ѥ���rV�,~���t�j�	��)k/�����_5L=p��h�l���Ϟ���j�vO�ʚ��V�c�~��G��q|����!��ܵ vcfjm"�p�L�0��� �X�RZ�/2gr�e�QP9|C�qk),�5sp|5��z���S���:k���h��*��_�w$��N�%]�m��EKMIx�q��O}�{g��]:4n5Q$T�M%���o�f�����f���T/z)�N�s����y�c)`���k䥱�[;sA�i�2Y7�ͅFwicM8�ų���\-�)Ia��E��&��l84��������O�!����ݝKL*���5�̢� ��1pG'�r�h�]�D�E�g�oŮ��/;���1��w��k87j��Oi��KZ�{��u�QM�Y]�����g����I�r�^�V�*jܪ\�5n��~~�W���0���� ���N�?�-�4 �k���n���#W����յ�uVQ^���r��1
[�n�eU$ء�K�    A}%�Z9Za�4�8b�7n�v^#��t,jυ�f�)Հ�Ŷ߭���R�k����-�B�s��j/W�++������޳���Ygo�bBB�OD�ZJ�~�{u�1/�ْ!�9��L�+�璑�$:���Ŏ0Zr�會� cLEV��ï�����P��8���.�6�o:z1�((�M\ }�@�c
�F$��6��.�b�/�M"a&�G�q�0$	́�b~�#���a��?��hb�-<��Znggڱo��eիT]�P�)팊���~�ܜ.�����]������Mѷ��q�S�I�Cr�Rɖ���P�lUF��2-�.UI�>�(���1�^���!�'R�4���ᔊ������	A�tb� ��O���,��azw�±���~qc�Q�,�xp0�~N���B³��o�n��f���Rz=�y���~��":�%����R>�ۍ?�a'���v���*UP�Ϟ��*�$���W���6W�&O+�X�[�
l_q�K���-��Q�Q�-������"�������BA���l�P�A�Gҗ-��b���Y}�#��=�r����w���(%�/:���H�B/ejl���l�r�ѬH���E�ҷ�d���O��JĖP��w�\����S[=UN^���w�RE{�8�ʈ�<�q:��Xv�S:̶�=-ot"Q+K�դ~�ya��,�-�n�z�C�;V��Q����,*�\W\ſh^���HV𻤨ء�tj/|9f�Jp��]t� l��X�yo��U�I	�W�U�(�q
�X_M�8nc;�O*��ҕ���c:7�!������Ҋ�$~��x�u���k~ǯ)&(�b�l�=;��l{�e�����qxz��[��D��6�l�4���2dB*	�;����MM��ȶ��M_���k>0z�4cXe�%���
qSҨ)��%UP=�9�^ʆc��@(W:���g��\F&��p��	���;%UƉR�ة�.C�N�����δ��&��������`���f9�����Ϯ��e�8�m���qv��`�s��T�����r�裡SYH��Nm�cs4��q�_���@XD�>�gTΙ޲���B1Iՙ���b��R�Yݽو�,��I�np<���"8pn�3ޘ�D%�*-CX���#��R�AӪ���P0���������$e����Q0xUxӃL���(�gX��i"���WϬ��d�\�=������Ɗ�5���mW���,.Uq#
e��O8��A��=Y?�%�=(#\봫c��ҷ�=8��=K�^�n��)<�Iޓ�f��D8�>�s�@�5᪅��*9k�{��*o�.�=c�x�W7i�����=��R��.8t�M��Lp�,Os�)��fsmK���t����j�hѳy�l�[�n&���4���=r��Gl�I�r�����&�(+9"�%Y_D�o�B��_xeC86bF�Q�'�~`#&WzH���j�>k9���@;��j��'%1���(�K�:�;��ߪ&��#�'�����~����9_`��G�JY���d�����x���j-1-7!���������i�o��\]�l�SK�w�����6@$��tc�����H�=��΄"�WcRl��ƶ���⓹�C,U\���x#{`Z��.Rcd.$��pQ�`%��0��ڧ�
�y�Ėgf�{t�!�\�ʆ\���v>ɿ��Lyt`c���v�-	��ul��j�3�BNU�n���=�}��eg���t����xg�+&-N���3�|z���>\\q�Y_ԺV���a�@x�w!��eҵ���*_���@�ۍ�fQ^���1��5tdHjˡ>wY>�Q^K�v�o�]\zE�%���Kq�? x`N�a��X��S����hY�e���U���i8
%�2-�K+7j;:t�.�c#~�V��{�g7K�k7��j�<��@�-�N��@o���M��8GV~r^|�U_ �d1(�|z�L��d/{(��l0��Ɛ�L������"�7ʇ+�_��/�ϓΝ�&9b�y�J����^s�|����6@[w�j5�5��Ps]���24����V�,�k'���pc�S��[�;��=�𷟑u"�"����.��Ks��r���@�����?ɱ�������!H��%�� -�0�RqGbL����I`�R�?�{�@g��Z�ݡ�?~7��=��R'�aҊ%nU��b0s� E�<��E��X�:�~ ��M���L��i��Q/��6��׹1�ﵷ���������r��ޫ�Y�k3�J�O��U�=����J���EY��\�9&�f�_6��:',�L�-&��:�5����pgv27�`�i�8ݠ��pmb�Z���z#�l����pQŠfV "�a{�Q��S�Ѱ~	Q���X���CXnN��cOi���Q��Q�����,��*"��i�j�i?�_iXK�G'���ڶ׈�V���p�X���tL��&�T�1Y�O�r�$��arn�_#@�PtcM܇��=�LƐR�Y˺Y�c�|�ɻNa��rp�(����Y�i\�_N2��/L8S�s��;�ga`�<��9��XSɱ.�_>�ZP=%�Um�P]�tEف
����4��֞_^)/�����ݳ~���wf��z>�~�N�ⅳ�K;5K�����80N^�ܯ�e�R$5��\���	eq�୪#B�N���Ҵ�@ڲa�jެ~ӵ�@#8A�"t����x%9Y)�%v
B��5��3�}�ZH�����븟h��B���`�Ԑ�x��f�|ȝ�dJ=[�.�j[.���g�Ⳮ�yϊ�Km���yǾ�]���`�ee�K_�)�%qԊʍf�+�=Jµ��_,���g���JYa��Vr?�
��3��
��5e$R��&�Q�`�^y��1������3ܧ��ڪO*��Ex��� 7�N̯!���Id�6���f�ř��'\�ݥdi:�Vw����xS��A�<�^���-rW
UwUW��Ѐj9��7��.��qte��s�����Z8��m��U u�3v�h��Ҿ\M���[�P��؎��hF	]�ߧ�Y�E�ˎ��ߤ�<xa�u 1�"=x�ӻ#��(ʄP���q�S�I͏�Fq/J:�5#�6�C�qUu`�rp�,Y�Mh�=���&f�#�����J�W�I@!BS�2�xz.#_����eJE�n���m��lg��(Aۼ�������j�'ʂ���zu�t�g3��rmYB5�?j��9��b��	�*�`%>�l������*z@�]��U4��FD�uJXuKM31������K3��1�{�ܬF�/\ �L4�xZaK���C9K�/�K��5��O�G�	�W�����}j"���Bl��y^��?�T��q��ͨRm�"a+A�����Ϯg�͗��WZMe�^�_n�4t'���p�F"ۙ��e����n���cjmt��T�S�^qZ`�h5m���5XL.`�P�����	GF�' ���Yc���:,�{����:r����c�����I�]ҽ�C�N-��
���(�Dr��K��|x��>��_V)`�w���{�A"�x�i* ���`�y�h�<������v�T�^iZ�kGq�d�#y�5*�i:E������7Z�W�d���RZd(��ؐc�OcKu�����( �~%���L�AN�>d1�m@G� tt�xF����En�A�w��*��7���B(����0��I"��mQ��_2�4*����$�v�)��}��}۪jN��ư�I�v����ٮ�3������A�bsq!|�_\y��ڻ��v���!���`����
�5�ا�(]���W8�"��!6�f�.#�P�hއ���QVƻ2Zƕ����u����g��R�z�c�
��m�#��0�-�:���z[��T�
貘9)xܩ*Ֆ �3dBn�~�wp�)}y����e1T����5U<Gx2�fjy���ފ҂����^��ם���X͛��j���0y�Б�7���{�|��/�6�f���a��BPg#2_0uN�#��hxԣ5S��0�w��    5��YӚ5G��zQ^ ���8"�~���50�i�+d_]W��qIR� �A��I\#�H=�aKI�3�Q���xp�2���L�}�ݼ�*�s?�t�����ek�oݓ�0z����)v�@���:V���\��޾�O[�se�_Y�\��O����o�E�� �%��O;�r��QD�4)q�%��ɨ'�����E��A>�_kܱ��gO���q7�9�:QQ��!�^<k�d��$��ֹ{�7��7�C�(/�:��v�ɂ8�EY,���s!VP(��=/�.lr�hG�F2������
à`R?��ۓB�eB�s���G<>c�V�A��y��nl���F��趗Oe���S*q�u�*[���gꆪV<�и�bꮭ��k�L�6��v�^<�������^���}Vr�3L�+-R�^��w���aAgI�u�mQM4���/N@1C���Ƹ�%.��xS��$l[��6�(O�*����/�?�"��=��~0Ϫ7�4�n��� �m�z;p�*苸�q_8L"�R�j��)g%��!�c�ޕ������b�.�(���Jbx�Р'���3�r�;L���GA�^mU;�j�[�J#h�l�p��������h�N�{��k�`g]��{=���h��q���\P
�l����ף4��J_���Al)6����$�Wa�v� Q���8c���!�׿�̠����'p�~W7�7�JuÙ�v2ia�b�q�F�Τ������"����G�z�����b<F�56c��q�R�zfң�;��S�maW8C�#������X#bz�\��S}�$f1�M� _f�>�9��h�;��y���<�f��fkd�*���-���,�|��/���͋�v���vN�7��@ܸ�/�Xўl�}������!^biD_bZ?)6�A� 
��Ua���n�%,{4!���F�nQ^ -�Y˼M�EW�[���A�_S�r�q�r�$��;Q�7+�$벅C¬Ʌ%0>R�փ'h��)VC��:<=�c�M�n�)�"�zՎ��fi�c��	�UUOqu�M?�yk�}��w��͋����v�8�d5�#߸�L�4�ý[  �h��@pX���+)�kp*�sd((R�҇���"FY��g5}�c���jRo��}��ϲ�F64����W\,��O�D4N4D��ѤF�xZ6��g�~^mU��Y/�LU�f������z�ѧTW�\�r��^�5ժ�y��Y�i��m���:�?�B;4��[��:~n�ۊ�8��W������v|FV���52�_���+:�"�;Dd��rSC�l�(�WX��z&���zx�9���k�K�c��	)���AZ�`�v/���6�(�&5�[�@�\�6��D��;�մ�T�~�����5�n��R�ןN<~4�Y+�iI~�#Wi׫m&q�g
}�4L3*�CO����"k���x�J���iX�/]g{�t#���Q�+峽��/����r�~t�<��}��~���D��p\����:X8BE��+��Y���K-&p�C��A�4Jct�u��5#	?�A{��X�y�Қu��I����V+�^X��{���cc��Ëy�F�Q��?Rn����ga-b&vV�TxDna{GVpd���x����S�߬aX;ȉ�Wr��RwTϰͧ�W4��,��(�w�<E�9eM�r��G;ݠ�]�_��>_ީ�'�=�r	{��c��..J�����B�~"z���K��0��s|����}N>A�	-���u��<%�O�t���	ݫ���L�7:�0��x�R�U���pg���5TVG��E��lp"s��,$H�ZRc�x��<,X9�M��#z�X��}a�?�8Ev��1�pr6�����r��;�B����LUs�O���WՐ�h�Vަ��[�j}gѼZ�/?m���a�Ԇ����̋�շ��S�	�Ƹc��rb��"�D�	��i���_2��S�
|�E�
	^J!D����c�����s�7����͚���S���b�j���faA��-z��:��0>"*j8��OJ�t���n��_�X���O!�U������/��#N�kwqncc	?��N%>�6W�:��(����-�#��p]-��ٰ^���kmww�p�i��l�W�j�m#����qI쉃 o��TD��ºof��t�%�_s��2ȈI���!���#7�J���L�2�kU{B�Zy�0��0���f/�Ĝ�N�1�P'�V���/x^|0L�3s�43[z�o?�m^�ϱH{�2[��`WE�9�[9�R�0`
�-��x��a$��{HCl�xc��S�~~��w[~'>���f��������֫���kz�c[�8�T�N5}�kO�W�^�\������Pm7:k�y}�ц��=�R*�(����2�;y�`TD��S�����t{a�+�٭?�f�/#'�hH�)���:�ED�~�"[�+Jߓq)w�.�,���SfA?�w�T�c�[����n�b�b��2e��t)JDlR�La`0����l>?�f�[�ݝ�԰v=�#��u�t0�]{��q� �DR�4����[3-ګ5s7V*��X	��7O����Al���U���bԐ�B�"�����%��o�u.IW��O)'L���wJ'��)�|���88܁w��kU =b�V���<�y߻�gz���dW��.,����),���̱p�&�X 4�eڥGӣ(�$��).E2��9� þh[��J�<__غ�3Ls�L��s�ϥ�j�/V�����ڨ�w���(R4ݳK7T�����mڸޘo�s���uP;_�,�I3��G��o?C�m��K�fO�.Q�#���2�C� <-�+��
�&сƏ����h(� �/FU�s�L��-�@�X>5�(/���@9t��G9�X�������ę��V�|�-h���j{Hρ�!��QT�:��%�Vn��������5���Q�
7�40�*�=0Qņ�gS�{�uw��p-轼�m�,���«ݬU�>����e�<((�H��!G�2����t��8�c�T[��N��؁8���柉z��őUX�~�pJf
�n��%��q������u���*%���K�̔��6��jÓ��N*
,&�$�	��t&l�c����e����`ځ�<ȜS��=���m�eר�:���Xeς7k��' ��m�M6�����y����鲷�{9�,�u.���y ��py8Q��cSA6��L�| �`���]Pē��5T�6.��7�k�v�&Xun*�6�W���_��P�H�:A����oR�7�+�ʫ�v1T5_|�=���`�8nޥfٞ���n���Y��F��ت�)���}f����忩��/������bتΟ��fK�8n�j� ��k �s�&Q�oQt�1k��KPe4�PT�Dm?H��wQ�rI8x��|dӽ�*�3��7�[NQ^ �b������+z��d��WDW�9D��r��.�iW�W���;���\5�|*�}�ɡU�9��p�'&T&62��Z��+����ӵ߱�g*��N>��]�g���{/�?���z�b��*�DF�����u�ip�z��y�R9>x�����076aP���If��a��@���xO��ˋ�7��I�q�ڊa-=��i�ꋀ�rB�	�9~�w���(�b����H�D�<�I޳�f�Ӝ��������NziZa�R�Bh�R�qq�OS�F&����VrPwH���x�H���ejR,
}ЯD&�ĉhY�p>��톟��B��o7� *��*l�H���1x�K@=G���p�MiN=�;�K�Ϯ�Zu�x��ptu�=���Fm�ɨ& N`]}6�bOƖ�\�'"�1�Î���'���~ϵ.cK�>я��M@��nϾ�&�ЇM|Ӽ�ͺZ�a_v���׶����?�����7d�b�*��#������D�2�6p/�%�gX�@F6������t�ѧ�BM����
F34s�Q��F�M�3US� v8�2���>�g5��,���'��yE���>7Z
�@y������.�Fe�    ��/����n�&��e������{܋�d�Z��4X�H�5��Y[���r�iZ�$8L���'���I�b�YY�,�:�Ԍ���Pn��|D;�3ؔ��m�������/�v���ky����y������~u�Tݹ��ʛ[r�RWo�]�P�/��1�R�����%�M'?� `�QVI���/�5n�$s���#��7o�b��V���L:��I&#u�t�X�U���c��]Hk�dOl'KJle2�Q3�5�,��a��ϱy�Oo�3�M�I80$��_H��c�Tjg+��\/t�7�R-����vLK11��Q���yW�yc����\8mE�rjǱ��!Q��F�+�d�fe�"c0�_�	�����!��5H@_�
`�ܞ)|ػݗe�Qެ6�i�.�����L�&B�ID.�85�����	u�#x�o/Jp�)���s�%cL%F�E�f�F�]�z(�2��!�6���NN\�o0m�	��Z�a� ��h�F���Ut0��_yQ�W�j�\ٕ��~���co����G�/�Ņ.��F=�����W�L"��o�&xDtS�gC��Ty�g�ͅ��#�y3��t$=�ݗ0fu̚�>���O�� �O�)Ra�:�H�/�z�2����L�H���O#���Tj�¤u	��0Y!��94|B;/���gJ�kT/�AԂ!c
��|�4z�oj"�+���./)]#~涖�η�I���[c�[�BdN��4JP�U��
�� �'��i��R�e���&WFH�.��x<�yB���:�2�Z+d%)-ty,ӽg���>kٳ�hK#�(/��2�I���3�]�WA�_�����q��xg����F�P�@M���)NyJ`SD%'�~ꁧ�CKSM��4�2TC�L�RMMu]8mOW,̍������r�}��m�����D_L.O�[���ō�C�����AQ�S}�t�0��4S\ETm��2{�Q�RZ����.�h	�����6�D4����3߻��a��eΪ� a��P=�DiNa;��KQ�.S��5�KI'"�W$y�D��; �I_��"�b#���
#��͵u����9l�ӎ;��������-�2-� '�t,SSe���-��j�ݪ���K1�����a�k���oD�$!�Ԃ�D�/�3d�(	Pw&^�c\�ϱ:���2)Y�C����K���N��p�1�`��z�^=�9ݱ��Z�;k���Ԣ�:�X��/�����O���1�"�)�v8"�l���Q����A���Ux�h�O�nh=v\��ܴYe�:���R�b� �$��R��!�K˙c���L�p�G[`R�.��]�i::x��Z�'8��r�r\=$DoN�+���ݨ��x�����J�5��nI�G��D�!������'��(	��`�~��H��
���%N_��_���S��O��N(�q����ړ`���&t�2�~A|�QS���=a&���
�����(��� ~�I,^�ф��4i�<`LJ�"��4 ��}�'�/�'R�xo9����h7?.�a%
�Dчo�B]s�,̱MU�\��ey��y|�D3�V{��ڦ;�^�����`N$�t������}2��N�<$��RB��o�1��'Y��������Z���K�=DI�a{CJ����0q����B����ˠBp�f
�g��#�Y]��t1�~d2�JWOV��NA���hS=��釦1W��'�������$�ܚ��V1R�!�� �Ȃ�9�x�F��vN-Fy�1�|5�ws�)u���I�,���\��4S�l�v]O3	i+��r���i���派�uT_Z���/�%�F_�
L�6���tZF�t�	vWIK #�eQ@�6�����(��ev4��C��bΉ]��P�����U�2
�����<�VQ^ �b����,�<��I���z1�n�Y4���-�`�a�}���%�a�Ď^�D^����4�{�)UYv��%�\T@5���ݧ�J���������ͼ*qzRV�a�U-���J��dU�������|��)���S~���o�%�(�b��h�I���ٸ��cm�yrI�_��"�x�G4׻�Ҭv鳆9k�<���.���P]4"�*`�+��Vil1tY��_A4���*�3��efb���jΖ���T�h�hQ��{��&�[W�Ŧ3�
���X��y^~��o�/����K�ٚ�	i�}����m�������˕C/ ��˔Y�T!���)�#�O�^�bA���Ȓ�s��u�؋JK��t�M�S54'�vfƵ�D������c2>�=�l}���%�z"VKP)���z��&rL���9k���h�ZFް��cO-�%8��z`b��>�Pч�<l8hz鯼�y�9���m���y�TV���+[����SM�>�@X�5�!KcQ�k��%V	#�e,t�B��Nn�V7U<�>�}�A^�n�x�7+C�f1BD7O�����dx-R_A�����}�U���w�+U�﷢@p%���Rm�^��M;B��G�:Z���^8jT��<'�l���i�ud������e�}ؘK·�M�S%V�K޽�\uq����߀�l�]�E�W)`<�f(��8��-xVT�w�QM;�Z��-��9�M�wnt�	m�ps��=�I�&�$��!*�UFjS�V"b��?��:9M��mJь��c�%������q�I1,�Tl�2����WZkuu�g��_�=u�6j���M�3��zמ �Ӡ)JH��5FA��9=��20J��R���K��v	��!�0E��;}�$O��@JŦ�mȬ)�Y�+Q.��?�����D����7N�>Z<e��;J�va�
�	,����A��d6�&���>�6�e6F��q��CQ��g����[=�r�6��n�Q���~X���]��[�((G�e�b؆��yV��œ�d�:;��'G��7�,g��o���� 46�I�\!�g�����z��_F95�����<!kP�8�r��#��6SxГ�{��j���5sL`@\ �b,��`3�O�l���F���p�5x	�kcR��u,4{t�`�=��s�(Q�����0r�>�z�)�4I�f����ض��ϖ��9���UO�6���bc=)����y���Jyd��oY����Srዀ0��%��Q`�2>�:���>��V���u��@��I��O8�L����I����;����"�ĹIh�'333�D*�N�$벑�c��]KjV�L
���q��l�����$�f�T5D�`���d<��+���6ĩ�4,2�Q�;�HUC��Ɲ�)|"j(���炂y���S��Lޥm!,PCp�ey��"���! ݰ=pZ��1��Z?ZH^��|�kk݋��d5���(���Eچdq�o����pŏΞF4�U~��Y��iQ����apT���ǘG��`���:��(v�~V����ی�M��A��]f���b����+�Q�J�"���"�b���H��d#�C���,K؆?�'�׆��IJ�1J��[�r飡�T���&�4�}��Fbp��Q�l�Q�*x�| ���锪��q#nV+�i��fk����h������J/#���-�9��?�H̓��5�?������Pl�=�n���ݵ�b��.б�Y�0#��x^�|��|L睈��$��_*)� ��.�j�Pg�M�%���qa��G����:����ʞ5Fi͢� {�=��Ds�6L�qJJ-v�S@c�h<�dGW%3��/���3���u�����rN<�5��(0�xDx"�*>s#eK�U�L]��^	�W�����B���A����S���LIXQ�k��'����I�5}& ����9��7�v,����t�{u�TN��v�ݡ�~���<�^\�(�a(�Na���Ԁ�C6k���-������P�zXz�����hϧ��=Y��4R��?3�UIdjѽ��룜������T�a5��(>�R��|�A�N�����_�(>�Q���HTL�X��-�����I    �]���7a�5;g(xꁧRQ��(���T,oD��O���BG�������eJ]Z{;Z;��w��d���zy�C5�(��o��-n���]iZ$x)�T12�sJ"�j��_�D�&���ޏ������=[��z�[�T��3��5����T=�Im#��fĉ���3���M�;5ln?ÉȳzREvdq^[�����)O�݂�6�:Q���x�kz`y��v*����iN���,yV[r��;u�b~k�y�^%h��m?c[l3������od��2��/�-F΋W-#v���Գ�������@�	�*������7�kf��6C+c�#|�ұ����"Ek��'������V���/Z6�Rc�Ѭ
�%��D2���B�ZXL���Pf���n1�J�p��'���^�~�m�X#&yt��1D�����Y����f���k1�84���!�.��\u�[���(�|*��ib	���d�|�Z,7Jq�m�	F�I0��]�<�Ӹ?��ZG�������ä�P2�!jq�o!Ú��5����'�!��H\��6Z�8 Q�B����Q���8���9�-���`��n�k�
����Kc��uC�W�4����7�a-tΖ�׺����S��ە��i�`�@��0���WQ\��.��|b)���E�ƯP$���*�&"� -�qEJ��?���LỾ��HY�4R�Y]�5F]
�(/��0�İcT��'g�t6�&D��XM�1␇&�]��n>P�b`�J#�h;�j�c+EM5eV�l-��s��o�b�ػ�F�p<OE�BG:���u�5F����v.���{�`��\�8W�n��ύKɁ!��Ux��h�%RR��yB�	2��>�� �}�e��Vv���'��rCtWD����mhq�5 �F?X�����G=�	߇g���YU�鬈���11�1�➤�u��"�;�U��&�9���Q�l��d`%��al�o������1Br����C�n}��T��he��ׯ&��P�������F/j�Ͱ���f�nn�ލ��~�D�VN�6O��Ϫ��p{���׿�X�A���$��<#Q�����d1x�7�ɢ.?���f��I;8��VoQ�#�q=��܏�eU�������=� K*�d���x9s�8�lZFt�����A���w���4�ƅ3�R�fp�a����C|83';�]�c*��?ڊڕ(�l�6�8xu���Q�OC^S�\�j:�i�7���ZuK]76w�J_RO����a���m�u�6=�De֓
�5��],���B
RW����*��n�D�)�l�Z"�1*\�A@a
Cp��G7�{��T;�=͞U�Yc��J/��C�lR[�  ����P6�F3�!�o���K�/�*o|�MW�~U��Tt��xi�^���F󚑓T��w�Ra-�eRk$�^D�Q}��ǣ(��ي��| �����9��w����I'rZO/�u=ionem�y��2�V�"�c8�]͙�0f�6��ȥpny����ˤ�tHTvR�ob��i���R	_]��j9��R:�Q���������qo��Uis��f�Q �^�@��bx��-R
e� G��@��iR��~R��I�;@�b�{cH0*��4�9�Y{�HV�uJmw�~5���߉A��T���U�@w\�WG���\q����*��V�ʛ^}����U=87����Ps�]>Z�7$ү�HE"��<41QfK�V���>)o<�9Y=a]«��H�S���&��mK�/�*p��9>�/[3��5�;�׬��Y���2q��"�Z8�~���OZAO��K�co���������%����8W��{U�'�|�DH*ۮ�T���wL9촺F�ӎ�����j��ò�-�6]��:ZN]KΖ�������鎲9_]�<l�n�����]��Ô���̀F�]}� �� <����R�P쟻<p��ǥ=%��JW?C*L�-ΐ�(���jHBf
�u�w+�T�YÞ�nZ��( 5L�*�b'!�)'�otP1�.7d�Gj�+��O�הt���7��dR¯�
��a���5v�Gw��`="��U|Nǀ��1��{��ս|*{7w�R�����4a��͸�4��B��M79��ꖩ[95X��v��x�y����]lh���P����æ�T��� ���6B��,' b��ӂ�_�93FTk��4���ʈ�(;�<��ܫ<f�� �ι��'.��1����y� l7e���D�itJŞ�/�CM� M��\T�Q����v0E��(���Ę�W��Z.u�vܩH�6�9���֭R��@�E�Z6�p\�2���
�󥫋Ƌ˫��ɪso<{v4dn"��r����Fl{m�k��`N�`"���	rߴ�m����-<���f���U*��$��A9�=1n���\�f�ui�@֐���x��N�T!�!�N$���P���2�˪RI|��w���0R�D1��1��?0�W�_o(�����e$\��9�6��v*T?ڃ�n�a�Ұr��d56M�d(��9�e���uS�K�U=_�z�b0�<{�)���v��'�<2����&�!ApSj�j����1�oJ_�s��Y8*%�@�_E/!_P<a+%#P�쳤3�3���@S��!7��O���ae<{곦=k�t��vØfa�!��߼�j��*�3\ΔƠ�H�	��/|�Q�?|[�����Yd��RUDM@��貱H���M|n�*B׷+j�ϧ�wt�)MOl����ڞ�����k�O:X�����TCd?t�V�"�B}��8>�{/VO.��<��<�۩����R�لC#L�,6�߼�?H+���^2�	h�ڦH�	O$���o�D�W��
��쟡�P6јV��`q$����>ց�K�G�􄧱� wvN�B�Q{�K
84�ۄ��Ӡ)����K!����z*s�!�L왛7�j�����<8j��چ3�Uv㛭kR0֥,���]�H�B��J�,�e>������/i�d��0�$�`'���4QX��������3�>E,^���ٗ���7ﻓެI;����i��0Tƴ�&J��y�O	�Y�`!:Չ
�_��#��'�M8���1�R��pDx�h�}�P��	q�B�p ����n{�)V�U+e<q1��q��������5���^m��Ӎ�g��#h��Lp�΍EO���x^|��D����F���/�6NB��q��q����Ҿ��ޛHe�f|-���%��?m#q1)K$�n "�J�����Ā	{��}�	�����J"�'B��msCG'��CO�|f�o��]7�����v�G���恪��F7�;�\��K�^笫��y{J<�-��q�Ĉ�`\	�HW��q�&�4�
ט���=�"��&Ϙ�í��B2��$(˃���K��u�uFf`d��T�g��"���O��}��	���6�Κ��.3.q�b��4E���u|��!�S�{/$�mn1�Y���V��[�0n������6���)�Vp��C��Kk�==;>�7�妲��j������+���D��I`�\�`5���B�� \�!���M�BbT�&���/C�Jd
������!���JT�#����v��S'E?�A���d�K��C���,�4tڈ����%����X�LH/�դ
BQ�Ѩ������Dė���V�4���#��c���ϟ�����rJ]G�N,�E��H1-��4ͳ=��,�B��4�Z�|6��on��k�������^ÝS��>D+��B��q ���kGlr��z�����Ľ�P�e4_溇��2I�R-�qDZ�n����-V�Q�(c��œ���(R3��3�'�Y'�2m��L+���-3=t�5 �wY�(_.s�^���$EM��b��y��6�H�o��ITP�\�,Mzބ^:����O�G�>��'�lzJ|�\��Zj��w|�)�X�d�k�aaw��K�wW�T�Rtѝ�    u-�V�`�Ӡs�r������8�ի��U�6�N����l!XS�����8�l�����C�L�vC| i�*�xs����#�,ۉ���~-y���Zqt�`~��F�q��۱J�Q��
x��F˴$�Ԡ�,f>
�ی=�ۦf��{j���DOCns�:�5���D.Nws)Um�w����um�i��[}ޝ\�P'h!��� 櫸�F������H&�Ee���!�ݯ�G�cH�� n��%�l_�˞qf�UAZE�'9Z��(�|R��H�:�f9h�� �P0KC��Vј~틄��X2c�IB|���%.Z�_�.P�z"u4o3�u��ɁW�>��Jz"��葓���v�Oi4���V:����a�9;\T���48^l�FSWeT�R���E�Q��r���s��kT.����hL����߲z1�ƥ*�����K������k������m���%s_0V��#KΜ�i>�"�Y��&s^z�1���+��D�V��V!��9l��ģ�|�%=�|xw�6�"<����������̏�0S�E9~e���}���ԭ����j���jD`��m�O�♪�`�{��Z�<�ˊ<��j�X+����6��q�![
��,o�(���#�w(��pbvw�,�D$׿H۾S���|i�%@�al�0eQWˊ�*�%�)<��ޛ,g�Ӛ���-޴���=�U)�`�9���t��M|5H�;�&���Gc� ېv�Նx�9�?���>IF�V3x:2�[QL&�9as��x xN�`�EU��NS��Q�o6���oIY�@` ���r�8H��
0��L7/z��^V�r�Q�����Y8�>8%�MH$�(d�M|�%񩾒��'U9�}�$������苗Uْ�9��Cas���$g%4�
ݩ��,�]�S�t	�b�� �(/��j��&�Rt��5#�X��J�F�|�%" �[��'�s�`��� `�Dn���oiʪ�O��ĩT��f��K�0ա���۶��"�g�K��Vl�޲a>u6N��U���`Îw���|��S(�-��M��U.�8�R�hȉua��D�7n���SX�;J�p�ţ� z\b,��@)��3�G2�;�̬2��������2Y�^yF|�V�<�	���5><�'@��g��"�,J��OG��-B�L��ǵ~��o�k�� ����գN�*
c�	n��).8w�k��<�9y-���k���a��rv�λ�gC�<���s�_�j��U�Q'��DD
3�WK��x)EC����5��K0+x����n��^�d�!�*�1aIȣk��=Q��&�o>+�v�,!�UyӼ{YMu˙T��d�\ƴ`�[�C� ��M��B@}�,��j��LJT�"P;��RSd�X����2� '��t�ޑͨ)��X��@�Q7lW�Mѡ�2M8��8����ʳ�M]+G�[Ask܁���$�K�0�V⃂j��Кׅ"հdl��3"׌����vs� �+T"翶3��<8��\�Vڲ��x�L7Ó隬*Na�}��Hu$�)/�l��y��5T�g�+�t�)�m�i뙔D뵖4�h�z8kc�ӕ(&xG(c��eK�Kf�#E����^��{�͡����=�<˵�,I��9���P[�u�/�d3z���p��ׯ^4�>�jļ���"��#Iw_bE���&D_l���W�bM2�d�� ����p� �%Ҫ�.�����c�����y7�I��0I�+�[��H��=�'�E��׬C5���Q+���؟ȋ$:$J9RZU�-51��u�r�� Q����0\;g,�V�߉rZ(_V9-Mu8 ]�����9�ӯvV��g���|��-����(��KS�,R�cPp�R���!J�l(�"�ő����A��" �Ù��H^V��wSv2ݔ]�u�+,`�M��/Ky�DX���9e��`yӤ�8P�������ۨ�1�����ȵ��W��ǼMQ]�=�)`6j�i�̴ ?ؚ�SS6�Cխ,�k�����0Y9��f��
��X�BRELE|M4,���5�����b��F,[܍Q�O�#C�!}�f�8;Y����y(	�˳z���[�H�L����1�JbN6��pi����3�|h:J�A.#����E��uP_?�cy�T�',b��!�2�뫉�>�ґ��\�nq'��i��U=S�=��9C��ixnN�;�6��d��r��Y�=��o�5�hj!�KFԕb݈*��r�xɚ�G-K���K�����CH����)�F}���?Y��;I��T�\�#m���l	_�	���m��m,���	C��Ԑ�%b�1� �Iz� Z�3֝H��ږ7t�8�N��L�nښ��V�^o�7?�������=]7���9�wD�Gx�C�t$n��ЈA�%�1�D�}�����#�I��KV�5�8�%�� �����u<�݁�e��5��=���� ��"��d��=)p��4A�o�R��b>|c�5��^����l��x��2/�z_��;�zl׹�#��������蓪���n늭��0���˫Ou��b�g����W�.�7k�kۣ��!4�e�ڐ�i�
�SFݦ��ܯEH�E��Q���ZQ~���mM�����1�|���������v�jZ�1��6D\�p���k("@�vA�:�οEH���*0�w0W�P��>��*`IbT���1���b�v>����S�w��������&�-~��pQ��Xj���r�E��n�+g�v�t�\^j(�+T��Y�Ԃ/r�jB�F"���Uu�����;�m�䤒Û�O����!IJ�@�1,���.'�� T86Sx�S������ك���XZA��K�*�&߼y�2�"��*��c_p�P��lPR"����x֚id�$b�X�A��L�MZB@S���!g��mo0�
�G��:X	�*�����m�y�*���m"A9�;���a�E�S�͙A�lm�<P���/��ã�~VߵD���{��E��z%b#��w����v}#���Rq���_q_��c�ӏ��3�@� @{X�%��_©�g_R.U�P1�ٳ�6lyuY����7�Y�-nr}�<��i!H��`o_��v
�00x���+Fu��$$6�p��3�)�,0���:�z!0#�~���=�aG�V	 Vk�dz���k|k]�r��
{#�T�;�D�Uq�����!n&�n$�g��Y.�����`��kP��zh0��wLͰ�V��n��h��<_�\n��.¥���P;,�dF�=�F��1��s֚ML4	Ɉ	ʻ��m���TD{�Ç�y-B�1g�Yq�7��s�o�Zt���cBE��`L�!�⻖��`�i�;@z�b����v��I�Y���r!i�1a����I�6.x�������"I�K���Ok�1'h@��Ә�GC7`]Qu�S�+��歂�{����w�m$��E�9��臣��*�6t���ҥT�"$��"3�"3)ROg�10���6�0��u=e�Ч��a�
�<���G�_rb��̔Ț,��RΌ].��KĊX�o}ߦ]�<��`��T�ǗY��d���`^�K�����w�g���R�yv���y��F��ƾ�w�%��SC֟_�T��`��tz!��{��L�J�Φ��2�";�2����E|���9%���RZ>��Q��f�-���W��$����I�ˇc*��TZ�j4�?���\��` ��JH& �R���b<|.Y.fMӹ���5�3E��X7/��+G����[��~6��O��ڲ�9}۳ףc�ycMr��4jd����IH���P�;#:9�j�2Z�:�`��N+ꦓ<${�yn �8�gȗ��H�m�a�7�~�:�K"�
��,�n�s�e�����Y)s�����u]g�^̇Սy͸��_�(��X��)viկGe8�	1�$
�V5J�"!Ƈ�XT�mp����?�J҉�y�3v	�k@d��s�
t�F�C����F_��S���L�:�������k=R�G�Y[��T�;�W5��B�9&uv    �0!H��BiN�mմ��km������W5�J>>�{I��5��#�����qb9�~}���l�։���	���!��k�-��U;�����%~:E�:AM
�|G*F��� �qs	�WX?껿�EO��,�PE%X%g��EY|vm�];����Ҁ�����AYVl��`�j�#���ړq$�[�A�zܕ�5�x
�Ss�$.u#Bx�*��������"�\����)��4N��4Ñl���Q�����=���������0O��D61��f�)��3A�ZdkQT�d�-��ز���rtV>h�jUt5�	�&������)��8[p�Sm�▴#;�����]���'��j�]���Gt���^�Ƨ:7BFa|���Ƨ��|^�B��$�t�ߏ+��me�"B����P0(,:�x�i�����h�a�o�=��LVT۔lK���Nѳ�>S��:�������ze�n6�9*X�Pc1��˻��]�5#_?�;#�� �/5>����Flut�<K��*5Z��v�?xr��0�sQ.s���bN�ʁ�s�z[w\V7�6�(#<|ަ��9�����/�Ev�p^�#����|���v ]���c��Ŗ��%&0f��d�
�x�Du�]hT�g( ךl4~��L��:���n;�s���dkV��xb� T�T��_�{�˓�~�|ǳ��Ov����/?n�3$b��U�>��C�/s:�[Sآ�_F*���[f|�HF��ƥz�wx���	�7�R�/�2A����.ҝ{�ء��{�Z��ZܕM!>B�v�w调H��`w�NGBp5�z��ʶ#�M/�m2�㍋mn��sN�X�ԮpG�PlGrlM8z�ZX�X;��'�n3�Z������V�����^	�G�zn�s1�Pe��(My^"���k�3_0�& �"��V���#��� +Y�,�8\s�+�p�-�חv���@��������6��Tm��_�Q�����y�� ̓WE&��J�ׯS�mUo��'n��I��֢��H�r_�`�y\c�����7�v#�B@I5R�m��Rb�h��BM9w��x�&[=�Q,ۏ 5����i����,>[�%��zp�4��Mo��^|~��X_ȡҐ-�s;U?��n{Ί����c�=��:_{�3O4��7��>��s�Hf˺��̪	,����l��6�� ����}������E/��z~�U�/���.	�\$i�U�@�8��ZB3w@w!1�J��{`Ȝ��b�;>����K�A���Y|6���\O��Z��xa5Y}��ԓ�S��k3�)�UPt���Π�'�-[��~����w�.�6�v�O���U9��\H�w&� .�Q�0�ć���!�#�V�;ܶ�qK;k�꼡���m+�_���d�F)��Ν�1b��\w��N�;!�S�M���L[jx�%ե8�:H2��A=�K�4� dJ��9m]+�N�2�t���e�`���@� =��6�f!/W�%��`ϐ�^���و;�J6
�O�n�O����|��0� ���!C�E��B��e������8���a���[�@��2�7ܳɭ��������X��%"��]�1n{l����9�����:�6�x���H�Ё�>�\���lm�]e�ٯ�~�v���[u�3��/ԙ�D7�ɱ1�I-7 �����{��G�D5@�T�b(��m���e�r��j�4J�j@g�א,�Q%]��XVѬ���7�WO7ε��-c�,ؑ���`)���;�Hf��o@��qo�}��x|�Q��2�nx���0x��{L1Q�<�ۛ�|_s��\�ҪV�;���׈�˂B��H���ç��,)kЃ�ci�ظR0��6��j+'Ҁ?81t?�n���
�)Z�����0���c�Av�Slݴ%fF��+ZE�eې*̚�жn@�U�L�r��mO���������zr��lM�������n��	$">�^��3�1|g��$����!�'W�0���p�	�l&b9saĮܚ�����Yz�eK���jm ���;���B�OE��i��X��� ^�Y8��w�A�NZ jRK�����:$���g�Q��L}w��z�j\OS�P,7Îi���	h5G���=S�7���l�kO���fw�a<��7
y�2�ȗ�z\�����$
������QԪ�=���̒�flD�^�!;C�U�:��&��>T�x��C���[��&*ٙ�v��|�fY|�,�w�:����E�;�!t�����w���(�$3P^t����޹�=+z����� �>Oxj�A��T��є��N�t�)�2*�
%�Cj
�2:�L[إa�NQ��#3z�ҏ7�J�0��ʕ�8��̔�����	֨RHɻ�iN��9��m��G���P�4�;}��@����������}s��}w��b�V9����;&�[ri�9����AD�v�uƈ��
����4��^2;�	;����{��PR]W����G�z�`�Z,�s��Y0'Av�����:�D��+4SW����5�w�iG�Ɇ�[>l��]�͜`,�w�qCb9��.�J�lf~Y#"W�
�(��2���1�U*�xg�,��H�O�$�r!�'���Y�c�ŀQ�|�h|z"����Κ�2��#̖�̖��-����-r*fǜMjW�x���H����|b�و!�gaS�)S��2�����3OC1�P��@T��:�*i`�E���7.�6��Jg{q���5��-ߕ�Zxm+U���"`�(ϻ����9�<�k�k4��W���I׹1�%���;&�[jJ�K��X���N_PPG�.%n� -蒴��6������T �ࢯ�l��6 ��E��mE��3��1�yӻ�t셙���˔u�S��ݰ���<��j}!���V��M�|��F��W����w���r�
�/E/�f�����K-di}
�/}�JO�/�f���?�C&�ys��j��9�\�v�:&�[0|�)�q+�a�ؗ�g2�M`����{̎NRy�@7�K��:!�8���*�b;��S�,E�u-��d�$o�@�������݋��xy����6/��gW�N".zCGI�໧՗��1].N��E��Zȗ
��<5�g��H0=������,x����l�������0\��Z���1ܔC�/������ �*�-�k�Km��2pJa�!�:b����F|xl���}��DZÑBL�j��>*���78�P��R���$գ�Q�oo���"������5O���93�2��G�Ե�8L|egS\"B��#<0�&Q��>`d?�f��U��6�M���,�%��}���nD�ZJ��=�[�IVrj��8%}�$�Ĭn!��S�P5$�ri��3�*���D��& ������j��,j��8�TE�%�'ĤOJ���QL �N�O�<��ȱ�늢H�b��STe�,x��+�֭Au�]���z��o@\>���g7�߉K9f��Ӊy�CG��t�$Iղ4_�V����3�ƞ+=�{����=�F��C�Z�$u�$�*v�9��*y'�Pqo,/D�i��V�� ������x����S�o���CO�ZdC�o���d�2�!T۲����}`7v�=Io����A��<�i`R��PbB�6'#���gy��m���s����>� �GB�Hͫ�g���o�J��鯐�:�'7�yr"9���A��:��J&�-��G���!B؃xѸᎫVu#�(]��ţr)p���@B�}\�,���Z�h����X벣(z�d�lp����**�S�>�.�g�rk�R��T1�K�,��	� �B}&���43@�X$��+��&��ѳ��<AN��@(5~"����$V1	͕�BA� O�}����5��z �P�1	ra٥��?A�'�dZܟ�
#n2/�ü��j� r:]z(<�b�``�^M2�<A���9,�K{�ѧ֘@G�����5P�ʠ"E\v���U���hy�hխ���ճ�Tr�V���7    up��S��F	��
I'A)~k���"�>�U3ӌ�X���VϱG�\��]�^�U6���ֳ)lDX�0�(h���:TH�ݯ	�`'5�J
I�;�� 1�ER������dg'��>eE��L�Ԋ�Qw:�ڐP��&Es��������%m5�՝z$�9�f�.].�j���@|sy���lh-��i����.H�"
��傭S�f^8K� ��(�A����F�O�,3EP�GV�:�̀��Gs���r3�8���3��E8[.�R�:M��DoH�:t8S%�Q/��d����U�qU2HG"���PC`,�����<RO4�2�V�$���b�4�Y�|��S�y~3>���;�X�C`E��³��g7���OK�w�Ϛ�K�q3�U� k�{M\���m��e��󐀋��&�_eft��Ҵ���C�] |�7�`����7������@c�{�k���!8���r���vS��ƥ�Lj�"��� G=����'C�2�DE8`�B��?�K-��{
�c�y8�{�C��$ �L"QQ��<��:�3Pr:I�3�24��L�0*�V�\�y�`99�h_*[�g�Co���̚�V�("�w�Kp��&�!�4�����퀊�=V'@ٙ���<1;���9����]{��/=Օ�u�q����l�2-T8��ǏQ��)�?C���Ԙ�k���D��:��{t�6�A(��q�_f�(@��h�h�m�Q�g��L�j�t����zᚐ��i.�;G�kK��9����U�s��� $iOD4���Q����"��>��,� ��Iz��m�|	��K�4@Ʊ#���!��p|�9��� �q����l�yg�F'��T(3l��7�F�b��0BV�1��N���W����HӴ�� �M�J*��TE�̢=�հ�\��������Q�'��J�ۚs�B������=h7����ӆ�#6]�y����e�bf��;�nX�����P?��s�����6bͫ�mraf#�f#�s���^6j�b���Β�~~\S�f	�7�\Bu,�φH�\�3��דPL�\O<`���T.2$0W��ec6����!)��A��f*ݵ?zO���we���^j,�*	u ��a���Y�ěn�?^ͦ_��]���t��ѓ
�$bן����Li�2@^n@��r�E�}���C���\�YS��U{^q\�/�)d�6J��+gF���(��a�2l��\*�����D�	v��q�)58kc~�BӘ;���6�����lTĹñL��Y�7��L%�aj���N�-P9�f��e�b	���8�R�i�n��w�}���Y�	��*�uLE$���7�Q��EZ������,�Ny��-5ln�3EtL`:�~�]{��a�|I�n�Wb61�����l��6�S��0��}����Ѓ�CJ�n�e��H�bf�̸��� d��J��g� �.y��;���?�#@0�bCL�BS�9Ĕ璆��K�������^T�zs�/��Y^�Y�ޮ~aH}/��X��9��J�i��
J��"9l�ś=p<D4�upt7w�H��'��}�����NZh٤A&l�t�Y�뿗�n4\�/)�u�9�ă#M�z��@�C�<ǘG�'Rk u]b`����$Pc���
9����8Aѹ�?h1z�)]f�";���(�tL�2-J�)�lE;��;������n�q����\�.���?��E�DnR5��㺳�a9���`u_p����������!���i��E�
�.���Q�! �c<�0C���I���;���#��T��G�5�*�Dj NoR��k��3BΓBx<z�b��]ǟ���v^b^Su��)2%�a�PA�Y;�/�?>9l^Y��αz�zh-�l���r�q(l���a���yPw��,g!�?��jb�p��$���냁���i�d��gFj���jUOK>�^RJ�g����)	���b��F)c�(��_����𠐂�g�Rþ�O��7A^��Kf=A:z�by��\e*�o��X�pT�dA*7K.ܔ�w�:��v�խ`������ '����Q���s���x�u�#p�,�ΤcqC�>D��X�+�JF?�u�ueMe4�AˠlB38r�;��/9��V����p��;
X�SXQ%���̕����K�K�	���[)�`�u���A���SIU��*�6�����fQ�/[�\�������~C�z����s���z��i��p_�{�"�0P�{����\���n2�;<���O����	5���P��0
P8�أ(�x��H�˟@�R{%�Q
O����O�J�]�ӚM-M�[P3��p���F�8(/���C���X�pR{J2YQ���*�U,��~�MhNó� �2MU�m��m�V-j�˴������}˪^]�]�-�ɮ���o#�*�J��CnXU�.Ң�$�Z@��eCr�C��e�m���w_����3!��"j.N���o*k0k0�h�n蝐��/����2:���g��/ȍ��Z_lׯc��D4a<m�O�o*h���ǆ��z?�ԃ1�*�f�h�.c��e*̨4�w�ɪ�L���T��'K�n���H�[�����wi�r���v{��0g6��'xM�qؕ_7�F*T4�Xm��;B�[ìih8
e���{�v������]�t�qg�<<k��h�]�O���g3�@�BGe!��%8[1B����� �.
��0��%�p��}\���v��K�����w8����}������S�m��lzk��^���v��%ۛ���g�`�F(C�C�Z�_�<9:�e�ɩ�¯`юHA�U��;`�Cd$�U�� �E�c<p�	U1�0���/NLY�<�Ȑ?������Lm^3���e�/�e`��	���#{�v���׺�l]���h���^$�,�dJ0 $�=�1�D���Ʌ�E)�N<�D���̘ �cF6ˢ��0?�(��,w���Z�W�[�rso��q��2m�#ZCQs ��o�6��,�k���J�N ��o_q>��!��>�5��_e\x�d��8Fi��K^�~���!8�hٯۙ�p��OB\y�[�	F�]��j��!/޻\0�<���Xʊ�9r��U�-UZZʦ��JQ��5��m8��YS��m&+�R�"�͈�@Fo-�4A�scfs�>�	���U ?��^wo�X5{��u��W��llo�Fگ�B��+}ķ>�U����x%�G�	�����AB8쭯p}�\63�N0D�(���^� r�����FϮ��	e��M�U*���a��Q��ЏP��:�KMÊeG7�\Vd�$�2�b]5���3�~\�5��W˭���`Y�������EH��D��lb~��^B.��y���v�RM=�x2C��{���������)�ʑMH�*-%̭����_��@l� C��Am5S'��|�qp*��m��A,�t����Gtd�b�� ��4�1˰5S1��a�R Y������et���g�j�O����R-���I`ՏOv��q��1�Y�^�1�l��O
���mX�_�y��A.z�++k8꼬���m��_0�!�c�YO8肼�
�}�n���@p�s���x�w7�<��	+��v�t�Ȁk�Z�����b1δ�3?�PM9�(�ٖ.iQ�3/�6�����3ǔ�)��:3�˅����Us'��Zp򻸞9�6!�R}���� 7��A�$L'�3m��1 �D8:v��[��n�Z��:��|�$�o�X�C��{^�Yp4�N� �lD8NiG�p���)��@�+ܢ�T�ȆB�����$�ԃ2��7/����AW>mD݈�B����*���'ӈ_Sv�d�Ӻ�T�SQm-I5ME�l��ǜ���ø�J����]��^,��z7����g�'w���I(�O����G����Z��,�h����1���zp�OY�68�\����� ��{�]6X�N���N�{5gO��x>%��s���Ct��Y�P�h�����(�����)�M�Ju�l    =�x�m���F�D���)»^`"Ôs5eC�Y�l�jʎn�����m�X�{������ڳ�F��i��L-��Y����#�S��u�th����,6�8uq��J��,O�J����E+T��BO�C�!��}��Ԗ�CŘ7�ۮ�\_0#S�Ȕ�g�$�t�.<�{�#���
�&�Hc۸%p&t㨎�Y��r����ZfA��	���|n���0NB�[M���A�ì�)�(�,[�����c��lD����F%��X�N兮�-H%����(Tʍ�$�,L��bo�]ԓ���[���#P!B�
�fJ8%����9�8��J񞦷�233(g0��J3�_���Z?P�.�l�؍y�3 ���>��|F�554�wn-�t�D?����a��ul��Pw�L����X'�8�$V�8�CIWMŔٱ�D�Z'da���8��޵CޢR�E53�s�]�_�t[�������j`瘐�e��Xs_�� �]���k����qq�o[�,�V�^`�6e�I�(�P����V�B�p�*��~�g�,�ΘZ��dje�F�����g8�S_B#�0����{BO�1O1��D�[v�U�Iv�t�ϳ�q�((QĈ&wjg�����b;�iCk�jp��R��<��x�{�e�w.���d�D����~��	�}*ן���O�
=��%��v�?���np�U�4�d[�[�F#;�����{!Ʌԯ��\����Nn������S.8>���B͞`�\�������%�>e48h�Ȓ�eg��Q�k���OJ3���<����^$�B�i�4߼(�\�,�(�O���e�i؟��pB�5[V$�>�awH1l�<?j�x��3U�v�._���S�o���1��r&]e��;dO�J�Ci2�����v��R�9�H��K�Ǻ�Z�h�:Y��UJ%�����\����H���d�M����j��9�D
�]C<��8޿RLyf⁧w&)�ؘ=�dn�����	�P
�݃�𢳼|��}��U��R��%PO��񇟾~����u�ʦ�<����W�E�V���6)H܊:C"�'S��1x ��{𾦽����+μf߶$��$�,ɤJa.YɵΪ��Ҧ�Ę��  ���Y�c����1�c^���UU7��$rQ�l��$�8agh�tԎ]���.��9R2Ga$�ZBl[���g�HI���H�s}�\�W�������u��*ߜ�hHj�C���l9L����8l��s�Է�������߼���悵��S�p!vzPg��{�V�c�e���8&��R�c�Y��"h���\����_�f"H�G�`�w.�"hS�����)� � ��U�:[p�@����>K2��f,ɰA٤&h[��jAK��H����{�퍓m㤹���5!A+��gn���wH��,�4��;>V&3��CzH�u	}LU����e�d�H�LX��J�c�·1��)�|C�#`��P	�м�#<����U0P���UiB�	R
Yv�R�O2�TV��i��]ݚ�@>@Uhu[�i]�ͫ��eIzl�֞/Bw�Ue�_���Pѳ���
��K�
Y�a0�O܏9v���� ��T������Ox ��1?��]�{S]Y���y]e��e�fم��C�2)DeCP��H������<{�2�����gc�Aj>3oԋ���[-��y̽T ��֊<��عR(� ES������H�bR�b�ҋ�(���`o�Ҏ�;���E����M�j�5��P&�s!��)��~�S?t���p��4ޭy�*�8�����m�e������r�/C�A����@�e�+.�{\����T�@�KK�=N�6`|�G(|Q����E�D
�':���c��uq$.�y�
�D	�
�u`=$jHc`"�(�8��L'T1���,e�:U�2A�oV/[����F��{�����$����Y�v��BŹ�m�q����0ǜG��i���Z�T��N�:�h�$R]�A�é�܄��̕����Z�zw#˩�݉r�j�pEIQ�t%q��Ƶ������zL��@��r8��g�s��R�y��<�S���]qɫ��.r�A�s	�+��ѷ��Ɇ���¨٩\f�I�l>n4� 5���Vu��@�9lĵt�1T�T����C~v��ѳ�U︽��zg�����T�Q������5��n�����p�d�u�f�5 Z|f�ak��CD����C6o�:��2��V�s�l��VBy%� {��C�O �)�0��n�~W��LM��L���!M.�/��T���TJ�x�U���
pl4�0�"����6�'^͘h)y�ۢj�3``��~�A&h�spɜZ"N�Oq��'GOZ��b�;>Q��~�)r�?�]�?�( �BC4t�r��?5���O1̧{�K�*vw����w7̫p����O?p�<X�+��B����2܏��DzD�$�"�w�=��;��H�΢���h6�oH,lF���oڈ��зp+-�v�� ����&Q#�QKk�ká��n�o�k��Vc"�Q�F4c�'�f w^��LK�1�6��S��~�̃Ʈ�N�B���{�i�3�����f1|���8��Y���؏[�*)�醭�d���gU.*��e���pu����6/�G�w�����Y�p]��ę� �I[(dɝD,ߤ"�be#K�RL1��=��̍^a�>~�Ř���m!���-�d�Zi���e��[�����$er�������F�C_�gz(� <7��3��[����d�<�Mء��Ξǃruh|#�x��U,�x�LdX�#<�4�c�eٗ�����gE6j�'��:
��lh��������Gj��O`R���YT�p
����$nK��}`2ℯ����������ɽ5�eԕ��>��@��XPX`��"��� ��Gu����Sk�ƙ��3S��TO����e�r� �[�Уj�;
Ŕ;Buԋd��X���=U�L�^߇~��h���O.UQ�	P7e!7�hJQ���@��?ﭝ���ӥ�h�Lws�e�:�T*�����H����1��%w��[R�͈�	PZ�;�]�a�/RG�Y�z�㢵>Wz@�2���Y�c4����5�=���=tE��w"�Ju��ҹ$�p���[��=ܫ�7���SƵ�"�\}�/<��Z U��K���M>��@$նo�VЗa����dd��v
�B���Ssp|�^�Σ�j�pq!�q
���1��e�<q�����A��8�����`�U�iP�̬�?A��'��},�tś2)ּ��0�,� S����v�t�	g�i�q�}`�e�i���c������9SE��T��c����Kȱ����� ���3�-�܎T��j �YW�kH���8*חjl\<�,�X'�t�6��xk)j�U3ۖ%Ց��)�8�%ۛ�sx�x�.�hg�ٌ=��5��:8#"6K��}W�J�H���A�K��]w6E�!�1v������q�$�4T{eG_J�a�����Q��O�z��������޶U�تM�j��R�d��c7�;�� )����2{�;���խ�=K Ħ�&�t�7���v���K�8N�����Я������gVm��rwvJ��S5Q�r�YK�N=�'�����e��Y|6*p"�J8��@��%0���~�KC�JB����MN�Ǽ**��L�7j%�yQ8�kVԅ����*_p.�_=ʊ	������y��q۫d�ɿ �t�<��ڐ�nqc���oH~����7���CQ����uU�6  ��j���|q�#�"	����w�N�Z��jȆ�#1ِ-�E��.>+Z��ړX?v����w�x���,��.��s% +"��#��� ȉ/VX��S(+�?ޟ���"Y�y���c@.��.�gɳB�<�j�ϡ
=Wz�7x/�45/\XM��o�e��;E&�sJ��WH�`�,��ͫs�oQ��Q�O?��� "�g^�;���(H <q��    �;�Hj� e�Psm3A
>c[I1?������lK�13R�!Lo��d;��~6�����A�l�l;p���e�:WʨC�H~`�H���6�*TB;������J������8�e	gH��B0Dhd��P��W���5m�P��"FY|F�������i�\g��"��DH;�i.��i�ځ��E+P*�����a�Z>�j���.K|�X"�.c��2j�QS�jͨ	�y����f
��L��e������߹��|�X�;�Ng�et � eGTW�������䎄�2���\Ha�/?�FZ��Ä�W�e��#Js��|�{X_YS�7�)q� *��|Ӯ0�޿��v�Z^��9�>�@ 0ޭo��c��.HmaF��A
pčTbu���O<�ĉAk�r���I�F�~.|������׎�x�w������`�٩^�@��V�k�F�<ql�p�Z ��ޖ0B�I˺�Ӏ��
���x1W�`��jJ׿g�(����0m��BUK���	v��Z���
I����D���|`7�%4[>���8F�C����`��d���8��j�Uqܚ�^Sٸ��I�n+��O3�U,��Ք����n��u�(W��I��5*��A0�Д"����櫄��HR�Vs������rMJ24"X���4!�V�VU�0���=o� �]���S]WY�`�h��_�E�A�J3��ˋw_u������c��)���&�+;U�]��-t�{d�8�-,�Oj�bQ�d��-�ɪ�U���x�PMI7��UM+h��v����O��j�����`�ˍ�[�
9X���@PQ�	c�#(�T^g�x�_����'����nPI:�ۮ��+_\HS^y⧻$��J�q����~��j�6gγ�F�n��l����9��e��3��=坥aQ�E����b��%m^��}��bs����Ŭ�}Ǜ��r�+� �����St��ɵ�R5�_�Ua�����B7
�o?	7ϢZ��ɳ�yq���W͉I���{(h^%qL�����)�=m| �h�~%?c��(�\��:� ہ\T//�>��fx��omJ�/k-��=��A5Ҹ�W�Pٔ�a��'�F��^,t�����dU���|AW$`�Ow�j�ԭ��k�:�ɷc����ޢ�]��E�u��ᒿ��K��U��8~|j�8�~|���E�Q���kdE�l���iv�7�\g~%e�����C�U�� 4���
���
�o�9�8������p�۴��FQY㣾��.���4��2�y�fN+�/�	l�����c*zŐf+�\$�'�^�>Þz��K�Š�G"n�����cu�=�E��e��5���=��<Y"�f1�����A�pz�eZ�!K�!�����VƩ�X�*��R�[K��be弒���kz��~���@��c��߻~�b4O�B6/Bu&�9�"���HmK!�6m�S���f�㒃Fd{�&�i�e�f���0�=�Vif?�F"X�|3�%��������T��<�K_�����vނ �[���^������F�Q��b���~���VO+ɹm4ㅥ�\q��=sTRa���VXLd���:M���H�Z�>�A:˿=9���р�"b��\駽�4GV�S�+P��X�P��B���e�F���y������K����8�A�( �=�H��p�(���CO�)��樬��^>��;�)>+�Zt�?~bjֺ��]�+���@�\��̖��oL�h�i�����U�������!l��K����⿘��ǰت�����Bȃ��鯸�匦(Mv9= T*��M�N�5uFy�u� GJ�ZH��&��Vꨂ�
��؃-�z�@c> �r�rb�}��8�0{䈟l�V������1G�!�iʰs�g�(¦iW��z�ϯ�ݭ�����}1���R �p���e&h����6�b͞�c��v&��I�l�|T�y'J9�{����1.tKp͹�Gu�����*2��SM)�/�6	W�ɥ=H�@:�z�نU!衅G����t\R8�����e2�<U6X�8=�zQ'�-�%��I�ԗ���w}b�TF����dY�)>�Z�ԃ�`<	�㳽��J���X��ֳ��"�G�jE:/H��NR,��0m'"#�S��i�q�>���
�hR,(5���u����\���Ƚ,����*f���vD�M)-��r��C�'���1����8!�9�q��a�Ԉ��z.(j�En�5�R1�j������rtf�@Ͳ���Ȇ�����5�O��zO����fw�;%J�F�*��]ܟ!�OA��q�ٲ�sL�pxB��;�	���P�N�OH>�2K�>�������C��K�_��
AS��q����F��B��5%�rܣ��A��{�L����C�U��z�u!��+��P�f[7|d'n�Ru�q�4�ԕ�@�C�3��ͦ}��mM�Db����8�G2TUaG�d���i���IE� ��O6���O�ݾ~喷- g,W�����o� �c&Ҟ��.qx`#�,��F�x��YH�#���}fK���o�Z�y�՘�o¶��� ;&섦����(d�h�˷/H��l��b�ز�\-���ߙۇg��z���e�S�u	f��)���qc�RY�X�:���;g��6,��l��)��OwN�v6���d����fg��e�K�����B��>-j�C�e�+�Z�L4UX,B�d5�yHl��71����Y��dG�n����$��"F�!JI��$�Gr���r��k��}��~&I�
mH����l�W��a�V�����G=�Q(���+4�w�A��O�t�(��FE�5�/��iާ$�U��p
ט0ye���.k
sYve�TM͒��d��,Y�#���]�cB������ͭ��١wu��2�ЌEX�*פ��������A�!��@�L�Ca�ϳ�����U@�VC�(`�z�.�R�J���q�f��'�cӜ�Ќ�q�d�H+�"!�)�Y�q�����2�BD��%�'�� pJX���](l������]A��/0�갡Z�/�Y|�Ԣ��fw���|R������+�l_,��o�=� ��Ť�� R^BȜ�+������#�D�&�(�T>��K[��TӒ�4�>���kie�ٝy��zv�A)4�t��n�{�tų���ك9���p>�9@`�x^�����d��o����A�2K7���N6��3kL��R�َ*>�_*���ډZ?>���٭�y�"{�ǣ����5}�"`��T�򪔃л��.>+1��7����FM�F�.����+�K|�Oue�`$2�`��P	�Y����.�P�+��C��߂�"��3�d�� E���;��-��Й�;ت��G���x�!L�Xl�a'���1��3S����0mU3LIST5�l���N�˞�Տ��^>���E�2���o�e��mal9%D��,����'�I�:�������E(�Nt�Z�����%��R������`�++�D0�6�ع�!.4�8_��r�X�hDDq!@p�-�}�&@���FC����Q
�K;!u�CVPs�o��
Fp�D��`RP1'DUEl�ZT�`����,�3��pO�-�Bv��씑4�:f�]8?����W̅��ٓˠ~���ɨ�<t���:�D���U��Ƿ�a� ��h�t�/8�N�O9A�-�@J�nv�s���1�!��S���卤B�R�h��М�:5	��͋6ZX��s�j��T,O�q}�7��g �_CҖ<�a��#�TB�I��f5���bg����Zj2�+TmYX�b+�d��~6�zh���'a��xp��+'��ɞ�td���،P
5�<��!���K���7��&&��84P��p6i�ޞ�����������<�ۘ�:�j����aG�F�	]�{�{��LF-�o�̥7%���Q�6�B�gLc@����<O彈��o�    	]�|4oZ�i(��+"n�d]+͟T=�a�B��0;�6�rRn�"_d
��R'��b�ӨӪ����� ��Uys��h���"';1��̕~�KMsadw~e�e��;?�V4�t�E�����(?	AU�}U���M���4�ƺWA:�c�ųS)�9QhF���F�I��5����W�h�돘�4*|�Y�X�b����vQ%���i��d��79�\�K+�HW
I,�B��O��:�b�����0E�\:�SYnحӸA: y�a�/����^���:��nD.��DzƟ����!W*'	q}��#�\�X���Vpj�֡l����~CWF����L�M�j�0�L85�ԃw���z�s��	��qYL�C���
����_TÂ�V��2c�f��e�8���5ì)���N���6[r,EK?�E;�mۓ�����r��y��YX3Gw���/z�r$�@���bH-�MP�d3�-<>o��4��9�D��������g�Ym	jǟ��pq����`C����`�b>
�C�-��j��g0�J� Bװ�9ľ-���c_��gΌ
���e>+�{� �Z[teU
�2<p�J���}ǻ����e�W�\��1oD54I�y�}֔�i���%�?^�X~��x�F������(S���!�����5���K
L��
�����Nګ�+��H����TC�S�:�Am��(�	���ngJ�,{fi�u���,��t�����W�
��6��;,���J8�#��Q�׍��LfA�1�D}^���z/A&>���óر��rM�h���IC�Ml�;�>[F��KZY�[==�׫�Q�|�±��͑�T?�y� �b?r�"@��� �����{N�H}���{��돰�q�r���yp�ӕ@k`����{�+k7��̫�m��_���@��;��o�w�!@a\$.P͌Oc�;��zt��y�^�n$R�1�{6q�������%CWe�YՊ� {Ͻ�)��r���/<6k���d%�7�B�+Q�D�r��-ܽQ�I���?b�N��@Aq�g�h����͕>�ŧ�zҕl" `��d����	 ���FIQ�bZ[$��Z16h�)�䚳DZMH��}R1t�d�oS.�w�����:�3���lٓZ�]T�eZW�Ȉ�G�5҈�W���#�%��MAN����[\i�w�v�.Y��X��W7]�u7�qEˀM�╣U�Xk��Y�P[%�F/��c�;�ξ=�<��������8�T%ǔ��@�`�����;.�G2�p�(��<�($U
���g�H�kS�P͓�YY�	6p�W"|4��Q� u�'1%�x��R-� [bo����V�R��E������I�����w����ԥM� ���rW�B�dH��H�&�b�\>��֜�T�ΰ���`�r�@ �����:`?�����҅�Ïn�j�S���,� �������c�@Jw(1`�ov {���taml���a������C�Uz���XU)R�|�	��+���4Y�t˲��&����ꦦ�m���+�?]�tY�
�}�Uw��{��O��%�q���s��Pဳ)Bo5qVc͐"�!�u$8�З&���l�)�Lx<�/�>6�IÐV޷)	6g�oA�sVD�P�!&���V��f3�'�#$�,�`��@wJ�7����5�o ��
����Ӏ�����z\�#��]6��|����C��ڢ��;���Z[/ȃw�+Ld�ڍ�j@�d2?]|6���n�4������T/���|�$˴u ���/�<1�i�D3h�"	0V����2�	��
�'��� k�k &�t�1�ݹ�ý�{[�YS��5g^�}҉/���`%��u}1IR�"�k�"4���/��ވ��Ǌ��-�D��(�~/
�U�e�����,�}�'�z�	�}DE5L�r��YD�꺡Z0���U϶���k.V��ں2�G��~b��n������z�ÙJ]x�vk*�O;�{T�i1�[Ce>�<:U��+�>��@��"R�)^�=P϶�����C����jN�R�~[øE>�he�,!3%m�18����L��P	�H�҅�n��1B�"�=p���T¦G���i��:��y�	G�8����ȦʎA�4�ϖR��nc����-�����J�{5F��%OG�yЂ���9C��s2��	S�W,��C)�W'N���l����+��ǂ*ʿ@>�T�AG��T_�(������Wm��X ����͆%�~�/��~a��5v�����%PoRbj��� P{c?Y���r�nŴ=TK�;N$����l,S���w9쬪Us��i�5SU�Ʀ+��Z�.�,ܓLM7��'�VQɌ'Ok�G�z��?�6z�����������ݍ���9"��S�A��� 3u��N싘��g�ʩ����썉\�� ��.1��r�����!��+��>��`%��0����w�k��y�럃�G�f{�q韉GC��F���k,ҽ�՘G`�g��^^D��������n�m���8�pX��0���F�ȘdH����[�������z���#,v�LG2m��(�l�f�vsy��ܱO}g�r����_ZO7���<�aH��E��?PR�k�� _c8mlh��^R��-\ޭA���q-��Q��s8!��?��1�K������=չm(�0BFziƐY�`�����_&\v���\�,���yCk 
�5B;	�U�ϢRŝ� V����Oh����g(�d�R��5Y�ނ!oCQD�ĉ�J���<M��̍=��r1ʥ��^�3S�<U�_!���ğˍ�Wl�F-1���/�Lt�%Ҕ|˥�įW�o�P@�N�qY��Q�B��Gp��^��]�����B-�/��Ra�C8��>.�����a����͔��S�����/1F	� +�X�N�S�4]g!�e�'�`<�RG�	8"�����;�?a8E瓡붦�gخ��JEs*�*��H��a��ij��;�k����g��g��ύ�Apgϧ�#�p�'�9�����FQ>�~�5�� �"��$M�Q_^��g�dɀ,��Q�nX���vPn�F�C��{Z�YӲ��>´�`Z�0@��DZ�^(�DvC���^CUԨ�p�+X�@'{��Y܊(�R�ը!�K�XlD�mq���H֊�G�u��,KytP̘W�u��ˎ����j�gS/x�m\Y��a{ga�؉�/��_�$r�� �^$�9��ƈ$�c�I�+�GB����ZZ����?���GU�r ����Y�[����7�2C�;�$�'>���E�5ÑJN�@'4�aQ^'�([` #>p�`��CQK��w��@F���e�0%� T����ijA8�D�Nhh����غ�H�cⳡ�Ϭ�#���������V��m[�����0���yR�om�0����"y��<f����˵^�cPxy����x!�q�+=����bJ��ٺQ�d�,� [ �a�7�"����
Wlb�6l2�!�����2<n��@A�b�"�/&�vˆn�}�'�0����5�b��ȼlY��Ⱥ�Z����Fѓ���i�Tuyq��b�X;����G#�㜖��"�u9�\�5@	� ����r�O���Y�����F�B� kz`�3���1��Du��%�3ea8���|�4| ��Q6��ۑ�2g��˕����oٶ�f|o	.����r�>T�C5��<��)hj��ҝ�0qbBUe�eMSIU,'�lE�^E����Rx�+�yg�U�.�Q�u {;��<[r� p�˄��0'ş�r*N4@���J�g�8��
���R&�wئ�k��k��o��k�X|�[��5�5(u^A����`P��0e����xj�,���d����"'�QW	�&�qV�P$'��_)��p؉e$]��ya��q�Lf�ST-#�<~�8�^�?{��\p�����L;�����dKe�e��91û�%�`��s���iQ��    
i jl�;�(=����
�Z�h�!%K8d��TJ�����[_�M�J� ��Xb{���������S����ɘ��f|�'ödJ��>>p��b(pb��8���Q����:��d$R5y�;���E����޾v���wN��`�p�h$�(���c;����.V.VA��xN�4?��D=���v��IA�{�6�"��y�/\4�=cG�\����}-�Ԕ�q��r�?� ������O(w���@����b󖛑�[�;�s�H*� Ȁ�r:V��1��	��	�Y��\����R.Y`96s�IWI%>�G�d��ӳց��[���2��ݽ�V>Y��w��[@���g�K�� le3_b"���RRTv~���3*"� �������s���J���_L��2��)3��
��b�83d g�!�u0Sn%�v��Q�^D`:���;�ID��ʶEԷҋ����<$�!�3�b�0���F+a.t�k=�Z��$�kv��Y#��nH��X�B0dS/
�Y>��z��V��-�H�ƛg#	�ױmUȄ��,I�^:&�9����^`1-�� ��pXe�ˠ�����<�o��C�n���M�����v��]�Y�cΝ6��$���0?A��W��O,BI�EF�2�Ỏ`���0��	@7"�g�=�^��Zt�;e�*�]sϬ�k��h�iʒ����liE!�ё��%u+ՅƳ�����پ>ʌ��H8�`I+$B�Y��G�@�|7@9��p� �h��E�fn�*Y�b"+�-v�cV�X�č�q%eW��V�m�6[��X�>0�L�T�)�����-���ٓp�2�?ΖQ���c�n<:4_��A�%C/��I����p��i�}�I�������@���S2T����j�^����n&�gG�Ŷuֵ�^mmTbMLO��
��A0���:�Q�}�CS�f�5�_�������9�
�^R�L� �r��c��o�n
��7Wz�w8�U�������ApӼ�D�z�W)��A��K�����6��I]`exn"���֭^r%$1�]!JO�i�Iѳ'Ԋ%�p��-���nڦ�A��fQ>�#{�I�����-k������}M�h$�*����4S��i쩌��x̙ �����2�)�9�܈ePŅ�Y܇a@v[$�������_a���`�2oܠ�����,��
�E���Fz�?��+ �/z�t�S�_b���3�����O<iyK�E�<c�$	(�N4�G�c��٦f:�\�-�1]�>3�J����!Yls��'��Ɉ#O��-[O������&�7��/�f��MyDa��<pZ��^%�h�1	����Z'�z/<.���i�|�q�s�j니�F��)�SJ�r�9��?����j��H�9'2c´K�	uC7��,7�����(IMn4g�Boz�P~�kP�c�j��A0�g�'���'�.Q�Y�e]�5M�Q��4U�U��-�h�|�?������S�ݭ/nU:�G;�>v��xd���3�l ���}3��.ށL8l��P)'̥vQK��g�S��%��,p5��MwU��c��+;kW&�(L�����\/����X�RP��V1�)�4S���swa��L���Ë`f܉� �m]����B���J:Չhea���%���O�b ��^mb?T���D������f5Vw�������z�^���~_׼�H~YHcW`'B�yf����\�fDo_�S��>��h���v��%rd_��h�6�2��X�~�_/�V�j��-R���3�<$��7��XA���q�o�� �̥�:�s9o��W�D��K��"tL�D����Z�W�� �~Ԁ��=e�.�,HI8Ѡ���H��l�H�Ͷٖ4��j�^4`�/>_ ���J�g+u}k�5�D��v&;���s0��g�V��a\E�&1�����$t�
�M��SC@���	ܽ0mtm^�
�J�^���Rs�y��Xe��?�|XI))��#�?	׼�{i=pC�:#l�Jp	�&��qQ��P!�3�V%��v)ᅐt�})e�2u]+h1�;��h���n������RK�I�UM'4�'�h	:|��|�6��K��UT��~�퉠(rS5����L8]��x�!�(<�QV`��+�,�Y�>Z:�4�0�P�:Ėo��u$\�]��'X �d����e1�G6�{5 �Zd���?�۟�F��`��<��(�irY|֩�t�N���� |p����]��Rs�2������w`��m�+u\d�jDm	����<�>�`��P<J1��;>�J��[clT��l�$4T,��M�4��a��Y_:
��y�R=���Xdhu�,�����S�Ь��=�.X�zI8u/E�_�D��D���"�-�2�/�w����w��'v��௙�MC o ��C��'��}xL5��{��@���J����>"k�#�S�m���c����6ĩ ����RX=�@��ڸ���!j���_0w�e4�TY	 Y��ZǬ�/���.�"�fE�`JA*�;_`�3Yuŉb��(�nk���'f��5 ٲ�I���'��]U���������]_������r�;YbE��O.�/�J��%����xl�O[z��4� t�2!߹\�w1
�#��#pD�d�d���u$�@u �cǜv�Qu��PU�b��c��R
�"�=S�'igD'��`,�E㪂�H�G����k�wS��i�r�]��Ƃ���V����F��O��un��m����~��V ��X7����i�ϣ�V�[���m-��������<�c����P���o!�Y��A�>n�EQ(!��'�&���­��Ѓr�QX�oʬM��S�w1ݨ(��,zs=�����^�kja������&�.�/��l4=Խ�"�<1ONłT�k$����?�F�	�^�i1i��"Ȁy�H��v��t�1���Fl�i<�#6B+�G]v�J�U����;X$Mut����^d_vk��}�ly��ٚ���\�YSZh�[���Z��w|����,FZ���Z��!0����*WV|�%{��ƓY��h`'	5	R1��>4�)���9�s���&����1�s#됅u8h6���ي��#*��`�5C��`���(Pⷀ���n,�"ΥCE�*sE٭��U�{���J�P�6�T��Z�tٞ��"��k�l�a�"]J�l�f9X�c���hEO�c#\�����9WU�Z��Y0�:�pf˺�5������"����'lG�{�������H������=t�)_���e����|%R14Ekˁ��▛�EO�mNc5���h����֯��C���'�����h��65��۠�dD������8~�F�ҁtI���= �l-��T���@��5���N���4�1Q�c?�4�p���j�B��z4lM�l�QLY|��a�t�m���U��n�,����E�O)�X�e��gW4ߞ�
 �D\��6��*tg�GN/�(͞���@���|����qag�vd��v����[G�Y�-�\��E�	� ��}��svW���j��qv�}ȡ"�)��
�S-rDj!����r���G��"��Eh\�C,-^��{�!`�54U�fi˖S�,�Z����P����๻�q^��0Zr�ZT�^�/_t���n�Cػ�둛��aq
�.`]bG��� ��f�x�S٠�����qv4�$��_/yQ��B'��P�G�5E���F�#L}�����h�Ji���s���~X>v[>0�J��!�xv�u�Ek&Q�w;��)ƕ��8.$�@�Ƅ�O�6�T�тH�i\cB��Fo��4n����dئ��"¢lTG�O�����u�-��u��;�f�T1?�GP2bFfs��{���E�XQg���;��Pʚ�)�=�7�<���3s���������B���8�E#�Ӡ~�l�Km#V���N	�'D���/�ǚYL��8�!An��"�Љ���������4[��    ��8eG��E�����np�R�?q��ۋ́�]��ןP�x��@���Q��K�������w�ب���.���8T�d�3�%�"����4i(������7w�������`��a���fik�R�i���Mȥ�B��X�+BLHT�lwH����p �j�X �e�L]��%:&yB�����
|���鎦,\���Yԁz�#˨�P�Y���y縻�F��6������e5kO;?��Jb�e�]�	�U	x���)X�!g��8s~@*ru�C֚��6���Ճ\AX���	?�z��d ��?#'���8Ԍ@���r��M}m�+��9�X�*��TzY�d��^l�֯!q�6���Cwl�������3(/5�s��뷒�����p�q�!��]�
��)vHP��GcB���d�+�ɞ�-�}c��(F�;�+MX�UxU��l9��#K��C,�*�Ų��{�����F'xl>q����뎕5�����@HQ��_�T=.�_��Ds:�8�](
���3L��P���'*��I�$$L:��O�h���3����%U{dΕ��<ǽ��l�zdO+Ԫ͡ki`�a���C����>�.$��4�A)�pm+I'*+�����؉��=���t�!u8���I1�Rjl@	�B`�e�[uM]��y�w��kf^=8�cl9�*��/-Xw,ٖ@L|�������'�m��k<^�o��O�r�r�kN:�+C�MR�wV-MKY��|I�9e�|G��QI�����am��]p%ME��lf���B(Z��hD��Dp�}>`������γ�a�z�|�`�&���0��!�*j���Q1{D��C^T't�A��s�]@6�?�3)2ۗ���4b�Q��X4���cNt�Z��]����#1/�׿5��H�a)�g����/�ۃ˵gQZ�����G;{yH���޻�6�]��_A4��n@t�~�������.������@Q�DK$e��-�s�� $��A����ө$��Igt5�������/y�Zko�tIZew�}^ ��Lks�{����Y�����bG�^B
1�/�>/� X٢*&�0�_)����q�o���.>_? X�o~��S{Z@L{���޴k����`�}��I�o�k�oȱf������$�~�o���P]!��.[t�V$~�Wg:i~?�0d�߈��7Ug���,|G6���˵����r�$���<WO��m�����-�>	g� 2����>\���Hl���s�4��$ǉ�K��P���!��O\�6t)�1�K�]���1����\����ͥ�(��$V9{~v{�fm�/9���ٮ/-A�觱���s��Ģ���h��8��^Нڳ���V[�$C�Ǫ8vbA�3D�X��|f�R	q<n�VӒ۹ˌ��w�泮*�#��e�5yh������"��*��j�ʘ��y���^���K+�hGk��k|�[XK�I�
Qހ2j�3BS/ş_��r�P���Z�'�@
�L�{A <Ԍ�(�;O6�pI
2#��iߩ��.͙W'�kx4�U[��G�������f1��c�8X��ް��F�2@�E��V��7�2��f�o�<{Ͱ�P�6���T�
@L�g�CHZ���m�k��RL���q�����-��@�`��T6��'������ƶ��x�4��#�ym ���8��(j��D�ԑ����R3�G��:��Z�A���0��a��߃����Ē���%����e�����[�k�h���H� ڈxH��Y"�	v�z���SvQ��q��s�[{+�N��46g�BB��֔C�c���+��<���ј��ډz�0��GZ
t:r��g���4&+�᳅���bK���/����$�%��o�!8��*4��甎y�]�?`7L�����<�K�q6�ϋ�Y�c�e�8���@C�I���,|o�v��XV*ŝ7�IJ���*�S��\-���c�x|Q44'ہ6��಑t�^{�c�3Xb�!z�F�!����t�� ���"6�o0�9j���:�j;�nk�ch�',Ֆ���ڊ�0ښ]���\.?yr��e�qdE[�W��/do��V=������R�s|u���cW`��F.�i�.�����dȩ���~�v�&{W2|M%�yS���pT�`�nm��w�g��anrЇ�Kx䟒��A�~aOz@����<�g�4�2bCʗ��lƀ�2����ɞ�������e�Ӹo���#��n��@��t��W�m�`������ml.e����j)������t}� �s��Aj7Ɏ���	���-�m���xA�W��l�lxyp��t�VߋD��@B.��Gs����{�c6N�`S����A� J���B�G��n9{U��>Ɉ��F���H�X7���:�PL�`��7k�3�M�5Q�l+�ַ��8U�7������Ov�T�
��A1ZI/��rC�),��˰+�:�j�+l1DJ9cY0����׉Z��\�b̡���I}[J
�x�1�S���߳�%����� j͢J��m�Q�ӐLe�6 �ʈboI�@!3o3�g�M��T;��vG�y��k�����P��~��%��2��TmE1,W9c]�M�T5WvL��sͪ��Dn�_.����R�l5ag�B�*��?�P��Z��:���c�=q��ԋ�ҥ	V� �Cʉ/�ߓTa��܆��Д�* ��8:�&�t�:/S�x"_h
���,A��������M�ɬi�L��@�@u=� `>'ϑ�C��~�2���IwZM��bGC�d���p46��|`��F��[Վ�Yǝ���Φ�mj��^�o:�e{MEs5f�Y��؎����],�U��N3����Vv�f�Nvֵu��lo[�<D��ρ)�C��Q9���/C���Ά��BT �HwЃ���`m�@Zj������n7;�G�q����Y�A"1�VIz��~��\�F{^��	�~�{��j5��Hc�n�h��c�Ń���Mbh1�����j�&ٴ����i����<%L�+�[�&�א)��r3�RY��n��Hbʹ�T\5�����h]���o�����.��6׌�U���%��o~����I �6��}��R��uɬ�����ǯÙ��ٟ�W��ǟ�x�|N�;*8I�`����W��Ƙ�M�]R{�v?f��RW�� �o���8�,:���s ��M�&�21�,lW%ZZ���&B�V��|O�o	齜T�	�)⮆	�F���0�܀�U�Vӧ[��Lf�aBy��Y��F�İ=�GՑ5��e�5��Ќ���������ց���\�J���'O��rL����U>�K��3��q��v����)m2G�.�pl��)�%�=�,�W��D�4�UT��'눐��^�`���ʫ�IgX��ߗ�ޥ��ڤ�Fm�6�
� 7-lE��F�/1g/��l��`o����H�ȨG)���k;Y��5�V��؎b2w̵,Sw�b�i��y.vUvu�#�5�֪��ۏ��㭇Qt��n�>T./�2C��W�����Y��K;p؄I�w>��
DxD"�q4N����]��ӡ.8�G�L���Q��f«�3�0\07U.���ނ\�QZS�+�C
d�L��J������6X���Ŵ�MS����pf�0�&���F����t@�2�7lr��˓c�c��cۺ&��Jp{خ�W��)=�j�w���{���`��:��_3?������q��� E����3���ǽ��O3"��I�[Ya��u�P)i�2g�/�i�Bvr�����1{�7�{��'��Y(3Hˬ�2r� �5���������]@mAL�=��@C���F�|��	�S�*��v�n��V�CH��0EB�j��N��t�'��فm;z�h6���Í�e���Lb!�w�R��{��R׵���||D�Ëͬ�A�*髓�K�#ق�OEإ�YG$�� ٿ?d�AE������Ѡ)�n�W��u�)�D�U�P-��vҏ�8����)߅��S�?;WLM    !ŴkԀ�K���Kd�`���>��&V�Y<M�����}��=�=h�8���Lq��39��f���LH�1]ה?Pu�t��ڞ}"[��˖���SSm�j�d�[ɞ�Bu�������G�fpt^J��K���9�7�z��AXK�hh��׃l*!��GW_���T	����*���O+��5@l����o�h�&�T*�#�0��@~�e`���H�/�*a����'�<�w��nOn��i*�S[=B���3+Rp0�	�))�B�bDV��&�.Cѫ��2�Lj�yA�n�{��z`�S�܏se��y�����W�R�z�V�V�PD~+\���WǩZDW�o3�#!n��@�kz��Ö���i0Y�ꢍ5I`xy�d�N��D�g��E��J6!Dȹ��f���&Lo�v��2Wf���R
M����)�P!�N����Ǧ���K����7%�W�����F�����Ǫ�1�`�2��|^Jf�L����H�)��jU�Å�l��ɖ�u�v�Qw5X\_(Y�ŀ=�34�%�-��BD�F�-�M�L����sk�gb��.Rxy�		99�<��y�l9�N�T]2W{?g5�\�˩A ^ѯ	:\�����[[��:�i�7/=j�Fm+���<*GY��Z$9�+�1�
(�)O����
�3�#� �}�����(���3b���hU�ع�;͘if7�-G���a۲�Xyy��V<��O:[F{ǒW���������P�Ǘ���v�0�'�bS� [��a�, Z�0B��=��:3@��.M����J;{�ǄB�B�Dtu�º�-1��ZN���<���;^����=xS[�ݢ�]ˁ��;1`��q�QL� �3Է��������J� d :[��E�z�[i��m@|����.��`�!uȸ ]�!����[�6� �Y������̳)�#�dJ%��^s��z�BVƑ5v�[���<Ԡ�UO^f��e�u����xk��vr�<[>�|��t�hK�ד��t#iǃ$.�c�N�� �}B���|����a�ؙ�{(G�L����Q���xLkR�.%'n�J��2�,��M�{�<w�e��P�5}�q�`70h7PkO:}/�,���"Z ��2�N�fVW�A���g���2�+8��mʳft� ��@���P����v�f���A�QxՀ �r���Y��Ag$R��aʎf�3ۀ�r��ì�<n�k��xtb*���q	[]O��bDi���=������L]�&.0���EƏß�\�wZ:��c���S&��%�p�w)�emՔyc����V��U�m��3ߡ�-�ͮ���냎�58��v=p�!h v�������x��I!.�i{����w3�~������ذ����K=?�����V���ޝf�Xq3lR]U�d3������T���f0ZI/���{��r4P��I�� |E.��'ғ��s9���LP�A5[B��1�`lk�By����˺����sfA;E|���bi��I&��Z|���w~��|��}�1F�W&T����i�^��?�,`o-�4.����!δ��1��,��db!��mB�	I���[�CJ5}��g�Ʌ�]aB�Ƴm{��ka��v�����"[�-�;5US�V�>YY9>���S����ϟ.��Aц��0�DNY~Ĕ�A���W���2�L�'ٕ�q�/ �AmI�q`�~07Mlޓ�ݾd^�������/��˨�����p? �XR�#O�q�iS��g���;�z�/�z�p0.� �S� (.�bH��Lk��Mh<����Q��v�2����QMw,����Y�*�l�m��R����$,l,�z��q�x���QQ�6B��N���2�1����agҵ�����+�"Pg��W�'����Xd�����Q^�Ls�{=�;�������/�;��f���C�������8L�)���?`�A�u-]b�+���f�{A�R�Ru��3
^�g�ޮ9��B3Dbרvz��M���[3t}w�]9���'lZ�c��n�s���Z5���J��ǩn����{{�@x���r�EHx����k����I���kL˰�{c��Ki�y1Ÿ80C):�_�0�ޕ�(�X���yޥuT�W�yu�)�/�����Vm���%`W<�6����Nz� �?3A�b�̈���M����9K�~��r����R9f����?�'�Ұ<	]Mgo�f�G6TH�,VTŕ��eؠ�&�*i��WMbٮ���a#X>�lO^v7Z�r.���+L��D��<9^z��<+T��H��K4?�S"m0k��Gb������A��$+S�a� ��_ߍ��64���A=���_`{���`�KB^�E�a��P&��E|�r=8�߁��ll�D{H�, �*��-x��3v6�O�fk��mf�t|y<��ؚ"� � *�b������������[[G�O�G���1�4wK$H���QrA�G�&7#i-��RP��� �/ o
��Tv�,.?$Z�%=.E��7B���d�Vx���̛�R��TM~TS%�tH5w3���1��S)Ʌ!�Blc�>�����݋ot�;+oy��h���C�
@`<������'�Qa54�m�gF-u#[sE��Ԇ�0�:�\����,��V�x��u�γ������#P�j��t&���=��z�U�8���]#����'����a���y�!ׁ꒔�qa72�]��Ca�v?fy�[�Ler{~4S���.�2`�+���Jktȧ9�lg�bo�8���R*�yx�wgh�~lTH��.&H�Gt��T�Pڶ[��rt���u<ԕ��Er�^��{G��孳�D�M� ���7hH�EH������;w��&z]�O-K�]��>z)B�����U��4���ǺA&�?�������"�v�6ys�6�yE��FTQ d�-pF郥���3� �e켦N4N��3�LSjO�z�:�����1AP��x��
�l� ��[cP���� � �u�����E]�ڑ6˘3�-;��FZ�b˶�8�]9��҈�֎�w���Um��|x�����ʳgY�W۾������'un{�6����B�������q���]�ѹA�m���7/�����QK1	���؜�g��;'RA'�!�dp��<����G�E�V��|G{b�\ �5Ho��A;�1D�g)
��7!���������O��zNI�;��h؜:��=������E�n��
fyU���頡ծ�ɦ�h6�]U-P�iX���'��k�*?������Mu�tm�8�:�|�<�V�������w zఱ)�
��?��)����)�TI���Qa=���IH�5e���Ξ�>H�?f�����D���A�Dk����L��嵜r�Ra3.��͚	Z�� ^}g64y����!�W�IaO�m���
�_��F�"�^܂�rI0y#�r#U���Z�m�qgt��4����J7����U��N^ɍ�K?�SvӞ{|з�{��+��#vD�ϓ�пg�DzhU��W�Ǫ��3�iʔSW����ߧW����O��埱�n,��܂C��΄5�K��F��X*(���p�վ3r��}�����9�(�Eʩז�p˿z�sxِ̅���ǣ�P�ү2i�?�,-]�B��2�{J_ɞVԔa�(e�/���C�D,��qߡ����<ie10s�#V�Y���̨�So�̳e'�.��+4�Tͪ�������|��j����e;i���������䯉]Zܔ�p�:"���b�v i!@�y��Q��%��|�j�MЎ!L[�iJ�ñ�x�w*��ԉ=���h�4ڨm�r�����6>��6�H. v�h��[΋x������Ω�0@6偻�њ����FȰy��
f��[gO�&E;�`5<v�Y�Ǯ��v����]U���mۖ����-�PdSS]�v�W75�*����ݳ������:    �?:?�����"-���J��l4�$�*W���+]>�E�3��C�z�M^m�>�a"3͉[�J�B�A����w1w?�<��]\{�6W�n=�]k�5��2�NS��8������D*X/�$
`aN��FN����FR?�v�ca!<�mKSlqNx�����`O�d݀�2z!�!U��)N�����eF��Ϸ,Em���6��Y^x��c��l��N7�YUQ�=�ե�,=>;\���g��5��B	я�slM��'����}�'�&�x �����
Fg��@cN�1V��F�B&���	�><@'�F�y��!��(}L���w��R�4k^����`GpiG��\��r�
Y�>|4 {�c��r��ZM�k6s���r��}0���X"x0DN'����mgwFo6ղ���{�P!إ� /ږl g��X9��aﻚ������`���(,�}G?�}|=���ћ_�2g�x�s���*�����U� <7��Ĉӧu��oƋ��mA�N�!�կ���էQ�(bR��hJ�$H�%�0߱G�e�/��4f�O��L����/��g>��g�ߌLa��f>�Lٸ�>R ��G;܂w7C�����j�zV�h�6o7�V�x�y��0�UM��0�l�:0�;���K�"4��meu������88����Kϋ6�~~���'z�Y~P��9��Q�玨�2/���wt���`�TࠦH�i7���w�)��(��	�
o���*�Nm� h�|Q(�j�f˷����������U�)�;v����iy�F<.�bO����$#�ZN�����'�����j��t�^��έzM�ܪQ'[�ճ�{�f���n��n�cNP�
�H���iS'�O�U&ϲ�
��:*��K(���ں�������������G_��X�Q��>��I0/F����=��KpYO���F��Fzꒋ�h߂(�r~���	 ��|@�|�J���r�>����D5�1�$��P�W*�/�����uǨ�m�qgR;�c�9���4��h9�:ܶ�k��N���������>>yx^���rF�.���/ K�$�k[(�	��nj��8�5�#��,��79.���J7��zX��,���%G�S�� ,�{3�[β�)��h7��4��j��T̶k�a�����Z�xx�d����&��I�A&�pEr�<�0�O؀2}�R6c_>C>-�N��\��.{C��jJ�.c�x�O�8��~0�l]1M�8�R�Y7Ѧ�Q�����ۻ-ӕxi�Q1�������*�sj���j�?A ��s%���z���력e�e/0��ߧfJ`�i���@f����/��P�:W����j�f� V8ǲЃZ�%��{8�;��ѫ����a��G��� �"��g[@��R����������`�O�QC�k�EJ�g��Q���a7��ř��s�@����[̚]�Rn�����GӒ]۴��vը�l�vζ��C7X=�=���g����@�t+C��[^���I0s�}��S�[���+F��o뼈-L�0�.�s�o�9���4��G��:��r�I7'*.� �kp�uk��7-������_$���2A�p�f�6�@TK�N�^�ԇ1e��:��0,��Az�g�SU4H�����k�'�dj';�=�@�SU	���Ab��Bs���!��/�*@��,�W�0B�OXޓ,�zك�"��4�2��G�J�~%��D�#!i���~A�x4���_�cһ��vyԆ�����I����G����mB]!<$L�����XZ�NN�4%�6 �2� ѝ'���|�kH�b�y=�1��	u���*�R�6��OA��TGI�����[[�"�BueŔ#U�ЭKYu]�r�B���L'gn�+Ge�V.��z�F��ÍÅ�I��2+5m�q�D�+X���o��7P��p3D�|�zIx@�R�$�>�' �P�9��"7��r��s��vbw&��h����:�h�A��x�Å�����n��K�	xF�˜�q:|:���t&v���p���vz�F5L��G�Q����vË�L��&���e[u�ɯiB�TˮZ���{+��v{��Y_[�?�2�_?�>`� C��w��-�G<-_hyD����K�·dR�����^��Cp�"8D��|�E�����Ł�A��ل�5W����5�-#tk^��0��j&��V[]ޥ�����eYuW�����x�r�94:��F���U[NCfB�P�j[.p��\GSt�Ѡ��j�=��ʈ��ˇ��O6wv��`y?<�7�ʈ���Fo�@j���&�'S��׎�/|�u�5��E�Z�X�q���&mvl�Ŕ��~�Y%���:�N���@4-M��]Bb���^X'�џk_	8A1>��
��8���X��!�%%L	Q�d�	��R��๘P��n����Ū��[�ٌq��I)��EVaV��3pv��hLs[,�U5ȿ�p���w<4���G�Y��(*���^ys�%��x��i���E�W0^�a���BL[<X��. u�'�od�CP���x�oC#�t�&����S�sk����~���?�~BO�<��e��V�L{I�u���oX�����B}���ٹ}�>���Y1E0ӨS4�-3��)�����H4����|�4��ʦ�3UuL��6�ghE}]<�>���>k�C�x�:��AI_�� �8
J�X?��;|c�x8����/bD�,���C�Yjx8T�%j;Hc4���gi���)��>�[��B[^�|��܎$.�*�Jz̈́��O�kTGt�NR��=�c�դT�ȓ�	�� �7q&�	���~r��\x�.��6d^�[�
!m�NN���{�{at����~�6\��	K1Ỷu(�z}6Gi?����4��9l�A_Z�-�7��(^�w��.H�Y�]b����GD�ȁNd���e'oi�|W�;��M���w�!nM��P�	��q�]î9`��elt��r�P�K'o�8��e^���>8���L�\���ۊ�`p� ����y`~����b����QF�b-�;�`:�A���)��&=fz����Ӳ-��T~�Y4���Cm����Ëc�-??��v�~��9��"���b%CO������>��yγM�ة���V���
 ��;��-���L8��֭�J�ʜ�5oN�s�@MR�v�D�R?�� -V�'�ث���r�����HJ�>�+�
�Xr:B���*�tR[�j���0������v^�$q:�0��6*Ӓu�u�^5��x+^c��n�Y��Gۏ��f��`m�xq꒥�=9!EZ^��r�T�.�1Ƃ|YZJ�8��i��'��>�{��/��{3�ۗ�k9�x��K�b�֘��+6�tF��I"�+R���[����|���@�	��0��y��	 �[ �f�3ѐ0�1���1�C�K����Mf�'�c�M۲w���$�= �Q��w��e�~��f��g��XvՓ��P^[�7�ӭ]U>{�n-��E���ۗ��
Vn�[�ԭ� ��`3�����$���|�rZ~��^�����<�@aj��!9\(�f�r{,ڙ��ד�KI-��Mw^� ���Oe�5��TF͐�Qa�M��2��y���ɉ-�f҂�-��p�s2���!-�&���S���-���3p�Y�K��o0#H�I��i7h�܌�]E�uU���j�|�>�O��������R�����e$ը��+����	���g���e��Œ�C�� �Pķ�f&X���P$���c�KdGR��w���{6ݻ�k^�6�˂��*�Y;�r�5�����b��@D�q,�*Hy���ej�kB�u�^b��No����rt1�š
؃���&ZY ��}@Irv�T���mfTԦ���A!T"k��MӔ=9�md�T�;�X�R�A�荝,}��,o>\��U�4n�C    Z	�.�hn]��N�Ɨp�0�"�N��-x���-QB�;o�JЬ��)� _-���w!<0P�!�ό��>����EA�~���Vm�x@ ��l��q��� �o�� �*B�E��>o�Z�a��)�1a�9	;�#7 ���`�o���f5����iF�d7��Y��2�\4��f�j�)k�m�6�5/�Q-ө��|�q��N�/���g��V����r�~Bo�T�pO\��D�,��_Am�Êm���_a���#I���{.��*��q���Ɛ!u��mL}������̗�?D��cgc�FS�@��釻s����`��`�TP5��t ��&�W�_cb�i"���˄͡3�u�j��?MyC���x43䭍�/"t ��.���FgT+�����
v����X��8��:�U���������ݧ����Ƴ�0�:g�r���L��{��BZ������K�d���L`��LV�/��ln��b��_��9t��^����.���o"�� C) `m��)��j���/3�[����٨~N��M5��"X,���H�X��)���רW�4,C$O�hk�̰d�����C��a�P٬濾��3��QEd���fӼ�U�9-��Z�QM�5M^}��bfv�/��vO;�5�x8l��A�0v��p��� ����1
5.T
��T��I>!�G
z�d����1#�8%y��^ܑ�i!
�� ��l>w!�7�%uɭ`G<hz���AJ^@Ξ�t�#�>�M{ӫ�s��+�N*�ԁ?��tiW�����N�ϨK5
�@���/�qp>`���4�Y�#��(�1-h�]��i9N{���x��-D��Il�r�ډ(
��H)�5Gώ�\x2�#_\X#)�X� ��F��y]��#/6����/4�]7��U���1$*Z&Bb�^��N���yvS���]ۥ�E��п�D�b��S�|�u�F��7�	���� ��T'gh(7�K*z�ϙe̙�=W>����6���V�w�F;�9jy���6�9�e�21�t��4A8�}G��P^�(���#
���}��֥ٓ`���h�����W��m4�K�$l#^`焥�9�(�ūW6{nzy�_����h�v��i�f2z�GCw,�|d<#8�!r��zE8�MǛAB폋��o8�a(l\E�?�U�����v����Ӧlv��h5(Wg�o��ko���V���q1��QJ����C�����/��y�P;�I��Q��.^����k�����Ɛ�����-�d �%u���0^Å57N�����V�7���0%;9�~�TV�3$�m�������ՊSfw���cv
�&�
]ٶ�tK55Y�[v��'��!^v�Í��b����=,�����/^�Nl�:o7F���ʄ1dS�e��E4y��`�K0w���fodE!C�q�D 8s��7�[�ݛ*��ʧ- ζu�[ [~:��Q[��E������GP~�S���������t�� (��o$�=�`�2S!.�|� U�l]�J��>G��U�r�n1��b|��pˋ�A��H��7m9��lUn���t���h����}�n�'�W�����-G^B.6�`���ρ���\}���s(7,."&���-s�Hr&�*�U��ߝ`�Tk��赥�/Qc@!����G�l���99�ib���#��oDK��iZ�'�h����r�h�.�����o�38$:.?HLȏ�n5���F��+��<EQZ^ʭ6(Kqŏ��ʎ����n�*���~�؎�,�YZq��upT:�J�y�1��������d�I�_H�#�L+2hs|�8�E"�(��,,D��u\��[� ���u�}}-�{1�;�Лj"8���ت	�F����P�D���<�a�L�"��q�'C/�j�σ�L=��ŧܕcU��6�����������dc+2� 䟭9��Ub�Ͻ=�4���i�r�i]�Z�����*+5 ��{�����x8����JQ@��h��,�5c����#��7�ƼN�~?Dw�v�e�bf��6��wȤ���ݻ	ߪ��4X�R�̩a��-��C���C�o�������C4b�� m�TF̈ �R�j�]�Qf���Yh+\K,�G�n�#P�Xy���� SM���r���=~r��ZY����0C�B	�Sx�/~�]~��pa��&������ F�6�_� r�:�v�:5�l`���D�;U���ާ����k6�ɘ�`�_ ��H�]�I��᥍��DZ.��X�u�D����/vA�g3��M����p*D>���|�Ɩ06���Z��ҭ6���-��Nɝ|Dz��5Ʒu�����x�d�A��#f�w��a&��B�����zz�o�͸w�pC����V:�D���)</qm%�E}D6C,�w�e5�'a��Y,��n�>t�D���o����5�;��k�[�D�{~TNG�3�ڃ�x6�Q�J�i�>Qʹ�v�ԑ����S�!��$Ke�9x�~@��_�[����Θ8��t=����'%/�G�ׅ#H6TM�UW�(l��*bt�ͤ������l6�6���N����w�� zA�r���>HO�������>^�t�ƅ�w`�^D�C�fJlMQ͹�_�η%;��d��؛	.��$�*�8�@�)/��C���ڀ�v��������s�jZ�# _*E-F�
�
���F�%��pL*vE�ه�I!N�n��V#�<���@�喝);���ϮV� ;<I���1��զ��g�s����jf�l�	H�0�҂�d�|�+�Ϳ�`?���=9@|�C�0�㒧"|�L�s���o_��z�������x�{��5Uc���!� 0�M�>E��K��98`קE�0Մ�BkG �S�e��j����"݃�ﴓ`�t�g�A����q��O� �)�o�y��ʦᒈ�
3����=3ܦ�X�رg�`5;�8�+�o��K��fHYф�O�������x��AT
ֳ��< j��A%�H�6AF�R����ի�~m1���.�J^�K^�G�{4�w�Ȣ�L��n�Q�Ֆ��%3"��y�wx�s�`�yZ��}�Y{�u
��6fd�E��ӪV�p��f:����.}�e2�ܴEW�1��]���I����k��;Ëc���q	�,���P'�e(���Kj��Z?��E�LD5*��^B9�|��^N� �O^���f�/0�)�s��f"�#Ie؋a��'~$ު� �zmL�ED�!2<$(�8�;`�M�䘘�b�U4���{������F��u��8L��HĞ\C��N�![�Y�\��<h?Y���O��^��x��x�V���l�ei-ج/}�a��SɃ�Ui~^��YV���� �x�8�Hߣi썰�����S��){�&�	ͤ��q�dܬ-"����T�}�	`^LࡓD��� ��"{);m���<�L2�-aLdEH�'z*�[9�����~>4,w޹ڭ���՛���QQt�b�g��XWsd]��Sڸ�3TUԩ���������yw5^�HN��dX�&B!+�i��@�0g���/,D�M�ĸ1?꥞`���'��u����!��hG�`�NF�Zd�.e^B]}E#�=$��
$Y��'�6��ZD��o��`�piðj��P����]�2+w �8@p��(���H���U Q�*;��i�f�&���H�d|�'4����qo��l�6=���Q�QEn�۹�Lgmg���t�i@�!&"�_e�.��.8mW��?���s����ʒ�zC=�7\�[�<��,���F+�D�P��R	'ߤ�&d26�?r�_�K��S�S<P�(ǥ�*�ҕ�/�S	.�jLUe^�NF�H�SRK!%�k�A/�����QOŹC��L{컹Lb��f CP�!��N����ͤC���3հUۖm���g�U+��w��ån>Z^�wϲG�2,��d��D����g��$#o�!�"�� w�L[��:�     [�n<b�t��&� f>Ō�����ϻ
Q9mj��3~d\%w�hU�,�[�M�Gy�+����?��?���I{�,��iZ�Ƃr663�/ad�d"���Y��:��������1n�6�i�IOf7��m۪�(�f�n�6�f��a�P�� ��V�s0Oκ��3g4X_{v�9�'�V1���,����E�����
��n�i=�� 6�ׯ2,�
)���Vq)���l���W�}r����)�|S������JmY)ucbS~�R#�tk�=���4d�HV$}�C�Pv�>������@ʟ`�tT�nq l�ȋ+(�U��߻�>��oI��*n��&k�jˎ�����П�t}1^z�ɖ��v�����'���I�a�})��OԑBy+��(���~ɭ��[lq�y�������$@�s �#2���#�\K<v�<�{�w"�e�ef�(� j��ښJ�Ҏ�
��ȋc)ʐ����v!p����E�xش-�;��|(9��.x��$B���լ �mԙ�o��<��&kj�SmǨhX6d���3ksm�;zn-/hK%O����«o��=�A�Pr!+�\���_YW�u ��A+�Bk��P �*��V�ls�B�f��姕�n��g���#ު������p�����
��C?�%JO���l�ZZ�f�*�}�2�N�팃�qH�GzD�nr���ĳ��"��:�L�7�r�i��t�vs��fTNsl,<���`mu%|�5���^ (�-��5R]��Ӆ��/ή��ZeCVQ���D+߲���<�(���۸�II9i0�r"�-^ �7�ȃ�k�Ӈ��TW?fy5�*�<C谆F�'�eq��@�%f9O��R��䉤eB3�����#�B�8�5� !�x�s����������i���4U����:�-��QQ��YUYpOwc������٣�Ω�%�JQQv���k�A� �A����ci9A����F�I�4�me��_��O���(r�yAVK��(1��W�޲����w��^?�G���+!�xv��:��C��O2?���(o�\�P���X�FE5`��ʼ��,��!��6:���_���"w�N��K���TӣV�ڍf�&�v�@۩c'��ɮ�o&@�+���/���݅�����[��gE�x+����53��j���1�|a!���'�M&�O�W�.X��Y�I�P���a܁�?W�#Qb�I��_Eĝ5W�_��k����W�ذx��
l0���rX
�T�c�'��eO��� _�h������Q�{M3!�'v��}��칆���l��#]���L�Ϊ���ŕ{�c�c�]s�kvZC����G�n]MYK���6�F�x�DW���YN}d���~8����,�w8Jt�ͻC�\&��Ś|P�h�.0(�j}�T`�֩�K,sI���2���r�C��I�% >u'��[�g�� �Y���boq 웫}��V���ש�٧��N� �p�5k��~��q�{������|�օ=�.�4e� j�?/�!�±�Sу�_0�"����R�3:���7F����ʺ-2���T�!p�{�a���O���~�ىO�R��$�����?��`��p�J�}�V(@�� �&���U�`	S���ԯ���Dlz����e����n�9���F����l� ��"C��⹄L�oJ�\���T�)�Eu5�Uc^�Ъ�_���jjM�L��
P��?�^.'�"���+ğw�')Z���-$j��?"h��hZ���d6��ab8 �n��ŖmÌw�g�:��b?óN5��n4�����'�gz��Ȏ޴e�(�r�7}�>9Q(2��l�d"�3@�մ�F�h�b{�?~dt�Oό���ܴ�!1fr�F��n��z�3���ymi��L�%��0�e�s��vH��C������Ak�{3ջ�g���r�ꠢ���tE�Qk�sV���B��NU���d�ف/�Wh!��ۈS�3��	ɹ�!mA`8����o�֡�YO݊��w�bV����t�\��T׵mM�tG�-W�C�]��E��U���7{k���}�����[B2��K��j�/M��"LZ�����F�4κ�ipa��^4"��$��}�w�}�)'(m^���@�U.�6m"�\�����l�F��R<��.�SQ�4�!�kǏ��{)gBB{f@�n�@Т��]F�Q����hR�;��G�#Y���:ף+zEmx����������a�e=yR҆|��v�, 4�#i�x�Tj�@�pDu��g�S�A�j���B�h��+�_S������r�.DD��4Z>e���bÛ����߉���)�D�/��j\e��x�s�G��	k�Tu���A�|������5P�{I��X���Mz��u��ƪ��7mF��:flM�3/�9��B5��~�]�Uٶ��IGé�;m�>����|��l�ך��E�ۺ����Nk�o��)`:E+����8���^@���iaz`��h�%|��A��2��'N��g�zA������\�~��V��Z�S��&�9��m�m�(v�~GZ?q$�@��L?J�H�S.��4T`¾'���K/ނX豻s%��Qv!_��!ظP��t}��U�u4r+���w��6��f÷��4����M�dG�AK9�������t���s���o�Y���-�\���>��	�b(� a�$�P.-��V��*	�D]��ڭPj��ۖ�.�e*�k��-��u�e�?L9bzY�z��DX��w�ZSva'P&��x����v0�#�Nw��M�G�v���e}���j`�������ĉ��|�)�Q��b��@b7��3(r!�?�"���CϨ��΃�Y1]��tl�YS�����T=y��.Z���������V<��y�������P�;���%�)�8���N�9NP��Ó,E�����<��E@�����j�vO�y�byMôys����a��f)�mؗ�e~'�7�~k^ZB�A�����u�|�1����;=`{���%����@�I\�H�ZoN�2s��O˷��!���O#�Iث��c@B�^�S�bZf\ʚ�h�e����&�*�@Q�t�Ue��n\(��ϟ��n�]�̣�����G�v�zҵu���I"%$��B.����\�8r���K�ƌ;[�b�W	� ���4]���p�|���?û�k�&��8⚱�4N�h�ؔ�1�C�@0�SbL��"�=�1�͏ �;5|�̂��8ubeOBb��ߤ}�Z���T7mT����3o�;��,��O���Y�>Yhn+ʶ<:h4ԝ0�1$��)HȬ�:	(f����� ;��� �m�V��\`K�"�b 8���m����{@o��o#�
�M�*<����&�ib��`���9���i�z3�C(gR�x�Qp���y`��ܥ>�i�dV��f$C��&�������b9�Ğ��<�3zs5�]��Qe�t#�UǶj�{�O��M��ڒVk'�G���t7vN�����%[��
]������g?Ӏǵ�Q��ׁd�Yy	 F �(�O��_�-x��Iɱ�Tj��m�-yψޗyfui��mB�S����1W��Op��|Su�Iu�Ԥ<�yE�g���HNNN��|F;MK:����M�6��hr�6n��}���.�=�j���y��Ŷ��jV�����0͓S��MH�VTD�m�����^c�>9=���")�(��t wd��%5?��v��E��:P@����l���I&����[;x�-�n�8%/ɨK�W��'�}��j�`��+�Eej�7h1@��P&��ɨ-��lK/7�K��g�
3�5��/�CB���X��̋{1�[��#;-	����N��'b��Q�}z���{BJ�>R&t��@g�.g�3*�=���3ڪ����3��ch���yn�؊���y"[��ʎ�K��*�z�����	;����>j�,t��3Xw�v��wB]�i]iM!ҁH�,g/�"
M�-    ?q��@��(Y���8(|,8�t�_�he�K��y\�$��'����֊���o�[��`�0i�0kK�s��+dWy���G�a�	A�G��@LH�`���'D�hZ�mz�D�1VĴ0�%��{̋d��]	r}a^V�v*��]nN�
�t��	��ɚj�l[�������m�X{'�zz��e�O���F1���1�Z
U�~�\�����HZ�8� ��p聥��:e%x]2]`�~DوL��Y
!-�R��f��^����<�Td�)�d#�_ (�Ρ�E
�/�ώ<xD���4g��B<,0��zD��$������)���H2��0�ӄjD�23�#CAL���U{���U-�Z��o5#\a�2S����=As�hW֠ի�h��b)U���������m/v��Cec�}�.���6g)ʴ� \�Ҫ�)�*|���w���.�N��>����ԩ.ͥ�,|P'�����ݽ��

P�Λx~�� e�������	^�>�m�?���!;7�T��` ������4�E�fXE��)<#�6|fDD�ǟ9�<z���w}F��fv�"4�T[6M��?;UQF��[�������=��gϞ�J��������t�9@); ƴa�>�?��G��)���iXt�g��_$<t���&��T�+�HKa�b������juA,@ߵ���/3�O��Gt��o[5U]Vk;h`�,'�� 4�!]D�.ۘ.�>�xF�c��w�ϱ��Sn!tq�#����i�bOu��=6���L����6�C���J?K�G|��*��;���DҞ�(��5f`���)Ɖ� \��K�*3�Y���tT�4��meu������88����Kϋ��>r� Ey]z�!�����g� ����0��Oq��A�x��@�J�Ѡ\���h���LʍDk���x�oWC���:o�����[�5Հ�B�m�1�vF/:� ?G�p�i��!U!X����Ƶ��&�2��|����Zl֖B��G;Ð7o2�~��X�U�*���� R5��پ��,w7���J�Ě����lqKSf����/	f�N��Z��E�Z�ɫ���ܮ��Y���"����,R��Ipq���j��N�0�-�z�W�;W��<��I��ZOw^�N M��pT�᪨���$�>�f�t�����c���_ȌS��^�`=ԖCaO�Ǣ�7�) ph�ه�5���Zi�gQO-�U�����z��ۦ��F���e��aZf��N�`ա�|t��.�O��-��믯�E]�A�#ԽcB{s=_��.4��e"�!��y�B�w�o������Y��o������6��_������&�����o�A��!n]��lF7AY�PV�+�Q���Z�Ā�C�ց�5HP�Px]��{�Z��%x^�@��UzlI�� �D<#���7�]ƾ��:w=9��A˪�8r�=�@�8�K�\�����Ne���է�ݵ��׃%�����p�hCi0���p���8��фI�v���̚��Ǌ����k���v�'+�LZ~��>e��j����@����U�}W@�C�eB���s�����6���s���
�`�� lB�#����$���<Z�h8�UK��t�}�Ý�ˡ%q3��3lȭ
����Ώ�K]�e�'gm�Hv������-�Mf2�bG";��֨p���>��;��|h�"}��RW��4�\���V��⒊���qf�$m��{�7��}�IMB d�
b�ǎ8y�X�wa�&����1�aS:3�n�~�4a�l��a����O�)�ceH�4Q��	�6�L��2x*?c,�1eK7řc+���(�tgi!vG�u�lis�sҰ���X�T^��	�8����W8'��TE�lP ����({���&xO�Wά��
�JN_�^N�Nd�)��yeBփ_ eҸ2ٵ%/���t��x>b=��^z�����q86��\j;Ke?�&���V;}fxv�a�O�T��4>�U�=α5h/���^z��n��%�ȝ��w�!�/�m���9q"16}������%)4��)�v��PP�x
��ar-�?d���*?	���"�<����ds����q4�.���վq�}SP��@k9���q��W�b��I�缀����'\!F�)S�	�	]q�	�(_�.O&O���W͵�uܛ�k1됏�m��QI����Z�g��n.�?ZޏW�';��6���}�d�����1¬Do]�q�΍*�n%�+��y���b`]i�~���޳�ܲ��Ŝ�.�X]�.n���1q����(��C��XJn��Ǧ�%�J�D�l�P��x?rS%%0��BV1���gv%i|�R��<(ņ�Uմ�g�2�m%�t���^���{�7��E-a�|'Hϓ~�X-f���� ��zN[�<-��?��:�b!*>��hx<,?W{ϧw�2X65{�t'�x��$%���Cv�I�٠��@"^g�A�>��s���+o��pJFl\H����Y��Q�Q�����H��X�j��3h�n�ic(�c����f��T��W�޽|���L�9핅������R �*��k�1Y��i����G{��u���kzN�FŨL~�#@GL|6D�D�rS�g�_uw%^��7dڤ�7^ ���ʨ��n�59u�)�EVʘ�#�o��=�Ԧ"�6z�i�&G,CP����l��.G�U8EMEn�A(�_V=��3h�[�d��#Pa�&Uaw��h��y�x{����O���'%U�[&a�@��%H�	�:8�r��n�H|^������I�+b��Qz]:�Y�h9g��7>�QǴ�� �Zhw���0�/���'� �ǤQ~#�G�{��/���p�	4������O���q|�M	,/Siiii�s�^��9���������S�aH�m%����<�ok��S.��S��#`U�Al�jۨ����
:�-��n�τ�/d[���iښ]#}<�S�Ç�����s�<X��\��20���YY�3ୋC\GL�������F���e6�  V����]h�=��-`��ϰ� /(���{� o�r��ϸ��p�^�뭸�3o^��v$qTթ��&��k[���nd_�UIi��f�]�1�q<9��7n�T;�eOy2(�$����Po�A6J��#�|8o��Z"��y�����r�C��e+<�U/������I����nϱ������`�񠵩/z��c�4�����&���~������"����P�
����(�x[
�5ɡ"{�}R��$B0���!5(�]�:$���vO4�d���ٚ**�߷Yݥt^������@�k�Q�� *{N�e������}��b`��77�Ƃ=ΛF2ިh��g=�'�e$��L���ǩvt[��n�6��z���$VU�;wp@2��1�E�>[N�si��C���j�h��������E���

l��`;ߺ��_>�ѻ�x8'.�"��%sN��m���x��m����}�ѝ_Y�4s^����߃V�\��<M�mk����g��d�y� ,̈�&��S����l��E�rH�J1x]�Fi?��3i����!�a�cʎ��@vQ��V�V�mk�;7�e{?Q���R��D�<�[����d5�Ⱥ���W
Q\sF�!`�؞,�k�7�KH��]i}N1���K����e�!��0�>L���Z���L��;p��ݚ��n�O<{��24��
Q�9D���W����]`-ec���B���6���`��b�͌�N/H��)�eȖ ��U��9S�n��&;�����U�+Y�X�����:Y�w��\t�6U�� �]0G���:.K���~7 r�7W�}���R���`^�c*nGK�Ix� W<>�?�S�7ƀ�<
܀Z�!�}	��yZ���z�[�rY�n�qu�k�Th�樵���� ���Q��+E�^�co�ϯ_b0�o"5	�<�%"�v�Е5J�)u"
��H��� {�a����n%����*�L�    ������ڹ�����\|b[� X�iȎ���j��#��D�ֆ+�ޞ=�j=>+�� R*����y��W@B6��(ܳ�T~v(�a;�����
�+�@������[�rچ�)���| ��#n	���j�p�ߪ�_����ʄ����_�mҶ��"���!�p�k���c�����/��	;@��/"�`O����0�T]x`��"�xk�j:<��3�i��{I'P�*�y����ɐm�������jV&��%�ێw�}7]��s4��X�K¦���į��P��q�%7��ьo(XB ��^�|��e�K�	%dl��(lK�D贳�7���S�u�+��M��H(����StG.�#U8>�?������j��y��!�Eԑ�{A[�/"E�Y(��J�Il�(��q�uECw�qgԘ六���W���f-��~x�ĩוm�9���(R�fT�|y�6��˞d���E]֝��1��y��D�M�E��|��#'/u�cvxT?�q��\��A��o�N�,+�^JS�Y��Rt��л��>�o<'	G$X�_�̏S��9�p4y��.���G���Y'^�k�)h:���� ���5~��oGT���Ü?K��}K�U�j���щ�l���k[qg����J)��!�K�Ư���ƝE@y���7u�Mi��W�@6<�o���E[	�V��0�("�澩}��W���{8�;��r���2�����Y���'@%�Nh�XfJ%�P�JF$4�6�Ag*�ǳ�@��
=���A��p�#U�]1�8�3�s�&t��U�yG�f9�f@��$��2�Hs��i�Fe�c�\(vssk���S�������SA��ۍ���gX҈�qfc~�'�a����g����I���:/n��a�/��^ҏ�����H=�U���gӹe�+-Te^�&-����f��pa����#	�%Y�W�q���@_��������N�W��V�o��{#��5;l� �h����Gk#��/§�R5��η�1#��F+<����D��9����Mװ�gMs+林6��8��>��e}����������&�.A�j6�e$p��?���JF�Y�yb��brK҅y؅P�A苤�5�Z�8�g��z�ftw2y3T��h\���������C���d�B������`�\���]�)OELb�։����ڰ<�F��ĀDOT�9�;?��)�5�Tt۔�^�D�Њ���Z_<;s�s]qN*����0A�p����W����a�����h�a�&XR���U>��M�~�RW��J��ލ\ݬ��v���];�|?�	{>@�ϼb��I?�T���+��I��S��4,��@�1dς����f2n�kz���w{�n&lgQd���={�4�Ӥ!��-XWv\˖G�=MtdԮf�E�����j��o<\S�g�8zV}o���o2b��ȗI8��Ճ�z��1��-��U� 1 �����4�~�q4Ѷ7 g!i:��߽�Fv���+�R�"E���H|}��O���fI/�qj:(�S[t��Yԓ�^���|��o�f�h�Ny��ե�=$o�*{L�ٔ�0���S/O�]���w�Ì���]���S5d۰���T�Wo�ʑ�l���r��O���M����EK�� ]�s#R��U:HI^�!B��2�E��s�|�s_� �+4�~���?/]��*:��a, ���3�3Y����J�e�g+��~vz���?K�w��{L���&c��a�O$l�3�p�{2f�)O���}S�i���j�u��n�>Hp.���oٕ/���� ��9 K��C���^��eɲ�/F�Xb�Ȫ��"%����AӍ��A�ȝ8}�&����tA��<����_r�Zk�b�D�K4ݱ�i�dI�v�^k����z�)ݦ�t��\Oػ�4  H)�-)��qM.���d���^c����pkkcYi�A�ؾ�#�1���_��)����b��#�[�����A�V���T� ��&�f�{����Vǣf���~��N����D0 ,��o�3�����+�X���[S�
��0St��;�~��mT��q�lZ�멟�9Q����P�����)"l+����J()c�)��|�9����Fd�I���2œT-e_��~%):�4��H��X�e�|Ӑ��y��D;Y��xѼ^�]$뇏�ɟwK�3®|� ��	��������\�Ԩ6Œ�& �1EAn��1't����9��c�!���ן��!Pa�"Ù�ܳ�~λ��nc
��8�:��
ԩT�w�oR���Z���
���b�HqO��z�:}t�*#��xS��W�	�؛��H������T�,���<��P��ݣn�Pl i�o���eK"����N�<�G&����0���R��9
�`����2������=�����j`;��$:�v���Q���3W�^<Č���f�J��bG��gŝ�d��{e���
:�����|s¬Y�bu��\aRϗ0���B�͒�)��J����^�ơ�݋�fw��k
78��)���د7�d�������J{o��*4�lí��ּB��f ��I�{�5���8��z1��/;L*W_O����g�~	�P��mz2W�S��D�UI�q%� ��#��ji��>��$�ZS�
�������u6�=���}"��?���]��l�A���,&�&�)�OS%��y]���F�:�T�jw_��Ė׷wO.�4z��n��(n�i���OC����֭������i���6�6��TkR�6�Q���� �@�D �J�nīA[�!^E�b�r?f9K����D=��W�N)��E��B���	���K<,�|R�q�f��.T�>T~It�x���@�l��G�+�;�N�ví�����}~�(�bJ�"��g�*�A�+yg�����~��>=9z!_>~�����
A�y&�o�q�'^����ɯF�gغ~�W&'��Q�W �I�Y}�Z�C����xj3��)��B6�v��8�i���A��1�d!Ұ=�wQO���^�w�Ĺ�7!2X��l"�uÇ�J�`n�׹�Qo�v�%�kV���G1E��!;�!Y�`z3U+[��<_\���U����a�Q���M��Rq�v��ȇ���i8�4-+����{c���C{�¯����?GY��Da�
���*|O&��%��P�wP����QAVE0[``NR�3fi����D�*����w�\m���Ә=�̰��T!��pN2cW��)�{��7 ���Ѧ���I�*��tK�J'ў�����nW��K��]��/3��ѻ��W1�\��l�n����{f���4$��"׃��H5ގ�Qo�C�Ut�@�!SJ= �5�E���?��&��b��|�Հ�P	����8��Z����=�����m��(��`�:';��`U��[Ŕh���b7�l���j���o':{�!��L�u���l�>�f���Z�(��J�i\�UKQ4��x�|VՒ������#��'��3e����^(󧮢��ׯ@��(D�
rf�o-�{�8kB�3�I"(��398�U{�X���_������M:��٤�jHU��Α+G�;���r8p���>։�M���I��D@/�;S�h(5ؐR�P�@a�3�m��K6e�r���}*���n�W�p�.Ъ�B�ŕRH��P�%TD6�������>|��4�g����������1ȉ ��[�3�ۜ�B�V��+��oX���:*�h�&($��r9�b]�nE9+a1p��g8"D-��?f��˨*6t9b ���8�ߚ�ܯ�~��Yc�
��XFe9��7���X�/Na���	�+�oҞ�]6%f
-N
��^ �:�^[8Pz�QӾ��:���#'f8쒉�Y�l��&?�0U9�e�T�Ӱ���nz�of�
��۲Nzl�"���_�o-�'�'�3k�<���O    {�����k�?��E�[5�5\C�=�}[#���_*���p6���v���K��,���\�������|HH�םyվ�@��
�NM���&�܋����drMy���M1�=[��g9��_�� �Q2��cO�������i:��X����i�O�gnȖ�(&o>��)�	��š#ɧ����Bڿ�<�*�_�a���ebޓ(7& �@t��gu}���R3r\���ql�嬉��*@��'�;k�s�8@L�E3��R�rot��3W���$<���<@�*���_ =5y�Ђ2kp��!��j��]�"�c~;�c@X4�}��ur���������')X�P�ì N��ዂ�r�:��ӳ#.�]N�hh��H����fie��������(r�w��xY~F����]D%H��!�2#�UĊ5�]��F8�|�zf/��KV��%�E(��R�|�L\mZ�Ou7�Fǚ�:Ub��a �(/˔� ���3��9>���lf�b�nڕ�>NI����C��b��?������3太�>��F t�c,	���bqq����!��}�ɀ|!�&�k��՗������{�<;p��m��.>=��{��: 8��P�b��o�?){9�Bs�}�тv��5�>B8�=\�.l������zx��	:�(�Ω��h�]���ϒn�Q=
��m�L�>ީ�L��� �ȥ�:���W�Ars��F"��p��*�F�|	0g����_O:��Н˦���^���,at*W�����v�Z�i��-� ��X���ތæ��ݦ�94N��S3��t��%ͲTIg�<;�Tٲo�[�%�9����������U�̖D5��rm�P�r~i����ܤ =
?�/:5
���m���u�:c!"ig�����7� .T�v@ <�t~�i�`�ʡY������r
������m7�)�x��oL���\�T�`�6���l�w$C�T��)�6#���T]׍��׳�Ք�&���x���M-��f_y	3i`U�d�i�H�������Ճ+{K>k��uِ�x�b8�Z��m �&2G5Z��'���=��"�+�(Wp|��HV[\�U��/�_�
�B�Qp��Щ"�ba�	�<Am܉���4?�,���u�'(��& ����bm�I�ڹ.��Z
������^�;�'z� !��=A�=H����Gv0��b�}��� I��,�|�������llFf�qa8	E��1wL�-����u�:�`�,l_lv����`��w������1��2!H �k҆Գn.��"��� *C.����� �$�S�؜j���^�9W�7���3ڤL�����V�QL��X�  ��o��&wNzCT9�~�O�=�Fs��'"ȢW�t �#���gϓ G��r���&C�(%)Ngt���d�gI7�Z���w{X�{���h�d�h������K�r� n�l�w;��֓���܀L��h�_�k�uˡl%�88NT1�Q4�����\$�]����3���"
���ᖻ}DD�7s���\TYݼ�M ��`�:xV��\9Ķ�T0E	�։n2�r��d���y��_u�7�U����M��A���F�|�d8t%�d' �o���<2$+�b=D}�Y�(w���vS��wL��u[�m9�c�1!J�`/�aI��[l-��z���_��W⅍f��`8|�4p����ݣޛ�p��b��;��X�6� ��0�$���q
�$�L�N!��7��n1��mt�8P�2����s|7ZQ4���k��Lg����9��@��D��ĨG��P|N����j��g��~5u�ILH������x(���x0M���O�=���].F:ݨS*���P�6�X��iҍ b�6;�C(�Z����7�NO��n�{a���\.�,sӕ,������"�`�]%*�7���I����mU�d֌�C-%Q� �S�J���dĚ�j��f�t5��<Q���Mk�xG��0�Gv���O�s
�+�� �\\{��Aa��eܪV肛A�b,����mzTG��*�CH�@�`kw�5���7M,b�B�f@>w=��QE�,��0��~ʶ$�Y�`��� P嘡�5B�r� A�>~'j���_aJS�Ͳ�2Svu÷YVe��0��6%S7UI�,a��U���ً��ð�Ȇ�Z�w�.W��7Z ���~��|y�w,e�f�3��4�f��le&[}�v�~\]쟞�)�㺔��iXm�H���v�+���67�=��4>A���:�1���-.�>a�>�W���*U���bX=x�j������\i�[���O�#�YC(cg�?pA � >xU���/�,ӌ9$�h �.�����hH}����[��`]�Z�V�}�\���Ǐͥ���ڋg���f+��|�����O���v̻�0�<א
ȳn�T'P�?�^]�2���m�in51yHv�H&��G콚�E�����H��ei�Q9Ā8�����3�9��(ލ�
qZ_<(-��`��k�`C���,qj)�o��J�<�W2
<����hP4�Ԭ<G����8&��Uкr!&�Ū�S�F���.[��v?�l�Zວ�p. )Q#o�<���;N ]����Q���&&�.}��>k<��iD˨��:	_u��|S��t�MCl�a��Q9�Wh�m��B�$��[��Q_��?zX��2%�')�����ƀ�ܼ(��z�4A����}ƞ�l��ݎd��-��s��eK��g�|���j�t��O۽��J��񰓷�Va�Z��w.�h=�ŕ��뎜�U��y�iVL���y�(�,�RN�K�ڊ檕�ufB���p��+���1���ǍYyB8_<��&���^S\}�6&LT �#���#�@?m07�f;s���2c�I��G��H�=��0m�Ie2.�3°C1�:5Z'x�>��1ή�u�]87�nZu�_�������R7쥡'U�")�_!���ݭ��ʋ{`�,���egnӄ�U}�<g7�Iܫn�n���0�VU�ds���}�C`U �QVUu���p2����Ȥ�eҪ�3���[ׯ"^>�)�D�]�:�	��/�I}�tA���-/�4#��!�r�'�7`�1WرJ�������5�S2�ҙ@[����ik�d��>�u������KO[������aw�q����Y����׎2D�u�!#�n��E!���o#��B|`����^C���U����T42VkynȶR@�M.�v���!D`��p����Ma�	=�!��!W?�Ҏx5��%��Ks��Q�Q�86oU`/�����:{5�ö̌�҅R�Z�d�vz��}�����Xk�d�n��|#����],M��et�}r)�Iqj���|Q�у<fkh�x��*c�h#���dQ.�h��*dk�|��	�c�{AF�W؇RU	��(y0ֹ�����O����-d�� hqt*k[G�=���r��a!�s�"�@g�SU��,q� �8;!�����i��w���j��<������~
[J}��*�&;l��4���l�C��U��%ES-�T�볭9e1aW�}��nk���U�<TVN��gE��� i�d��3	�����+L�S�d���a��� ��f��ق�!i��A�S��^^�u{��
��f�8B�I^˄���金ۜBU�2����P\ =�Q�TTF*ŋP��k���W6�����NS���8 \@萃�;��c���^�fg�Q�R�F
��u��P&CW�J��˒�Y���,���.�{��ݧ/���c}���b���#�Yi1x�)]!�7�W����ґ�u��x,�]���V�wS&�^��PA��Nm�rxC��y���$.�9\���Έ�n3�0��+<���L�K&:�e�ŵL�iqZz9�� w��ڐ��=x� zK���R˚��ǋ��/O���F=l���B/���^��۳H�^�T5��:��Nʅe ��`˥�&������h)0�Nt�7e��    Vܶ?������_���\*2|~�	�%s�W+��iuѿJz�� E�C�0�<fC���O�@~HuR�p{��ۘ���z��ń�8c7��p���c�̈́��nJ�O04�B"���WzR�\,avw�*��>�G�e�`��a*�q���V7Ӥ��!3�l?R@Ӵ��!��-�w��7[������z�~� ��<�Y��+�7#�EF4�*��&'���:B�ZB��`W�b�E�x�	�Ԉ�$�GP������>}(���Q�$?���՘W!�q[_��W��VY�[��L�\�K���6�c9#���!]`#Q�	����W8<<X"ټG��:6�Ȋ��h�*
=gI����mJ�eSH�6��eX��̔�,6���cewqy�3M�=�Xn/,l���^����W��Z��=`��"���FR���<�]=H�a���%eu�q�����u���Z2D:����nͻ���{<��D֋g�!�ct�_ �V�N��<�)�W!�g7�9�5�֙�E�u�.�cn��O.-��"�%�r������(!�!Q'c�1&JV��Г-Y�qOPR6:������c��Z*;h%G�t�Y3˪�}��O[�nS�l�닛�6�f���$�d��-G���P��5�J����	�(��˛�U/�?G>{��3����.^Q��U���ǔ�A���qvͼ�������,g/�y}��5+����_ }Ӹ��%"#�VvD�EV/��R@��L�b��5(#����$(�`�J��%�[S��Ǟ$�k����$�ZΦ�~�)O�^�I�T[s�aC�ώ���WUw�qw���4�5��#]>9*1K.����]�n���.0%5�:������A�7ܺۨU�̺��?�4�����/�"�Q�c#A��c�t�N�p�\�S-�� ����_�\��lo PEt�>s�-jb� )��T�EP�Fe�m?�bd��LR�hp�<���N�z¬�=�c����>~�P,�;%��<�T �=�����؋UkI�[�I�d)6�˶5Q��v�R���v=�s�Po�.{����/�����F����������M^ �P3RP��&�c�Y�����;c� �w��2�O�!-+�L�����h��qE6y����X���NU�Q�ט>�p|\,����(�?yG��CqaґYJ�4*N�u�m�@�Zz.w@M?����'˺�e�y�a��T������Xs�����-kOs�ՅBd(��!��%�Ć������q� I��b v��jIՅ���݆K��c��Flj��ǈ�	�*�J����dk_�����}��`)�U����TKP��%�;t���W�����W���;d�FC,~i�ر/e�G�q�A��F��$K�vܻC�1��lSf�n��L�,�pT�tÑT�-��4t�]�!ch�7.�������Z����i������u!�&N��x�̳-�r<���P�(��G����@5F���̴�i6`���sp�X
�����\��ь%��(��x��<6)��.� ��U���eH+Rt� H�pv���p!��VE��kA�7 ���Z��E�8(u�@ZƬCKv�'��.S�a�iG�M���W���@�����,)L��:+���-�jk�U;07˝z_>}t�O��O�V+��N�F������ۏ:Y�/�&XЌ�ay�P�N/���C
'��o�):���mܘCBc�~�{�T򋪭��6N��Sm[!�v*��5�`;���W�m�8��p��>�w���au{ >q'j5��C�WF$�����ppR�#�)���X�Ϲ���A��*4�4鰱���R5ٖ%��`��^A�y��lK��A��?^YtoݨΤ�̴x��^��f���~gD���R���_�I���Z��ʱ�S�U�$0a��Y4�����������f���n@�TT#E��A�k�:�i�`/���C�2�V�Dx���ˁ�6ɾ��@3O�:xa�Tg�<r� �U e�,W��>c�=��Ԧ����,ņ�,˱��g�d�����rx�|�h�K'���`�i��0�����K�`!�!�$��� J���4��&d_bA�p{
���hӐIkFM�qN#��:�=؏qN@�
�3�8��@)�R�h�1�]���X���ɶ�� K�z��TK�7h�a��%e�1��l��T-7�����%��7LC2�3�M�,��j�=ݪ�:qx�mmo��K�N7A�n/�=��j���vS�V=�~��!��6�����?�)կc<�E�5C$T��Ӫ�eDIV��q3��B��G6�YKZQad{^1�@atR��y8�]s�*bZ$�OԳ������1��m������^��SO:Q���td"B ��q
��u�g�4���D�hL~��k��ݝ��������~/�̺ ��n[Tr9���<Y/N�#E��ǋA���qN_�YV�Ibj&�Y��<��x2�q�$^�Q?
m�y��+��1�9���w��y��'��f�Oc�2���!�$D8D��G KL9��?������Y 3���VyB�7H���X�����d�K��L���qR�)lQ]�Az�6�.�!R(�a^ܷ�U�*If��Ou2�Lo�fx�_�?�$}�V}�vLS��J�ώ6�~�L�Rk���-��Њ��Wd�>�i����Fn�/�U �b9f�R�9Ľ�oP/�`:*�6"7�]j��	��'�a�J�}'n�� � �SAh�c�Ň���j����H�(m:#�`�-���˂�f���7��	���p��pD�N�p�� �
N֦���6���7�T	iv��V?�,+�m���s��Z�~�����cs����W'�|����e��=�}�$o�or�t-�r	���ŀ5�� �g,�W(�N�OS�즿����2�"kwUʔ)Fa��\fV�9_�P �����+QD�BT
�'�p�+�ą&K&�1*�*���w}a��/��M�Ƀnv/�����d��J�e��Hq�ϑ��Z�|܏��˝�fd7�V�&.��gx�y��'G���hs�P���dH������6����M7�y،w@"�.�N����rIb1���dJz�"N�;`����Ș���I�]
�u�>/�	c��<�)SL$7fo���u�#��t�Q��@��;��CV��45��Ur��BߛA��V�uG�tS�>[vY�ؿ�xrr�:X	�{��pqoᰀ�;��ʿ�\�Ȅw�E� ��jGa�<�H�PuU`��`�����������Ħ(Ѫ9o��@��h���"lE���<��B�A�5���.��o?y��Vu��1)�Ȧ�ƣxbiuS���pN2_�+%R�mIm��UN����O0�2۲TK�JC�5�wO}Ӭ���6$S6e�28���j�Y�숢}�t���L1UU�j���y������CF"�P� }�p*C�3�o�G�弶N�G�|���#�2b�������1����2���S�y�5J� #
3��*��f-�E�R�	��
V&��+;ä��Sv�]�� 	2\��Y�=,P�&i��'����	���7��V.c�1�T�ы�����$�?�����8�K�)ےj)����l�rϾP������
T�������|�{���-nU�(����z�|7_2��1����Cblّ�Gl����"K��7��c�t�Ph�r�8C���Mʼ��&� ڤ`M��T��t���ӣ���Y�;i&oP�:��,��& yp/���HPW�rfٔ�N�����I�4ʹ��@�ر��Y��¬�r9ו��bˎ��i�{���by}��}��>Z���*��|�Մw�y�~�pjo��`���}ld�i��G���#�?ժ]�_����8~�Q���*�h䯏_��}��l�2�Uڼa1���U�h�J�rezK 
�r���3S��"�2��z�rR�͘./�M��ͽ��U�a�S�h�kYH�)G�.j�DV�&�    ͣ*Y��l�<z�,TKw������|����U�mw�X�N�j�Jx�ðЇ��v����@�ib��G.��y�H�%��*��Vwcވ�+����"80�ֻ��iL�s@eb3�-br|_e�"��Uu^�����U�tU�,^	�	�H9�P��T����@��ma���cȌ_�"�xF�@u��2{6����[!�U�l�{�����v��<��:�[��阒c˜i@�-��q����Ʊ|�,��C�H6�������%;���:�����6�6 �Ӣ\=u��jn�g�U5'��-'U(�E5��a�@���	 �� ��_��|ԓ��4��bUm^V�A���S:�ZY$��z�H�Ӯ^ V�?p(y�)�Rי�)RcD��Y���t�&��H؋:�z�
�fv��n�w�QII���e*���~��r�I;��f׭'죮�&@[��H��	�L�6���������v$�.D�N��}�,��R���E[? C�v�2�p�$h�C�%4���gPU��Z<�� �g�]9a��Oc<� lQ�>����w��/P ��i)ED���9���6�*�yeV'����)3�t1�N��V�6�Z���rs���D;<��P�䮑ʓP�Z�����".S9���_�݆�ꞡ�ⳣ*%�AG?[����읮t=i������ �B� y�]��Ez���._S��Xe �ojG$��#ㆈ��3K�'�Dܫ��_!Z B&`��p����p�=�F,9��\�>�yvr�o!���"���M���P���c�$(�>�ypƔ��'�BI��n���m�@�E�!���,&��hS��V4�nfYe�nۚ![��HpU2t�[�SY�\0�<�WZ��p;�ܴzQ�߾(Է��^MD,����R���z�r�OP�=���O"2m����-p�Ӯ�t���/-�D�δ�S\Kʱi���S�]�W�>U /	�A � lù���f"�y�pC�<b�t���ia�t ���𗘙�m�#3�i��W>��a=t�oNX �șn?������~��7��љ�h���F�x���$�XՂ��nS�Z��� ����xd��ؖbيf��͔���H�����5ʙ3�Ӷ��̏�㋋]K6z��ݝMu�w����Db	{��Ѡ��x<�B��wJ!��LJ�m��E�)\�S�7*��0�n	����Nz��;�9 n<UA�d{d�b����va����U�7x��P����nͫ���Ņ�C5d�v����هD�T��^��/�����{�Nx�h��^N(WH��~���+�Uьr����2[�f��h��E1eӐ4���b��OvW�󵳳��v�bv�����Z�z�7�oޖr�E�0r/�9d�O���(���ӣ��*��϶qT��o^�g�3�U��Qb����k��{o�r?f9,�Q=֟ˣ��*�Q1����j�������5���%dU�ѐ� ���l�.��z�
͒�wr�޴��6���0�L6$Y��ǟD���|���iORTI7���(Y�RV�v.V����e��/(�A�L�1<�+`O�-8����A��4#Qń �s����ȥ��֫űt���?�("�c�l�jQ��?�	�N��1d���caO�g1u{�bi��|�d���W�(�v<�� �@��O(�;GJ���Į�<��PNK>�O�l����Y�Ԋ�H��ؒ.b��;�4��~�w�z�Q礻,n{k��������쑕� TK� �� J��b������q	s���ȪJp���Q�%�����GXc��2��^�g5wS���c�Z��睂���_ uUQ]5�r�3�9�t̜�j���考s΋F�{]�oc������I�b��1Ƴ��zС3�m8�>U�8��H=��G-.z�����9�Z��ͮ��IMe�TtɄ�,�lie1XW^,���\?5�Wϖ�f� ��HH9%�py�~���Q�������������]�(�>�oQ��h���)���{�FD�*� v�� *���)��� ;����P�̅v�����ico��X �1wR49"v�6: �B.��y���B���2(��',ř�]��Ű�r���G��A)�!�noY3��\�}t{��m�-M�/�V�z G�c�G!� vJ@�P�AXՔ���z���n���~�^�w��7�����;f�3��oIۊ��C��o���iӉ����*�v��<�*�ŊÚ��qx�X'5Və�!��M0�E�0��v%U���z�n��JÙw�v�6;߉B> ��u�	bl�5K�OO;���9�<0�4���a���ާ��Y�4Jw�-�ǗO6���\��po][^~�wQ��a�����b����5�c���ܰlY�gq�R�rQ�)HF�6�� ���b|�E�Q߼��U�#�?
�`��_"j��Chӻϳ��L���'��%6���A*�UV� ��8�BΖe�yY��	O�M�d* /	rpӁ�k���߂�Z嚤fy�Y!a�u+��iY�d�	�R�����ڡ}�����]o�g��O
������ĺ���5�fv�/4��!D�	�

p�o��ʱ�T�cP��2��J%Dڙ�ˌ�Q��}��w �ymׁ}G�nk;� �n����]b�蒻]�C������
��	(�?��Ť^b��Mw��i'P�Hj�஡d_/��>Ř���˶��9=en�,�&�e���q�F��E}w���hAU�v��V+�?ɻ�K�4PY	K����Ci5]`2L��	���n,&���ɴ�U:iA��'�zx�AU V �#U�a�\�~�r��Y�-(FS"�/�nY�[�)ş�_hxQ/�� ���,.�1���ioR1X���K��~#�O�L�mp�ٓ� �̩\(�=��R�n���_�jm�p�@��Yi �'O���kE�<���+k-e5o�.�/r�
W��*D+=G�{�!�e֐V� �G�~Q}�^5�v2h�r8t��+}WȔ��*�t��Ĥ�j?)�A���l�=���e8���n�3����6�Y�˗�����@_;�Iu� J)�<���?�A�\���E����)u�rf�2b�Cf!�{� P�$}�����Q�A�r�:�{��!�1{�w�1��C�  Sđ����.l���q�~p=���,� �v>��tg�`i�X؜_e(=�BT�@�˭5�6caS������7�����x��`b`��H�
@��D��~N�;���jk�<�|�@����m1��ŭ����������þ�
c��#nS�b��'�	`t�3`Y"�%�DD

f1 �{2�(����ٜ~�;1J��Z�(1���ʒnk�^궬�>O��B]�����<�N�Z[����� ,X�/�	&��E�tg@���		X��l��(�j��R�A�e(L��pɀ���)� V����"�>ҩ�����\��N|�B[��j����L�gW���@���&S_&�׿�ȑ&�%�~{��F�6J�HP�����;��B����u&��ɲ$�w㨒a��q�˶��%J�W�/kJg��`�H���B�X�M؞�����M�V{�`M���<��Chn�	�Q����!F8rg �^����<.}��w�y(�.��~N��<�&�-��ߓ���,�h���,��GQHY����6�*�2Io�Nf�Q
u�x�?̲�L@�b����IYK셱b�W���`�6����C�J)�Y�����FwWIM~�*��PPmK2t�J�l�ty#2;���?=}~q��Iz��J�n �� ]*���V˯Ѓ�
=(���x�D�u}����<<b��C|�����!�H�HOȡ�E{K�����<�_@����,Z��U	7�^��k��*j�.W��È�G5T1d|��f-��`��Tޞ�[J8�]�&l��98�B��)���i��#Oq�:�<_7յ%���n�T����+��+��ʶ��*'0t�.��;�^    �G�Z�$��/B�y{��4�C#j'x����:rLX��bo�2NpR������O�fH�.��b�:�s�W�Gj#T�=��YYG0�$3k~�UR��m7��ߛ����}I��C
�/����W�����5g��):_����2��p~	k�=�Ն=x�8�'H��}�oq*��M_S�:ey��t�ij������5ݑTK��g�(�Y��'��$�rlϼ熱�?p��d@!5,��r�%�A��'�D�\L� �	%�_��4�V�x�#Ո��Z���?�OG;��ra��O]�?f#�S2��{�<3�b'���
�P'^ E5HQ��V�����o�6�q�\��  !ZT����sK�z���Ͽ����&�l{�D��K�+��W=���A�� �m�n��	��/b�{�3�倂fy�)����}ɶ����r$]g~�n�*�αK�)��G����z?�X\n��Jc9L�*�����h'�q�o�qu��E��'';dK�}�d�Wo�Ψ��D.9˭�:�n<W�������3�����@�M�q�������W]�j*�f�;]��7�3�X�!2?Q����C��Ĳp��đ�m@ -��u���c�@]�`��F/�7�CO��h�"j��L��MI74Mr�Ō�Ҥik�ak�d�@�ڍ��K�ۋa+�Z+��3���R������7Z@q2���;y���c��V��S�[�N����~iR�%�� vO������q2�%&�pR�/6���,x��mP�s �%���6�4}�L�nח|��R��~�'��˴��lf�f����Uv�s%���{-���ӏv��B�y���
����6��i�%s��e���Z��W����5�䵯��y ��\�tw�)��'7�+�4��Δq'^��Ƣ�ƨ<\�N�ƈ�/��|fg��c�3�؈_��W+�G�q�,�ᰬ=nRv��F�j�v<K��k S,G����/�}3$�Z�0�����<��۴�>uӕ���_vdِ�S�PL�i��.
l�4k��g��d�M�a�:qwoC�ۧ�b��;����˓_j�A�fѥX\CU�Ȁ�Xf�+�U�Y`�8}V�P��8[��% �ܑG* ��؃�HzĬ��
`���)�}�k~Ʀ���l�%E��k}I5O��4��P'�̾�)$`1`�~��0�,�k4)9̔:�����9�\60�+�'e˖lC�%G�:��eup�V���hm�0H.���mŻ�M�
t�m�)�I �?�^�"6l�x�	���z��DX��n�.���������|l���%n��tDH �3)����|��6��]�ǳ�g�� "��� �'�7P��yeL}� *�JYES�P�5g��3z	9���J���K[Z�.p���4� �C� ��$��K[	"l��^u�l�Nw���e]դ��U��ֲjo���e^;�.��.�����8/ �⛇3�j�I�h%���@,�x����nb�UX^l��MS���Z�����g�f)�H�2�Q�)5+S]+������U�'��D����n��k�IUmfa����YO�NSP���G�������=8��LAaD�W(*��f9�)�������lQUuv:���l���Y{lXO����x8�ڃ���i��������8��uDFO�)Ɣ��e�@��Y�?�tҹT���h����wU��7G�q��4s&����%:���g+��4p�,�?U�4Щ,�³�Ka�t��N��=, ��c�����^�na��������5S)J��!�K��!lnb�`@�~�J�����g��6S��>9������t��*��6�W���gO�X���RזR�b3�a@9�,ꎎ��R�S�^@r��eD��OC{Lu��-� �����.0��԰�H4-C$����I֯����x�Sv(�{�DV��L�5e\�^ �WQ�y�è@�ce{��e�ͫ�W<�v�;���l}Q>qه֛.�t���~���CI?����ɷ8L�$&�ѝ��|]�ղഖeCWو��4݀��_0�_n2��q`U�7<��s��u4ݴ��|��a�8���<4O><Ã�i�͢9�
�SKX��ٺ�O�qnne�8=8~,
���4�.�y�U0R<�r�_ ��(�T�*p 5Ǚ[���L!�9�*�����6����܄��"91a?`�[.W�Ѧ̶���6�az�ᩧu�^יB��R[���`�$D/����tC�������d���X9�k��KVs/tҫ�'�)S��F�\�Y���,���b,�У��U�o�*�4f"Q7�^�����H�NүVv��׿�x} �xt�ORZ�+Џ����I]����Y.1Ɣ�8t�@�@��X��8�Y��|Ѿ��� ]~b�g�ll�I�^ ODt3�.{�9���5H�yЦ�����Ar�7?��[?O�8�(��G�an_�yT��e�X������U>�ٽ�|�'Ty+#?�"�7F�����	���M�s}lˆCO�_L��G����G� ��lH	k�hD��U�CMǈP�큠3a&����Ô�~ǔM=�/2V��T%E�U�f.���� %[�ڍ�ơ��Q�γ��x���q��0�cE��"�	�V�Xc9v)2�����O�������w'dC!�{ϊ�~�������U��,?��ވ��b&:�E�b�.��dE�يe;��c;l��� M�f�K��{%<���_���9�3�ʥ�6��F��Y�̮#18���CJ�R�(�|�-��p��^__�-8�gg~^Y�� 78�-��y,�~���RA�K��Y�OC߀f�=�uJ�-����2�AKA*0D��G7��э�gk^Km�@�w���f�'�0�~=�l���٩�TJ����ϩ/���os��8Zr�p�z�q`U	�*�'ć��r���*U��;�@�&�^#阢dLg���?m�8Qg骹�h�gK��nr���֐v�����%�8�(_�$u� sY�8T>_�B��v�B�EJ�~�? TChϙ��������X#�����o~�)�&�"ِ��zX=��|����-������jox���!�7:D�)�9�#�� $qB&|
���.��"�M�\������Z�����֏������ST]c�*���^�d�4���#�Z��k�J�m�/Rmw����OB�*r�8-�!汧���FĝV�O��9rY*<��x�_�d=D�B!�k�_.L��������-� ���n9�E�H��Ev����ޞ���O�!�n_	�ç���A���x�o��F�T��dA��4�'��,�T�{�)t��ݕg�v$ْ.�nC�̲�۽���˧���x�rp�����\��B��@�����QNZT�D"�B�����k!\=���5{@`(��W��[k���?�������D�_oh���~TDE1eho���N��RX�+�Aث����!�G)��O�bR� ��Wj'���8R���Nw6�Ć!�~|�tK˴CO��
��H����j;�`KRJ^o/��a�{�;�k���Z���<�&�լ��[\	G]�X��w�T�m�3*�m^�s�_�������Fe�5�⺼F��U>��^�'�b��cj��P��F�r���瑈2b�|�'e�v�(|8��a���ЀCdNPN5 �8��a�*�Y+[2x�!�RU�d��3f���:?[v��݅g��ަ{z��ޖ�8^	Ir�!�nK�)��+�I}�U��| M�\����ӿ!� )m1e�:I+D�1\��f'Y7h��yM���:i��4N?�q�M�t�WN�9�	v�땨�zx�������\����.��y�����#xg��Y��1lM���'�x,��|�;Lgj%D�e�*���MMZ�I���jkw-�����#�OoA�n����h�xP�乆È
U���5��i"�*	(_>�<�    ��k��*�,>�8ݱ�N3HQ��R>X!C=��)l�ɸhE#�D9&��1���Wv�s�b�.�7೷ʹS:��+*7��?���F�1J&����᚝+{p�2�k�S'�߼�oč A�E��ds�@���M�|���(!��>6���Rlp'~ܟ�|Ls��D��5e^S��/�>��A�m,�]Bp��}�B�u�<o?a'�6 ��ː�����@]'t�N��mKbg!��  K�դ�z��)�C@��X�O�|`ٔ����}&����'��#��c�h~��@�.�u���i
S0�����c�e]���Y�[\m]t������v��=��¤�G�&��S�-{����#���f	�>���b�O�d�T���6
5Q�N�=��^z��|��oNX8�ƛ9��� ����A�l[����;# �7?N9z��Y�R�!?X^��d��'�K�&$�����)�fy��{}�[Ϟ-{lB�(g���Si���tTU�L�1�Ϻ\�|`w������چ�T�����ɪkq.�L�Z8g��3E�Q5�B�u�U�i������|Nŗ��sZST�Y�/��f�%�A?xۄ;���S?��=(ȯ�p�����,������Q����['0����~��߬�m^�
{��,�	�:�>f��`49,�k��_��QL6��d;�����M;�T��q	��5,	�f���$C�-ɒч�hNY��u��<�p������ቭ��v�5��,Ǧ������Y��q��ȋN3 �&u�g��
��Ep#"ڪ$c׆��j�JdG!t_|�S��,C �:/��B x��!=�*[n?u٬��g���c��n���
��XE� �r��wRe�+��=��t(����N�'X/u��1e����i�Q�R%+/`�k2b���d0�LG��h�Q�o��3smk���n�������}�C*��̺bi��.{r�
K���� ��;��bq[�R��X �|�Ē�W�đǬ��[�.�[J�1Lb��u�_�7n39�L9 ����Cb��f>x��Z����3�y3����&���z궇�P|�8��e�t��U~��*`,�Db���O¨���\!�,�5��E�.p��8����n ��i����̒��`����w&m�/�7�'m'o�������}����6̷z�:�u���vJt�K/pHJ	E�"T�P9)��ܛ�~��_�TWo�/� ����:�%q �0N��w)���&"Lj,�,x� "?�'��=Lo��d.��Jm�� j1A�P���0����y*U�ې��
pQ1�Q|r�rF�6��$~�t�񁵞t�3����M#1��[�A,�pIj!)�b���V������a3*�����ȭ�{���"�0Ӂ���~-�t�v�OSS\�MU5䊡ې��eI�z���>��ž�ò1.�*.���Ö\g��Sng�����bs<��33 �)�;ڤwn*�4LQ��
��j��sY��8<���c�������^��y�4^2H`�Bz� ��zR)|@�j?v�)"B��8���Q]�u��*7��d���jܪ���� Ҭ�4+�峤�B�w�׻nF�=x�\t0)`��cHq�H�h*���?T��*�r��f4tvK�fǶu�qtC�L���,�Fղ��N�8�j/Hg�-;��NrT�Ln���pܹ=��Q�|0� *��G�����R?$z�a?7	4�ձ7��?G�w��M'm7eB�[`!����/r��8���_s��8���l�m3�qJ&.���dT��������6�u-������qt�f��Y�6�5yU-g��y���+u�Yӭ�D����^Ԗ�[�uG�4��q�Ru�,h�I��)?qW��Z�ӵ���e�@�F��6Z��oxz7s6\��,��B���P+����������7o��vK���&3+	+j�"���{����ȠZe�9�K�Y�t�hn<@|�1�O~NHn!&,�;ns�� ��`j���p��:��7c��:��A� ���(!�}���E�|�&(ו;ۻMK�b��R�L��WIWCrߐ|Y�7��`J���p���l*���d3�.��ţ`���Z�ދ��wu���5=H��^�Y���\ы���Շ_��X5#G��=� 1��c�+�� �~\��6v��<�su<ZHɔ�c♹%o�*���-(6=B�cl�#^�-��[�^Yt�<��y���}��C�L�9@�35T��������G�tL�MLf�A���~`:���I��{j �~�@������ �"��|��N�+@%��N v�,��I�jd�v]�J�{�����i0�_�-��V�bu�+ظ��El�?� �%�!7�2�-��Ā�Q���H|��"!JQp P'��ӣlj�.�@�x���]�zQ�e�))=^ �������q~����?��F�6$z|v��7_�O�n���H%pn�!Q�Q�����!=
�p٧�.B<:�����S��ُ�#��;& 2͓�v��)�f蒥�2�_P׳aZ�Z6�'/�.>Q��O����g�O��g�J�1br��y*�N�����C����+�~�)�4+�"X��ڂԠ��O}���B�� �<��1)@��A���Gժ~���?A�E��*߳��Pzp����q-����n�r����[��3��*�	��'[��U:4�ۏ̣���̤C<���O��kS��Ń�Z�����xK�������������}�<�uݶtC�u�_�T]�S�Y�TG�$S��v4a��R�s(>k�k+q��X���w^���<D �t²b��}ֶFQ��e4�n ���㛩��U���A�ـ���ߴ?��uZw敱:��N2�iKZ���)_����������A3
����D�d(�����$@�Ge��K���mz$�$C��CO�O�cNb����؊�8"Sb�V���U�'?��;q���?����]�n����c|�Y[('\�����H_f���)Jbȗ�NDD��23��g`��_�u�)�����/���:�m����e����;66
W9K"��`�0�8x=<D�;���Čh�}p^�GR����H�+@��%��0֔jse�a��ck��H�)���议9uCc��iI�n�oʹ�b4i�k���J���n�]9�:��G�G���3��9��jP�e��<H�u1�!�s���V3��"䵦�c!��Ȯ�dש�Uז��s� ��y�
��u�����xFv4��3i�h�&��QD�i�"KiG
�H����S.>;ՠSZqr�a��#7��v�S� �bG��L�%��9�*kfY����`�L�퍅ݓnz�tN6��gń���X7�����LH�XT�b�2��?SPb����緜���n���؈&^`�o2�י��ve�C7D�_�a�'"�����e�A����R3�X9�/2ʤ �C��eG~���1�]h�ۡ7	14M:eݓˋ�����}���{�j#y�_h����/Sf �?�J��_�t|������^y��v�@d���T��\�3�� ykL��Z�!@{�/Hb���p��Wc^�ݽ
��/�����aː��Ѹ��GC���C�� �A�i:�'3fl�X��1+��3��a̸�"�*P�	�sdᆏ��&��P���"�ᝄ�%�	�A����>�΂o�d�뇻���blGSuM������8�b*���[�4��%�L��O���V.7�.�KkwqC�5v�����?��0n���I�OԪ"��Wcf+%�߫����_��f����&��.7�ɀ�芅)3]��1�#"��Hm�ꏝ<�%��	�Ԑ,���w.�7��P����ѹ�+�.����q����Wi�TѢ��:�U` ;zb�|�H�ԍ_0��P'�b@aO��. ��q�*���M���S�5\Ó%[k0������d�����&FLGh)��I}u�<
/��%e�����    ������
Ȑ��sδ��w���������g�ρ&�2�J��q���@�&�H����ת`^��F40�@Ht� 5��K�H8��\���tR[n`1�p<�\����[�Zف�_�"�*Ӥ���O� �h�=�:�W]��K�RT�N��$˦O�Zs�ش}�cΡ���F��'�K�gE�%  \ʶ��ݦ�,�6�~gv_#����7$GvTɒ�zʎn�M <K��K��q�Xߑ�z�����f~�أ9������Z��*�CjL,|�?�J�5�0�ʶ��-勸x��^�k�"pYs����o~�w�]�g�r�������e^5��l��x�k�V9�f#�a���9����O�<�Y8)�I]�= ��̧x �j��b3/Y{���{*�E�q��vݸw��n�����vvI�ER�qO�4i�!iO��t{{����}�B޵�:E�؉K0�%���1g�2;n^�1�a�gEwt�:���y#3�� ���!��{D }������"8<�/p����|6�=���d3w��r�d,�����lU���ܤ���	�8���������L�DC�
�z@fH�R�M	Ƒ�>ҧ��#��+�)I�=���tl���۸��&G�,�F����=C9:X�p.7���xg�v�y�!��ʁ5]��tӟ@j��z���<jg-�S?X��eIp���ȡ��Aί�{�o!��q�g�"�;hƧ��A�O�Y��^ٍ��fب>s��0����{dT" �J��iu �pϚ�y!H���/'<X%R+lH��D��-�S�����`�y�j�U�1���N��q���a[�e�R�uޱ���-��%�#L4��%5���O%�I���H��$�L�򑡣x�^�=�i�d�aT�@Ց�� �'�����W�(4Pm`��Jď��������b��V�θ:��8�ͦ�Ț�ܛ�~pQ���tV���u֨l�\U�1�.{ n�#����������.����vC�Ч}�mFQ�����,�3s�̪�RN?���{ròO������в%�����U'�&�v�Lb����a;n>�7O�}W2t7o4��3XF_�"���W�����ir������>vF]-��(2�,� �[�-�x�C��W�uూ,�8W��Ӟ�$��4�o��rLC�xp����f券q'�hUL�M|N		���y��Z�U"���k����q	���л�tS����$�mh!�	2�"��Y��%8��S*��O�?5,��9n����i�,�>�jI��55tv7�;���_������ɳ�1�����O��D��?��H��P`��B���F��+;ɗ/g=:��;"��rp�<C2<&6B�ڈ�3�L��z�r�&��d��Q��[L�Q�Pz ���Uo����lt�!Q�H�7?	)	,|Y��:qȱ���c���IQ���	��?��	������+X��ѥ~�r��{�B���۫��Ȋi;6SO�g5�>�Ǝ>�� �-�T�ʞ��{��3k+�����g���ôY����s��XY��K��P���YM�?W�y�*��|x��_Y"
%M�8y"Y,� �H�&��\壛Ї��	�غ~�K���@!GR���b�u��:������ɘ��M$�{Pk=U0I��*����-?�4��J���^˲�)�j�c��ee����ȣ�mi��ڂ�\�ۧ����B� �=�ߎ`"�nN�6a�O(����C-f]�Dv�+�/[�Q&���S<C�O�i��MԞ`�W7׺V]�فP!;P�W���}�Z<�e�[�@�4�*G���P�N�%6�8K�&�O��TT0�S�bjZv�`��HO)�\��fF�\����C�Y�d�m �g�d8�԰e�����ȍS��}�.��cYSQst���;jԵlՐͲqi ��ғˡ�l7��;[�W�J����ZB^���`#��|�I[�|TQ�Z�[�~qQ����h���_���/��������Q������LN�*�b���l��)jH1u�]Xb�Tiˍ�D�&�������ŧl��<�[c/<D�ovÈ�f2¹�h�nܪ�\�}ƞ�������(�c�T�jk2 Sےff�9�UV�����B�=:9=�ڳo��pS�pEF��z+�<@T�U���By	B��r����������$H�ݠ�&�y��T��Y��ݓ�~ �-rANP@y��FE��G��M"
�(|K1`񜹺�|�n��+��Q��e8��j]�������� <N$$��p��AߓďS9_�#qF��2[~E�Gl`MF2������he����������6�.�+eeu���,�X
 �?�� ��ȉ�95Z
Yp�8Q~*07�{�-8�)d��R2bix�
h똱�-r��� �" ��g�X����U)�ɕU�<��u?�z}GQ"���qEr�>��e£\�Rr�p�3_����KY���Q�)�kR��xS*�s���"Ubf�,9� �64U/[A��Fq��li�~t���C�ٓf��#������C��{/��,�����߃�
ݵ0e;uȻ@�(�ʫ(��QQ�A�@k�@©b�g`��6]��q�
Q�7��n�c^bZ.�"���	��}F�Z,��1*�/��Y\���!�P\l��S�J����9j]���:�إ�!P:�'V�A�*�ZS��t���K��_�Yo#ٕ.�L�
��F�0T1ꇆfejS�/�`0D�Ȉ��jxj�a4�]p���+]�ڝ�nw�aT�󠲟�'���k����Q�;�}U*Q!Ŵ��{��>гm�]IA���W5��x��N?%Z�OJ_p�T�������J��ť0���Y̷�8���
!��8>*_�NZ�7�޻��"��D�*p��A֢ۺy���p1mR�(���v�8�����U�-?��c;�is�3*���u�mql��\��m7���`/�{�M�����"]�=���f *L1QU��E��Ip��DC��jYb��]k�m�x{e��B���U�Qy���������Ί�.��Zx��ͳ�m� ؜8��q�����nԦ�Z�Sq~�̝aS�d�R����_b�� }	3�_��q
�?��r)�&νeZ����_aZ[�'�a.%�T�>;&r�ê� tG��e�N���o~]}r�޼��KROR~ )&T⭧�� ���o(_9�N�p��Ǳ������3_~B-�J}	�Q%S5,�YQʺ���Iz��@5Z�`ŵw<e+o\ۣY��5sߢ&MOO�����Ʋ&�m ܇�Tc[�خ�|S��~T?��6�	��ݬ��]�{�J<���H桾?��pS}$��̳�r:p�Y�%s�*Kl�X�=����
�<���b"�s��f7�w�t�,A�&�숙;w��R��b����B��i��nI����/)��8�bˆ�2@i��E�vYr¥��ű�w��_l�.�+ƒ=�gQw�~������X�n��������ӄ�;%����A���Jz\#�%�?�q�4������������u�s��TK��fW���A�|���5<߬�,(<:X�o�E2E֥���v�>�ț�^�]P�������0jCubh�(>������Sl���B��:A��aVh��&��nH�"�_C3��6yrZ?�]5Z?���kk��Rл(@��*�rz����	��� �w��0I>����v)6�q�A�Ҙ��q'�x��H��W��'�m����q�+1���:D#��m�u$@U�YP�G� 8�o�Wǩb�`�*�d���.�q�Xļۋ���0i}�����D�3z�y�8̕M">��0^C��� ��Z������ң�S�`i1�씳�]f:����K�7���$W���di�0kն�,WV��g���q���}u�;Q���5B'��o��x�!%ɳ	 ��hr��"�3T7�:q��b����v�wx�����z���s�{�c7��Sr��c����<    -��zŨ�C��t[q�s.�:"YE2��bp�m��(�4<���V
�&�؂���&\c1o)K��w�P�w��XZ�l�X��w�,�<QϬ���te�h�6�@���R~�'����ެ(Ľ�-臾�;a+}�n�O9�9��9r	V��T]�y�@g�� �E����X��e	�A�E�w�.g7�F����h�a���+
��Je�<H���e��E!,��I����I�0�;��! i��d�j����'��B�'�q��ٺ"���uZ�&�M�\�on�l�Wq�������G��^��,�GZ\-��h��-�o�
6�����T�c<ш�����^eߣ��h�Kh�)�<�����^�������z&�I�dL�ИnLj�Z�
�ɪ�k�K<Ҹ����R����=��>�n
�)3���=����݄�>3�V�z���}�=�}-����4�Vm���P�e���z,��xв���e�~t��>]P�d;̣�&.�׼�n���]"�w��t4	�:QSPβ)�d���8e7x��h�{�؇s�3�u���g��a�fB g�H����]�7�[�V��{�����|@�i��۴9h5#d�����KHIM���gC^�	!Q/.BbUܖ�X�tE ���V��S6������Ⱦ��E��F�},������uy��.��iA�}ie��EAAs��CJ��?����@ǋVQ^�FJ!6�2��a�n>�r�k�ӿ�%���@Ǥ˓	�a��� yL�:�i:��p�esl���1�FvYg��0��%�4!^j��2���,"��&[�p]�1����p`?��!@.�5���`��Kӕi�`�9Ȟ�(�����2d���2l���⳩���oo4��d��r�5/:��Ƴ����w ����Ț���ma?)����q�F�V60�axQ�����CXS�퀼�֠"�/��@j������V�sQWy�w�@�h��9���c��U��*f��V9f&Fo!JQ�1m��jݭO��������/K��p;�a���J�b*�Q���^U�a@�Sa#ȄJ��hJ��<��?���-��n|rl��q�������,6̿��8���c��諁wh}$��9p�UAŀMʏ#�J6����զ:@S%�)��o�@�֯���+bp�g��r{8�����<�[�~JލD̰l�o�'kDF��6/(H��?��2�Z��K�+��\��|��.�yJ�1��j0t�z�p�6|2~vZ���>:�}$������#��Ɣ�\#`��)��ز�7��&���;�"'���-h�㔴Զw�j5�ݽƋ�k��u������|���pF��͗^�w�쿏E�J��2�GaXs#ʷ.q�SްɐU :)�aHLjtY1�s3����p��U�]>�ܽ#��r���l=�縄F�HD+#��f ���N�tYD�Q����p�Oڜ/�������B�h�����x��/��Q����1�e�5�vtM6T6R&�O�S�%��.ù���2M�4���E��vZK;N�mFK���\�p��ƭ�9	4��G��5������S�8#�������	pF���X�x��C�x[����Ur��'^�}�D�x�OO�,3�/�*�6���	R�y��k��(�����,d~*<o��#��\9� .�|�Y\cZ�Y��l��r�6g������NYGq�i+\ܺX��W;�{�k���~�0u���v+-�E����l\���$Ѐ`9	�~�$w�d�(,e���o��U�K.���)o,ʼn���mc��Xn,69����3���?� ��n���$j��)�.�̶�%�Rx�I'Wؒ�!�4$,����mR���=��z������5fy�)��]��T1mմKw�w��+2@�lCb��u�ie��{/����j����q����j�@n�kbO�1M��[��s\Cc���q�,�5��($�3��)G�x�V����MR���� rԼ����ʻt/���7H�L�1�? �R�Av*Kę˅�x�ǉ���(,ܷ��*��Q,�T�H�<�	�
-	W�K�P팔^ �Yg��c��ÇD<�l���fq�)�����+�x�\6ES5�^��i܃�%��ԡ4����Vv/{z��fݔ�7����Rr�.����� �QL
D4�X����}�;.�^����j���wR�%�Gu��og��A�Ku�v����oP��踊g�&p�QѪ���;Q�Ž���Gs�Gs�8�G���c�����񜠜�(T�!�"��8,�n1?$\�[Bk=8�m�o}�%8�)N8��4 �tˏ�l�cDJ�j�]N�`טrS���:��隺Њ{�u%nGb&iK�c��6���U��Φ����zg{���z��s�1Q���Ĩ��Oi�P��w]�'q~����6�57�T�B�[#��V���p&��TN"pA��IF�Hn�g�����T!�6��^V]�@CzT"OSF)/mx����`&�m"��#��R1R�1��4P	S,��7Ģb���� ų�Ҕ�l��t$�:���8�����H�tB$�	�آ��e�^g��goq�zc�rw�{��\�#��C�EL�! 3�X�u�����������l��1�ԓ�	B0�1�O<%"1��?m^ee!��V��zWy'o��g�H]M�7�Hx�`�7N���m�c{�5aX����@QO]�)�{M�3�k$�D2djBACx��=r=��<�/]"TZ+z��,�1��}5��nٲd�/���-���7N��ޮ���w�'�A�j�Y�ǽ�g>4�=1�8���wЭ��^V+�(xD1�!�%tlt�y�NY��`�7�>�S%��P3���mԙ��U���{��zG! �Y#3F����u����J
C�/�'�$� 	_�5�������Q��*��)w�)�)vf�[3���\���V����-]m`�o��>Ւkm�U��[��L[��p,ulr���o�E)���ok�>.x�6���e&�H/c�B�|�N]�'�_����ym}^7���{�8 {�����W�y�w�ab��YW�L9��&L���B��>�
p�dJ��>����6¦�<U��\��#EB�NSKs����S�I
��iȾ�3�}�T�G&Y��}VU�����S9��������o]C�#)�}Q���X�Y�-��<�c� �'"O�������	��'���̏v�(� �ߩ�y��wKOu��:? ��p�2�D$ �`��KX{
{zP��+q���r1�?'�N��X$G!?�{���$v2��a��Od���=��[��$q�����!�������u}j��n�D�9���գ��\���E��Kҹo^_!O(_�2? b�(5�6W��!��͘�������΂�␊y���`���Y�w��hV����O*C7�$7K�H�':dK/�y�o���jU�=,{E���T�����ɏ9uB,f�`��>=Q�Nc'%���y����!2��
�����fq�)]9�05�F6s�RM[W�:��=�QC2�Jl �VY��K��r�D��{��3=�[��|�a�8͸�Za\xl�B{�����Roc~�1M\ǉ ��>��u�х�tn��7.׆��ZF7��(��1Wyd����y��T��{�8��DGmTU1+\ߋ�q����J��Q�8��
�Ζ�S��Ĳ7	�;�T ;�m��<@ZK*����D �,I�>�'��[�QU��f���	/\��4h�u����a�J
AE4�m�e�'��ƫN�k�j�x�Z����,���dM\���]�:A�#��h�jQ��N���K��qC��rh2Й�����p�a1���ϯjՁ߇�����U�M�z��d�y��y��RMY�`Ъ3��]� ��'O����OF��ޒ�@�L�P�� �g��,�}Q�N��4��J2��\�t��$A�s:p�K�̋4Dоdj6|�uAig��Sg�_i�뫻f/դWZ����|���C�Z�u_}<�	m��n~G�n^+�N��Z=�E��    cZ��03�kp_��.� �gs8��^�Hnt���(��Zci��fd��
FfW�7��k��:p�O�Z7_�#g����{���I����@j�x��	.� �N���IM)W͚�S�W�5`'t�� �v�ly����kׁ�@�tG�s���e�����pէ�+����]��O���ˏ�0σ[��fwjB�&��Әo �M�.?�x"�~; ��&��`�E��n�&��Ţ2JgBT��������-L�� �W��=���.�����# c�����JyH��
{�EX҃�<�:`�L��%,F	<B��y�@�+�UE'/�.؃�Ѓ�{���q���JGҺ^R�xf�2$d6��[EY8@1M�N�K�j:�iEF��2���9���Bӊ��+���,Y�׆��-7Z �`~�g��`#�E��Sf���JJlz�A�vR�x��"�,���� 	�xd�Ǽǅ_�%�/y�$�D#��N��穖ܜ���U��L$&y��`�ܵy�k�p �]GsW��.d���*GAfi-y��� ����p��%$����l���x��JNk6��КӞw� �����'��g������t3ݍ�o��� �'.%Z���ñl[|k�jYA�ӕ������������E+�*Z8�
Ս������c�E�-d���"���3�v��[��r=�q�";3Y�O"�P���B\� g�#>��k������i�y+H|��Gz�3��E���'j�0Z���Je	&�C����*�"�|R(�"���) ݰ%��\΀4�J����tSU6��S��lY��w*�v*�uӓdˮ7���w��,h��P6ú�7�{Q�L�Ҏ=��t�-��)1ÑX��8�_N�0/�c��A�qا��p6�|�9�v�$�"%��=_�"�%���<�	w�Ȩ|���i됹�)���F %��w�KCNs�I����<|���-ˆ��[�Evl�QE�$��n��ْ�h�˰�,k㙿UWc���N{�y��w����`���������ؿ��y��bK�f��D'U4b:8�H�����7_��>�Ŵ�x#����u#����y�_J� ��wŕ������R�s���f8���|Y���jU� ��4%��bD.��m9�b��n�IP�S� ��&&�`�])I�6�Q�x��Mv�=qB�.4#d�jH�,`V�Y�#z��`��k����W;Ѻ_W�l=�K��ˡu]B&q�Pڝ!T V5\�I�
��G���2��|r8Q���^�3���*7eQ�������4+����}�N�n����,fkް�yfB�����چ��T웬�[�|�K`ia� `%�Y�;���S.�z0���f���ʍ�h��;V�K�y�)�#���'��{��4"�����V��	��t�w�{~t��v�;d^�<�oC�֗�pi����Ƈ���v~�8��o �(xH.®ܫoC�i�ܰ���#��V�ſ{.@���>̌��'u�)Y����P�Ӱa<�g�0x�/�(�A�dp#N�b�C�]�FI���;�A_�t�HA�P(I"幛��}��u�Y’�[�և�����"�@<休,�҈5D�lC�L����,[�[O.����f���k�w�2R4G�,��,�� b�ߺ՛�} �]�VL��,NpG@��0�o2ﮋ����#%��_�:<��vaϳ���p����f�rZg�%<]+�?5!dl��C:�P����7��pb�=�@[ ��&�q8�y�(��"js�}�/0�u���/�wb+2]�e��M��V�jm`4�˵vpp��U�|q�����'B�1$`�̬��S�D5e�X�A���߆4�,,�-�F�FY��EM
B��P��M� b��GD>"��s�����\W��	o���л�O�P�|ı��YĦ)��.;������?�7�m��Bϒo��Baȸ�OR� �#�KG)�.$�S�`��G$$L����N���3�{_��Q��|Ȇ��*J�\ݟ�!R/lO+�]�x~���^I_.ח�z��{����o�P�Ε&�0@�Do���]b9�a??I�K�At� Y!.��XN��6�+����Á����r�Ny��� ]�A37ӡ����qʇz���=�;��\�RE�ŌBV��J���P��d�7�~�<j#d�����$��_H��}�^
Աz��ٝN6�>y�Ե�Ӑ�n���U�f�<��fH�Ɠ��ꔵ<�يS_��{�wn���/䐋�o�<(�@��[�7Dc!�6OKd���c�Z���A��@]ദ:/��2|udR��# FC�4��ry��,����0��<by�:��� �ӹ�Y�]�*��u��A�9����>M,�]R�akCW��rH��cZ(t�ܞw��Mix�^
R�D�,ɱ��Qz��:�t�EϿj����f�:(��ûd>N��6:s@�!���������!��'�:,5J����v�2ì`�[2f7��H���<�K�*��Ng1G�Fg��X��`67��$��-���"
\��&��
��U�[=�{@�:�� �FD�F��3�Le�-�m -r�y٣�]���B�CGb�If1)k���ݥ&�"��5bwb��_�C�f9�d�� ��l�*i�G�O��g�F�^]�-�O�6âB[~d�U�!}L�6�4��� ��|d����+7�B�1��"�J���0����`!�nJ�A��ݻ����#A�1/�Q1���,n}Ne "N�y���������#Y��#����\:q�M!��V���Dg��)T���?CD��m�%ħ?�,H|�UJ�
T>̦\�%i��J�uda�����۵�.[^�}��s��ƶ��h�T�`읈���1nA�+Ͻ�	�q�(2"��3��Uއ;h�귄�Ɠ��b����y��]�t��(nr������lN�+˰�S]#�%�H���@����a�+�pǟ�	���eA
H�q����	�9m�X��˕��8����[M�IUYS4ùm]ٖz�ZoH6s�u���CTKs��jz����`{�,ܗ��ѳ�9m
-��5v��(����觐������k`}���#����q�NG��Mx�j��,�P���<�[�����I9ܤ��	9�7�V&As����ߓ�ڗ ���ܧ^!tcrq�r�rg�;�z�	�ـ���5��|<K����j;��޳^�ji�Ӊ�������l��PC4lB��r1�G��FMe�����g!�}ʼ�|i�o��4�a�d��%v�xU(D�G8�����@wP
��� ��#o��Ho�^��n�c[
Y�m"E�T=����o[n�1���\��?�K}~��B�\�Û�S�����Ϣ�V��;�����l[b�`�]��.k%��y���d�vztu�^�n�����)�C��F�ũ&DO���/޿ ��@n00�_ q�|�/�
�����;�U�?���V "P���w�vf9ۊ��Xbq �B�faِ�(Q��'�>�>@�g��9�_�@�������?p���I�(
�A�F�i�
mZp:,���4�
��{!,~���r-i3�ش�sAÏ=���=�����o8Ԉ&i�jI�#��#���/z��^z�����-�w�A�\�{ �6��TEL�v���D�F�=Z��/�a��Ô_�{I�F��{�9V�L����F>��/�y�@W�#���/Z���U�Y6 ��E2ۮl�� q��W�*Ob�`LZ7���+�$���"8���������>D�|���r��w=��˘Ս\�l��d*�[�gK.�ӭ.��W��J�����^�R�}?�ѽLD7�70��'����h�<������爾B;�!��`�Ws���K�j�索��ʸ9���:��/�&C��S"�s���kaN���y�,�C��j/E:U��Q(����jsE�    �.�{@)���h�ZV�b�3ON����C�R������_U�R�-۴��ũ�N��.N���U��ć�zz����G��@Ԩ��[��9T �� Q�ؐ��71VB�jv;nbt ����9�X�va��F,Po"�J���2q���y�3��djl-T��G��¾�� ؠM6�0�1���\!����;��W�u�G��4��B2���{�$)A��}A����dB�>b:���%�Ӧ>�F���7s�T��>�F��fŋZۯ67�^�56Vͽ&���
z�y���K��;ㄿ�,�hlJ3�G��g��ѯh<&��sO���4L"|!���	�<Wy��<�ٚ7;�v���N�Gq�����U��\E^�U�˻�7o�}�6�^��xl��$"D�tW��2X$/M�:��>����b[���T��Ϲ��>�M�dp�eZ����3��l��n�ro����.�u���ק��*2d�i p���F �[�U�al,.�����a�a��8��g�����+�����H��B��^���g@�����Lʼ��hI�m� b���Ne��t��	"G�|;u��v�5u	�$�M���w��[���I[.��:�dO*�^/@.�[�	%Y���i{ZrW��(!�Ӌ��m�W�vO���e}��I���xw�9!�	�giï��{�r��-�!ј���ﺌh�z�!�Xw��`����l�e�A��"B��"�K&��6��_�f޿�U�Lj�*&"�#<�$�ņ*�D���z�Rّ+��+��!����1e�����c�kS�WOp����c&d����ܘW'��+R�9���mF���su��|pH�8i�CR	�┤Q��U��D1�Jl�PU�$�@G�Ќ�Dx���N�ue�.������@�z{E[pC��75�DAN�-`��;խ���� ��YX�a{��,��R��0^�x�����}�dDb/�~я0�sэ�>5[&Ԏ� �����!W��ӉX�{Ds~��Ag��U��O�C=�"�V2V؎g0i��y�f���)F���t�5,;#o����AB�	�_M�*`sA�+E)��|�SO6շ��h	��頽�P}\�����������u����YY�.�͍���>������v�Ͻ�]r�;>��U��QS��0�v��P`�/�E;FW�7[���H7@�4hF�e(ȧ�J�m�ޓ��̾���d�*�2x�zU��|�;7̏��*.�`;d��.W<*�v��:ӆ�������i�6Ӏ@o��G���"� �;hQ�7���w�M�x��d�r^Jv���oi����Q�"�6uv����c�H�cY�%�dۖ���݃Uus���ݏ�+��/G
��5l��P!-��s:��'�HY[]g��������Y U�V����[ ��q�@�n4Ͼ���X.�ބ�3���03}A]>�CBR���-��F�v��E臲M���<�;3��N9�NiH}}��7U�"��|�����&�>E�CD�~LP��So���\vi�Zn��?z��+�A�ZtK櫧<�����˝u}t�Ԙ�/Y�*�(,�4��t�b���Z�~z?���Wv_���G��6��u��.�Å^5�kn�jձc�a3�@-Ǒv��h
e���q�,$ߖ��M�m�~q��>�۝���[�:o8����q�Y�-���ց6@tgqDEa���Nv��	-+��C�OU��9�w?��i�6{~�������ȿ臝�]ee�<�[�%M�yϮm�fY�Z}[��r}}{��"XXY�XY�Ƙ�)ae��#m=8*�N�`ʑl����Ǽ��AKm���F���N�R��I�ُ=�!��uV���V��9�������FAu�ƓSM��C�lb-�gn���D�,Ѩ��3����.��~��@�C�B�f���%hG����o�Jm��*q����+��ɧ�Wʱ��jaW���a,�6ea���e�i�_.5v^���jy�^d�\�l~�Ro�� ��w&�c�B�^U@P�c���y�:Wn̐�HP&fj��5�|�����[x��6b9�A��:����S��]M��(j�ZX��8<���R�x	��-/�~"��s@�g���pɖ������d��N�,���g���/Y�.K��p�&MQJ��7�m}�,����g�����/���sDl�IZ�O�ul	/l��et�T;�8� ȲI�I� X��",I��77��Xl�0�qbz� �%KF�/Mc��I��5-P�r�xa�ʱ����C�s�C�-���_"CH�p���c!��-��
�-�ѷ�xz9��\e�n�Px��qS�l��4Qx�G�Jk�[r{��
V�+�SŻZ�;+^�C'�;�`��hv�4~b(SN�ͣN�BX@�}��Չ�0�}��a��~����N���xu�'���/��y�^	���6�~�-=�]�d3���r?ʷq��o��P����<�ݍ,+ʄ�.< �-�9f尠�ȓ��%<I��N
�IY!�I�u.=�X�J���ʔ�YW\W�\ʝO8��
��}�Y�b�Z��낕}�Ͳ����;K�n��s�{|v�{�j���h���Rk�W�-��~d��������A��^�� �A-��1k���~WW���\ޗ�md��@��Do/��4���8�c�w��f5���$w����cU���T�i�e8|8����ɤį ��/Ԇ	��8��&�B,�R1w9״x6��-a0��I�
I�L��@��Y�3�q����z{O�?�{�)����י9�����jÝ#��_}?�A� 8�����	� �¢⭁,H,-V~&�� |��n�o�JƗ2��m�Z�cW�)�L��r�� Fn F��Nܕ�j� ��J�Нre�Y\c�'�W���B�X�aI�i*�f9\�V���Qu8ǵe*�^��I��N������ӭ�뽎��q䷠�8�� �F��Ĵ��Q�E|���	AN�IxH�C�goěE�'R?��5Wy�����]m�@�"ǩ�� �$����8�>y�(c�Vݹ�|��#,I��PTl�S�y�D��wh9�K�;�T�������^/���^�ۊ���s�-���`5�d��iPMU/K�{�R��)�]�<����b=��vN��R�ؠ4(K_	�1*�,E��'01q�'8*�<@��2�p:���� �
b	*o
S>����t-R�O�f�]�&v��reQ��'&��In 9��|M;=2��n&�|v`�s-\��'�>���D�1�!*��H�{�Z7�����ொ�8��X���e>�䝹|�90�$�'�f���_�t�_�`�LR���������&[�o�l��I�*�@��R /�7�<��by�ߠ�D|Gt�C/��p���Ml��w�@3:o�ּ���T~ ,ժh`�Je��A�ǵpId~��P_�o<0�a�^@.i�ل�ꥁ���UԊC!vD���$�`�28*@z)��+F������T��ӮD���H�~��v(44�K��ؒƮ�6��s=K��E��Y�����Y��j��k�#�����2�lq���S���>}�3"�B�)
ZA�C�J��FLuAx�@�*���z��G����S^Y#�քI��?yߓ�y C���k���&��%��O�-�M�<X�y���Q�j T��a~L��I���A�1��B��;+��1|����9�^��gp����l?f$i���c��M��w&)�F�Pr{���<z����^џ���Wu�@D�l���<b�hՠb'h3��?���Μ7�.-�֊����Cd���C1X�3�xg4��"k�$�4e�9�84o
2��P���?��M��.�����~ �! ���Z�gt�^K�$#�nuJ��I�)2q�0�������%�ٝ� ]�J���<G�xI��*vB�G���3����M��ޖ�<�]������u���c��fi`�v���N��    _?;�];�܁��y�ҫ!��ğq�z�Q���%���@OpLN7 ����Lp_����v�M����uE�_��bb��ꍠ�Y\?Y����v?"�'��G���d�$��R>��5W���mC�=_���+CYD��
��`�
$�����>M�rB��tE���K
�0� ���$[�$E�X_��6c�`k_�:�}�==6��0l[ql�t�2+y����u��|$�0$K1E�ؒ����K��|�͗Gi��kgF�l-|�	7�]0��z�uh�ZՔ�I�qCi�V5T��G��H΋n0ڠ+�w2����m�6�s.�D���$��<�[|��:J�OzYC�S����\��dm���y1��:��V
��Uc�p��P60�i8�Y�TSRu'��w청��W˭��jQ��7��˻��O���U#�	�K���v�����#b�#�w�B���&FFn����9�  �P���`�B޵OU����2b���G�JE����љ0Wy�������f�����T�q7�W�q����ȩ�"u�J�>�hUy[WUN+�Sb�g�;�� ���n �bR��+��|�{_`
|�+�0]�3�ʆ*i�,�([)�j/όK�ehv��ϛ+�W+[�Q�����\� �|�A�S�R\�����lD�\����&�g���x��y���g��0���ZY����Х�a>X|zZ���T�?Ԅ.:��3������:���'�f���`�yDP��[7_�zq��:��O������y}��k�|@2�6_G*,۪U��s�SO�aB�0���MQ�y����0���U�wd��w��/�/��uv�.�ϭo����q��!?%G���k�AuïU�!F��?��@r�Ŧ&x����:w�^�*!�O�6(���.�]���,v�R;�\�ݼ��Ϲ�����b�b����4��E��"zʘ�F�f@��E`Z˅�%��D��,KL��.�~��SHd���w�w@��66�)�l�`��i�bHl��dS�4ՒuH�j:`}]b�����e-�>v_'��枲v��u���6בǤx�1A��ܧ7I�~h�F�B!�&�V
Ě�@� 7��h�}�^�� ����Y��M����MRC�Ȗ Ys��s����y�����u���e�۞���+�� ��D��h�J��h�D?	6B;).A�CJ�����B�'���{Wˁ��;�T\�N��z 1AH�� �c[��}.�|���]��/^���OOOOM���,U@g�|�u6��f��n<��TK�,G�-����`�U�0�����z�}�#�7��>2d���s�4�IW4YG�/����f���:q��>1�
;u���_{U��k.I�F�6JZ=�Ֆ	r7m5�~��:ʡ�W���ʌ��9E��Yv9B��\f��Lu>�N�Rx.Ro)lCsD��}V��J���'q�ZW�O��j^h{����FZx�������D�1��kU��,�ϓ��{l"�����#`�K��?��48^<���G4�]
q�]%�}�\��{����	Q�P̸����,k#����Xs�`��y�Y�'�AtĈ���V$�����K቟�������[Q��H�2���2���3\17 ��^ΰ�y�)�S6�~i˶��%��Rv�T��ӕ�`a�l�����Y�lsy�P8�9��ӿU���곹��z���.c�����F�n��3(�3]�DT��'~t
���^�w:���`�
���ʶç���HR<��i=b��%�L��!�;ͮB"K���B�#��L�o����H¾��\���PNj�.�J�NR�C>�+�m�9��H���⳦�-׫r|x}���oHG{;�����g'���|z"���G>�b]��K�	{�(�O�[���<!c-���ݴ!�!���\�>�T�#̅�zݦ�z���*��C�`���Ĉ�Ms*_�/��>�I���:���^�?@��7f�b�+�3������� u�>�t5)�UJ�x��[�Tu�4Y�5E�,��d[:[35�Td�-�IyS����q�/6՝g���`W߳7[�N}-�����'��빙�DW���IF��^I��Bl�R�̲����B2��v}��
CI0��}	�9�| w�w���<���,��Y9�J���>,@� �
�ʓb_��I�#$V1���@���8(/����RZ9��4�6ӏ���}K�̥�h�g�,@�}�)�ӽ����/�s'��}��w���Qz	b��B�a_j��2�����
׾5&�����������$����@�z@!@��C�oX��@'iA�ۊ��ۚ�d+�~h�-B�C�K&�B]�,��%�a( B%	r��(�;3�j?��Dj�����ҁg��Z1u���	�*�l���Se!��m��`4�4��O��?;e{-�ų}u��=�hv[/Z�t�w�4B�9 ���	2�&������:.���72(�
4A�%3״l�<3G\
�터^���6 7��	$�����L��fb;&"A9/�������o��a�	�roc�H	�m�Tt���=��D-��-�"09]2A��p��Ru[-�ph\����Źv��r����9�q|���3l��V(^�_`�Ho�~�Շk"���z̹U�S���n�wE�/��A�/b"��2��ȅU�lDD;(�i8��ͪ�1Ny������B��| ����J�C�R�U@�ldM��	ѷ提m��q��Q�f���a�O����&U�ڠ4���C�G���Egm[���%M�x�{0 ~o�9��4jBv���j��4$S���L�,�~/I�tC=<��W͕�橽�,v=ற���w!�?���o����/�ڭ�Sj[�B�Wc�� �a����E1�ce�VThSxGol6SoW��K��`H67$��*����1�����2�ů��}R}���VL��h�tR^�yB��/]�}�"KW�Rp��b�$���r��}�?=���%u1�+���.޵c���70U7��rt��`G�ol_��WW�I�u��y����S.�r����)����[qa� 0������C�&.�'su?=s�O�������Uύ�`dd!���h�pr�5���x&D�Z��(���>�Y�m,�9	Km��;�浡4.[�~�"�.a{!�Ez�P�K{��N����( I(k��-�S~4	�I]� T�@� ��m#M�A*rvR$)D]��T������\�kA�e���� ��0%USl�������u���W�3���Jg�!��[Nޣ^��U7����0c���|`n����kK�a����At{�0���??�b_���W]�A'VހL�d�Ȉ�RY�(��d_� �� �����ѣ�b_n���~' ��@ɬ�XtҊ���y�T�'�)P�#���B~:)fuSmQUJn����d+i���jIÐdٶ8�E5u�k��,��R���>u�V��nWkxݓ�"|�aFX��^��5q(`�ŁBJ���{<B�a1p�4�:�*�I�+zc����
�5p$���;%A�-�2��p���o "�vzcTP�t�0�rYpGm������eJw�Trd��@_ �r�)5x�$��	z���Q�C�4�'2�.C`$�c�eD;@Y�����%t�p��w�����ۍ3w�T��ql��QK�H�ը���]ވ�P�ж�×���F�t��mJ�����L�O8y�F�:�A`�av��TE�*�.%�]�BP�V&�|	�_�ak�_�v%)�������9����>M������'�����hu���e!�w�c�\w�]���cw�:>��t����V{����pR�>x܄�^���h;�dnD�->�IH²W�!��!2���}/0%2K*�M���d��i���H2mېl��r�����^\[��=��^�t³�#?X�[�����y�w��� 2	��J#�=�I(Cy�W���    .<�)5cp�n�����!��(E :o�=�M
�I���$�4Wy$��P�v���'u.���Uv4i��C���kC��UW���4�.o�@"����bB����͓j�>D���*�Ľ�v�]ZC�`'?t4�/�Ո91ԃF��]Ruv�zd�B�	~������\cE�öjJl�~�ˢl:�'�u�b�~��]������R���0@T�����C��f7�$�����ёp'��y��l6 kG�{%�\�*�|k\M@����"���:p47>ǀ6�����O���9�Z�6���rj���A���] %@MF��?gsW&;��ð{f����%G�9�V��v��׆rtL@��9y׭����j�"1��g�)�Vh�lG'���V��^=O^��nȽ�VE�]�%U�#�P�7�Ƽo�6&�6;8l ����H�$����G$UN��W�%�ݻ��L�<:g��I蜜��a���jFQIuX�a���=q�q�g�����A��C	�C�7B2(l0ƭ;.޹%����S60Al�^6mG��CӐ�gS-�C����f}ǉ�co�xk㥹��d�\��Yt����~���m��ĭU�8��x��3������Bz��Æ��E:>y�+��fpl�R�L�G��ywnh�3,���=��A�����_Ъ��3[.��C�l5�o�'���/�B��^�*k�G��8�z����H�P�4�!��-H�R�T��;pF���L���:�gN�W�ﻝ�/J����m+*�]𑩦\��:�.�ώ�{����FW^�\���_��[^ūA��E���w�F�/������8�_��8�7�����`��C����H��h�ژ�?��N��`_�U��0p=/�|��xȻ�����ǉ�V=���]���i�s�`r�����H�*Ш�\��Q�{��tb�y �z�d�,�5	?��H#{
:r܍�����I&�-,�ҹc��)�֙ߌO���XJ���m�;{�=GñF��-��!2I�7�y������V��}u��":v���9y���?>�h�jT4y�-x\ ����TV��q��ݞ��_���+�`��ƞ�=}!? K�BK��P��6D&e���'��e���*�Ru\��=�$�
t9�Sn�(}��_�P�4W�o�n�Rd]Ͼ�*��͆��Y{I�?z�X�?��U�N/�����A�@4#�2e#H-h���@%�:���K�7�Ԫ�7o�W`.�Ab�y30Ey���'��a_�djC��n��\�&��=Wy��|�ٙ��2t����`;*�lhz4D�
����|҅�:)�����#n~4Ѣ�BZ�*�5������������S�vJh*�mݮ�+�ji@4"�Y��cؒ.;2�u���V�l���뢿v�g����"�̭Q jNb�����H ��A�V@�>��ԕ�S��,ɰ����¦�y�2ɬ)���{�RK<fC�2�͐U��(��>>�l��ݲ@������8V)�Z1�-���P�6�4V�/81�c�6^�.[����EL��]�$R�X�[.��q-�G���6�E�%�$"���޾�+��k�])��ˊ�H�j���V2sG/�P�����������]u��(dY�rf	��E�P򃷅��-��x��n�:�C��	��Qz�{��4C|�F���Df�S K��l2�_�Ϊѭ��?��x�YWc�ɘ��fL�t7���u�+���M� =�[�3�4|�W��(�.=<��Lo'fO�!�q�aO��������ON��v���C��H(5��%��gu��mO�yL,�����#>kr���|�y�۩��Vz�Ro���� o֛�A��bV~<��Hŉ���Ý<��aq���̽7�Ϋ�!~�~��t�k�U�nf$H�=��D�g�w#N�=Wy�w��<o�ƼaΫ�m;����c��D^A�#^9:��]u�Z���+�ɾ���D$>��a=���$s#����_c\�Z�T�A9���G?�����[�KgvW�ޤ��]�s�n
�ma׊ak���~6���/��s����bo�X����g�B��!ƲF��(��S&��(N!��`8]~U['4��L�#2�^�����s<o�:Ĳrۦ��i�lک-W���z��-��t�Pj��=����z�M����~g���@j����-tJ�:��6��
�g��<E�^ʀgr��m7`+|#�&��Hy��F�jg�d٦#>�9�^>?Y[=Q�C�����}~}0x�ߕ�#��8�~\��D�)�?��>xX"��rk	pҽw�f4�(��8�[0�ن�#�ei~bRi�\��<�;~��7We^�G�a�\�0W�����&�I������B�o_9��`&y��
�=JķRO�B!��8q����}�Y��< ���$�g�gS-��;�7���Z/��峵VoeA{qp�O2O9T�e�CtV4h9�n+�����-�������o�=#!o��~qR^�f�ܴ3�}�5c��b��8K�`�6Y�����E�"{9��7_}�u����D�7��	p�� /F=L�&sm�Y���>�g�ٔMYW,���6l[7%]W4Q�U��p��W������������y�a���y�[ļ�'�n��
s�HL���x��#�ʨg
Q��y��K�ȳ a2l���_vǕ��2B>�Q�H#��9a�W��<����=B���1F���:d��\�Z�u�SN�
���3������Y�A�F�O�`"�r�Ie� �|�;��3H����B��U�{�SOo�����M���*��l�ZI���#s���T�.������D�����Zw!_
3���25��p"b��)O�>��kb�@��2'��`��~P�#��x�����Y���s�ȟ�<������Eç��<� ���6��2U����D���q����&���TE��o�'I+C��K.1�r��қn�a�`2(DÙ�Ԓ�'�=�=��v- ��hb*Sl���ۺ����KَV�������<
����+���t}�WH����>�C��Ƹ���kRUj�B�YՑ��(֪C���D��P���Z���˔�T!#k˦�&a�������y �3��uH���*d�:m�X�H}u0Z�[y��sr�q�y�j�V�W�����oﰧ@q<�D��.��H�\�(��u�s��(]I��}Ķ���!����8�{�d}e��^:���Q�$�/�{Ŗ�/��Y�%7rnł�����9�%��\s��!5�/ȿ��2̆��PB�DM�<$M�<�yW0	��I�1�$~ �I#"f�b����W��!o�@fl�F���[����l�Fk��7L�3��ûqlK�J�	��|Ӓ2��$)�M}_$`4�gF#1-���@g9^��m�^�v���[^�Y(]B>�u@u5�[�EƸ���"��߄b5Ͻy�u���rnܑ�.7X.�9`��|JVۋc��ؙ~~���XS�$��?�Xa�����p�@]�|���"�Va{���8 ���iZ���)�Ѱa��p�)����Dq	}�HD�-H��j��/�[SP�2�@��☑���q�=�6ף�fH15f��lf���-���[F�;0����g�gQ��ok�1@�q� �	ܩ!x�Tk�霁耙���P�ヷ���P���9_�3#��4�ӫP�Q�4sw_{j�<[T�a[�?����O8ck�ge��+? �l�=;c��G�����RZ��L�I��v�A�_��I��֣(�RK��� ��P����n ���-���VI�ڙ\d:�W>�YUdE�$�0ŲUͱؖ�H��˒cي�3��]v!0�`�e�����v7����F>M���;6�RH^%�B#����@���m�"kh�J� D
; ��� ��C<���n	���@{������Ǔ/���S���)z6/D�ʥ�U��>�d.j/�ʼq (��Zh����&?^`��l�&X��3�n�nny��!]��E�B�^p����-�E6}�9¥    O4�M�'���l���+�dH��Ȓmi�ˠ�T��|y�pq�9�[=�����Rm��T��%h�b� 1��A
��n�R�E��k�τ(x9Z��v*��_W]�9�]T�u�/�'�� ��k�hLy�	/�qa`>�19A�#���2�������!)��6��T��0�,L��L����/��z셲W�KjUM��nH�;l��RNyi{{�s�A��c��
�"�x �J�H`�%��QYV˕E����JT�0u��-�4Oe�$��3BJ�~�[��j�n{ג�rҌ��J��O�.�^1 �'��d� �/��}�$����b�T�6��6��5j<�S6%�x� �h=v��?e���W�Cb�lQ������A6�����:�*���<�1|�1_��q;d�����L�xZ��b��[]�朁��ǅ�X��/шr9��=N}��S+n�ll�@��%�}t���������e���i�:�i�xg�dg�:]5VG�2&��F�:�v��'!-3�C��*�8E5-��87������h��8�y��)H��`�&�F��CXw"�|�oq�s3oe�m��2UH���#+�*�̥)iIAe'��1�� n���RV���(	���3�0�sKxn��֓���m�1g}�iCK3����7L�PM��$U�T��4���v�>�Գ�#��u��Q���A�X.��Ǳe�
y�y2!�k�U� �MA/���sR�*Js!�$ Z!��}�)/�?��bC AE���el�vy;�)`��]��������
� �y6����8 ��T��� "Б�P)�=ϿFO��~ʍ����AG�Nԝ�
�"F�R�STL�Hg7P�J���jS�ՠؚ0缎�����Uj�L�.1}}R�[�Do����[ѓ�bQ]�����������O�B�1t'���q���%����z-��Ėf�Z0�����>e��-"G�]2r����F@�Rh��H�@#[�b�]�;���8h�mf�����(�-��2���<����y�lިB	��@[����I��Ƹ�@��,�}�W�7�G{�&��!a��Dڐsu��a�@�K�;8�xJP���&��K�WضZ!t�+Lo �_�RdE�4͔d`SidEV��-Y���[����Ń����Eo;��m^ꭷ�ld����6��rF�Nء��~I1dN�>�<�h?8w������Z΃|���7m����=�-3f���{���`S����FVm��.�G�Zfg�)��c`���1Y���R�U&��-��ꋾ�<�T'�G�Xؔ�Y��\%E|rT�f�+�����(-c�_�W���g�v'��6_nm<�ϛ��@�Var�k
�4D�ј�7�F�M�/?�KDD�PχG�褝�T�)�"��O �Ci��$h@��,����-��M�rz@�5v����t�+�rH�:<��ǖ9���{8d�>[ ����Т��g�H��I�Z�9�e\��{�C�+$�T��i�:�H��@������<�K�n+n{�h	�J��8��XܷvtS/-ꐚ/b5�Ov�zqp����^���mLzn�};�oa�kժ�ɀ��au�vKd(�@\��9 0�3!����ڠI�z�>���"�ق��\�z��7��J�����T0�����`���hq{��Gx[��b�j���U`S^���ғr�YS]Z����Y�.{�z��u�#�|z���-�:�=xT���ڞ"���ڊw����8�dX�!i�����S�U6�Ƌ虦l�'F���{����o����u6)?gC����ժik�I��\ռk��%:��rZ��A?�s��� �m�!���%����<�[~�ɜ7Mp�����4M2M����ܪ�+@�F�6C�����oA�������,�$��}��.߶01��rI���E�OlFD%�����A�p�f ��D�)�.x�5��b���{�DW7�%ZN�gE�$CQ,�CC�߆j��/�;��冒n��%;�7F�{���Ôd���{�P�" ���?p���t�M��;��x�%�*�0�E|����!5�8�n��SFY�X�4	.˱zg_��G�k��-2�qt� �(�(����zI�.�<̫נ��e2��H�F�tpq�^u

_�-�s�>�Z�*H���=J��gŧ&Ǧ��b˄Z�<�ݧ��.©�h�jF����Po�j��UCyyz�8�q������Y�|:��F���DD�P��5�����g#�j�썪�I6?.��b����f@G�K�|����qّ�1�%�j��9�K��7O���Pl!���c�B���m2z��Y_1z�@��soo �Zf�Ǩ|�:C���X�)2ͅ�u�'�[�o�\+;%�cŲ�	��-�3��=��ey���Ȑ7|�TQӴ�TMM2e@:["��d�4��E��nn�G���x�_2N/�^�A8����GA���[C��G���!�s�S�UᏆ�u��ӭ�N��h7�>�*s�,S�k&�kɈ\�0`ƚRB���Z��k0����Sf����<�Ytm�8 ���T�ȯ]���.��8�͛��5�*����Xk�\:Tx��̒�9�g�.��~�q�@;)K�9���My�{p�D-��N��}{U�5Iwlm��l(om��[�k���l������\��̙OK}#_���IMa��t�HԨ��0ˢpSbs��0�bPa�*�*�O�"���<�V�o
?"(գ����Ңͩ����8 �2ٜV�-@�%���E}y�f�����N9G�Ox�.00c$A�G�]Qu����%e� oH^u&�˩��B�[g���.I/���vZ�Q�g��F���r�s����v�J�_�������=B��!c��{���V�%a7p2�L�	�����<^,0%)bλ?�Z����m�OZ)��KO��>��|��;"���k�+`� �BJ�z���=x|����\��O@7�'	����:�C�Ǟ���{���{q�1}�E�z9��T'��u��q���LKP����K�"�ʖi:e+VmG~n��\�m��-?��՝�W��q�v��� ��/3"��H��öS''t: ��Qլ��(�K�t�C�����Jr�iE���F}8J���U��r��MU�e}޸�[+��idmf1�P�!���Ht ��������6�4�RF�K��$�8��C@|���rj�J � d�M"�d��r���8%�ҳ����7��n���[6M�Rl]e�-�i�̌��)���g�\^ϟ�����N�496
��E��2w!4K0�
���׌V�Խ��h���?�r9�6
�c��O�A$�sh��{��M�b����k�j�0m�Lۂ��h�� :��z�񲨝�/���l��nN"ε�\A �s"�E���
��Q�s����Zӟyz#<k�o�F/�ggF=�������3;YR�f#�gXk�*��^V��i/{��몿��U�zp�Z,4AS8�
�?�=���W��?�0�s��m��!�}��?���?��󷃬5f?k��O����'�b������v$�nJ$��ϟ�Y�M��^ ���2�N2�	�:�(g8�s��u�3��EVDU�W��? �g������Q�;uXo�Fjb�P0�����n�!s���V� j���~�Ї�E��՘-�GP�Y�l�2�%������q-Mf.��g�fM.-�n�t� {[+q_i����E[�r о�n�!0��A�q�i
�p��́���ӐDu�* Fjr�&�͡�zH=��:�)�N1P�U�=�;�\坾���#�Tc��I�`c&٘SY�i%�0��KlI�},���U(KE�H�7!_��J��'bbx�pv�$��
�FZG����f���_'�+����M}������E�ij�- /����Ю�������e��^��a�=��(�?6vH
���Zx��R��(N^\i�܈g��k�-�IIuX�3j"(b��    ��Nb0�8�!$`����6��������[���g�"�9�����9xp����-{<�e@Q�DK"e��-j���AmPEqЧ��t�i�MP�N�)"�/y�Zko���)G��q� ��Lks�{����uQf&�^�>W�n>��G�&�d�>�&/�F`�F`+}*@+xW^*���c��L+�y�0�4C�$�?����F�c��	.[��w���l�����_u��lʦD f��z�t��pq�d�?sdyeaa�<�h�1T>L��kJy��_��<1t���&WNSl�����$I8��A��%���@��3]�M�H����߹�� ��������Z��yȼ	&ʐCb����1Ӕ�7��ױIQ/G?��.�r=��������تZNE�l�����4Uw��L�ҝzP�,C?V�c�2d�a���ւ��/K�᩺���:H7ά��f��̕[��^嚱�!%�E.��%AQ��|��O��?z=���/cjz��l
����k�ց�2���s$㭜�e^}�5I�_`�c)�G��4�� �� ��|�2�xW��
�q��BS�;��>`�t"�,�X=�ň���pw��o>�k1+B�,��)�;�@E�d�V�"A�.�ֹXިo��~Ú_|������
��g��XM�e�(I�	�����$T�6d��;}��K�tf�'P
)悵�|sϻ>Y����t���U�_�5}�nXK%�2*K�!2{-s�-�a~ �8���9QfN�.��x] ��Sv�Z��F2����k�1<������3=��]��)
�Tǔ]7Ke�U6غw��Qo�BN�����<.4���������b�U��-����;�������]��Sc�/ѓ"�`�\-.?��՘؏�"��/*-NN_?�_�U��To_\��8�:�/��i�|feg�H�� 
�AH�a�0W���|
���D���P�:�H�:m��3x0�S>4�b��!��156��%0��I�(��v;��U-��k>kl���65vqZ�ÌKݐu[8}�c�e��n|����6U�p�����|&]��>���y�,���*�"� �\_d��g�(�+�`���OC�:��]�.�����ŷvfw+��t��<T&����:��U9�|1���M�y��En��;nC�8nwF�h|v�iu�C�%bȫ�5���M
L�r� �i 2��r�)3;�VE�w<�t�L��r�ݮ��c�v���K�ku��X�V#oV���]�l���0��WJ%,oa�JIy�8��˪�)��x�q���!�Y�� ��Ӄo�.�+WR�Ӏ3;� �+5oԉ���Yx��C
��J} R�F���P��&%��i�� }�/��]��@YSG���Z�u\PN����Z </[؁B��%[7o�F�ʾb����@n?�=h��&%ێfɀ��Oò��4���?^�����9�찐��/�,�p�&Lc�V����\`@�cr�����AP�a
���^�6�MC�:/
L~!�$${� [o��VM殅��(���r� Zg��A��P��	?��q'�������[<D�Mk���,E�C�4)1x��`r���IK����d�d&���*�f������G�����[����P�o%�Q���M/Z��\��<�"{�qr�[(�G�t�y@�K��	�[�`�1��؋���}�w���	`�AD�+��?��hv�xZ~����d�r�&|7�Zl=��	I���E*�Vv`���[��7��D�l�� |yD�mM��d�����9�N�G�1|�SD�@A�d�l�Ϊ[	��Q3�e�ݥ7�?��7eCUu�2�4�T��~/ow��G��}]o�xG���������i��yI.��`�MHV��a_�����(���
���@���/�<�o�tU�A����E�T
X���N�V�1�J�0iqT�FUrh�f�]#�����2�d'H��Eϖ@���;�U�(J3F�{v�"��p�V��z�Ag�#|�U��M�A���;��w&Da�l���[Gͽ�gkj�����~�Q��q�I��! � =�����I쏬O���l�UCJF_��j�IZ�j��O����*��[ߦ]��rjHe�~��_�lN�G�~=�Gŗegd�#�G g	AD���P}�)"�-�7}f�m�7�m���=��Z��Y��Jf��*k����*��CTk�Z�N�7Mg]s��>���m���1���/[e+�M�]���Y�yȊno�1}���T~�w��+�����͙2��.)�Vy�@�}p`����UDI�c��A'X��T��ñ�h�{�ׁ6փ��Oc�[G�&�ڪF�e�'1�e��ia�1$����ʎn���I�F�ec#`!<cG��@��>ʮ�(��fuP�XRO6t�{t�m���ǆ_��텼� ��SBCK �$�P�L_Z�k�kT�}��#�
��0&���B����ޒ}f71��
�@�/�œ�CQ-ZeP�0�*�Lm��.ꕥ��Ch|y
L����wA��9n�'a��	�xB���0P���@l?s%��Ad�,��2���u��84uL�n��
�ǨR�&;�a����Z�\�����������Y_;�h��킥��4^���Mi+��E,m�� IBɒ��d�����W��p���p<е��;� [������eiɋ°#m�a��lp�{*�D�wb0�����ŵ�Hj���
'.�©�pF�����96D4:h����L����3;F`��0�A����[�\��MƚM��w��N*�� h0�gF�%^���厬=�|ixx���'�Zr��8~�?�[d<���C��H�C����F�^�c���ң4�sSjB'`m]�H�8-��χ�m�$��4��>�T�C'wT�^�<=^d ��_A�o�K�ř��s��8�[��7,�5����I��%�&v�5��MY�JC��׶�%n����ִV́��
;�q���"��u��B^��С�v�e��@��-f�>�^-0��2��]Ų���{�W���G�~�7��[��#��
ݚ�'��8�V�>��4^�1�4@HVU�JB���������,
�D��c�:q�E}iV��i+�R my�JDI���{;��b�
��^;+.��ꤪ�XUJ�eR�0U�Я�ϗ�/��G��gl���?�nܡ��\У��r��� �нJ�H��jo6��*z�%m���x�k��1 9Pd�5����e;F���z�QW?���G�Z�7V7�j�G�Ƌ)�pmH���/���r�@�y�+8/��a� ð� ��h��iݸM;aLT�G��)�w��D�QL�|hL������]��@p���z4������W
�-�����F�������0T��O�)�I6&0r�q"����]���CϦ�������k�-��9��Ҡ��ˋ���p�$�YZ|�,4�������8�$����Qi^�����}qbe�����c�,���~".n��]0AeAƯ�zs��<�ۗ�bC'�' b���&�S>6f���rI*{�z�{�E}�̻4���늍������L�e�£��9�)AB�t(� &�ʎ��cTU9r�� �HI^���-�X������t���=Z(����+�D�� t���FUJ�f��4-�+�
} �� �<�*(��8W�23T=l�����̆��D���ToQL���Z�	��h�E��VpC��E`�y(-���`G��c���5��^~F~5�a�)����X"�0������>�0�@��_�ȯSNo�>�j�`�j�
0�(���>�v,�(�g�����Q���yr�r����.2.���v��^�3Y�ֳZ��~�KDF�՟�v.����Q�
� �*Ù��m]�=�L�`�誁7Wy��v��ZL*�$ >q�Ѯ�
SGW�,����a�m�_��m��**    �t�3�bS)�&h�Ar��E�{y;�֎��uG�4SNX$cYg '{K�1_G����H�`G��b�.2���Ύ_�麧(����Z��2�T|V���iwp�=�V���ĩml�qkᬐ\���WVj�9��D�V�zU([`�� cG��Xҕ9�Q� ���Q�LS�̶�~�@0��a��%�._�$�j��A<�o�h�R�gn��~���T�b��>4&t���u8|�P+�H�ن͑���I��%��hl�^�/��BP���l�1{�@*��r�5���P��,}/�p���.ʆf��U����Xo��a'L�a�x>Z<���
&0vHQ�n!G����X~썩L�b�eH��%î��d�2��(��\��O�;D_XEH � ?�	�[�]�05�1�Zv!�A���i�7ɢ�(�C�zݚ� ��r��p�yc#,�Q�����i��4�J���@���H'�rN
�1�zHϬɮ��$���mX�Ȝm��u��@�煾j���ۊꪖ����&�Ӛ��8fܖ��Q6Z����,�m�\;\=z^p:/��I�Y
 ^�N�z�>����H�~����4���ā�1��zp��2�y�1�	a�D�ԉz���~*�a�8=��߅��mA/r����謸�t�Q���Z+��=��`�����Օ4�ΖJ���1�{:�k�-M�\�[H7A(��#��*I��F�ͮ��T'�P�U�KTK��������gں��3�Y�h�`~{q#���hoK��b�^�%��N�@��P�Vg?�%$�a��>�i�����D�11d�B��-KG6C�/ <\Q�M�
��ܤ=���bQos"�8� z�r�1 2�R�$R8��#i��3+��a��S�"��5Ѷe�3ǘ?�(2#8�O`��f�8�M�H���l���~�̚�EBRv[g�*�HLK-K'z����飧gj�u�֗k�+��8���,�m֐w{��P�گ���#��M���~ܭ{Q�7�^B:[Jp{����	J\� h�yQIZ��n�c]a����߱g�]�ҦgM�@�5��f���E��[��~~���_���O��Fׁ�b*:�ш}�}�`u�{2<0&gU�.+`b�C���7��d��H��rT!́8�	����d*m����hP�_N�Ovv�K��h{i���n-n[=��^װ�5^����Zzv	V��kɽ�ܒVsk:�u�d���Q�:kY=��� ��{�ى����)�[����E��6'��.�
���P����h��5�VpS��(@C��m��D���+�x�X{-�]Ajs��r�Q��4�^ �j��f���gy��YA`7\Of�$�@Wɐ�M�l}y��=���n�g5/�����^elbq�u;�\���e�f���� ��B�x��vX󇈋*�J��]Ur�:�� RJc".Wv�`�3B��H�hyJ�z���m�rg~S�-�1{",� *ep���͗��z���`?b�V�j�k�
C4�p5άQRe�F�&�"~m(7�;�����D.��a��h���Bn8��NI(iN=�b�	"{�:�dۊ�3s���� z�f��SO/��G��b�[��N���O'�g��s�@�+��|�,�;�)Y,���sNqU�M��!��ǔW�0�)�l�>3C�����(6���j�.O�%�E���w���FM�^��P��8�@�M��;Q:v9b�QG+��<NQ����}"z�� �s�lS  J���h��i@+ 4VC�Ǽ�yI�=.�&VH#>9�,�x�R2�t����Anj����\5�@W\[��Ǿ�9�)����p�!�fLյʂbl���|��d�h8?<{�w:X�,�^��9��p �d�2��D��T�6�<3paa^�a�2c��O!�:&��&@�F-$�Q���T�i��'�?/8p1�P߹G����i�	��l�ܱu�l��D�33	]?aFCP%��!�. ���L���E$lu^��A�����?�FyH���<��e�� }��].4v�;̮���ó�3�3dy�l�ox���m�N�������\ɅB&��(r�qC���M<� ��< `�1<4c�*���+Z��T��s-ȁ5����h.�\���}��Iio^U�i<	o/��U����T 8�b��V8����<#u�Q^{il�=-�5)��_0}zP^� P�wh���[nS�IQ��ٌϮ^���e ���;��8�k��ز�:�Ô���m�����6�飽X;�EKK��bo�y|E�ޗ��l�g��y2	niL?R[[��x�7	��T���D��u�i;���r���(P��^.�֝t�m��m啮Qs��� j�p�R3�8��c+v�b�
u �T��[��E�a�u�`F��1�o)s�S nCLU���J�8���v�f00][q/je�Q�ʹ�ϥ��V�@_K��49V����Nb�%�Zd�q�hz�H,K2���*-�A��?�J����	�^8����u���,�),����,Ry�0��]�~��.���J-%�C�3�A��د�i�V�ӓ��L��D�x�d1�nP�R
��qOVD�kQ	?T?�L�F��U���]f�����WM5d��!�����na���me5梹����eu~5M;C�L�T����[��HJ�1#��#��n�w��#DOI�j&�C��#���ԸA���)�o~�Bv�]�ĥ).0�q�9Pg�nN�����1Cص7Af�e�%���<�J���<�C˅��б��,H4V�����dU�"_����b����-�n�
n=ʊv��h[�,�p�����%��Y�����T=^����|_9z���q���Y<ƕ}Z�!-4�#xv�Z�6�/$�f���J��p�h$} ���@�t�3A |��5�e�y���u����h*���*Wj�rH\��rJ{�1�n3ts8�����LSX�/���݉[�:����Y}<Lp�H�F-�5�8�$�ϭ�����lٜ��MUT�3����g�)�ìk�F����r����G�|Td?��^{�A2.xy�z�Z�1��B�?B��?��t+BWF�d�E��?$޷&����\�Z2�2K���x�MLd���(ӿ��w���ZI��Q]�L����W|P�)���݋Dr�i}y����*�(�w���5(�MB'o0�ݕ9:ɀ+�l��U`�wId�YǽQ��bF�渮�ێc��c��G�C6������4MHR���u�l�.%��^d�w�����~!��TZHK�dÔ|/���)�3g�U��E J�*4"�� ����UL(�rP����k"���g0Ѫ%��׀wW�h�aHݓ�{��,�Ŝ��В��I��UY�J��W���p)y���R��ZJUAW@uF�^8����\�B��=|S��c�� �4>���,ս��̪�껾��=��$i�j�%k���>;N�>��F�}��ӓ���������[ �l��S��tvA$��Ɛ��\��*�9@�z"�����_~@0BԱn���\����J][��.�R����>Qr�\M0$# �T"�t��Iɥ	����w�5�ޫ5M��ظzH��� ��7�;:����y�q�#b����n�HO�~�!�������Ŵ��0��E�a �:�`��O�W�=5�-���򀆕��^D]еr���z����A��e����(�UW/�1(-����v�'��l�k�B�&dR�rHs5w*�]�O@N)/��O������['�(�R`���Ad�����D��~�%���ӯ���]� D!�|� :u��F�q� m�{��V���}�	|���І�%0�S\ �7��;��αe�`�x��9|i}� ��G�hj��;|R(��l��σ*,L�R�3sG�>���+U�y��O��I�h��8�U��]��@c��@DڔM�vŏ\[-��9�hϗ���(i�Z�-{P�np�؀VU$8�E    \����\����%;Ы�P	/����1�����F!3�E䁉��"c�D��_��6�����K���tP���A��[��Jk��Y@�(�0T��!m<��Ir(��-hV�Q��2!�!�l��{��Y�s�Ag�7�BqU��ah�l
�̜Ⲵ��g��I�o�U]=��-����6�Rv-��'b�D�K��7_�x�f���@��9>�Oa3E��eeT�ʼ��M��k�
lV��j{U@[슪1ma�m䠦�֣��>@]��[�@T>���CY`v�S Ί�	0D��Iڻ�a8�!I�;\%�W8��,dd�;��F�h���)kc�C)�e�z����� f����>���n����Ye��϶6{GK�¼o?�yf�K��|$j�Bb����H����p@Yn�[Xޗ�~e�ma������6�K�!�!Ip�t._r�v6������D	��6$=O܀��:zq8�@��
�D�g������ɈF�j���[|��@��e t����!�.�Yt~���L�ή���3K�j��Ȧe��S��a��z+�g�S��tc��������鯽��e2�o��U�����&�P\m�|l����v�]ϒUQ�@X{I�IQ�:���u��C�L=P4H�|��6ż��U��ڄ6~��e�	�U #�d�*8\����	d���J�<�G�"I�&��i��D�>��H��ף�v�\j�="�mq�H���l�>)w�iP#����M�kv#�ߟ�����x��l]'�l�=VÃ�=��čӍs�I������/ ܺ�pѿ��U
"��Φ�������|,��s��['�r�b=��(U:@,-dm��I�niQ��ݏ`En�����\�;�w)�o����+\�u����~���Ljx�jL=ݺ����c�z�q�@%��#5���.�^ =;��K��@ɶ��F�Q-/Lݵ\��l�r-�9��c�� ��� �����hE5���P�}P;P����`3����z�Y��{X�T`��v*�Ө�'٣�ˬƀ�R�3MA�ar��GԵI9~%i�Ȥ6�	�_Xx�\���S.1����ӾU	.v���CcB�8� �r�3*���8q� ��=ѕ��9��jf��_&���v�ZVP�GS�}(�b[� J9��S�K���TNf!$�7���V���-7�����3��	C�U�04�������盏�6�t�>X^uV�[�rk�?O/�{�Yl�م�Q~��')5)0�-~?��ӟ���BQ�h�K,�Db���c�AQNн��eU4�,��ﵤ��4Q�;K����/�{�rϧ��]�a�}�N���@�5��fe����X�|�z�6�pu/�F��ӍeZ����	X��ԇ��%��MƚQגVڭt2S��HMG�c:vY#������ϛ�����މ��|�(�>xm�*���U3���GDީb�N��]V�׹�k1H-��s��:��(
�P�#`F����/VD�����e���b_Y�w�*�{�� ��.M�xhN�)~tJ�:eUw�_���^���gS�d8�0K�./��:�Q����_�IA�w;���L��X�̌ICd�3�ǉ�i�bgx<x�⺵��.�Hٛ��-2����K�	)1���)u&�`�u ��<��	E������>/[��)�P��Ays��7��7�To�lf������$*>q��kWr�f�>�>dA�IR�R��iCe���Q��G�����%��J4�h{�D��\G��6t�ؚ*>;F������Œr�Zm�t�N��S�y�X��Z
��˗Q1{��p@7hP��|xD?��Tju��3b9RƩŻ^���l���� 7D�%��\�w��60�UXb�u���N��2�W#���Mj�@�L�FNe5�����gu����(�'��6���pgI�����&<��
l�1��r�_G!��X�l����0�b�V���&cϨ���2t�����ꆮ+����m�`���)�����e��|�s��z��zmW��s�*T�!r"�0���Μn�ˁ���H\��\�5 H���+�����	x$��L��9� ���7�g2��[�V��+W�'�*߁G�)���'��B���
�f���EM�jq������/<I8�:����,��1�.&1 ��*&{޺�G�
�\�,�gu��o��-�4h���O.�;���?+�O��F�|���K��F�Jw����v:�b;D�bڒ��-܁Tĳ,h�[�^w2��ވ��e�]����F�C�)A�Z�� C���ߤ̆�.=��v�`J��k�Mڪ)��Vʣ���x�sT�����'
8|�.��4����I!�-n�g�����Э_F?o0��*7_-Kw��ڄJ��趣�Ǉkѳ�������aA'��ޡ���K{� �'ҿ{��HO�N'b����8�9x3uD��!���ه�o>��o=����<�P�|��=��/�E��T&=R%����R6���tӐ�
��s��<��{���7��f��p�T�f�`�� ����
�"�*R�������kx�-Lq��H�>�8(�P�d��b� F�����8V�"�۹ˌz�q��f�lh�->[n�#7��x}E;yz���~��ow[r($�l��O;:j���YH�Y�$<����Dꌮ,f�FX)A!q�u�a���(��䐂�aE�����kzR��w �4��")=�\�N�NE9o�j�L_m��nEwU�*5�q�oJz�����\�`oc$�8PT+L�`3g�@~�t� d�C�gY�R�+)�_�h�Qo@b��1��zfn����Q��n]أu���p^(%�����+�Qؚp��+�e4bɇ��Wb2g,�|�Ȯမ���x��P��?s�@[^J�Bi����*o��nU�ް��NQG��6d�[A'�aKv�0�Ѧd>U
ė/���X��hF~/l� 3�خ��%b��%I�g�%�;�kpC�$QՕ]vHe����%{Gک�^K���=���>_Q�V� Xt�Q��q�T�.7�c����zV��Ǆ(M��#f�ŉ�_=��'X�5���L6X\ �H(^IN~3����T���c4�.l�s���CܮD_㚜���X-U�����Ɖ���3���?C������_�AB� �ѴRrQ4���Tzm���t�*�A|�~���� �<E��v�2�{Ǧ���u[\͎�[2���LP'�`�S��4Y,�ۋǋ��ʩ��u��x���M�T�bG�幺�<w�Ϸ5�(��i������}�~��[��G�oR��"Q�R�0�G��E�����w�1�T	��y��7?/��k\���6���#v�'' �����F�6��u0�Do�bd�6+DQ�&t���2����A�r��.�G�m��w����nI�,V^��:�#ۊ"�aE/��|���wgQ�f�+g�;�����ة���\V<��-�ޓ���O)�q���T�!ǻH�(
��pR��vew��G�׍�����8nv��l���� v榋ӽy�[��|��zh�Qw��K��U9��T�I�>���Dl����[����!�O��9U�B�[������ ��	&�����a��5q����4e�4�RN�tk���f�aj��O����B׼x�T@�����?����S��w�E+��F}t�\�v �'��9{� ���`��.W�`E�++�6kv�@�S��2�ۓ�b���&rQ��FW#���aM>8<؟�tma�y�Օw������Ŕ��G&qi�~& ^\�1���F�`̬�ހ��c7��V썏7��UY��L��ҵh�I�l�Q�~$�=�_�֊9D*��3��$H��p_,{w��Ʊ7��}��oX
�Y��j�'��*�����v��ys��tZ�,}W
�ԉ�����uȩ,~��/`���!i>�la"�<D��w����[��=T�!�]�̆�@��n�qG�cZ%�o2���;ˋ^_$M�-���g�4(Y��    ���t�Q�/jO�Gq���;�+�V m0Y
�b%�#~c�_Qv2�L��4���r��.,0�na����(�b��*o��B���kS�x�8�bqmr+�@�%����������ؘ�\~�a"����e�9����!��7 ��0�lp(�"�����n�.�������
A0z�ܒ7��a��Z���fD`���r��p,���aYI���e�.���t����}�%b��S�ϔ��`���{��0��d�TV߰>M�I!u���=�҃s���-����Lx0�b��#�sf��{�dˀ��Q�G5�&n�d�L��@�Һ��0xmU�]�$�]�Q�g�-�6����3y�o��G��n�0���u��~D�~ʋ�W��.?`[����Z�`P��K�֕��!���'�!���R�W���Gy�ܘqT@G���\�^L�6��@�tUu*p���f��4��u����P��ޡ��S"-�b*�hj�l�����Y&��X���5h5I	�WU�^�X�m����ewvOqk��vҮ��u��q��Z,^~���$D��jl9���{�����z|��W/�/&-�,}A�	�w_��y��ﳯ��0d�y�9A���с�D�>gA��{�����h.�"S��[X��>4�F�,I\�3��g�Z��j�� L�{T��s�����4�H�m>c��&�P:re3�*Zy�K?�6�R.q���bopwe�\�۱t���Z�����u�s}7��Վ�;�g���ݳ�Z���?�{�BFI��>ZD��'}�M����w���\N.$��	`U�{�GD���ga�~�x����P�߰LKu+���V9�1%�8�U~�e�1������`��	�BV8M�[gqqqijvoȼLχS9#�t��2T�t0r�d������Mǟ���
NKi�̀P��ۀ$"O����j���}V��&b���?�Seӷ�ugXj{�U����%�U8'?�s������F\\IԊ���C���JB�Y�oge1���(�0�K��N(�����8���
R2W��Ӿ#q."( �;	A/0���ze�*��E^�H��%��,-����3����� _M;E �Ԋ�K��X��a�h������	�Fq��)���賨�����d�b��xד���&+����*k�.�'�2K��zg�f�������a��\��{&Nm<Y`Qx5��h˘�Q�DV���w8�Y��B]�R�F�������/uz�O�
_~ U�B�`-�m9�2L�Bܗyމ�� ��P�&%�(��Ш��s0��:jX�K�J�V�)Oa��������R�����[��i�agP5�} �U�"�}R鯆�j�i��U�]~��������[�Z���v��v�t�^��ң^/��{]@T���C�G����� �2˭�=n��4��B�2=฿���W%(J[}`dR�}�-���5Wy�'w���gO�fljccSӸ"�P��,;�<�������#�\�j��T�9�B*C�B�P�*آ\Pq�����*3�9��`I����=���9��v�C�6M�xB�nZ��d�4-��?�>�
��ӥç���v8������)
��E�����q��a��U�~��Y��+���Vӫx�pZ4c���� �~�e�
}�5/�j�ӈ�U���@��W��М ,�/�b�\1��
3���@�BI�K_I�:�8q�j�	Ngdpw�-?塎��u6�lQ#/Vy�H���0>�6�_bp��/0 n<�].UpK���H\�_T�*G�UJ'�]w~!Jԅ��lt�w����׊��5Ak�}�k�w�R~�@���&��Rc=J�N'l�HK��놾4��(1!�gV�Ov��hPX� ���p������b^הiIpe|\���J|��Q���N�f����Xэ�@�\��,����4>!\�͖��L{�Z�a�>�/$#@��g5���ޝf�3G;FNuUqِ=f�DA +:�Y��뎨���[�[k�Ԉ��G݃��zR���k���@D��'�US����M 	UUpĄ��PIwM$�'�ˋ`,݇Y޹�Uՙ���XUM��Ne������3���l� h�xT����i�b^L�0s}vb{�ƀtd�Q\ *̙ԓ�>���ZN�fuES�mE-=�%a��a���Sd�6�y��jv�)�<{�l$''��t���h�o�(k�^r����C�{T+��me|��M��{�#���b"
�ŪYhF��yQ���%yq��L�V�HU=E/�e#���­P.Ӈ�)�I�ȕ?S�Wo(u�<�6:"�`3D<�ۛ򀔳�!g�%0X�F0W�Xvb���Y�L�=N�TN�n��3�4��9�Й��'+��h2������	�-W���O�7�������Q�Y�p���o��8>�s����`����m�����A��{U��q��R2Wy˧�mI���4�4�P*����g^����E��Oi"���I��&�'~�ev�g�4�����B �-M��n̤7�����8�ʢt��x�+��\��n1�B:���>3.�_��Ȟ���pC6 6cYͳi�e�@k���ߨ�Ǎ���|a���b�Gg�
M���*t�Q��n�ҵuG��B%?��'W���!�E�"/�,x�n�w'��H�&�)� z�T�F�0Ԋ	U�ML3��	�N�Q��JҺ���W$K�lw�g[
$]�7މ�U��	��w�ѻC�5���/����&�x�r�x�)��E̠���~��U� �u�����rY�����B�^wы�T��*�nˮ!>;�[�e3�m?N�ԗO����N��\H!�=��b�����s��9-K�5��Ju�G<^�E���5���@��qh0��� ���/�<7ߴm�ᠹ\_���B� �6!k��J@ֳ���\�N�	UfSHM@��^��8�;1�5Sf �@��B���ק.z�����{�v��:n|�ٵ-�h��z��OS���n�2��p��k+s�7���>�o66k�.VVԍd�e��7�=�®�r���O=����w�6���ĵ!{P��s�L	���l�����ҍ[|rb0Wy;fqW��W�Ɇ��O�
W(�����!�"�M�<����`FD�&q�fͶ���X�����}�n''�v<UN���I��<�����c�l3o$�l�p	�͓Fm�6�z����_�z��eDVWv/�sw/!B+J��J�P.���O׽bg[��Αt�y�Uiۻhx��lb����4j`[O��T�4���5���S�W��¤�*�%�vp"2c�1�d)�J�m��d!;�[��%SYR�a�cWq�g� �F�����E�����9�7L���e��{̮�/e�F�y�f������j��.>:3�ݖs����bc�{�X�����߄(���$�P3 (|L+~�0C� 6�&�X5��8#�{�yq��.�H<���F�J��q���E��p��P!wO'~�R}%�T�:��� ��q�5+;�@�Sy����`�
�Kr$�#������ �`oԱq���L�mTu�	����K*M9��>�n��~�v�"�35Hb2*�l�e;Y�;�=���e]oh����/�]���6�&��c29`2�O��~DFdX�z�>�	Q��w'fK�kj�[��=kg��+�*o�t�B`*��zx�H�Jd嶤�w7.?G��CA����p��F�� 6��^zzN���HC�q���U���ף�� . ��$����e��*�/u��44�я�F^d��`�Uҿj{��N�Y��;�?��������/���Ռ�=�:E�� >��4'�e841\h����Y� ����-�v;L���+�E����ԣ+�7d�U��L�T������?j>��\Um .��̾�ⅴ�p��V����|g�%�n�X�a���t�4�    [�����f��~����`��]WvL�{����eϳSeg5�:�Z;���'A#����C^�	\B���w���}���a2H�!E17şh|P�5�S�S�5�~FT�C��1k�`r����؏٫���s�5i+6S�Cs�� :brq*&o�f�Nx�k6��
(Px�+gs!��T�\A���l�cln��I�](ۆ��?��I��//윬t[K�-��n��j���k1Z(.u ��rl������`�dc�ur14�Dr�Z� .��a<�h�1�R�ݪ�G����)"�sKQ�cG��̽��!�o��[\=�J!;�4�/hN�� ��|Q���|]de��5�oj&:
�V���Nc�y:NI|��G�]�4I���Ym�5˱\�t���(�l����fِh�ww�A�l�J/Z��0����ByX9�QN�MI�q�P��G����)��Q����E&0ik"�� �o��Je����ԭK��BY0i;���.F!�}�i��
�#��"U�>>p��:�f �<K�K*����賛wO��1\��S�)���eC�;����Qm�{��tv���Q���`&��³ϑp�c�.
HB?���f�s�!O��_�*$�~�_�*m��8�V(ͧI�	�\�m�ߝHdQ�4���$���]N�aS�,w�J6��
�mZ��V��R�H�_p�@$Dh械�Ӻ �.���;���S{��% ��(�Y'�#�=D$y�\�ʍo0�ʱ3�Di����80��9��u��a0돇��f�5����޾>?�4��4ܚ?���mA(L}��G�4�a7�.�x�|��������V�}P�$��B�X������,+�C��B��~z�^�e�ro&zW���	6�+���.>�K��}�d{�P��Z�{�Pթ��Oa#�S�w1�u���Fț��n��=h�'TҔwa�:�S}ܳ`k�{��<�ThV9T����M�R/2-���L�2��ٚ)���� �M�덡��g�p��m(���aވ܂0��X]X7�e��( `�El��VW&�c	���=����J��;i�x�����
$/�1��{N0�D�Ae�	�	�@�1�b�r�&�-�y��HU�׍\q�i��pM�+��$O�bQm�'�03�H$io���Ҳ�Ʃ�Ƕ�X��3C��=�[]w�o��M�C���$E��-C5u˒�vdհ\Q
j)eUҊ��_{���p�wz��Zݨ�O^�Q�[T%�g��������L���(�j���A���~�`���fY�]G�qa=��R���8�&��]|_�	`n���^N���8��Ӛ��q��r=4*`��Һ�`v<��D�8�ј��A��J���`�3K����{�V���T=���W3���d��5r6���zI�Tˡh���|����h�ɔ���f�|��H�m�(����t�v�GnT|BV�{�aG�W/����o�� ,�+-D� lr���
�1�F����>�B�%��'r�� �h���O1���p?���Li���4����*F�vGd���U�$"{�QfG�WM��+��۶�;����.;��d�!���w���g����������J��׮�c��� �\6��¦��/?#~�7�ƍ��X�`N�� 6:+�²G�¾� ^�0���[ F���זg4R@�F}��1�qsO�Jc�D��e��%LQ-�tlW7 �fh:s�]���R,Ӕ-�Rv5���[J�;|��O����8�����gy�R[��+����Cy��$ຄ�+Q �3	�	i�_�o����Xwls��u��Єu����0���Wp�R���N�̹�'x�BY���CcP� �dpm����d�"u5n:� ��;E���!	����0ȴ��%tE�jt|�Z����0甒�A�YK�i@�(��}q��gO�$	��4���T��s��UKs��t�8�ʔ�0�S��s#<�(���t���֖Y܋�
&މ�{_��M�w�b�Z�?� ��C;z�}�����(�X�x�t��Vgs][y�fF4�8�������0ǻ�7̝&W?���J��s!wp���|�p?����� \	�i����Zp�2ߣ&�]ׂ����<�� ��Ba��{s�k���*"d��$�y,�6�KUu�YS�u�-���Jt����,7V����FY=*�怊�	׃?���O�sL�2�f�V����o3(�.��-$Ӎθ!���_������-�V���P&����!��R�c��U�1zj�àj�����2�����Fͩ������^Pa��}�,��ix�8͢S���賟Q�����:$���4�W�j�3�p��zY~����Z��A�	�z$��V����
�W>B;a���7��b�ڋƋ-��'":[��nt'2�;)w�I!.�ؤ�����V�"Vw�!���&�*N��C�,x�-f����8��u�x��<
�C�[p��vKR��mn`�aO�j�
ϋZ���Vl@���Q�~��.�'�Gq��'�}�y����B�Ba!��}:V��W8�K��iyP�XĹ,���=�A� ��?
�~����ޭ��u�~����vTI\ ]b��.�������\5�d��8wD�4Ac[�0�<��<͗��&'G,�)������ɱ,�٘5Y�M����n��=�a��.�0LCv�'�Y:��/:�x<���ƓG�+��ד�BPx�t��y�63�6y$��z��bu�i��UÜ�ϟxC�ۗ��'�v�
����������M��d7��0��7���r��*�v`o�h2�~�<[O��Ęύ.?}!�NBxA�x5� Exd��`=` 
�YR��0S6FTs��x=	��P��)g���mnIOmS�lف�%�Y�ʖ�ȏ�W��ty7�=�NW���^}B���\����Z˖-�B�Y��y!��.."�lU�Xs��+Nz�\�;�ه�	������z6NV_�vL�n%0�f��1r0n���LǚU4ycŤ�	,2/�*x5��
� 
H� dDz�}�~΃�#y=����!���8�r �����:�=J?��6)o�V��u��0�SE��6,�.�%l֑�X�P��ԧ�|jY���9_���%�Eq���(3:�bUVUh�ppߤ%ʠ���KQ��>�XkIK���ƨ ׇ1�gb�zL��rRw/�o��7U��EK	P��@��b�$��D:H2���ⵂhD��8�H!@��)����B�]��H����Mw�*Yts�;ܒ�Y.S0�Օ����eS�����<_x�[�և��棳���w�Ex�v��L;d`�,�`(�]X]0]�
�sv���z���1��Z�׋���oSQ�
w�[ 	8t҂{�y%���N��d�1�M�+"p��@�̌=D�ۘ~r�M��]�Za�4�aN�؊���'�x(ޓ�p�'
��8L�ˑ���7�����Z�ϊ�2uS5M���N'$}�-���ʶb�D {*ɣ�	����N�ty�Lw�k��v�P�[;�}���Lڙ��*&Q��� N"��/>%W?����U�U�d�:M:T8Xha��9�E,Q�yL�@ŧ4L֧1@M!��s�;�~�䙩s��*�]G�&�"�U�\�l�Hq�Sm��:#���{E�/4LbY��g?���j���!�%8��7���H�QTUv�)>�����J䝞7�����I2�^޿�aM2���F����(���z��r>HG���H7�K��|��� ��e�!��y1��_?�ۗ�7��7�ve�GH�b��0�SAH���D�#j93��,'�� ��ԦK94(���x�c�>	�q��5���L��/K@7�j��ٽ��܂Y�[ʴ,�)y���I�h�y�3t�v.���9%ԉ0D�ke�:#k0ǵ�r��7���W��2�|0Ǐ�N��]~��b��[��
O����ƤBB� *brq���?Ń�d%��f�    _�9(�)@�v�a�.{��2ˡ�����*�� �m�.k�iƳ��;�r䫻=�0������_�U������(fJ�8䥚PC����̳���e� �ʿ��LAo��'�����x�Q@��U��<o,r�r�)�F.:hq�p��`�!vxW�b����@S��q�q* I�M��#�/�-03h�Ex
�f<�Ms\���s��o��a[S��ã�-k�`7ru�TJ*ۊ�/>�8k%�K�Bs[�KO�(�؄֢��_��کf�"M�F�e�W��gX�&F�)� ��k�	�9_�$䥱v�p��&q3w�}�-������6鐭�k�/N����9���\V�px1X�����k�>�-B���+6(8�9 ~�إ����r����]�^�#yvՔuKV����<
 ��j%5j��җ��Cy�Yԓ}y��ȳ�C�IKT��7 J��r�W�e�.��х�\���E�X.���� �m��nd�J5��мZvN�Lpt�a@GT�A_��
Ą��z�8�+2�O�����"��_�Bߩ��<��G`~M���'�!G���Y�E`}/Y�e�N�q����bg��@��k�SG1��n5U��ef��2�OV6��e��ݝF��hqq�m���Okg��Ϛ�:�8�Ӏ���u�j�_��#x�A��,vN@�'=�<nJ�lOl�Pt����^;H�b�D���ȝ
bޤ��uUC�f� ��rU�00�g4wٟ���W��wY��|�C	�ϧ�@	hBU@�C� �iT$�{��򭢤4˘7��4]���N��b���~d.,t����B��6Gϋ�Y�6�V���j v��ׄ��}� r^f7�Rml�H?��^战���	S�T!D;%I�+����H���z�
��2�[ɼJM��QƠ���UJ�<�måW�#��|++Ҕ��7�6�<�&���䓄��f����0����я-��x�gy�~l���Z`��⳦i%яu�`c�0i��Zs�:�[�����:|�ϙ������f��bO���݌\��(�# �!��:�7
1���W+�PV�{��T"�T�m��̈́-o�iЪ}D����k�Q�N=		�,9e��t9�HFG�͓B�n�����Ӻ3�l���Et:�m�덩�Z�'8�H$B��ʕ����k�A��I'h�\�L�I�a�B���Vr)Ќ�ɒ����W�wϟ���|A�o�;e�^�ʽ�w&�ۆ@O�/��(:�D����X[��c8��Uy�X`L���A>��"Y��f݃Iޕ���Oyh�����~W?s�Ö��Py,a�����C t��Չ9��ga��$6�m/��`Sƹ���Q�r]�7�����Aݨ�W;۲��c>T��pK�f;~m��E�������zw�I��0	���rPB1�[�R�p J�'	zք���d}L}�C�
 ��!4$�|݁��������U��݁hf�`6u��H������c�(���2���P�u��|�����'u lz�#�D: ��r)b*�oz���R2>��3���r�Ҏ-͵}�3���]�5�ѳϦYR��k����α�٦�3���3���"�߇��,!��e4���W\�� �_� RF[;}��l�	w��1��^�_ݜ�O�q�
�a��m�s�����>��Լ�Mv���sep]�!4(�.{8Jxy4��r��ė~M�ڻ݀���cp�{�EG7V�[FI�k�Ag�0�]]S�⠞�q�uJd+�^��Y�3�gI�����Y���E0Z��p�����C�
T,ʍ,1�yE��9�3L?��s��A3�P�,�[�vVBxْ��:���2Ў؀�@���=��K�:��v�yM�W@�L�S���`���a��8��6:f�����\cy��
;v�`�v���2��0�%�]].LK���m�����e��X���A]vTՐ5ǡ�xՀ.����?�?]�T�q� _�=~v���[@J-��2��7������<���V\ ��-J3d?Ǎ��%2�S�a������Z��\3�@h�Z��Ke��R����	��\�<��e�-|��?z�V�!_awR��^����=GIt���]ЋAՀ�Y7yA�������4��d�W;�ɓ�q���o�'��ċ��Ƀ[X)�,� K�o�1�U��7�R��}�u³�C��m�*
�G
w��w�mI��"$u�6�H�h�M�(�}/���̀-|��!��L	_P�jD��أ�A�</6�i�6�3���Pz��aJ��x�6��/{.�O��6J���]f�����tmc>Y0��j�G�APs�����a��NGv�f���R5K1�ZT����㍍g��ڦվ88t�=�޾|/3���G(A{��Bɂ+�X/G��2����['�rw���
�,���I��	>�[�ϥ&P�`_g�^��`+��M��ek�r�|�B���ɵAL�s�A�SQA���������3����N���r�0E����m��1w�-7 ����ɦO���`�]��K-O���ӵ�-��db��zwTFv]3U����s��I� U�"C�l�.�s���ls-����_�O�Fo��?[���j��9�_���⮴�՟R�3�H[���K�=Z��3��/�`w���l�j+E[���Ϫ����������|3�&K	��VM��n=�]��� $�OSX�� ��&k��U2��<�Ή�Qz���=fޙ�"��=8�s��@���d:l�%���x�Y#�ֻ�a�����5Wי��B�����j�{�~N:��[6���b=�z+A|zښ?����l�j�^�Nx�+��N80sg3�����')�H���t./K���BU��&$`Z�е�E���9�{�-�[��Wޞ�ܖ��A3�WSQ�x�郭�>����t��O��K/�Wn��Ԍ��"j�������È�1��B����3;ip������-�)I�y���k�|m��\�s��qe*�c�α�ו��{^]��F�U�}�V|��ݩ��(.S��n��ֽ�����k����s��
��@��j�'@�=y�y>�Zj��a(Z����_Yδ��:� j�� 텃���x����1CK�w����I���,�� C88M��ʿh^���]H��2�C��zYf��^Fe���d�}�W�����^%R��}�V��*�>$��m3�F��"d��U��3��(a(�%@x�S��c����a:��n���V��5�@���ޚ����&�(-M+Ԕ�V�S�.�O��q�Yc����aF�IR�6�T���G���ܤ�kK����@���W|"݀0(D�`����=�X�:�q�%R�b$}߲	ݝH�M������P7��̈́��/>�4x��C���]"�h3�5�G� �'9�t%k���O��~�n�0�	H#n&h�Rj�Pj0w� ~��I��`�ꥱ�o�6�{t�k��it��b讪��j�f8�nh QF�\4��`I�;��Ý��'�Fkw�U:���]��7_� L���~S�)�sW��"�F
n��[5����
��!�� q��̋�$2�x�7)��\��<w�W� �zx� � <m�X gŜW��oR���~��@���#��FQЗ�e�������Ms*C
���̿�=hudS��hr�������[�ŬF.����n�ԆfY6;L]ǲ��j;l{ՙ��f9�����H��ݕ�Ǜ��ڙ)�So^{T�ʀߎ�h�x�b�EW�j}�u�����˿W�o�Q��Z,�� �Q��WؘQ�N�n��1�&�lS�DZ�`������VX���?I�Q���ݝr\�y�:%�J�T�A:oe��̯����AcT6��Qf����'���|�i D�#�	���x�ڹ'��^���c�7�aE-r2���mtZ�H�-�jv3�}M�m"E��Z.s������Vd�5Tٲ,�[���|���Eg�`Af;���[[�����a�W�c��7�0��#H`     ܵ��Xy�nL(���?������V�_z��k��L>c��I��T�f�D.�#�7倀�!�:@�j �!�J�C#����H���X������]��J"6�0�©;��~��O�|�	C����պr'ZS����'��֓Q�<�ձ@y7�o�5���ׄ�.>q�xD��rT�r �[Y>�n
�!T$�ݡ�W���ߘR��LK'
�O���Ɏqܴ8't\~��E�����/�<l�m�B����;�l�5'�H.ە�0��^�!sOͅ�^�H�^�=�!Z8,�S���T,7�#)��_�g�` ����R�2�z��k� f��D�5���i�h�Z�d�8���Ӷ7l6dPP��������Ê��vY�w��S/�P��H�w�4�v�-_���A�oe��I�A*�����r~�g����[�ZR�I* "59�'v˴[��D]n���C6�A|�H{A�G�77'_�s��O�[��݈𛪤�*�*�%܈ �
A��1���ܟ���q4�O�+����A�D��l/�h�[����z�F�>��M9it~��-����*�)P�pg�1�����G͞�_h�c��N�dr@�ǩ(��M�+��$��a�����3d�OB�]�-ʘ	� ]D�B�<�G!T$J��T�N|�*��SI�0F��s��4כ�����S�@MԊA}ؼ�t���?'���0�|��+������a��_1뚎 ���?���Zl��Ё�tl`*`�=���v����rq�[�ɬ��I���e��cv����F�0 bD�bYw��5+K��]|�{�l�;��m�^l$G˫y�4�t�2�;�ڸ�.���"���8�(J�y���Fv���
��' K]��^H�����l1��Y&��"�hџ�'� &���A�7H;F���i�$�����z��D旼{��w�J"�eJ�X�s&nQ%��U{����y�.~[]�뗟�h�y5�Tw�����m�f蓚4.(�8�?f�߯q�C��yY���ʷ�ynS%�*o.U��$� *�ʫ���7�VǸM��ڡ>r"qsl�Y�/T�2?h>;49�y�
�(�&�ˬ�g.�������#gwS%d�5�Db��NIv#*X�-��R�Շ�;��{*�aW�A�4(r�Qg4�`G��ɹx���~������I��QӒ���(LF�.�C��-���8ҩ������ ��42���ʉ�w+����)x��b�QhfG�-�^h�Ut�t��h/x��iu����}��	�W��{jƤ!����Ṑg��$~���1���$�U���C�{���s�7�����x$��fj���\8M�t��k2�}Y���q<�����v��sS?L^�K�N�a�cр��~��׊�q''	�1��'��a��@��{6����"�X[c^U$~I!Eҡ�3�r]|��m13�?�Mߐ2v*�H�珻�w<�c�ep�|H�j��6%Nwf
' ����G��%��yǝW}`��&�>MWT[�UC�5���l>?�L籼�m1G�(Y=�_.D�s�]sT�l��7��B\��cn<g5\	�1ܾ��G��Vx�΁�~�3 m��)ؽ�4�y�t���uѰ��0	fU\ }QI_�c�Y�1֨.V'e
��4௺�D>�.0�K�����ӈ}Y�<A3�q6���������<�ᷡ����؃7��@q
�j&EN��`�7{�y5P����6�7h����`�ϊ\�v���h����{�O�����_6�z��./�^���R���h!b��(|C�
�s_�d��Y����3�o�{�$T���>~I�j�?��������o&
��+S�X~6�6���4��l�\x@�Z��/�s�VКe�R!l�M��<�44,C���f.��[�s^}_�:!{������f/�d`T��TͰ�{t�|U�m�)˯�l����0>6ϴ�x��Q��&SO�\�a���X`�,#�c0&���CX !��hK�o�k{k@߭�	
K[+P��#�Ḇ\
˞;���iޠx�ٯ�1M��(�N�eA)�KA(̰OD���K`�]��mE�=���� �߇�xI�ڈ{�= S0D�������:R��^�S��ct�$��o0�*��l��S�u���5}��h䦩8�e�&��lE��T�&��=e�4l'���F��`��L���e8� z��' ��Ǔ%��E䛥`
C֟�8� �֯�K> &\�*�G��qJ�B4 ������: �2$ ^�9C���A����C��<��#�L��zS�0�s��x��R�l0�65tdT����J��I=^>qt�G�n������U,�	�X�ZΞ���Ϗ�Q��0��+��/;��ZP\t�Ⳮ��v������㍣T����O���E%�?�� d jQ�dDxq�x����:B$w� =?՛˘�>��wt=�e4'y��wy?|�QI���P����_2�ğK|_�!��]�p�:PsR��� �J�JxI�1��P���sA
�w��S���N'a�;�MR\����:��f�!�	�<�Bt�9��#�]�d�1}l��ك��b%���X0H}U�G�Zx<���r��!c7��7>h���J�����$�����8nu�T�]c�(��֘�����7uِ�%��l�?lHֳ�'��r�Y�`+��8Ft�z�)��0,��k7u5k�-6��	M~��TŞ`�2&Z��w�m��i!�jӴP\ -�@Y���/E�e�-�<ZJnì�V���ؓ��W;eG~ �	����'(Y�3ǐ�z�Coೕv�dB�cJl��,�G�$ݰ,�2�,A��n�-�DK�-�t���?Q[yc���+��&�lDq]8�/��4"���b�c(?���o���R߅3���j��,~���.0�����$�A�S��"�zߢg�91ϻ�Ƭ̨19%���T�zq��D�_3SrQw۱�N]nDz���~�?G���)w0���R����]؂��,x��'P6~ɓ!
O#�-W{pS���l(��듇�A���bO�4����.�����-��uN���HҖ��򞾾����N���ÿ���0�}�N� 8q}q8�8��kO,ha�	��kL��;�a׬��� X��lkcÅ����+�����ŷ�x��Eu
�� zꐞ���A�G��ž?���7��y��604t�$�8�GU*�M�s�w�n���׳�Z�nGp(	ۄF� 3Frf(iJ��n�Ҁ���v��P���h-nB%aPo����0�\EU���,�YW�ƒ�^�N��-kӌw�8\{<���?�;�x�/�C	y�#��LZm��5��D�;����e�Q���[ˋ�Y
7�2Iَ�ݑ���B�M�o&ۗ�Z^T�`�L���Zc"�jG݁�����������W[l��C[��.�Y;L9�q��O��mX%��c�aT�`W��_�{��7�W=��~��7����T�P�g�,����Q?Z�zO�Ɖ}0j��4e7�{����ǫ ��$L��@�'Q��=hkȄux�ĕD��'^��rk�ͧIm���+;����q�;6���R��t� J��Rꕋaϳ���H\��C� ��Br�������a�(�x�
���
�#4a|��r�\x��!�@v������B�+o�Ak�$(��f�s�Y��	@m'f̥����&ن�J����ٯ ��\�y��nv��}c�b6N���3nol��X���).&֩q����R��	�Vi��Q�����,J�e����e�� n�YH_L8�x d��zY�)]
���?B�|���v#��;s�)�����J�oT.�������2���3�& .�ſ��/� ^&��Oy�D�&B�'+���g1L	� vɕ�%�tC�w��˝�7v��� �B���bK����HӖ˚�R���n_9{z�x��o=9���|��-2nƏ̡v�kx,.[4(�H�~ׯV��%W���ܝH�$�Թx    ����H`�
�B���嶨�������@?5�OX;>���.����K�M��)��?�	66J�,;) �1C�pS�i��3J�Y.�;��Dֶ�X��Y�i3wU�P�o8&�^�(H6Kh����?Zo6��;돶w���Ӗ��I�g?Ϸtń�,�s�v�,3���vp��R$���y"V�+P�Չm�N�V����
��U�E��_G�`j>�xՒ�?��ua��};��f��X�;��p!~�Y'm�*(�k◂u�\� �&�w���^�Q�ɠ�r�=��2��³퀹�>�#ba�0 P�e��-R��}�Rț��5���]7j����&�-S�F��n*%���8����,;�����Q{O�F�1FU�G̠�	��U�|N��Қ�	�Ђ�@2TG�#��L</�����/�ox$y�`�Pjp���Ւwo�I/j�f-jS�Q��n��ۮ<��Qu;vs������c�v����q�#�9��Q>�I}@��D�� ȕ���[��N�������^F�B�v���5B��$UV,��iϐ��Wi-hw��d9�"i�!t�)��k+�Q�m������2[�yѓ����dAs��1�3��sì�]�����\��[��!@& �jӍ.����π���	��3�my.�j-2e���xt�$�u(�E�H/ϧVlۂ#xt�8z�SOs����y*�R`*��'�������=틎��]��h�v������(�*َ�e�#�l9��ԩwZ�;��my�lo?�Ǵ��F��j�>ˋ�&���L�-m�����aqA��$���qk�uG�-.~f�z"1��d�!��;��j*��/�jZ���$�/S�����o�'�[Qwz �6���}��L�M@F�Z��C`�I!քR1�c�����g�����P���蚪<Q�U9���dk6�xUK4 Y�b���Q':X]K�����������Ͻ����/�9�ǯ�Ux7�AR}�����`�V�ʡcvI��֨"[�C�'�g.lNd'!�	�,�wl�7(�y]�A��)� � �fWt�5X���b�1˪:�m�1��͈*A��uԳ�g��-���/�}��<M+��w"\����y�1�ld_D�Y�`�pT*�Ε3�ROR ��4!�#�#d�t�]�����Dzj�FS9��Շg��1�FM�lEmc=}�6�u�Wɍ5�DL���|(xc�_>A��O"��?���[�7�lK�&5mL����q��P�3�y�-xkj�_ �sH�T�y�& Q� K�'�q_^�E�L��EQ��(�X2�_� {�'�:�c�(W�4�������Ք�V�)�u�Fn��mz�����sm�uh�����y��ҿ �y��!j��A>��4*,!aA*���XO u�(���F#f�A�����'l��\�gy�wӒxI��Euj�/���V�4I�_�;t��T�|)XD�7��Y�`�@���.���	bF��M �����)Iz��CΧ:�Ժ{ف�{Ő4�0]2t�������<m��3�������no/�k�&TN/�>6�h�@5����� @M��<�L��唿�ʡT���`�
�X_jA	&te&���[��gӹ9a{��N�[�������;v��.tò=$ļ*:�k��1m:S�Yj�m!65h\�0R�g�*�D��}L%Ll$BӔr�_�z^'K��5�dU�T�-�jY�n��G�S մ�5�,{
�'�眯�Ϟ���g�|�����!Q�������v�A�g���_>��4`9��1��<���dE�ka&���dG��+{&kHY�d�R�٢I3�F���k��?�8��|o^�/��M�BŚh�JZhT�9� R$�Nj��d%3�/�0Q������hg
����f<��bIa;��Hgn���� ('��'0�c9�6���M��exsw��T�h�aj�dX�$�;%���;-�IKߴ�#/�|�k�&b^s�ʹ(yP��4��є�B]s�g������]%�swE����@�O�Xb�����
K��[ư;߾��F���uo��m}�[׊w�?Sd�t߬lڽ���!{��L�B�mإ��GtAhM,s`��,l�:�)�V��b�Pb�v���6P]b�vòO=��>�|�S��Ѽ���z!BQ)"��"���2J�=�������Fx�ڕ�u���r>�9Y*��
��z5ݐI�|��+����. $�=v �M>��j��0�5��U�P�o��mV����i��m�I[�J]@6Q�#��D���W�x�ifT� �<���ܡ���u��H<���f�9�z0�qL����Ըp��Fʞ|+/��������l$?o>Y�+���#�<v'��M̮��atЖM��%�U�ܐ)ox�b�xr`��@ת�s������C����0>�Py�ft���S�YT�E�rˤQ@YR�r�X�cc�3��(�b�B�5quN@��o�V�K6PkRb�1�� @����� �ib�JI���?��-��\h��=_�m_�\��H���H��ْ��6�*K6�Ze��Vc�Z]}�otcs��(*�Av��>�A"+C����� W��T�v.�(�Ǆ����\pL�SF���_`=%�	[�@�l��0��M�R�!�d$�mE&@��C$��6=�-)@^��C�\m�4����I*�0O�`o�1`ϳ���8��76�`V:�"�� ���\��AAJ��%��0�-��x;�j��)EUJ�^����C����(�w��ҵ͠�.r_~��#.�?�"��	����d� m�Mm"BUH��#��Gc��UMl6�0H�/�,������ی�؀���~�,4��犀}�\a�D2�`�<��E9�mڢ�-SP~��BmS��ֽ�n�_Rޛ��"4�ᄽ�W�bJ�D.M�.��/���"��A�_J�ʝ��>�|J���`�����*��8L�첈��ƣ�t����3��փޡ��6=�J�L����)�W�3�P�0�u�^��
´	a���bU�jϑ���
v��Q�@�^���3O0�eh��~^-T��ޘ�e:�C*A���Uq�Ů�,J��X`Z�\�s��Ƶ<͐���3��k�[̧d?�`�f�����^�������J7Y�S�t��YS��FŒlEe�"C�&�GQ�Z������ ���V�O�@�YK��ɥL'��%�d+l���Np��r=%=J �A��
A�c�E����ǁ�6�ɘ<LD�5����ʗ9cWͭ6R� �U�/��ޚ��]�������6�(�_ sH�T���%�o�H�]�!'G��Y���\�Ü��֡�	��.�;����Ma��r��ܻ�8�;�ax=�s
�H����!P��-P�y�Ń��s��X��9�[g�Y2���/���8�7v�W�
D���Mc�O�F��!ٛ�r�j�j��SD"�x�d�!�>&1VL@g�	靘�	f1�n0�iJE1���t*
�3�
�ŵ1�%b�o��~��ދ����-�qm���΋'����2�h%���y�yA5��}Yn��g��7=�:�<C1�s�tQ�tE�1�j��y{gk;�ܣ��������O���\�C�R?Bg�i%���[y��w�_���K�9¿��Nz�Ʊ�şs�Vy�mLA%�l�$���+�Py�'wcb�nԪl��(�*u�ǌ����?�+��e��� HJ�z���\�S|!z���F���l� ܺs=<p�r,��� �+ e4S���M���͵K��_��c@�j���4O�զ���1-�i��۔,(߷9Ç1��4Z�α��^���';��'i����9v�/	�8�i��##��ĻT���nu˯eV[\����;��4@Y����*	�{v�r��8��(�yP<O��*߂G�E�/�?iڢ:E���m�t[�4�8.o@������I�p����LX	��ka&P��!���\s>=��S�D|���X    ô-C�-C ���4n�85�,{:F��`g���7;��K���+��f_U�ݠ*Qu����#�'�I����_�8�H���x�J7�`�ŧ�L�J�N!���o���1J�0E,޻)ޔ,^b�Tg���P�Tǀ��й��j4����9fFk2�d�{�� Y����w遮��˔U��cؖ��iG�mC�LGs$�p��']�c۪R��i����#s���Q[:��/j��i�u_��"Ct88�˰�	Aw�3̘���reh�q�m�}�	%��� "�#� �8ꬕ�A'�y8wg���K��Ӌ�լH_�HcL`��y����*d6�}�
�����3o�c��J!4�!���2�J���2c��	��G�Ҁ��&){9R(��}ҡH;�/-E��1���)eZΨ��rk��y~0>_u���K�#��j�K���_�^L��Ԫ�6��mܰ�����:l��S�rW��YK��y�6~��� �8�TM̓���?�t-��b��Uo�H��d�B&�H)�����j5D���g��r�{�Y=����Ie�ʤF��k:��B�(A\�>�5f�����,/�|?Fl֍��,����.xMY+�����MzJ� ��3ۦ���)���Ƥ���r7w�����N
��M8�-K�f�.� e�������:9*O͵��^�5���zט4�Z�&6���#�nĬ�!�R	!ђ��& B�sJ���Q6m0?b��2mL�at��1bqV�]������;�[�w�=P�f�B�a*�F�+�~���!Y�8��W�i��FK�FXE2�z�y^0JL!'� [����Cί~�DWL����N�lC�,S�
�.X��r��9�m���j��=�yj�g��x|0�T0+Ї	nO!pѡ������* 
H�NJ�Jb$��e���������D.+�)#M�ŐSD��b|�-�^�K�we�7'��e&i�#r����]����JJ�iD�m^�S=����8�}�)�s�I��S��O �)�Y�=��y���������BnݐtU�,Q�leKI:|q6Z]=����Q�n���N�	�� �I<*G�k�5�(p"�ѢvZ'�1 	����|b{;�v���7-|�}6�O�S�Aͫ�+�����v��&c܇�,g{�λ&;ޑDr��h
�C��T����z���؈���:�y���)$����@a>O�N�k?� �Qm�9��%���(��Y��٣�n�بa�e������Ϗ�;8\S$�r
tƇS�;���C�����YnQ�A�������9{���^M�s�6j���\�=�x�rH�Tjt<ޮF�_�\.T�=Or;�_lg0�E�2X.�3�Pf�b�2� ��W���(a(��Nn1=,@�B��y���%����d�Ѓ3`���x�׽�l���y+vgC���A6U[��}�x&��1U4t�k���9�l��2ڏ�u���D������]�|S)6���Lh����k�on~�4�y=S�Mj����,e���_N5��<EEH?���8<���
�1kf&��~N��4�U5sQ�|��Uq�4MQ+Na���c���� �8�Ӥ�v��=܉fy�����4�P|�y�a�vɬƻ�5[Y�6���x��"V��R1SG���E��'`9�����w�l��Fc���#��k^ulv�7|�1��$�$#�.G�ݨ��/̌w���y��*<X� y��&��Q�'jB���6���
(�Vd�~5K!.��G����*X��l �BE$-�(m����k�Jc6v-$��bx6�hF2�$:D�EN�3��猑?gL���8�j��m��IUf�Ai&�7T�tL3��1�Ç��'K�]�i}o���������xJ03�A�<3h����#w��ϔ6F��U������d�Q�ZX~��,
J�Qi�e��wn�]� ����߂��+�d�B)�/��*��z��z;�oŭ��CU��7�{��;u%�Ư����+S�fj����F��̋�ȡ+��A*�RJ7��]$���P�Y�Z��Ky�Q2����s�t�������w�<\͋� 1�*(�q`��&��ҋ?W�k�5�x1_�.�H�ɗ��P�߯s�	�{�eE� ��iiKޣ�܈�]�1�)�� ʠ�2�+�7a�A��������6.V�_|�����D?x������f�� �銮�]C@�fG��G\Tꉥ?0��w
��Ӥk�`��M$��@y��$���%SQˆ"��`�%;+����=ӗ{��~K�A6�@e�ŧՕ�|jN��68��U�uV���k���_�]��fY�/�����-�G�.�����*.���g�$1��@k�ļo>�Ws�����Ӊ�t�W�2���d�k	m}���=�ӄla0hd�DgT�ru0�~�b?j��,�	Sv���l�1U��I5mh:udpT��鷍H?\e5�ݧ�����1��A6����f#�gZ��W�����ľ�^JX��,�W�_����p��}����k@+f�d�K�o"�[��^�����b���w|�
�����������M�P��
�M	woη$��(�f-�S�PT�պ��aP�T�+x�g�R�)e�ж�
+��ɘ7!
�����9��������u;�D���"q:�T>9�jI��۹�5��fL�n��o�mȚ�ۺ,���F��Fjo���]�[;+Z�4���[�T, ����^�h1���ޣƍ�L�H+�?Lij���&!�b�NT/��jtA��Bٺr�������%x#�jP���L�1I�m����`���Y�ÇIJhQ �'���6��V���:Ŷ�d�=�f���D�rY�4���S_U�UI9U��Tl#�l���i���>�N��/�WԵ�Q��ۑ֣��CCl�<G�(�m�5NȞ<"tH���Â� "H|��T��@�Sz��K��0l�,��,V��x���nB��Za��i�W��_ ��H+��#
�t;TG�#@	 KԪ|O �@�f�1@���#�%' 헢��J�E/g_��`�k����\�i�9�l�nAp7�Gޓ������a�X�l�(o<���;��H����WO+�3����vܐ�����F�(��s�~�6���Ja�!�c��-T�ۉ݄�Q���	�P���]��N�r��b��W?��j�X�*2^�BDJ�I�+�����Tڅ�L }@�/Tp,ga����)�8�����r(&����?[�Q���IWd�a��w)9��J�b��wNiP��ۧ�����{;K;O�������,��K"���"ǔ�ʄ��p'ڛ����+i�c#�y2lwfnf�����#Xg����B�o5
���:�h$
^�s�~=<�*ww�"�E�m:�"� �ꐢ*�ƀ7I�w���,h����㲐bg��Wi��Ù���0����4:`�!��O��dj��Rm	�n�M�]o�y��ߍ�(a���%cv/��I�<���hóJ�7��xxvʎ��Si'�b�I�>|�������$ylQ0���Y�Qc8!n��5��=t������A<�pD4d�ٻ�"c1�B�}��-	�%}Q�r�/0��d�)�(J�j�FjA3o����g<v���ib1�&5+��T�	��g�A^4l��A�4�m��Z����ϧP�I܇�jbm���U�<�I7�փ��q���tWV����B�[%����ł0�����Z� x��#��1+ ]�MLh��d"�0�HhB\��W���+j;���@�� ������_��㻋%*�	��=
�~	g���.������T�劁K2��A��٠��#麩d�m�dm��[��[~��6�'{ʓu��(V���O=�^��e�{�����(��G�2���y)Q�rD1:�V�$���}�K������%Ȋ[㒅�1=fC�<��:Cb*{?g    uY*�a3_H�J{�@�Uq��@�uD{�z���	�
�	���x���o�@%X:S�AW�0Qp�0 i$h�i",�Gѽ��!�;�w>�r�SЈ�m��UG�l��m�4�ܖ����m{�ţ���n�R�u`�q'��g�ν:��p2g��F�d5�*�da��� �eq.\E1�d5k��5d��B彚���;vrii�Q�߸�#M�y4r5�g/�Cد��q8]�cfv�T����X�n����v�tb��|[�J��;�|��������-�����*�)Kl!��e(��V{��o[��=�W��p+\���1��d
}QYj�y�j�Y�{5*�C���� I�o�7�k�i-�{_�����~F�Q�O٨!����ŷ���TΘR��/�"꤈f�8����G��~V���P��K��%A4ˋ����(�i�p�79uM�X���7��2��$n$��J��k�� &��G2m�Z5�i[6S$��5��p�E�.?}�`�^�r̪_�n�����N�p�����i̶C\�-7M�A\�v���&�6�j�(+�\gN��b2s�t�Im=�ե��h�rl!�v���ar�0�	���\?�]��Is��r�7vV
�o� ������7���JP�m�- �NB{<�7�i♡J�a2�8%EUDD�>�\[���en=�y����}���xp~�l��O��eP�$��oZ����F �ƗMmM��	f��D������I���M�Py�p�2VLMi켺L���)� zd�ٕ�4���������F��s?�����/��-�%��W�1\��σ^/pC��Ys=�:gc�K����w�V�����{`a��	�]��.7=�{A߯��D��A�z����̪�����z��{�,�����59��I�H]^�3,�VZ�ߣ�\OR���ie����E��T��L��E�_�u��֑ �A�1�7��
�]^F����� �U����),:�N`�MdĦ�	�q䒈��{>]�е�^?�C��D�';��:�%i���_ؖY�\�P�'�ކ�>~`��=�8-��_�bb|��i�1�3������w��b��E=���������Si*M�I�GT�1aEP"[N
 �<A*�{�Bt����NM�D��T$Wa��/��Уkr��E���&b��"oD��=Q!��c7t{3s�̗#�B6o��:� ��J8�0�P-�&]k���{�p$Q8��rY>�{���/�/�;OWY�a�Yk�HcC���CâČ��劉�t�=2�zH���z�j=��([���-T�f=)��&X�ܐ�)����9k�]�ܹ	߆�^�r�QPO�C@�CʦT	�g>;�is�fs=��{Pd�$���;E#0�-��N�R��F��a^UmSV��@Ul�@��T[�S�Q>��v��h؎@�6�lI�s�9�?����0��u�4�!HZ�0oq���J@�\�O�j(�}��n��Å����Έ��]��*�//^�5j���I_}�d �L�� �2�7܅Yި�|���OQ3~���.���z5=�p�b�?�6C5���f����gq��{n_ꎱl���{�40���;��}�y���xlK3ISMM|��,���ú�z�H#�<;56�څ��+�{!B�m{�*�� _����/�F̑!`�+˧��Wn��ր��ao.T���ݘ����Y{�����B��U
^�}�)���YN���uv��L�4X�߈=ذ���Lx"p6cr0q�x�%k�������ٽ�mut��b��N3�$9��I��s�Aն���y���������ɚV�����&�J�(
� H�Rwˈ8ɱ���3�!�����R ]ȯ(A�c�WK��NQ�4A�Ǳ4�����R�8ԑzxnp� ��W�����TG�6W�N9���1oO}���LN`cPic�+;n��-V�oB��ˉ��" 6C��/f�qD�U���5< ��^�[����@�A�}Ue�eI�jٓ���5���?}����_��n��q1 )<$8>����7&�/)ױ��UE��R�֪��N&\<8(E��Zw�x(���J����,�+�1@_�Y��<��Ww�ۭ�<���(�$s�)o9�a���h�r�g])-V�����"��C��Ae:G�����W?���8l.U�41uR�e���
�U�by2H��V�%y�P��t(kqSfB�m"g��Q%�F�o�in�^�*.4-rВ;�Q�$GͼF�9%88�i�'���y��Fڱv�j;K�ݙky��qT���� ��+K�����k4)�`��[�@�=�d옉��6ŕ�j��w6�˒��v�{�&�7��b�Fq��(0Z�@su�\�����1X���/ ���9������� 2��i���p/��Y.}���VC�44��U�8
԰d�rdm�l�f��q���C���h+����Ӽ����ЯfY��<��DX
��00s�:x~\�hMD샢�>;���� ha��9zX���E�nǅ�K�B`�1T�;��V�Y$�N�vD����hL�����)�Ui�Qu�m3�t���(iq>7,���~��wPt]�Z.x3k��!�m#l���ݭE0"ĕI^�I�[ D~w�:��>�Rf��@H���i��r�mh�5oƔ�G�lN�3n�'������z�h�yx��>[���A���R��X��@>.[5�Q�H�G^��BVג���IU�Sz�,jƃ6/5y�6�;(�b��N(xc)�~�������U�q�$��+˜(<G �yT�y���%��R������0E�3N��7����4i�ch�K�����M��^�M �Qܩl2_��_��ѣses�������|��o���{,�ͭ���(ń������,�tAy����Ӭ���&Y�O?N2w$|x/'uK�V�ٙJ��/��X�?N����t��@k��H�%��J�L~f�>FA�S<�g�J9����s�v}UWӲlK�L�7��̖ 8�4L[R��7���]C��z����)����ܩ�=��t3�jʘA��[���������6XHdS�!��K=���綂^��@|�����u��@1���:�� ✼z��*ߦg���+�
Em�Uq�خ(2�bS�:V���a�`���2��ur�ں��T���د꺱`]f5�F��+�)�1B�y��&��	d��������� �t5�\�����7?�pq��kX���l���2���I�"E����i��t�>s<k�j���q��T(1�c
��`bEY!����W!�1*D�C��{ؿ��ddo�
��xe�����@�k��'�w�~?W{(L#���5�����@#БF�*�7]-���P�l�[�x#E�Ը�,*SI���"�E�ʣ��I�ٳ���?��Ct#nN�h)@5�6>���iB�u7�ȼ����jqʒ�H���5�&�+Y@���^�8���"�����or9��[���;I�-;[�&���˒,�1$� V�㢳C�˚�vz[g��x��%K�Ϟ�uȶ!�-V����j�B����?��Mva/�˥Bu�
)�{��yfrĬJ�U�����B��t��`\ң�
)*����ܯ6]8�=��/32*�y��?��N������LIK�l/1d����"yM������nfL!&�R f������Ϊ�?gS�*AtO���O��JV �c�J(?:v�5��hX��I��j�3S���������Ϥ�/z�ѓ�K��?����W��b�n������Fl�����h��@�8�M�H��S�-��=ڿAr�ؤ�V�19�4�S1d��9^C�ޱUtA94hR�H0�	����	'`CB�,�G� �"n@@X3}�ļ����ʹ�_tU�LE�4����n�]�M�(��l���n����R�}4L�����a�{���V� mŽ    ~��0����@��I��-j��7,ű�*��a?[5�`�����{�����/�S,ׁʗ�j�~��w ���t� -T��oRb�U�T�r���z2kzJ�[H�#xT^BB�c���V�xhόR�0�6<j�0����>�2�A5�7��*�y��T��tj*MI7lG�5ݗ,������U��l�N�n�'��l=�)���A+L��-����O# K\4��縁s+���	Ip3�s�-�4N�>�F�
����*�pge>����U�#�wo�7*�y�3U{Q��&.��i\��J�p����"^	B�����T�-��5�m�}��<#�����0�a�!>5�\��]ƚ_�^�C���J�K�m������ꧮ�b[R5C�s�ᔅ�y�=<��֣�C����^���CD�P{:��D�1ADԯ��L#�O�L�������3����"H;���*�BH=RL���\�c $��Z_=lP��|��4�p��m{��"6��,�W�m��D�k�YY�LG2=�Z\!l��}�H�Qu�mRqu+�&�[3f=t1.b����wH�)�o9���(�+c�^KExE75S��lF7�l���o=З���p��H�ƺ���I��Oyt���`�U��w��~�����|�\+���L/�IL���P�"���+K���T��8�~5MѫE���nnm~���ZB�W:uQW�)\�(����bv�Ѯ3�����\]?���Tӧ������l6�B[�Y��Ģ|��b�	��l)�|�y�T��5��_Q]M�m_�妣���ʶ��C�������(��/��M����hy-j��mm�X;=Z*X�������Z����@�<��.ȩh=1Ơk܄����ߚ�$+�\��� ��Q��/�	e�Su������cX� L�X�ߖ'�y�����ԫ�L�����u�foU����U?��[a���$p�(FY�YE�t�,�{�()����4�F�0-ۮhs2�5�^s�k4�u�Ć.떑�h�w�˖�\�m��4֜g��S�������Qޯ��MF[�6RJ�ձ-j�ז��e̖�G��x� �BH����M_uv�qU��xb5���V��,�9%��V(��Px40���W%k���򜷣0ŝ@6�)�9� ;��w��^��S�������`�K��=�]����+� /F
��\|�����L��{���4H��8�eP�;��X�rBԀ �}zZ��֍���Q�Ȓ�9�i�5l�wN��d9�"��K�G��e������'O�ݭ�C�^���'�y��^�P"��]y�dB��e�W��å�[�X�{�5*��Fm��ɼ$4p��܁�������OA|��d)�݊��s��6��+V�|
�'o<(���d��-~��V��!<�<%��/�aW�m��Lh��HA��Lو��Ʉ"��� '+X�낌 �nx�w0+
HNP^G,��a�	�N��^�i�������>���%��n�^�1&���`ڊ&i�`�ՙoP�@�pO����b=n>y��o?8�
�d���q��̜4�� ����W�I׸@9�¹ϩ�@0� �O1HKɅ� ��T�ۣ].�Vڂm������D-T����"_D�Ц�Z"���k-�+8rA������T��s���U�D<폣�$�ix$ؽ�{1�f�������*�"�+-׽w�\Gqi��y �(���fi��v����=�ܓ����=z��E�lvP *8�"sx���BO����U�,C�	��'��|�&��;f$��)'�%�	�,9	�b���wu�%�Ŧž��Mx��)sU+��;ρ�/r����b�"%Hz�vPy�<�ُY�s^��,��%��5��j:l�[m[�̯j*��-����6?��N:g��GZz�`�X����<@V����sw��m�����G�yyI�iQ��tt�]:�8�¥�ײΖ��G���T�
�OZ�����ѻ;�[��b���rl����T���3�g9b~�=�tڲ��6�+T.un@z�0�v�3bc��?f<"DØRG�.>�G-hYL�М����x��|1�9�q������5
�YV4ٲ�F�,�m3�-����_�hW�T�4T��c5�P�sk�[[�<�ם��������P�[+@~�ÚB"b�k�,h�Q��r�'p�NJ�KQf>N���8���~g}y���������@��~�)�)���h��5X�p.�v�b`��D�u��>�T�nL��l�
��5��p�����x���:X��Fa���������U�?��Z�(�m)�ÆR5SD��Q$�֕���o�4w���~��6l��8k���ʗ_���,G��/<# ���f��l��.;p���7H�%�PS���ͣ���L&)"8 w�����[��mL���Iݸ�K2d{FI^ 5Ҹ�c�倝&�n����YvQ��ПE�F��i����0��ى�eþ�f��lr�HH�s.�1>P��I�@+����%~T�Qr�-�d#.�)��V�O�['ʖ�^�$y��S8�(b���*{�Z�]
�'��?�N�X/(��eTZf.�����ܰ���֐x�+��hN�Ǆ A�A�C�A����;��6�QV\ uӹ��<}C'.9�켄��|�o�n������%���|K,��!q�#xo�����V8����
�*�{÷���E�p�-+�d�%>[J�oC_�?�����S�u�n��'�U�ͯ�h��H0����1ա�8�f���(����'�ȋ�e�3�N��Ζ�QT��ߊG�ۨC~0uyZ�F\�-��[��������Wț�����q�^���h���(5���~�J�V%����Z����F�Ws��@Q�b�C"|1m��%C!`|��e+5�'�����\^��g���h�Y`_1[�C��#i1O�Ӻ�� D1��L�����7EG!{�X<!���W�4���c�M~�1��1�P�;3�Q��4I�f�*w�^@�L�bve'�����SGTG��=7��W?]�n�KL��ݫ�շgB�
��6E�	=�h�{.7�[zH���ۗ:��fY���Ӝ�)����H��>he��4��`f��VYS�}���ڱ��i'|����6��I���߂��Y�����D�*%"kQk�Ԍ����_���!X�����u�̩ @�ɋ���^@-��Ne�`���2HQ��]�;��z��8�ة�;�1@�<e�#n*�� ��H�LO9��o���Qd��	��*��(f��6J�?��vG˪�Q_??�;��6��N��7D��G��#U��U�^'`6Q�0q�1
ү@�\�?,�"�kM�5����_N�gB�]��-�m�ל�D+.�
�Ee*h˕�����N��9	(�B�D���I���b��3����bvtcf&�%�z�u�ǋ���.�x3Ϙ��l�z@�6|Y�0���*����g�l-�n�?Q峑�7�G���Kw���%X��եRw���~-�K��ď�$ٰT;k:�P"�8$�9���&Kyy	��Yc���	�2���q����;��|Npz��Y�'-��ZTt�/�̋�_y5�W�D��ZV[���^��ٖ���f6��� �x�P��.�CZ�s�����J��1�lUi��ͩ��A)��Ⱥ�Z��  Դ-���e����#ɴ-��lݴ������#��m���G�hp���L-Tϼ�U���ղr�VJ��x@?������Cp��HDg3��ÿ�� [$��`3����m1f�e��^c�:]!��9ewi�7'�ED�X��i�<x�K�ǑZY��=�"�6Z��ju~�+�0�S1���
���}�v��,���B�j��������lؗ1O&K�%�X�G��H�!�kh�����žfx��[�C�*[Cѕ�b�������$��++�zd����bm�x�d]�V`*O�.0 H]]�n'��[��Wd�u���x?��q�W���;kT�j����C��:d�I��5�[�"Ën,S�_ �    U��j�捍2�2���KP�C0��q�*��/��֜��[�T���XSO?+H�a��bӏ�	
�A0>F�<$��AJ4��Ԭ͆�l�yy7s������q���``�]R5S02��R6ĩ[���Q./?���uy��<_�Ɠ��NB�J�YO��R��Њ�ӹT;n^�i�U����z)>������ї�2�9e�f��my�[��K
`�S.���\��ʒG�m�׫�?Ǌx�g��1$�z�fU��lfM�zҹ؀p�SA�*�\��3����3�l��i��Ĭ��(險;��ե������xВdI�Yb��UT�vJ��Ҹe�����᮶�R�O�0ۏќK/���Hr���d��	�?�"�߁��*e�����L�|���L�8z�.���e�z���ƁOx1�߆��r����y�����7�Eu��AuqK�(��Q�$�'�5E�φQk���>9]"�l�9|\�/\(�q;!�z��p�} GHN%6�E�L��f���]9�Y�H�b3�FbÊCW���m�%t�ٳ~������5W�VM��-7��#��b��4��c���k"rW�ewT�G?s�l�����I����N=�	�,�S�������1�s�s���藈1����4Ë��B�[�(7-�E5���)�k�����Ԭ��:?f����+����8A� &ņ��#W���I@5)�36�.�{ �U@@����f�U�([���{4�W�ԥ�5�,��}c7�_��!�zA�K�*1C���X��Q��E~5S+[}~|�=^�����l����c7�!R�Bt��	�p��QKO\����4DM��q���$��2PV>0���0ò�Y�\��s�S�QY�|��U��w��W���/�`���4ضa�T�X��z�'�Q����u1�+��Q�t���u��oS���a�kh&O5�=����1�������nk��7���SG7����e���#�@�Bb�t��g/��7AS$�}�*�KGks�͵�WPf�ֆ��!�0�%í*�|��s}I�t�iW�K�����2��ە��K6#@Cc�0��:�N����p�7q�������)G��"�4�)�DED�����$�&PdQ�gh3�}~9��R?��,S)�@��s�Q����T��'�$����(X��������4K�
�#�Y=5�߁uZ�[>�Vf�Ო���A\�v�����:����!ۘ�{�c67�6�u`tCbRxO�v+bY<LtuQ�z���.���6��Q�鎱>7�JD%�!9;d�`b
�fJ�Ԍ�A1p�MD:�^�7��jvR���m*�&e�;r�y�Ħ��0e&aZf%/��`Џ�4�]�
�PRTՒTK�%8�c�%��8y��<u��3�;޳�&���a(��\`�`�<p_=�����]j���a*+q�,�;,f��8P�a��L9�h��c�� ��߲�����Kh�(S�Ee
���͖y��Zid��-��Eo�+#���t�z]��뗟��"`��aJx��`�@S�,���g�9��	����uC�lu��,�d���VZ�=��v��}�By�ץ��N�?��q.�3+PU]D��K%��h����z��|�w<�*�?��OQZn��񨲼�7��  u��w[���;<�ݼ֩@�#O9���:�k�Vi�5!��}v�$�z���������F��X!1s�R:�;�����0�-6ib�^I��k=�F�jV�����tQ�U�ٴJ�b�I��9x*u��ͧg���f��R�p,@`R����� %�F� ��p���*�+T_�@q�E;�� �D��(2��/�5�����7
��)�+?���[����h�-T�%�q���t'��U߱h�ruD>���Yq3���3됗�.F@��co�d[V%���/!c��Z9��yƜ���oa+t$Z�KV�a�Z����l��V8>���E>���/;k4 9jܑߋ�.�cځ�P�a)��m�<�F�|�=p���s��q�'Q��c�I{�p��xRe��?Ħ6^�F�5j[²�kb�^�*Gw��nPҋ��3�T����Ԩ�n��+x��&Ŋ`��=�84y�H�:*�������~ ���i�T�\�����d~C�t10TBb�>�m���c�6��u����}��(���wуng���R�N����W���芮>=Q�hc�>p�h�Q�'ZC�De,P�By�W��'KX%o(��on�/-��X�P��,T�ތoJZ�H��S�����Z:W-�\�^�ZdEi���K�怦�/?�"E���f2�F_N����0E	e,P�[qğ�Hq�u�^o�9�����=�R3����ܐ�N�(�4,[|VL��������ǭnc��N,�|���S��]{9�3���%���� 4(d����\cK�j��b�I<|p���3��B ��e/�@E;��#���^�������v6Y��)!� �jpm�*u��8�"��GH�q�'�w��b
���n�B�__����������|N�\�B�������� '
}�M�Y��&���L�rJjj�dXo�+]ws��a%Gݣ�Q��,,N$�5b~W{2�r�:J�Q�?�@'�KP�{��
�����{O5y�4��}NPKݘc�4�a�W���;\��ى߆L_�̰�a����&WN����?ĐY��o�H�J���U�Ͽ�2|t�5��~9��@@f�����I]�L1��c|2v	�r]���C�:�d��uǟ����Gl�~'E��TR7mN�"��H�)��vӲ9�����nS�+[�u(�l�׵�yK�J	Q�S\%Aǩ1O�HP �Ұ:/�a�̯g��>�x�|T-
��[A���c�$zyu2 C�Ge��/�:YL�@�����Jf:����)�4�t����!��{�N`��%q�w=�ь�b��'��A,�� �U���Ɣ�B�-W�`甘��!b��-����<8t�$tl �T�4t����u����k{��a=����I>�SX����3�+�-� .j�s+���#�0&�YJ�x�9���#�{�bN�
]P	�[�B���c2�߿�x���</+��5���|vØ��hV��J�Ҕ��.)`=��݋?O��;X��FA'��*7��<�g���0}��Tچ�Q��M	�w�ra��=��Ɣo)J��1__S��Y�s����za?���_�϶�����B٥�ȭU/�E�n�IusR�A(�<�*���i��G>e�t�3~@��ˌ.�@�%T�»#"�ᐃ�I��eqygxBy	�[���F��
��aYh�R������ ��7�|jo}��l�H2x�.�n�@��!j't?x�tih�w���QGN�l�ُ��g˙��?�gs?l�6�?���G����ۃV��sA�p&G�?Cx��W=��"������9Y���.&߰Q��e�@�E�?cuC�87rU��(['�6+LȽ����(&'�+������;L8��h"N����w��7��]td��je���N
���(�RF��W9�t�O���b�]e,�fL�z��=@p�d@�j9-�w���nC}~Pj�ih �!J t�)D5�Z����x�WIgK�����ȫ���.�)��Ѫ� ��Z﹃.�vd���@�d�>�Oȉ_F�	)�ܡ��@,F���G:��R�,1|�'!�
���H,T��oXj���3tO���uO���8���0`�&��Y�A�*�x3c��>-K�m�`jy��4S�\�����鉏�u����d����d�QJ��Rhk��˝Ӄ���j��y���@x�m�
�c��&�ǣ��N8kBY�=oB�D�3Y;��9�j̅i+��9���K���@�(��@�l¹������i~tB�<�A����-����;�ɇ�����Lg[��0�_Hw�=x.6��-�ʛ{�ki	<� Vf.��*�#>���w/���+�D�ݝ�}    �!w�N�yy-{��ݻ dL��S�X#n��3p9�5�y�w�e;�~����*�*}�n3�mg�YO������I ���4כ��bm
�)S��(��ͨ�od�ph�b0��ˈ.~�9A���G��/��:˭���N� L#�o�L��H�a�Pp�u1k��Ⱦ��̯�r!!7mّ,�p�ϊYR7���C���|u�乵�v�����\�r�=�#Xx�\��-P"�H����L���Q�4�A7�b$%��X����?���.i�!'%������z֪�^�O��o�ݪ2AK�!:%/.���\�����쵍��@��b�#��z��](Ƀ��B{�,� �a6AC�PA�~�	�Ld,���"��@r�C�Z�ϯϢhn�H��r=VM��a�1�?f�K˲�&㕆�jgO�Ǐ�fw��;�>��b��7���ք�}�:���}v��p�\�T�R�%o�2:�����㾷!Sy���xl�~����h=fb��"N�W����}�B�~
��W�}�G�#
�!��tge�=ד�-$��]��A�9�1�S��1<"v/zz�"AY�g�f�2�����ЧiȚ�k��L�d��/w��2ͥ��;�۾?ҷ�n!>�^��_^b���+;���GAs����j4��q%��Oj�V�W_��G�w*�⦞ho���mA�h��"fQ�6��-vW�Y��c��:p��W�
�*���Vu�Rr������>\����])4� �l>��g��3���o�1 f��<�Md�O��y�@�1��\���c�7��\���0�yɩ��)Y�fg���iEOO[�'O���g�+f#��+`�^Y��������Ey�QK�$������������,�M=���!3�~���6p�R �t��H����Hr^;�E՚���/�vZL5A;�J�XH�m�g��}�`�kȫ~�_�C�G|QȘׇ�A���������I��Իf�ǀ'��j�a�;/ �0&�D)�̸��o�'1�܆������Z�m)�&;���R�C���z�4ڋ�As������Q��������<��\���G�+5�~�X�on���e���s��[i�3���L���^����<oCJs�Ίݪ�حM�ȕ�~��C`�\mz�̡v��-J瑉m�#�#\	��ޯ�N� J�=!��Ҡ�$��9�N9Il@�!լ�fJ����33K����F�6lt��'K�+O�v�䵉�7���Ћ�oz/m����'n�װǇ0x� &�7�۠}4_�����ń=�	q,q`��f"7(O�Fze�)���8��J��s=?I�1�S��8Z�.��Ѝre$����.��r$��������x�!���L�@rq|�y��L�#i�6�>� ;<�`PzL��y���G���m+l��gҕ�G��U��U�r,��e7���v�
�3}��z��do�n{[�ǅ��i����k��;��C7�+\���Vw�~��^�?��g/;�0	�0��ρ�u�±Py�gx��{�f�\ԦT����1��j�V6��`�<�"}/��H% �U.�A���u�%���e
L����5GS-����a ���""<�%v�	�.�}̍gL�����;Χ�H|�L���B���ȋ�����۲d���m��RD�x�s>\s�kqc������Q���s�yX�Ykbw����\;)�l�'��/>�4�;����xԃd\�w�^Ϗ�>r�N��6��������hL�����
WV�r��3!5����â�&�>�Pa?
��A�OG�߄�J)���͏�Y�j�J���6]�U���g������Íy%P9��Fo6�n��������i��DY��hvI��T~��4l����ޮ7r�J���+��������}���Z-��bQUT�RYR�*���`�`0�$m���d�y؍`.��+�	�/y�Zko��j�K���$��T���k���Z�z��n�����j|��<Rv2�jo@W{��8e[W�AV��R�?bp�� �0?oM(��
�����IM����Bא'?�@����6������b�TUg�1��x�ʽW��C�B�Vd�*�O9��R<� S��L0	[PG�ۘN���$�Ф����"�Ә��Q��fw��U�|?���P��MX���^�Eț�f��l9�n����Fɣ���ɓ'O;q[]�R��Q�Ḫ	�i}�> شbe�V������Jdg:N���F�E#���z9�v+e���m����TcD�8�{6�;1�~��L���Ԩ��Ҩ�H ��^���H��#���NHO:l�f�1F�i�W��2�����DΙ�J�6o���k[+�bP��MrM�\������ֱ�[:ݐ�I���M��`��N<�sG5*�� [�
[n[�ϦS��M��VZ��y_<p����=i��M�#ۘ�ܛ�ޝ��?�*����AP�{�F�+��_�._Ix�����k��E؍�M@���\)�+;}oZ�U���%Iov��\osW�E6%[�Q;���g������Y�8x����w�(���a�2�P����#��&~T�I��R���#��hb��zT���Ő�л�3��q�;t'u�����R�b�����L�>��N�X1Ѧ�I ���@��@ѐ�c�*A.��H��-X��~�E�n���&Hx�a�/�kN�ð7��)���
pS��w�~�C;;;k�bv�*	��n ��Y�i�>Ҷh��E �0��_�E��F��;Xl��Ŗ�xu�i��X|y��lHk�垐����e��O��B[<I��Ԁ�S��%)@���&�c읧{��@��\-j#,4�'�+��֤�̪���x�ɽѮ\�����cMa�ҺE��IZ�Ȥ^�a�1��b�<2}࿰��Cj���㆚���g��fpb��nCsLO�C���r2�a�є��~�X����ي�s�j���p>F�*�̈C�|� *�����j�o�v��^'�W����u}yw@��o�d�u:�a(b�ֺ�KXU��-�-��cV�ֳ�ZFRuW��Y��;?��4�b�C���W��Xw,�z�{��_���N�������-l�c�u�N�0)I�B�7#��]��[�Fx�)q�UL�����h��H���w�wƪH��Y��bgSt���v�!k��H����n���u
�NN��qR��J�4I�$�0~j��N*A,��(=����Z�%�_~7�j��cZ�kA��i��R��� ���{1�[7բh���*c�3~��&�S��!I ���1[�>��'Dr����'%=�ŀ_`�Y�8@��؋��b)$] �)INw�i�M}_�Y`(�[I@�d̧L�2u��~-[5$ۦ�Mf�a�nm|����{am�x�y� >�;�>*R��@����h�s�C �Nv��؏t�,�zTȄN�L~�pR�l����je�6`{ػ5�[5���h��>+�Q3��u�:
�ّ����}9� 5��m�u�F�ŉ\��l�K'��3-��4%qy!����
�^Oĸ�\��f��~�x�T܆��m��"t~J�!P׎�����A�{��\�H[v��n�p�Lo��
��3�e�Aư�n��x�_�y��A���Q�Mp77�y��ؕ��u{���G�,)Qz���d��ލ��l�6��lx���"s7T+k����$��Q���8���Y��mZT����o��9l�E�ӂbn��b�zB���w$�(+��z����ukQ{~���P������Y��2��F�]v���}j��{��.���yB�P��H	qKo���M�]�R@�fVM��'��`J"_g1�4c�z}����fO*5��R��pO�*����X	���Dz�e�� ���x?NK���AQH���戰+!�9�#�A�M%7%�_v_��[�eq��Ԉ����    �?�V��;�h V5E2t�?krY [S���V�h}�߾��ix�h.���Y�	��V5>��^��Z#��n�|-d%6]./mj ���r3 ��c�̣��g�	�B�<�D�#C����c�c+�{�2���'���
���o˽l�ՅCɨn�io�_��&� �N�Q��7%�B2��M�񨔌U�R�����>0ś{lu���3/|M1t��)���*���9�!�� ��ڗ�wV����Y�d>m���A���/g��B�V|ދ�&��r�-�\���3�p���2��2S�ǭ�+(?�~P���ߎ!�b`�c�bxV�kT�h��'Ճ�M�ʞ�4�IM/{wM�m�L��R_t��&N$�`g�Mh� ��Q�$�y�ߠ�������<� Zr4�Cfϖ������A�l��>���aw�X�蜨���n���[�~��Hf?E��n'���aQ��[��>*[~��sTN��@��mu��#�"��2&MJO��}�1�ؿU��� ��F8����-����l�}�d�r?G}ۆ\��l�t��)����]�̻�A��k�l�/]O�~�{X�#%4zg��Νlw�bH��`nv��]�?wpbd�)�(Lȅh��\��<;Vi얿+���ꢼ�24�(=ln>n��l�����/�U��_�^b-W4�p�W�WHFd�%�e�3�S4Qgp������nm�u�.|�Ν�5Bm,�� eTh[U�ʞ�SQ�d�fÆ ��YI(�R�gk��'{��>M��a���exN���F����(�d�X�?&J_��G �ME�:�����D�:��+���� U�0Ű�cشM�/��ӎa���H�%ے�d}��^��������Z�����ɦ���+�#2��kŪ,��f֩������Q�GH3B�/�>Bl�Q�W/hg�@���A'�Y��C�?U��~O�\,�Ƭ��+��pd�;�]y��c�����kB��MM�ZveR��C�-8!2;b�,Cm(�h�h����i�9���7q{
��vf8y�)�h��"��9cIo���x�D�8y��D�/�w�B��>������xl��%��;4T��/��H��qPL�_L0�ܾzf���y���BqY�$�.�5�XC&pN�rff�=�/���7����c��ܫ�ޢ�O��>������g�3P ����k���0.%T�g�~�cRvRi+�1� �"���p�-�
!�nP*���7�mo�Q�v�W�z�i��:��Y5˶��+����Ka�[?�m�/���hWh.ٷ�Q�j�PF">ulU�#������=�'G	�Y�2�Z��ӆ��|��cy,J��<��ʻ>��5�ky�ute�uB���#ir��)A�W����X�	6ʁ5��X�w�'���l0�9���IȬ�[½��x���!�ُY,��$�Y��Q��,����L����ç�;3�ق^F�QtF��[�+�V���>7���h��4�Z����|N��,A�g��)�s�.2�E�\��m��M����g^n�a��\���Z�I�cBF"���"g*�����P�q�ȳƘ݌_ 't�*�W�j�L?c免��RMd|�K�9�:���Fۀ��P�>4�������zR?r���8�|���8���[���}��M��s#���5́Լ)�n��Y������?�n���t����n~/[��2#��"��!��V��G�|6Ԛ� ���dp��4B4n?�j(E퀌����-��V1 �-4T���ܟ�ޚ�������ܫ�����b��D@^�������(�7�;�=H!eX�	���܀"�8Q*%u¦��B�~�FØ�tI����=9�ON��AΘр�ϲ�z�m�?����������n�W?Xh�C�(�K��,�E�k��9X���� �I3PN��A�,���W̖���w'9j�fplOAd��=�9'D�9We(}d�x�+w�r�|�F�wEy�+�#WT�+j�mz��2:O3�в���E�u<$�371�{�xՀXP����ADN����0��z�%�e����O��Ƴy1�%��[!2o��Ш�Z�YKQA0�C��|pq�5h���l��p>�-�`�/&���8E �EpD�:��Y��7q�V��a�9KX�4���9"&f*����̘�U {����%*����S�Cf�׸9)��)@a#@� D-B*9��!��V�;`6b�����R0�������$�g������CL���5ܴ�6���}8�E�뵺�%; �Gr	l[3m��~���/����s{;�'KVC_�
��L���ƚ��\��d�fQe�јyB� ����jr8ሠ�=؂��	'nX����"�y�)s�{3һ2�k�A�v�L�Ap�S��iT�A5#�17������Z���]���<,�Ơ9��ZA�7)��^��Y��:�H��������I��T�,g����Ѽ���Ȍ_�,W�U��Ϩ�fݰLE�4[�%C����Qy�M6,])����:���Q�8=_U�����F���F�|4��"��6�4�P=��	�̅�@f�D��.��Q���rV�"�?C��C�>�&_A��;6�;3Ƽ�) ����4~<M�@J���ʼ`���+���[@]��GkR�[�/�����BܡXe 6��(�����<-,��`E�")�~g�LfЏ>����[}��	˸��4$G�Rٔ��l��c��ַ͝��ŕ���~�s,�x�m��!(�e�9�F1[��:��f�����-�t��R?��.՘3�a�Ɠ�ϝ�)���GD��d�r_��}�5*�1-Q)�����l���x�m^e+U��>���U,A�P�=,h�ؘ�z�� ��t�j>{k?%�uawwA�o�D�R�)'KVK�e�泦�O�67�8?��X���sQ���\�Vb�d����]�u���������Ң~�4�?2�v�nm���2RC�ì4��C�u�n����'?�WrA	��S^C��!��`�ľ�,�����f�����'i�[q]UM�ve�9�K�f@�2&�xX���yn����7�K��]�����el�ict����H��b����7�/��J{���jI_�·ÕӞ��tgo/�*�`]}m�T�,]�G+6	D�-ҰVbO(� AQy�<4����S���Gin��(�^�b�������$t	PK�%��C�U��V��f��u;� cq�q*b��8ր'w�����F�)�࿁����g]� �����)�GhT�';�z���|�1V.�y�����mE��`@�.�rFli)�U��֝z�08��_R���E��.�z��fE���˺��knO� s�(�d5mt���f(���!;O���\IF(­E|d����B��{3ֻ3�-�䤺�G��k��3��q�%ǬRq=��§�^��}��Dt8pV�R/ �nA�Q
c�s��r	��o|[^h����PQTG�!$�uU+�[���Vc�p��"��VNw��y1m
�f��*�uJKB��D�UP-��StyE4d/Dm̜�V���0�	N�g��mA���<�Ƕ�0�d �z�%6#����W� ���:��6�ON�>UFݧ��}R�� ��؍�E���Q[�Ŋ��x.���Ū�h�IA�R-��H�=H����V�a�z���n�6�.�l9���=�\Y�,���&�۲�7T��e��+ץ}s~p�}��h�����|_�]�E5`i�� fƯ�C��꣐�R�쌄�z�|V�3�	&p��V��0���r����[�����`+9;g�cùs�|˚�&sOTQq�
4\d�D=����Z�qul[�V�"u�G%Mde�$13��$[�q��v����1�*���2���]����n�9��
sB'i�ng�zK�ʺ����N�k�{R�1�.��k�B�7��&r�c�ZY�J�$�«/!}�} �d�' �C��"}�_���ۈ�vY ����k�`�K0"ظB�    �_}5��ܯ�ޱY��ל���}�Ze�A�04��+#uw�-Cl��]I#����B��p���&aP�z���y���BQ��"eO�1b	�B�64�����t�����>mZ��sm��XE6�΃���˚y�.l�U��+e���+�O����Ab/�:[K���� _ G����s���&�3:4��MgV�t\��;�7��&	w������I�C��'���gy���
��X��Ω�LH���4��r���y�$	'|��R��@>aV[xV�_�e�	��Q�����	ic*�#,�!�wy�/���t���o�I��'���J�nڒ�]�T�������rЎ/O�mw������~�,>⇲lr�\����s����Mq�I�5��gk:�O��;�ՋD׀��9�z~���ɝ�d~7��*�G�"M�gP툪�������"kO�`�y�EW�_ֽĽ�	'�f�9�{Hj��xbp����q��S�%#�b<�����y�-y��Ȧ�]�)Y��)��vY����y:�4���%�4\�zr~��^P��m$�6�uR�C	󏱇-R2g);�@��zm>k��Q��ZLr�MdԤ#$���=b$\�U�K��S��{�:�˳������uzZ5Lݬ~��!ϕ�+�T����}Pǎh�.ND���A)߈����6uHn�]�9s��YΧ������j38A]/��Eߓ�[�i���Jr�ƒ,$ƚ]֝���=��sc8tWx�I�%\�_����Õ���*`{\��5�R�
�#��$C�"���W�c��oaԈ(��%�T��8o�H���'E�pR4��Y��u��F�ͼ�Vzڭ����q�G�^L� �p"p���`O���T�aK���:{�I��H���á��'H�3p9(��5?���ϸ�gMﲗ�)3��f&��y�D�
���`�*��"; �0�ԝ�'�A=5����ǡ�4��k݁����|��S';`��~f��"d� P�	K�#G�9��	��[>VA�Ȑ<K�����Y�C�׻C9r^��z҈*��ܯ�~�]TT��ԣ:�fr���m��[+�SH'��Ѻ������j�k�z���u�Z�V�nB��!!���&�`�}�	̪�r���Cn���\�5�6�����8���,Y�4Es$�1�������eI:�|�d4N�;I����fA�o��;s��	�]{�ۅ���ɕ��� %�QW�(���&�Sf�¿T�i�� h�n��.��X,Q屸t~�����d�F�V�)�Ӯ���i1��>L�C��0/�%��7���c	������{aD �zٚ�E�G�r��x�M�Ze|T�h�-��le?�e���ce��5vOw�W���Y��l��j7�����OMB�b`zW���nÖ���Ԕ�\ƕ��PFUk\_)/�7Q�j�3T: �'.�<dY��� �!�����X�&2���&��D�<ѐ+{�����s��acG��C�n���TIq8	�ӧ�T���뇸�iRM���0��8�v�i�;}����c|K�X(�i�i��g��om׷/�։q����w��uz�UW�]8< r�կ +FA\�ÂO���૾>�T��,��\�p`�����ͬ�C5!���!Je�}���鍓+,y~A[w���OW�j�x���c�f���l#�%|) ˩�$0*0)� �S��&�2.�"[����	���g��FѦ�:��x��&��K+ɑ������+��Q|��C�|��I������Gq�ݯU�0���N����(w^o�I��-�/"��H�.��c�W���N�-Wu�����8]��"�6e���c>�K/� ���I&�$�);f
��.uԓ���Q�<��o�ڄM��5IW����n�4��=i�t��@��yO睝qګ�v�TJ�DP|!a5���y%��<��箚���B��?�8�D�E�2���s`|�Y(�'W,��C��y��w}��e�yG����}GW�#i�y����G���V��jn������G�A(t�l�HVw	�	��@�����HA�%U汤�P����`'7~���wi�lA�]�vb?y��*�b7���$���6�0,C/��r��Xڲ���KG�dO��������4�<�_	z���(Љ%0��`���-r���7
���C�����+�$��L�m'���d3�{0Ļ2���4�g�Ƭ�]�E�*.�/��uT����fC`��{����#��Y��ӡ�:qE! `ls�-����)��F�Xt�����.-0Z9��M�S7�4�����x��{�bz�櫀�� ���6�])�Y��qz9\�7zKq{qw{N�ڛ��4�
�P9Vq���J����}c��!��ecn��Y��9v��&&;/T� *1��m�q�ǝ)j�&���<*[�����Hs����Ӫ�H�N׸�Y���$��
�>�%�G�C��^�0�ߊ}�?�1����R��"��mŮ@�T��f*�	��$Qōp�����mJ��$��8v���=��H��ќ�~>�O�����qI�mȦa���a�^�)���~�� ��ПF����rH�Ύ&��~�ޏ���~}^1�G�B�5IPȋ�7-��e��~y��3ֻ2���(�jc�S\ ��+:8�Y1`�H��՟�����Po�gFn`�����|7'`��Hp_�ݯ��&��|�ڙ���0/ۂ2ɨ�ȢORd�6tC2��	F2�rH��Nײ�7���y��=?��M��n�J �����&�}v8��.8Eu��Y�ߒ�=�HQnq�bf�.�k��@���<X�r��3�wu\76�|ٚ����ZfU\ 0+ {4��~�m���/���q;^��PW��x�F��������I�.��������-�$E����!0�_�,�0��'�P���7�'�<�G��m���i��SLJ�m(��A�B섦��
K�psnЎ��Β����=�3�|����u^�%���	؞��# W�G�=��`i���a����@�/2�g8#!���b��Zp{��/f��9a���FO����1�2	�������������/Z�����"\ _��]�����ݘ������/�Cv��I��`k΄WAu�v��/���^�K���)0l�V�:��7�9!��Z�9���
�Vϗ����������7��?.JZ�::9`�m�͂�9���G�fيk����#0���I�­e���n�6n�����TQ�B= �'8 4��ɿ0cdG�h��m�E�Ա�)~|̮h�bNe3��_gR�A�:Ȏ� ���_�*����gq�����&���bJ�844�Q�,�)Z��9�E����_����uU]qL��lU3�0�"2�OG�t񳪖Me��J�����{�~3}lF�u�5�rdf���=X���M0�}�䊎��gİI�e�ܴO[k����G���_��m��I6�Y;~����n��y��6��"��{4�����y����&y�IB����mʕ�1���V C�	�o	��W�.���r'��P�qm4n�x,����ޗ�K��`�ɽ��L|�,kB'Zr4]�dE�~v�J_�Oøo^>q��%�Q�<jt��r3��0?P);,���[ �|���n>B\�#���S��q� v�%�-!p>�c�;H�=��{��^	7�|�����ہ߁_sJ��c�.0�4�N�T�[�/j��o;�0I܌;'ԱTاy�!��I�˚ZF�o���Ԡ��*J���^
{��8�4� �m������w���Ͱ���r�TlE�T�j�r�#�nm��������Z�� ����\W/�A�&����S��w�%�L'��Q���GC�2�"RD��b(����A���!�û�Ǡ6�J 	�w�wf��"]�UǨ����\��T+��N߃?�*��6�Ui&�'B�a�a���ׁ��'I!�G����j���a�o+��>{�Җ$��[+���3Hh�)��;*;�����S�    f��X6eI��8Q�ȎͲ%���q�rk�ם;=<9xd��l��ϲ ���b� i�g!#�ٴd���<[B��'K�gFazI����~W����,����`���@�Ď���$�U� 9HD��Q����'	��B���c�C��\�I�~�t"�DJ>m:�Y��p�ۿ��$�`�$K��'�%]<ٺ�k�))��Ae�m�eρ+����΢�4����x��[M�"��3� խ�?G. 8X�(g2f"�4s5�Z�+��D֪�Sm�h�����7��O��{kU7�� ����`���^�wvhwc�ג����M��p9�\N]�?_Қf$1����TD怰�l�@;�Fn��P�:��%ȸ��b:����o��D	�6�k,�Ha{H�3�C�sr�k��>�����Z��_�@�OK-X�N�G�W�r![�GX�Bl��IJ|�}"��k��ȱß����(觘Blf�<�*I-c�v���8n˖�?���"���f��^1��;6������ ׈�T{��9])�7 �҈q�l�.��*�"V�����ցX&�s�ﱕ^g�ۑUݶ�1�O�&���b"U$!TM/m�J�U���ܗ�vƇǃ(:h�x0z�f�ݣoI�����)��ĺ���9�e>�}k�X����#�e�]�@?ŋg);�w����뗨\wA�1:��!Oo�9GQ��rVy=�'.�.aV�TbT� �O|��?9HEh�͑�$,�c8o�V��$�ul���'���oB��x Di"=
��+p�{�9�y�����\1��4]�f�K�1�}�n�����~��ܐO�F����j�w�,X�����3��<*a�м@
�+zs2R�������b�jT�<��@	q��aց���]�eq�2�Yc,p/���<!`V��`��B�C��ҲסwXH� �nN��B�����O��N��.��L7)y�y��M�ǌ�q{M?bq��ŝ8�.���p��X��mΙ�v����멇v/6O�eUz�nϟ�Hy_�/�䅸�V�B�x.|c)��k��E����2�؊�����+� ���c�����0��&�6M��}��cN;_`0�ٞ�ܓaފQ�i�ǣ��<J�p��X�O��P�bv�`�iQy.Iԁ���+�:9Iԣ�@����j�!��l�aP�P.�s�zמK�K�(ǐu[ϙ�/�ѹnhy�Vb,�4���6�)�(���і��d�`�i�����O4%�7�ɗo1;B��8�<ּ�$�/���]��p�Ar~���y0S�q���f��ȣ\OUq�y��P"��,"(�EN!� ��6�?�+@K�'���MJa�����W})�u)�6�\�V�N��-*��2!
�Z^���1�P4;;��:��$C�U�rLS`v����{�G���pguwU�l-��V����Ŧk�}��1��0s 
} d�a^�vR4�i)�p����D�_?�^ U���W��@	�b�8��/tp��q�&����±������Ʒ<���gS%�r*󼩔�@N	�ׅ�;��]8�0�IK)/�\6�Ta8d�'@��1H0a�c7J��Ls�i��TT�1�웖�iΉae�ؒ��8�0�YRU�l�f�܌��ٴ�W�A�n4�6�n�c�r�����4Ks�
��ܤ�0(?7B�m�u�հVՌ�)���hԄ�S�*�d�Q	惙�;8��4��u*Yre�o��V],�?��Y����"Uz�H���A��m2�v�*G5�v��b�C[i�qR�E��y��5~�E|� �A^XK�ώ^�qu����n��{��GO���'��.X�_]���K���\�6p�3��U�c^��'DL�aj\��N�p������yH���x	m�(�)9�}'�q�v-3��2}lf .��P��R*۰�R��,���SX�7�_%D$o�Dc�a~�л��N��F� �bd�R@�Yq����zWqlW;QY���0NNW4����X@�٪!��{%�c�ut�6��ۘ?����ι?wmW��Ϟ�U4�W�GCE���k�>�M A���nmk�s�[�G+'%Cl4E9�r���m�^�(�{��z�fz͹�Yc�_ �2ȹ��Z�������~A�v �c���o����hŽ���	�N"�bW`+�P�".�N댅�Mv�\�æ���������#E��s��YW�~e���'���i^&+����V>Z+t>6IbqxX�5;�o�� �1q'>wX��4�T���|{=���h�0�@�7xV;�QC"�����3�{:�۵��]n,�/�˙\NA���p�/E�ͽ�tjĔzR�[\m�\�Mw�MH7�CX�%K�iȚ�ʚ�(��H����a���\*^Q�0ʖ~N�������x~�켞�����Gl�U��E�*h����Oب�:��f<��j#,�����y����\�+E�L��+X����_�G�|�v�db'��ɳ3|Gh��b">��L�
��{�1��ʘZ��<��轰����d�4��}��n#
�SOcL��r#�)�<O�}�9a��*�[�����Qy
҃�r�:��N9W��ͧ�@\�-۶������;�ݭ�u۷]rd��5G��S�ʂ���q�|��)��J��]�~�燄��U��?�������Y|�+<�����]3Y��5t�jt@�e��A0Avh�`��!������o��4����FA�yo�&~-�a�M�ஔQ����5�H�Jb�d��_�ZP�9�O��|�xq ���.U"&"��f�	{5��@�&R3�JN`�"R�{g}b A��l[%�y���7�q+v'xy����1�; �x7����*�ʒcڼ�Y�T���Ɓ?l�4[}��mo��^��|Vd{���+����'I����b)v�m?�!�����h��t�z�&�O�#���N^܂��Diz��Ӓ���L�^�{2�<2ʚB�1�(~��R��Y�K��˴ <I[1
�g��cLJ�+	���׏�N��.�Ֆ��t1��~+>��L�����I }xR#�'�Y�k*��&�Ё��ܮZ�`�ջ<zl�t�ޠ�R��o�*dU%�;����8wʪg"���1��D���8�&�3j7 �Av;|�>���,��2�E�ײ��?�k�e�76�k�M� �{��[�=`��
 �(�`հC`��rE��k�O���	��=���Pb�w�6RwD-�(��E�Cx��ʥ_n��i31��ډV��êۮ���~��'��t��j]�tՒL�4TXc�rٳ����ظ<�=Y�H�N�IOkZ>���5"��u�p��Ah�۠�7T���Я&~���g��)�/n�C�y�/��<��R�~��������)��O����ve�4�t�vlC]�.��a d�s�~M�� �DZɉ���8�I ��N���_J%�[�K.��M�铞��H[b�#:�Ռ�J՜����������?җu�9^����Q�Z5��;��,�<��ٟ��3?O�3�G���Fh$�˦"�ζ�/8�鷂S��ۛ��,ߍ9����@(a#1�{6�[��k�'�j�	�ͪ� ���jP���V��([ X�@���Vt1�[���B���&1k� ��N��Ek�Q["g[����2@��$�x�\�N��3-���	t��uE��+����ҒӍ��I�?�����g��Q�����Wο��JS�k>��^ �峈���(M$c�pbG�� 8��9FfwltE�E~�6��W�7q5.O�� �C��Z���g*�}�wk篹򄍔W�\ٖ+�b� J^da���S,�`1�t<w�Ãc1�E��y��w>�V�
_�M�Th�?�e������d�y�/o�9������[�ֿ��t�SP&�T)���Һ;S�(Tc��Ғϙz����ޅfs�wF=�pC�`�.Rj�W��h��_?�_�S��a��U�����뇿�����Ok�o�%y	�V�u�vq-�'n��Հ32�ǿ�ˈ���J�^�g�*p~`b�q�Ѥ6    ��	\vlĭ�����:;H�,u|��b����t쒪�7~���72�T,GR���r����S}ak��R���ם{�xk��ʨ��;�C5�VE��nC�b��W�D� ř1��[J~�~ �o���	 ��p��~�co�8�l��_���Q��'��Y ��Caސ��t��F';�!v5���ߕ=�����*[�2N�H����@��9e�����O"~a��������b��	>pcuy?�E�aGܒj7��H�Z�~p_����S6}ّ,S��?4�d[�g���]�YX_k�Ǝ�,����Z�)F��Q� H/�;&�q!>c~�7��/�V5�ER�2�}�)`b'"�9���%�^��	f!ڨ�����.,�m}�!��*�y+�J
`�?闲���I�w�$2��˃1r�ŵǪ��}��M�e�aj�m)��h�ʢG�xƱ-ɖU�f�.�HY.�|�	��J�Uꭣ娽w�py�,���q;C]-X��$�n�}�s�Oɨ�m�L��(?�6��g��M�o�?J&ԾL��Z\�	4a��=�m��[�;���$�p�����B�W�c��l7/�ٓ6�ԕ���ka+6���S�k$���A+IT����$�$�di�JN���c���C�U����ɥ�j��Z�JW?<�Y���/C3,TZ)�vQ�#��\]���U��W�F�}�!�A���U1츄���{�����2X�u#κ�a`h�c��{2�۳̷�(a��Q��<�2?�2Fݥ*�c���b�"W1���W�D���s����cԩ�,x]�8�Z��6]"4���
���vZ<�׉�~�����{����ø�{i���=W��v.�����ٲ\�V��������K�9�.]xO/�6O^���#���l DZ����=�Z&��`j�x����f�����[�O`��2���%��kc�B��0�3�wn@�kxy�ѠOG�}J\ �Q�I�6��7�n"�^����z��si|f��P\�Lb�rl��L`��_�y�G&b�İ�16VDtz4��X��3nP��~O��u�a�GRUM�~.�A��Z�OW�z���fR_|�K�
����2���/�g�yUr�:ϖ�vܮ��埙'�6Ϙ�ps�h��(wN�Rã�LF?!1əI�.���舺>��^\ G�������k�̓h���?�.?���}�/��Zr�'�� �\�F��@����k���m'x�%H�u��Y�q��mA*I3��>8�
��&����)��U�t"d���A�主�pۻ4���'��(�Y�Y���r&����62I�
j�)��B3����TCY��x�"*.��%����A7��<qTȺ�C�;3ϻ�x�3���u��6�?�SJ殲����l�&H, ��XJ`J�Au�7i�1%���s�1+�2(|���뽘\,�(xh�#s��}����%�A#50��s���s�"tH^y�t��.{{Y]S\>$U1MY2UU8e�?�\�y��s��t���e��\h����?���H��VN�� y��`Z�
N��&���"�ؒM��M�� E�� X>��ȧ)y�57�t��ӷ�~�$�Z(��5��N|,.�ja�j�Tr��#ԐN�i-/`ڹ��Vx�IK'
HF����4^�HPG��Z-Ǥ?�-o�ke�}4���%۰mɐm��˖[C)[�8�,�}�.���Fg�ގ�?���p�҅���:a����`�P�V#�6n�y�T�|�W��m����Bz�U�93oo-�}C�=3-�4��-� �e�o9re�xQm'{�:�t�&�i?�<-�ve�BD߭��Am"1]ZW�D�{�d$ e�p����&�e����s�w� ��E��j��#����SZ���r���9M�:zέ�;��k@!��^؊�ӆ���I%��ܬ-�����N�Ĺ8~�G�iX��.>w��U�$g�yW�v��Y�>4�Yy�?� >h���T�Aϔ$p^���ud&v,sH�}���;��&2�bꋄ@0�UR����8���gV�
2
۔5�}��g����Ro'����ǇKk{�Jt�v��#G�D�3�3���wjm5���2S�>���Bx��h�v�]���@�a�|��_�R��T���������6.\�D��n���j��N @��(��L���n�¯m�㏢��(j���V���v��	��1	��Y������>�����c3"	��qqG����ou� a���Ij-�2��)D�e+����P�;8ZX9�Z�Z�����p�Շۋů���\�Wjh7`�-X�8�����
|�,�YPV�./��9��l�s ��A��}����� ��&}�r��~{-Q+�S���r+�����oX�C� ����kܲ��OX��N���W��Ø��f����A9��!���R���@$����G�h�Ef�S�ɲ�r������Yv��ͳ.
TH���dj��VS4ߗs���f�QӍ��kF㬧;Kͼs��Lq1a��g~��]ѷ���8�����&�!J6��4UW�ad��H��nq��9�q�m]^���/�]~�ҵ��2�{�B�b��r��XO�@y�K��!ý���?[=����l���`Ej�KC��-Q�<��HF�0n��;�$��L������:�"0�E��	�7�ۼ���d���<ez�v�3UC;�}�P�u�~�1��2�[�݊&��%�{yؿ8^9�͇ʦu8�??:[�Ϸ��˝�0!�7�v���=���4�����?2�%8�}�$�$����Е�������9�%�
���������xQ�^W��r`���%�H�����S>�~�� �H��Sl��
{:q���28�{.��B��#@H>XG�`(J	�A�3�/�ķ��}�nzډw��U�Qd��CH;�"i@^j;��ϴ�$����Cs��x��^�.8�^_�'|�p��+�G��LD����ա����(�;������	�m(ED<��ŖC!|�rY�\ld�@��s7����({��F[Z�ΨaZ�7�5�����[ݥ�3L�2��".���`V�B"�X3�/T��D��	H�7�'����"�/Ԅ�I!�tP�D�Td��JIZ�����^� �R$��pɲ[���n<���#Wzz���Y�.�'�òUs�Rtb)�3v��Ͼ3�&b!N3� ��Ј�Ώ`��<J��^�Z,lB�8ub'��b������0�۱����ю)���&�LZ�}<��[?62;!�R�9�X`(���D��M;t:���C3��� S؏CGҞ�hm�J�PMw��!��LI�%��,KD��c�j�Vǳ΁��=����UO${���V����㼸��'������g����X8�͏�j�j�b��o~"h.�_�QP���1�����oXX���p�QV4j�G������vM�5�8�I~�� wqx�a2$/_��fǇ$�g]�E�5��?n��sH�	�&��X_��7�l��R��p��J.0r�8�/���ͧw���*�bȖ,_B�}e�rTI�5���2DW�μ����_:Y:�[�Z+�f:�e�1��<v��Nu��.���	�C��e���%i(!7X�o �$��F�7����(U;p	�}�#v��|XUf�?g1�QB�7��o~���?�[r�����\���g*�l�wa���˙�U��׷/~��d&�1�P:�G�Y �cVaw�Q7l�$�41�Z 	u��eRґ���"ZOH�C�W����<�#^�D(y���dZ�uTUt���m��Ϗw����'���SO�J�r>���@�x"h>.R�����/���!�� � 
�?�x�y����n�%��ЂY��@���-��x���-DT�x+�o䍁���4��*��TX<7�Ŀ�w�u(n��9k(�6W� Ό���cQb�@��N��" ���{��^�+N �    ;9!%����RV�XʀHD�SΩov���}OvLC�����vZY?;Jٳ���R�kiO�����ơ�5�tM@�z�]��7?=��/9�����㈸��)�li�n�9��dXB[͡�&M.	�1/�T� ��1��sC��˻�9��ژ8�_ W�ɕ��vWwZ<�T�آV�:����5��c������� �"6f�������,g��O؇d n�6tS�Y�!���S�MX�'�a����`w�shEi��E�ڱ��x"���<J�S2��06����K��b��%$�'��j��C�P<�������PY�\7E���f*�܀nnXE�W���~L�!��*���Q��~-d���
[u�������v�[n�4&��E�<�	i���}Ϙ��6R,��M�o�M���CR����j�ۇ�ۏ��/��l˻7�em~��-�:�^Ӛ����������a{}'�gW����e
�85;�)~�lr��y����H*���m;�C�De���-n�e��/�1"����2֭���zI����6#�7S�#�}K-z�=��l����i�LަWL���s"H�C,2�zC*�,���t��/-�Mx#�T�c��j �09\:�9�����(?���'��\Z�6�1�7�!���T�,>k=�;;��ǝ�n�Ƕ�܊�P��C�Gi���i��#�@�ә��Dm��pޘw�j䖞��f�7|��Rw�d� 	�p`)�����$-B2�Z2���3�;�׼+���U@q\Q!W4�ǧm���sW�;q3���"Ո�M;�5�{��\9��[�j��� ��,_(�.(��ؒb��\Wq�����A�{t�F���p}8����|�[h�+��
>d�`�aΌs�S
����:���@":�d���xK]��
� �RU�p-ո�������΁;�8���*9�YY :�FP���w���C��٘��P>�L�k#�6?�]S���Ǣ�n�-�KrvNq��+��K�~'mr�\��KR5�?Z�=hiN�=
[�����daÈ���t�
��'b��	J;��0S�l�B� �[A���O��`�l�L��ɷg5y;�gUuV�	�`�ٹU�ϐaWIXP���֪�ȞoD�~7��IF��7��/X���x����:@��n� 7dGv��6��nt�(($}IqL�$�,]���H�����c��M����g����㝽�����P9�v
�$��"��*��C|�'W,��p�V�CEc���-j1Å_���zТ�*�K�xt3��
��אl!�*&X��[��!��ZX���CjU��x��]�Wyl#�� �jPˮ,B�3�Ei�_A��3��7�0��/2ǆ�9"�N�"~{���S0��r�qA:���-�2�O}i"!hN�3�FY���y��Aa+ฅ���0eiH��8�|��Z��ɍۇ��l��c��u���?_�H6y�ضD�E��A9�3�l\��������F��Q4���J(��м$���qM��a��SvT�B^���&���͹/V�v:&��/���Sy�p~��`�Lꏇ�V��&h�#��B��(|�Iz(i\G�l��b��j�Q��^���7 F*w�k��i�����7�5�ϰNL搚o�"[ϼ��LE�uGd�h�/����ʹ�.�G��#���R!K��;$�͚��3����^Z�9f���Wܡ8�o}��U-D���ƞ¬i����ͳ�`{��:1�� �g��)2� �F-*R� $�H�t��=)o�'�6����J1%��R5��NC���$��!-I�p��O�Ig�0��/ےK�ұ���L��'nc��g�[��O.��^�r@�:&JV)�}ժ���haZ��ʱ\@��Taw��:�8J��F�Qm9��Z\�9'!�N�À@H�4��B�	���8��P����I�ya�Dm�.���	Б,�>(Dl7!��h�,����+�^�*�L�6R�מ����Tl�	,�^�Z�4 �u��r�r���zڢsw�c�)�+��-i�-����M;֟��R�`��$�������ü�a�f�I��F}�'����b��?ꝳ#~*�A�`J�D6�"�VZ��9���C�"�0퀦�6������G����k��b�-,�Ս��UaϞ����߾9�q��NtN�����B�i\�%���!X�ʫ>hf0����K�u���s٠SO!�FJi�(�*~�{M�e�^";�����n*�϶Un?���w����`#8�Q���n���[�~�=�� >X�����`��?f��1��-(��r�/�Eւ��ۺ�v���ְ��\�8BZ��ȱ��k��)���}�-X]~�R��k���/0�`� ��Vy E��P��I�>�y-��� �R�PP��"�HyW��'�8���6�~�-��u� =h^C
�3�ojf9O��ݧ�-��zL�yן��%K������G˲��E+����΢�4����x��[M�Bw8c���Bx�*�_!/��,"�&�� ͥ�=��i���q9�pU��7�
"�}o�����y�o�\�S���NL3�n֬�"�1��/��)�M��	�B��SǨי$�B��Y�CS�(�2��%�ҬJ�����qZ���'�3l͐Gz[�c�=������ꜜ��5�4U����˟
�Ԅ�y�l�ސ�
\�y���c�L�t����K�A�m`6op���8'$l	3�wm<�fl������Ƹ� ^ ���7��J�9�{�=/N:nԨ��4[D�nvRt	�8���������P��J��t[��x�e秸���쟶�V��w�@ι�=���������{�6��Ӗ|�����d.=U=����Ώ��K��ykQ2��d�H�[Շ]?"_�)^R�Lh�:�Pfg�l�Tn��:Ŧ_����W$D���[��9r�����L�N��N���ϩ�b��CEfԦ��	
��L����n�����(�ꘒ9� �Z��̓�>�l��EPS�3'����TT2yMnp�oU���ĤGg�w��R�Bw�ž�IgF,\	Pc�h��/��	�:9�G��^Kh�ր!�E8X]ʝ�:k��e���;h�7{��8��0c�A�f�n'���	�@�g)�!�%����z��Kˤ[�I �9[
2���՗��4yq��r�"�g�ہ�xU��Q0���	�t0#v`��zࢋq2��-��߼蝹OqU����+��
F�)ٲ`c�������o��(&�H����5�.��B�_��fl(�'�~Y�%�s��R�3�T��*v	>��}��A�S�ϔD���3�G��4v�$8�0aJe6Y�!ٖ#K�b	f@Cqʢ֞�M#����+ZXj�d��g������@.��+ `��In�L�W�3A�S���6����@�bJ���|�E�4�yb��q�L�R�`��xc1����� EVOE�����XL�8�|Z�����ew�DbB��	�:Q�E<�,��(_F�KM�����T����a��)%�.���}�Jו:�W�V�z�M�p
1�LCb.*�vA`P74��U`���'�����'u�dM}���w����~p����˫�Am����D�[�Īހ���F��ePòqDW���B�ڃ]�H�vSf�.%s]����^��l��1�'CL�v�".�B����ݙ�\kJ�g�1����M��ʕm�t��oI{?�6~��!;E�Ӥ�Gl�o�����!GWJ�oJ!GX%,��v�{����G�VV��W�������lH:ۤ�Ϛ��݁����V_�~h<]����a�u�E	^4�A�N��б�3W,*`�=��@�3��Ҭ��ڈ�������4�eM�B������r����@��{��c����0��ƅ�x܎�Ȯ*�WR�B��9O1%�7���@�W�q�u��}�������|w�g��؝��ة�}��&�*�ՒD�7����i��i։n��X�    �QKr�G�Eq-I3��EgpY�U�,����V�:<����˕c�pU~t|V�(.��T��$�o��%��܍�N%f������i��x�B�����IvsTEXwm�_���_"�S�Zk��5�}MZ�{<��7�k��ꬡ�����K٦H^�V�]^��q��g������K�a۲��_��q2B�vy��î��#�!��ʥ�n�)7Т`O���תأ�d!���;��Xu���k���[U�f#\9�OW;[�u��ԱDlu��[v�0�[���z��z-��hBp��8.���)�z1P��؝�5�S&�s��;�����Q9"l����u�jr����tТFW �}R8�"�R�xY�N����~����&4���-��Y~6KC×[;[���y�������uUy|- �}ڡ��L5+`sO�p�tծ���Vl���5�\��<P
�vD�k�� ��g�y�	��J�_gd=\Q�LE(<x���Ӄl���jC�o_����]�ԍ���x � ��r��+�X����u":��?+`9jD��|1a�}�zRN�bO�F����*���wp�)1���ӻ,�樧��j�S�C�W�e�EI������=���xc�����ض��Q�4
sS��"w8�_�Gx{�p�넹����r�7�Q�t�":z\�y~p/�?������|��N�
K�?��m� ��fb)������^��M���ѵ��^~�W��kT2"{<c�h��L�j�~���2�_t���OD
�t[�'�+��b��6����QAΛ�������fl�$�6}�kk����)��&;k4�dk�!yf�;1%C�dI�e�W-[.�D�j��l��%移��F{�Tʯ�h�y�樃7O^.�̜�Q�J��B�/�F��
����`c���AMpefR����L���-��(����Z}`�+�ˀ	T	iN�	�؋�H�u��-�	���A���0��A.|b[y:�*�q�u����Q"dǃ�`Ye��6I�,}�m<�&[Y�-ؾSq�t,C�M {� ]�!\�4K���JY���V���v�x��X;\t�A� &.�"�T�h
ԅ�W����xh���ȍ�tS���47�tHpc�Qt����֝i�UsV&���Ve��v�F�nUҎ�,ǣ~����g��ͯ��-vP�`熉uqc���XD�`�:u\��A\Y@��G���~��5�N�����ޯ'Aۺ�hj�����Tu��Y6�~ƛ�B�����֚c����e� ��t̐�B��ԑ��/��ZQ�'P�-h
�2�� z�����:x����_�/}�%.m2���ɑ�$��%����12& 
��C��.��0W�_�<�G�
@�,զ-�����ú˷_}��X� 51���K�G��l����밚hf�H�m�u��Kؓ 0^ҝv��������o!�k>����o_~Ή�W�:JXR:$a���z_��b~3Z_�/��	!M����Q�_(y����i���ꯀ�y��s��?Z�:,��Ò�@d�Ne�����;�8H���0lZF��[h
Ҫ� ����W�>����M��XJ�F:p�o4��ȟ!$F�}j�+�g��߈Rn�Ɓ=��H�cZ�ϥ��G{u���O�ܽ�����T$�&�*�+�Wtȹ#���)� g$73���d@%w6å�g,q1\�aȶL���L�>��N���I��p���lr8M���)(��x!J;�H}k6i�D>���{l���`:P'u�Q��$Q�`��U�w��0� �����r��plݞ����d��KP��&s������I�wwNzɓ��(
7���_?�v���D�O���bD�ꞻAP��ՅŹ����	��i6:��G(��Æ�n�I5��o��������3񐕳
�4(������_SD���ȁ��Je@C�p���+��<�('X�Ť1��TYDhY�e�'a\L�d($�1m$:[=$�����ŰZ�R�X�|n�Aӻ��;d#�!������h̭5Y����ey�b5<3�����sKZ�� ����?����M��¢�}ڷ��H� �)�-�j��;\�Y�V큆PT}���[�h&$l�v��H�R�A������}�][v���0�J��́��wKS�6�#���C��t[1[��r�;Ϋ5�ܚ���"Tk���d����M��7-CU���Ӯߔl�`(�8-��fɦ&�FtN���)fgS�H���}�
��b�=]d䋸F���$�����ad�5����� �i@��_	g*�M����s��6���r�x�Y��U��J���Wp�#q�H?�v�;���#D�n?�,Wm��4��mbZ�ZqWr�p�7�B;C�!Oz̏At��'N$�3Mާ��t��?b:�����9���BAie�\��3�_�v�K��hy��kG��'����9jy���L�Vp��5���&���f�� ]�h>h6���<�C~��.4A}UC����#U�I���d:9�������x��3��<���.,M�u�jQ�;Ҍ	Wa���%�J&"�twրȺ ��g�hiC�l�Bl��%����y�8Qqd`�2mCӳB�b*��N��i�n������ӹ������ˍ��Z̿`����[������>'C;_!�MًĎ"�~�ۃ��^ MjՋ ������PR����@s���]B�.|�n�333<��n53��:�[7�L������`[�_�L��<� ����$-7�v��\�?>�}ά�? �y"��P�����	:pk����7���<tζ\����1���f��I��)��xs��5K�t�v$��q5�,��Y��*k������t>�k���u�H0<�׈�4���d���FH�(2�+!�8ⳓ��f7Bk��~��$��'�����ߡ�]�'����p&�;�Yy��	�Yik����R�2��I��}�ы@K{�])�n,�s�rI������UGf��J,����	�^��òL�2uMt8��7�+
��@�dÐy?ܕqm�8F�ر*Y0Ɓ�x00�x�uQWU7���Z�g�,�p�����@����XX���{�9���s����5�t�l��/�����E�8��B��w�je��{y!�&y�!��h�1n�P���:Rxc��(f����),O�d��U�:rM�*�"�c�e4#z,��L�K��;��ӎ��99�b�W��I0�� ){�d�.�ہd9��=��+g 
���%��6|������{6U�[���>���A����\�TMp/�d�!X��8n��<'��sj�V�jc�ԯ�'�����&s�ZJ)t��ID^�a/`�Ct�4b� ��M����.�>���Tf��ekn6����9d�:������QLr!K�` �g(��Ьl`�����-2�Ë�*���DqM׍�	X���������iso5�����4�&*S͏H��@��%��q$�=�����c�4��+ٜ����/>��{	�S�4����s��7����X���S����bx��az�n�[��!b�\��b���AIX���%4nU�lJ�
n蓺%��v�f��N~w37ݸ>��mf4�=}R6L}���4F�v��o)��fNC��al����Nҥ �Z�힂����6��N�����7�ʧ�H,��Д�o8n�e�L.��BŎƪ��6����W�x���a�7�r��f��+Q���������T��7&O$R�<op�$���/�s���]Y����Ou7���$����')ԠE�|"�Ͷ��������ǒV�����J�Rksk�������ڑv��9���z�MK4�Q2|9�(5NF�{�|�$�0��N��?i\h��H� ��Xd��me�	�Ņ�#���x�gr/a`3�ls�!< .�Bj<���_��O��xgB�'۲]�@��2���="�͕�1��zc��]�f̢��U��&j#��'�F( 1  N���&�,�[8#�)�[0A7��q�W�w�+p
 ���^����.}[�4��ۍ b:5��Rac��>*��x
��������3��p���OԵA�p�����o+jH���qp��a�1��g2��%+�lǽ���$�?[�hR>�T+`d	�:d�D��!�rT@����&��̢1#�U�}���]��)�S�U$���C,��j�Zu����[�.ȀR<&�2&���#B��-�i���	�?�߲�l��{�ĭ�*�po��U�f��ۚg8
����̀���[1��ϻ���Z��Y[��boϤ��Dܜ9��4�5��O-����TSl�ǎ�A~�-x��y��l;���Ci~`�T�;�V����#)m��˕�n��99U�E���Y�M=Bk=��mG"EL�'i3��D�y���%:l�0_�`uX^��R���6��������p�W�>	���B��h
�L�.���+[%�������`�>4�SSs}݊Q��+��Y�g�I�3����b�o���+;�{��ͪ5w+�\ƪD1'��b�����������Sߏ12�D�Q�n~Y�}��>�aM��e-�s4�� ��������<E $9븙����)3M\G��pHAA�4ß5-r�&�����Ր6�c���ю<e r���=�\7��ۅn�K�˲�u4��GǐXo(媲S���B-��zm���rVޫW7Z����`����4�M��-�HsG���xc��vG�'q|ޘ�l4��]ݰ[ e�0&Iy.�ĕ]��p�w�iҶ3�T��������b_k���X�������]0         �   x��Kn�0�|�)B��nT��	Ȕ!R1z����b�0-mL�H���L{��BUg��LvǍ~���;��z���փ�$�Z����$e��<���|�YR�.|���-|%�*�|��/�t�wʩ��6���I�٬�h>�<�~11����A���?cA�         �  x����n�T��7Oq�.�L�s���z�ERS��Nu�NmMb���KĂAŊ]�����p�=�&��d&��A3��8�I����w��&�%�<�)ʴ��ϥ#��lSq)p�k��A�J�1 ��&��AӵO2"\��.y'M�b�[F�'�8���W��Y���y��������^��|z�7*���_r�s��F�2�pO*�5P�R{�������pע<��a��}LH����+����ocn�La/-\��\VJ��W�%��k }��t�����S>���Bv��!��x�cyJ;i>����$�9�y���F-�Nm|	h!�y��.��$��b� �j�����p��B�]c���S��e8Lp�%�K�(YY�J���ָ�b��ӯ�Q0�H�X~Oo�yJ�}J��B���YAC���y�t<�47�QB��.׺E@�kQe-�$�˟�-,f*S�-R>`���q�f�s�ԛ�n��6ʀ�ov/����Sپ�B������}BzO�NJ[�~o�����ˋ�͍c��ղ����-m����m����8�Y~?,?�������������������U�Xx{�S���hø�w��qxҊ�z�8A�x�&��X���z���W��4H.'��Şn�/��c/���.�����p���[��ֺܳ�^^�q��n���58��;$|�9ʕr'��éq�fZo~��n��v�k`�v���-e�~��/�	�4y��Y���6��`�&]]���{vU����}�y�������*�W���e���p����������
f�f�;�A�'�e�Qn]�^�	�ij�<�_��tL���3��F4K�|��>��4���CzNi���,�N��ĳ,�Q�N� ��8���p�N�pF:A�ƕ��p����Z         �   x�}�1n�0Й:E �H���2�t��6jq�Xz�:]Z�A�?~<��р���أ0eƌ��(�#��:/u]�{�����c}��j�Fp:�^�6,��P��I�`V�Q�y���[��
�ii�ڦy�ԥA7r*����-��O{N�)�)<M�;t�Q�C�d�$�H���/�.p��C�DP�k{;O����n��-<I�ܳw�}��QN         �   x�m���@�k��@N���lO@�T �R(�#���H�&H
d����3H�i8m�z�X���}�n�ߎ�;��:��c��B���엉Š1i`I��Y"�����9K�m��p|U?΍mw�p��]Yi���\��0K�,�by�v�RI����1�	�8G         �  x���K��V�1�
o�*|y�"e����P$����ad�ueQ"E�z%��8-wK�:+��t�"����Ds��A�����$�|��_�HҶe���K���qQ�y�5a��a�����N�!zN�>�_qY���/E_Zf+��h�!�-�s�@()�=�1*��
3�'�"���a�a��l�����9�A�m�6�p}�n�XH�?6���'�E�����ϛ������Vq{[)���@�(�3fr�{c��Ǒ!�6�{t���X���������̈́�9�����p���[h:��,�p���8��uS@7�o���m��o�1�G��[�*4����*:��"���t��[��)e���Z=S?�+�(L+^q;�jO�F���K�Up���mt6V�i�;�@���I�<��IQ����<f�����Kx��7m��֥'pe~c�u+x�)I�5הb��p:U��RN>ꑊ�f��5�����27�;�D��=��D�]� \7�??~����R�Z^ -wF��`���Xi�c8���|q�
:X=�Y�N�h3*AI�����_�E\��iX�Ehc�	1Ӹo��.���N�����>����O�������{RW��QU�i�]�%*j�&IFtAc����Ap�U�3����AO����`ɿb�zNƌ�b��K7+�i�֭�!4e���t�ܾk����ױ���»q�`����mU(��I�����v�.2n��zl��>�0����҈�̬zj��jc��q�/n��(�&��6�����׵��=?���>h�(,ߥ6Ap�?�4��^NbqO��os��Aל�~�޷����Y� ���('8� ���eQ`�.�_ ��w�+�m��F�������2��AWv'�0�}[��'��t�]cq�P�\'MZay�C�b��(�!��8�ZK8j��U:����ڵ��=������CM_           x����n�0���Sp���P�-��L�Q�����n-�;�RN�Y���nk�L��]U��U�Ʉ! �p�"�k8iE Ͼ���~vU��2ĭ
# }{/� ��!�T+Dk�7���RP���4��L$R~�2-3� 2����vXs&�,F�T��*Je
w|<��^����X��w��<�$P��wͧYF�]����f��:�yX{0L��4n���!Dw��X�W���54��_O@�g�u�fo��Y.�z�v��ǚ�]�?߂s�A��r         �  x����n�F��ç� 1�?�يj���R�fH�H��(�TR��.�W�"��]��Aх�"z�^�Nl� "� H/���9�\��B�X"����&	��<t��i���*�#L�D�MLY�u�DD���*}�cw�������)^�m��c�p�gg������v���ݧ�ˢ��s�9ɬHwaB�d"Y�Nb)��fK���ZLu,uLXČ��2�DŒ��DL
�j��\�y�:�v���E F��%�1�1'g�-i�bJbf{��0^�C��~��\瑖h�l�u������x,E,XD%U�*��Z-�x�mSו���r+����@��Y�i�LL�S*C�&4�i�C�x�3�:�������X�HJ���Ta�b�ca#.�R��� �����m�_��[qI�z�M��Ҥ�*�{�ڻ�ۮ��]���/�u�I(�Z��&YH�v�{'��w45@F�m�������W�����8�]}ؠ_�� sR����ۛ���/t|�>-n"1��rl
t�h�1�%�Iv�4B����d:��Y��M���J��1��Bo��V��[C�`"�tGG�||4A'�E���~�&��O7���� T; 8��� T�C������x��`���w��p�ƫ�Wh���iע�����W��h`���͜ͻf��� [B�V����/�o�h�k
"�u��ئ�_����C�)���v��	��0�����^������q�npz��$��W�8��2�*�`O�:�� �ʁ��~�WU{�{Ovlt�(C/��Z\�6�nm/ʶ���C�����,G�~���y��v�:��O���x�3'�އ�Z���C���5��]s�eX��7�e�]�a��0l�2�#�{$�������y(���.���~�� �xw��            x�Ľْ�:�.|}փ�;E�"�Q��y�}��dK$�����彫�˩Nwĩ�k��;��H���������{o���i�Ǐ����~}��C�?z���'��3��/]���&�t�u7E.u�(�ĖK�19�T�.�.4N�0�������s�_����?�h�q��O����� ��s���q�G���pv��ݮS�M���=����]V��VV�u
�}�b�X�=�e��� ��8ST��KF9�:g:ה�Q�3����P��?7C7^���b�s*,�$�gU�8���]W�'��(��M�׻�oK�A]�tm
#��;�+#{|9����|�̯��O$������S�)�2}$:��(�ԧ�4fʌ҆�BԛE͠/�Nuy*S��s�wҞg�G޿�5�0�dk%T��䚤��� Y��!(�?�aYuѸ�֭Ǝa\ǣ�iT�����3�5ڻQ��߲R2���i�p(5Sd�c�r�r�<��hEqG�.�x�G~��IZ;�-D��SYRS1MM�֦�(`�x�ǃV٫�J���Ƴ.��Q��Z�-�~��L��������0a��n���2�2J;�1o��g9뱹��9����D��.Ki�������B��ڐ��\<w���h�ƭ��n����C��хc���d�dm�-]�̧d_j�c�z,o�ru5�Ƹ��C�G.����ס5ag�f�k�فo�CgBV��S4��7�}'�?�-$m@ind�[͹�Eun�Y�,i�L�Kf2ǶmAL����^�S����]�Y�b�񷡺���[���o�'qk�G�	� �IR��Gˉ'��%����w��	�q��I'Zt��I���t�n�"��G��-��e����8�9⚮2�m�j�����X�e�`��8��޻z����-۲�؏�4�`:�&���i�A��OE���W��M�ѷ�b)�p��B��`���� �<�'`�_A� �Rf��B��^Ӥ���l��޽]�ݝ�W �G(���Q��Sτa*�:O%mf��h��m��.E�����l�������؊-�Gm�B��������`����)ӳ�{�L���q���m�Wۯ�w`�oA轇��T�X�8:no�!L\�+����2=V@SFa�$������0��N������?�[8�I��*�y!�`�Dl+$a��XP��3��:��eUm�ص&M{�]��-���S� i?¨�]rH@F�8Ayj�`@J#�үq�g����uϻFa2��k��Ź��-f������"����B%�iY�o�V5�~�.��X�;��*M����a����S��2kl<o�������3�&K�[�[P�[T:E~d�;����{�Jt�x��V{�	��5�QJp�<Mބ?LFt�H�,��f��ߎ&[��ߢӏ�J�hG�<\��%���Z���q�+��~���OD7�j�U~��֎�V{ĉ�89z���$����g��_Tf��䶝�ڽ�/�?��B�OqK�i����Z����ZV�YuÖ�?�H�-�{cVU���~ޟb,��R3L�5��f�R�\jK[8�ǘ 	Ȁ�0BЬ���b�V��ح鴆:�k�[��Q�J��Rx���vm��u|��,e�vC������3�]N��e���	�-�����E�]�ao��nm��\ĩ\�VY�h9;�&��~R(��~���~
r�����s�ຠ�Ux�a��;,6	�^#�������\�GQ���I'�o�d��Rݛh�j��К��ӕ�I�b,��ߌjU�\12���	�n2m��n��o1�M����d�$M.%5�_�NXg�����u�W�.�|y~ZN�	�5�Q���r
���&Sp1]�����WnLM�5��}��s[^�mM.����#��3�T.��*�2jQ��뚎���CTDa�!�I#-s@�7��1�U�q#�6���(r�J���փ�2�H!!�%��@6����j�\f��h���ܜ����(�T�NuS�tW��M�:��0 ��T�F`��Y��h܏�������ǵ���~���nE4&R�Ac}}�+�/LҲhޚ�Z����AiP�7�.꣪H�+M���4
iģ��((���tt��nDfߟ-�Ul�G9�'ͨ:b�?����iBQ+�r�H���6�h	2C�)�+��3+w^ڭDL����ݵv��w��-R�l�,��t��yV��P�Bb�6���<��^.�M�����H|�����ɏ�JȂ�&!c��I���w	�aiVψ�׍�J���^4׬Y��ޱ
��(%U+-�kNF�F�ܝ�;�^��o�5����&}�GF֭���!շ��Qp�Ѯ����\Q��g���l=�6�� ᄿ�UjP<+ju�+�z<��,�崝:����-j��T���
���DϯK"�kV�N�UY����p����|R��ž���e�A����4�/5��&SK�4m�P���u7cʗ��*�ɔ�g��/��_�nK��kqI�܌{�G8�q�'5K�ܱ��.-#�1�aB��VY��ږ��J�[��f���s ����^�H�O�	��G��w$`(�i兮����u'*��|�V�^n[v,���A�z9_��|f���)�,� D
�/�3�U�#f5�^�t軷�7M��m�UW����cӹ�9�$KKS��)�eRwubD]r#�d�9�&�qo�ꍜ�W����M�� �G����/�!6x\3��5{�!�R����Y}���g۞��*���y�c�E���C����C�����d����2����=,�y�\g%e�%3r7�����e��p�Y�J��<���d6K~&�/\���J�;���jw�L�}_j�r�}_�{[�.�;Qa�}�Nq��4d1�»g]S{����r���Vv��e�1�-��mqa?脠i��rF�)^�jdU���fd ��fu�	����~�Y��d�:(׶8ئ�L�*�zAoO��\d�&�����nr�B���c� �1�V6jX����d������䪔��%b���p>�@�_����\��,�s񟩋�MH��%����T��ʬ���
��Ӗ�Bo�Y{Fd�����-*�V~�����aF�~�dg�q  ���Q6bB��2�M&�N�-/�m����.įk~�k��8xCg\Hi���_y�i�o�� bzVO�w{W;�'� �7�E��j����6�(5-��A�]u�U�+,X��������(�<'�J���>���uCV�?���;�(�Er,�	�-���a/�bֳ�fn�����S��\������jG�-(�����#3# �0Xzڶ�,��j[���k�ۛceU(��f�x�� ��I�	P�5A�ꦡ?�vJ9Q8i��	8V��n�|�D�j����5�G̝�f?���v����H���5�n��ֶ�w�l��V&���}�L�|�7�`�Ԅ���|����&O�rCSYa���jw���w�q<����2a���=8Ґ<���f�[�>~��,$��m4W>�υ�:�fg;*�q�X�����r�Ķr�"BIz�5	 M�m�j"�������,ܓ��/������ԗ��	W��%��pKNsi`��H�l��dv0��x�?(�pZ�=-ԽA����*qV�\IRaB�$�0=�R�o��^��6��rV��8�VJ���Sⴜ�9��k��N�48R�&�'̢��W�5l�s� ���*�����W���J��jc闘���^��5XA�b��i�\1�<�y�k�g��uE�OvF�ܜuλa�A�$?�&�JH�Մ��4Ka�x�S!��Uw5#=����U^�������׳֧�ċ��V,�l{�/��H�]���{�kL�p�寁G�3�p	���G*�Zg�&��ݫ�a˼�F��]�6 ܯ��-t��u]��{ֿ?		g�$�*��xv����vj�V��:'K�c6N�~ǯ����������9��u�!N"�j<]c+V��_�����qÿ,٠�K�    G��)��P �hc�H�F<H��T@-s�څ�2^���w>D�M�a���� +��T����0�m�u�~us�N�Nmm�g�˴����\���7���w��L�!)�:h�ߵ"ԟ a�d�Zfo��N����jW����Xj=����>��T��>�١�u�[�-�ٜT�j��+~4(_��n���ɋ�h�>B�J��☦L��t-s���ۤpY6����N�cv�tPv�) ��[�Hɟ gN�����zd���dwQ]��T��&��ę�27�ېt��y}���Q����L�#~\���1�]��z�j�6?���RB����L�}9�]��iA�2pH�S��ժI�{-��Ҧ��� �!G�ږӲ+���ɟ�2����S�`Y��ܝͬ�7��v����p���Q���2\��͋�=�7g�����&�wƞf!LMf�"G��4�4򲪷rk������+#,υ�9�����+|�'�Ԅ��j��X�|^%qp2�����*��8b�[�M=�{���c����ZV��IVkj`p���,D��y<�Mi�^����P\����V�F����ܢM�(#J� �h��42��4���#Э�;��ļ���ɖEP���O﫸&cDf��"kU�W���ٕ�����l�*���_�<��/��#�%�`��L(�4����T:Mq^�����reP- K�̣���1vM~ S����X�0���!����a���j�ͅ\0���&J&Ŝ�lK=k���H���?�Y�g<4����6�D����85	� ����pOhF�;��h��\k=�&��U�3�2�A�M"�
7��h%���ij��Rѱ*�R�R#�f��b�:��#\��Ua?Ȓ,�ۺ�T�'t�2�u1S�)�yS�� R��6۳���T�$��H�������c~�%Ab�o���n�-�������J��z�XH�jn-��-�!E2?H�W�ڒ�R��K�S^6	���������j��S<ۇ�kg���Z�@L�����K�`���ub�/�r -"��x}��/
�UZ�ޕ�U�h-��Z7���H�A[O9�=�Q���=�k2d'\��[k�+Ze'�R��|�:��S])��hB�d>[�`mf�2L*�M�R���.���vZ]�y���	+^'��Gki<�jL��D���	.-ժԲf��@���䦆�-��A�~�'���k����������,����W�q�(ni����ys��΍�n?H��),a��֕G���[��ݽ��^�\���v��Cu�k@���Ae>TE��k��p����Zd~M7�\d����,ζ]5��w��铛Xd�EO�A蔵 g�w9����Z[�]��J� =������������C*m���^�1{b56�s�X���0�B'�k�u)�{	�����) H֒H_���Z���@�vp��{���x��3�$>�`؜N�n�G.GI���#5�v���,ϫΝ�+�}��&Z�|�P�������{˓��-��2����Ța���*���c�A9�M����{2��D,������6D��;��Z���jfo��:�+zg�Z�7�����#<W�O��x^�i5X�}��=z�S��R�c0nf/ߍ��w,��wY�w֤�-�P���'�� D2�$��F�:LBh,��y3�2�y�H�.,ƄV����o��L}�)�DC���m=�v��5��[�nT�Go��垤;��}�Վ�)�a�a�h
78m���̵��?a��.�V-g]g���h�5w�M^��:�~����RYGҍ� $k�.��Uo�yW�������(��F���7y%ʻU�;9멼�	~��H��ʞ�������ݙpb�I��u��GX�	»om�렀��|��3?�;���؅�Z�:��p����_��no�:�Ύ�~GT��sS 3�����ԁb��5p?4�|���|�ި}�/fS����i�-T<�h����\���Wl�gN��r�3c���t�WF(��$�r��`|�����Ncp��
L���Rd~�s�ݕ��V4���P�n�]��� �_��_��ٷ~`�
�<��TLV����ft��|��&�Yl����@�/k���9���)Մ�I_�B���Og/���n��]G#�aW� >!t�_�wI����J	{v$"����j�tf�5���ɀ���])l���~aP�v���/?�MEzω��|�$B���ff3[�V�=]��I'��V�E!��{����NG�����mȜc2�v1@����t��&�W�q�廭�
?�*��=ۊ���=��6$�վ�HQ�2��27{iko=���zi���]8�C$�{O������֪�[�f�߬���>�'���2���J{�ߘ��u>u
~��ٗ�U��¬�k����𓼐��zp�����5<K�K��< tb*j"�O�K��t�9�ѻ������#͒��f����\�z��I(�%��Ft3=��e��7���`V=�^��4�M�d����!Kz7ñ������5����Hgs_5Xi�(��:�Ǐztl�Ɔ~S� ��QA�N������H�
X��nq�Muw��eZмF��#�*��+wǯ�#�����!��Z\��F�F������yi�\�,�Q�!�-Gh����]���1p�
B��e~����l��]��U�?p7��2}GT��u$f��8�gDU�B�`��R���06�������nu"�5J������R�k��ā�-�����Sbc�2g��j��D�$�Vhm��C[b����'yy��w�>�"A����!�f`ό���v5�Vk[���|I��������#��W���r�)#�G�fZ0����xc���ݶaչ�z{�,�,��'t�kk����o7L���)��K��ogg��nb�հ��/�KaYF�Ώ�ʇ�e��WW��E��g�
���>'�|ɵ�3;ǅ���L�g���{~�I���j��L�4��@"+L̻^~�-m=��l�ݱG�(�G��,��'qț%R	Yf��A�w�F�uݕ�Zqs/��e�{�J��68�3(�
���ӾG�g/D2M�v�YnVѽtol��5�J������=F dV�����Y�M%����q��4(5Z�������*u��}�7{���v�6sYw]�,�h��*mw�� ��x+B�N��2(
^�$TW�"լt�><��Mߏ�-�:U=��	��xD�V!`�y��5��^��if��s�We�h��γq��Zv���Х A����2�7�~���?����g��`W˚���-��j�7��ŷr���B� �b�w�1q����Y��TYl9�E�:��f�k��D�>@�R��
�=*PB7��o�i|�s��em虺}�L�Qu�)9=���H?�n_�`l=kszv�p��ӵ���hv�.��eW)�W��&����{���
Ez,�)�<��f��s��K�����a�%S����9�)6�a?>�:���H|��8������ɇ����UXd}��k���mk~rl&��^�H��}E��|�b���TO�<�,�Ym۷�����/���Y/p�?�!���Q�}L�j�IRx�N��R1)�{���ժmQ���7��fF&x�?��m:�6L{B�D���=���5�亘�o]j��v��<K�4c���W�;v[��X��ٝ�������'=�Ȓ��zwS_7��۵P�Y~0j+{��I������Ke�Њ��E�%G�u�����ΪGVz����pP]��Z�q�?Bǻ����涏6���6��,���(�1���~�ڟQa��r�86�y!�4|�}�'��!ړ%xt���_��F+�q��kmfګ:?n��Z􃝳��Wk����d?I���� �C����
0XC����:�ȗUg��o�[7ص{��*L�m����H��Q?Je�x��4t�`�Y�����i����ș���m洡��
���^��wfc� ��H�&�R�	�����s\?X�ά�J
'?Q���u�E���w��S�    ����W�ضn�V���gX�M�?73sr4�DϏ��c�V{Vm��%J�G���?���$R��t�J)󝜜�Ořy��㲩��jg���'7�o�����St�3��n#��cZD�$���$��Dy.2���y�<�F�R���+Gw�mX�#�K>'}�ɰ^ĵ�uZ����<-˕�y���e�뛇���pCo�d�*�k�@��j�A]��_i�;^R�ҵ�&Y����F+F��	"lk����}0N��!š������[����u��/h��e�e�\��p�z�����¸x;'�x/+X����3ŉ&5�d$��p�.�߁H={e�Ԯ�Խ:����q27�[�ľ��xo�-�|r�j�H!�|�mb��m�s;?)4�z�5�Ys�)�u�k����D��y1�RL���A`o���c<�H�����܂�J�z�6�.��㸼��#}O!�^���Ijs���x�-C#���Rݾn@%�p3;/���5���@�{�penJh	�)�O�p�#/�� ��J�?�ݞI��� 2|�nr�~�MԵ7�C)��{�����l��9���"++�ۯ1�θJ��Zfaͅҧ�\\��M�4�Yl�@�O;�S�� �^WH�	|���ј�����A�i36F��Yu�����7Ykq���Ä��_�����؏���) ��?	� `Y3�[AL��5�{P��Uء[4�_C��)бe��P���1+[_D�ڱ�]�t���p�a=�=��{iߐ_áߊ/jEJ'a���Y~t��vۮun=�m�]��������oh��U<!!��;�ͫ���֪ˍ]�a;=O�p&د���r"8���-�}6=�k]fn&�Pov&	����
s�F��@�~�VxTPP�"�����`*��$�7�ȳ���1hVi�E�ibSُ�u�9��a��i)~�VaK���'V8���p�  4��!!薚��4󍷥n��6_�n�Y�j����[ޓT���4u�d|w���nrN�fzt7�jۛ��TYa|텇|�ϯa��@�E�צ��8�?�=\g񗌼`�W��~V��9���{.�w����t�'ݢN0A�Ч�B��Y�2����|������d�Fi�B�'��IL�9�-9H��y��F
�^��äp=_��`�{6���V�HsS���e"���������)���[��Oۅ�N�J���{;��.��<5'Gp�gԄE*�u�ڱ/��>�Gf�T���,�b��=�����g?x����R_	�(�17��]��l�m(�Tۖ���{Ɖ��U����v�
C�8��az�i>��"�қ&�<��`jӄ�^�b���a��=��@������O�9��5�ae������?�'�gA�ݘpS��������؃d��S�<��@��婴���~��F�XTc��Z�}Nm����8D�|��n焫]��O��$�����,:ŲJV���q+.�D��ʄ�:�����~���L�Dڙ��f�W�s5uW����#N!��CG���m���h��*��9g�Sp���[s��ݤ9)ϫ�C�8G���������*ϖ������6W]�`X?Ӎ�x�-����N�~M_/.~��?���������7=�2�T��h��\�;l�k�����/�v����_#��lŰ��lzP��Nb�o	q������*}��;^1��r�U;^��߳O�����{�$)��ؿ�N/|�CguO�M28��ŝY�U��垳�x��(����9e�"�S�T6 ��ס��r�yX8���mu��������~4E8J���54]W������*���IkXGTJ��aICh�
���o˓&�TOjb\�̴�{��^�j�>�7kp9-��!
�k$�����Z'����N�5���4�=ͬե�f2�E�xJ���7<]�;��5"����g��ţ�4�M`?�wFV"D�,�������Tԓe������@��$���{Kr�v�
N���dx�'l�Cd�ڃN}P^L��8$�eTMh'y���������Q�6��LϺ��*�`�*v�\}���I8B� }���O��4�����t/�E��U���^��:��e~������W�i���ִ̏%���4C�7�ua��&D���<�^o�SK�=l�S��g��:���&��r{ݭz+ۗ5��{���<�c�!U*�ad.�7ּpXV�і�C����z(��x�a����Nŵ���Qa*�,��截KI�8#�=��;I�߰��&X��	��^�������n�U�*jt����vT�W3px��#��ӿv���i��f���?BL��E�s��ؚQ��z�5��ޢ�Gf�TY����-���6�#�g<�D�S��Qdr���8V_�W�������Ǎ�U�baW+)�Q���&􋾢YS�;l�R���� ��=z;��z�[8f5����h�F��Y-E:��+���FKc�ޭu�C�Ң=��[�~~�&ro�p�U��0>F������F����Y�x�����(����F$�������5�Я=w�θ���4��j%�`�_d)�5�9[��9�����80�nng��N�{N�L��[�e�43�>_q-�Ȫ��r>9�¨�d��Q��!\�P��"5����������{��+��.}�ONW�m6�Q��C�� �	Y�\�Z:�SOY<!��GǢ*�e�陋�~v̍}ܜ���E������)j�#��*�e������|�3�:��A��:�(U�߾m����⛻��=d�#N�����t�^(x��>���VkL���6P����E�d�4Pc�o�
����w�|F͠K�\�� Fh$�ҡ�����hR�3iGr�fU߸�3FZ��L����輪�b���w�cȮP�u	R-����t)�Τ�=`v;��=k|q�-��u����(�dԷΓ3�\;��W����:3�-�Wq��O�U���Gڰ\D�>b)R�q��8�6\i"�wR�4Ie�	�����6�3�p�+�;A|����|B�����}ȡqb5�t��x�ƞ��P�#r?�Ս�E�l���R��w"mq׶�� �~F��T�,[*ӳui�[Z�~HMr����.��e_��؍�eᰶ>ʹ��y�&��O( �d1�M(�i\�(j*Ǒ�J.-H��^���Ջ���|�W�FgxIae���0��~?z_���E���^x�7^(���~����@*&-c��Q޹��j�`�2��is�˃���"��>����x�/ӞY�f x�_�^ *��Wmy[Y���>���؋�o[)�N���|τe�6�OG�u+�����/������y7�wF�im4@�~�^>%�/)����1X�1�`�On4��V�
�˾�:�:>c����@	R�
i�Q7!ŔN2$
B�.$��܊0�%�^�[{w0��
��b^>c���	�G��DF$z���|O(P$�F��]J��E�ϭjָ���Xn����?d�H��۷0KG�v������R|4�K�=wG�˻�6�3�4'h� /���8�������',+��fHccaW���NF� nGy�;�w�	�:��1,e��x[�꓊���t_ꝉ�_s���x���(�G4 �;��1>z�cEq䜃��T[�4�FR�
���n�[�n�r�w���M�����Ӛګ����Z� �Z7��AH��G"}�`�9̺܄[�Ψ���j�W����g��
�#�E�Vp�b8����[�J���q	��[i�F��_�&��3�Vk��Qޏ`�K�p���c5��|���&4�!�҂���2���-����N��aAW6/����6B��*4�j�!(~�*�\���M��x�/5�3����ګҥ�\�e��x�ߏ���?����������1Y��#a)8� F�<�U��qJ|������4�T33�sצ���]���\�|�ֶ" �ot:����bnв?�+F�A%G.F���9�&���h%��dc/� �0T�*�N�h?k�[韦v�֏�%��    ��.� ��K��KlV�����"��Y�A���2��-z���Q-�	�d��I"��������֘Č����Mr�r������S�U���#�V^W]���x% �
WN����Xd�0�2������r���մ��y WWE��Jbh�����!�2��)=Ӏ^�/�t�ߗ�[9�_֦�`N�ew��}�$����ޏV��Yp���@�|�w�ZY��]㵭�C!_^�p}x�?)I���X��w 4��f"0�����9�Z����~�G��ָ���lJ&��ϸ�|���f}��s{ �.ҙ����Y�֤p'��Y�s��0\������\�n؆cQG���KL�,�l+�ڃ�,�蜙)��2YDs}W�*�^Jx�����<�q������R�D � dܺ�ҵ��2���;���'[�feM
ƥ~>\|8d��9���oO�)p�6�?גe�}vk�y�w&����ñ~LX��r!\K�l�������A�'� �U����w{e�wTR[\=��+��c'��#�
v+H��\��r��`Ou�7���Q*��wVy�|Y)�����X���ܟo'5��3���R?���we[����i�8:7k��wk������ni��U~�X�7xO��C�w���y�5��$Գ�k��\�{u���Y�|���f�7(�G��=��R~�Y�r ��T2�o "UF��NB���a�u�D�^nY0�aA���n��# ��������{8�_{)�� �Ȟ�ߨf�Vq{:����_�W�S,x� �{�������#����Eh����pl;h��J�������Q�����wT�J;8�E ��?�$/��LéOB��-jP�������ę�O���晵Dx�+E����/�N�s+�j3�����g����`���I�B���Y=u� �˪�!ml����sl��m����$?ɋ����NH�u�[�%s�Ұ��sL�)��gpXX� ̓I�:��ǭs=�>��\�{����;?�0%��V�ȴ����f@����>�=��u6����'�ko�i�P� ���G)G�ꜜ���Q��q��Bי/��]y�w7v���M�����]F;� ʾC���J��	���1�
���d9}4�4%3?��5g�(y��nؙ�.��9{O��nu�4H����y.w��i붂T��3<jٶ�?��������|��\�ޱ>����=��L3��b]�i����Kn���z�	e&���G�2;���ۣ�.��`^����mzE�~�i������v��I���<��ΰ�+���R��I�i��������p�� D���k�jz!'�J�l��MMf����eܯ�q/8T
�j���=-�,7��W���aV�^�X��4sk���j�ͅ#�Q�]�y=o�ؼg��IH��w��STs�Jo���8S������86n���f���c������Ř�|?���j�-���^�L�tL��R��c����8�������
<����!t������=#�O�޼�ޝ=�Gq���k�$�<V��O�k2�[��X�z�e|Am�E�����r���/wrf/�{� �O#�}&YJ��I���j��&���~�7�-jI�������9]g��;G��0�.�����Q}�ߢ�o�gW��嫝��z:@
Y68��Y݄/���E��zѹ+'�n�>�荙�A}Z?z��nIn����"\{��|<����ً*��Q��Qv�~��SD��O~A0�֎8�r�ydY���ű�VdU!�A8�9M��������*����V���,砼oQ�'}����vdB����֙{E���鲽m���p:=����� ��G���=a�*�˽g��{+�P)a�B����)�3:7�d���^'�����:m���m�\c8�W����g%1�Źn_6QSߑc�׋�d{��l߯SiLH��|�!n�Y�*&����tn��L��eo�o`>�⧝�ۨ���x�3g���Tt~JnϞ]N�IAC�>��e��5
R�������YA虵F��*�S����t��־U�J���/jQ�.��g�1�79����f �2ߥ���nOȜ���a�uw6�a�=��O��u���4����as\.M����z�WϜ��}O�o����V:=�:^s��L?�;�!Ay�DQ�o��!aƫ�I���x�e��s�Æwl�瓠�����?I	\rr�^{�S�:*5̗�k�yxD�^�:������w������'~�IHDq�5AJ�< �3�c.岕�'��׹Lz�c�V���#��@%�T8U��k��H~jG�Z?꟏�Na1^����} 2�uL��L�.0B3_��)��^5���i��Fv�4�Ww��򇽧u�I��wsWl��ƌt � Жp���O�9HwZ���P�nK�䞒�޾�@ޏ���0�4�E*Ri�#�B���Pvl�n䜥5��J��xkE�^��@ԏp)�c?!1�]��LU!�4G2T��>���̭���n�/�j�@�Q�3
5� q�ē���dJ;�t2H�!|�A�r����"�d�+�rj\�&������H�r?$��S:YM�\L�.
֙���a�POJ��1���m[^�N�� }���zP�0&mӶ��;�=�.Ω�it�S����T&L�۝�/H~Of�;_��V?�!'�=M!�>�~r�v��ş���3�ZE��?��t�'�r���+����E����x�jC���s��k����|��0�F�ן�6�>n�+ם_��x�Ӈq��56n�G��
������h��yx���Ն�Y���cd,f��U�}}���ӹ�[�6"/�#���x���#+����\�{N���Y��%�gZA�Fʯ��,@��?�$/�gq�W��N)��sdh"�?����w����N��lo��UE�x�N�-��戯��VCf�,m���-�?q�$oJL��1���y��3�ɪ`�w�>�.5ox-�zO���%�$?�X�65�Zg~{���e��q�m�؍o�Z�~ 3Ɨ�15 13M�k���}��s�o�IL-��e��*�tZ�3����eѸL�SD�$/����!�7қA�&��j���m�g�&�V^�~�Uİ��*��x~`��<r�u�Q��x˴�	o�!��OBD�ɒ�V4ZyU�|�sm~������?��� �����e�B�G��+c-�{�/H	�>+{vh@虹��������0��t�#���$���hg��1����Rx)I�¦w����4m�|��e-�Z~��Nh�޸56r�)v��� ��:���GG��0�c�H��p�eLV;���;-h�}oG���A3���G����}��f]@V�DƗ�N|��R�����A�(Fd__�%A14�����=�ďq(ŧ���1��ÔL�U�����kT�r2�F"�U��mO'�������E�xE��E���g� ��x��izvRI'>�d�l|=�K��o����I��|˷�1�=H�ǋ>�:N2�g4 �r�덃3l�;-�3=lM�1�����aפ��Y7ۺQ�&�}@|�4�c���:��0T��,�z��羏�(�-�qo���9|�].f�'+�n�L�
�(F��2OW�%�ڮ��s�/�ټp8Ss�>��2���e)��� :K�ܲ-[y��BjL�WD��Z�zx06'Q5�����Z��{?i��h?�.�k�C<�}��`&�~��,e����T��<>^U�Z�B�S.A3� ���ۜf:��U`�>�I70��2���Ex9x�x�jAi׬�`��~Ԟ��=Y�1yI��>�Ž~�3��i~�s���㶜퍺H����(~Ҫu\A��ya��R^lidf2���ᳵ��W;a�wv�\�Q�7�tO �8��Ӈ���2��7��<�\���y�W��O��Y�3�\Nb|���Gy?@*P��!�Z=%1������_�~���_�<��6Z�4.q"��N~�M��|?�G�k���v��OJ�œy�Z
U�ud�g    b��s��rU�AU�H����Z"u��M�W�;A+p���k:�4L٥8��(0�jSy4��Cq���zv}�{z���!'߃P�q�6�plz6EJ1�df*��[����݋�>lfyR(��-���x/���8Pa�Ά��n�O�o�������u�?�o���?��~"�{��h��v)�� j�r��ŝ�ђ�C�z��Yٚ;�$����V���&�m��k�6)h8�N��cq�UY}dP�N�}-��<��5A7�'"�7��<@¥�i�5�I�t-���9�@���>4{)gZ�������QC�[���=u���ī�a�/�1�pba75�� In	7"7r
�)��Ax��g�D�i���\D������Ve~]4��#/K���L�`�����o�U���g/�3���)����B��FE�[��P��^�ȷK,L>^5r��LƋ���3?j���[0�̳M�+���^��%������|+�Z��q��_r�f~d���7�n�<]fG��,����`#q9>�?c���%��c��W�<�_�u/����Zj������y���l�t���%�_��CA@���g>�>��G�(��pb3�`V��`y����y�g*Q3-ۣ��(ܢzm�e�00K%o��h��F�ը���Y�ݭ�Z�\����N�0 �00K3ҋbC�i̵F}���AT���IT�f�kޓ@��vcŷ�w<�v�s�n������2.�}A$������g���ʬ�rm�l�=ww���kT��4	<|pN�89s)W��&�R�!x��Wb皞�E���Qy��<�K�$�!��=��;iy:9�K��Q K��ҵ����lϚ��ѿ����1��=����d�����W��^_h�b=[F���'�������>p��+IN#���h%�GK�n�	F�щ��q��V���kH�_�glK���D���F	�Vh���X�C�KED�Xꝓm86��Q���>zK�m���'�J���ӄ��/J(O����Ĭ�E�,��F�zP
���/iX�}O�����L�BC��t��RZf���nƪ�Q_�'"i0�3���7�.�vK D\'_[�5���_8�4�L�F4E3�!Jr���^{Z�$�L�s3x��_�q�eo�M��05�j��^ꖧ?�Ĥ�_�ǰ�7��h�?q��ԡ���5KwV
P�_�q�UN�	f�~���uN���,� 7��?O�˱�y?�~�o~��{Z��:�$r��7q���QҀ��#[>�%Q�-����5�ks~,�6���h^�c��{�����XG7 �o��I&�n4\ˬM!��W�J-h���l[�����Ex�͓]p�w�>F����O�1ǻ$ٴ;7Íf���(ʯ���ڃ�E!��YH���!����i����k�g�35-s���2
���ޯ��v\��C��;x='ko�QO���G���P��:3?r�ݜAC^9tc�	�ut��_�q��F�o:��@T2S�x!��e�r�1:NYT�� ��.�=;��z�q��p|+�'Az〯�X4��ه�޴ֹu�eJ�a�宬�x����pH	��!^��,��״�� f�o��f��npL�u�.�߯Q����d9�L]Fqn>ex�yf*#�J�~\�gjt�����v>(��D�w	�@@�t⦎�)�ϗ���4#s��;�r��GF�rϧ�iV��Fޓ���������w�ZlN�*����s7��mh�JMcv��h����������l��w(�˺��S'�8�*�ƜH����\@��/G"L8��
;YJ�[��L�Nk���_�k��?*�]C��Do��&�!W����l�=D�;����]^�e�Vo��=7�r^x���r���վ'x����{�H+8��$:n��k���x���h�y0{ƶT��7���=��{��Q�������4��WX���N��hū���F\X_h�l�`|�9�������Z�
��Mj~⸼�b��q�������P��E(����t28u�Es�����̡�@l��[De�W���Ccn�q�������z��AmKI�\\�ho����a4����;i�W���9��,�qH��k���h8����P�v~xgS�Y[M��{����t��]�LM>
	��^���~$�]���9_���� ���߽��^Pdy�.#�5�^�gL'�b�.���I�ɾʢq/?�]����ػ������B�hrz̃Bk{�6ާs�OXW�� ͈t����p��}��:�Z7���d p�?�)9��s�c=3Hk��]<ITp�9��^���0��U��|��/�������?Ϸ�T�1]�?�Lc����n4oO�UP���Q/\v�ᯡ�~�j3z��ĽǶ�H�%:��ށr�A��֜pA� A���f$���]��:t��q�'+"-��M���������pkM>��I��m3%c&�\%Q#��+��,�g��yP9r*��K��%������Ty5�廭���I%��-��Wj,/��{�=v�ۿv3X��pa��j;
|��(�T�De�S�C�/��-���ɳ۹������7��/��=��spCǄ�}�!�[�K;��	��mj���iS~:]�ݖ�(2���Vp���K:��<BS>.�Ct5���`����Dѩ�͢Գ���jGj�d;�'�7�Ҋ�������5�8JAA�nl�%�>w�־Z�\��[<�_�'���`J�ȉ��J�@��K���h���*�x�Ż��Jүm�/�g��� �9��Q�kD`g>ޕ��(��i���s�4"-���O�����SwۘD�Q�q�k\<�_,sbJ�Z3����37�֛I�E�vN7�1�z/�~Mr���7ãe�N�Ƌy߈�د�� 'ॅQ�����u�/��U�2�~�`�U��~����1�#c�����)��fE�p�Jp����0Z�V�ޝ�(��~�Bi}J��$�A�X]�4�)��tl�̯���k����FK���م��H,��wo�0����-��+h�)� �=��C)<���i�ޔ�C�1�*�/Q��ؿ$p2#)� ^t"��xѸ��ӯGdl����m�r�zI�tx)Wb,���+�@���j�Y�*p��TM�Q؈&w]>������z��z&�3��^<�_,�6����d��鞮��(b��s�j\�:��r}��������tڷS����q
�#B��NGgkql	g����u�-s���R�r~�dYa*c���UO�t����YѬ������䰨Ͷ�c�?fC�s�1 s��9�І���q���+&��qg���6��֦"]'SUi[�V	������LF�	�GY.����҃i��Rk�gu���I�	�K֗�2�k-�z�E�)ƾ9�q���k8r�>{N���W\q������
��iTQ'���R�&I������w{��2��f�c�����������?܃0ҁ��=�d�3$��,������A��N5�)�����Y�Q��]ק�['K��_�!4�庞�RU�-�#n8NqX�n8�;�BΈLZ.��ך��4���3��7ΡooA�/\��7J�=�M;�E�#��Fp�C�"�:%��N�;!xr�SZY���NR�b·�r���I(�/��oeN�P�L�\�q��m�=S7�a�s�^���}icJ91�{t���<���^�n����"����m�C4l��H>uk&<�����~�y���NO��D8�ţ���ҿ��+,F�[IA�_�f��:�)SE���H6O��A��(���b����)1B�������`��<��֢��!�V3���ay_�����p��^�|�{�w�4�d�ج��/�"�Ň��.�<W�y�m���ޓ�\]'�8����bi�0��ӽH�� ᠿ���T}��	B�X~@3°\�Ճ�Ǎ�1H8��]�?���:3b?��ͺ������^Cd����s���6uj�i�WC��a��e�ۙ��/��$�.n�G�Y�?X�W�B���4&�/4���tx^/���F��A)1j    x���<�U�&D������A��ٞ�)D8)������,�+	vo�,&�7x�k�����¯�����F���5��n�=f:ܔe�y��$$�E�}����F�v����Ұ��A���O����"w�	)xZ9���Z�7����y���LS������v[,�x+�`��"��.<)Ru&��}��i�M�S�l{�|�h�����?)����ihn�؍�++In�!K7{ԉە�>�x��X��Ҧ�)�w*��|�jp���~F�QAE���:��t�ޔ�����*����Jo�w]'�H�Df2�5��
�aAO�2u��]_ɰt��jj�צ�ڙ�]�����c���i i-�ґR\4��M�z���Zgbxk#��2�pQy�)ӕ����sx�E7�$�*�<��d<Y���9�k(��)�N�R�LKυ�}�[&��yWA�E����3E�`�~J*rm1=���G\x0�~���-׈u}̗;֡�]���9v��do�8Y���MF$���1?.|����|?o�$Z�5	{t���xJ�o'O�! �9E�J��q#��A��`��'�.�ags4��Ý.��V��9,����31�L����I�[B��OD���4��]i����8���_{$��ݬ����1�d��p���̕Y���S0z�&�01,8����Ų!��s��1�#����\�&wJ=�m�����R4TO�)
�kC�Y2ueIum��簰���,[� PSa��KKav��d�Jk���Z[��u�<��IK~��ȉ�V9w6���g��}Cݳ�9����� ���s��Q$V�^�t�e/��e&F�����Q[����ǔ��@«�kC.������4��nKY�%4D*�?yӬ�S���f��O���Ub�M��V�0�=��K��i;"�ϗ"�#�d��ϰF�;1���8}ޕu\ꅇ�c.�o������ե����h�v�G��wG;�bU}����>�n$�ʤU�m/��/��3PC�i�Y�'�ZUwt��vS�J�����(ٯ}X��s�	�0�)!��?6[BV<|��C�KE7�����ќ���Ne+���O�K�	U9M2f0��M�Tt7:F�7�>e0RFa������|4nM;�ýt0�n ǲxB���2�.Q�9����)���EwTD0��������<?�5�9�����wM<	�vG���bE�cF���?� ՉN]�_��M�TؐڝCK���f��̞J�>]��O������O_�ж�z�zN��Z��U����r�.���a��&��xn��@� ��aV�հ��!t���2��Z�P-=ڌ�-})s#:����d��_�'B<8��iB���Ӟᩦ�)�MM|�8ri��QM��-�Qq:c=*ۛ���q��#��ҙ��Q�8'�D�n|��5a��s�z,����ȑ�m���Q�_8'���d`;sza����6�!�VZ�~��Ͻ�u��(Y>���P<�_\��?O�q�EQD(d*�,[�)�����S�5�z�sک�mڟ.����+G�ǽ�=�����M^˷�(����;��a�p"�4�\ԛ/ǧ��������g����%$���U�I3k ���Dc������2��h�CuQ����ð��-*������k��VF�m���W���m��g0�2<��_m��ec(�C�ޣ�������R{��]�j�Og�zڤ�ǫ��,"�8�P�_���sT�8�b�&�r�A�g��:�	j2{���!:���wۮ\���`���X�D�į�QEg��m�b��]��<A!�֫Z./U��{�<���1�G����n���̡�g��k�'��8Q?O�⤼+�rn�v�ޒ��n�{��_<����t�#�et��X��w1P%$���B�v&.�����ٛT��z��싺!rs��~���~^8{�`g���~md���;���*�NK��-g'�x�$���NkD
������s��RMjR�X6�ۆ�֊#�:�ٜ�x����R^��#�T�g�	8�b���%sUg���jZ��JeE�������N$��_�{j<���~�@�^3�����_�+��R�����!3QV��߉
����!�H߹r>{�g�֤�P��x��g����~@���T�3��,�����V�D������ט�`.�\��j���@7���q9�U�o�קd���o���*/wM����H+,1U��U]��Wj���Z������+���}��菑�Ie8�*�-_S�ԘnF�:mmk�T�A��j�kW1���Ds5�CL�a�l8a\�ߴe�c�uXΔ�LF��iӑ=��/�Z�ȹW���o�"0�m�8"���)�K��2�l�h�:lWg�a�B�,����t�����?W'���������.�2j���*.]��w��M\o�\1���D{Di�����OvA����CF|����`��,�2�,�r���i�:��)�L�\���*�q�&/쳽KO /������0��oO�rJÀ?^�21���|S�8!�~��O��q�&��FW4,���>�ML��+p�9+\�,Β����W��h];���	�����)6&�U��:���9DA�A�z9�
���
�
X��D��p���S�T��}Z��1��Xc(�M^ɠ pQ ���:*�1�O8�KDS��?1D�u�}u_�T��17lRZ�7]��c)��W�ޛ�Om'F��R<��?�h�L4�HzNgI�yI�����*DzXc��W~����_9/�u��J��\u5�b5��7^.�?�
�%�U@��8���V��ScΫ�AL^l~G��Z�;TӸ"�K i0�yI���`�ʺ��Z�z���5��U>#8�ݞ��X�t�a��k��cg!�Z�'(4+f`�U88X���Z�*��z}���#ڳ���s�eJ�?�ڐR���:E�~A]ݼL��GT���F������&c������=Ҩ���t�ܖ"C�|ſDs��I*Kէ}k.��~w%��
g�ǡX^�C)�M�S�a�Edյu'{�Fϋ�B^�U�FDk=������PnD�I������M(t�����5����h�̥$�b�%�����h�v��jQ&��C��&D�pb��5L����o�ō̽�H/'hd��tRm<Hd�Ʈ��F����~��@^�U�J'�:��A%�p��>��ȱ*&.���$M׮e)������ԋҞ��##R �hL2��PS�MP^s�tAo���g.�b>01�-x���p
�(�t��<�%
w��dE��8Y�yCnҾ�P�/��L�q�C��q��4g\��A40RZF�)\n6\��:$�����\^�M��w�GE~�Ԕ�>�����
0�?��0��ʟ�j5>U��q`�������hx�8�W3�_sU�XY4�"�6R~��0��Ŏ&�H1��]I&���.S1ꃀ^3R%W2���1�X�0w�~������c{�7����f�j�H� ���Y!-Ĕ���a�,8=_�OfO�v{��1m�,{46{	_9�'�H�T�
���x��z�jRǃ0E�e����T.�P�ɢ1���f�u��+cC�]^����B�P�5U���iTve���GR�b�(�tM��P�n�첏ꑿ��Fkl�-F������4z�ڴ�ʰh چ4��'���&5���dZ7�K���[�:*�#��Wn����t���[Č{˅7^2d=�mH�)Zo�������^Ӵ���,�P�_����f�説(�ě�3�c�����S�(�Y�Q}^3��<���T�7�nc�P1�����@��C�F��	�T#@IŧW������p��׹�wO��	֡������~�@Y�����0�i�?]w��������܇�E��OK�uoކ0�P�o�ޘ,;ʙ�x�7�g�����G~M�B�w�`;<�t�L���dd�!$ Ő��T�R_�#l�T(�䅫��BW�����b�p��!��O�Ri��5\���yy�r]��l��5�m(&�d�    {�b2�@Ȫcm@�au	��̯�}�|����G��lA�/ܘ��u��##Us�VUe:$���B�@�'#���nF=n���uE�VwR�;aG%�+/v��;ٙ�kj�o�Ϊ�7����>���Ԝ��������j6�z��JJXjx|��b�O��w ����7ӿ���	�;��rH\$��5�l�kLc���N�q�tlz��k�����L�9���ޛ�T��`Y?��k��)��֣\U��a�����䒵Z�u���z>��5���07�����&�e��Q�/<?r#[7�4���c���Bv)�2�~A�u���Q�
G0���9#�U�����ӥ���&��%J���8Ƨ��4u���
�	 B�/����-R�ugΊ��`�ƽ홠��RF���h�^tZ�~��H�c�+wx�˨p����V�fX]+�q7�l�~o��B�<p��5R�L10=�p]5L�MȽ^���C�'��q�^�|	�S�z�W�����Q���f�K�-k6�$,�g]:�
�?��~�NZ��i�~�β9�[�F!�P��!qۃ$�0=����H\6d�r$�벨�ڀ�^�"Q~jU���\z�x �j%D�@(�(3��Ȧ���r$BD*T8�F��	��;��=Ts��$=��PZ�:���V���
��Bm�H_-BM4`8�-�|�{X�w�ܗ�h��v��p{�Q�_�����B^#�J$[U���\�K'8������/d�bLW�8R:�̶2Oa��F!�S���Θ�SC��v-�2�,��c�I�в.Yl��2$��V�����చ4<�:4$�R�Q�%��p���L�������t���T��$��t\͖����CKv�tA���~��:�d�'��2l��s�R�hj�����7��n�l7�}'Fy�rh>�
����3�;Z�[�Zձ��C��
�C�;�����q��Lm_ߦ��CT��k����+���SH������DG��j1Kf��h/��m��,���R�Y.CX`�[[6�r4i\��?0k�8��b��EI
�z�j�7��[���X���T�x�"�i`�vM��������"�w>$���j��Ӥ����T�(�W��HŸ�/����E�������"a���O�
������Z�c���~��i��+�&���$80lz�m�b�V&9b�H��3%���g�U7�=5N��9�����q��(�d��
q5�"�l��uL���p�'��rQ���ED���m�����~h�I��q�c�HW��9pϨ&t�
U��$��.kL7a����p.�V0����:�v�z���q݂���5à��9il<�nyH!�)����I�����[1/D]%�g�~�ٟ����G�˼r�鍎���]d�|i�2��~�k.��7L�8V'�b��.O�]��b��	��DVB,0�xQ���._�֫?����*�:q���W�Ck:�x�v�P�I(�W-�i�f0D�4fz�C�M��	u�?v�*������)=�o�y�F���@"7�Qȩ��s�\M�<�%�``9�<��÷ͅ��x���K�%����S5�U��+τ�R���uTIl� �����lnATE�sϤ*�0�f�so5����ոZj����E�x�7ܦ�������"�f�Z����ǆ0KSO*}�rL���?{���墼_{����Q݅���\S���8p���d�p�Q��s7����c5�����Z��_y&��At����^���������x�%X(���v�Pmஇrzt�{��o+`p��0��$�ьd�4	QT���B�'A��yR���;/�t0�����,OU�鎮�Ê�0�&/���j���`��g-I�FL7��ݱ�K$��F�m��}������R�g(�����5�"���4�A˴���l���om�A�]�2��|B���XsQ��ph�Jkn�A�kc�sPʯ���"��bG&� y_s���	�����x�w�c5菬�6����J�.ܢbH��7gf% U����0�^�	ֱ���+�"�~�/Bm��H~gsN�A�knpJ�A1�&��k!�6\|�r��(�g(
sCzՉ͡0��~J�HFUs��&3�N����~՛aGH4}H� ���?K�î��q��[����[�n�+���@�g)��_�&����TZU��\6k�
wv���Y��1ˋʴ�Ql1�_�k�~�xe����|~Kf�cу�厜�j��;���������oS%ҫ���)���pbS��)���iU��4l{G�A�e7=�	̯:�Aԗx:��>�!P�O*K�W6�I����F{�w�c��1���M'TE9�T���U[U4��&X&HP�č���Sq �:�����/�u4�-�A�2�����A �b1��Gq>��N|�R!��ZE���]٠`ћ?Ы�$���ڙ��zu�&��}��A.����0rs�����Ꟶp�̵!
��#��� ϙ�(���78�GG�#=G��B�#k*	BH8rv�4��­x��u;�p��=w\c.�(�W���'��������Ҽ��u��������2{ѯ���s=jڒLLG\�k�(e��0%��𭪹6��	s�z��߹��ۤ��بoP1�U�L�jr�t��!�S5�Ƈ,_�)�k$��mr�w����3z�����呵<��OH��p֚"��3�m�ݐ�ގ΂n�rk{�n�W��r,ǳ�D����0A#�5�c-xrh������_󻇨��S!B� <�X΁kU������D����I�U�#%�?g���J��K6���#]�]d�	�)��{�d۶��'kE�Kĵ̟��I��h�+��f����M���g�u������]GU /F�O�qȎ��[D��T���p��T�d��F�-��đ��ˣw��	(�p���w������4T&�M����^�:m﻽�_��L�щ�r��O����r!� ��J;�x�x��+�s-��`�p�_mt�/S7�'�zo�^��n�[]�s
D���'L2�����?!2��'��%��[~u�kSkШЊKn�~��.�����P�����p��u9zr{y��c0�d��)���P�VZW�i�_�OK]�Z��i2�K�Z�՟̺%i\���.��	4�48���s�o��Ә����+t2�"���^Џ[5��X�m{�nY6�%�`�J2�2QE�4���q��ɵ�]��{�ڬ��-t3������� B�!g��6��ˤ�e��r}lY�eR��+���Y1N�_5�^�b*Y�n+�㺪iz�f}���TV�'�����ɭ�S)�i򏝉�Aa�M���΍��i�q�D!���G9��2���1��4�0��MY�I�aŭܞC�1�\0L/��(g��l���P5X��5��Ae��㨹m�g���
���)
k�Vdyu@g��j?���ޗ�Q�����7�|�P�c��.K�p�H"9��D8<���(���m==-��5�{�΄��%�3����I��l->�5j��f�V��	��I�.>V�J�ι؞��	�*��UR�3+�k\'D��*>��K�ڮ��ק�q�yA1�D�����B��\�r�¨�
s$��Z��1ʅ�ܼ[��ڢZ�%gVu��#�bH���U��gXڋU1/���扈w}f����o��s;�v�ݧ?�@8������Da�es��
�Z��~�o��.�`����ج�q��Op���S8��,)�#3m4j/��҉�^�R�=CC�[�AޗX��2��K<5�5n�/�xصfcW��v7{%��t1D�p���ȗ��#YF�YM�Cu1p��yo�V�hwFa~����L�X�'�4����YW�t�:�
�ͺ�һ-s��p��
d�_�pD}���@��m�#�!\�\m�k'}v�y��K�s��f�b �B����E0rE�/�{�|r���~I�7¥_��Q�ߺ��q�$�H�H�2�A��6�48C�7m-7    ^٭��>��zyRf����.�������yR�ICl,��#6N�b�����o�ɉ����ߑ�bU�4l�O)
�{o�����H�$��&�E�d�A�J0��������ӄa�����v���n}[a��Š�����5"BzĲ`�+l�i��퟉��(�a:�w*<]�n�66m�b��Oh?���n�78���8+��x�5*\ì�և�����'�W�Dj\�� �:�&�o���8�?���C�!Q�䚄�uoJK�[��1�&;��`{�Za�����2�	�iӍwϿ��f��j��K��X{ȗ���ڗ��o�{���(JT�Y��T��s�*\o�s�rOo�H}-�~4�d3�!�b܅B����Ha*ER��l����QF>����|~*�}\oӑ�lF��쑜\g�����Y�H��J��'�q8���h�\Z�ɹB��U��M7�p��x@�VEƾ�k�g�_��s���ϝ��S�t(�+^���3
����$b�w8҆�QS���12�|D���t}^�}c��K�Xq$ H1��_�ŦM�h�omPb{�qVT$��L��b���Xɔ�Z�l�.A��J�M����
C� �B�#@��{�����(�A�e7ّZ���6�]{s1'GW���bL���,��,.^:+M��4Q�I��#�G5�7��`�ܢac�;�k�
��z��d˒<�S$ݱɄ�#ɲL�iK�:�ơd����S<�����Ǝ�n=Z�ި��E�
��޹��I��:��Di��0����ù|Q���qR�X��?��i]?�ی�.
�[�#� �^j���ݝ�9ѱ��7r���2�7�o3�������?^������^Γ��sd�7��bbQ_s)ͬ�޽�~r�us9o/� ۯ镔7ʋ�����*w�Il��-�9�p��g�-+ i%ZR/�c�����hШq9-FG(<��ߗ�6c�dϢ�#��R��ɹ�7Ω�����o���� ]�&p����%�UF��v����t����ߺ0�;3y�)3yHe,_]4��mm��;-�y�*)݄����:��h><ӏ�C�ow�Ŋ}g�J%�wD��&6�����x?�|�ՙ��꣪WG�c%�N��^��;��q8���5��p��*�$g̟��Qv�̋�CmW��/�𷉊�:�o�%��j��p����K�W�FÅ�N�EcZ��p�1��T
�i��ԎN�wfOq���ڻQ0KWǀ�v�;zlؾbT���'|[,�@3��&�k��c��8jUZ�U�&�zw�����>P�x�hF��Z+�r���j��*�1o[�`����2� �.i���w,�f����z�J�s���v<]��n�/M=���K\���Q���~	�r�A�
!=�5W"K�����6���]-m��IG������p�y��*�-�M%�`���<Ie���Y�A��*Z阅ʮ���ԝ�p��:$n .�M�PX�;�a;L2Lbb,��q]���q�I�uC�+��A���[��P���_���4�[g����,ŷ�[F_�<K�O�A�� ���.�Jsk�Z�k�^��ղ=��#�߿�ʫӈ(��u���k�b�`��X�#�!�h�1 =SQ_ړ8t'RWn�R��;��c��~$V�a6�OW$Y�LYC�i�6!3�8)��@c;�0��|@��pJ�4v���u����A��T#����W��M'��+Nŧ:Fy�%�½�?��L�:��*K�����l}�$P�\?�&fzq�L��t���4`C�b�,��RJW4bՃIc[��ߡ����i�b,�|����~����]�K��ſLM��Q�qF~�s5�i���jB�nT5���9,����9��9;�֞*W�S4sZU��9��d��ΌW����Sla ڒ۬/[z�lL��FF�S��\����T�pkG��Go���0��;N�3�;=Y���Ս�Km09v"~1�#�AK�L���@��Y	�V�+�GH�֍+h\����������[��x�9o'�pΤ��Ac�>�֥{��%c��xW�����GD���3�|>ul���q-��s��5�ٮuֽ�5T��e�pG��E����90(j6�kH��Zl����~�h�A#�Fv4���?����\Z��jd�G�E|�7�~�1x��R����Ybd�ݨ?��2��PQ�lm��0_�h�;���4���ޏ���x_M�g�M�>��KLQ?��\�hegv�Ǵy|�����`I׮��_5p��7�MYn=WN�zi�>��J����6�)}�[9M���fu�M8kY��D�igY����~��5�F|z[�྾�	Xzwi�A�]Q�y���'�j<�aMr�Rݍ��47�(�W�� \7J3�EױK��| �SE=W��cm܍iZq:� ��1��f��������'��>����0q�B���G�'Y����`�<�W5��X#n�%o�SuCҔ0���y�M�^+Y7�\�5m"+�'
��HcÌp�2�B�ۜ�]e�qJ���	!�E�(o�ן+�ҭ��ޗ�Gy:�K�ݨ}lZY��h���\��Z~=5�cG���.�ubC�C�̈́=�Y��y�S;?�m�"qcyc |����ՇY�n��)�n�Q�ǰ���P=��S��5��@�V�=��Z��{}���[sI�=;={а�F�oF���t�>^��8��u��u�	C^y0�`��A*'�t��olx��go��Z�����F��J��(�5�w8��ED����	kRЖ�������^����!�d����2��*
�l�����	�����z�g������إg�����^z<>2���6Mr�`\c�t�z�(�[��$�����!;u��+���$�SlC��"=�p�G���i����|�}��Qz����NE9�4y'��M"M,5rFX����e��;,��r�Y� i����[��$N��>�!w��3 	��9�+.m"��>�h<n��澛���LEk2����CM6��Bͦ=��z#p6{3NFI�<�`_����T�c�ѐ�70���y��n�a�r!�����������2Q�#C�3v	�����sbk�~y.%���Q�{8d�L��?p�M�����,M3Ufg�`c���0�H�3]�h�������#j���yYlnh���u�� ��C@�t�����s�o��֍+���jl��w}�~�4���7k���<҇5n(J7���1�w3����z�5�1�����~*�5�O�(cd�܃؀g�"2c�����:���t�eX�k��E��ghH9T�MG��3���@`5�*Y=~DQ�G�0���1a��X��3��f�]{�`7~K��zE��C*X�����Τ�Z�ztNϕ][����>DE�Q�e�X��2	*�kq���}�;����.����js{���8��3I#"U�V�L$�����]�)j�YXmU���#h<4oC�5h�x��o�N����e]
�,�FT9_���i����~����_���a� ��O"?�V�<#���w~�̚���]�LփG���t}�$WP{_���x;�I�h���Zl����N�s���Q�E�m�KN��}�MԟKbƁ�q�eM�����>j$-}�4iu����b,�R�7�|�S��ܹQ��V��M�ž�w��>��'G�Q�"`ǲ�4j�Ƶ>X<��7	���d���I��K;�j&�n0�y�ɬSݦ��|�贎���~�T�W��<f���G	W�?TT�֝-XE�{�����>��(?��XXQ�,�3��؊�D�Ç�(2XmC�hS��y*�f9��4�.�ecl?����©���t�wW�`z6m�k����FǺm�a�O�u�ᤂ]y�S���&oap�A�0�����A��}���~�uIUW"�8œ��)�g����b���(��Ӳ�civ��Ŵ�x`����i�����<,�s�OW�xՠ-��-F�g��<��Yz�p����dPQ�A�eu�9ѕlb�,a��ٜj�'�j�:�����=j��!�ê,�ǆ|͐%��k]e�kT{�S��pͅ�8x̙,�    �O��׌��Y�e<��'������S��a}x-M�b�#���B�q|7��Q�sA"¸!i���*�m?�%7Ͼ��{�d^�����t�M];� &���y-���7$�o���e=^oÖ�yZm4"��?#V��|=E���d��U�!�D'���`X�4�k�񸬎���KFe�5����g)�3lb�f�Il1�̓�J~!���.�La�����M��r�߆ʸi�N�O��gY)r@(%�Ԕ�s99¶�i�K����3(��'�)���4�I\!�T��"���T9�����-����Q<�^t�����9�1��j>q�^���dqYo?�w�s�:ܫA��nW���o��z���V��#�!;���ra�}	�����w����0q<<+�x'�ڡN{Z�6�|zX(k��(�5�X�K��1�_Ρ�?޶w��"JS�f����������<l���Y0���*��BRt6w�MJ"�?����J7�]D�>� nй��9F��(:�j<\⡲:��r5����j�x��H�'�F2�?�g���I"��;�lҫ9R�R�T���LQ��x��H6���6�2B+RB��9O���DS����d_��=��Smz*��1�B�U<���e$h�D����<Oj�=��d?�N������x�@%�y����>kam�=�Y۱RA�V�.�]-�I������:{y�J�����i�� ��pk�r5j�Am�^�M�?����IA}�#�E����5�Y$
�a�\��ݰ{�����Z��`Y�xB�/{�yo�����a��u�������>�k+㗮��L�8��0d<��>�JV��g��&�m�^b~�J��ە��͋�B��w;Az��]J����2w��c^��I[=W�ی0u�xؼH�V��9���\�Z�ȉk�%5^���w����T��+��GˋD�ͣ�{)1�
����Y��g�,k+԰;]�pg�9���=9Utw~�e)E��K���j��&�J��i�H1��G�+�Q��;\� ��`/
��;���x4���������=���5NA��<J��(�u�!hPh�L�˘?����~7N�(�'��X�]�(�/=�Q�d���yu���ƒ����+���%���j9�
��Fx��4�)��v��j�cL�Kٹ��Ϛ)�b/�E>���v/�>�"';ikJ8y"A^���p%����2�q��{L�w��]F �/]�9�p� h6_����5��)����}2�1?{G��T�ӥj���5���Uij>�ڂ���(���� ���T��k�ZUE/��l��ͨV�l�.uZ�]0|��bHn����!o�S��Dz�Wekᄼ���Ρ�<ծ�Z�Ѭ���A�m�W�K��Xz���um��#y>x�?��^�_���r4�sW�����)�CS�u�\N�\���G��Ϊ���i�Y���}ؕ�E���!�O·~�����e%��
��r�|�p[�qR���ѓe�-Ip�ݎ���{/�>x9�!
�t#)ǵ0�G7k�G{[*'�s�-ZuP��N'*Վ�"���k`���in6)h� -=���zv�7+�n۹�N��1@[�k��AgH�g�*�����J2�?��v��U��ʩW�+8/tr���r�0\�>v8�E���g퉾���nh�`4˂�����a:�D�h���p�u�u�d�Қ�Y�*S8t���E�"�Ǫ|(��J�����~�_��C8kPEɛ�0��u���-��s>on0ь-���^C��Jv�`g0N��������.sN}�ʌ
33O�l������fl՞z%R�m�����&R���<�G���4i\����W[��wVem$Q�Q�NP��t/�\`��4�4t������,H;e�Q�7���x>��5��io�i�MحNcǸ�Z�e����\��ߚ�˂�f]�L���Uou?����4jg��_z��=<�l_�
�Y�W7"�?Y�G0�cGȒZzu��<O�m(X.�Pd�`��S����z�/}T�/=�K������H?kU���{�5|�7FuL������������T��+���8�H�Uz�0IG���#�-�,iY�ҿ�܂�.�Qr�΋�[���uk��l/�/:d��&��rx��u�yH��Vcyk)�¢�E�A��xx�k��*�J�d�]<E^���k)�L�5�Ɣ1E���n��3�����*U��Z���+���g���/UI���Z���	��Em�Z����uol��G����A���1�B�,���n����
��Y�DW�J��k�<כ�G�]�����I��>��2�LMx����co5�x�qsj�����~���DAL�L��9���s��n�:i�n^��_z��y�!�Q������n�q�g���7��iz�**��_���kT�M���1����H1W��?nUSy�O��\Qݲ�!A`P��t��1��r���?��&�<㫖��5k�ٵ�D���⫧qe:���O��h�N�+]����)�0�|�=�v[�DA���t
������sߤu{p�/�����X*(/��i�%�3Fǟ�Y�=D��T���pX�Zf�>�z���Z�.׮$�5)/�|��;�%?���I�&>A}�l�D�����0�ԬZْ��.��C��7Vn�ܦ��"Y'v��e%�C��������v��Ԑ Y�@�1Xt�[��x?d��~`�]���%�/=��
��X�[���ͥS��y���"��K7!��e��&2�eJ14�Դ ��ˤ��8��02k���'���t���+����=�2S�d���St �jF�PI �e��F�i�[&���Mi�U����îǾ.��ڻ$���}s ��ۣ�8 �d�8O�D	˰z4�	��{��կC�;��I�Y���!�����{K*ELB���.�h_�a7��Y�T���b5�#J�E�-�)�a��J&~�fИV�>0DcP�q�g�.D�Ad�����f��^��`8��;�p��7g��$]Lɖ[������*B���÷�������rnķ�~�oe;�g�:\��(ޛQ蘕�F����,�t�4�õ0�PR�ukje��,k<��jD�p�CA)H��K�ƵyN�(�����'g�ϩ㯒�D�#?������@:����y5C�%���J��bU�g�
����j�S����{\��f�����#�g^�d�F�������DU	��e݋�2�'��ɨ�xe7��c7����|���&_��h
��������� 5r��+������rT�-����*{~����i-���e�;���}�a0�be0����8%��Ӈ�6�v��$H�d4NdxE���V�*�L������62yf su6h�3Uo-���w�-�ǧʠ��x��G�����E���<� �z�V�ᨱ0��ՉZ�����6�x��(�W`Z��E�������7g��Sj�0��|�=�bq�#���A=Y���TJW�`f�L���R����8�i�,Dѩ"�͔�Jo$y�������չ�oE�M�G���#�ȧb����0V����lJ*e~,5&w��c��`�����4f�$1)4E��*<|0�i��b������1�;Ϥ����������a���>kf�6�'U��������X3�z�� �B�nh*U���tL���	���1?��Yp	G��O����=<n#?슔�"ex	Qޯ uݐ��u�#��C�UU���Z��c,GY�*}a-����f�[�[kqf�1ޚ/|�x*���c�f�P-w8
E�]HD���gυ��D�7.<2m_���;z��G���S�p�4�5̖���J��稦퇤Y��J��c�@��8ߜDA�D9�(G(N$����da��eu���aq�NK�ڭK��W�\�D�(�6u����� Q�����}�+r]'e;�H��������f���W�I6��'����D��@�V���Rs�,���nUf&��9xם�mg�C��(
(N�B8�8�    ������%kB�V��v��D�k���P�s��m�-8����L�M���ِuM�$��D@xQG����s1�|4����j����7�����������4e7]ƿ_�nsz9oy�5q�QI���Xd���<`�C��
��u�4]wM��$��d]}w_�|�qY�>]���<�\��O׳���T�y��B�Ԩ��&#�&Q��(2U�b�i &��$=� ���Wԟ:�f��نf.��~b^7>��o���S,��"u��:�H��:�wb(�Ϩk^�A��T��*ڵ>�[f]1-�q��of��O׽�����H���XR5���f}ڐA����NGF��k�c�FGڤ���)���RY�k̴3�%�$�Z~�eM���w�q�Nsg�νӠ�t��Y��G�͔=���aݼ$�znR	W���ɟ�8�~<�mY�I�}�'{��0��f�^kT���j�j��!�a�iF�>mȪ��=N�^�4�h�+y7�f�u��~1{��*|��>���9���h���	�&Z8ۮȸd[m�v��.���6x|3�O~ʽE§��O�D�Lc�Ҝ��Qᚃ�܍��Ц�lKrrtnS�������G�ew�ФT��+3��DSѺ�qq��{�A�<�i��7����-�p\N4���̯�"�<�޽5�Sk:3�ݾ������x-�fp?oհ�~>�,Jf[qm�vZ^�ԛT�ͅ�J�Ji�m����Q]��8p��4y3>VH@fȡ^�5��q�Vi�vi��C�Fƍj�������0�������(� *ܙ��w[36��9�$���|�R���|d�{8�<�C����/�W��/35IOn\I�
� R�,@��|ͅQuV�m�V���λ�x9fAA��|	Z5��D��0@{UJѩ�:K2��<���Q�R�5�qo��2e�nۙ����&�%}����?�}N_�P�d�͕T������˱����'E�p���_����Ky�nX�Ȁܯ�2��t�Ϋ�3|'b���v�>]d���'�^Qa��`?�|�Kuj��m}�耀"a=�{eTN�����>N�}b��U�~��h.��jtr*���qe�؞��l��ݠ�D����Z]��6�ͩx�$�/�>3����Ѝ�U�朂��M���#/�"1������U4ӷ�hA��Ҍ�Ӈ?nm�`�>��.�<׵M��W8g��P%[�D4����땻���2DF.���Is��v}f��x�6�W$w���7_����8�h�>�XX�&�q��R����.���0^��\d��EY*G���Ҵ[�����Hz�Ea�p�`R�Ju�Җ����m}����a���w� `sm�v_$�����S�E��O����!]ۛ�l�n�F�{�|�]>����<|ɨ�A������tMS��^�oJے��kլ������|<��n{���򫪐<�h�lL:�W]���jkE:0�P��.�K�^�gʁ�@����8JNV�)���j��d���ɵ[�*]d�JJRI��ǣ�2A�f��T��s��8A��ך���˸��I]�<�������q3s�$���M5�����eP�"��1ɠ<c��	R�^u�W���0�¦<���Qc��N���D65�Ut�{�`?5��xM,F;&x�M�>��ݵS.�Mr}�`�%��Lb�nͫy6���s��	D�)���Q ����5�	Y��K���&��E5���P���^���櫖�PT� �P5��<��
����*戟�
_�:N�p#�>�K��S�T�
��N��ù�TK�o��J�,;�z��5V{i�_�jF5�>�ʨ�lF�6���}�8�.��U2a�}w�@��w�F��M7��D�n���T&|�f6Z7W�������#�\u~�28�,���+���)�l����7W�ʩ.<���mv�벨��A��v�o�3�Ox��➸N��oJ�����9x ���Z���&#n��j�3m�F��9���?� ��+
g��M�5�j�a��V֪k��ϯj%��7�}Z\h�a.g�����	��U�w	�f��03�斵�ZϬ�İ#��.T���{��V�ڎ7���(��ך�W��� 0m%��0[�C��p�D�B*���G\Tt�g�2p����_:Ӱ�R5�g����Z���Bs�9�*<{���~�Âs���7�����2{��Vso�zh'(�*1�s`����7w.z�q�y����-���U'8��#7��\�J�rM�8�u�iɠR ��*1@^�H���S���H�	��S�=+G�.�w4��Z}�F���Z�ǋ������P��4ʖu2,\�z����E ���TB�tiL�|���]��UO���5�L��o�Je�V�wׁ�}�A<�#p5x��L�w�<twaþl��]+/�m�� 䚭�{�
�m��4fq�x����� �����ـHC�D�v�'���o6^�h�n�T8�"�U�����}E� ����SE5��WV%l���fd5�T6D4�n�ZSk���p�W[FC���u{���^r�� ��HV�޹�8�h�^շ��r#-��;5*���L���vv���K��2��yt`�Ll��$FFz���¬^�J��x�}}ѹ��/.�o�8�:#Z	=�{�~P�q���*΂�"<[R*,�S�q��3^�G�P�Sęk����C����f� �+���G|Z�`�)y�(�<-�U8V�)~�W��/b�L���AB^7R&a<�<^�B-�%���Q���җ�7W�F���S;�#�.�D6��3>a��0~�S�Y�涴�Hg���2>��H�����3��OxU�A�ba=ĵ�"3N��"�����*ǥ8:ST���/��E/!���ݻ~����|�[7���@0�
�4��
>�������ȴ�]�w�!Z��rTP�c����&Q`G!��BPd�wU���"<�U��g�_�Y���z���yj�;ɰRs9CQ�U�q�Qݚ�e�Ndc�k�w]B��C0��dp��p��p�c�+���}��E~��HE��:�'������xl�$oV��"�hk5I�yv������ܯ��Ii�$����E���1ҁ�0T��v��2taOG�M&�]~ ��[Y�_
/{���\s/��{z�/�<1�Z�9��'q���W���e�́��O���&�R�+��L.��y[�A���@:������V�f�"�ǏQUV0|cܕۦw�+���MK��s����l�,�ٴK\�
���:�K��7�0
���g�����~�M���QGq�����8�����ػГj�־Y�n/Z�)4�Bg��C�\u^�sϻ�:��{�^ӿ�6x�l+e�
\�/Y���U�����8+&�������0�Q��lX�8�'+����M];˫y'��A+�4�;>�a�U��]U5}]/Խ6J-�� R3$�*~���/���y)Y�r12�����H!�?�W��7	� ޹aLV����N��I����L�3e�<���&�b�ՠ�0�UL��偼~f��	�8����6��Il�f�����l4²�]&�|ؕc؊�����U��[�#���l?�/��
����Af!�f,}R%L�1�خa�h���
/�@���դqm�,ě�xA ���G�K34|mP�B�_f��bҊrK��6�+��}r-vG;��i���?��(8&nh� �N�p��XI�G(����� /��f�>�(lx��j9j��1�Oљ�Lo�<8fB�o^A�`�KW�V!��@%c*�:�r��i[�4δ�)7�5ќ��<�g/�M)Y��M�G�T�����H�x�J��_�kc����ɦ�m��?�-�!3�U�jeg|w�LR��6�Gp���>N�e��I
�!\5U�߭�|v�Gg.=כ&�/�a� ������[���j͎NI:�F��I�)	�.��i�V���-�I҃TdϿ����P��]�.���wDX哄>�iK:�T��ٍ��������V�H�7�v�$�N�!W����];�    �)읫�.���iC�k��ƤJL{�����������T�O���*�����<|�<@�@q�,���lAU$��TI��=ۓwX%�jO���x��ɭ�:���a�ȯ�d_�:�]����5RTK� >^C���	;qDV��t8���n1�T�k[9Fs��<��/�����qG�w������-�h�p�ث"�)����Xy\���aVu��{�y*����a7wf��]���1u��s�ݠ��*}M�u&|���g�������N���o��L��0]���@B�+pv!�4>��_qMxvH���\,�˲�����̤��<���㟗�vLp1V�Ь�����*T�jy5*��.�F[/�({��DC�E4�G����-�:����	b+|��:����.��X���Ay�3+��a��HWd�#��� )�"H����,G�Yی�v1������Z�}�\׹�b�k�*��8���y��Q��x��J*F��WaD񺨙耳�pֵ�r� �� �fM�����(����
p=�${p�+�A1|��1kڧm�(��ށŶV�m�j,���kQ��Z�L���x1��΂ʩĵl��N��1����X
G�k�Jgǖ�z�j,����ܹ7к�C�\�]x׷��<mը(
r��%"g�M'V��K�Ӱov���8���e��51�o�+L�0�r����.!cva���R'�4����N��Rk�k�T��ĎA~�pp�v;ɕR��_�"Y�5�+D�(��uK��߅�W~s���kMGQ��߆���UR.�ە4V1�����z�io�%���՜�B�)>>�Uʚz{�]��N�Z<By�U��Ft8|T�?:l��a�n΋X�q�EI?K֠!�ڳp��٩r<O��7_��� �$���JK�P�b���cD�,ߝ�W��V�^�C+�u�]��*t�cF��Z� Uɪ���D	`ק�FI&���h�n�<��o����xU{��xU�{���	Q��$�=O����ڳ���F֪u��8o�xe���/���w5�&<C�=e�vcb�j�,�y�:�Cގ?��HB��e�O����20݂xW���)�N��
^[�������O�
:���:�AJF#�����\.�K�X
i0�|��(�y�<�ċ|���hD�PBϪp��0M�|8ښ��n8���bg]l�������탮Ũ���L5�CTb�j]���_��r��Ϝ��?���e�o�j���ڌ�T���J�l��EB/��@]ƃc�q��l��I�y��ݾ)�W�X��P�=f8H�>RGQ���p�5�c��*\���\��@t�a���,c�/+r�xNx~��d��%�.��Y���#�\�"(��/B�����Z
�]EqŻl��Y�k���k�˾:�I(������U���~P�� ��~�����ˆh|1ѢَM[%*�u�z��wy����~��l���Iʐ��E��5D�
��$K�ˊ��5i(����x�p�x�Ռ|��*x#�]��*�{�4�5Db��h�b�Zk(s��.�[}{�� ��>���5�_���@2�2��
۾ͧ���}n����m�F+��w�
�~�_�f��8�K�W��-v���+V��A�������(@�r�0/�&9�/�g{qg��BU��_r�I��{��ԓ�v5eKě�����"!�7By��5�+"�":6g4^[=���i��]�]�=<o��H��U���'UC҉��S�9��5>�~g`Klw1��{dO*3��\e$������})2�>�h������Q]H�]�d���v��&�����ݣ�#c����#T|��7)�'Uӝ_���$ӫL�F++�x�+��Fо����ͮ�����h�����6�k�q����-+�&0��o�� ���"4Q�����z��K�N��VK�v���YV���/2�{bwhFB��5����L���2j5�^hW���*+�^ �h/y�
��*�(*ֿ����Τ[+ٲ21������<4!�/><�$���(�D��Nx�V��}Y-w���ֺH�E>��?��hv$�/eد��\�2">3�������x�GŬ�7c^�qs��|?o%�[<ޔ&ٸX�E�Qw=1lŽ��9��v�WF��*+��7u���LMB����`��Josp��Al�+�>���J7�[��^� W�������LN�Aa�9�,�����X�kkG�9�����{>���������#Q���X���ۇ^�X�)9V�:�C��'^�}@��W5�>dxS�K1��M��[]���w&��u��?�c�3�nH������(�����Q֩,����)�|��j�θծ�����-B��K���li��ł)��&\�y-�F]w�Ѥv$;2�j
�C���W��yJ_��Lt*L��%{�LJ۳{JFi�
F�[����J�?�!�#�
(:��⯦V�FE�%�!s�;��N����.�;�C��-�G$�gڷxC7��?�l=o{�l9��K�k�|�����[��?�"ɼ�-� ��� /���!��;�}�~��ܼ4�JX:`�B��?���P�o������g�A6A�����Ժ�K�Q�݂VA�����!�/�K�v��=+JVa�D�#p[�u�!-�R�)������<D#�8����b)�߬����e�+���b��K_���jěþ����~�s��M �w������M��3���Y`�sҺ�#ۈ��^�x?$k����!�F"s]�_��ǹV[�N����E��= �9����B�07�r���nPP}�K ��6c��bOjצ��hD�M8mXpތl#��e�jEC���>r�S��+�s��KOyб�B4?�m�0(7��٭�[�Mu�{���l����Q�J�D}��/%ZE��Y�:G��&���t���ü��(
�䙞T8���8�:���v��b���f��;z�!�y���*��b:ʖ4]Ź4ë����`����T.{�����+(�����7�հz���o��@@�L|e�1@V�H��h���j��N�vG��n���W��ïxU=��W���u�A����\?F}�ݘ�hc��#�7o���PP_�ʣ�����O��O�4Q��G�]���~�-��>�f����͛¿_Ǧ���+^,]���^�u�&av����:�n�Bwo���CΑ�ʯ
?�M�Tc(����KM�+�=߽��3�F�;��a��/����K����WY!��i�p�Xh$�dؙ��+y�fwߛ��bC{����<4$��ɫ2�V7�E`k"ܘ��/E�����^?hWg��W8b��G��Wd�N�d<#��JTU��m�|7t5?��d݂�Jw�$+��$##��cC���h�ir�2�3'js�{��//��4��Y��<f�˘�qD1�
(zZ����|�57�s�W�}z<�λM4q�b!�~��\$�V�x���8Ļ�xݧQ�U�S79���1�&vB��jD�&�\��O�j[�l��e�^2�5YR�;O�tCt7K���^b�f�NAi��Sq�U:sݧ=�Z�a:��*/!�UМ8��ek��[�뤸��Ѷ>��^��6�_�~���'^0�.�T:VvO��@��Z���u��y��7�����P��o�������9����JҨ���QQ��rؘʭsuw�<��ic��������`����,U��Zx�m��N��suJ�j��׿�|,#��d��e�.N+Dǋ `8o*�8|A��D �� ��VV�v7��V���]��h�E�󰍼5�1N-�y���/+Y6��-���ؔ^+�R�����+g1�*�B3b�D^��![��R̚�i2s$��5�y����ph6mæ���p�h�G��wtpm�� ^��b�Ŀ�ebzM��
+�RP�ui_��V�1�������̾�	\�t��ؙ�^�߬�+�Ǩ��Z/ɏ�U�X�&�!������:4I#�uQ�����V���6.�,��K��}=^9    "1�L��"��㕉��õBEg,?zC��u�m_���t������je#�����%�ŵ.j���j�/��C�N�����ǯ~X���.U�f-[*z�̂:܇S�?�*Q�c�Օ��
7�a3�x�R)�7���ˤ��b(���z�MK��گ����+��Q�/R�<�l'CR	�9�;}�B�.����xh�aA�8��4)vl�����>�n��?�P	�T�va�:�Z��:����4�"�ws�l��c��L�WK�MY��W]6�g!�ΌLK �������&�z�5ڣ��~x���,��_�J��]x��Q��=6��БG���v@�]#�*\�(\]QAr�s� ��E`��9YO�G��w[m\������H.��HC����9��k��8����Z�ǜ_/��'�[]{�99:�W�9L���0驆a�Ϭ'>%�Q��K��+��]�y�V����_{�$N�*����+c8�p�O�
��<�^k��p/���s�G�m`͋Ƽ�f_�7����#����eJ&�8�W�*ܱ������YZ��i�,�0���cDa�e�ߎ���O�׵)�&:���X����ža&�f�&U�Lp4r���E@� �c�����&d�K����q�m��V��Q�.���Q�i_E���X��T\Ôm������	{�0$.UD�X�R҃i�Q�U�c3�֪���7����7�P���/��5��!�*�~u���N0q�}��e.���g$�a�wV=%��5�aA���o#�Z�v2(�4�9���q�F���1�����s*J���z_��:[����е���V_R"9HGd�aK��*ޗ2����.�z�Gt�-z��y4��y�EG_�0m�1��	�P�w�g�"L�D�8����Q�d���k�jv��<"�+�����xϗ�vD��
�����O�`\������/M,�f&#皸|�B���g �/_�+[�^�'��	�7ﵰo㵵
}�ۢS�wd�М�5�" 9xF�C����a])�թ�.:�/:��сx��z���}�4�+����s�G�_��s�e�T	�q����A���U^Sa�	'l��vk����R�j��­2��
%��]�/Vv���G{l`�^I�O�P�뢉����L�2��g7.��yP^}�9(Qu֍c��z}�e&Ī�ڱ�N�Yu��1a
y�]|�J��U�5����D�D��m��젤 �PY��re:E-�enD3iO��,�@����#����>�k�)���V���X԰@Ӫ[�ԗ��h�~׵C��\4�m︨o��}��q�s�a���E~Sە���lP�Ʌ���t��^�7��4>t
e���W�6��7+
@�nd�3]���,+ǵ*LCu0d�Y�Ã��Q�m����4(���U]����S���NTk���NHת�N��aGH�X[S:n��m�U'䰷x���̃,S��"�s�O��D}�G��q)w��}7�S�j_� BI��k�e�I��K6d��ix����}u��F�6�����rP����_��i�I{�n��L�����U��W��Ns�~/�ۓ/g,
��v�t���`+����*Z�r�y�Q0:�]�);�T7�����'pƊ��K�(��{	7��8vO����8�)��<k*2Q�[�tZKe\��m˘H�y����rP��u�Źkz�e�'>
@F�U��u��p21�-�l9Q(�Ǟ7`_����hG���ő�8[��t���}Ɖ�˻�u-�/&ڱ�{g��.n����w{����Ҵ��/���5�Hx����.��~�wϽEy��I�A���9s�!�&[\7�Ը�9��a��nh/�*|���$�˷�W����x��I�"x9�P2I��:g��/�%��D� M�ֺ"��J��=8��2��L��.��S�D���K%��/I&����5����m�΍nR;�.A�z�����	�A�"�_�~��|�4ʹ*s�*�T�f�r|O��BH;e���ʚ�ʻ�x?Z��wcߌ���&�F���̝m��ǳ�Pp�<��)�Z��Vl��m^���ү��B��T(�Q��8��?}��3�q�M�x���&���Q]x�Oq�>O�[�V/��o���g"��h��U꟢�kǿ���݅W�=hC��:��ކWF��t콝=+$'0�y�O���C0�$�cQ���X�(�Վ����ڵ����p������t�I��fi�A�.ᄺ'^��Y0�L�nϓj�=��C�.5�|������%6N�S����E��KuESE�����o�?Z�z��T-��(�9JX����sdd�X�qm��I���(>���F$������J���8�DUX�.�^EjR�+*N�~��j`&D3K�23�6�o�#K	����Gg��k��YI����gE_�н�1��B��Z�K��Fp��,�5�a|Ї��ٰ�w/Ļ�Ϥ&���S�?*��Q,�Q(]��YÎyOT}��k]x���r��V�^�;��˻{ͅ����d�É������A67�0�S~u�����"�8{#S5 �����n�4W�]1t꩔S�<,&��i��6C�=�6Pa8�I��.�
� ��S���:�-}벟��|������ﻩ�Z�q6 �fF5j`u37^�� [5Gd᏶=4��[��i�nb.s�ld�u��d����.KH��{-��W�PU���7֣�׏��(|	�?S��������pvc���%ׇSd���9�cXY���{p�nFĥQ.*�%3{ ߺ:�q-�޼!J�G۔�����f���F�I�ٚ��uc��f����2�דּ���A���@�e�?����3-��ȥ���b�l�
���d�ݳ�5i�l���� y���9����_	�s�^�丩�@��p�5�e��pT����Fx���?,j<��5��\���o>�����R'��u�8�)��Ar�b�H�ٯ�;�v#��6�.`�a�l8? �v:e!�ձ��ؑm�%��1*}��V9���O��,�'�[��/�Ac��1���>��qvpbP85w`�c�i%TP��fk_��>��"W*�w6[�c7:��g�ڏ&��y�+9��9U�rpJ�t�$�
@��V3�Ou��Ѯu�ǝ��Abk�iw��s�d��3ioھ�&����w����HT���"�	*��"�~�\�^y�;�fę���9eF��=�*S�5ҳ�;\�X	$�}��FQ�Z4XN:�>b�5�L�{H}K��5|"]��k���I�w/�Z�4&+�Q�1X9����y]�Tu�]b)����󻷝(R��cY$7^����U�;��U,�ɨY�:S��Q(������1��x�ʼ�*��!��*�U�Y�L��Onmڿl��#�K�/NI>�DT��J\�:x�")8�Lw�L�@��*;`:�W��>ʓɢj&�i�������3�ȧ���y�J����rOkI�]=@u
a���jHҏ�e�m/��;�����!�Ÿ��7��2~�'���� �:G��fKXs�0��;�>��sK�r;�m�C���_�W�(��\WA��L3h�8)2x�
DR\�z����Z�H�F���5ʥ`Y�`CA
7G�d`�bc]%ɲ�r���shxٚ�%(0�5\U"<���Z�0�����	��� ;��L}��S�cbDc*��1�d����tN�QIG��b�BT����zé�#{\�̵T^?Z��pD:���B���59�q���	fF�g���������~?m�v�"?a��p�9�⿜H2�P����}�Nɓ����+J�%ԫ��J����a]}���G��y[=��Lwu�S�9w�.y2�gEw@��˞��v�J��ǵ�����ޮ�ZI*��#��B��K'�=UrmW���T��=���I~͕հ�C4��4���(�mr<�~o븳Th�9�2~ӵt�)��հ�ﷄb"���f%�����.�kQ@�{{����v^�� �戶�_~rǄd桂I�S�_��X���ڄj<ٶ���jR�,�c����(�9(B~��i*Z"�j I ā    ���.��/+K ��8�G�]�cy���M�vK-�<!Ư��s�����Q��H�Ȳ5%��m\�-�a]��3O���b�*%��+8o�d�KS^W��^� ���+X��q���VZXšdWgg%i\��d��1~����S���e���!��>�$��7^��i
�L=&��b,��\Y_�6��>G|�z L����5EѬkX�;L�l���Wg�sυf٠~�mdsPa��>�+�z�,�~�Q���{g'&�,WU$WV޿�p�\c����"ւ�X]��6��T丛���N;Iϧ$�bHP8t��/;@�RT��������.�ल�LOY�����q��	�:I9b��Z�Y�x��W���~��۳�\�I���g{�� !`�u�^GU��[ި�n�ṱ�]������gZ�O���ʩE�W;$�,�����Č���&���P�x�E��q��`PnC����3\��-��5^7e��=�Uk?�/�g�6�m}T#�����3��'d::O:J2&�T�@��8ԣ�̉+[&D/6�-<���T`���\��Ҧ�XږJ���'<��+�!Ls��쥳�H�H�"���y#T�J*�%���á܏�b|��<�yX>�_�IqdK> \㕩d��������`dxUE5H]�0_�Z*��uR�#���xs���4�>��u)���7"=gWC ��|*D������8;��P���_�{-��0�ܴ!�P,CUK�aoω���TOX��Ql0ܛHJ�ċ�N������Tls&�˦��ex��g��ff5!�b��c	`�'��ښ��u�����K�Ū�*�\�I6M��3Ku!��J��#*�]�L�*��`�4I��?�����أS��JE"��������C�la���6��I�XF��VU�ӓ�Kw1�-]�. ߜ��^s�T]���8ǵ+��f��7�3���<�p����%(T{�v2��0>����ߞ3~ɥꃜ���?���i����#�c����'��u�-s&q&���
=�;G6f�6��*|�_�-��~���oԋ����)����G��@�q��5荾�N��`��(�;�B�M��Q�V^��re\3�uL�2]V�&���Ʊ��cb*�Čω��Op�d����*�U�~�^�2���\\�aR�����OE����T�����1��"쀆��y�w%��K�&�ŝ��6f}_ZmZ�{?�Џ��>���S�]���Q�>I$�� VA�	b�FE��lVM�l����V�cњu4��S�����bF�K�H��s%'�_ܽƒy�p�2�@L�f��H� w6��ݥen�}E:�v�tB��3����=��������6k����u���\���G��B���*������v��j!�6D]g%�O��nN���xjW��ӊ�1�����6�K[��g<R��ݳt���|�-�$�z�l�(��]���v�/�6��SoW�}�L�����w[�{[�]��*H#�$�2�J���
Fw���~ݪ}�rJ����mP}���w�v��{Ӿ��K���Wtle���l��L��-���/욣��d}�(��9>#-��Gѵ���ϼM�)}E͒�	�!�6F+��mh���嶠�a�|������<���=;F��BTN��e-�,W�?i��N�P���C�t�T���8>�<�'��~���ݐ�H���c��%�$�!<E�PN�hk�����lN��Q��������v��1��v�h�,�/�	�JE�׆�X��oqa3��
�Q4���'p=���L���Ή�U�3!k�nz	�>�s��[��)��iӐv�8|4F��>��^
R��]����ҿ�ii����1�Yˤ�ȗ�G+�6� ���Yb{�ɲI4�pGv\�}D�f����c�w���#����m띢�YKu�G[���:�@�8^��3�ޏD"*X ��
��3a�Z�Ű��&�IW&�����g��pC��]v}ϐ�Gy�}E�iGK��}���Z�^2g+�\ %|�I6>c�a@�ޥ����~�{d��-������Z5�$�<�����A\�]��8~T�M�m������cَ�e����:�p��F6��Jw0�7���vc��RM犔��c`NH���D2�7`*�v�7[��#�I��9o���B*���$�P Y:H{,B�� 3]���I���a��ޞV�vth����8m�j�7��: ������"|���{.�M�����=no����O���S1ȕ�C�%b���L8��N��ښ!��I���3$7Z��ΝkA\��îMǑ��r�T����z�Q�dC��G��4Ī�FV��RY����4�?,��yY_�Z�L��se�B|*����b��Ҏ�ãd��y��jc\T3�;�J8څUi�V׺ig駀sUK�c?�m�L��	��C�i�$x�`��$�]dM��ɨT8^�k�)���TnV���2���n�QY~g�e�[_L�\���8i����ں1�H�\.�s��R��&����C+��+M�A|%)٥���q��ȏ*`E�|����5���zb琘��b��~����H�`[��m�:�:ͺ�@@�*1U{�K)\4�7�˳ٚܬ�'���ԨI)ڏ��Z�k�wg�9
�ۇ��p
.&�נ�U�iʓz���\����~=�:�5p�������\vkڭ�s���W�N>#���"p�ΜҎ���}sF.;����s��ı�5�jSKX��Z�p %��n�^vwE[,K��ֳt��9('��J�W�	���#�k�����~y�6�wo�s�RG�3�ħrn+��(I�_{�e�F������xK�^y��I7�v��~�O���gf�O��]�����c�U��Z�~���1�V�h��~����Va/E����B{������G�a����u�٬�E�k�˜V���Gm����_�č�г%۶�ߒ�6l��x�uvUU'�)��}�ӊ�/o��|uK�Vc����s���� UL�v�d���ɒ�b�M��#O�ֹ98�[�h��U�Ψ����c`(��8
�ZQQ^"��He���`�pWA�3�سy-:�	��My�����a��Y�0��Y��GT]�r���Z׼�IE
��C��W���W~?b O�z'j0*� o����7N��64��fm�ɺ<<Ư�g��!NBw}r�&g��k� Jxy�;��p �t�I���S1�O�;I�x���>��kd�e�*�����S�tѷ/�����M�p_�g��-S�����`�����I�$+I�x�^��LV��5Y��H=����1�*w�B���?v%
DD�Fa�s幂�$^��P)j�.'bD��+�7��f�,?�Y{3���@�����c�x��
�Bv9[e%���]�o�=�t+��e�RuC�2�k�c
8W�lk��h��������I}� |� N'�XQ�#Lw_�[f'�J##nLJN��%�L����p��6�^�̤�Ժ�͚>f�cx��L���/R�m�$O� +�w���4Y}�A`?����S�Nع���kG�"��s�Q�od����*	��ٚ�)�M�,�Cm�0�ܨ��δ��1����#d��U;� h�-�L��o���W�!s�"�d2�J������)��
X�>$
{@���D������=��T�ࢎ�dI��fs��ޯ�k�W��l��(Z�  l�γ�����y�r�Oi��9]�����j�����s�u~�q�u"��3aJ�hFh�۸���?��n�*i��g����l�ۜ#[rLi���/7C�.���R�/�H�gfH	'�����j�ڜ5F�rq{���n.�e�Q�N�� =����[�bߴ%[a5�e-�'���r�Q�smN/]Z\_F�-��gΆ��Q�&:��6	����?o�m�Ő���	f���#L�rk�@�6���3�Êr���Ϝ��y��\�@#��gL4����*�q��|~�W{�[e��&ṙ�|�{�!{K�z�tB�@�j�UEf��iu�/V�Z�\����{�-Z�|4��,E��W3���\��    �U��İU��Z��,̲��:I|sRy�������  ��~X�7TE}����w�NW�<����Q�4�W�O��|��6���!���)( �L�p�Ԩ��&[�|��y�jέPM�?7�]�>q�_�,��y�.���7{����I���`K��"��C��i��%�Ν�@:�n/�z����
!�K�k�Sa*R�˘����M��X6���r���[+���hM=N�@�,�6+��>�u���]��ʔ��dp�iJ�gi�pSt��B�7Yu��Տ�{wR��P1���z���_�cDA��<׺p��bQ,Vo^#	�V�s�M�Q8�?EYDf@ +�*�Qjp�G�qG�y�$���J��X�ta*�f�>O��@�V�-�qbw\Z���?�!*��p���l���_5hV�^�ܙQɞU��]��J_�O��i2ˠ�I��'�$Q&�a��t�IA8�,[S�И���ۖ�5�9�Ul�Zj���d�2���	�` �3�uK׆&|{O�b�ԝ�6u��}4e�>�\�F���I��YdT$�(���5(~��-;��	���u�j��>�Z
2GU6嚌�K�cEOZK��At�}��E�L��7Ц�N��[����剛���p�y�d�J~#��אKJɸ���2�蚸,�_X�;_k:僕��d��q���������K���t���������T�Ũ#��Q��7���QE6�3Ç
�Y9��|�`e�wU~�E�;Nsv�����G����Z���|��n�ř�ݚ����;GD#�ZD'm�g����L;��V������l`�``lp��s�� ��1�}?��Uҍ'�>�o�	{�]i;U�#k����������9=��f8�/v+\��#t����=����X�%���M�s���~D��R0�d�<ޚr��,Kע����d1���A�9\�O����g���BZ��>E�A���#}`�N�:��5t��hdupQ�wˋ$[�n{��N�_�-+ӣ���C ���4T_h��,y�u�:�����X�T��?��~a|KOֿ�Q�t���Ǥ#=�暞�i�x駁f�pZH�IuMt;������hn1V�D{4��d��i��^�W�<��(:�������� �LW����|�W2�o�&)I3�'|��,}�9�zqrw�P��K�m �P���"��ˆ��&�mq<�6g��E��*7���g6��ڔ�R�N��}]�U�eX�)�0[;��)v��Gz�D��b��|fe��p�aF��?g�XV�3nCм��0ESJ�vs!�f����tw��F~.�������yk��]��iEWX2p��a8Q�2����g^F��q��K��h_yʖOS�9��>lƝi27}�j
Q��wt�TE{5�)��N|;Z��UN��;OR�9lS�Zy�	a��áF�`�&�W��s����/;�L)��8|��������7>Ql?x�hɈAD-�ϥ��ǂ���Ζա�"=H9���U,wđ��*�8��֑'�+��ήJ N���ֆW�5��	n-�p�o��Uh��?즀˖���B3�"{��Ӫ���|���^{����^�E*�c�����H�f���|�/K�<��ɫ�֊p�Tԫ���f�U�-��~�3��"��E��Q<U�=�9��z�+kV� i ��a))�>3�S����4m}zX���c׭��A���~|>>m-wj��Ǫ˚��8�KN�fb��J��u�ӊ�b��)�����gR���fLq���SB&��֚��m��ةsKYP�������g�3�Oqʗ@y����_}�����BXP���_I^܆�$ds��~����>������`��53��TI�e&t�	�¢>�7�5X�ɂ[N�����M����	��c&��W��f��!\�͋��:>���zkO����0�\P��������j�p�s��R�"1�,J�R�H�Ku��J}��R�����|A�#;�_��U�����3as�%��i_�jw��G��^�#-�្���^E�S!�]֭�8ޥ�R��W�8���>���r�-�o���#oÇ�ub4tb�hak�A~O:`2����cm^��api�0�jܡI!���dw�cM�̲gH������l���rs�d��N���Z;D�2���������2����9`BU.Y1%Wј��Yq��;��Ӣp�����L��/ɼ�
��n���ʏD�Ƨ$\g���-��3�8X3�yў.��`�-c�O�z�x���r��pN��s�e�e���Q3���|(Xk��nH��V�Vi�BUg�\U[�K�w�8�PJB�;�
$���j��.�&,���_S��.l�4o�JU��g�b��to�SN7��-f���~��H@��kM�^��� ��D8\o�β?b��sz��|W�4B��֠Z�)[
1-ՕYV�=o�vb��e��s�\Uu��ò���i��~���e�v��ۦ�T�Cs������Up\E�����p�X����؏������;��\��nIx�w/fօ�A�g��P��[�~�ۑ�o�M�K����jH���P3�{��R���O��u�/twi�:�����Z�ƯL�ƨB@��GXsB�Jۨn���\�A�M꥘\���?2����i����:Aj@=�gZJS3��W����9���pN��@x6��g�������7����lS��g��\q%Ta��Y!���Ѵ��0��:�-��t�uEǾw�3_�O��a�u����X��<=?�eX:ׄ]�A�_r����ZIV�<Jw���(�}�ؤ�+��~�lW:�f��@�Hi�f$8�0�y��k�ޫ����N��jA饱�g�����d�����Y���RM���0s�?<�#k�[��9�iog��?Z��v8د!�`�{}g�3�e��j8�|� ��8��;���[��ć�t���s�s\PMͻd'Q _L�8���m�����K�7�s�hm6n��_k%0�cBbFR�>��$��?!�^�������31�L$�E_��+��Pz��E�ݔ�F/Z����_�urw�1xV��}�ዘA�T�;����.�����T������<�d�ƻkL{)��w1Vq�d#�]��"=��]������Lt����69���x�,���[4P>�0|FX�]�Wp޹�Lq��Yl��O�pB�SP��x����;�F��H��&b���PZ�Ռ��2&�7e�x:�
��L�X�vR
'�]��H=�F����DQ�h��{���1�̦��{.��b���2��z
��K�q��j���V]���H��k5�K��#qJ�ﱃ�Y%J��3=��n���ws���?k��a��v�cݬԷ�̜�m��0��U˘�q�D��{����(֛��i��5�������U��f��Z�0	9���D�ض�Kz6\��0��xڲi��Zi0^rr��T��+��-!���fd%5eQ4hW�Xpw�j�UgZ�]N�^��=��4���������XX��>���T`�4$Zֹd`�����V��ش7RkPHZ��@��0�+5^v��4f��kр0C��ѻ=���?�UGz#:r�V~f~��M�2k��9U~�E�]�#N��*u݊�L/���ϔ?l�u2�`]��D[������\PEǇ.c��(�}�OW�Ǯ m�m�Yӈ�:�ϔ������C��<H8�~����S����&����ЬT��y����f�P� ����ꪊek�EP��,I�⪒+S�q0r�$�X����Q2l��m��~mK=]�J���Jǅk?��p�,I�ڤ!�[�3�����y���߭k����~Ukک���+�G�?�Y�tB��B�F��L��O.���l
�aglT����ܗ-;�#�����@�|���}����&��Hj!�}������LI��DLw�NuO��=ϙ/��N�� ��RC�˰Ư8�xDJ4vWA&ɔ PJe÷�>�5H%��E{�����j+n8W��m��0��̄1E���GzV�ƽ�N{�0���~4@Lj�1n�h�Ԣ    Ĵ5½*�@�{�һ�)�M����{� ����\C���<]P\ͥ<�����^ �O�l뉈d���z�4����\�V�:�BoyJ�a�l��@�x�c�'���x���&a��������uq�-�xp)U�Uw{Mnz��$���Ej�.�ڰ4Ksd�G���X�����
�5:��L`�Ǔ���|���,��ak<�ݝ�/�39�" ���<pa��9�I�w
�d��e�\�em�,�/J�P[���R:�ʨ%K��"�qz���9�l�<
l�XQw�F�nW��Ԍy�'��{a�f���~��X)=��H�x�ڑ�wPn*}��`�����N�b�(���7A�p3�iɥG����W���� P��(�n�m�]������Ф!�
/#�E��e:UG��>r�è�<=i�כ˩���xkM�^�����i\ZE�u�L��Pǁ�k�����>�����CF�!"��Uȥmtj
,�2�4���\a�	��5���{K-�&6���ގt�-F����=����}�����z]'S�z�t���z4����ǻ�I���HS]!���=ON�{�>S�'>mtPs^/h�bT5֡�=V�!!�,�b��R���� �Q�P,��4SU�5թgڊ��.�aHu�?�g$�s��0�G�.�t�������M�;��@��Z�>���y4�a[����0����i��^��R~��t��1�-��<��"�y�1wW�������	�Ŭ��)*����ޭz]4����o�C��Zc�g�C��{���W�b.2߀�`��VG�0:ܶ��1��� ��!<��(�r��J�΋��Kd�q��7���.����v�R(n*/j�:�Y���6�&�!��_�+�*Yj-�v�t��tE��3��r��X�l�VQ0���ٙ6���''e���K�2z��r}�3� �C��5�5�w��?7,<�T^a�������gi{�N��VQ��v�@+Zɸ��w(C`�F��%�H(יPCqc�(�Z�J��kD�嵞���9<�~��M�fMJ�I(���ϲ�=t	�A��)FօGn��䎈��\��ǂ�!��T����ö<*�iXt�wjF��πV��w8Ĩ�C2�9�½�|�0W�[�\`�ʥ��V����ڛ�C$m�MbPa-{�:��5~��^���ӾD���1�8 ����!��lk�n���$����,�+�:㋯��aٙؓ;�6
� ��*ӝ����Y��x�vhp�7�l�;�.�p�Mp�����Ÿ-Ү�Թ�sJ���C�|H�5N�2eG8[+��ַ�Ů�}��6�q����ˣ���1�i(��ׯ��yiۖ	���;��S�;g��n����C�u�Q�D���F㘪&�F������<˲���gn�3� ��:G����_ꙧ���R�JC����_�p!�3��Ap���Yz�����b�Zx�[����]ť�*�q���O�0Ӂ�$�S(�d�)�Ĺ�҈��,�M���p��˅Ui���:�*���pT��f����Sh%0܃�u�y�$;�{L.xc34)����)%WA�?�8|���sQB	�&㗫e�(�r��՚�ۖm{�,uwV�0=�s ;���~��W�SC`��W�ڑ��P<���=M��#elO�����V���:3ܻ*��r@=����f�� �����+���Zs}{�{�2=�t�Z��
�ȑ�X���r��@�RYX$�N��<�ƨ�ї�x>	��:>ȑ���rsx��+#֥��1�-gg,=��h(�m��}��+q�.��*����25���/Cg��^3����,�<$��a7�z��d���5��~6)̏�a�ć�i('��>6r�(�NiZH}�� �.��>���>�Ur��z9>xxf�3�����Huʽx���b�7�욆Bg���5�2=]:f���,x�͐V��������;����psJ�o6D�<20�{�W�N�J�k�F�r���}�����X��X�����%
tE)��5�`�:�p������6z4��c�(���h��g��/��\�c ����}��T�<�C��A���)��0%�9G�!���s&	��_NC3u#�Z7�eQ�J��כ�i����w�~t��Q��q °�5����M��ݰ]X��?~���e#��9l_��谥2���c]�r>΃�� ��%\g��$&O�	�Ӹ���@ ��
�tM�A��:6��Y��+�Γ�<^�Wq���>l��6/�-"�l4�O�Y�7]L��Pk�U/�{6�T�e��� ��/��X�l8IIW��榷�.]���Sk,n����U;��l+����7�aD˾-�'.G�.�v	ۛ�i��q}�:Kk�&��*�e�k�����*O�x����lP�hXz��4+�]���v��A����D�B ��N��W=�W�l�i��Y��x��.:�}7���a���#��?:�o��8;/:`Uֽ4 �: ����(�͍�Z�۶�5
�M(�X9� ~O�p$p�Bk����#���Jt�)�lL�7:7�v�سfֲ�5N-�3ħZ0�%A��0N`d6P�Ttr��"�� �=��ѹ���RM�mw��n|�4���Z#�ܕ¼q��h��#D"�=���	� (1�wk��с�<�&����D�V��[m�����#�X���7�m����':��a�l-����l_���6T:۴�`��F�+�]�ϐ_&�S@�Mu���~��0 L��	�,~z�Wv������4T�^l����Q��vؐh��Ѹp�σ�t��I�y��ycj����j��8ީv��lM���>D����ڂ7��<���-˼+?K����t����^�灃��FTq>$�{~����4W��|�#(X��8�HY6���Q�Tm�8�8�]ɠ=���\�ie�h(F�Q��g�R���^���F%Z�W�Sc��o�e!�_���>+e��xﲩL_gs=\��!��x���CM=�}�͹xR9 �`�WU� �ҁ��P�a�aDg<W�!6�a�K/^�F�6�5�n�ҧ��7����Ã���d��;W��+��ٔM�ug�����nm�u�;h;�O��j��?%�jv^r����a[n}�t�]�5��1���^9�����v;�8W���6x-��������e���G�u��=-K9u� �0S^��:�OM�!���ĝv�wj����s��'����h蝝�{ߥjHOn��@�}�}\M��6�6���>��oq�*x�C�HC�σ�,�bB�q�g|�@J������h�v:�S����G�`΅������u���8�[��Ӎm����G��v��Я*y�q�$m2K�Sa����v�:����,b����a+xw
��:��>�X��E��3E�\��
Ǧl}Y��TQ���3����ԙ�3$��"�؏������	8��b�4V͌V�a|�Nof/.���43Ġ��
�F�2Ў��
`��"�/:}�P:��Uֆ�
�9����Z����f�=�E��`�A��3�Y�K����*CrE�g����xW��{ػkT��;!����rq�}p����C��Q���T����"[)�.�C�p��p����p�oӫ1G����BN�em!��M�2]�@� �`�'���;���z�&U�ß �}�z,��؉6q��tl����3qϤ��x�H�-�%���o�KU���HM�� �?D�ֻ@�0ҔlD�0]z��S/MB���W<"�ǩ7�O�����_6���Ro������]��I�����B�l�Ƭbŵ^�V���ȹ^�cQ��|��x�I㕰K�۷N�Y��Ν�h
Ӛ��4U�v���$�#�-�ɄÌ���=��P�_��F��栗m��6��M�p��_�-r���
����W�ǚ&���5�m��YcrO�.�� �bQ�S1RX��
}��J���������3g]�r*͛b�V����wf-�fUQ<�!���H�V�    ���.�E�0�7�m�����K��L/��x�a��rt`���|TC�Kb�nz�g�����T��o��?�C|v>��p*��\^oA�;��e��o���MuJ�c}=�[�`���C@����"�}�0�R���$�4l���kG������k�X�@i~�Ś��됻�-�h�;7L��s���]:qh��Rt�j@}��>K;�J���z���i���>��#���\����1�9�F6pL��u��b��m�k������w
���9��6���K�n�$�	q�u�ȏ���3�O�rݿ����[���6iV�j]1:t��*�`��W��@���E�t�&noQ�,�Y9ڟ���_�b��3N���*p܎�q��`@i�y�I�һ�q��e��9���ͺ�����3�k����.� ^����ˎ]+�|�S��H�^'���W�������������n�Ս7��)����� !�L.cv��x^e�Aw��@�����K�P����{����q	�$={%� M��^�Ln������@90�������"{��)4Z�{ײ�
`X�˪4�����҅��C�O�Nk?<u���J�U'��?�E|��]V|V�UG]{�l�����
l�@����]�(����v%��-�[�}�;�:9?R�"�{v��ܪ��HC�����j���֋��+.�v�����u+��W4x��T����������Y!�=(�H#��}}�����n����Ph�ߢ�����2E���X��@�"뇆��5�6+�5P�Aq2�cQL�
�X�.���s`�m�S��8�GН�@ӣ���!Ϻ[=����ը�h
�����q>P��|��PC7UӠ �ɳ�@4��N8����^�L�Ft�D��&q�r��J>{>P���&O�L��^fPM�@Ъ��Ҝ�)Yl��u�<�N{g����M��_S�?�u@�_�{E�C����sH?u���TN��zv�]B��Pp��L��(�Z�_�ʝ�Jd��u�C����]ذSY7H� ���������� c�5�D���@54�{�]��9���|�V���n��#(�C}h��ۻ��ېf����aُ=�̴v����~���ǹk�<�3��_�a �D:@��G�&���,?W��o)ZO�k�fY>;�B�\U�۱c���b��b�ES��H܌��&�%Tt�� �p�X����d�e�r��}z�w�a�9Ϊ��x�d���˂,V�l�N3�ޞ�~�vW͡'t��~�����:����~D?��:@������_�"z��ovŸl�&O��� �2~I���b��k����a���ʪw�z���N��#@�����S�O#���	[T��^��*��˚��jvE
ժ�>j�ԭR=��~ ux���و�{�Bk����n[O1�Y�������4 ܨ�ۅ��ƻ�i��L�+���g$�����.)J`<����O�aR]��/n����H��k��*���z7F��_����n9�6/�B'��O��I_��؄�}��	~�v:��&̴��+ˣ���*�V��%��!s�	Pqrm  lt��U�+P�̚5@-�7�IL,[�X՗%���"֝�)ҧ��&$�������A��U��a���Kf0��ِF~a��6���ۛ����iig-D����1X���cU�����I>,���&�\��SOKK��n���Q�9�
��W}U�'�V�&�'յ�	6�2_;[H׊�D�
�����]�vCR�7:��`O��I n���aA���)8��is��L�9Y�;�@~�C�b��<>L�́Z���n{�}sTun��d	��j
�Z����� ��P�n�:��~�L:O�m�=/���| ��P���w��J��y�i _���̔��.E��	v�B�2\��)0y�_��3�Ҿ��f�Ay��i��!S���֏�ͤY�uwڬ����V6 �7��홵a�S�f�_s��k� ��=g���̤�m�\?���q����_!��T���uj�i �3��9�KT���
�J�[3�}3��+��S�1�|�l9I#�ֶW-iք�~sj߮���#���Gu �̆�!]0d����_���a���<9nC��*�͍}� n⽛��y$��B�T�gS
��ت���t��݆�V���xIߜ����������ao�YS���ռ5�"Xt��\�g/"W�CW�����<O���dz��l�*�b8ݦn�;������cE��_�R����r��%KA@~52 U�{��d��nl����f��yU���6� -!s�����HQL= 
�<`Kd�E�Sv�T���q�8�cuY�o��,�A>`KH�ցZ� �X��F����� 筆؛	�q�e3�S�*i�'z�jm*��ڨl�t~���3Cb<��St@!�&_Leg��:2�|c</PeS��F=���>j���M6��fB1�:&˵�jA@bh�vfm3~6�a&�f���֙.+����m����'}Ut5�(��!�a���c��/���6�ݡaU��9������=�#�iL�Uy��M���Mih�VX�����܊Tm�\IG/��}�=�����E.��l;�{���Y�d��s�o��{ћ�,�=�-~s>�nѾ���q����@�Eu�G$ܨ�����z��}��C${���N���[�,d��T�;90,�?<���Np��P��cВ�G�n��I�N�z��e���b$^�7G�Ѩ���S+�m�T�T!�.�Zy-�8k��[��0��7Ϛ��`u�±ƀ��|���*	1�^��/��@�O ��Yz7�X���y�Ţ1[v��7wg��@2���M5n����� I��Y~{�>f���\��||s����׹��E��t�__�'o& �f_^�O��6Q�aw�<J4hu�b�օ�p���Kb��/��`!��� ������.����p���B�t*��-�� >�7���3��{�g�]�fM��L��{���+T��2u.x~1mq}�|χ�SyF�{<�� ��a��dv橚l�b��㨯)�+Sɩ�������磈����;�A�hH<"� 
�0l�P3�X�&�#��/WW�-��[Zav�} $�Z����R��v ��MQ��H,��\4WE֬�YK��l�y�Uj���Z��U{Q#�Ս
%��>ݰ��9�#ڄY2�Ot���$����lh?-���l�6��E���5��(���~'��n�`��g���ۋ�vnk��>��z@��U�ɹf�_�������Ż�k;}T�#hA��2�-��k�c��E3�<|��O��:�;۪Wr�xl۩�'�,�˘��
���,M�Sq"��j��˚۪���'�[��>�=Ȉ��W�u&F0�κ�.E���W��/��
~�U���d�l9@�������M X�IL��N����IW��m�us�(]�(�f;#�7� � ��1!�J���b
��_Bʦc%;ci0��­�Ȩ"#���inG�6GZ�>`��:��f�%������ޒ�ڑ������7۶:��7��G}��]�E��L���x�ǰ��I�,p2�tF��B�s�YS�\z�C���Q����S׋���P�r
n3;��2���N={���t]�wk�iB��%!e�б�C������jᏋ��̤9��c�������V��ͮ�:�75
Nq��!�{+R�4�`�aq[ofgM8c9�תsu���Pf��������חb������M��=(��EZ-ok��R ������ax��P@�~Ŧ0mBw�b�HXLe]B}���y�P�;����[|�暚�VO�K�
�W|gbح7T%;��P�	����o�cq��O����~�|���<�N�i۫ȉ���*��W���<P2�e�ғ<vsrg��p,��]h�zor
���2[(E�� ��nS�%��d1Ӕ.D�Z�N���ph��.Iy�:��o}Ι�������I�I�gMVGwc�:��ƛ1�j��֟�|��dN��{��y=zM�GO����.�Z�/�5��)    F�|���r�q6[}����Q"f
^!<#D0���L��Xv��4b�`Q����6:��;sM�E|��F Z� o�Ę�|C�8M��x����!ַW�Z��+�$��C5�%"�x�Ԉ�:��* ��̀!�^_&����e2-���2�;	-o�Z��� �J��W{	���D��S/�2� C��d��A���X3ǧ�s"�5]6������#7<������g,�u�ugg��b��n�m8�*�M<=�A�ރ�����ŊV8w
�<��jJ3�h�:R/�z�N{�y����ZU��7��YsYz��7L��u2��#��uf�|��޶'�u��w=ux�#���:#� �#K@��fm�&ѵ�+�%�6���X<֢.��AN"w<{	<�S)�mR �s�F��:]��̧�n1(�����z�F�l2i?�}��� ,�n�^	'<]z�L�;�(�h�=D�fW�uXh��}l�7�NKpt�`�aS��^	օ����Bt�EMȗ̔Qi�-b��������#Q���� ��6Æ�*Ŗ�:kU#�a�Wn�g�������]DM�v��H;t�,D��䃤n R�3���̣gʲ37�HS���-�K�T\ff�b�ZjکN�}�H�!�@�P��i��W��T�]��_z���vsk�r�p�=k�w���&��ug�i��A�5]�I�`� @�3�Ձ�F����v�v:��#mu.i���ך7���=����ƔI�A~�e5Vo[���}x�s�un�g粽W�7���j�؈S��"
�!Bggy��[oS��وW�|e���h}�0B.f��Vֻ3qV�b�m����B�=�3�[���x|�ʍ[�{���g�$M�0���e*JhfFv��U`C�T���U�=���,Y�:��9I���B+I��� �$�T��\M���H���%�i���,�c��-�n���T��͓}�y���Өv�;w����;���v��R�l���w��I����lK��v����juz\�~Q��͓}�&4�w�{f*w�暴������{p�S����z�"���湾�x㱫�Σ�	~L�^ �b��u����fT/^7��A#��EB^X�J���do�w_�nh����J�?+��uVv�B�b�t�B�I�C��J�;e@�K۳-F�Z%k�Q�;��Y��aS�&xTۻN{�6�l\ky���������&3������*f�4���W[;>�q�P���W�tmxY %���>}B ����a��}Ϲt�� ��\��T�v[ݜ\V(����+6�`g? J�H��,��J,Ǡs���8[���^<�U�#����z�Ԭ�j8R"S��,!#k9��s0�~���b3��{v���4Bѳ�ƭ��\���Rg1>�/�3�hN8�5�H?HN�C���O��tc��=�e��xZ��M���g�eE�튯��#�B.E��KpF;o�xȊ\n������ ���C"ڻ�ʤW�6W��Ӻ�(�ceYF���>`J�H܊��� w���>���B�5:���>m4��I,��> J�H�I(���Hl���ʳ�����jV�<R��S�N�L{=�D�۵�ET y&%d$����;֙���	�g4���w:�A�'��Ӟo���]?S~i2��K� &!���e����A߇R@!�ae����Y��5t��~�8jiF����5��NBb�b�����������W�"1T_�(-d�o��qZ�D�S�u�M�u����)
}ȱث�w��K�\���{n,����k�V8y�M��*�M.��n�M.�����M�u����?#k��JG�s���[�֞��T6To��t�0�m8Nֻ�z .3��.����*�v��L\`P]�Ѧ�;�l��Gul��	!�V£���5Y8CV� ͤY�
`M�Q�`y�!��νW�ɉ֦-!�7�IV��m�A�-���sz� 5�F0��D���(*�R��۴[.-ɤ����:���D�A�:����qb(����߻,���)���P֏�"���}�^@/d>y�k�K�����G�Y ��C�
�U/%5��`Y��v֘y��x;�n8/>�T.�ىz�$)PZ���Y���K>+z�=z=���
��ٵz�����:�D��=�������p'4�do5<����K#1��V�����1o��|y��ӬćS�ڻ�'�����v�� I/q�v/M-�b͇�	��&�8<�`*ӀuGQM�Q��<#�D0k�a]��V�*M��aM)�՝y���|���̿l��U��De<��4](`,g��,�a���{kR蔚�yO���X�$B��_�x���<J:�%"O�t�X��kx���6�C���coqU��dG*�Ju��+B��FOTRgo�`4Ut1��	��0+�g��v��r���;������;�B��tTj�X��t<l1�<�5-���k*&=��`�6;;��Ù���P���9���a� �%H�!�W�6(��"�{�Gg�JS�[q۲z�b�}d;����>-��yrp��ᷭj�#
�k��Ӑ&��M#��@O��?�?�r���/��u5<�-!sކ��:�XS~פw�I�k���mgB���}��w�E�_q1��F���Q�`h01���u<�5���5F��G~���m�0�a�oa=*����t;����}�����b*<�}�[]�)4�}����k%�#�tT�(V����!k>7'PG��\��On������}�Ǧ<:V�1�C�4�_Tn{7 g^�vL����[�|A'<	���= �����m/wu]���xR8)�,\�|�:�@�������r�X�u���v\ T��^�U�μ�G��Y���ΌB�$&�i�0��0���c` f�pܳ0WӀ�P�o֙��ɩt�����h!d���ԟ��M��[	�g'�a�F�7�̃�u�N:��pT�lL��y���ݸ�2�E��	�����S�.w�N��HES���ySEw�'��7H��+S4U��?��U��L镻�m�W�i�D�dw.�+�����\�s��̆��	�!��κ�R2=/����
��i�uk�+w��+�Ʒ�=�`D�'�9�S����쌥g��v�0/�b�їݥ6L˵;<�|��Q2�ݫ�xЀQǬ��%m{X�p���zl��tW��-�	����55p~�[�T�<��'Cs���y3gѰ]�N
�
��Q��=��`<We&Cƚ)kǰ�	w�<)䏆��C�/�ڈ>O�y�tϭ�}߱Kc���o�1^C�O�C�.��Yl�)�8]�z�J�۹R3�?��wq��<�G�?�,��T��f�)�dS&��a7�6�d4��Jqu�	%��e>ȧ�����M�)C����$ʗ��D�8-�/��b��6�w����]>�g�����m�4�!A���0�IONU��GY��5w��[�{�+�EЯ��<9��BQ� _�oEG����m%�)��~�X�<�1�ϭ�+��s��hd� /�~_k3J+��.u�~�����uEE��;�xu������
��Q2wQc0�G�}�Qm���bY|�$�N.�͆���4�U���Q���Z9���v�>0$ѯ�_�GVct��6A�p@�����~oh�R���W����[�{��e�������gi���Yc�*���R6������C��L���x<�_l����Ұ��t�P��x��J�1�Ҥq.�v�u��V�lԾ�B��I�C#剌E�+�@���1�H��er_w��(�ӑY�޺D)5��y�l������25����tX�n�Ҧ�yrJ��K1�˲HH�W|-[��D�n��)��Fނ�Ҿ혤A�M"۞��`�~�듺xKy��r�+F{h[K?��ݗ+��ئl�E86G[0�_�����Vp�"?�d\�, �˙�e�:i����+K4<�~!��x��B�|ѽ���~���&�!1^����i%���G��x�޻K���P6�;���K��g�G�8d[��bb(��Ϫ"�I    ��JO���6�q���+���� �(�EDT��{ ��IVo��,���h]��nq��8��KZ��o���O�*�d�0��+�	��<��_R���OS8I�jѢ}�O��4���~��]o�W����H"�w�k��d� ��d�,��4y�t�&�{,O��O/�>i���K|<q��QI��Aj��%;4�(Q��J��a��ѦB�<D +��!����dx2y�3j���s�̜���~4K�v}�4��pr&>�gЯ(W��6�ć$ �����W&۪0�_c��I3�y���M�[�;�W�y�ĪJ]����C�~ȯ��m����DR(̊j.�~��5��T�Â�X7G�z}:0�F��p�_�>�kX*�������i{�"��֊kz6�y�Dߓ �<���Z#�����`Uz�IK"ɍ�P����߳�j��n��l`S���^g����ѻ�\O�` ��47ڃ��k�a۰��V6�Bt@����U�w�g���/�IUm&��φ���H��dΛ�<�F,7�Y�w��m,C*'�{km����츭Ї6a��ټ���J+��R'���߰�X=��L�8��c�=�mkf�^I(j����ȅ�#>�>0+�?��,�I��Z�DO���.�B\|�����yj*1�<��Y�#RQV�����4��f�4*.���V��Ë�*���y���d������*x�5%�[ ����Q�^"wa�}u<�ﻭ�F�Ѓ����Z���J|wnWu��,k�v�J����~��S'lu��������<�i\3I��x�����Z����1��_��Ф���λ�����)M��Z��1�گ�ߴ��(gc��%!�L=;*k������kVJ���`����4~E��>f�^�ƁG��Di0C%�`D���6�}��(���H	V��1h�B��E�Ԋ4F�f��~1���=�n�$L6�n����\*[��T��`*4 ��z1ޞ�H�:%����<Q��>��<آ���cDY�Yt*�x1j��jؔ�6��*� �w�9����Ѫ�Φ0����ӱ4$�%����1r�t���gFB-rCH@�b�UY�9��m���ă/�pëg-*��%��r\������UOmFD(7����n�,����7�C�0�0�`��L��L�� ��ț��6���EWʫ�h�焑P����P��ހ�a�6��)�t`�V{wܥ#�fp�+*jmLd�m����9���:�#�~M丠Y���������G�o����Xl��mŝ�֖7����y~��ހ	�N�P�/�`~�o�{�7��$����������� N5tUXf|z�g��z�-g��fH[�2�z��d{��2B�-! l���$���/c�P�o�7��&���eP2�{L"w�6g�Q�Bļ~�"BY��B��.5,����Z:J+���'�j������y}�?E����n�<�X�zln�Ň������2�+�����D���1�1��X���֔Uqq(��ƥ��z׮���<����ΣZE��`�O�<jH`xEE<�bs�uʮ3{�Iڹw�E�$Ʃ��z;q�y=�?�U�/v���Ui��V#�xs'��)\�ɹS=��ּ	�[D�ůcLvlnK���k�na>�_��O������(��TXV&���~R\���]=\=�U"G���x̹�R���������x^��_�I��RR4�~2*+�MG'���o��묟��#����<�[t�YՍǰLxo4g����a�gu;B|���Bf��� �:���
]S�� 0��t@��a�;@!��Ya׵��R�f�fo�?���R���a��Ea�Vvձ��\+C�w�E��i���+��Q^u!�U�2,f=�B���Q0�gnQ%�BĘ4�d7n޴���J��ou��@�d�DI��=W}	�q��v����˖-��������]��K�Y�(�]�sI��*��񔒼�U5�����k��yƨ)y�]g\�=�xzm���;.�^p���Qf�|Ɍ�<����%@�F��i�2�uo^�u׆�kV����~�9��R��.��܉C��R��l����Y�Ua�Y&�z�[��޽DP��sy0.57a
5ѽ$���Ah��{6U�07O�)d)���O�ZKE�;/��p�\7�}a*ry7.�?��J!�CD{=;rkِ�W\M�]���m�0��s2��\�8Ⳑ�O!:֛����c�W�QZ����{�pT���F�,�)TV)��`�l.7�q������n׾I|�	b?�������]n���'��'�]R�m�UU�iNI����X���5gYD�A��$��ʱ�iU�s2�2M[�pP!I0a��P�#O3�h��e^=)>T��x��{�$V��h.,	/��,�<M�kǱ�t,�V,�uMe����&�!���]�?��n#ն���5���� ���;�.�WH�o�{р�����R�>��0w�s�-��RhDɦ�
-�D8�Kwx(�.�W��o:�]��y�DQ(1U�g7��6"CN��̸��HSz۱;m]����ѧ~�*��u �:���ʅjB�G1 �bbbt����$$��f��"Yi�갇_}Z�H]�x��W��oZ�oX!:�w��i�<6�N��X<kS^7����&+6���r.".��i��z]}Ez�j6������Bρ�Ffب*��1�h��Bع5���C1�������AOcn����7˹w�eó`�� ��]/]U!
�7d�Ζ�-�衤	M�A��������}�J�Nv}ܼ!X���T�pb<���xz]E��9�S�3���x`s��M�s��&��ץ�8}D�ex����Ң?��N��`g�%7i�+5!q�)Fh(�bnkc�s�a�C�^��b��kv�{��K�ߢ�Z	Z�N	��n-L�Wp��w|�n�����l����xL�s_�q�%��H���s���^�^v��~r��S��轚<���a�b?��\,�`]�	Eg��n�:���P��K{G��v�P}r�,����9:nNQ��pVYWut���),�V1[NϥJa���Fd<��C�z�~��>u`�@�e#L`���π@1`F�����E<���H�q�:��V"$�:�����5-��Z�L�6�S_��C�&�D��^na��+�}��7��6�A����u���J<�:��&�����g�H�:�T��P�U��dm�ng�6�͢9I��kN��U� ������j��zgn�v�����Ꭾq��q� 6��E}���,HԢ���z�;����=WL.�����7��	^y~� �	&�f�
���VLu��;�Q�o+�ۥK<no@�|�G��ɓ2o�"�CDĭ9�~��[I�{�,N+D����+�i���uY-'���Ћ�%�`�t�s��T�5��h?�m���.������@�|�H�����PM̳GJ��p6�l��,��z�TګE���8���ɴ���g{H�� ��4A���PF$���ُti���ac�k���l��J��i	��W�d?�b���T %����Y���G�������6~X��r�v�
�k������+�[��$pk�B!���D}6�!6`��x0?�$濩a��1���P�܉�ygE�wR_:
}HgY��x��J�{��̢���b8��t���͸
�>7�<'Ԉ����W�h�l�!���].1�,��H�t�S�ILZA3n���j���q$t"_7��C���ۢ���\`�����*��0y5鉃i�%�]�ն�Q�̝v*��r"<0�KE�t�aJ]�&@j&V�%l"�b==��t&�^y�a���������Ѫru@���=|b\b���OX��\0�x�Ó]���J��"C��w��՚y����]q�yȬ�[��+�a�LE�Ae��d�p�0��(��)�#��1������L�!�4 � ����ʖr�vL������9��z�~*$�;�@O<IĿ��tL�  �7� ��f�    0���p�[9n�^q��y݋}� �"d}t�dE����������ҥ-�t��Q��u!Z�E�G�N���h�f����U6�֏��:3}�Z\��pR�)[�����,j?����_"*�f��KQے���c�)$��S\��E��˚1ˢ��\U'T��5<Y��"C��O��"�{�K�&������w�Z�Ҏ���5דHH��|��@���yE�*7���xMժ�Z��$��v?�� 	Ӿ"I|���U�#�� z}�J�:�p�6=����^Q͸�+��)D˛mQ�1�@q3�
2@�.0���RS��^�ͱY�η޺4,w�J��uȶr�N0 VIc'��;p����w�Z($S-��)��PTZT=8��;���MXe�r�S<k���k�D��J\�3�n�Ɩ�`@8��I�&�}E�S��4<���N;�Եͽ&dΛ���zW3]�RnA�A�t�P��l�fex!�S�^
f�������P���۫P�`�J3Lh��LH <`&�BpKOׯB|��A�&4��oEq���2�g��[l�0����(��HE
W���ฉ����*DH{%j�ϬJC�_Ƅ)�`ߺ﷚9�*���S�KԴ���^��Z�� |�)�F>_���sg�����}]����3���P���� Ć ��:���z���>]��F�6"�{��+}tߖwC�y6�]�0 �c���\�0t����߮"Om���q��j��;/��e�6,�k9�9���g�6�/`�� \��
U}��T�	��.��?�o@��ɉX�Q]��B�Y����on{o��ߐ>!,!���N����(����t�a7�&m�k�!h>r+��?yg�v�������:L�����W��}�4p���Qkcu#6-o�sx;� |���,����	����� PB�	dmʫBF�*m"�A����|T]�f�}��J��P�|̍<������RnrSďQ��W���� <3YUO�gL�����Kơ���թ��y}!s���'����e��f*��N��	��d��^�t��h���--��M���(�/�b��Z9��d��Q8!��B\l*�����!nFtTPr��ʺ�?����������[	��iV*7 ��M
ֲhJ{�����	�Þ���f��VT7��8j?�.��`��xBlh�&�y8���Y���cZ����*���Q�ـ�M� �'5�?�5��!�Y-e�,g�ݺp���G�9�O���}�q�]������������ 1�=Q���Őkg����FF�n������x��Pd1`�8yVdE��o��~���в�mI�ŕ���e%^?��5�D�5��(��ت�@�"{|�X�I�L���fe��̰���tW
��Z�۫��N�JM��8��4�gPń�4D_c�l�v/Nc>�����e_]6��\\`�F��T"��z�;T�%���ِ�;l{�ո�a�=ң��C�%.1O�Ӏ�����n��g��<�)�/,yMz��Vۛ<�F��J���aMH���Q��x�����I��.�|�h � ���i�EIY��:�9���#32O�m�l0CP�h[�s�ۅ�յҚ�
B9�:Bّ;D��}\p0��?�l�`9�f�6��Îr��J��\�W�ς��֙��`��Pzzvm�xw�$��"����#d[_�:>�CZ"r��wA3����<�zm���&����Z���B4��nNSK������A�h�fg��;��e��*�4q�q~�iQ�qwU�6�.
�_�9>��rK�`����(*cX3TX	}=l���z`��0�*�d}��1g�a4�8e�>NnTc�

����!Oj��n!`���x�3�d��z�W�J�;��Ÿ�l'B��c�u����a~�Y��DS�'@o#�ү� �L�L�M��-.�j�y�.�N챨)��|���ja��ƺ�+��uK����T�zӛ�:}MŻ����Y@��_:���_�$��oM���[ץ3cR�E��)Y����_������_S�
�u�}F�Vs�Z�H7��F+/��p-�x���j��m����o5
�gc�ǯ�Y�GiTc�>Ng���R���������<d�<��L��+p�H֪���h���Mmݷ���Q�P���+�Ɨ�;`
4T<x���W�	��#���,�����EJ)n׷��6IU���#0�i95�+�C��-�ΣD�I����P��9ދI
�U����jG��;�[g���^��95؏�E���BG�ԱXf�������EE�� }�I�:r�G�2-�N�,T�G���r"lh?]�4���+��t`��&�Y�޾n�M�^-s�0����W��R��s�lh?���
N(��S��������fe؃�꒪��9Wv"Xɉ��������h�TQ� �P��U[_�8Ь��x�'�K�=��,��t�a��]�i
�󵵴�>��>�pK�Vמj9k����k]ܳ���9Tթ�.}��Wgc~r:���7-o[+�Գ��B�{'HܥI/Hi�B�۳zˣ�!@�q��*o��"�axDQl[��#����<���fK4U��V�~+��b=r�~����'�V�6��m��B�7Ԁ�++;�'��n2����f�<(�n��A�h�D�xi�K\\ ��dk���3׎����W�l�Ӕn ��n��\�w���)��:��4-'R�o�v<EE�SC%���.M�BH�1��q�E������^��� q��� e����Q�k�%;3�Oň��r焬�]���*�1q�y�Юm�cXܨb�����"[<#��u��3�8w�$]WS�������+MQT ��Lt]<"�?��|H�F�jdRF�K�-p���M���5�5�Nﵜ�� �`����
��h<������g��?f�7���澴�Q$I���6�8�������f2N	�CB���ox�PU�۝��k�m�&�������yv��觹NW�b=x#�6�R��s����t�2X��
�dT$�-�p��X��wi�g���R��^�$���o���Y!�)'�ߍ]V�D0��gM����ZC�X��C����b+s�y-�:�����,`�(͟��-ҭ9�=Zm��l�[5NN\�r]��<��퓙o�y#/���0���L�%Z��T��z���ޘ[��>�38jȟ���cJ>"� �C�X=��[Uպ���q6<���r mBn����/�V����4)��g�)Wv��*_nD]Z��ua�|R!���"�c&�����UõlE�4��R�L�:߃����,��y��A����Z'�����F�@^W��$_���H<�E��|�����ޮ��m��:�z؉�s��ۑ�xE�Ρ�j:�_����5��55U����-°Z�o�S���;Wi�
�FW��:F�����DfyV>� �آ,��ӡ�T��ظ���Q��%/b�gi������k@
���&��
����~�7��nQw����XH!fF����Q�G.���L
~�A}]2d`�1,��X�����T_4;ұ��v�ܲ\�j.}���3@8���X��3:��Ɣv������ݗ]ؚ��̍l�cYe��U��Yt%rY[%ө�~U�7������x�%H��5co�l>�W;�L?9�I*%.̜�WI�q@U�+B�fϢtW�Q�3;����c}�����}!^�#  )���
R��k��*��y@��͙�tLY .�WY��D���6����kL/*��"�2C3�}��)�c6��7�&
G@#q�,�.]�t�[����jf�¹ކ\���V��6������u�׳��*��Y-��<;tb_
�L)��AJ�%��< 8%��oe�S�	�W�Ɲ^��a����2���VV!DƏZLM_z�:�Agٟ0���u��Q+|:�sQ:��WZ����"�14����j7�����S2r��|�
����鹟�~�sͣ��P9��Y,A�K�,3���)Y,J��=�g}�"9�}��-x*:��L���q:��ĵW����E-A�K�    l�>��UU��R9���3���
��[�@�+\V��|�PNf�~�j����	-[���(5��!��D2@���,G��ҼH����u�.�#];J��fR}�� �䲫��acf��3,�b'@5r�d���}�e���'��vz�x�0�Na1���$�DiޜА"��I�<�9�e�y���|���\PhIIt>i��h��_]�QExO�7	��{_Gk17����'Wf�z�}�C��zs�������%+C�ꓝ�̞��޴�ҥb������,[�c�|[q.#P�J�1Cx�TBkՃ7}���u��1�2���1������I<�|�GV�-�k|�ԯ���@���:��`��HL"�Lv��/h�4�/%�g�!�fk�3�����ۏ͙KY��C��<{�AA&J�aS`9�a8I��o��(�ghz�.��NO�ݞ\��{T���VS>c��_k��$ ��Ci�?��r�����&��#�����۽+�T�P�.e� 6Μ�j�V.��N癮��أ���+H���L�/����Ϧ&+��w����^�þs��q4��V�ѓ�G�1-D��IH#�Ih����p�PQ���5a�B��nԾ��x[��w�Q���+,���������a=�3ʋ}T��V�I[34��s5�v��+��٫�Է�ĺ�~m-D��I\'��=LaO.t��Iae.0�� �4sC����d3|\�F#k��n��H���{���'5fV霂�Ps�a����W7�(�'��?o��� ��o���fH�*~b��Ż��R͔�}�{5.<���7�a`]�Dz�D��x�W��.�Oj���9���'3&_�A�P>�{]�v���_Ϣ�ݘ���ذl=i{�5ZN%���m�b&^"�!_�'��D��ڵ������w���ܞwïM���ܽf�i�	s��)��!��(�$B�.ښ_��u�dY���A^��;n�ʺ?O<j:Ƞ��+b�9 ��yF��Pn�jU�=C� ������g����i!JE�����}�i�������+�!#�]&�Y6���
��Wh��=;�Q����8?ˬ�����I�T�j��q2g+�u��'ɺp8:Utk��k��Ѳ������#.s٩>~6�b:�i�4�FH�I��b��q���|��Z�@�F��z����FI f��(�a��~�p����Tc]�������O弣�v�u��Ғ���@b�P%���i>l�!Yԝ�՗�M�w==��,_�
�eA*B������aq���
�mi��Ad���j��z����h�����x���`I�
��_�g�e�0��i`�j��)z�g�]�>^�mx���#�ԇ�"��Q���G����O��
o�!��(DRM���U]�j]���$������G���S)!
�)�N��b�TYaɟN�@gLҕO��b�4�L�|^9,���y}3��#�粍)�f�f�0��}� ���@YV�K�YF44�N_D�~Y)o:Y�ۼN�K�V��=�>����PR�)ͮ#�e]���9}<�vw;q�u�q%1*�{A~�����F��%��L����5�|G+£~�ӝ8k'���s.S��,[!FE�VO ��=z��8���[;���|0aX	!,[����������Ź������L���z6���3΢}�'�sMMϋ=Ϸ�DL)���p�y���_A��[��I�X˚#?)��[WQXa7#;f�c��r�-Ǖ���;�$�֪�"�lT�9����xn��\6��C-�\�e�-7:D��v�,0��7�3;ӑmڇ����ߜ�(pE�xTm����Y���UCsp}빬�#���f���kذ�E�E4
�U]�%4X�P��X&�o��!�����m�t��h!tE����
���"�9WRs�N�h�V�um6����Z��T�,LG�M�A�H9xk�)a`��9Ɏ��Ҩ�m�Y���x7��=+��r]#�6�!���&���:&�d7��Ⳃn]�벬��S��
�]�P5�t�SR�Ut��kXi�������������_���T���U��\����eȯ�����EZ��ֱ>	���B��Mf��?Yd)d����z,���YҜVo����m:Q�K��2��gʬ ���2�b	�ߠɚ�̫�=H�Z8�,�kὓո����Mf@ґ�dU��zq�Q`L�,�a)	��hݾ�P�;c~n/S���6��
�,�5=4��S]�����xѪ�r�|�N�˓�f+�mwjw�o(���d���@��Ƃ4%�g,��==�=���:5�c����q��\6�CX�:GP8�<Q�?ش Q.V/1I���th���SSV��# -ĳ(����Q�l��m;�SuG�o@�,�07��A�1ynVF/m�s�V�|31��ek���,�VP(q-G����fI�����2�\fU�9hJҲ�j��1:����5�B<��ӡ���P`�S���ˊVZco�t-{?:�Ͷ>x^���oÑ��(F�E)�~#kD������Z×y�Ⱥ���>�w'Q��^,D�(���n���*�I={�����c��ku��\j�)����ob!^F���ot����UM�<�$�;Ք�Ԥ�6�~b����R�#~�	��;���f�Y��q�}�@�vo�5q����i�)���5�mE�%*Z�!&3�?膎=[�]��F�
�0�h����>���w|=W'iħ�dX��S6�W��tп>�l.!��o"�(
��˩�q�}���������S���&���/$h�	�Y�g*����%8k��w���l���9[J\���6�8�#�1�8�o�)���d&���P�uf�4��,,��,��+,X��FC��d4# �M�6Ds?]�rLB�h]�־7.ju'��qx��Ng��37�����o�EG���aΉ�>r���i�Ű�D5�ng}w�-ht�T���O`n�gYF�&"0�49_aφh[߅�>�+s7K�M��8��lC�e_�����_F�����H���C�4vd������!�]R]^�qr���r�w��mQ��Z���3��KW�>H�+�q�n�t����yp�`aY1�X�	n"���4�K��?5*q=Hڙ��$�Ư{�^K�t�S˯҅9��xw�f�:�:ꤍ9Wj�B����X~vj}	��-:�iz��dg�9a�3_��n n�4v�$� �q��o��	�H1�I��
�x�Vף�����,������[J�i��a���:����E�yT�Y�a��x3���xY��v��zH�׿�!�����9��;����ߛ���A�A?��{���~z�O�q{Җ����t�R.q�I�E�0���.�L�>�q�9@^���x�N#��A_���[�B���iIDرs̨�c�܍��?n��*�;Ͽ��~˵G�d�C��
LT!�F�^�D_W�L��3�<p�0�ʎ��@��U�6�9�l3g�D#ө.��i��.�����ko�L���g.��P _��X�^jB��uN�+meG3pU�9)���Y������`�YV��2��*�m�"��ݟP �N�w��!mQm\�V�"u�'
6� �_��.]g�7"LF�Î�M˴t�Æ�"���h��i'�m�ߙ��b�[q�~�O>Bm�4J���L�0E�,�A�w��5f@D�K�y�7<c��no�����V�P⻔��9�o��q�ǑH�ϻ��hP�_ o0���y�|���f�����ܒ��OE9�|!Y6b���MWq5쩪��L�b���I��,Ͻ����{�v�f��j�_%��Z.�m�f���PϹ� �V?	��Q6��ם>�op3U�ƶ��K�ܒ��y��>���Fr�6�L������EWo������Ӹ;��oi�f��\@``��nN�3����c�f�m4o��ש��.��B܍"��R�j��i ��I${�Q�k���qݮYʲ3�Δk���J�����2\l���}7t���K��`{1ǉ��FVg�1Rj\�H�?K.~��(��I:�Sh�j�e�X �
  `�$i�g�:l��i捚�?e�V�����5,|������ʼ�[\�da�U:-k-F�q]�.�M�!X�Bȍ��;��nv���v��k��fr�MI�D Z�+�Έ0�(����˗������pi����D:�<���R�.\���j<h��]k���m?��$�-�I(;��
/�M�.���2�@Y�k|���)K��2^mσѐE.��'�qe�?�8��?x����j~�eq�!ΉᄵU+k�G���� �-����e�����w� d�:��qU��#n����Ȭ�������|\���Hf?L�yتjX(����4�e��@�ӭ e���v<>�9(D���_�霥��C�g0:���O�<kµ�F2�t{{_��Y[�Y�ݹK{���G�x���zat�S)��-��N��̖�Z�8�j�ݍ�KZ֑AO#>�/���7s�#5��A�g��
{��ӽ���q.	z>T�Q$�a�6U	�d�ղd���X,>�&�x���{�0Vh�y}l[LGJ_[ߪ�ͥ��:�d�(K	lϰT`Me�������A�TtC��=�q�E|\��욧Z%Ռ}rU�+!�?�Da9���e�㷰�i�!PO����d'5*�m�[:����r|[�Uv�ak��t�^��'�s� ʡ~�r����JtV��)_��x���(Z�Bd�"��u:Mf�d��Kf�h�*�̗�/ola��c��k�k�g�� 5�)D���F+��(���oy����c#��Xҽ���_���j��w�t�ڀʩu�T�RwX)zǁ��R���C�T�ZT�'�I����[����Z!:����a�Ylϡ������ ;(�P�0ԍ����t���[.'���֢���"��sM ���p��t��4'�>n"�m&��S�3����s�ѯ�O�q<���l`k��FU�
��6��e�۠s�p���CT���}�_A����ܛ����M��#_��i^Ga�G4nz�N��Ҍ�~�}V�d��[��,���d�w-E尺*z/�g"NѨ��4<س�]^�z$����͞l3e��F�f�=�y�a�
3:�$/�2�Q����K}RE��l�=���r��\�e�!��ئp�3�Hɻi�����K ��a�X��6�ѻmԭ��`z�\��%�mR۳��Q&r��� &3&��2taވ�}���JV7�[���i.��_��Q$�%{F��S�$Cˣj�,n4�,R�i>j������&P�
A;
�
cŧ��޾��c=�����w�� Ӗ���N���\�Wk.e9_�?L��Bs�_���
�:
��,�|v�7�I�27�N�;�14��C�+���Ej�M^�N�"g���Q�c�:}.q9��]��|E���%���$�W�ةx�#�ONc]�v�W_����׿	��z<i�ᚦ���\�����k{��#�p�ܷ�� oz��ԫdG�F�zgV����׿�1��\
A�����z�:�N�z�0Y6�3&1��l!H(��( �e.W�X`C)�t��2�|�⽠�wٞ��=\8ZTk��UU�e�>)�Ϧ�6&̸ ¢(�w�M�d`sO-��+5[L�Y�l�k%>��|1���v�2lu*�mRUv� v����£P{D���Ȯ����3B�,EId�e#�Ä���Z�)�
����|�	Ԝ��,�Ơ"*�ڃ��>������J�<�^������g��/���#;�4ǿ
C����q+i+��	[��ݵ�A-�ƁV�C�:����*��l6�Zu�X�(/,Q����`-��V�to��tUe��Zv��o�Ϛ{_�E6,N|��됛�v��u�ۊN�h�f)����g\�e˂:���T�djJ�q��&�lʮ3���0�� ��u�L䫴����Yz?N�f��?J\��&2BMP��AYh�`
���U�Ӡ��[v��g��A/[?���`K:�AW+�����}��D� ��HJ�{��Lt��9���m'Ѥg���~��D�ZI����f�{)CQ�	��g�:A6�Y��g53gM��^�)��1�ˏܽ;qN�A��K���!SE��>�i�����K�հE!���JsЯ��� .䈷 x�H(h��L�d;V�A��}Qi�tP�t�	��Z!GAiR�Ʒ�L	���]�a�F"fI�
�V>�x���E�A_�eF���I!�O�~j(ge�������k�T�ym��:M��㢍>]�SZ�]���R� ����'�溪h��۽*����� /,�Ůi�KZ��⽟"j =;c�-�`Ri���R��HhZG��4�k�.ݫ.ڒ���7�A\��]�`9�7>3	��1�,�h>����5���0���U�śSz�_7A�Om�ҡ�2	  F�0��1�����I�?�0�!�mQ�������r�����Ǣ(�cg�ƈ0�[x���]ҵֵ��u��MkY7�˅s�s����g����u�����t�l�i%�6~�K�0�S�����,�no����i?�r��;.W9W���3doN�3P��������d�F�7s	���!ۖϺυ��I�/+9��;.����̆�],� v=U��t����P�u���QA���TK^�����u��HIS�c
s��>Y�n�*K�@[-z�8���l٭ɫ2k5�f�7�3k5�-眴��MRM�=�fsњ�\���r�}�G{�����k����_���?��K��           x���Mn�0���)�/(��?��$�]5���8�و�9F�]� �N�-r�ܤT�&m�	PdE�>�|�Q�ur{}���L�o�o�vE@l��!w!g�\��7�5r�;���QM�t��绛ou��ow�p��o.�E�-6�źm��]6�\Ϛ��C77��l����f�\�:.�W�t.<mlc���p�4��DAۂ�Ϥƀ�"N,�U,���31�L����M"0*K�}�.�s��������r�	A�Խ�$j��e�۶=���4RΘ�����~0�=�$�6i 8Q�e����\���hxUf�qj-r��E!2���0�����I�C*�bf��(!{(��S|RU�ɓ#�9��;'�I�IO�T�'���=}����
U�nf���n��^n��ȧ�1��!g���h�[�Bp�U�^b{�V�h�xgk��h�0#�dVd�0�TdC�"z�o��ʩwW�]x�z�}�ن�h�mn1y���_��uYj�8���)��eH�`l`<���2.C�BZHOi��N��`�[j`         L   x�ͱ�@B���0Q��\n��?G�(^���^��H��i�u��q�$�!�Dٍ�&(�D5���e{��.�$�         
  x����1�Q.l	�I\뀐��4�P]�׌��!�}�vg��Bl�#�̘D|����{���� Q3`��T`�d�z�n�_�x!�$H��T�^��2N�3��K�>	�.�ܐ�Ρ�6W�Ħ/Y3�n1�6`�VX�A��Ϭf/�yɡ����u7g�ixb	��3������C�٠�FJp�I�_ze���{��H��LN���\Ѱ�h�n,Z���t��`�*�7/�4|\	�bN���Mr���5h�I8��������g�      !   �  x�}�;o�0�����ɉ%�9&v�,N� Y[���T K��ةH�nu�n	�!K����|~��<��G3������x�a�=3�2��N�7.8qd��'�nD(�D�
�P�Z0�G,�����>z�2�!K<?���wܳ��~��gS�s���
�]��m5̰J� �P�=��#d��`�&D�c����F�e����cAtq����;ւڂ=��T�L'nd�GFi��
�a½�ԑ�$��8}L;
������"�Pz2)_&�<t�}w��[��״�Fթ��;vQ�o�4u�[��A2��ql8�o8�\���S�jWU|��.PS�-�B���Ji�
dJH��I5�>���0���^�c���:-�X�\ ��I�CW]shm�*��=�S���q������r��KeB4��۳�����mdZ���$�O���xc���G�Dv��m����a�W��5�y�>��S�����,o�W�]��Z�;��(��      #   (   x�KKMMIJLΎ�M-ILI,I�44�4�367����� ���      $   !  x����n���3O1���]U�g����I|̥�J�E� .�(/���A��/9��(��7�7�%RZ�bf��`S����^3��/�Oo��M�W�FΉ�ʚ��E%�
QGCM���`�e���<��a/fG��.�F�[�{q;��"w!4ҧ�dK.�{	;��5r!4�p�fu��1lw���Bh��O���8߿}sܜ
�B�	]�nH��՛�&C{�{6;&'�/�F�����8�g?��u��� �7vϼ��B#��������uo�g�_�eQ��B#���˼AhS&�7n����Bhd;�[�f�#��b9�� �-�E%�]t,��K<��ß����v������rc27/��?��B#������]��Ȃڒ��[�q���9켣�?_���'ꏷﾟ��2M�L����b��9���^�.F&=��GB{(ɥ���N�z��߿�w���^O/����'w��1=����۫�SIϟ�i5^��	��$	�Bh=|���fz��Po�qj-��V�������c:^^��n0C
��֬*90�Q���$�&�Hg�>�vY���NGk�^�b�c4-��TUH.+&§ZY9i=��L&lŰ�1|���T�%a5\S�,�n�3�Pͽ�Xs�$4BF�oJa�^�ҽ��nf ���Ԍ�Ti+/ǰ:�9���U�K(Qg�2�U
�<�%j�y���(���>Y$��+���d|Rݙ�rI�:�í(Qԡ����[c�
ث^Z--�ON����(~9ŐQ��i�b�?9�T�=�N�w��!&��8	��c�;�V�Z�DtCbT	�D*&��q��8�#MO����������y�^�r��n/�tuܡ��`3�3�b�UL��R!�V����'t�YNB��+Y�fm�!9�1r��b�*��2w9me1kY�ĐZWb���"KGѐn���`me�+Yt��K��k�j��1��ydS���J����ԛ*�A�9�ʩ4�u��Rs�����,'���J�~/�c5$��%4�dA�$Ĉ�q�A���44:Y[/pg.�����8G��E��mѽoeq+Y��T`��d�XV��Ķ�f��/��ůݣXe;O��R�����쫓`5��r���F�|�X<S��"S�u����-�)#Qv6neY��4�$�t���Q�ܰQISQ��"�����o̧�ѯ�]lA�M (��؞�Q��>��ִ�e���лH�,x�"�Ю����6��\)[Y��.	��4ԋ/�#��4M+m�ז���y]��.���юU7w���]��g��%�\�V�u��u�,H>[lXIv֣iR���)p��Y��.Xj�1up���oE�FQUj�s"&��,�t�]llfvs��a�t��"����t�r�y�{�:��9�C𱰊������Z����V�+�����I��L��8�;�ܦ�k�}��P��L��LD�r
^�R�mWL%��(�$4���X����7��S���*�圼�7"�A&���H�̡a�`�1	I+j�ë9�p�Y��LJ� k�b�;�/�MH�N�O/V�!�z�`"Ha�"�0c�㖂���+�jc��a-�C�eF(U�3L���C�*�ڡ&=��c:�p/\zh��S6_� ���p����l�VY��\�j�
;"�l*�T;jcte��-\�-�]5Ԃ�C�Ʉ0�����{K��۰���2�uW���#�%�j�� M}"���J�,��ir��5��BcX��<t(4N �O�U��=%�,�r%���6"D=��p�n���_�:}wu|6ܐ��-�`��x&#�y�ሆ_���y,4F���$d����PC�,%�b�ʈ�ņ� v	@�B��A�,؂���k)ޢ@ﳜkP���HK �܈흽��2{9הt�y􍦭 ��|4��>΁��J�2`tE󾻼���s ���� t�������%�U��5F��t�
�� 8���@֣+`bV!KUaBo����/(�[��YT��s�8�4S�������N-JK �|M�9(X"�/	��%7���ZMh
��9w�Xh��n�_ ��%�         �  x����n�0�g�)���G�-N����!�!۲�6��J��������{�M*���m�.%8�������$��c�UO�eB@�@qr\�d(�r���9J���5㒪m�&M��R,J�X�weQ/=]����|����f��l�׺\5�h��Of�'�)��).���( �)!��a�B� ���8F��נ���p���QCdί���j��z�H�������!��N~��/Q�ܛ���:��p{��>��"HDEᰕQWr���rE�4Xg�=�d�K]��|���Ոq��x��������vS����?�m~�N�Ms$��=��%�Kÿ��р���[y%�؈=�}Q��z�yv����-������6�D3�u�ԡC䠝�b�e��ï��j�M�����e�6k��"q�~D��<���V�i�e���      (   �  x�͚ˎ�����OQ��ȩ�E;�e�,��3� )v��D)5p/�,��&F��xA� �s�jz���Co���H����`0��ש�|�gu#z��կ�/� �l_~��1�m�>_�cEÀ^)�h �`=��B$�j������zPxPG���	�Ӷ%͟�/���{G��5bF�g� �6o�	x���y��,&��O�c���37���B��
�*)F��?m���d����)x����&u���Ϧ#�|�dY�%V+���dI#�v�hM���*I' ���>s����%ٔ�J�ԙ]横�e��2G��.�(W������R�y;w��*E�~���ڲB�jdI�y>�H���D ��ۗ�$]L�J4v��*R��x�ۗ?F�.�w���m�5�&����o�/OI �ۗ�jS�ܫE:I�Me���� a{2�l���sWMu:hM���羚�^ܾ�a2M�E'�`G�7���4Q-�� �e+�j���M�%�cYuZ4��m����h�8��u n�*���I��d��t=:���zr��3L��5`�Jh'gE��)!�]��w��]t�㝜�.�>x��]ĵ#��xU�'�A�����'}c�Eb;�I?�w֎zr^�;5g;���a�N�ឞ��\_G�l�a����;�j�==;�D}��/�;�k�==?�T����{7����{'�������IX;�ٹ�zB~������|�N��<f5�s��8&�X����W�l����]X�I!���<)t��~R��z�������v��������<Z?[��>�T�����G\v��hwYq�Yϣ�U����v����e�B�d
 9BxD�ϩ"P�-����.B#L|��5���R1b����h�� �c1�8����mȈq_Q}����:���
S�^���GL��*��mKh?W&Y�X�^�Ze�e��O���4�ʏ�W���q���p}g��q�����H`Ȩ�3F���)=*��=�(�Wc�ݾ�\0��7�B�\<����q�ʖ��@���zG����jߞh���DW�~�u�L��9�<�{3!�b�
��v�tT&��֯�/�#*}�$d��"j�q�YרW���)j��F
�� i+��FH�D�!8��g
B�����Km���ԣ��{7\�zL�[$��'L�ꆔ^0�yc�~.��a��(��o�j��Qw�Vis;����?�=�I&C�XE�c%�tH��P�7u�F�)tDt_b��h[j�[��.2�̭���.�`�4P^j0�r��v��ۘQ�}�� �mI���^�+�h��2�V�������0�U����T�De�ka_y>]Σx�V��ba�7	
C��b�B�(��8�I<��h���85�5�)񉆏�mK�!��d�- ���?���d��q�������K51�B:G��.lN��ƑކH�&����DA��`2c�� Yn�+�,cmdı�Xa�e�P ��&
	K���m�5!H���ݛL<N�`
�8Z�u�Z\Dl��\��_��,���1�b�L̻V����\�ؙ�M�bȽrs��ZZS��^�\���)X�$]��A�n�]k#*j��(�����KR�0_gn&V��&jM��R����$K��
��Y/W�d�fc�΂f&l����i/�8��W׺���[GZ���_�@���j�XL����]��TMR���2��q0�&��3�QE�ZZ&��I2�f��/m}&6s�i9��e�ϳ�-ݙ̤&�lX�e�{��L窃�d�d��+�h�ʬ&�ml����i�W �z\TF�T����SEg Ú\����~��3���0�K��<�,���� Ig�-���jK#�GE*Vx7r���qM�	�o���]f���ٔ�ѻ]�[�<�v���M�U�ȭ���E���|~v�Kz��U�[�|p+^0nH��ڢ�E�q�Ҷ���Щ,m�ȇ�.�f`Y��ʶ�՗f+����ڠ̭g�r�*��l�+�����mF��a�/��F�-gp/��]�;8����W/C�]�;l��k3]1������q��.�wK!��^Qh<�V������Р��Zl~�� 48|�ю�ާ��c��{	�V_��Ut��@�u���$�·;3�i���/��� �E�·<��������o=5@p1��l��|��H�K̈́/�]�*�L��S;Y�/�|���
��bL1���{�\sh����{ ��o1Ȱ�=R���K�����-IW4      +   �   x�=M��0����Ĉ(G �)ǆ86�Z�8(q���i�����(`B�Gz���))k`
Gb�h����9"�W���gm;�F#en��[���P�P���FW���vC�/XX�M�?9��8���=��c��"Z2U      -   [  x�Ŝ͎#��Ϛ��ЀM6��~9�ፍ�� �����3Ҥ%�3�<C�s�cr�}���&akfZ�jM/�$vlÆт��b��⟬�fb�d��弖�t�J=-k����lj,�\6�./줚|X}���u������b}�ۿ'��rʪ)3�3�g��K)�c��b�?��)�f���*��>*������O�X�T$�� ,��c�~���E*q�* H�z�s�����g�������9�uq���%��%�uyh|]*XW9��8p��V$�"�H=))�#Uu���t��F���e��e�T0e��*������-��f��L�sc�z����u��N�{��(�l�kWa��˂ۙ�Q���ҽD�I���W�R�3m#f����ϟ��%�L���(��N�r��y%�Y%)9��8h�߿���#c��f�I��D�s����~,��/�f�,����9��ż�6�F6�zQK����1ܥ�I���t���Gk�~�e�Mx���=��Ea�~���z���nX���j�Ź��O;�h�퇅�6\ɋ��Vɦe�/�5�/�\U�n�Z�N��̔t�`\ʱGO�]�k�*�2K��o�*;�ht�����<	�4�h �e8NB���H���ex��.Gjd],�K��u18Rc�b^q�a�b%i�F*|5���T)8����
��0R��4V#^��'"�b#%�r�G*���XM�BeD�r�'o7����]��������3egB����\�=�����G92��W��v�s5a�m��բ�Fj�<���$���n���X�o���Y�b���������k-�e���)Rf:76�Kf�v#Z�R�����ۃ��u��S!5����F�$j�zu�Z6�eqSߥ�G���~/�
Nis袉ΟA!/��~-�����f�s�n�j')Z��j��������L�5ۦn��Ƕ��-�~B>$�e��l'?6�Ŧ��׋��o��mt�$���~r!^b;H����|�5���iD�~R=d���|��G>[
�j�Ų�m�67 �B�>B�R ����q�޷�������im)�����E(	�j�L=�m���vs]l�.�x�ۖ���u�ss��"��0s�� ��~�Z$��۞��B��z�\;EI#�HpG���֓i�T��&y�o���o������ˤĪ�[xA����/�rW|���/�q���QX�M�4W��w�lW��0����9g��k��`�kr��T���1�����m.7.˓p��Tq�Y�W��溉%�����Q��\�ƒ��ݜQ���ˡn��Z��GzsF��6�M�>Oi%8>� ���?n�V��.��|�����I��~S��p��E��[���qqn+-�{d��h����]��\���)a����y�^N7�;'�d�k��C�R�z���b�ٻ�v2�q�L�d�qE����}�"\�xe ? ��>���kR8J��<�<�_�����ۉ���&� ����USoc�TM���ů���+Rb�P�ws\pB-�����v;Z���`
+A�������MƛC�Mw3BwA����~Q�V��K�4�ۑ��� ��z�wjn���8��_8/H��wz�uq��[�t[���v6~��I/(����)ߎBy�XP^P(,��� KE��]q�zAA���_��x�H��z�
�_m���v�r9?�� �C�a8B^FA�UX끓A@;.�4@������m��Ǯ���P���j��ۦ�e�f��1<%๤����r� ��\ݤ�\����I
�Ƕ{��!({�˨b=�H?A�ݒT�77��z޴��+�F�z��_�U�Z�y �p�JN��w]yp�O'�ץ=�K
�s� G0༤���_�+W}.�Ms��n��Ӽ�*ԓ��G������뱘�@8�ڕgصY��������e����.�m�n�ד�$��X�'�#
��������w�Y��+)U���8C�%��_��.
��G.%���%���ݾ]�J��0x�R� >�@9����Q���̖H=�%h�(
�AM�j�H9��:�zl�[%R>ha��*�(��`x��jEa��S�"|���='��ܓ����@�De�LB��!�U^c<4��$Hik������V��PH����Q���CI=f��D+<�C�k��T3�ؿ���y}�@I�[G��O�$���^7������r�i��i�[�J��=����㬒Tj��/ ������R[gt�C���|!����H(��1!�v��	6�E ����H�l�HlBo��1�oav���%6NiH�*��O�C%L}D#	�]Q���b�I��m�!|�@��Ǫ
Ɂ��(�o��� I���(���+�mܮAm�G��� E��&�8�����Ⴄ61NHҀY<� �M���ǿ�e|#���ձ���m���DB#y>���Oni�PS%�	1q�N��*4�=/��{!����B���CL�k��͈Pi$��>Gam� �k���#=��
k��@^[Ra}��]�,��m���9���/x�b'5Ķ��vW�D�#y>�� ����Fk�g���A���lK���E}�*M"�S�3A��.��PF��άN��o<D������`��SY'��ձ� ,�վ(��x�`�f�h@i��� A��`VW�H�zğh�3@{�� '>5ճZ�H��c��7�� ���ARaͿ�e�,�z���PTK����4��QHduΦ�(��z� 5M�9[��AM����SMw�R��7ͼ�Ai�B��6�<׭Є�� �H>�|j�CM��QN[$�����H$4�2_9]"I�I�����H�t���(��z� u?�)�qVCRGv<f(���?����aqMC�^f=�C�z3�h�C�C�����p� �I��Y�j��@b�39���B�s�wo�Bk�g��3�ը��\R�c��ҳ@Hݍ�_#4�$6��1�-k�H�����S��{�Pn���#���?�X�B����d"���0㽐82�j�;^��8��B%r��i�G>� u(�~��C�|%��ˢ�w�#8g���EAjM|�vC��K��<�#UhM��h*� ���G��8:��S��uDA6R��q��00}�I�5�H������Jj1L�����)#z�F�F�իUT76��+��06U�/����Qm��C�}%ҕ�@����}�:=]#:�*|%|�B�Z���}ҕ�2�HWtc����q���tŽ�Е�!�FW,C��:S�:�vʑ��~�tō7Е��B��R�t�����?>l%HM��z����+��/��8i�W���/��8U*@WR_"]��@׸ƾX���#]�r~vv�7ck�      0   {   x�-�1�0Cg�Sp���J��]Y"�A�ʏ���z{B����m�p��>��
�8�/K,�C�բ��N,S
������g��Z�`p��Y�Wܽن4nN�P��"��T,F3��sOD?�(*      2   I   x�}̱�0�z�� 1����p���䲽m�&���6�/�sI-ɘݙ���66K`+��Fa�a@����Ⱦ1      4   <   x�K��/�/��/�03O1323ֵ47K�516HӵH2L�M5��H�43�0O1����� �Ht      5   8  x����n�F���S,t�;��<������h
a���D
�py��H�hO�Q@�Coҡ�ڮ��X����ofv�3�q2rE@F�GLQ���nI0,b<�*����	t��q�gy1%'>��48��5��y��zV���˲%�B���u�}Vd�i��� C�3��� uZhm�A�.��<����3���w`2N�E�DJR�����W��Þ��>�x���dl/h����ɱ��T���!)�DG���RV�r�7�\�U��1F�/&K*�H��(�$\�9����k��;D�lwJS�`;�����0�t��~)�a2�*i%s=0A-��~|5,�"Fï���Շ����0I�ʗV�F��O�W�(���1��~)f�X������]1C�|��Y5G�Y�,���n�
�tZ��y�yM�rq��E�I8i���]�r�O''^�p¤�g*�\��:��2�dn�q��}��C'ʎBy,lh��1g��T|-�H���������\}Ғ�W礃~����ɜԾn�ӛ=��Z����2�5q�L�e���O2�R�c�D���6�g�AB \�w�uY83���-�,��� ʍ�&Ƣ��o9<��A8������^q�L|�&[Uͱ����A�6R(i���N�IZ��%�g�?D'�G���z�rI֗R��>���{��>N�WooSv�Dq�@�Rǹ�bQ�4��iZy<��6�=�{$���#���Pc���Ҷmɻ�0]B8=��F�؇��rfv�q�k��z�x#�������ev��o�������A����`0�bb�3      8   2   x�34�44�4�4202�50�5��2�4B��������!��!�H�  	:      9   -   x�3��K-���ʐ3=??�˂� ?����32��1z\\\ ��      :   q   x�3���,I�H��2���,��KW����2�tJM)�L8�K2�LSN���T�����T.3N�Ģ��T�В̜̒J.sN��Ҽ��J����%)��E
�y)
@�)@[b���� tN$�         .  x�͒=N�@Fk����3�?��8A�h�ul+N���PP��BJ$� $�XV[�蓞�ͬ�HG�a������M�,^��#���ˁK�%(s09������UN��3T=�JW�"\e��#���t�q7>��ƧA:�v�Ӳ�&��a��Y���UeZu]Ֆn���[gK�^��gEX��!��Зu���׼�$'+@j&(�f	E	�4G�DR[D��8�ER\�� ���%~�9
�6oO����:~I���5�%>�ELP刹4)J"�-cD
$�x��q�2pi      >   �   x�M�[j�0E��U�ȑ����Bp��f{��v-]W�)����^đ$��K@Lc����,9��5M����@�㘷�⚨?.��.�ua��א�u����F+'(5HW�;��E�D@;N�g-S��\J��>�N�.-�¶�|Xc�[��(Q%8}��?�鎵WT�Q橠��8�Qv�;ɨ�j�����Z����:��k�|����q���gZU�ʿR�      @   l   x�3�4�,�8�+S������
9����)^�P��i�ihh z�ɇB-�S�8�F��˜B�귤P���Rj�>��0�d@jq	�6S�R�+F��� �ոn      B   j   x�]�;� Dk�0�E�s /`ccC������F#&ؽy3�$�5E.9f>��P�p�[�[a0�9p*����`+z���ŔvG	�B��IJ(��`=A��',�q�76      D      x�3�442����� 
*�         -  x���=n�0�k������4���i$[��f�_D/@��,P�?�Y�U���{�QO��\9_CK�-�&,F�<;D��&��)�W	�<� 8$6�����q����[^v꒙jp@'���o�f�8'wS��KI"�`���<��u,L��T%a��D��F�yc�E�~��۟�w����cT�'���8Ǥ9�Ϋ�]Eo�zz��Z�J�Rn�@Snn�X.�0���uq/~��ܤ�5mF�$�މb��a�ʩL6�:�E����gT�e9���xR�]+�@m�%9��ޠ�����\��      J   @  x����j,G��㧸/P���TR���.�\dS�!�,��?Q'�`7|=̢�4]R�#�^�~~|���t�˯������_.�	J���3� �r)"���� � �kR�8��*6I�G#d��҆s�����+H�����1O��Kp�.����DzQS�O���e#`)�
�h�e����ؒ���r��V�+�MH_>_����U�y�6c�3��"Q�ɥK0O�K"�}��x����jQv��|A�z&�=]�GkKb�Q�V,���*k������ ��N���1;��e��M/M�OIN�1C��%�9�/�F�y7��F�Q+�~j&s�g��vk6a�QƂ�LJNBq	�ae�on�Oa\�r!P9CD��sǤ���.��^֩�r#�o�>@"z�+�x� D�x�i���{בj_�,6]w��������{�͹��)�fq�eaj�DM� (R�4�����H;�c$g�3�W `[�s�Ƹ6f?goyH���j���-�e�3	Ф�\�4�f��(ޖ�u��#���D:��4�����g��#gt�=�(F�>[�a�[�<�f�,D3�%�1�X��T#O�w�1�UF���r&A�1@$!磎�֚�*����>�1z*�K|*�I�1G0�t�a��$7�4�ZL��T�_y��x�<y+�o{�L�j��Ժ��6,�u,=��T"�>��b	[L�3�{#�'��w�d5֟�>k:»��Wc�%>6��V���V2�(�T s���ڔ�in��q���L�d��'6ĸ�z&E��XCR�s��1g���Y+�������� &�      N   �  x���Mr�6���)rq�Bg�Ǝ�.�y�3�~���d�� /���E���nN��m���'��La,�p�pc2>I(Q�H&�	�a&��Z`x�:bݡ���?��~�����?￮/Z�Q��t̩�`�,�XG;tԱ�N��j�s�v�2�9?:�xM�<�`Fi�C�o�uj>����f�|���Ne±�A�[�kی�4��ב�>\�;�|�����.x�??@�<|�����qL��H$\�h}]w4��:PL?&�3KS�nQG�;4��:�Q<I*��ܴ��gC�����B����vI�߮W�L�ۅ�*����;�V�^���ڼ3 UQ�?���h��5Et��ȱ��Ƃ�ZG�)64��)T��y�7�I�Mg�\'T?۲��w=�<^h��
3D�RDY�Aw��CP��� t��g�ل,׮��wh�����c��YI2�*8��Z��h�ON�k�9�̐�uĸC��'W��Yd��l�uļC���|�g̣O"���Ǥߠ<_|���֙���.~s
G��l�|���I��JCf� �;4�x�}a���yߙj��Pd�Eb;4����z�}(����L��>����TI�or[+S�_#�:�pqX��^��g���!�T�EL;4��ռ�@�cR���R1���CE�8�̏�٩�����|��gC�Oq~� �'�#�����[�����S��Ō؟$��!g}�Z}�h�)�ς�$�r��^�d���gC�Oq~��Y0�$�='�'��+�����S�,�����-�>_���|��r���<]�>�t:���y������['��J�7�\y��#�|�d�,�e��]n�\�p�7���,7�����^I|Y/�s ���F娶���@͇]�^I>#���	-2�!�h�/����5ud٭�����ļij� ����C5ʆq�d�fi�nu���|������1�ΊMԀ���j���Gj>�y>y�� 3~t�Y�˄|#G�?���˿E��      R   d   x�-�;� ���
6 �<~B�>�!B�3��k1�=L��^�oY�Ew�e�*k��s�c;~4��N!($Rv��u���+*XiBƔ��S2����%>Z� �      T      x�3�4�2�4bc 6bS 6����� 4�}      U   �  x�}Rˎ�0<{��?`���5���!׽8�-���a�����!��h�6ewuu��̈�3^�����ai�����6І���,�7j
�	0{�Q��� ���/_�|�����D�C=��z.`Z�6�ɭt��MDZ��,��*@V����L�ҲP� ����ҍRIQ�<�E.�s����-13��9�̀����K^%UY�y�����s��&��⻳�<��1��"�ԍ̓�����A7�\��<��ۏG�T���(��t+��/d�m���͍��[�%ۺ	w����v�V;���~�X��/)|�GY�2���w
Y0��?����U�����u)������k�ئ���Bb[�!���{(�츉٦@W���h�tx�q<;�i��:����"���ڍ������T&5k��(�8��lT�di��C�[r:����      W   �   x�}��N� �3}�y��2�i�ћ'7��`�n'�� �����F������2�=�L�S��t��z��L���<$Z� ��g�I���1�� :+Z��[l���8�d�~����Ƙ`������1�v�oAI�fX}�x�@�xڲO������*�;�w�%4���J�Z���b���_h[<���#���D���R�	V7�����9�_�9o���c�=�EŵѨԯA���iZD���U�«��02m8      Y   �   x���1�0 ����+۱�8@LHH,qC%��H%&Vn�室��r�%F@��zW��+9���%F(2Pa�!4G��@����x����ڪm`��
A�*�jC}`��u䅬�wµ	�?k%%f78
R��B�|D'���k���"8�      [      x������ � �      _      x��ے�ȶ����b� D�ޡDDA��� *�����+Ӛ�{M�����M�E�ԏ~�9��#M�udƩ�v���'���n@�%Z�a2ju>yt6��8D�[���z�A�jgja��ݗN�������"�p���}n=☝��K���I}U�����W���˩���+-��\ߢm@o�:�}}�����vf?�?�F�7W+;�x7ڰ߅/u3ٙ.���p5�a�#�>����_;��gD>���2Ӛ�{�ƍ�W1v�\��2V��4v����[�Pp4Gs.X��nE��
P� e�T~� bH�#H��X�D ����~ �O�M7 ss����������)J7��x^2�̅>5J(�Tc�d��q�j!%��߆�{9�|l ���Ni�J���k7I[��I`�����'�vx�ͱ�;���vT4�Wx�ћ�L1�sǲ8�y��7H�Q"�L�"WE.#"+�$)"�?!� 4��$ �'�?F\�@��}
�[�;���	�9��.�����:����BsO�mi[1�Z����"�%Q�%�J�I�� jM9����e�Z�<����l�����&�d>�{�x\�x��N�hv����6� ��������O��;�_�c��.�}o5���M3-��wλ����&X����曖�	�!�&}�@ 6��#I���xП
��q���4�������m����'"tZ�>�g����q�u�F��F���n����>�/6 ]Me	X �'�?$F�Ԛ>���ЧO�`����K�<�=�8K;�Vyp_nK'O�q;?I���w˜/�b+<H�����5�_z�����45�������n^�#c,��"�p�b����~qP���0/
H��>�}�������<�L�X��{�E��ν�e
���ܴ��㙧���b�"�x�v �?З�*%�?�����*Y�?���7��y]��U����L�H�Q�ݣ�Y���e^��?�~}�}Fۚ�Nߧ�K�~��t`r9_,�gx�r�fa'Й���z�j�sl���^�> ����J�>�o�-�۾�B?/�̾�4�k:9�������o9nk�ު��Ǔ:^��Y߻t���� ��n �"K=�K��ѯq����>|�O�HP8�l��rvm�ȴ%CyTF�рoFܸ�_�mP.�	�&�%�>}����yB$z�O�H�>�Yk'�Ӵ�Kk�ؾNM�F�;}3q2�2���b_��)��K1N�QD��9a��w����'rH�eJ@|A��rTG�^�	��5~Y���LL/��N���f�:�m��B�Gb�k��Y���`�����Ʈ��d���c��1�	����R.8_��0����F錈mr����%�N�m�}��$_�3�ѯ����1��{���V[�� [��m���zas*�vs;����4�5i��'5�D���"A~K7諧@j�j)}��>���UE��n�L���F�vp=��ᴎ8Q}/������߯�b�� Pdᕾ��H�]��۴��D߂�~�	��_[v�l�E3 �X���]�?w3�6�e缊�ܪD_j`�-� ��>���m\eAi�:|_j-���
?+o��0������"�]4ퟖ7N T3t�D;���/���%�4��$����CbȫX���r )�\��_q䎯��#[s�~܁so(ˏ���>��@��5]�Ex5*�T���Ѯ��z#�z�"�"gC^Ŵ���o�"���_!��S-������� �A�]|g�3I �IǞ�>PAj��"������Ǟ\	��vbeE�
~E.~�ĊU��?�xa�y/�MG�p�p�*,,<����:^�8�/Zy�|	�c�zVA1�o#���5��@2�E�(�+�Sb�kmZ=�5���1k
Ov�|�]��5�������Z�?=�uP
iҚ݇g��Ж|"��%�z��YSX��i�>Џ�8(��Ժ;�9�����[Iޔ���.�����\�����oGQ�Ha��2�/���_k�@�m���_�l�)���@�y+7�%��Kߛ��b����༃z���+S)+e��2���5�?%F�֦�.���i��fZ��|�=�,(��v�b�ߔź���(8�������*����H�����Z�?%F��[��>�?ҧ?�~�6�hn+�"XM��ص��z����K��(��go�.�z���F��Xy�y��_?�*�~�:�J�L6�i(|oB�=�^�ugR|[bؙ/W�����=O�}sߓ*U�Xl$�7�L�ȥ��Whk*���ak�/�R5��d�݀8�)�p~���)�M�[�B����M��+U��+�x�H��K����W�F�V�i
�;�L/��J<��Q�:��%�S�3�����WE.����C^ſ�c�zHՇ�Ʒ +in.&�h{�� m�[wo�S9���yU�e����fU��S�RҒF�ŷ�Sb���
m��ЖJG�*�=��v�٠7>Kbsh���"ą1_ǇYv��
�����Fda�J\��,������qE1xK1 ��Yy����dP����C�v㞨i���a�g�KIZt�K"�u ��K�j�V�xr%����:Y�Cbȫ���rKH~������;�Ց����E�KZ��[2�����-�]Jh���|l�������b�\�J�	d���k����Z[��o�Bh�B�5�o��`����m�����<K���v����5�k��Z��������2O)�?���_��`�ZS��T�ov*D�\�y�Ѹ��F�/�Ya���H︫A2��n��a�m.a����}�u*D��t�c��OuJ���SA��	�u5AI��l���`S ��������ԩ>H}W��qC�޶L�,�/���_���M�b��K��J=u�Ul/'�]p�^��r�;���p��
��Q�
�c��QxA@_�?%F�~{��=���vE�nS�o#QW�ఙ�����2v�S�?l�L17�9>E"�d�������4HhI���)1��3��o��a+�����\E:p�t��V�CK̴��~��.�ft��.�U%�"k�*"@/ͰC^?�ʐ((rZP����������%kp�'9�6ͩ�5���F'/WY��*�@�%"}@�J�~N���
> ��2P��<&�9�mЛE�i}�ɤ�1��:Gc4�ʈ+���V������<D��^��)1��s�� r$C��_!��S��~YZѿA?�5 ����2�8��M$�K�tr����XhE�}x��+yI��u�|Jy�&~����Qx���:������Ua�l�H��!%�;�����M����#�֔D����c���W���򼰵� ��LF�֤_����PWIY^,G�z�j�2N����*�	���'P@�u�|J�R��_ ������?��oǔ�#���mvj��#��lI��<\=k����^\��9� NGҰc�����w`}!ة=Y�!|u�O�!���d�?�b0��7'�B-V��M�������^�����HC�c�[poU�匫��෼"|=*u�������I>l�z�s��*���S:~g�r�.��9]��B��x7��#m�[�����! V��D���Cb�k�CC�h���iF�#cGg�Ӷ��r��e6��%N��U���A���b�H����t�SI/>�Đ�·>��w[��
���y+G�ۏ�D���%���{h�țv�`�����%j��2\�Cb�k�C)��Î�3��
��3��v��~�S�3�y�[���Koa��d����A�r�}�!�,�!��bC��e�XH�<�~*���!S��u7�si�@��~{���hyՍ~�6�ȎVC��I����)1��!�+�{O1�x�lΤ�
g�;Z}k���k����J��O���z��e_�$)��/��Cb�k�C�,
/��"@�|(C���|������^�G��l�	H��%�ayW������J�12�ҫ`�$v�J���[�3�!��}"��.��5fs�v&���Q��u;ͥYK� (   ��[��h-���͗EQ��A�^\��!�������Q��      b   �  x������@���)�������)ihB'�N:9�c[��Qb��P�CE��ބ��H�sq�[���ox�e�:ߗiS����q��M��Y��hd
ݾO�U�}�����K�P����߇�װo�N;����ӷu�/��x����b&Kn
Ŋn�zW�cɛ��]^w)�@X0ytO���Q9������\������*۶�/�C}R�v���m��d�~�ݲj�SQ����1~�n���u���%�L��@�<x����ߡEo:F������?�]�T���f~�}�f��X\�0��u_���`��)&����4��vZ[-�%A|IXx����L��',N&8�g�ylLC�+0VH��\�֐�	��� ����LSh.c���0cj�\�(��~�
bkM�yl=�7ޯ��*�EO��l�x�4&ħ�i����s ��z�)4�0�4$�8�ũK�ŗ�xY"v�bqᘸG@��Z��Ü�Y��ɭJ���<5      d   �  x��Y;���u�5�B@�MH!��H�)��H" ����V)��� E��1���;���-R�����O�s���7��@��Z��{��������P�yt�o�����m���.��W�>~�z�}��2��}_w?���<�~UU�C�^U�A��̫�/�6�ݘS�~y�Ou;��,[�<��� ����2ݢ*ڤ���=�:A|�
.��mg��);�[�0�������J�x���N6T�_t �� 7b��[�����	���h��ǿ���W[���_%�n�[>I�E��	FՄ�4�sm⽧X�S��	r�=��r4��{h�`ʩ ja{QR����
z'�YM^:n��vxm�.��>��6���ˆz��m�hX^������ǿ����_)|�������Cr���-b�j�,���G��2�qn��C@��]���[���i��0��N?��U[t�)��`U���dA�|*���oȗe�-^~�R����z��=I���h�ڷIˬ}.xsv���})��C��Y�P��e���&�z�"W�K��y;al$m_�2��*ݙ`GṊf����vU��[�i��b۽����^>l��域�&�$��ix����μ5��/��u���D��1^�+�z�Nqܱ��I������f(j+bZVih`�9=���>3@7L[=�rˬ��}���u������7�|��:����kq��D	Yy�!���i0B�D?^�E<�'�{�T�,����cI)���@�oʼ0���ݖ!��gO-�ٴkL�>v�y`�*��X�t�S�l�u�����;UM�.�.��ߌ�Q��T'���Dl��?RY�2�/����]���IPvܩ��3�MA�@'�!C�w���Ơu��5uX;�Y��F\9�����ڇ�̸qm]��RC77=��4Í�֐j<�2Po�p,%���\��]�
�j4:4�%� �>�L`/�l�}Ml�F�</躪}�em��fo
Tn_���_��d�C���ے����(��nTN`���?��A��F'7�:�âc�1�eZ�u�5�c,w(d�t�G�D�!�l�������߈����i�?��'k�~�ǧ�q��BFe4i��`�|TwI:�,J�$�����Í�r\�\�pX��WQ՟3��;�����w"K��I��Ѻ�s6
���Q�|Xւ����un �7�<�Q� �CHtJʪV���E�jK��tTY��\��s���/RD8S%*Z�RB-��
,���T�3}?\�i��*ւ�E�\٬J��~�?��]�x�������0�t3�L@�x��p��Y��+��� ��{)�������wuSB�t�NG��q�l9���i?�w�p��i������<��a�ꓳ�I7����W�����>Ō�߬��RƓ%qU��fp��5�ʺS�(,s�G0؝vin��O"��AH}��U�!WO�b�D��Rs��Le-����o�Ra˩�wk�uҋU�����E?�5���.J0�rH*���e�O��i5�ԝ����QZ���?����ٌ[�@�V���z�c%T�	��,�6~H�����lNN���Ec�'M���~H��J�I}��P ��6���$�>ڜ�V��*4�hly��dL�����I��-!-��R�Q��L�<i�q�  �=����{എ�?&��/�5m;˓���[۸�4#QP�����JS��{������a���y����,Wǆ7<�>���ذp�M�;��t�v�;|ls���맕�gc�WQ���TO6����E��KRW0&����"��&иS�NK�A��(ڠ�݀����0����W�$�N��K�93!g�Ο��ǁ��_w�r#9œ:C�\�+��b�����g��|Le��!	.�5)��A��Ƨ3B�K�r�� �B� Z������A4ܕ�'MI�k�n8� ��}�����|�beBKD;_�b���㭴�Dݠ�3��髓b���U��������ۈ?���E��\@�)����T
�ƾ�p���$���־~�q<��<w�؀w�HN ���A��%��,��:���$���"���cK��Ͳ��i�ozN���״�bOx�	ڑ$=�/' �Y�p��yO��W˺���~��^n�J�[�Q�,:�h�P�T��<f�i*���B�<��/�0�#��y�O��y�G��|���+�㗡��͟K O6eg���qK�
l����%3��	R��i����yu 钗��b�,��Fu���4r���d{��8*ҡ4�+��m�SR�@(�U��Ĝ޳����<3�L��t�}���c�2Ύ�e�j����6Y|�� �� �⺫�2$�;if���'	�Ԕ�@>��,8'��d@xs̓���2z���OvV��C������ �]�l�N񋝀�hAx�!Ã�V&B5�j�`��d��'�L���]�x�'4���vû��ȆOz/~ӌx�!��*O6���2-�L�&�k��6�eb/݀QM�@82��{�Q2+$�=|�!�=���;q��ܓW��=��5t5φ�X�ԝ����w-э�z���jUkW����9�_>x���q�}���6_7�L!Z��	�s/]`��0��59�M<��a��-��>eb�U�0M)I0�Y��[�{ʆ�'��8b�b�? �ę-�aO#�iz���l��uk 6҉ygj�R��|�2�RW�vU1H�i��\���U��Ļ�X;�����p��3�o������O
��w�(�fg��/�jG�u0x}���ZT|�$p@�ɽ>�Q�(�N��5�0��	�^ϖ5 �UЫ���x�.�w���B|�7�a��w���W�v|ӿ'�G&Y�`��Dn�ɼEȨ��3'�U'�1p=O���p�	���j���v})�����������k�Sz�9�����:����2�6��i��InirL1�k���U��=�jb�@���t�p�/nqz6wfq��.�[�~Ћ���*��N��#��x�G�1}�w��C�WU��������zRĝ���t4��Isu򼺆Mތ�5�]K4��N��s$���L��lΡ�PHc^	8�Ym냤;�@��e�`Ri�]�-��o��V���~�퓀���vU�'*��w�bڜ��g\��C�SD\ IZT��&E{���^�&U�|ښ�e��{ ��w��<*d\_t���m�K�'G������O"�ꁶf�[&2���2�>���>�Ѵ$�V��F�A�h(��D����b&T��ށc�S�%�ݔ��w,w春�J�?W�v�%��G��'/����
[ 1�k�)�?9$��Vu�?3~��ޥ�w���X�:%�5b:\w��v]�`���A>T���ue�x�K����s�mWI��ŧl��ih�5D�_�P�l8��q�(�~��(J�ƀl\;���xe�$4�;Þ+�dr<��z�E�t�:�~j['#0#R�]�!t�'��:�GG�u���m7<˚�D��𥴨o���E���N�T5�)b�`s9Hߣ8���Ƨ�J¥�!C�� i�8C�ǙͰ(p�����.�˟T�ɢ{x�Bn�\L�-�z7o9��!���n��p�|�3v�ݶ�]\��69s������pq�����dS?�r|� ���vbR�����?d�8�%��&�'�@�4N�VQ���gˏ!��Eٕ�e��N��b������<m����A�*��x���U���o�޵�;����l���'��FؖqǮV��"����<ۧ����L�e]1����9!ո���TU��$��;"=(fĺ-�B������)����8yo��m�׏��Ɋ~�?��o�퇟p]�=�/0E��_�����j��C��w��
��kޓ�k��=>��l��[c�}zu���pA�:�97���?��˟}���{�      f   V   x�3�4�4�L>�0S!=�ᮥ���%E�y�@�4NCN##]]C+0����X*ZXZZX�Y��2������ f�2      h   �  x���K��H  е�}w������?�6m+�eW.㿩��M��,��*��"�dFrn��XJ� �����v������s���@¸=|x}-��%k���� {����4��{�!}��	��sCms� UW�����[4S1�����+㮔�����ޮz7�%�٨���W��e<�J��2n�Za9H�0�,n�	��q����X`�8J.!�}S��p�����߮?��r�N�D�f"�KNx�M8�M��Y�^�9>*d�iw�	yE*.����yC\M����N��u��%����������%�Fy�Q.�������c䔩�bV�cc�8���Yi֖qTz|����C�	Om[��p��t�/��v�+-���drX�1�E�/ې=5% �d�RH_���Zݮ���~��SG=
���+����i�E$��������,	�9����l�"�<\X�2n��~%���E�վ��2��ef�V���sW�)%}���� r�~��4�tc^W92Aw������҉�p�"\.H'$�D����#YV}���,6���u�qng�(Lg Y3�)Y�h�w�@���2Я��1j�e*le����"�X�%�VsuXg�ܛ�US�V�� �5n���k[m�����~�v��N2�.cbT4�������ӿm�       j   �   x�3�4�,I-.
���y�FF&���
�V��V&�z&f�Ʀx�8=����݃\��9c���A�����Rhڍ���,�-,�Q�,��LL�L�M�̀&;�������p��s��qqq ��*�      l   �  x��X�n�F]��b�kh(�"��CqرZ�I�&F�D�Z�(3��Ȫ誛f��n
��EΏ�Oz/)Z�4#K��6�����s�=T�4��߯?}��\_~�ivq��߄�W�$����d�>�Ë��&���_��N���<ޢ�3����dp}��!?���x��������ԘԬ���Hix��~�R�ߟT�߿$2y5Ҫ��1���ⷶ	@O��G�v}��=�= >a���l����}����i�OM�95Y�'�� >S92YL{j��L)l�⇭��Z��t@�
,�)<E�[X�U�1Oed�����\p1�����␎�LR�&h}Z���;jD���dw�H.�aX�v�rL��u��l�Ek-��
g���|��w�խ���U�ռ��q]Z#')�_��5<��N�i�Z|�bq��)mN�6B��Բ�S����n��<�l�G�s�/yҧ��K�Mp3��V"���Ɋro�x[��Y�Mj֚#���5�.� �ѩ]G��i�ZQ�#�`ă?ܥ1f~`7��1����cD�fן��&�� ��^���p8����5�:�(��9ύ�Z��t�:	��&�{g<�D��a_t5�<�Ѿ i��¶����:-7���E��R����C��i�$�_bk'��4r S�y�i�#��)!Ub�6�_T�	]�:Z��W1�ʫ�><�� �Hgpap�倀Ai�#����\t�w+۴��[WI�����;+8��J{tP<��L�3)��P�#����t@5�#�U��Q�H�6I�Y�Չ�}�*��i�MćQ6�\�d�ZAV�ٱ��V@���Gt���c�e�:�Qز��.��`��Q��j�&�)5�#!����0������-+�֬)��HH��xJI��3V��br��CL��!Cv]������X99M�2����'����)�9x�<DT��v4���AE�**
�s���z�y��vo�(o�¦����d�R�0�� ��O;�j$v����9y��	�<(�!wr�c�l2EA� Vo �R;��'���m��m�­�i"�T�%Q�����&���*�S@��1C+{���ih��w�tXQ�zʡ�0�d���Vq�j��K��}��B<7��c�k�\�5!�>Ϫ��p� q�bz��Z��a�T�6̜#Į�)0����(D0��f��,���Qݒڠ�Y>C,b*B�W�ٌ1S*i��;�ڌy��%��FڽC6ccOً����،5IX�Y:=�߰�,��֌��j.\�A�1)d}�|��&B*���_B5c-�J�+����5cf�i�n=��"m#�I/-���ؓ,��.������:x0�dҷtD��%n�� �Ϋ#�qH"�"���Vh�C�c�.r�B� '�!�v���9i%n��??.9мq������ׯ��E$����X�2ҡ��-��ܹ����S�O9=N5�	[�uA�*�r�ůR*($�k�(˻6r��(*:y�~>esp�S����L�\D�"�ϵ��-{�������C;`�2��\"sj����V\�OoV�Ļ�Jq�{|˷��k;�G2AÉ.�.���E�ܜ螋.�gb�F�";,(��.��R_��^�^�L�� ���d"�"n���k�[����y!�~�����x}��<�{׾V��J�gə��b�V���z�            x�՜Ko]W��ۧ~������A @I��l�.W�(@XO��H�i[��F�n�v����Һ�t�n��J���|��xH�*�(�-�}���s�9�\s-���a�Ÿ^�j_Rlz15���Q6�U-G�������o���ӝv|��7�娭J�����C��+����d�Tu�6��YEݍ�J�a]��e�����sؤ[�t;�Q���U0�]���l�����t��}ȣ�5]
.�Sv&�[���*աtU�:�T�C>���U^}w��+��[��zK�]�w]��6��n�4�߽_�����c��:Yퟜ<{�{�΋�rr�v��d�_�ӹ��勓qx��xq|���w�=���_�QF��Z߉N�9:>zl~�s�b<_�=?�O�rЎ�.�R�+'���~���a9�,�қ�^~>���ho������_J��_j5��`53j�V��8���z�K�E-��Qz$.LZ���Q9�y:~�����k����^��D5L0]%�k#�3�[����(:�R��U���7U"fL?���]�ٜ�uFoU����k���.��l3jU����_��#�>ln��jUT����
sW߄^巴��y�؝�l��K�{���a9�U�� ����3�	tc�*�+c���k��fԠ��i9"�w��C�����$�m��|5=�0FQ�q�z����6[j%w�]�!�2�Kq��O��]tq4���p@"�un�X��/���>7'bUצ՜J�$z˝����짏yt;"��F�֞	��OMr7]�?*G����m�]�^t~��e>��9~U7}Y�H~������~ʭ��N_�����2![��e�g��(��<vR6�ao��X�93J��k�e�5�r�)� ��-���y?ZM��<Ԍ-�乫��۴5�d��
!e�����ѧ'�tt�_�=єt��`/�����̓�U�ۅ�W8G�t8ѕ�8r�G[H���.�ٳ��N`�>��q`�Z�����h��]�s��M+�����w޹�[�:8�h��^@bb�s��u���ֺ݋�	�N�YO�'x"cQ	=Z��Q{������sW��,�aW�]�v`��K�����������$>Α}�ow�����A��{2�N���;w���������'���_⣽�=�7���?�׿}�����O�+��G��{����؟|�o_䰴��M����t&��ck�](�h���b3��x\}���Ҳm�r+'�&
)du9'4�2�ܨ�����Ζ�C�%�R!k&b��>\��A�c(��$m�T��t��� �T�l��G�@�t��^g)*��r�|�VQ	��8��T�@9����s�j����Қ�y���s�eF�������Ē�ʋ��.���T��H�[򫞜��✷Kqy��2�������TA=n�wQ#�G�=jȟ���LN��»�L��e ܔ���^WR�4E���H+�|7S���%l3�e����0��5��/4Ԡ< ��>����%��c����_���|�K�V����G�De��p���'�`G�%ہ�89��E�]��_d��*�	�[NX$X������tlK/�~�K�.�.����%��*���'VI|�S}'e�W��"47�lP�iӐ��%����G��A��������vpuFǛ.�i��ן�������M �m^E ϪGHx��]����F-��W'��/���	@os0���~eL��'��6�]pg0oV9d�������"{��8�|�z����U�\�Ŕ�BR߳�Y7���&�fEP�(���5�q3��Z�w�b��k]��!<��M�����O/W�~���E :`�0Y� �I���c��OT�eP�ʹ%N�W�������-�ńE�e��{p��Pϰ7�*�m�e���~�)1�ނ+֕�Ŧazg/���4�}D,}w�Y�c�#z���7��n���ԡaWUm#��U�fד�ہt���%���ӗ��~��m����,��q��M��(�:���YL���(2:�֤�\���xx��yˀs�nx��ֻw"�x���["Q��搁�/~%����ko]�1e$%aT��6����W�n1xy�J��h�
Ԧ(�'�#QD�'U(F��'����IK��ti��붛<�[�����z�#l{Q��Ӎ���Q^�+�׮������_�pc�}x����
��c�}3����B d�MC����tcl��w!P���I���j����H��r�a J3����J�ĢK�	�����a<QF�PBi���]�yS$����Һ�����Q�o��.��o��	?�x(sq�� !��<:�c7�o�{ߡvw�q��}t���[�/��"��H�dk�0 �bS
-
�)�Z]�k�X��'xՁ>��m�yfc�2 ��UWo))]��K���U>�Ȉ:�6�4}S�F��UQ���?x��W���a��<�e����ku���g��`|`���I�C�v�����×k���-����-��]��	5fr�|��0�����x�'�b���oxh�����L�B�:�}F�;�B�j��qu�Բ�C�}-��z��DA�6�6A��Ec�M����U��Kk����!���m�ޓ��|}t��͂@"��>�4DT�TYC{rpx"t��{l+� I��V��q����6b��=X�kԆq0;1�?�#p�O��@����i�� �j]�9�!�x'Dߑ�}B������T�~� �`<� � -r}�w;J�W�qI������r��n�:K�G�W��4���Y4��f�ܯ�!�k.���h��_������aη��Y�@Վ�Ýw����]L(M��J�ly�� ��vC9��sC#� (�r������:����9�M�%�i]�C��J���F�6�ݎָ���%�:����_��?ݲ�/���.��p��!��zq�c�g)�0rP��1���b�r�V��!!�-��r��z��|����䡎�P�bQ�yc����+�ytZ��tmz��� g`�-��u�-����S�T�q��W��6�A��]���ԈX���	ֹ�ҙ�?E��|Z���4�]�jW
����c�KᏔ|�tI��6_�����̃��;���� �X{�&�)�u`�.���{I=�2"�LU�� B�����e
6?G��p9��� �Mq�a�"Ť��h����`�����?@�!�4y�嫅��v1�-�v��uj�^,�o��z=N��x�Z�_����>��u�����P?{����g_~����u?��w��������W�^^�!E��W,�<3d�x�P��ǒ����s`�WG{@}�o�3�J�w2L��ej �<�7�*�/#KBX[Guͣ�Z����P�:�K��8; CQ��ى"W��&�:Kg���K�"[����%@Xqu�h+~ V������Lɯqu7~sI�{������ݺ�qQf�r{���f��K��]�K��)�3�3ê�6)��=���1h���*��VR�N��:�dڨr�1�C��R5�Y�c�HjW�&��Yb�G&]wJsTΚ�7�Ql$�4`Q��}/2r����N�R�G'O��Ɨ���\���K�W���%�������n���6A/e9-��xѐq�c��!�\���f�ҒIi� �|݄��݊�T样�rGZI/e(�X�M]�������	�*�n�¥�\�${����[���!Q�Hzn�(�P���ֈ��i�X ��0|��>Q2~ �����߀~�:ӥsQ~��'�&���L�àOf�"�v���V��$���rt�|����nېy�v�?��z��j��V�ӹ&6W��+:QSZǵ�!���2P�c�è��{��bǫ�]eSuGg���tws�������$z�uz�Cњ7DX��BmU��Y/K��c���׬�n.	�8ܿx~%9�L�הYה��B��E�[��fI��̛��A��6����VCC��,�y8}ގIT��Q#D��ܚ6CWK��b2)*}7��<n��>�LA1p���N��`*V܀�	���K$���6�-�o��=�X�]�^��M�.���[�F��6E�    t�ŏ��҃
xIYem���|i��\=��5 �#^?���ag6����&�o�8�!0�HY�QU���mQ�Z���Y��u�ج���Ƹ6���&$�R��J�7�4\�C�Cd�|5�P�pǭ��Zˀ�ʀ�C�m^G�|ܵA^ϰ[�$�	�$:��܏����������5���ӣ����d��9�p���s���|i�����{�};>��#ʤ{�=J�����;w̓���|��ag���㥫�)�O�/�b_����������~9�B���!��QKDť��M}�h�.SZY���k�4��3�^�!{U���H�,�˜Ĝ���-q�I�S�����W��j�c�L!D�1]W=��gQ���8�Y�v}�Q�{�������o"m>�G��c.�}_��?+���y�|���߿�㙾���8��8��d���ݷ��raA�N�Wh�8ƨ�/��y6�&�y}F*���+ـ����F�ց��e	x�Zn�I��9�/���<W׫�
S^�"�H.it�T��2���t89Bk ���[�d�1���u�.'�3�T��u���9;�_B�
�z�����}}�"�����!��?|��������w�~��qj���������g߇o��=޿����U�����d��_�O�TΖTNX|���1"����d�`�ɜ)��Un�lZ[b�X\q�=�+f��'�ϰ#�@�Y��C���.Ϛ��J���C&ݩ{��H"E�uEB#󹱌����)S�֑�ʛ0�b��H >.KjW2g��򪵡�2j׸]v����{���OG�N��m�=��$@]��?����4��y�.�&��@0wsϚ���@=�o��و�~չҸ�Nn�F�LDRMM-��G8�>���4/�I�0��m�YD*���R���k6S��J&��̃t��g�.��V�Tg��)��y���{[��N�S�6$4sO�朸o�V�ExS=���6��h���nm/ӧ}K�]�w��Q._���M�y���*}�^%kб�d�qqP�R4�x�TQmE�C��4M�y:d�|��z���E�KU0{/�ƶ�K��zͭP�
@
d?�'����8�6���V�pD��),��j��O��4a�L�4c���
-�Sqě�6���x	�Jn�BΣϮ6ƛKR��˳��[��������)�e�Ǥف�` �2'r��j+Mx���s�W�B�&�-q܋��r���I�{�f	Vv��
�����Lp4$cB��UO�4���D��7�Ǩ�zӫ�*	/�d�ଈ�b\m2��)ر�������FZ&�/VgL�jB��`��_�����S�U��VN�6�7�L9�\f�eq5�%�gSR��go�E���ʲ$8���w�Hj��s��y��E#�s�筤��U�[��,� $�LF6�̤�Eob�k"  ��	]l��ѧ��N^�Pz2X&�a-���kB��ˋ�i��Sﺼ�d���t��o,.[������O>�߻^|�����P�#��O����'�1�C��;�E��l��,ǌZ֙����4��
b���j	Y���)f���1X\?Q銡R'쬊iB¢g7����ɘ�H?5<��P�&���W�aD�"ł��qm0�̓�t��d]�R�S�?��N�J�!{���!�Z$�1�JJV����&ʭ��]�Ѻ�t��������2�
���6��ȵ���Zh�.��o�����[����۽l�S��_�e�m�a��r~:�[4�e�����U���(�������n��t��M��4m��0�%�H3�ݱ8��3�Q#&��{��Џ���J��%A��/����v�e����צ�UCBkY\����!X`-���O՘2V�/�z�h���mo'T���|I2}h�_T�x�Ғ��7� �2�/�ա�6V<��)����Po��:��'�y�6�vi��Y �wJu`�0R�����HB�y���$s;Nv��p�b���ӗ���[����f�l�� ���l��OR�-6�t��ٳ_�Z��5KX�t���RFv�Z݀�e�w�8����f���	W���l�]:�g'J2�2ܰy$GP�ѩԭ��T�*� ��X="և�-d�1LC����?u� Y	�k��N�o���6�^[����.��f����@�����0�XRhSV���2�{v�ë-d9lg=��t�V�|zM���T�|�d�, I(�0D1z׽��ɛ@��G�t�5�Y�6T�z���~����*~- GBLM�w	S �H� Hl@��_�a�!�k���]rW����k'9ܺ���^�zm�\�L��~��w�#[��,�B@zW�֛�����I߮��~y�1�y��[t�>��as��t��	�.�f���^j�M�rnz��&��E��G��ۖ�	�n��*��Q�9��P��Fim��qI-�J�����kg܎������\��<|�v%�>c���IEљؠ�Ŀ����0O<Tf�Ҩ�w}��S����bo����i�և����,�R�a���#���Q ��:� #L�����ബ����(��!�\��&�RBO�0��q��=�9R�B���&��p���S����K{�?�ǯ�.����?P�g��f��z�K�X����� y���9�_�(���-���#�a[��4���EG4����
�d<���v�i��ߍ�N�Q���mh��G��ɦ@TW���K�C��4h�$CǞzO,���#{Y^Eed3�-7��	r���\:�ͭ}�C�ǯ?��[��d��G#��E!�P �EpY�	���v������Q������?z�\٦}��Ew9�b���s�7H����9 ��=N����I��r�K��57�=������s벘������K�*93&�r�St�N3ʲl�&� �D�k���(�|���Kg[�~��?4J�]л���kğ�G^�b�u.���f�E�&�T�}x֗���ԒO[C�^�أ�F��{����Zx�**s�@�k2���Kq=�Jh,?��ȸ3� �>�k��L��!x��t7J�,�i�%R�,B��(Sf���;E�8D�u׎��Dc�2�/.]��[��9Vz}U�W��iM{9�O/�ձ�AW�Ł�Փ��G{VSoe�Хy(��l������'"*y�ۙ�J6N9J��I[z���a|��l�`3�\w;Bk�u��9�Q�����uP
��j�ٕPBƮfh�h�D�.U�������6�^����.�}��5�˦����X��r�xt�Ŗ�y�]u<ݔ=c�-���x�.X-�J����)�>���E��Cī+�6ylώlrh���Z�
����+;�=�Ua���ù/��$��8b�(n����C�ы���s���"g�)Kt��^/�^N�uSݦ]�wQ��r߾t�x�i_���֛K�G�}�/�ǳq������ݿ7w?|������_|�w�;L{�P���Z���_���a
��Pab˟zwK����:ܜ6��Ύ����-ֲUG�E��(1G<�6)�:��!Q;;��]�t��,s6�9�E�ʐU�.lr���|�)��%��o��īZ�՝�{D.��RWA������w}xz7�?<���~���/��O�/����-�}n�sO��u9xn�������3��~�"�3�YZͲ�J-��b��"��tu�͓ӣ~RnL�k�cMVv[H/D��Ô���f$S�4��Dɗ�(&�xL���A"W\u��X�b�5$�N�l!g�>K=L0�(h�pB%_�\�d@3��el޸�j��?���_ލ'���z�ѩy��_u���=��sg�������������<<z���=��s��b *�+�ЯAN��}��g9>��\|��M�n�^&��j�a�63!AH��:�q�E���
5�!M�if�4<'S_�#-j�'�U��e���4G{��iln���l�Ӓ�DXed�Q8�ќ��g�/N�˂W�ܵ8˞��������ʵcDG>���g���ދO�>���/_|<��w��d��ϟ����o��-_��Y�������w��.�ɹ�e1I&� �  W�4�L�.������]�3$���ĸ�nJ�#k�V����d�(��r㑕3�j�2KQ��c�ɐ@��qÚ(g���7��i
�(�PdH���ɤ�Eu�Za:7���@ƌ�5���2`�j��1��2�h0�����W5..������,qV�^gR-���/��� ��zEx�P��ӗ������������d���2�6ik��R���,-e*�P,a��-���c���t^�*�VA��t�`$��xA!�A4d޶9��;C�"L�%~T�d���Ӷ���)�3Д�*�k70��m��Ȣ�Kk�]o^?��疜M�_�Q�Ew�����9�l`>)�����X�Mrg�]�pD	ʡ5[='Rt�T���5��CK4�����d6�߉�Pd��nzr80�֠|��P��F�Ec�{� ��)G�K�V�ê���t@٦����5��e6���uR���v���X#�b�f��[*����|��ovKl����c���Ȫ��K������gm��      o   
  x�Ŕ[��0���*؀͌=3�����)2)�� ���t]��X��B��Kl���|���E��iُ��-6]w<����N�Y��ph�V�؞��a7Y�ݺ�/բݮ�Iߵom����^,-�Mj$��JF@� �
�rjt8�H5��M��%����Fm7��ֿ��tȻ�&�Uʫ��Lک�e�d	�#H�_�M���"g&N�1D��D[�`��d�e,���˗��?>0������/��0F��`3�x�!Ï. X|��x�y�9n�9���suP339?$e{�.g}��ǋ��	�	4$�Lr�d��5�?��s0h���iYM��Q�	r��@M�y��K�W�3}�?l���4�퐔A�Ͳ7�JN��xH�Y���>�Ca"�[�ݹ[�A���8$e�p�'�o%�(�3<���*Ls��UVy��*g���\�H�g�!Ld�pJ�Cx:yd���{73ƪ�+�d��)�ʊ}�{
�dt�a�fH��e�W�y�ȑ����[7$I���h��y��      q   �   x�=��N1��ݧ� ��[")9��ƱVgK�^dЕT�PS�{��s�#��o�	�ّv�	'��l�E��2�;�B�'��G�1\�@�ߟ�1��\n��/p����	f)܃9ݗ��g�q&����Cƫ�Pm��yz�)<���*��r��b���
���6T��ҶLl��m^G�R�F�����c�r32����RtBټ�B9��`]�]X����b�      s   2   x�KJ�4IJ4N�M201�5I40�M423е�4�44N5�LI������ �	�     