-- testing for asn association
-- insert into domain (client_id, name, is_monitored)
-- select 1, 'www.test.com', true
-- where not exists (
    -- select 1 from domain where client_id = 1 and name = 'www.test.com'
-- );
-- 
-- insert into asn_company (start_ip, end_ip, join_key, name, domain, type, asn, as_name, as_domain, as_type, country)
-- select '1.1.1.1', '1.1.100.9', null, 'www.test.com', 'www.test.com', 'business', 'AB1234', 'www.test.com', 'www.test.com', 'business', 'USA'
-- where not exists (
    -- select 1 from asn_company where start_ip = '1.1.1.1' and end_ip = '1.1.100.9' and name = 'www.test.com'
-- );
-- 
-- insert into asset_dedup (client_id, domain, domain_id)
-- select 1, 'www.test.com', (
    -- select id from domain where name = 'www.test.com'
-- )
-- where not exists (
    -- select 1 from asset_dedup where client_id = 1 and domain = 'www.test.com'
-- );

insert into tag (name, created_by, client_id)
select 'test tag', 1, 1
where not exists (
    select 1 from tag where name = 'test tag' and created_by = 1 and client_id = 1
);

insert into tag (name, created_by, client_id)
select 'test tag 2', 1, 1
where not exists (
    select 1 from tag where name = 'test tag 2' and created_by = 1 and client_id = 1
);

-- add permissions to add assets
insert into user_role_authorization_scope (authorization_scope_id, user_id, role_id, has_all_clients)
select (select id from authorization_scope where name = 'AuthScope_1_null_1'), 1, 42, true
where not exists (
    select 1 from user_role_authorization_scope where authorization_scope_id = (select id from authorization_scope where name = 'AuthScope_1_null_1') and user_id = 1 and role_id = 42
);

-- add permissions to Tasks / task templates
insert into user_role_authorization_scope (authorization_scope_id, user_id, role_id, has_all_clients)
select (select id from authorization_scope where name = 'AuthScope_1_null_1'), 1, 53, true
where not exists (
    select 1 from user_role_authorization_scope where authorization_scope_id = (select id from authorization_scope where name = 'AuthScope_1_null_1') and user_id = 1 and role_id = 53
);

insert into client (name) 
values ('test client');

