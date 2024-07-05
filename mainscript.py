import csv
import random
import names

# Define job titles and departments for random selection
job_titles = ['Laborer', 'Engineer', 'Foreman', 'Electrician', 'Plumber', 'Carpenter']
departments = ['Construction', 'Electrical', 'Plumbing', 'Carpentry', 'Management']
genders = ['Male', 'Female']


class SalaryOutOfRangeError(Exception):
    pass


def generate_workers(num_workers=400):
    workers = []
    for employee in range(num_workers):  # Generate 400 employees
        name = names.get_full_name()  # Use the names library to generate a random name
        gender = random.choice(genders)
        job_title = random.choice(job_titles)
        department = random.choice(departments)
        salary = random.randint(5000, 35000)  # Random salary between $25000 and $35000
        
        workers.append({
            'Employee Name': name,
            'Gender': gender,
            'Job Title': job_title,
            'Department': department,
            'Salary': salary,
        })
    return workers

def generate_payment_slips(workers):
    payment_slips = []

    for worker in workers:
        try:
            slip = {
                "Employee Name": worker["Employee Name"],
                "Salary": worker["Salary"],
                "Employee_level": None
            }
            
            # Raise SalaryOutOfRangeError if salary is out of range
            if worker["Salary"] > 35000 or worker["Salary"] < 5000:
                raise SalaryOutOfRangeError(f"Salary {worker['Salary']} out of range for {worker['Employee Name']}")
            

            # Conditional statements to assign employee level
            if 10000 < worker["Salary"] < 20000:
                slip["Employee_level"] = "A1"
            
            if 7500 < worker["Salary"] < 30000 and worker["Gender"] == "Female":
                slip["Employee_level"] = "A5-F"
            
            payment_slips.append(slip)
        
        except KeyError as ke:
            print(f"KeyError occurred: {ke}")
            slip["Employee_level"] = "Unknown"
            payment_slips.append(slip)

        except SalaryOutOfRangeError as soore:
            print(f"Custom exception occurred: {soore}")
            slip["Employee_level"] = "Unknown"
            payment_slips.append(slip)
          
        except Exception as e:
            print(f"Exception occurred: {e}")
            continue

    return payment_slips
