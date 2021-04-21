class TimeModel < ApplicationRecord
  attribute :start_time, :atomic_time
  attribute :end_time, :atomic_time

  time_interval :start_time, :end_time
end
