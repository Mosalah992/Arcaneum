/**
 * Shared plumbing for the three read-only API routes.
 *
 * Files under functions/ whose name begins with an underscore are not routed
 * by Cloudflare Pages, so this module is importable but not reachable.
 */

/**
 * Minimal hand-written D1 surface. The project deliberately carries only the
 * dependencies named in the spec, so @cloudflare/workers-types is not
 * installed; these are the three methods the archive actually calls.
 */
export interface D1Result<T> {
  results: T[];
  success: boolean;
}

export interface D1PreparedStatement {
  bind(...values: unknown[]): D1PreparedStatement;
  first<T = unknown>(): Promise<T | null>;
  all<T = unknown>(): Promise<D1Result<T>>;
}

export interface D1Database {
  prepare(query: string): D1PreparedStatement;
}

export interface Env {
  DB: D1Database;
  /**
   * The College's register, and the service account that may read it. Both
   * optional: without them /api/availability answers "not configured" and the
   * archive works exactly as it did before there was a register.
   */
  ARCANAEUM_SHEET_ID?: string;
  GOOGLE_SERVICE_ACCOUNT_JSON?: string;
}

export interface RequestContext {
  request: Request;
  env: Env;
  params: Record<string, string | string[]>;
}

/** The one error shape every route returns. */
export interface ApiError {
  error: {
    code: 'bad_request' | 'not_found' | 'method_not_allowed' | 'internal';
    message: string;
  };
}

export function json(body: unknown, status = 200, cache = 'no-store'): Response {
  return new Response(JSON.stringify(body), {
    status,
    headers: {
      'content-type': 'application/json; charset=utf-8',
      'cache-control': cache,
    },
  });
}

export function fail(code: ApiError['error']['code'], message: string, status: number): Response {
  return json({ error: { code, message } } satisfies ApiError, status);
}

/**
 * The archive is a reading room. Wrapping every handler in this makes the
 * read-only contract explicit rather than incidental: anything that is not a
 * GET or HEAD is refused by the route itself, not by the absence of a branch.
 */
export function readOnly(
  handler: (ctx: RequestContext) => Promise<Response>,
): (ctx: RequestContext) => Promise<Response> {
  return async (ctx) => {
    if (ctx.request.method !== 'GET' && ctx.request.method !== 'HEAD') {
      const res = fail('method_not_allowed', 'The archive is read-only.', 405);
      res.headers.set('allow', 'GET, HEAD');
      return res;
    }
    try {
      return await handler(ctx);
    } catch (err) {
      console.error('archive error', err);
      return fail('internal', 'The archive did not answer.', 500);
    }
  };
}

/** One route parameter, flattened. Pages hands back string | string[]. */
export function param(ctx: RequestContext, name: string): string {
  const raw = ctx.params[name];
  return Array.isArray(raw) ? (raw[0] ?? '') : (raw ?? '');
}
