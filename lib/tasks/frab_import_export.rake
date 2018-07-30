namespace :frab do
  task default: :conference_export

  desc 'export a frab conference. Optionally set CONFERENCE=acronym to specify which conference to export. Current conference will be exported, when parameter is not set. The conference data is written to tmp/frab_export'
  task conference_export: :environment do
    conference = if ENV['CONFERENCE']
                   Conference.find_by(acronym: ENV['CONFERENCE'])
                 else
                   Conference.current
                 end
    require 'import_export_helper.rb'
    ImportExportHelper.new(conference).run_export
  end

  desc "import a frab conference. The import will merge the conference with existing data. If the conference already exists, the import won't run. Optionally set FRAB_EXPORT=directory to specify from where to load the exported files."
  task conference_import: :environment do
    export_path = if ENV['FRAB_EXPORT']
                    ENV['FRAB_EXPORT']
                  else
                    'tmp/frab_export'
                  end
    require 'import_export_helper.rb'
    ImportExportHelper.new.run_import(export_path)
  end

  desc "export events"
  task simple_export: :environment do
    CSV.open("tmp/simple_export.csv", "w", col_sep: ";", headers: true) do |csv|
      csv << %w(title duration speakers)

      c = Conference.find_by(acronym: ENV["CONFERENCE"])
      c.events.each do |e|
        csv << [ e.title, e.time_slots * c.timeslot_duration, e.event_people.map { |ep| "#{ep.person.full_name} (#{ep.event_role})" }.join(",") ].flatten
      end
    end
  end
end
