import pymysql.cursors
from error import InvalidUsage
from Organization import Organization
from Analytics import Analytics

def get_db():
    # Connect to the database
    connection = pymysql.connect(host='localhost',
                                 user='root',
                                 password='Nokia$trong',
                                 db='pledge_machine',
                                 charset='utf8mb4',
                                 cursorclass=pymysql.cursors.DictCursor)
    return connection

DB = get_db()

class Database():
    def __init__(self):
        return

    def get_organzation_by_id(self, id):
        try:
            with DB.cursor() as cursor:
                # Read a single record
                query = "SELECT * FROM organizations WHERE id='" + id + "'"
                cursor.execute(query)
                result = cursor.fetchone()
                return Organization(result)
            DB.commit()
        except Exception as e:
            raise InvalidUsage("Failed to find org with id " + id)

    def get_total_metrics_from_org_id(self, id):
        org = self.get_organzation_by_id(id)
        analytics = Analytics()
        with DB.cursor() as cursor:
            query = "SELECT SUM(donation_amount) as total_raised, COUNT(*) as number_of_donations, COUNT(DISTINCT user_id) as number_of_pledges     FROM pledge_submissions WHERE organization_id = %s"
            print(query)
            cursor.execute(query, (org.id))
            result = cursor.fetchone()
            DB.commit()
            analytics.set_progress(result)
            analytics.set_goals(org)
        return analytics

    def insert_pledge_donation(self, pledge):
        with DB.cursor() as cursor:
            query = "INSERT INTO pledge_submissions (user_id, user_name, organization_id, docusign_link, donation_amount) VALUES (%s, %s, %s, %s, %s)"
            args = (pledge.user_id, pledge.name, pledge.organization_id, pledge.docusign_link, float(pledge.donation_amount))
            cursor.execute(query, args)
            DB.commit()
