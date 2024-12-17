import { useNavigation } from '@react-navigation/native';
import React, { useState } from 'react';
import { View, Text, TextInput, TouchableOpacity, StyleSheet, Alert, NativeModules } from 'react-native';
import { KeyboardAwareScrollView } from 'react-native-keyboard-aware-scroll-view';
import { SafeAreaView } from 'react-native-safe-area-context';
import CustomLabelWithTextField from '../../Components/CustomTextField';

const LoginScreen = () => {
    const navigation = useNavigation();

    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const { GluedInBridge } = NativeModules;

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    const handleLogin = () => {
        if (email === '') {
            Alert.alert("Validation Error", "Please enter email address.");
            return
        }
        if (password === '') {
            Alert.alert("Validation Error", "Please enter password.");
            return
        }
        if (!emailRegex.test(email)) {
            Alert.alert("Validation Error", "Please enter a valid email address.");
            return;
        }
        GluedInBridge.performLogin(email, password, (error, result) => {
            if (error) {
                console.error(error);
                Alert.alert("Error", error);
            } else {
                console.log(result);
            }
        });
    };

    const handleSignup = () => {
        navigation.navigate('SignUp')
    };


    return (
        <KeyboardAwareScrollView>
            <View style={styles.container}>
            <CustomLabelWithTextField
                    title={'Email'}
                    placeholder={'Enter your email'}
                    onChangeText={setEmail}
                    value={email}
                    keyboardType="email-address"
                />

                <CustomLabelWithTextField
                    title={'Password'}
                    placeholder={'Enter your password'}
                    onChangeText={setPassword}
                    value={password}
                    keyboardType=""
                    isSecureEntry={true}
                />
                <TouchableOpacity style={styles.button} onPress={handleLogin}>
                    <Text style={styles.buttonText}>Login</Text>
                </TouchableOpacity>

                <TouchableOpacity style={[styles.button, { backgroundColor: 'transparent', marginTop: 16 }]} onPress={handleSignup}>
                    <Text style={[styles.buttonText, { color: '#007bff' }]}>Create new account</Text>
                </TouchableOpacity>
            </View>
        </KeyboardAwareScrollView>

    );
}
export default LoginScreen



const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        padding: 16,
        backgroundColor: '#f5f5f5',
    },
    label: {
        fontSize: 16,
        fontWeight: 'bold',
        marginBottom: 8,
    },
    input: {
        height: 40,
        borderColor: '#ccc',
        borderWidth: 1,
        borderRadius: 4,
        paddingHorizontal: 8,
        marginBottom: 16,
    },
    button: {
        backgroundColor: '#007bff',
        paddingVertical: 12,
        borderRadius: 4,
        alignItems: 'center',
    },
    buttonText: {
        color: '#fff',
        fontSize: 16,
        fontWeight: 'bold',
    },
});