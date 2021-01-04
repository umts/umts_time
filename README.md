UMTS Time
=========

A Rails time library for use with UMTS apps.

AtomicTime
----------

An integrated class/type that stores time information with no associated 
date/zone. The class is a fully featured member of the time/date class family
and mirrors all applicable methods that are defined on the `Time` class.

It is also registered `ActiveRecord::Type` and can be used on integer attributes
by adding `attribute :column, :atomic_time` to the corresponding model.
This adds automatic casting/serialization to the field.

Formats
-------

The gem adjusts the `ActiveSupport` date/time formatting system and adds
our own custom formats. Before, `DateTime` inherited its `DATE_FORMATS` from
the `Date` class. Now all of the `DATE_FORMATS` constants point to the new
`UMTSTime::Formats` constants.

(`Date` -> `DATE`, `AtomicTime` -> `TIME`, `Time` and `DateTime` -> `DATE_TIME`)

Other Helpers
-------------

Other smaller features include:

- `Range#length` (Returns the 'span' length of a range)
- `Range#overlap` (Accepts other ranges and returns overlapping periods)
- `ActiveSupport::Duration#convert_to` (Converts a duration to the target unit)
