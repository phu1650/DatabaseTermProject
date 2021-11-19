select (r6.total)/(r8.people) as average, r6.brand as brand from
  (select sum(r5.total) as total, r5.brand as brand from
    (select distinct r4.p_id as p_id,r4.total as total, brand from equipment natural join equipment_series natural join
      (select r2.p_id as p_id, r3.total as total from 
        (select r1.id as p_id from photographer, 
          (select id, birthdate from user natural join user_national_id where
            birthdate between '1997-01-01' and '2008-12-31') r1
          where r1.id = photographer.p_id) r2 
          join
          (select p_id, sum(amount) as total from matching natural join payment 
          where payment.datetime BETWEEN '2015-11-01' AND '2015-11-30' 
          group by p_id) r3
      where r2.p_id = r3.p_id) r4
    where type = 'camera') r5
  group by r5.brand ) r6 natural join
  (select count(r7.p_id) as people, r7.brand as brand from 
  (select distinct p_id, brand from equipment natural join equipment_series
  where type = 'camera') r7
  group by r7.brand) r8
order by average desc;

-- ------------------------------------------------------------------------------------------------

CREATE TABLE equipment(
  series VARCHAR(255) NOT NULL ,
  p_id VARCHAR(10) NOT NULL REFERENCES photographer(p_id) ON DELETE NO ACTION,
  price INT NOT NULL ,
  PRIMARY KEY (series,p_id),
  CHECK (price > 0 )
);

CREATE TABLE equipment_series(
  series VARCHAR(255) NOT NULL REFERENCES equipment(series) ON DELETE CASCADE,
  brand VARCHAR(255) NOT NULL,
  type enum('camera', 'lens', 'other') NOT NULL,
  PRIMARY KEY (series)
);

INSERT INTO equipment VALUES
('A100','0000000005',29999),
('B200','0000000006',31999),
('C300','0000000007',46099),
('D400','0000000008',59999),
('E500','0000000006',99000),
('B250','0000000006',30999),
('C350','0000000007',32599),
('D450','0000000008',12999),
('B275','0000000006',10999);

INSERT INTO equipment_series VALUES
('A100','CANON','camera'),
('B200','SONY','lens' ),
('C300','OLYMPUS','camera'),
('D400','PANASONIC','camera'),
('E500','METAVERSE','camera'),
('B250','SONY','camera'),
('C350','SONY','camera'),
('D450','METAVERSE','camera'),
('B275','SONY','camera');
