export class Metrics {
    constructor(
        public product: string,
        public customer: string,
        public salesperson: string,
        public amount: number,
        public groupingLevel: number
    ) {}

    static fromArray(arr: [string, string, string, number, number]): Metrics {
        return new Metrics(arr[0], arr[1], arr[2], arr[3], arr[4]);
    }
}