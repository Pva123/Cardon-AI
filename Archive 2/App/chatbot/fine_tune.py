from transformers import AutoModelForCausalLM, AutoTokenizer, Trainer, TrainingArguments
from datasets import load_dataset, DatasetDict

def fine_tune_chatbot(data_path, model_name="microsoft/DialoGPT-medium", output_dir="./fine_tuned_model"):
    """
    Fine-tunes a pre-trained conversational AI model using a custom dataset.
    
    Args:
        data_path (str): Path to the JSON dataset.
        model_name (str): Pre-trained model to use for fine-tuning.
        output_dir (str): Directory to save the fine-tuned model.
    """
    # Load tokenizer and model
    tokenizer = AutoTokenizer.from_pretrained(model_name)
    model = AutoModelForCausalLM.from_pretrained(model_name)

    # Load custom dataset
    dataset = load_dataset("json", data_files=data_path)

    # Tokenize the dataset
    def tokenize_function(examples):
        return tokenizer(examples["text"], truncation=True, padding="max_length", max_length=128)

    tokenized_dataset = dataset.map(tokenize_function, batched=True)

    # Split the dataset into training and validation sets
    dataset = tokenized_dataset["train"].train_test_split(test_size=0.2)

    # Training arguments
    training_args = TrainingArguments(
        output_dir=output_dir,
        evaluation_strategy="epoch",
        learning_rate=5e-5,
        per_device_train_batch_size=8,
        num_train_epochs=3,
        weight_decay=0.01,
        save_steps=10_000,
        save_total_limit=2,
        logging_dir='./logs',
    )

    # Initialize Trainer
    trainer = Trainer(
        model=model,
        args=training_args,
        train_dataset=dataset["train"],
        eval_dataset=dataset["test"],
    )

    # Train the model
    trainer.train()

    # Save the fine-tuned model
    model.save_pretrained(output_dir)
    tokenizer.save_pretrained(output_dir)

    print(f"Fine-tuned model saved to {output_dir}")

# Run the fine-tuning process
if __name__ == "__main__":
    data_path = "../data/training_data.json"  # Path to your dataset
    fine_tune_chatbot(data_path)
