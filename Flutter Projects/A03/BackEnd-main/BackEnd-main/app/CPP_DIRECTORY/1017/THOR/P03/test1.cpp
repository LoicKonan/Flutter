/*
        Name:       D'Glester Hardunkichud
        Course:     1043 Computer Science 1
        Date:       3/29/2022

        Assignment: Sorting Experiments
*/


#include<iostream>

using namespace std;

string perfectNumber(int n);        // Function Prototype for the Perfect Number function


// Main Function
int main()
{
    int number = -1;                // int value for input, initialized to -1 
    int sentinal = 0;               // Sentinal value initialized to zero, used to stop the program


    while (number != sentinal)
    {
        cout << "Please enter a number to determine if it is a perfect number.\nEnter zero to stop.\n";
        cin >> number;              // Capturing the user input

        if (number == sentinal)     // if the user typed number is equal to the sentinal value
        {
            break;                  // We will exit the loop
        }

        else                        // Calling the perfect number function that returns a string with the result
        {
            cout << number << " is " << perfectNumber(number) << "\n";
        }
    }


    return 0;
}

string perfectNumber(int n)
{
    int factors = 1;
    int RT = 0;

    // While the factors value is less than n
    while (factors < n)
    {
        if (n%factors == 0)     // if factors is a factor of n
        {
            RT += factors;      // add factors to the running total
        }

        factors++;              // incrememnt factors by 1
    }

    if (RT == n)                // if n is a perfect number
    {
        return "Perfect";
    }

    else if (RT < n)            // if n is an abundant number
    {
        return "Abundant";
    }

    else                        // if n is a deficient number
    {
        return "Deficient";
    }
}