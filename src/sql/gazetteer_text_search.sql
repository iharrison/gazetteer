﻿-- ###############################################################################
-- 
--  Copyright 2015 Crown copyright (c)
--  Land Information New Zealand and the New Zealand Government.
--  All rights reserved
-- 
--  This program is released under the terms of the new BSD license. See the 
--  LICENSE file for more information.
-- 
-- ###############################################################################

SET search_path=gazetteer, public;
SET search_path=gazetteer, public;

DROP TEXT SEARCH CONFIGURATION IF EXISTS gazetteer.gaz_tsc CASCADE;
DROP TEXT SEARCH DICTIONARY IF EXISTS gazetteer.gaz_dict CASCADE;

CREATE TEXT SEARCH DICTIONARY gazetteer.gaz_dict ( TEMPLATE=pg_catalog.simple);
CREATE TEXT SEARCH CONFIGURATION gazetteer.gaz_tsc( COPY=english);
ALTER TEXT SEARCH CONFIGURATION gazetteer.gaz_tsc ALTER MAPPING FOR asciiword, asciihword, word, hword WITH gazetteer.gaz_dict;

CREATE INDEX gaz_name_ts_idx ON name USING gin(to_tsvector('gazetteer.gaz_tsc',gaz_plainText2(name::text)));
