import type { Metrics } from '../types/metrics';
import { writable } from 'svelte/store';

export const data = writable<Metrics[]>([]);
export const groupingLevels = writable<number[]>([0, 1]);

export function filterData(metrics: Metrics[], groupingLevels: number[], filterByColumn?: keyof Metrics, filterByColumnValue?: string): Metrics[] {
  
  const filterValue = filterByColumnValue ? filterByColumnValue?.replace('+', ' ').trim().toLowerCase() : null;

  return metrics.filter((metric) => {
      const matchesColumnFilter = filterByColumn && filterValue
          ? String(metric[filterByColumn]).trim().toLowerCase() === filterValue
          : true;

      const matchesGroupingLevel = groupingLevels.includes(metric.groupingLevel);

      return matchesColumnFilter && matchesGroupingLevel;
  });
}

