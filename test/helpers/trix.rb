# Thanks to: https://medium.com/eighty-twenty/testing-the-trix-editor-with-capybara-and-minitest-158f895ad15f
# I read somewhere that .set is slow. Some stackoverflow comment I can't find now.

def fill_in_trix(id, with:)
  find(:xpath, "//trix-editor[@id='#{id}']").click.set(with)
end

def find_trix(id)
  find(:xpath, "//*[@id='#{id}']", visible: false)
end
