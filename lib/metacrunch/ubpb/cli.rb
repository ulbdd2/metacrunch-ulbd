require_relative "./commands/import_aleph_command"
require_relative "./commands/init_mab_xml_storage_command"

Metacrunch::Cli.setup("ubpb", "Commands for University Library Paderborn") do |r|
  #
  # Init the MAB XML elasticsearch storage
  #
  r.register(Metacrunch::UBPB::InitMabXmlStorageCommand) do |c|
    c.usage "init_mab_xml_storage"
    c.desc "Init ElasticSearch for MAB XML storage"
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
  r.register(Metacrunch::UBPB::ImportAlephCommand) do |c|
    c.usage "import_aleph FILES..."
    c.desc "Import Aleph MAB XML files into ElasticSearch"
    c.option :uri,
      desc: "ElasticSearch URI",
      type: :string,
      required: true
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
      type: :numeric,
      default: 1
  end
end
