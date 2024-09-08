export interface Metrics {
    product: { id: number; name: string } | null;
    customer: { id: number; name: string } | null;
    salesperson: { id: number; name: string } | null;
    amount: number
}