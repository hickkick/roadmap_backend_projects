class Presenter
  def initialize(data)
    @data = data
  end

  def print_summary
    types = @data.map { |e| e["type"] }.tally
    puts "Event summary:"
    types.each { |type, count| puts "  #{type}: #{count}" }
  end

  def present_events
    grouped = @data.group_by { |el| el["repo"]["id"] }

    output = ""

    grouped.each do |repo_id, events|
      repo_name = events.first["repo"]["name"]
      output << "Repo: #{repo_name}\n"

      events.sort_by { |e| e["created_at"] }.reverse.each do |event|
        date = event["created_at"][0..9] # yyyy-mm-dd
        desc = case event["type"]
          when "PushEvent"
            # commits = event["payload"]["commits"]&.size || 0
            # "Pushed #{commits} commits"
            commits = event["payload"]["commits"] || []
            if commits.any?
              messages = commits.map { |c| "- #{c["message"]}" }.join("\n      ")
              "Pushed #{commits.size} commit(s):\n      #{messages}"
            else
              "Pushed 0 commits"
            end
          when "IssuesEvent"
            action = event["payload"]["action"]
            issue = event["payload"]["issue"]
            "Issue ##{issue["number"]} #{action}: \"#{issue["title"]}\""
          when "WatchEvent"
            "Starred this repository"
          when "ForkEvent"
            "Forked repository"
          when "CreateEvent"
            ref_type = event["payload"]["ref_type"]
            ref = event["payload"]["ref"]
            # "Created a new #{ref_type} '#{ref}'"
            if ref_type == "repository"
              # Тут ref порожній, тому беремо repo["name"]
              repo_name = event["repo"]["name"].split("/").last
              "Created a new repository '#{repo_name}'"
            else
              "Created a new #{ref_type} '#{ref}'"
            end
          else
            "Did #{event["type"]}"
          end

        output << "  - [#{date}] #{desc}\n"
      end

      output << "\n"
    end

    output
  end
end