-- INSERT INTO task (id, name, description, notes, client_id, status_id, due_by, completed_at, created_by, updated_by, updated_at, created_at, instructions, recurring, started_at, priority_id, assignee) 
-- VALUES 
-- (1, 'Task 1', 'Description 1', 'Notes 1', 1, 1, '2023-01-01T10:00:00Z', '2023-01-02T10:00:00Z', 1, 1, '2023-01-01T10:00:00Z', '2023-01-01T09:00:00Z', 'Instructions 1', false, '2023-01-01T09:30:00Z', 1, 1), 
-- (2, 'Task 2', 'Description 2', 'Notes 2', 2, 2, '2023-01-02T10:00:00Z', '2023-01-03T10:00:00Z', 1, 1, '2023-01-02T10:00:00Z', '2023-01-02T09:00:00Z', 'Instructions 2', true, '2023-01-02T09:30:00Z', 1, 1), 
-- (3, 'Task 3', 'Description 3', 'Notes 3', 1, 3, '2023-01-03T10:00:00Z', '2023-01-04T10:00:00Z', 1, 1, '2023-01-03T10:00:00Z', '2023-01-03T09:00:00Z', 'Instructions 3', false, '2023-01-03T09:30:00Z', 1, 1), 
-- (4, 'Task 4', 'Description 4', 'Notes 4', 1, 1, '2023-01-04T10:00:00Z', '2023-01-05T10:00:00Z', 1, 1, '2023-01-04T10:00:00Z', '2023-01-04T09:00:00Z', 'Instructions 4', true, '2023-01-04T09:30:00Z', 1, 1), 
-- (5, 'Task 5', 'Description 5', 'Notes 5', 2, 2, '2023-01-05T10:00:00Z', '2023-01-06T10:00:00Z', 1, 1, '2023-01-05T10:00:00Z', '2023-01-05T09:00:00Z', 'Instructions 5', false, '2023-01-05T09:30:00Z', 1, 1), 
-- (6, 'Task 6', 'Description 6', 'Notes 6', 1, 3, '2023-01-06T10:00:00Z', '2023-01-07T10:00:00Z', 1, 1, '2023-01-06T10:00:00Z', '2023-01-06T09:00:00Z', 'Instructions 6', true, '2023-01-06T09:30:00Z', 1, 1), 
-- (7, 'Task 7', 'Description 7', 'Notes 7', 2, 3, '2023-01-07T10:00:00Z', '2023-01-08T10:00:00Z', 1, 1, '2023-01-07T10:00:00Z', '2023-01-07T09:00:00Z', 'Instructions 7', false, '2023-01-07T09:30:00Z', 1, 1), 
-- (8, 'Task 8', 'Description 8', 'Notes 8', 1, 2, '2023-01-08T10:00:00Z', '2023-01-09T10:00:00Z', 1, 1, '2023-01-08T10:00:00Z', '2023-01-08T09:00:00Z', 'Instructions 8', true, '2023-01-08T09:30:00Z', 1, 1), 
-- (9, 'Task 9', 'Description 9', 'Notes 9', 1, 1, '2023-01-09T10:00:00Z', '2023-01-10T10:00:00Z', 1, 1, '2023-01-09T10:00:00Z', '2023-01-09T09:00:00Z', 'Instructions 9', false, '2023-01-09T09:30:00Z', 1, 1), 
-- (10, 'Task 10', 'Description 10', 'Notes 10', 1, 1, '2023-01-10T10:00:00Z', '2023-01-11T10:00:00Z', 1, 1, '2023-01-10T10:00:00Z', '2023-01-10T09:00:00Z', 'Instructions 10', true, '2023-01-10T09:30:00Z', 1, 1), 
-- (11, 'Task 11', 'Description 11', 'Notes 11', 2, 1, '2023-01-11T10:00:00Z', '2023-01-12T10:00:00Z', 1, 1, '2023-01-11T10:00:00Z', '2023-01-11T09:00:00Z', 'Instructions 11', false, '2023-01-11T09:30:00Z', 1, 1), 
-- (12, 'Task 12', 'Description 12', 'Notes 12', 1, 1, '2023-01-12T10:00:00Z', '2023-01-13T10:00:00Z', 1, 1, '2023-01-12T10:00:00Z', '2023-01-12T09:00:00Z', 'Instructions 12', true, '2023-01-12T09:30:00Z', 1, 1), 
-- (13, 'Task 13', 'Description 13', 'Notes 13', 1, 1, '2023-01-13T10:00:00Z', '2023-01-14T10:00:00Z', 1, 1, '2023-01-13T10:00:00Z', '2023-01-13T09:00:00Z', 'Instructions 13', false, '2023-01-13T09:30:00Z', 1, 1), 
-- (14, 'Task 14', 'Description 14', 'Notes 14', 1, 1, '2023-01-14T10:00:00Z', '2023-01-15T10:00:00Z', 1, 1, '2023-01-14T10:00:00Z', '2023-01-14T09:00:00Z', 'Instructions 14', true, '2023-01-14T09:30:00Z', 1, 1), 
-- (15, 'Task 15', 'Description 15', 'Notes 15', 1, 1, '2023-01-15T10:00:00Z', '2023-01-16T10:00:00Z', 1, 1, '2023-01-15T10:00:00Z', '2023-01-15T09:00:00Z', 'Instructions 15', false, '2023-01-15T09:30:00Z', 1, 1), 
-- (16, 'Task 16', 'Description 16', 'Notes 16', 1, 1, '2023-01-16T10:00:00Z', '2023-01-17T10:00:00Z', 1, 1, '2023-01-16T10:00:00Z', '2023-01-16T09:00:00Z', 'Instructions 16', true, '2023-01-16T09:30:00Z', 1, 1), 
-- (17, 'Task 17', 'Description 17', 'Notes 17', 2, 1, '2023-01-17T10:00:00Z', '2023-01-18T10:00:00Z', 1, 1, '2023-01-17T10:00:00Z', '2023-01-17T09:00:00Z', 'Instructions 17', false, '2023-01-17T09:30:00Z', 1, 1), 
-- (18, 'Task 18', 'Description 18', 'Notes 18', 1, 1, '2023-01-18T10:00:00Z', '2023-01-19T10:00:00Z', 1, 1, '2023-01-18T10:00:00Z', '2023-01-18T09:00:00Z', 'Instructions 18', true, '2023-01-18T09:30:00Z', 1, 1), 
-- (19, 'Task 19', 'Description 19', 'Notes 19', 1, 1, '2023-01-19T10:00:00Z', '2023-01-20T10:00:00Z', 1, 1, '2023-01-19T10:00:00Z', '2023-01-19T09:00:00Z', 'Instructions 19', false, '2023-01-19T09:30:00Z', 1, 1);

