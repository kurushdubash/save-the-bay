from flask import Flask, request, jsonify, Response
import json
from send_email import send_email
from error import InvalidUsage
from PledgeSubmission import PledgeSubmission
from db import Database

app = Flask(__name__)
DB = Database()

@app.route("/")
def index():
	return "Hello World!"

@app.route("/submit-pledge/<user_id>", methods = ['PUT'])
def submit_pledge(user_id):
	print("Requesting data on user: " + user_id)
	pledge = validate_submit_pledge_request(user_id, request)
	DB.insert_pledge_donation(pledge)
	print(pledge)
	send_email(pledge)
	
	return Response(json.dumps(vars(pledge)), status=200, mimetype='application/json')

@app.route("/form-analytics/<organization_id>", methods = ['GET'])
def get_form_analytics(organization_id):
	print("Requesting form analytics on organization_id: " + organization_id)
	analytics = DB.get_total_metrics_from_org_id(organization_id)
	
	return Response(json.dumps(vars(analytics)), status=200, mimetype='application/json')

@app.route("/org-analytics/<organization_id>", methods = ['GET'])
def get_org_analytics(organization_id):
	print("Requesting org analytics on organization_id: " + organization_id)
	pledge = validate_submit_pledge_request(user_id, request)
	send_email(pledge)
	
	return Response(json.dumps(vars(pledge)), status=200, mimetype='application/json')

def validate_submit_pledge_request(user_id, request):
	print("Validating request...")
	is_json = request.is_json
	print("Is the request in JSON format? : " + str(is_json))

	if (not is_json):
		raise InvalidUsage("Request must be in json format. Set Content-Type : application/json", status_code=400)

	request = request.get_json()
	is_required_string = " is required"
	if ("organization_id" not in request or request["organization_id"] is None):
		raise InvalidUsage("Organization Id" + is_required_string, status_code=400)
	if ("name" not in request or request["name"] is None):
		raise InvalidUsage("Name" + is_required_string, status_code=400)
	if ("email" not in request or request["email"] is None):
		raise InvalidUsage("Email" + is_required_string, status_code=400)
	if ("docusign_link" not in request or request["docusign_link"] is None):
		raise InvalidUsage("Docusign Link" + is_required_string, status_code=400)
	if ("donation_amount" not in request or request["donation_amount"] is None):
		raise InvalidUsage("Donation Amount" + is_required_string, status_code=400)
	if ("donation_amount" not in request or float(request["donation_amount"]) < 0):
		raise InvalidUsage("Donation Amount can't be negative", status_code=400)

	pledge = PledgeSubmission(user_id, request)
	DB.get_organzation_by_id(pledge.organization_id)
	return pledge


@app.errorhandler(InvalidUsage)
def handle_invalid_usage(error):
    response = jsonify(error.to_dict())
    response.status_code = error.status_code
    return response

if __name__ == "__main__":
    app.run(host='0.0.0.0')