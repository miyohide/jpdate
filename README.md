# Jpdate

Jpdateは西暦を和暦に変換するGemです。

```ruby
Time.mktime(1873, 1, 1).to_jp  # => ["M06.01.01"]
```

のように`Time`クラスに対して`to_jp`メソッドを呼び出すと、和暦変換した値が配列として帰ってきます。

配列として返す理由は、明治〜大正、大正〜昭和は同じ西暦で明治と大正、大正と昭和のパターンが有るためです。

また、明治は本来1868年からだが、明治5年までは天保暦であったため、現在使われている暦とは若干異なる。この対応は出来ていないため、このgemでは1873年1月1日以降からの対応としている。

## Installation

```ruby
gem 'jpdate'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jpdate

## Usage

```ruby
Date.new(1873, 1, 1).to_jp  # => #<struct AD2Jpdate::JP_ERAS meiji="M06.01.01", taisho=nil, showa=nil, heisei=nil>
Time.mktime(1989, 1, 9).to_jp # => #<struct AD2Jpdate::JP_ERAS meiji=nil, taisho=nil, showa=nil, heisei="H01.01.09">
Time.mktime(1926, 12, 25).to_jp # => #<struct AD2Jpdate::JP_ERAS meiji=nil, taisho="T15.12.25", showa="S01.12.25", heisei=nil>

# %O is wareki Kanji name (%J is wareki year)
Time.mktime(1989, 1, 9).to_jp("%O%J年%m月%d日") # => #<struct AD2Jpdate::JP_ERAS meiji=nil, taisho=nil, showa=nil, heisei="平成01年01月09日">

# %o is wareki symble
Time.mktime(1989, 1, 9).to_jp("%o%J.%m.%d") # => #<struct AD2Jpdate::JP_ERAS meiji=nil, taisho=nil, showa=nil, heisei="H01.01.09">

# Jpdate#to_date returns Date instance
Jpdate.new("H", 1, 1, 1).to_date # => #<Date: 1989-01-01 ((2447528j,0s,0n),+0s,2299161j)>
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/miyohide/jpdate.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
