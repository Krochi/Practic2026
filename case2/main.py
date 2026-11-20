# Базовый класс: обычный пользователь системы
class User:
    def __init__(self, name):
        self.name = name

    def greet(self):
        print(f"Привет, я {self.name}.")

# Производный класс: студент (наследует User)
class Student(User):
    def __init__(self, name, group):
        super().__init__(name)
        self.group = group

    # Переопределяем метод greet (добавляем группу)
    def greet(self):
        print(f"Привет, я студент {self.name} из группы {self.group}.")

    # Собственный метод, которого нет у User
    def take_exam(self, subject):
        print(f"Студент {self.name} сдает экзамен по предмету: {subject}.")

# --- Тестовая программа ---
if __name__ == "__main__":
    print("--- Тестирование базового класса ---")
    user1 = User("Иван")
    user1.greet() 

    print("\n--- Тестирование производного класса ---")
    student1 = Student("Алексей", "ОБПз-42409СЕии6д")
    
    student1.greet() 
    
    student1.take_exam("Программирование")
