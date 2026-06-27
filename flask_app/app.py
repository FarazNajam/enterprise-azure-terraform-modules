from flask import Flask, jsonify
from azure.identity import DefaultAzureCredential
from azure.keyvault.secrets import SecretClient
from azure.appconfiguration import AzureAppConfigurationClient

app = Flask(__name__)

# Managed Identity
credential = DefaultAzureCredential()

# Key Vault
vault_url = "https://p-auea-flaskapp-kv01s.vault.azure.net/"
secret_client = SecretClient(
    vault_url=vault_url,
    credential=credential
)

# Retrieve SQL connection string
sql_connection_string = secret_client.get_secret(
    "SqlConnectionString"
).value

# App Configuration
appconfig_endpoint = "https://p-auea-flaskapp-appconfig01.azconfig.io"

appconfig_client = AzureAppConfigurationClient(
    base_url=appconfig_endpoint,
    credential=credential
)

environment = appconfig_client.get_configuration_setting(
    key="Environment"
).value

@app.route("/")
def home():

    return jsonify(
        {
            "application": "Incident Tracking API",
            "environment": environment
        }
    )

@app.route("/health")
def health():

    return jsonify(
        {
            "status": "Healthy"
        }
    )

if __name__ == "__main__":
    app.run()