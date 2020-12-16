
require 'awesome_print'
require 'pry'

# https://adventofcode.com/2020/day/16
class TicketTranslation
  attr_accessor(
    :tickets,
    :rules
  )

  def initialize(lines)
    rules, ticket_str = lines.join("\n").split("your ticket:")

    @rules = Hash[rules.split("\n").map do |rule|
      k, ranges = rule.split(":").map(&:strip)
      parsed_ranges = ranges.split(" or ").map(&:strip).map! do |range|
        a, b = range.split("-").map(&:to_i)
        a..b
      end
      [k, parsed_ranges]
    end]

    your_ticket, nearby_tickets = ticket_str.strip.split("nearby tickets:")

    @tickets = []
    @tickets << your_ticket.strip
    @tickets.concat nearby_tickets.strip.split("\n").map(&:strip)
    @tickets.map! { |t| t.split(",").map(&:to_i) }
  end

  def all_rules
    @all_rules ||= @rules.values.flatten
  end

  def invalid_ticket?(ticket)
    ticket.select do |num|
      !all_rules.any? { |r| r.include?(num) }
    end
  end

  def calc_part_one
    _, *nearby_tickets = @tickets

    total = 0
    nearby_tickets.map do |ticket|
      total += invalid_ticket?(ticket).sum
    end

    total
  end

  def eval_rule(rule, num)
    rules[rule].any? { |x| x.include?(num) }
  end

  def eval_ticket_with_rules(ticket, rules, offset = 0)
    rules.each_with_index do |rule, idx|
      return false unless eval_rule(rule, ticket[idx + offset])
    end
    true
  end

  def calc_part_two
    your_ticket, *nearby_tickets = @tickets

    valid_nearby_tickets = nearby_tickets.select do |ticket|
      invalid_ticket?(ticket).length == 0
    end

    rule_indexes = {}
    rules.keys.each do |rule|
      your_ticket.each_with_index do |_, idx|
        found = valid_nearby_tickets.all? { |ticket| eval_rule(rule, ticket[idx]) }
        if found
          if rule_indexes.has_key?(rule)
            rule_indexes[rule] << idx
          else
            rule_indexes[rule] = Set.new
            rule_indexes[rule] << idx
          end
        end
      end
    end

    final = []
    while final.reject(&:nil?).length < your_ticket.length
      rule_indexes.select {|_, v| v.length == 1 }.each do |rule, v|
        idx = v.first
        final[idx] = rule
        rule_indexes.delete(rule)
        rule_indexes.map do |_,v|
          v.delete(idx)
        end
      end
    end

    final = Hash[final.zip(your_ticket)]

    final.values_at(*final.keys.grep(/\Adeparture/)).inject(&:*)
  end
end
