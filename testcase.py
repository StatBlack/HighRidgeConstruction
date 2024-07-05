import unittest
from mainscript import generate_workers, generate_payment_slips 
# Import your functions here

class TestPaymentSlips(unittest.TestCase):
    def test_generate_payment_slips_keyerror(self):

        # Test data to trigger KeyError
        workers = [{'Employee Name': 'Test Name', 'Gender': 'Male', 'Job Title': 'Engineer', 'Department': 'Engineering'}]
        slips = generate_payment_slips(workers)
        self.assertEqual(slips[0]["Employee_level"], "Unknown")

    def test_generate_payment_slips_no_exception(self):
        # Normal test data
        workers = generate_workers(10)  # Generate 10 workers for testing
        slips = generate_payment_slips(workers)
        self.assertTrue(all('Employee_level' in slip for slip in slips))

if __name__ == '__main__':
    unittest.main()
