module JobsHelper
  def name_for(job)
    html = ''
    html << job.title
    if job.committee
      html <<  "<span class='muted'> - #{job.committee.name} committee"
    end
    html.html_safe
  end
end
