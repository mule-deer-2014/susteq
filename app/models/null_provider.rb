class NullProvider < Provider
  def name
    "Unassigned"
  end

  def kiosks
    Kiosk.none
  end

  def pumps
    Pump.none
  end

  def hubs
    Hub.none
  end

  def address
    "Unassigned"
  end

  def duns_number
    "Unassigned"
  end

  def country
    "Unassigned"
  end

  def method_missing(*args, &block)
    nil
  end

  def present?
   false
  end

  def empty?
    true
  end

  def nil?
    true
  end
end