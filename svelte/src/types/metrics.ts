export interface MetricValue {
	quantity: number;
  }
export class Metrics {
	[key: number]: MetricValue; 
	constructor(
		public product: string,
		public customer: string,
		public salesperson: string,
		public invoice_id: number,
		public customer_id: number,
		public salesperson_id: number,
		public quantity: number,
		public amount: number,
		public groupingLevel: number,
	) {}


	static fromArray(
		arr: [string, string, string, number, number, number, number, number, number]
	): Metrics {
		return new Metrics(
			arr[0], // product
			arr[1], // customer
			arr[2], // salesperson
			arr[3], // product_id
			arr[4], // customer_id
			arr[5], // salesperson_id
			arr[6], // quantity 
			arr[7], // amount
			arr[8], // groupingLevel
		);
	}
}
