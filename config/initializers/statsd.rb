if Rails.env.development?
  host, port = "127.0.0.1:8125".split(":")
  connection = StatsD::Instrument::UdpConnection.new(host, port.to_i)
  sink = StatsD::Instrument::Sink.new(connection)
  StatsD.singleton_client = StatsD::Instrument::Client.new(sink: sink)
end
