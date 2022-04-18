#include<iostream>
#include<fstream>
#include<iomanip>

using namespace std;

int main()
{
    cout << "Welcome to the Jungle!" << endl;
    int TC = 0;
    double Avg = 0;
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
