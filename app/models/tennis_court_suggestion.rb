# frozen_string_literal: true

class TennisCourtSuggestion < TennisCourt
  belongs_to :version, class_name: 'PaperTrail::Version', optional: true
  belongs_to :master, class_name: 'TennisCourt', optional: true

  SUGGESTION_ATTR = %w[id type version_id master_id created_at updated_at
                       lonlat google_place_id address].freeze

  scope :not_rolled, -> { where(version_id: nil) }
  scope :has_master, -> { where.not(master_id: nil) }
  scope :has_no_master, -> { where(master_id: nil) }

  def roll
    master ? roll_for_existing_court : roll_for_new_court
  end

  def roll_for_existing_court
    master.update(attributes_to_update)
    v = master.versions.last

    update(version_id: v.id)
  end

  def roll_for_new_court
    tennis_court = TennisCourt.create(attributes_to_update)

    update(master_id: tennis_court.id, version_id: tennis_court.versions.last)
  end

  def rollback
    return unless rolled?

    version.reify.save
    update(version_id: nil)
  end

  def rolled?
    version_id.present?
  end

  def attributes_to_update
    attributes.reject { |key, _val| SUGGESTION_ATTR.include? key }
  end
end
