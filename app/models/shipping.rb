class Shipping < ActiveHash::Base
  include ActiveHash::Associations
  has_one :exchange

  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: '厚さ3cm/長辺31cm/重さ1kg以内' },
    { id: 2, name: '24.8cm×34cm以内. 20cm×25cm×5cm以内' },
    { id: 3, name: '3辺の合計が60cm以上/5cm超/2kg以内' },
    { id: 4, name: '3辺の合計が80cm/8cm以内/5kg以内' },
    { id: 5, name: '3辺の合計が120cm/10cm以内/15kg以内' },
    { id: 6, name: '3辺の合計が160cm/15cm以内以内/25kg以内' }
  ]
end
