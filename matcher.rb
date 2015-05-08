require './db_connector'

scripts = Script.find_by_sql "SELECT * FROM scripts WHERE 'twitch.tv' like ANY(includes) AND '%' != ANY(includes)"
