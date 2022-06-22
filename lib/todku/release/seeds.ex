defmodule Todku.Release.Seeds do
  alias Todku.{
    Entries,
    Repo
  }

  def seed do
    Repo.start_link()
    clean()
    Enum.each(poems(), &Entries.create_poem/1)
  end

  defp clean() do
    Repo.delete_all(Entries.Poem)
  end

  defp poems do
    [
      %{
        date: ~D[2022-06-22],
        text: "dark forces abound<br>leaping masses to destroy<br>righteous ones stand firm"
      },
      %{
        date: ~D[2022-06-21],
        text: "the moral decay<br>of a once happy person<br>brings concern to us"
      },
      %{
        date: ~D[2022-06-17],
        text: "eternal struggle<br>torturous grappling hand<br>attempting takeover"
      },
      %{
        date: ~D[2022-06-16],
        text: "ever-changing wind<br>albatross around my neck<br>flotsam and jetsam"
      },
      %{
        date: ~D[2022-06-15],
        text: "bringing all goodness<br>eternally blessing us<br>with joys for the world"
      },
      %{
        date: ~D[2022-06-14],
        text: "covering darkness<br>foliage falling from the trees<br>winter is coming"
      },
      %{
        date: ~D[2022-06-13],
        text: "eventual end<br>slow demise in the middle<br>occasional joy"
      },
      %{
        date: ~D[2022-06-10],
        text: "its never my fault<br>find another distraction<br>the putin price hike"
      },
      %{
        date: ~D[2022-06-09],
        text: "a sailor remarks<br>of how angry the sea is<br>until He calms it"
      },
      %{
        date: ~D[2022-06-08],
        text: "irrational acts<br>deliberate defiance<br>ethical mishaps"
      },
      %{
        date: ~D[2022-06-07],
        text: "eternal struggle<br>between natural forces<br>and what is beyond"
      },
      %{
        date: ~D[2022-06-06],
        text: "delayed reaction<br>outcomes negotiated<br>consistent changes"
      },
      %{
        date: ~D[2022-06-03],
        text: "the divisive mind<br>of man often betrays him<br>leading to failure"
      },
      %{
        date: ~D[2022-06-02],
        text: "The sun continues<br>The waves consistently crash<br>Sometimes a rainbow"
      },
      %{
        date: ~D[2022-06-01],
        text: "emotional life<br>degenerative living<br>slowly creeping death"
      },
      %{
        date: ~D[2022-05-31],
        text: "emotional highs<br>tumultuous time divides<br>occasional lows"
      },
      %{
        date: ~D[2022-05-27],
        text: "who needs a lambo<br>when you can buy peace of mind<br>both would be nice tho"
      },
      %{
        date: ~D[2022-05-26],
        text: "driving wind and rain<br>can knock over many men<br>agile men survive"
      },
      %{
        date: ~D[2022-05-25],
        text: "the uneasy feeling<br>an ever-tightening grip<br>on my happiness"
      },
      %{
        date: ~D[2022-05-24],
        text: "this temperamental<br>mortal coil that traps me<br>limits potential"
      },
      %{
        date: ~D[2022-05-23],
        text: "general contempt<br>feelings of anxiety<br>and some helplessness"
      },
      %{
        date: ~D[2022-05-20],
        text: "desperation time<br>winters return is upon me<br>what can a guy do"
      },
      %{
        date: ~D[2022-05-19],
        text: "only one thing<br>causes all of our problems<br>russian collusion"
      },
      %{
        date: ~D[2022-05-18],
        text: "aimless ambling<br>observing only fractions<br>the walk is the goal"
      },
      %{
        date: ~D[2022-05-17],
        text: "as the crow comes near<br>his feathers shimmer and shine<br>and his caw echoes"
      },
      %{
        date: ~D[2022-05-16],
        text: "eternal darkness<br>awaits each and every man<br>the sunset unknown"
      },
      %{
        date: ~D[2022-05-13],
        text: "these mental hurdles<br>affecting everything here<br>can stop my progess"
      },
      %{
        date: ~D[2022-05-12],
        text: "the priority<br>should attract my attention<br>nevermind the rest"
      },
      %{
        date: ~D[2022-05-11],
        text: "time is the only<br>resource limited for all<br>man and beast alike"
      },
      %{
        date: ~D[2022-05-10],
        text: "lightness all around<br>summer is coming so soon<br>no time for slumber"
      },
      %{
        date: ~D[2022-05-09],
        text: "the winds of change blow<br>nothing in nature will last<br>it all must perish"
      },
      %{
        date: ~D[2022-05-03],
        text: "mentally trying<br>to hold on to everything<br>never giving up"
      },
      %{
        date: ~D[2022-05-02],
        text: "Snow is falling now<br>After flowers have bloomed<br>Always a surprise"
      },
      %{
        date: ~D[2022-04-29],
        text:
          "when the winds begin<br>some trees will try to be strong<br>the old trees will flex"
      },
      %{
        date: ~D[2022-04-28],
        text: "when one is given<br>so many options to pick<br>it's easy to stall"
      },
      %{
        date: ~D[2022-04-27],
        text: "only time blocks me<br>no one escapes the tight grip<br>of our father time"
      }
    ]
  end
end
