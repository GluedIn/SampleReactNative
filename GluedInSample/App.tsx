/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */

import { NavigationContainer } from '@react-navigation/native';
import React from 'react';
import AppNavigator from './Src/Navigation/AppNavigator';
import { createStackNavigator } from '@react-navigation/stack';
import LoginScreen from './Src/Screens/Auth/LoginScreen';
import SignupScreen from './Src/Screens/Auth/SignupScreen';
const Stack = createStackNavigator();

export default function App() {
  return (
    <NavigationContainer>
      <Stack.Navigator >
      <Stack.Screen name={'Drawer'} component={AppNavigator} options={{ headerShown: false, headerTitleAlign: 'center', gestureEnabled: false }} />
      <Stack.Screen name={'Login'} component={LoginScreen} options={{ headerShown: true }} />
      <Stack.Screen name={'SignUp'} component={SignupScreen} options={{ headerShown: true }} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}