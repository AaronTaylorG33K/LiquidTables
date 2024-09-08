// src/stores/metrics.ts
import { writable } from 'svelte/store';
import type { Metrics } from '../types/metrics';

const initialMetrics: Metrics = {
    orders: 0,
    revenue: 0,
    averageOrderValue: 0,
    totalBeer: 0,
    totalWine: 0,
    totalWhiskey: 0
};

export const metrics = writable<Metrics>(initialMetrics);
