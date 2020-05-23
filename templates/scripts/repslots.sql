

CREATE TEMPORARY TABLE slots (
  slot_name name
);

{% for slot in postgresql_replication_slots %}
INSERT INTO slots (slot_name) VALUES ('{{slot}}');
{% endfor %}

-- remove unused slots

SELECT CASE WHEN count(pg_drop_replication_slot(pg_replication_slots.slot_name)) <> 0
            THEN 'Droped'
            ELSE ''
       END
  FROM pg_replication_slots
  LEFT JOIN slots ON slots.slot_name = pg_replication_slots.slot_name
  WHERE slots ISNULL;

-- add new slots
SELECT CASE WHEN count(pg_create_physical_replication_slot(slots.slot_name)) <> 0
            THEN 'Added'
            ELSE ''
       END
  FROM slots
  LEFT JOIN pg_replication_slots ON pg_replication_slots.slot_name = slots.slot_name
  WHERE pg_replication_slots ISNULL;
