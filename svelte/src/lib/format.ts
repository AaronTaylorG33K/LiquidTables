import type { Metrics } from '../types/metrics';


export function sanitize(str: string): string {
    return str.replace(/ /g, '+').toLowerCase();
}

export function reString(str: string): string {
    return str.replace(/\+/g, ' ');
    
}
export function formatMoney(value: number): string {
    const formatter = new Intl.NumberFormat('en-US', {
        style: 'currency',
        currency: 'USD',
        minimumFractionDigits: 2,
        maximumFractionDigits: 2,
    });

    return formatter.format(value);
}

export function formatData(metrics: (Partial<Metrics> | [string, string, string, number, number, number, number, string, number])[]): Metrics[] {
    if (Array.isArray(metrics)) {
        return metrics.map(
            (metric: Partial<Metrics> | [string, string, string, number, number, number, number, string, number]) => {
                if (Array.isArray(metric)) {
                    return {
                        invoice_id: metric[3],
                        product: metric[0],
                        customer: metric[1],
                        salesperson: metric[2],
                        customer_id: metric[4],
                        salesperson_id: metric[5],
                        quantity: metric[6],
                        total: parseFloat(metric[7]), // Convert amount to number
                        groupingLevel: metric[8]
                    };
                } else {
                    return {
                        ...metric,
                        amount: metric.amount ? parseFloat(metric.amount as unknown as string) : 0 // Ensure amount is a number
                    } as Metrics;
                }
            }
        );
    } else {
        console.error('metrics is not an array:', metrics);
        return [];
    }
}