#include<iostream>
#include<fstream>
#include<iomanip>
// This is mereely a tesst
using namespace std;

int main()
{
    // Total Count
    int TC = 0; 
    // Average
    double Avg = 0;
    // Number of students
    int Students = 0;
    int student_count = 0;
    ofstream outfile;
    outfile.open("results.txt");

    cin >> TC;
    Students = TC;

    while(TC > 0)
    {
        double GPA;
        string fname, lname, classification;

        cin >> fname >> lname >> classification >> GPA;

        student_count++;
        Avg += GPA;

        outfile << fname << " " << lname << " is a " << classification << " whose GPA is: " << GPA << "\n";

        TC--;
    }

    Avg = Avg / Students;

    outfile << "\nThe class average is: " << setprecision(3) << Avg << "\n";

    return 0;
}