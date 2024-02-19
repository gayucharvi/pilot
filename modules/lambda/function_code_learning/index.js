const learnings = [
	"Terraform modules",
	"Lambda Functions",
	"APiGateway",
	"Gateway Integration",
	"Gateway Deployment",
];
exports.handler = async (event) => {
	return {
		statusCode: 200,
		headers: {
			"Content-Type": "application/json",
		},
		body: JSON.stringify({ learnings }), //sending the array of movies as stringified JSON in the response
	};
};
