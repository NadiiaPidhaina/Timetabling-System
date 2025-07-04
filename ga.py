import random


def fitness(candidate: dict, professor_avail: dict, students_avails: list) -> int:
    """
    Calculate the fitness of a candidate schedule.
    For each subject, count the students whose availability on the candidate's chosen day
    covers the professor's session time.
    Returns the total matching student count.
    """
    total = 0
    for subject_code, chosen_day in candidate.items():
        if subject_code in professor_avail:
            session_time = professor_avail[subject_code].get(chosen_day, None)
            if session_time:
                for student in students_avails:
                    if chosen_day in student:
                        stud_time = student[chosen_day]
                        if stud_time[0] <= session_time[0] and stud_time[1] >= session_time[1]:
                            total += 1
    return total


def initialize_population(pop_size: int, subjects: list, professor_avail: dict) -> list:
    population = []
    for _ in range(pop_size):
        candidate = {}
        for subject in subjects:
            avail = professor_avail.get(subject, {})
            if avail:
                day = random.choice(list(avail.keys()))
                candidate[subject] = day
        population.append(candidate)
    return population


def selection(population: list, fitnesses: list) -> list:
    selected = []
    pop_size = len(population)
    for _ in range(pop_size):
        i, j = random.sample(range(pop_size), 2)
        selected.append(population[i] if fitnesses[i] > fitnesses[j] else population[j])
    return selected


def crossover(parent1: dict, parent2: dict) -> dict:
    child = {}
    for subject in parent1.keys():
        child[subject] = parent1[subject] if random.random() < 0.5 else parent2[subject]
    return child


def mutation(candidate: dict, professor_avail: dict, mutation_rate: float = 0.1) -> dict:
    for subject in candidate.keys():
        if random.random() < mutation_rate:
            avail = professor_avail.get(subject, {})
            if avail:
                candidate[subject] = random.choice(list(avail.keys()))
    return candidate


def genetic_algorithm(subjects: list, professor_avail: dict, students_avails: list,
                      pop_size: int = 50, generations: int = 100) -> tuple:
    population = initialize_population(pop_size, subjects, professor_avail)
    best_candidate = None
    best_fit = -1
    for _ in range(generations):
        fitnesses = [fitness(candidate, professor_avail, students_avails) for candidate in population]
        for candidate, f_val in zip(population, fitnesses):
            if f_val > best_fit:
                best_fit = f_val
                best_candidate = candidate
        selected = selection(population, fitnesses)
        next_population = []
        for i in range(0, pop_size, 2):
            parent1 = selected[i]
            parent2 = selected[(i + 1) % pop_size]
            child1 = crossover(parent1, parent2)
            child2 = crossover(parent2, parent1)
            next_population.extend([child1, child2])
        population = [mutation(candidate, professor_avail) for candidate in next_population]
    return best_candidate, best_fit
