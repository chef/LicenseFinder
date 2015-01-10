module LicenseFinder
  module CLI
    class Blacklist < Base
      extend Subcommand
      include MakesDecisions

      desc "list", "List all the blacklisted licenses"
      def list
        say "Blacklisted Licenses:", :blue
        say_each(decisions.blacklisted) { |license| license.name }
      end

      auditable
      desc "add LICENSE...", "Add one or more licenses to the blacklist"
      def add(license, *other_licenses)
        licenses = modify_each(license, *other_licenses) do |l|
          decisions.blacklist(l, txn)
        end
        say "Added #{licenses.join(", ")} to the license blacklist"
      end

      auditable
      desc "remove LICENSE...", "Remove one or more licenses from the blacklist"
      def remove(license, *other_licenses)
        licenses = modify_each(license, *other_licenses) do |l|
          decisions.unblacklist(l, txn)
        end
        say "Removed #{licenses.join(", ")} from the license blacklist"
      end
    end
  end
end
