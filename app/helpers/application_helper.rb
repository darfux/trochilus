module ApplicationHelper
  require 'ch_transer'
  def get_brief_text(text, num=6)
    if text[0..num].ascii_only?
      text[0..num*2] << '...'
    else
      text[0..num] << '...'
    end
  end
end
