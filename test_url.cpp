#include <boost/url.hpp>
#include <cstdio>

using namespace boost::urls;

void print_params(url_view const& url)
{
  for (auto p : url.params()) {
    printf("key: '%s' value: '%s'\n", p.key.c_str(), p.value.c_str());
  }
}

int main()
{
  auto url = parse_relative_ref("/events?re=test");
  print_params(*url);
}
