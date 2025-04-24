import dotenv from 'dotenv';
dotenv.config();

  
  async function syncDatabaseYoobuLogistic<T>(
    url: string,
    data: T,
    headers: HeadersInit = {}
  ): Promise<any> {
    try {
      const defaultHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      
      const mergedHeaders = { ...defaultHeaders, ...headers };
      
      const response = await fetch(url, {
        method: 'POST',
        headers: mergedHeaders,
        body: JSON.stringify(data),
        credentials: 'include',
      });
      
      if (!response.ok) {
        throw new Error(`Erreur API: ${response.status} ${response.statusText}`);
      }
      
      const responseData = await response.json();
      
      return responseData;
    } catch (error) {
      console.error('Erreur lors de l\'appel API:', error);
      throw error;
    }
  }
  
  async function main() {
    try {
      const clientCred: {
        client_id: string,
        client_password: string
      } = {
        client_id: 'client-id',
        client_password: 'client-password',
      };
      
      console.log("Sync db started...")
      const url = process.env.YOOBU_LOGISTIC_API_URL || ""
      const result = await syncDatabaseYoobuLogistic(
        url,
        clientCred,
        { 'API-KEY': 'api-key-here' }
      );
      
      console.log('Success:', result);
    } catch (error) {
      console.error('Failed:', error);
    }
  }
  
  main();