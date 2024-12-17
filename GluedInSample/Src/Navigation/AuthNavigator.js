import React from 'react';
import { createStackNavigator } from '@react-navigation/stack';
import LoginScreen from '../Screens/Auth/LoginScreen';
import SignupScreen from '../Screens/Auth/SignupScreen';

const AuthStack = createStackNavigator();

export default function AuthNavigator() {
    return (
        <AuthStack.Navigator>
            <AuthStack.Screen name="Login" component={LoginScreen} />
            <AuthStack.Screen name="Signup" component={SignupScreen} />
        </AuthStack.Navigator>
    );
}
