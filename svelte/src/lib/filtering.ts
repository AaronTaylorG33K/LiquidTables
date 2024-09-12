import { writable } from 'svelte/store';
import type { Metrics } from '../types/metrics';

export const data = writable<Metrics[]>([]);
export const groupingLevels = writable<number[]>([0,1]);


export function filterData(metrics: Metrics[], groupingLevels: number[]): Metrics[] {
  let grouped: Metrics[] = [];
  groupingLevels.forEach((level) => {
      const groupedLevel = metrics.filter((metric) => metric.groupingLevel === level);
      grouped = grouped.concat(groupedLevel);
  });
  return grouped;
}


