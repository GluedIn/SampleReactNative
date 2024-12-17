import { useNavigation } from '@react-navigation/native';
import React, { useEffect } from 'react';
import { View, Text, Button, TouchableOpacity, NativeModules, NativeEventEmitter } from 'react-native';

const SDKLaunchScreen = () => {
    const navigation = useNavigation();
    const { GluedInBridge } = NativeModules;
    const eventEmitter = new NativeEventEmitter(GluedInBridge);

    useEffect(() => {
        const eventListener = eventEmitter.addListener('onSignInClick', (event) => {
            console.log("here is message from callback ===>>>> ",event);
            navigation.navigate('Login')
        });
        const eventSignupListener = eventEmitter.addListener('onSignUpClick', (event) => {
            console.log("here is message from callback ===>>>> ",event);
            navigation.navigate('SignUp')
        });
        return () => {
            eventListener.remove();
            eventSignupListener.remove();
        };
    }, []);

    const launchSDK = () => {
        GluedInBridge.launchSDK((error, result) => {
            if (error) {
                console.error(error);
            } else {
                console.log(result);
            }
        });
    };

    return (
        <View style={{justifyContent: 'center',alignItems:'center',flex:1}}>
            <TouchableOpacity
            onPress={()=>{
                launchSDK()
            }}
            >
            <Text style={{color:'#007bff',fontWeight:'700'}} >Launch SDK</Text>
            </TouchableOpacity>

        </View>
    );
}
export default SDKLaunchScreen