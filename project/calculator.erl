%% =========================================================
%% Basic Calculator in Erlang
%% =========================================================

-module(calculator).
-export([start/0, calculate/3]).

%% =========================================================
%% Program Entry Point
%% =========================================================

start() ->
    print_welcome(),
    print_operations(),
    calculator_loop().

%% =========================================================
%% User Interface
%% =========================================================

print_welcome() ->
    io:format("====================================~n"),
    io:format("      Welcome to Erlang Calculator   ~n"),
    io:format("====================================~n").

print_operations() ->
    Operations = [add, sub, mul, divide],
    io:format("Available operations:~n"),
    lists:foreach(
        fun(Op) ->
            io:format(" - ~p~n", [Op])
        end,
        Operations
    ),
    io:format("Type operation followed by a dot (example: add.).~n"),
    io:format("Type 'stop.' to exit.~n~n").

%% =========================================================
%% Main Loop (Recursion)
%% =========================================================

calculator_loop() ->
    io:format("Enter operation: "),
    case io:read("") of
        {ok, stop} ->
            exit_program();

        {ok, Operation} ->
            process_operation(Operation),
            calculator_loop();

        _ ->
            io:format("Invalid input. Try again.~n"),
            calculator_loop()
    end.

%% =========================================================
%% Operation Handling
%% =========================================================

process_operation(Operation) ->
    case is_valid_operation(Operation) of
        true ->
            A = read_number("Enter first number: "),
            B = read_number("Enter second number: "),
            Result = calculate(Operation, A, B),
            display_result(Result);

        false ->
            io:format("Invalid operation.~n~n")
    end.

%% =========================================================
%% Read Numbers Safely
%% =========================================================

read_number(Prompt) ->
    io:format("~s", [Prompt]),
    case io:read("") of
        {ok, N} when is_number(N) ->
            N;
        _ ->
            io:format("Invalid number. Please try again.~n"),
            read_number(Prompt)
    end.

%% =========================================================
%% Calculator Logic
%% Pattern Matching + Guards
%% =========================================================

calculate(add, A, B) ->
    A + B;

calculate(sub, A, B) ->
    A - B;

calculate(mul, A, B) ->
    A * B;

calculate(divide, _A, 0) ->
    io:format("Error: Division by zero is not allowed.~n"),
    error;

calculate(divide, A, B) when B =/= 0 ->
    A / B;

calculate(_, _, _) ->
    io:format("Invalid operation entered.~n"),
    error.

%% =========================================================
%% Validation
%% =========================================================

is_valid_operation(add) -> true;
is_valid_operation(sub) -> true;
is_valid_operation(mul) -> true;
is_valid_operation(divide) -> true;
is_valid_operation(_) -> false.

%% =========================================================
%% Output
%% =========================================================

display_result(error) ->
    io:format("Calculation failed.~n~n");

display_result(Result) ->
    io:format("Result: ~p~n~n", [Result]).

%% =========================================================
%% Exit Program
%% =========================================================

exit_program() ->
    io:format("====================================~n"),
    io:format("Thank you for using the calculator!~n"),
    io:format("Goodbye!~n"),
    io:format("====================================~n"),
    ok.