-- add operations role
insert into user_role_authorization_scope (authorization_scope_id, user_id, role_id)
values (1, 1, 53), (1, 1, 54);

-- insert into global.finding_template (name, source_identifier)
-- values ('test', 'abc');
-- insert into global.intermediate_finding(source_identifier, source_code, finding_template_uid)
-- select 'abc', 'abc', (
    -- select uid from global.finding_template where name = 'test'
    -- );
-- insert into cloud_account (id, name)
-- values (123, 'test');
-- insert into asset_dedup (client_id, ip_address, domain, cloud_account_id)
-- values (1, '192.168.1.1', 'example.com', 123);

-- make client 1 a standard asm client
insert into client_client_type (client_id, client_type_id) values (1, 1);



INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (1, '1.0.0.0', '1.0.0.255', '1.0.0.0', 'APNIC and Cloudflare DNS Resolver project', 'cloudflare.com', 'hosting', 'AS13335', 'Cloudflare, Inc.');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (3, '1.0.128.0', '1.0.255.255', '1.0.0.0', 'Dynamic IP Address for residential Broadband Customers', 'totidc.net', 'business', 'AS23969', 'TOT Public Company Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (4, '1.0.16.0', '1.0.31.255', '1.0.0.0', 'i2ts,inc.', 'i2ts.com', 'business', 'AS2519', 'ARTERIA Networks Corporation');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (6, '1.0.4.0', '1.0.7.255', '1.0.0.0', 'Gtelecom Pty Ltd', 'gtelecom.com.au', 'business', 'AS38803', 'Gtelecom Pty Ltd');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (7, '1.0.64.0', '1.0.127.255', '1.0.0.0', 'Enecom,Inc.', 'eneco.nl', 'business', 'AS18144', 'Enecom,Inc.');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (10, '1.1.1.0', '1.1.1.255', '1.1.0.0', 'hello world :)', 'boyolali.go.id', 'hosting', 'AS13335', 'Cloudflare, Inc.');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (12, '1.1.128.0', '1.1.255.255', '1.1.0.0', 'Dynamic IP Address for residential Broadband Customers', 'totidc.net', 'business', 'AS23969', 'TOT Public Company Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (15, '1.1.64.0', '1.1.126.255', '1.1.0.0', 'i2ts,inc.', 'i2ts.com', 'business', 'AS2519', 'ARTERIA Networks Corporation');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (16, '1.1.8.0', '1.1.8.255', '1.1.0.0', 'Yamu Technologies Co., Ltd.', 'yamu.com', 'business', 'AS138421', 'China Unicom');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (19, '1.10.10.0', '1.10.10.255', '1.10.0.0', 'National Internet Exchange of India', 'nixi.in', 'isp', 'AS148000', '1.10.10.10 - Indian Public DNS');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (21, '1.10.128.0', '1.10.139.255', '1.10.0.0', 'Shared Dynamic IP Address for Residential Broadband Services', 'totbb.net', 'isp', 'AS23969', 'TOT Public Company Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (22, '1.10.140.0', '1.10.191.255', '1.10.0.0', 'TOT Public Company Limited', 'totidc.net', 'isp', 'AS23969', 'TOT Public Company Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (24, '1.10.192.0', '1.10.255.255', '1.10.0.0', 'Dynamic IP for ADSL Broadband Service', 'totidc.net', 'isp', 'AS23969', 'TOT Public Company Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (26, '1.100.0.0', '1.100.255.255', '1.100.0.0', 'Korea Telecom', 'kt.com', 'isp', 'AS4766', 'Korea Telecom');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (27, '1.101.0.0', '1.101.255.255', '1.101.0.0', 'Korea Telecom', 'kt.com', 'isp', 'AS4766', 'Korea Telecom');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (28, '1.102.0.0', '1.102.255.255', '1.102.0.0', 'Korea Telecom', 'kt.com', 'isp', 'AS4766', 'Korea Telecom');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (29, '1.103.0.0', '1.103.255.255', '1.103.0.0', 'Korea Telecom', 'kt.com', 'isp', 'AS4766', 'Korea Telecom');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (30, '1.104.0.0', '1.104.255.255', '1.104.0.0', 'Korea Telecom', 'kt.com', 'isp', 'AS4766', 'Korea Telecom');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (31, '1.105.0.0', '1.105.255.255', '1.105.0.0', 'Korea Telecom', 'kt.com', 'isp', 'AS4766', 'Korea Telecom');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (32, '1.106.0.0', '1.106.255.255', '1.106.0.0', 'Korea Telecom', 'kt.com', 'isp', 'AS4766', 'Korea Telecom');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (33, '1.107.0.0', '1.107.255.255', '1.107.0.0', 'Korea Telecom', 'kt.com', 'isp', 'AS4766', 'Korea Telecom');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (34, '1.108.0.0', '1.108.255.255', '1.108.0.0', 'Korea Telecom', 'kt.com', 'isp', 'AS4766', 'Korea Telecom');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (35, '1.109.0.0', '1.109.255.255', '1.109.0.0', 'Korea Telecom', 'kt.com', 'isp', 'AS4766', 'Korea Telecom');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (36, '1.11.0.0', '1.11.255.255', '1.11.0.0', 'LG HelloVision Corp.', 'lghellovision.net', 'isp', 'AS38091', 'LG HelloVision Corp.');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (37, '1.110.0.0', '1.110.255.255', '1.110.0.0', 'Korea Telecom', 'kt.com', 'isp', 'AS4766', 'Korea Telecom');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (38, '1.111.0.0', '1.111.255.255', '1.111.0.0', 'Korea Telecom', 'kt.com', 'isp', 'AS4766', 'Korea Telecom');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (39, '1.112.0.0', '1.112.255.255', '1.112.0.0', 'SOFTBANK Corp.', 'softbank.jp', 'isp', 'AS17676', 'SoftBank Corp.');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (40, '1.113.0.0', '1.113.255.255', '1.113.0.0', 'SOFTBANK Corp.', 'softbank.jp', 'isp', 'AS17676', 'SoftBank Corp.');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (41, '1.114.0.0', '1.114.255.255', '1.114.0.0', 'SOFTBANK Corp.', 'softbank.jp', 'isp', 'AS17676', 'SoftBank Corp.');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (42, '1.115.0.0', '1.115.255.255', '1.115.0.0', 'SOFTBANK Corp.', 'softbank.jp', 'isp', 'AS17676', 'SoftBank Corp.');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (43, '1.116.0.0', '1.116.255.255', '1.116.0.0', 'Tencent cloud computing (Beijing) Co., Ltd.', 'tencent.com', 'hosting', 'AS45090', 'Shenzhen Tencent Computer Systems Company Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (44, '1.117.0.0', '1.117.255.255', '1.117.0.0', 'Tencent cloud computing (Beijing) Co., Ltd.', 'tencent.com', 'hosting', 'AS45090', 'Shenzhen Tencent Computer Systems Company Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (45, '1.118.0.0', '1.118.255.255', '1.118.0.0', 'eleven street,No. 18 Institute of Jingdong headquarters', 'jd.com', 'education', 'AS137753', 'Beijing Jingdong Shangke Information Technology Co. Ltd.');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (46, '1.119.0.0', '1.119.127.255', '1.119.0.0', 'Priority of Fashion(Beijing)Information Technology Co.,Ltd', 'wishisp.com', 'hosting', 'AS58851', 'Priority of Fashion(Beijing)Information Technology Co.,Ltd');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (47, '1.119.128.0', '1.119.255.255', '1.119.0.0', 'BeiJing Wish Network Technology CO.,LTD.', 'wishisp.com', 'hosting', 'AS58851', 'Priority of Fashion(Beijing)Information Technology Co.,Ltd');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (48, '1.12.0.0', '1.12.255.255', '1.12.0.0', 'Tencent cloud computing (Beijing) Co., Ltd.', 'tencent.com', 'hosting', 'AS45090', 'Shenzhen Tencent Computer Systems Company Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (49, '1.120.0.0', '1.120.255.255', '1.120.0.0', 'Telstra Limited', 'telstra.net', 'isp', 'AS1221', 'Telstra Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (50, '1.121.0.0', '1.121.255.255', '1.121.0.0', 'Telstra Limited', 'telstra.net', 'isp', 'AS1221', 'Telstra Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (51, '1.122.0.0', '1.122.255.255', '1.122.0.0', 'Telstra Limited', 'telstra.net', 'isp', 'AS1221', 'Telstra Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (52, '1.123.0.0', '1.123.255.255', '1.123.0.0', 'Telstra Limited', 'telstra.net', 'isp', 'AS1221', 'Telstra Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (53, '1.124.0.0', '1.124.255.255', '1.124.0.0', 'Telstra Limited', 'telstra.net', 'isp', 'AS1221', 'Telstra Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (54, '1.125.0.0', '1.125.255.255', '1.125.0.0', 'Telstra Limited', 'telstra.net', 'isp', 'AS1221', 'Telstra Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (55, '1.126.0.0', '1.126.255.255', '1.126.0.0', 'Telstra Limited', 'telstra.net', 'isp', 'AS1221', 'Telstra Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (56, '1.127.0.0', '1.127.255.255', '1.127.0.0', 'Telstra Limited', 'telstra.net', 'isp', 'AS1221', 'Telstra Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (57, '1.128.0.0', '1.128.255.255', '1.128.0.0', 'Telstra Limited', 'telstra.net', 'isp', 'AS1221', 'Telstra Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (58, '1.129.0.0', '1.129.255.255', '1.129.0.0', 'Telstra Limited', 'telstra.net', 'isp', 'AS1221', 'Telstra Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (59, '1.13.0.0', '1.13.255.255', '1.13.0.0', 'Tencent cloud computing (Beijing) Co., Ltd.', 'tencent.com', 'hosting', 'AS45090', 'Shenzhen Tencent Computer Systems Company Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (60, '1.130.0.0', '1.130.255.255', '1.130.0.0', 'Telstra Limited', 'telstra.net', 'isp', 'AS1221', 'Telstra Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (61, '1.131.0.0', '1.131.255.255', '1.131.0.0', 'Telstra Limited', 'telstra.net', 'isp', 'AS1221', 'Telstra Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (62, '1.132.0.0', '1.132.255.255', '1.132.0.0', 'Telstra Limited', 'telstra.net', 'isp', 'AS1221', 'Telstra Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (63, '1.133.0.0', '1.133.255.255', '1.133.0.0', 'Telstra Limited', 'telstra.net', 'isp', 'AS1221', 'Telstra Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (64, '1.134.0.0', '1.134.255.255', '1.134.0.0', 'Telstra Limited', 'telstra.net', 'isp', 'AS1221', 'Telstra Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (65, '1.135.0.0', '1.135.255.255', '1.135.0.0', 'Telstra Limited', 'telstra.net', 'isp', 'AS1221', 'Telstra Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (66, '1.136.0.0', '1.136.255.255', '1.136.0.0', 'Telstra Limited', 'telstra.net', 'isp', 'AS1221', 'Telstra Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (67, '1.137.0.0', '1.137.255.255', '1.137.0.0', 'Telstra Limited', 'telstra.net', 'isp', 'AS1221', 'Telstra Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (68, '1.138.0.0', '1.138.255.255', '1.138.0.0', 'Telstra Limited', 'telstra.net', 'isp', 'AS1221', 'Telstra Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (69, '1.139.0.0', '1.139.255.255', '1.139.0.0', 'Telstra Limited', 'telstra.net', 'isp', 'AS1221', 'Telstra Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (70, '1.14.0.0', '1.14.255.255', '1.14.0.0', 'Tencent cloud computing (Beijing) Co., Ltd.', 'tencent.com', 'hosting', 'AS45090', 'Shenzhen Tencent Computer Systems Company Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (71, '1.140.0.0', '1.140.255.255', '1.140.0.0', 'Telstra Limited', 'telstra.net', 'isp', 'AS1221', 'Telstra Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (72, '1.141.0.0', '1.141.255.255', '1.141.0.0', 'Telstra Limited', 'telstra.net', 'isp', 'AS1221', 'Telstra Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (73, '1.142.0.0', '1.142.255.255', '1.142.0.0', 'Telstra Limited', 'telstra.net', 'isp', 'AS1221', 'Telstra Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (74, '1.143.0.0', '1.143.255.255', '1.143.0.0', 'Telstra Limited', 'telstra.net', 'isp', 'AS1221', 'Telstra Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (75, '1.144.0.0', '1.144.255.255', '1.144.0.0', 'Telstra Limited', 'telstra.net', 'isp', 'AS1221', 'Telstra Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (76, '1.145.0.0', '1.145.255.255', '1.145.0.0', 'Telstra Limited', 'telstra.net', 'isp', 'AS1221', 'Telstra Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (77, '1.146.0.0', '1.146.255.255', '1.146.0.0', 'Telstra Limited', 'telstra.net', 'isp', 'AS1221', 'Telstra Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (78, '1.147.0.0', '1.147.255.255', '1.147.0.0', 'Telstra Limited', 'telstra.net', 'isp', 'AS1221', 'Telstra Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (79, '1.148.0.0', '1.148.255.255', '1.148.0.0', 'Telstra Limited', 'telstra.net', 'isp', 'AS1221', 'Telstra Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (80, '1.149.0.0', '1.149.255.255', '1.149.0.0', 'Telstra Limited', 'telstra.net', 'isp', 'AS1221', 'Telstra Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (81, '1.15.0.0', '1.15.255.255', '1.15.0.0', 'Tencent cloud computing (Beijing) Co., Ltd.', 'tencent.com', 'hosting', 'AS45090', 'Shenzhen Tencent Computer Systems Company Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (82, '1.150.0.0', '1.150.255.255', '1.150.0.0', 'Telstra Limited', 'telstra.net', 'isp', 'AS1221', 'Telstra Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (83, '1.151.0.0', '1.151.255.255', '1.151.0.0', 'Telstra Limited', 'telstra.net', 'isp', 'AS1221', 'Telstra Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (84, '1.152.0.0', '1.152.255.255', '1.152.0.0', 'Telstra Limited', 'telstra.net', 'isp', 'AS1221', 'Telstra Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (85, '1.153.0.0', '1.153.255.255', '1.153.0.0', 'Telstra Limited', 'telstra.net', 'isp', 'AS1221', 'Telstra Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (86, '1.154.0.0', '1.154.255.255', '1.154.0.0', 'Telstra Limited', 'telstra.net', 'isp', 'AS1221', 'Telstra Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (87, '1.155.0.0', '1.155.255.255', '1.155.0.0', 'Telstra Limited', 'telstra.net', 'isp', 'AS1221', 'Telstra Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (88, '1.156.0.0', '1.156.255.255', '1.156.0.0', 'Telstra Limited', 'telstra.net', 'isp', 'AS1221', 'Telstra Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (89, '1.157.0.0', '1.157.255.255', '1.157.0.0', 'Telstra Limited', 'telstra.net', 'isp', 'AS1221', 'Telstra Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (90, '1.158.0.0', '1.158.255.255', '1.158.0.0', 'Telstra Limited', 'telstra.net', 'isp', 'AS1221', 'Telstra Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (91, '1.159.0.0', '1.159.255.255', '1.159.0.0', 'Telstra Limited', 'telstra.net', 'isp', 'AS1221', 'Telstra Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (92, '1.16.0.0', '1.16.63.255', '1.16.0.0', 'DAOU TECHNOLOGY', 'daou.co.kr', 'hosting', 'AS45996', 'DAOU TECHNOLOGY');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (93, '1.16.64.0', '1.16.255.255', '1.16.0.0', 'Asia Pacific Network Information Centre', 'net.ru', 'isp', 'AS1221', 'Telstra Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (94, '1.160.0.0', '1.160.255.255', '1.160.0.0', 'Chunghwa Telecom Co.,Ltd.', 'twnic.tw', 'isp', 'AS3462', 'Data Communication Business Group');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (95, '1.161.0.0', '1.161.255.255', '1.161.0.0', 'Chunghwa Telecom Co.,Ltd.', 'twnic.tw', 'isp', 'AS3462', 'Data Communication Business Group');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (96, '1.162.0.0', '1.162.255.255', '1.162.0.0', 'Chunghwa Telecom Co.,Ltd.', 'twnic.tw', 'isp', 'AS3462', 'Data Communication Business Group');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (97, '1.163.0.0', '1.163.255.255', '1.163.0.0', 'Chunghwa Telecom Co.,Ltd.', 'twnic.tw', 'isp', 'AS3462', 'Data Communication Business Group');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (98, '1.164.0.0', '1.164.255.255', '1.164.0.0', 'Chunghwa Telecom Co.,Ltd.', 'twnic.tw', 'isp', 'AS3462', 'Data Communication Business Group');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (99, '1.165.0.0', '1.165.255.255', '1.165.0.0', 'Chunghwa Telecom Co.,Ltd.', 'twnic.tw', 'isp', 'AS3462', 'Data Communication Business Group');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (100, '1.166.0.0', '1.166.255.255', '1.166.0.0', 'Chunghwa Telecom Co.,Ltd.', 'twnic.tw', 'isp', 'AS3462', 'Data Communication Business Group');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (101, '1.167.0.0', '1.167.255.255', '1.167.0.0', 'Chunghwa Telecom Co.,Ltd.', 'twnic.tw', 'isp', 'AS3462', 'Data Communication Business Group');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (102, '1.168.0.0', '1.168.255.255', '1.168.0.0', 'Chunghwa Telecom Co.,Ltd.', 'twnic.tw', 'isp', 'AS3462', 'Data Communication Business Group');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (103, '1.169.0.0', '1.169.255.255', '1.169.0.0', 'Chunghwa Telecom Co.,Ltd.', 'twnic.tw', 'isp', 'AS3462', 'Data Communication Business Group');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (104, '1.17.0.0', '1.17.255.255', '1.17.0.0', 'Asia Pacific Network Information Centre', 'net.ru', 'isp', 'AS1221', 'Telstra Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (105, '1.170.0.0', '1.170.255.255', '1.170.0.0', 'Chunghwa Telecom Co.,Ltd.', 'twnic.tw', 'isp', 'AS3462', 'Data Communication Business Group');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (106, '1.171.0.0', '1.171.255.255', '1.171.0.0', 'Chunghwa Telecom Co.,Ltd.', 'twnic.tw', 'isp', 'AS3462', 'Data Communication Business Group');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (107, '1.172.0.0', '1.172.255.255', '1.172.0.0', 'Chunghwa Telecom Co.,Ltd.', 'twnic.tw', 'isp', 'AS3462', 'Data Communication Business Group');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (108, '1.173.0.0', '1.173.255.255', '1.173.0.0', 'Chunghwa Telecom Co.,Ltd.', 'twnic.tw', 'isp', 'AS3462', 'Data Communication Business Group');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (109, '1.174.0.0', '1.174.255.255', '1.174.0.0', 'Chunghwa Telecom Co.,Ltd.', 'twnic.tw', 'isp', 'AS3462', 'Data Communication Business Group');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (110, '1.175.0.0', '1.175.255.255', '1.175.0.0', 'Chunghwa Telecom Co.,Ltd.', 'twnic.tw', 'isp', 'AS3462', 'Data Communication Business Group');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (111, '1.176.0.0', '1.176.255.255', '1.176.0.0', 'LG HelloVision Corp.', 'lghellovision.net', 'isp', 'AS38091', 'LG HelloVision Corp.');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (112, '1.177.0.0', '1.177.255.255', '1.177.0.0', 'LG HelloVision Corp.', 'lghellovision.net', 'isp', 'AS38091', 'LG HelloVision Corp.');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (113, '1.178.0.0', '1.178.31.255', '1.178.0.0', 'ISEEK', 'iseek.com.au', 'hosting', 'AS9723', 'iseek Communications Pty Ltd');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (114, '1.178.112.0', '1.178.143.255', '1.178.0.0', 'Palestine Telecommunications Company (PALTEL)', 'paltel.ps', 'isp', 'AS12975', 'Palestine Telecommunications Company (PALTEL)');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (115, '1.178.144.0', '1.178.159.255', '1.178.0.0', 'iseek Communications', 'iseek.com.au', 'hosting', 'AS9723', 'iseek Communications Pty Ltd');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (116, '1.178.160.0', '1.178.174.255', '1.178.0.0', 'ISEEK', 'iseek.com.au', 'hosting', 'AS9723', 'iseek Communications Pty Ltd');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (117, '1.178.175.0', '1.178.175.255', '1.178.0.0', 'VONEX', 'vonex.com.au', 'business', 'AS9313', 'Network Technology (AUST) P/L');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (118, '1.178.176.0', '1.178.191.255', '1.178.0.0', 'ISEEK', 'iseek.com.au', 'hosting', 'AS9723', 'iseek Communications Pty Ltd');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (119, '1.178.192.0', '1.178.207.255', '1.178.0.0', 'iseek Communications', 'iseek.com.au', 'hosting', 'AS9723', 'iseek Communications Pty Ltd');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (120, '1.178.208.0', '1.178.223.255', '1.178.0.0', 'Palestine Telecommunications Company (PALTEL)', 'paltel.ps', 'isp', 'AS12975', 'Palestine Telecommunications Company (PALTEL)');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (121, '1.178.224.0', '1.178.255.255', '1.178.0.0', 'Orange Espagne FTTH Users', 'orange.com', 'isp', 'AS12479', 'Orange Espagne SA');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (122, '1.178.32.0', '1.178.47.255', '1.178.0.0', 'Huawei Cloud Brazil POP', 'huawei.com', 'hosting', 'AS136907', 'HUAWEI CLOUDS');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (123, '1.178.48.0', '1.178.63.255', '1.178.0.0', 'Huawei Cloud Argentina POP', 'huawei.com', 'business', 'AS136907', 'HUAWEI CLOUDS');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (124, '1.178.64.0', '1.178.79.255', '1.178.0.0', 'ISEEK', 'iseek.com.au', 'hosting', 'AS9723', 'iseek Communications Pty Ltd');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (125, '1.178.80.0', '1.178.80.15', '1.178.0.0', 'HOSPITALITY MEDIA PTY LTD', 'iseek.com.au', 'hosting', 'AS9723', 'iseek Communications Pty Ltd');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (126, '1.178.80.16', '1.178.80.31', '1.178.0.0', 'Net Evolution Pty Ltd', 'iseek.com.au', 'hosting', 'AS9723', 'iseek Communications Pty Ltd');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (127, '1.178.80.32', '1.178.80.47', '1.178.0.0', 'INTERNET MEDIA NETWORK PTY LTD', 'iseek.com.au', 'hosting', 'AS9723', 'iseek Communications Pty Ltd');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (128, '1.178.80.48', '1.178.80.63', '1.178.0.0', 'TRANSPORT MEDIA PTY LTD', 'iseek.com.au', 'hosting', 'AS9723', 'iseek Communications Pty Ltd');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (129, '1.178.80.64', '1.178.80.79', '1.178.0.0', 'INFORMATION PUBLISHING PTY LTD', 'iseek.com.au', 'hosting', 'AS9723', 'iseek Communications Pty Ltd');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (130, '1.178.80.80', '1.178.95.255', '1.178.0.0', 'ISEEK', 'iseek.com.au', 'hosting', 'AS9723', 'iseek Communications Pty Ltd');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (131, '1.178.96.0', '1.178.111.255', '1.178.0.0', 'iseek Communications', 'iseek.com.au', 'hosting', 'AS9723', 'iseek Communications Pty Ltd');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (132, '1.179.0.0', '1.179.31.255', '1.179.0.0', 'ISEEK', 'iseek.com.au', 'hosting', 'AS9723', 'iseek Communications Pty Ltd');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (133, '1.179.112.0', '1.179.127.255', '1.179.0.0', 'Sendinblue SAS', 'brevo.com', 'hosting', 'AS396982', 'Google LLC');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (134, '1.179.128.0', '1.179.128.16', '1.179.0.0', 'Static IP addresses for Leased Internet service', 'totbb.net', 'isp', 'AS131293', 'TOT Public Company Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (135, '1.179.128.100', '1.179.128.103', '1.179.0.0', 'Multi-Sign,Khon Kaen Province', 'totbb.net', 'isp', 'AS131293', 'TOT Public Company Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (136, '1.179.128.104', '1.179.128.115', '1.179.0.0', 'Static IP addresses for Leased Internet service', 'totbb.net', 'isp', 'AS131293', 'TOT Public Company Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (137, '1.179.128.116', '1.179.128.119', '1.179.0.0', 'HuaySak-SAO,Samut Sakhon Province', 'totbb.net', 'isp', 'AS131293', 'TOT Public Company Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (138, '1.179.128.120', '1.179.128.127', '1.179.0.0', 'Office of Education Region 10 , Phetchaburi', 'totbb.net', 'isp', 'AS131293', 'TOT Public Company Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (139, '1.179.128.128', '1.179.128.131', '1.179.0.0', 'Na Wang Community Hospital , Nong Bua Lam Phu', 'totbb.net', 'isp', 'AS131293', 'TOT Public Company Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (140, '1.179.128.132', '1.179.128.135', '1.179.0.0', 'Dragon International Furniture Co.,Ltd.,Narathiwat Province', 'totbb.net', 'isp', 'AS131293', 'TOT Public Company Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (141, '1.179.128.136', '1.179.128.143', '1.179.0.0', 'Static IP addresses for Leased Internet service', 'totbb.net', 'isp', 'AS131293', 'TOT Public Company Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (142, '1.179.128.144', '1.179.128.151', '1.179.0.0', 'Mr.Sit Khomwong,Samut Sakhon Province', 'totbb.net', 'isp', 'AS131293', 'TOT Public Company Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (143, '1.179.128.152', '1.179.128.159', '1.179.0.0', 'Static IP addresses for Leased Internet service', 'totbb.net', 'isp', 'AS131293', 'TOT Public Company Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (144, '1.179.128.160', '1.179.128.167', '1.179.0.0', 'nikon,Lop Buri Province', 'nikon.com', 'business', 'AS131293', 'TOT Public Company Limited');
INSERT INTO public.asn_company (id, start_ip, end_ip, join_key, name, domain, type, asn, as_name) VALUES (145, '1.179.128.168', '1.179.128.199', '1.179.0.0', 'Static IP addresses for Leased Internet service', 'totbb.net', 'isp', 'AS131293', 'TOT Public Company Limited');
