require 'spec_helper'

describe Reports::CreateHistoryEntry do
  let(:item) { create(:reports_item) }
  let(:user) { create(:user) }

  subject { described_class.new(item, user) }

  describe '#create' do
    context 'with the status changed' do
      let(:status) { create(:status) }
      let(:kind) { 'status' }
      let(:action) { 'Mudou o status do relato' }

      it 'creates the history entry' do
        subject.create(kind, action, new: status.entity(only: [:id, :title]))

        entry = Reports::ItemHistory.find_by(
          kind: kind,
          action: action,
          user_id: user.id,
          reports_item_id: item.id
        )

        expect(entry).to_not be_nil
        expect(entry.saved_changes).to match(
          'new' => Oj.load(status.entity(only: [:id, :title]).to_json)
        )
      end
    end

    context 'with the category changed' do
      let(:category) { create(:reports_category) }
      let(:kind) { 'status' }
      let(:action) { 'Mudou a categoria do relato' }

      it 'creates the history entry' do
        subject.create(kind, action, new: category.entity(only: [:id, :title]))

        entry = Reports::ItemHistory.find_by(
          kind: kind,
          action: action,
          user_id: user.id,
          reports_item_id: item.id
        )

        expect(entry).to_not be_nil
        expect(entry.saved_changes).to match(
          'new' => Oj.load(category.entity(only: [:id, :title]).to_json)
        )
      end
    end
  end

  describe '#detect_changes_and_create!' do
    context 'detecting changes' do
      let(:action) { 'Alterou um atributo' }

      before do
        item.description = 'Test'
        item.address = 'St Test'
        item.save!
      end

      it 'saves those changes in the `saved_changes` attribute' do
        subject.detect_changes_and_create!([:description, :address])

        entry = Reports::ItemHistory.find_by(
          kind: 'address',
          user_id: user.id,
          reports_item_id: item.id
        )

        expect(entry).to_not be_nil
        expect(entry.saved_changes).to match(
          'old' => an_instance_of(String),
          'new' => 'St Test'
        )
      end
    end
  end
end
