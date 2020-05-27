require "helper"

class TestLiquidComponent < Minitest::Test
  def setup
    test_name = "I'm a component!"
    test_description = "This is **cool**."
    test_variable_description = "This variable is the real deal."

    template = <<~LIQUID
    ---
    name: #{test_name}
    description: #{test_description}
    variables:
      data: string
      is_real: [boolean, #{test_variable_description}]
      optional?: number
    random:
      - stuff: 123
    totally_random: "whoa"
    ---
    {% tag %} {{ data }}
    LIQUID

    @test_h = {
      metadata: {
        name: test_name,
        description: test_description,
        variables: [
          { name: :data, type: :string, required: true },
          { name: :is_real, type: :boolean, required: true, description: test_variable_description },
          { name: :optional, type: :number, required: false }
        ],
        additional: {"random"=>[{"stuff"=>123}], "totally_random"=>"whoa"}
      },
      content: "{% tag %} {{ data }}\n"
    }

    @component = LiquidComponent.parse(template)
  end

  def test_name
    assert_equal @test_h[:metadata][:name], @component.name
  end

  def test_description
    assert_equal @test_h[:metadata][:description], @component.description
  end

  def test_variables
    assert_equal :string, @component.variables.first.type
    assert_equal :boolean, @component.variables[1].type
    assert_equal @test_h[:metadata][:variables][1][:description], @component.variables[1].description
  end

  def test_optional_variables
    assert_equal :optional, @component.variables[2].name
    assert_equal :number, @component.variables[2].type
    refute @component.variables[2].required
    assert @component.variables[1].required
  end

  def test_content
    assert_equal @test_h[:content], @component.content
  end

  def test_additional_metadata
    assert_equal @test_h[:metadata][:additional], @component.additional_metadata
  end

  def test_to_h
    assert_equal @test_h, @component.to_h
  end

  def test_empty_variables
    template = <<~LIQUID
    ---
    name: I'm a component!
    ---
    {% tag %} {{ data }}
    LIQUID

    component = LiquidComponent.parse(template)
    assert_equal [], component.variables
  end

  def test_missing_front_matter
    template = <<~LIQUID
    {% tag %} {{ data }}
    LIQUID

    component = LiquidComponent.parse(template)
    assert_nil component.name
    assert_equal [], component.variables
    assert_includes component.content, "{{ data }}"
  end

  def test_missing_everything
    component = LiquidComponent.parse(nil)
    assert_nil component.name
    assert_equal [], component.variables
    assert_equal component.content, ""
  end
end
