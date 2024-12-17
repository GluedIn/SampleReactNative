import { useNavigation } from "@react-navigation/native";
import { useState } from "react";
import { View, Text, TextInput, TouchableOpacity, StyleSheet, Alert, NativeModules } from 'react-native';
import CustomLabelWithTextField from "../../Components/CustomTextField";
import { KeyboardAwareScrollView } from "react-native-keyboard-aware-scroll-view";

const SignupScreen = () => {
    const navigation = useNavigation();

    const [name, setName] = useState('');
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [username, setusername] = useState('');
    const { GluedInBridge } = NativeModules;

    const handleSignup = () => {
        GluedInBridge.performSignup(name, email, password, username, (error, result) => {
            if (error) {
                console.error(error);
                Alert.alert('Error', error)
            } else {
                console.log(result);
                handleLogin()
            }
        });
    };


    const handleLogin = () => {
        navigation.navigate('Login')
    };



    return (
        <KeyboardAwareScrollView>
            <View style={styles.container}>

                <CustomLabelWithTextField
                    title={'Name'}
                    placeholder={'Enter your name'}
                    onChangeText={setName}
                    value={name}
                    keyboardType=""
                />
                <CustomLabelWithTextField
                    title={'Username'}
                    placeholder={'Enter username'}
                    onChangeText={setusername}
                    value={username}
                    keyboardType=""
                />

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

                <TouchableOpacity style={styles.button} onPress={handleSignup}>
                    <Text style={styles.buttonText}>Sign Up</Text>
                </TouchableOpacity>

                <TouchableOpacity style={[styles.button, { backgroundColor: 'transparent', marginTop: 16 }]} onPress={handleLogin}>
                    <Text style={[styles.buttonText, { color: '#007bff' }]}>Already have an account? Login</Text>
                </TouchableOpacity>
            </View>
        </KeyboardAwareScrollView>

    );
}
export default SignupScreen


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