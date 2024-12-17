import React from 'react';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import HomeScreen from '../../Screens/HomePage/HomeScreen';
import SDKLaunchScreen from '../../Screens/HomePage/SDKLaunch';
import { Image } from 'react-native';

const Tab = createBottomTabNavigator();

export default function Customtabbar() {
  return (
    <Tab.Navigator
      screenOptions={({ route }) => ({
        tabBarInactiveTintColor : "gray",
        tabBarActiveTintColor : "#007bff",
        tabBarIcon: ({ focused }) => {
          let iconSource;

          if (route.name === 'Home') {
            iconSource = focused
              ? require('../../Assets/homeTab.png')
              : require('../../Assets/homeUnselect.png');
          } else if (route.name === 'Launch') {
            iconSource = focused
              ? require('../../Assets/launch.png')
              : require('../../Assets/launchUnselect.png');
          }

          return <Image source={iconSource} style={{ width: 25, height: 25 }} />;
        },
      })}
     
    >
      <Tab.Screen name="Home" component={HomeScreen} options={{ headerShown: false }} />
      <Tab.Screen name="Launch" component={SDKLaunchScreen} options={{ headerShown: false }} />
    </Tab.Navigator>
  );
}
