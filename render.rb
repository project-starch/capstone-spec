require "asciidoctor"
require "asciidoctor-pdf"
require "asciidoctor-diagram"

adoc_filename = ARGV[0]
output_filename = ARGV[1]
output_format = ARGV[2]
ref_filename = ARGV[3]

$refs = Hash.new
$repo = ''
$revision = '' 

if ref_filename
    # load the sail reference table
    fileObj = File.new(ref_filename, "r")
    first_line = true
    while (line = fileObj.gets)
        if first_line
            first_line = false
            # this is the revision hash
            $repo, $revision = line.strip().split(' ', 2)
        else
            label, file_name, line_no = line.strip().split(' ', 3)
            $refs[label] = [file_name, line_no]
        end
    end
    fileObj.close
end

class GithubRefInlineMacro < Asciidoctor::Extensions::InlineMacroProcessor
  use_dsl

  named :github_ref
  name_positional_attributes 'text'

  def process parent, target, attrs
    doc = parent.document
    text = attrs['text']
    label = target

    if !$refs.has_key?(label)
        puts "ERROR: label \"#{label}\" not found in reference table"
        exit 1
    end
    target = "https://github.com/#{$repo}/blob/#{$revision}/#{$refs[label][0]}#L#{$refs[label][1]}"
    doc.register :links, target
    node = create_anchor parent, text, type: :link, target: target

    create_inline parent, :quoted, %(#{node.convert})
  end
end

Asciidoctor::Extensions.register do
  inline_macro GithubRefInlineMacro
end


Asciidoctor.convert_file adoc_filename, safe: :safe, backend: output_format, to_file: output_filename
