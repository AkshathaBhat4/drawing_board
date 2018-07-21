class CellsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'cells'
  end
end
