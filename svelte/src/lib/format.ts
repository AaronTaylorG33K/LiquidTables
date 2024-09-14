import type { Metrics, MetricTuple } from '../types/metrics';

export function sanitize(str: string): string {
	
	return str.replace(/ /g, '+').toLowerCase().replace('_id', '');
}

export function formatMoney(value: number): string {
	const formatter = new Intl.NumberFormat('en-US', {
		style: 'currency',
		currency: 'USD',
		minimumFractionDigits: 2,
		maximumFractionDigits: 2
	});

	return formatter.format(value);
}

export function formatData(metrics: (Partial<Metrics> | MetricTuple)[]): Metrics[] {
	return metrics.map((metric: Partial<Metrics> | MetricTuple) => {
		if (Array.isArray(metric)) {
			const [
				product,
				customer,
				salesperson,
				invoice_id,
				customer_id,
				salesperson_id,
				quantity,
				total,
				groupingLevel
			] = metric;
			return {
				product,
				customer,
				salesperson,
				invoice_id,
				customer_id,
				salesperson_id,
				quantity,
				total,
				groupingLevel
			} as Metrics;
		} else {
			return metric as Metrics;
		}
	});
}
