MAKEFLAGS += --no-builtin-rules

CC = clang++ -std=c++23 -Wall -Wextra -Wfloat-equal -DLOCAL -O2
INCLUDES = -lm -I .
SOLVE = solve.out
BRUTE = brute.out
PCH = bits/stdc++.h.pch

default: run

$(SOLVE): solve.cpp $(PCH)
	@$(CC) $(INCLUDES) solve.cpp -o $(SOLVE)

$(BRUTE): brute.cpp $(PCH)
	@$(CC) $(INCLUDES) brute.cpp -o $(BRUTE)

$(PCH): bits/stdc++.h
	@$(CC) -x c++-header bits/stdc++.h -o $(PCH)

run: $(SOLVE)
	@./$(SOLVE)

brute: $(BRUTE)
	@./$(BRUTE)

INFILE = test.in
MYOUT = solve.ans
REFOUT = brute.ans

stress: $(SOLVE) $(BRUTE)
	@i=1; \
	while true; do \
		echo "test #$$i"; \
		./gen.py "$$i" > $(INFILE); \
		./$(SOLVE) < $(INFILE) > $(MYOUT) 2> /dev/null; \
		./$(BRUTE) < $(INFILE) > $(REFOUT) 2> /dev/null; \
		diff -Z $(MYOUT) $(REFOUT) > /dev/null || break; \
	done; \
	printf "\nWA on test #%d:\n\n" "$$i"; \
	cat $(INFILE); \
	printf "\nYour answer is:\n"; \
	cat $(MYOUT); \
	printf "\nCorrect answer is:\n"; \
	cat $(REFOUT);

clean:
	$(RM) $(SOLVE) $(BRUTE) $(PCH) $(MYOUT) $(REFOUT)

.PHONY: default run brute stress clean
