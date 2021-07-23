require 'rails_helper'

RSpec.describe Follow, type: :model do
    
    it { is_expected.to belong_to(:follower).with_foreign_key(:follower_id).class_name('User')}
    it { is_expected.to belong_to(:following).with_foreign_key(:following_id).class_name('User')}
end
