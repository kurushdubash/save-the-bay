class PledgeSubmission():

    def __init__(self, user_id, json_data):
        self.name = str(json_data["name"])
        self.email = str(json_data["email"])
        self.docusign_link = str(json_data["docusign_link"])
        self.donation_amount = float(json_data["donation_amount"])
        self.user_id = str(user_id)
        self.organization_id = str(json_data["organization_id"])

    def __str__(self): return "Name: " + self.name + "\n" + "User Id: " + self.user_id + "\n" + "Email: " + self.email + "\n" + "Docusign Link: " + self.docusign_link + "\n" + "Donation Amount: " + str(self.donation_amount) + "\n" + "Organization Id: " + str(self.organization_id) + "\n"
