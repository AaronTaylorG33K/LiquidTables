export interface MetricValue {
	quantity: number;
}

export type MetricTuple = [string, string, string, number, number, number, number, number, number];
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
		public total: number,
		public groupingLevel: number
	) {}
}
