require 'howlong'
require 'timecop'

describe Howlong do
  let(:app) { 'emacs' }


  context 'basic usage' do
    it 'should return the desired format' do
      allow(Howlong).to receive(:processes_from_system) do
        'Wed May 15 17:00:14 2019 /usr/bin/emacs'
      end
      Timecop.freeze(Time.local(2019, 10, 10, 18, 0, 0)) do
        expect(Howlong.coso(app)).to eq ["Process /usr/bin/emacs has been active for 148 days, 4 hours, 59 minutes and 46 seconds"]

        expect(Howlong.friendly_show(app)).to eq 'Process /usr/bin/emacs has been active for 148 days, 4 hours, 59 minutes and 46 seconds'
      end
    end
  end
end
