class Organization():

    def __init__(self, db_result):
        self.id = db_result["id"]
        self.name = db_result["name"]
        self.assets = db_result["assets"]
        self.money_goal = db_result["money_goal"]
        self.pledges_goal = db_result["pledges_goal"]