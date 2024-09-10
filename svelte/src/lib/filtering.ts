import { writable, derived } from 'svelte/store';
import type { Metrics } from '../types/metrics';

export const data = writable<Metrics[]>([]);
export const groupingLevels = writable<number[]>([1, 0]);

export const selectedProduct = writable<string | null>(null);
export const selectedCustomer = writable<string | null>(null);
export const selectedSalesperson = writable<string | null>(null);

export const filteredData = derived(
  [data, selectedProduct, selectedCustomer, selectedSalesperson, groupingLevels],
  ([$data, $selectedProduct, $selectedCustomer, $selectedSalesperson, $groupingLevels]) => {
    let filtered: Metrics[] = [];
    if ($selectedProduct) {
      const groupingLevelOne = $data.filter(
        (metric) => metric.groupingLevel === 1 || metric.groupingLevel === 0
      );
      const productIndex = groupingLevelOne.findIndex(
        (metric) => metric.product === $selectedProduct
      );

      if (productIndex !== -1) {
        const beforeProduct = groupingLevelOne.slice(0, productIndex + 1);
        const afterProduct = groupingLevelOne.slice(productIndex + 1);
        const productFiltered = $data.filter(
          (metric) => metric.product === $selectedProduct && metric.groupingLevel === 4
        );
        filtered = beforeProduct.concat(productFiltered, afterProduct);
      } else {
        filtered = groupingLevelOne;
      }
    } else if ($selectedCustomer) {
      filtered = $data.filter(
        (metric) =>
          metric.customer === $selectedCustomer && $groupingLevels.includes(metric.groupingLevel)
      );
    } else if ($selectedSalesperson) {
      filtered = $data.filter(
        (metric) =>
          metric.salesperson === $selectedSalesperson &&
          $groupingLevels.includes(metric.groupingLevel)
      );
    } else {
      filtered = $data.filter((metric) => $groupingLevels.includes(metric.groupingLevel));
    }

    const firstElement = filtered.shift();
    if (firstElement) {
      filtered.push(firstElement);
    }

    return filtered;
  }
);
export const show_id = derived(
  [filteredData, selectedProduct],
  ([$filteredData]) =>
    $filteredData.some((row) => row.customer || row.salesperson)
);

export function clearFilters() {
  selectedProduct.set(null);
  selectedCustomer.set(null);
  selectedSalesperson.set(null);
}

export function filterByProduct(product: string) {
  clearFilters();
  selectedProduct.set(product);
  groupingLevels.set([1, 4]);
}

export function filterByCustomer(customer: string) {
  clearFilters();
  selectedCustomer.set(customer);
  groupingLevels.set([2, 3, 4]);
}

export function filterBySalesperson(salesperson: string) {
  clearFilters();
  selectedSalesperson.set(salesperson);
  groupingLevels.set([3, 4, 5]);
}