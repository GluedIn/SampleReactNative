import React from 'react';
import { createDrawerNavigator } from '@react-navigation/drawer';
import { useNavigation } from '@react-navigation/native';
import HomeScreen from '../Screens/HomePage/HomeScreen';
import SDKLaunchScreen from '../Screens/HomePage/SDKLaunch';
import { Alert, Image, Text, TouchableOpacity } from 'react-native';
import CustomDrawerComponent from './Drawer/CustomDrawer';
import Customtabbar from './Drawer/CustomTabbar';

const Drawer = createDrawerNavigator();

const AppNavigator = () => {
    const navigation = useNavigation()


    const LoginButton = () => (
        <TouchableOpacity
            style={{ padding: 10 }}
            onPress={() => {
                navigation.navigate('Login')
            }}
        >
            <Text style={{ color: '#007bff', fontWeight: '500' }}>Login</Text>
        </TouchableOpacity>
    );

    return (
        <Drawer.Navigator
            drawerContent={props => <CustomDrawerComponent {...props} />}
            screenOptions={({ route }) => ({
                headerTintColor: '#007bff',
            })}
        >
            <Drawer.Screen name={'GluedIn Demo'} component={Customtabbar} options={{
                drawerIcon: (item) => (
                    <Image
                        style={{ tintColor: 'gray', height: 22, width: 22 }}
                        source={require('../Assets/homeTab.png')} />
                ),
                headerRight: () => <LoginButton />
            }} />

            <Drawer.Screen name={'Launch'} component={SDKLaunchScreen} options={{
                drawerIcon: (item) => (
                    <Image
                        style={{ tintColor: 'gray', height: 22, width: 22 }}
                        source={require('../Assets/launch.png')} />

                ),

            }} />

        </Drawer.Navigator>
    )
}

export default AppNavigator