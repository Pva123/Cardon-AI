# chatbot/model.py
from transformers import pipeline

# Load pre-trained conversational model
def load_chatbot():
    # Load fine-tuned model and tokenizer
    model_dir = "./fine_tuned_model"
    return pipeline("conversational", model=model_dir)


# Example usage
if __name__ == "__main__":
    chatbot = load_chatbot()
    response = chatbot("Can you schedule evenings free for me?")
    print(response)
