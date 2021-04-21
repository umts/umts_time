# frozen_string_literal: true

module UMTSTime
  module CoreExt
    module Range
      module Calculations
        def overlap(*others)
          overlaps = []

          others.each do |other|
            if cover?(other.begin) && cover?(other.end)
              overlaps << other.clone
            elsif other.cover?(self.begin) && other.cover?(self.end)
              overlaps << clone
            elsif cover?(other.begin)
              if exclude_end?
                overlaps << (other.begin...self.end)
              else
                overlaps << (other.begin..self.end)
              end
            elsif cover?(other.end)
              if other.exclude_end?
                overlaps << (self.begin...other.end)
              else
                overlaps << (self.begin..other.end)
              end
            end
          end

          case overlaps.size
          when 0
            nil
          when 1
            overlaps[0]
          else
            overlaps
          end
        end

        def length
          self.end - self.begin
        end
      end

    end
  end
end

Range.include UMTSTime::CoreExt::Range::Calculations
