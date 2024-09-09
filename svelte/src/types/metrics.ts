export class Metrics {
	constructor(
		public product: string,
        public product_price: number,
		public customer: string,
		public salesperson: string,
		public invoice_id: number,
		public customer_id: number,
		public salesperson_id: number,
		public amount: number,
		public quantity: number,
		public groupingLevel: number,
	) {}


	static fromArray(
		arr: [string,number, string, string, number, number, number, number, number,  number]
	): Metrics {
		return new Metrics(
			arr[0], // product
            arr[1], // product_price
			arr[2], // customer
			arr[3], // salesperson
			arr[4], // product_id
			arr[5], // customer_id
			arr[6], // salesperson_id
			arr[7], // amount
			arr[8], // quantity 
			arr[9], // groupingLevel
		);
	}
}
