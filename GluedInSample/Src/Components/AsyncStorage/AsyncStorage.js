import AsyncStorage from "@react-native-async-storage/async-storage";
import Constant from "../Contant/Constant";


class AsyncStorageHelper {
    static async setItem(key, value) {
        try {
            await AsyncStorage.setItem(key, JSON.stringify(value));
        } catch (error) {
            console.error('AsyncStorage setItem error:', error);
        }
    }

    static async getItem(key) {
        try {
            const value = await AsyncStorage.getItem(key);
            return value !== null ? JSON.parse(value) : null;

        } catch (error) {
            console.error('AsyncStorage getItem error:', error);
            return null;
        }
    }

    static async removeItem(key) {
        try {
            await AsyncStorage.removeItem(key);
        } catch (error) {
            console.error('AsyncStorage removeItem error:', error);
        }
    }

    static async isUserLoggedIn() {
        try {
          const value = await AsyncStorage.getItem(Constant.StorageKeys.isUserLoggedIn);
          return value != null ? JSON.parse(value) : null;
    
        } catch (error) {
          console.error('AsyncStorage getItem error:', error);
          return null;
        }
      }


    static async clearAll() {
        try {
            await AsyncStorage.clear();
        } catch (error) {
            console.error('AsyncStorage clearAll error:', error);
        }
    }
}

export default AsyncStorageHelper;
