require "test_helper"
require "govspeak_test_helper"

require "ostruct"

class GovspeakSectionTest < Minitest::Test
    include GovspeakTestHelper

  def compress_html(html)
    html.gsub(/[\n\r]+[\s]*/, "")
  end

  test "section elements with ID won't be duplicated" do
    govspeak = " 
$Section
##### Example header
section content example
$Section

$Section
##### Example header
section content example again
$Section
" 
            
    rendered = Govspeak::Document.new(govspeak).to_html

    expected_html_output = %(<div class="section">
    <h5 id="section-1-example-header">Example header</h5>
    <p>section content example</p>
    </div>

    <div class="section">
    <h5 id="section-2-example-header">Example header</h5>
    <p>section content example again</p>
    </div>
    )

    assert_equal(compress_html(expected_html_output), compress_html(rendered))
  end
end