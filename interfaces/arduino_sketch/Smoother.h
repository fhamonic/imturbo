#ifndef SMOOTHER_H
#define SMOOTHER_H

template <typename T, int N>
class Smoother {
private:
    T past_values[N];
    T total;
    int oldest_index;

public:
    Smoother() : oldest_index{0} { set(0); }

    void add(T new_value) {
        total = total - past_values[oldest_index] + new_value;
        past_values[oldest_index] = new_value;
        if(++oldest_index == N) oldest_index = 0;
    }

    void set(T set_value) {
        for(int i = 0; i < N; ++i) past_values[i] = set_value;
        total = set_value * N;
    }

    T value() { return total / N; }
};

#endif  // SMOOTHER_H
