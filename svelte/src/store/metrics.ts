import { writable } from 'svelte/store';
import type { Metrics } from '../types/metrics';

export const metricsStore = writable<Partial<Record<number, Metrics>>>({});