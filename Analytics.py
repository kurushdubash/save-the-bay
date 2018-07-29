class Analytics():
	def __init__(self):
		return
	
	def set_progress(self, db):
		self.total_raised = float(db["total_raised"])
		self.number_of_donations = float(db["number_of_donations"])
		self.number_of_pledges = float(db["number_of_pledges"])

	def set_goals(self, org):
		self.org_money_goal = float(org.money_goal)
		self.org_pledges_goal = float(org.pledges_goal)
