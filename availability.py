import random


def generate_random_student_availability() -> dict:
    """
    Randomly generate a student's availability.
    Returns a dictionary with keys as lowercase day names and values as (start, end) tuples.
        """
    days = ["monday", "tuesday", "wednesday", "thursday", "friday"]
    num_days = random.randint(3, 5)
    chosen_days = random.sample(days, num_days)
    availability = {}
    for day in chosen_days:
        start = random.randint(8, 14)
        duration = random.randint(5, 8)
        end = start + duration
        availability[day] = (float(start), float(end))
    return availability


def parse_time(time_str: str) -> float:
    """
    Convert a time string (e.g., '9am' or '1pm') to a float hour.
    """
    time_str = time_str.strip().lower()
    if time_str.endswith('am'):
        hour = int(time_str[:-2])
    elif time_str.endswith('pm'):
        hour = int(time_str[:-2])
        if hour != 12:
            hour += 12
    else:
        hour = int(time_str)
    return float(hour)


def parse_professor_availability(avail_str: str) -> dict:
    """
    Parse a professor availability string into a dictionary mapping day to (start, end) hours.
    """
    avail_dict = {}
    segments = avail_str.split(',')
    for seg in segments:
        seg = seg.strip()
        if not seg:
            continue
        parts = seg.split()
        if len(parts) < 2:
            continue
        day = parts[0].lower()
        time_range = parts[1]
        if '-' in time_range:
            start_str, end_str = time_range.split('-')
            start_time = parse_time(start_str)
            end_time = parse_time(end_str)
            avail_dict[day] = (start_time, end_time)
    return avail_dict
