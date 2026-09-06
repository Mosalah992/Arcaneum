/**
 * Hash routing, because the archive is one page and Pages should not have to
 * rewrite anything for it.
 *
 * A screen owns its element and, if it holds anything the browser will not
 * collect on its own, a destroy(). The chamber will have a great deal to
 * destroy; the catalogue has one window listener.
 */

export interface Screen {
  element: HTMLElement;
  /** Shown in the header crumb. */
  title?: string;
  /**
   * Whether the stone frame is drawn around this screen. The boot sequence
   * sets it false: a disc spinning up does not happen inside the application
   * it is loading.
   */
  chrome?: boolean;
  destroy?(): void;
}

export type Route = (params: Record<string, string>) => Screen;

interface Entry {
  pattern: RegExp;
  names: string[];
  route: Route;
}

/** '/tome/:id' becomes /^\/tome\/([^/]+)$/ with names ['id']. */
function compile(path: string): { pattern: RegExp; names: string[] } {
  const names: string[] = [];
  const source = path
    .split('/')
    .map((segment) => {
      if (!segment.startsWith(':')) {
        return segment.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
      }
      names.push(segment.slice(1));
      return '([^/]+)';
    })
    .join('/');
  return { pattern: new RegExp(`^${source}$`), names };
}

export function currentPath(): string {
  const hash = window.location.hash.slice(1);
  return hash === '' ? '/' : hash;
}

export function navigate(path: string, replace = false): void {
  const target = `#${path}`;
  if (window.location.hash === target) return;
  if (replace) {
    window.history.replaceState(null, '', target);
    window.dispatchEvent(new HashChangeEvent('hashchange'));
  } else {
    window.location.hash = target;
  }
}

export function createRouter(
  stage: HTMLElement,
  routes: Record<string, Route>,
  fallback: Route,
  onScreen?: (screen: Screen) => void,
) {
  const entries: Entry[] = Object.entries(routes).map(([path, route]) => ({
    ...compile(path),
    route,
  }));

  let mounted: Screen | null = null;

  function resolve(path: string): Screen {
    for (const entry of entries) {
      const match = entry.pattern.exec(path);
      if (match === null) continue;
      const params: Record<string, string> = {};
      entry.names.forEach((name, i) => {
        params[name] = decodeURIComponent(match[i + 1] ?? '');
      });
      return entry.route(params);
    }
    return fallback({});
  }

  function render(): void {
    mounted?.destroy?.();
    stage.replaceChildren();
    mounted = resolve(currentPath());
    stage.append(mounted.element);
    onScreen?.(mounted);
  }

  window.addEventListener('hashchange', render);
  render();

  return { render };
}
