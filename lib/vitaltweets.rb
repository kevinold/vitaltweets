require 'yaml'

module VitalTweets

CONF_DIR = File.expand_path('../../config',__FILE__)
CONFIG = YAML::load_file(CONF_DIR + '/twitter.yml')
INCLUDE_KEYWORDS = CONFIG["include_keywords"]
EXCLUDE_KEYWORDS = CONFIG["exclude_keywords"]
INCLUDE_REGEXP = Regexp.new('(' + Regexp.union(INCLUDE_KEYWORDS).source + ')', Regexp::IGNORECASE)

end
