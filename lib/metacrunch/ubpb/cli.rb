require_relative "./cli/import_aleph_command"
require_relative "./cli/init_index_command"
require_relative "./cli/mab2snr_command"

Metacrunch::Cli.setup("ubpb", "Commands for University Library Paderborn") do |r|
  #
  # Init elasticsearch index for storage
  #
  r.register(Metacrunch::UBPB::Cli::InitIndexCommand) do |c|
    c.name  "init_index"
    c.usage "init_index"
    c.desc  "Init ElasticSearch for MAB XML storage"

    c.option :uri,
      desc: "ElasticSearch URI",
      type: :string,
      required: true
    c.option :override,
      desc: "Override if exists (ALL DATA WILL BE LOST)",
      type: :boolean,
      default: false
    c.option :log,
      desc: "Turn on ElasticSearch logging",
      type: :boolean,
      default: false
  end

  #
  # Load Aleph MAB XML into elastic search
  #
  r.register(Metacrunch::UBPB::Cli::ImportAlephCommand) do |c|
    c.name  "import_aleph"
    c.usage "import_aleph FILES..."
    c.desc  "Import Aleph MAB XML files into ElasticSearch"

    c.option :uri,
      desc: "ElasticSearch URI for the (target) MAB XML data",
      type: :string,
      default: "elasticsearch://localhost/mab_xml/document"
    c.option :log,
      desc: "Turn on ElasticSearch logging",
      type: :boolean,
      default: false
    c.option :bulk_size,
      desc: "Bulk size when writing to ElasticSearch",
      type: :numeric,
      default: 250
    c.option :no_of_procs,
      desc: "Number of parallel processes",
      aliases: "-n",
      type: :numeric,
      default: 1
  end

  #
  # Normalizes MAB to SNR
  #
  r.register(Metacrunch::UBPB::Cli::Mab2SnrCommand) do |c|
    c.name  "mab2snr"
    c.usage "mab2snr"
    c.desc  "Normalize MAB into SNR"
    c.option :source_uri,
      desc: "ElasticSearch URI for the (source) MAB XML data",
      type: :string,
      default: "elasticsearch://localhost/mab_xml/document"
    c.option :target_uri,
      desc: "ElasticSearch URI for the (target) SNR data",
      type: :string,
      default: "elasticsearch://localhost/snr/document"
    c.option :log_es,
      desc: "Turn on ElasticSearch logging",
      type: :boolean,
      default: false
    c.option :log_mab,
      desc: "Log MAB XML record",
      type: :boolean,
      default: false
    c.option :log_snr,
      desc: "Log SNR (XML) record",
      type: :boolean,
      default: false
    c.option :bulk_size,
      desc: "Bulk size when reading/writing to ElasticSearch",
      type: :numeric,
      default: 250
    c.option :no_of_procs,
      desc: "Number of parallel processes",
      aliases: "-n",
      type: :numeric,
      default: 1
    c.option :timestamp,
      desc: "ElasticSearch date/time expression to query only MAB records that changed since given timestamp",
      type: :string
    c.option :id,
      desc: "Only process the MAB record with the given id",
      type: :string
  end
end
