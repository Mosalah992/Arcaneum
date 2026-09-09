/**
 * Reckoning the in-world hour.
 *
 * PORTED FROM THE THALMOR ARCHIVE's `shared/reckoning.ts`, which is the one
 * place in the College's projects that knows what day it is. Carried across
 * rather than re-derived on purpose: two archives of the same realm disagreeing
 * about the date would be worse than either of them being wrong, and the rate
 * and the anchor below were measured over there against the realm's own clock.
 * The month names come from that project's `shared/parsers/calendar.ts`.
 *
 * THE RATE IS 2:1 — two in-world minutes for every real one, so a real day is
 * two days in the realm. It was measured, not chosen, from two readings of the
 * realm's clock 15.74 real hours apart:
 *
 *   Heartfire 4, 18:04   at 2026-08-16 20:05 UTC
 *   Heartfire 6, 01:26   at 2026-08-17 11:46 UTC
 *
 *   31.37 in-world hours / 15.74 real hours = 1.9931
 *
 * A GUESS AT THE RATE COMPOUNDS. An error in the anchor is a fixed offset and
 * stays the size it started; an error in the rate grows. If the realm is ever
 * re-set, take two readings a few hours apart, check RATE, and only then touch
 * ANCHOR — and change them in the Thalmor archive too, or the two clocks part.
 *
 * WHY THE YEAR IS COUNTED IN DAYS AND NOT READ OFF A `Date`. The twelve
 * Tamrielic months happen to carry the same lengths as the Gregorian ones, so
 * it is tempting to shift a `Date` and read its month and day straight out.
 * That works until a leap day lands and the archive reports Sun's Dawn 29, a
 * date that does not exist. The Tamrielic year is 365 days, always.
 *
 * EVERYTHING HERE IS UTC. `Date.now()` is an instant, not a civil time, and no
 * local field is ever read. A reader in Cairo and a reader in Seattle are told
 * the same in-world hour, which is the point — the realm has one clock.
 */

/** Days in each Tamrielic month, in order. Sums to 365. */
export const MONTH_LENGTHS: readonly number[] = [
  31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31,
];

/** Canonical order of the Tamrielic year. */
export const MONTHS: readonly string[] = [
  'Morning Star',
  "Sun's Dawn",
  'First Seed',
  "Rain's Hand",
  'Second Seed',
  'Mid Year',
  "Sun's Height",
  'Last Seed',
  'Heartfire',
  'Frostfall',
  "Sun's Dusk",
  'Evening Star',
];

export const DAYS_PER_YEAR = 365;
const MINUTES_PER_DAY = 24 * 60;

/** How fast the realm runs against the world. Measured — see above. */
export const RATE = 2;

/**
 * One real instant paired with the in-world moment it was declared to be.
 * Everything else is arithmetic from here, so correcting the clock means
 * editing this and RATE and nothing else.
 */
const ANCHOR = {
  realMs: Date.UTC(2026, 7, 16, 20, 5, 0),
  year: 226,
  /** Heartfire 4 — the 247th day of the year. */
  dayOfYear: 247,
  minuteOfDay: 18 * 60 + 4,
} as const;

export interface InWorldMoment {
  /** Fourth Era year, e.g. 226. */
  year: number;
  /** 1-based position in the Tamrielic year. */
  monthIndex: number;
  /** Day of the month, 1-based. */
  day: number;
  /** 1-based day of the year, 1..365. */
  dayOfYear: number;
  hour: number;
  minute: number;
}

/** Day of the year (1-based) to its month and day. */
export function fromDayOfYear(dayOfYear: number): { monthIndex: number; day: number } {
  let remaining = dayOfYear;
  for (let i = 0; i < MONTH_LENGTHS.length; i++) {
    const length = MONTH_LENGTHS[i]!;
    if (remaining <= length) return { monthIndex: i + 1, day: remaining };
    remaining -= length;
  }
  // Unreachable for 1..365; the last month closes the year.
  return { monthIndex: 12, day: MONTH_LENGTHS[11]! };
}

/** The in-world moment at a real instant. Pure — pass any instant to reckon it. */
export function reckon(nowMs: number = Date.now()): InWorldMoment {
  const elapsedMinutes = ((nowMs - ANCHOR.realMs) / 60_000) * RATE;
  const totalMinutes = Math.floor(ANCHOR.minuteOfDay + elapsedMinutes);

  // Floor division, so instants before the anchor reckon backwards correctly
  // rather than truncating toward zero and losing a day.
  const dayShift = Math.floor(totalMinutes / MINUTES_PER_DAY);
  const minuteOfDay = totalMinutes - dayShift * MINUTES_PER_DAY;

  let dayOfYear = ANCHOR.dayOfYear + dayShift;
  let year = ANCHOR.year;
  while (dayOfYear > DAYS_PER_YEAR) {
    dayOfYear -= DAYS_PER_YEAR;
    year++;
  }
  while (dayOfYear < 1) {
    dayOfYear += DAYS_PER_YEAR;
    year--;
  }

  const { monthIndex, day } = fromDayOfYear(dayOfYear);

  return { year, monthIndex, day, dayOfYear, hour: Math.floor(minuteOfDay / 60), minute: minuteOfDay % 60 };
}

/**
 * The hour as the Embassy writes it, e.g. `6:04 PM`.
 *
 * Noon and midnight are the two a twelve-hour clock gets wrong if written
 * naively: `hour % 12` makes both of them 0, and neither is the zeroth hour of
 * anything. They are 12 PM and 12 AM.
 */
export function formatHour(moment: InWorldMoment): string {
  const onFace = moment.hour % 12 === 0 ? 12 : moment.hour % 12;
  const meridiem = moment.hour < 12 ? 'AM' : 'PM';
  return `${onFace}:${String(moment.minute).padStart(2, '0')} ${meridiem}`;
}

/** The date as the College writes it, e.g. `HEARTFIRE 4 · 4E 226`. */
export function formatDate(moment: InWorldMoment): string {
  return `${MONTHS[moment.monthIndex - 1]!.toUpperCase()} ${moment.day} · 4E ${moment.year}`;
}

/**
 * The same instant on a 24-hour clock, for a `datetime` attribute — a machine
 * reading the page should not have to parse a meridiem or a month name.
 */
export const machineTime = (moment: InWorldMoment): string =>
  `4E${moment.year}-${String(moment.monthIndex).padStart(2, '0')}-` +
  `${String(moment.day).padStart(2, '0')} ` +
  `${String(moment.hour).padStart(2, '0')}:${String(moment.minute).padStart(2, '0')}`;
