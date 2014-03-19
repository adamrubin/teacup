module Teacup
  module_function
  def calculate(view, dimension, amount)
    if amount.is_a? Proc
      view.instance_exec(&amount)
    elsif amount.is_a?(String) && amount.include?('%')
      location = amount.index '%'
      offset = amount.slice(location+1, amount.size).gsub(' ', '').to_f
      percent = amount.slice(0, location).to_f / 100.0

      case dimension
      when :width
        (view.superview.frame.size.width * percent + offset).round
      when :height
        (view.superview.frame.size.height * percent + offset).round
      else
        raise "Unknown dimension #{dimension}"
      end
    else
      amount
    end
  end
end
