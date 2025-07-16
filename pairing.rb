class Pairing
  def initialize(team:)
    @team = team
    @people_who_have_driven = []
    @people_who_have_navigated = []
    @last_driver = nil
    @last_navigator = nil
  end

  def call
    reset_drivers_if_complete
    reset_navigators_if_complete

    driver = select_driver
    navigator = select_navigator(excluding: driver)

    track_session(driver, navigator)

    "The driver is: #{driver} and the navigator is #{navigator}."
  end

  private

  attr_reader :team, :people_who_have_driven, :people_who_have_navigated, :last_driver, :last_navigator

  def reset_drivers_if_complete
    @people_who_have_driven = [] if everyone_has_driven?
  end

  def reset_navigators_if_complete
    @people_who_have_navigated = [] if everyone_has_navigated?
  end

  def everyone_has_driven?
    people_who_have_driven.uniq.sort == team.sort
  end

  def everyone_has_navigated?
    people_who_have_navigated.uniq.sort == team.sort
  end

  def select_driver
    available_drivers = team - people_who_have_driven
    # Avoid consecutive assignments for the same person
    available_drivers -= [@last_driver] unless available_drivers.size <= 1

    available_drivers.empty? ? (team - [@last_driver]).sample : available_drivers.sample
  end

  def select_navigator(excluding:)
    available_team = team - [excluding]
    available_navigators = available_team - people_who_have_navigated
    # Avoid consecutive assignments for the same person
    available_navigators -= [@last_navigator] unless available_navigators.size <= 1

    available_navigators.empty? ? (available_team - [@last_navigator]).sample : available_navigators.sample
  end

  def track_session(driver, navigator)
    @people_who_have_driven << driver
    @people_who_have_navigated << navigator
    @last_driver = driver
    @last_navigator = navigator
  end
end
