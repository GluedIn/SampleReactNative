import { useNavigation } from '@react-navigation/native';
import React, { useEffect, useState } from 'react';
import { View, Text, Button, NativeModules, StyleSheet, FlatList, Image, Alert, TouchableOpacity } from 'react-native';

const HomeScreen = () => {
    const navigation = useNavigation();
    const { GluedInBridge } = NativeModules;
    //vertical
    // const apiKey = "be052e1f-d309-41b8-b6ed-0930e41740ea";
    // const secretKey = "2c6f5cca-fbba-479d-8c72-a7db56657b43";
    //Card
    const apiKey = "329580c8-d5c7-4b53-9bd8-55e905a69560";
    const secretKey = "66c9f76f-b07a-4e8f-852a-f92e1bcbd619";
    const [videoList, setvideoList] = useState([])
    const [hashTagsList, sethashTagsList] = useState([])
    const images = [
        { id: '1', uri: 'https://picsum.photos/300/300' },
        { id: '2', uri: 'https://picsum.photos/300/300' },
        { id: '3', uri: 'https://picsum.photos/300/300' },
        { id: '4', uri: 'https://picsum.photos/300/300' },
        { id: '5', uri: 'https://picsum.photos/300/300' },
        { id: '6', uri: 'https://picsum.photos/300/300' },
        { id: '7', uri: 'https://picsum.photos/300/300' },
        { id: '8', uri: 'https://picsum.photos/300/300' },
    ];

    useEffect(() => {
        GluedInBridge.initializeSDKOnLaunch(apiKey, secretKey, (error, result) => {
            if (error) {
                console.error(error);
            } else {
                console.log('initialize success', result);
                fetchCuratedRails();
            }
        });
    }, [])

    async function fetchCuratedRails() {
        GluedInBridge.getDiscoverSearchInAllVideoRails('', (error, result) => {
            if (error) {
                console.error(error);
                Alert.alert('Alert', error)
            } else {
                console.log('getDiscoverSearchInAllVideoRails', result);
                const hashtags = result.result.filter(item => item.contentType === 'hashtag');
                 const videos = result.result.filter(item => item.contentType === 'video');
                const users = result.result.filter(item => item.contentType === 'user');
                setvideoList(videos[0].itemList)
                sethashTagsList(hashtags[0].itemList)
            }
        })
    }

    const handleHashTagClick = (tag) => {
        GluedInBridge.handleClickedEvents('hashtag', tag._id, (error, result) => {

        })
    }

    const renderItem = ({ item }) => (
        <View style={styles.imageContainer}>
        <TouchableOpacity
        onPress={()=>{
            handleVideoClick(item)
        }}
        >
        <Image source={{ uri: item.thumbnail }} style={styles.image} />

        </TouchableOpacity>
        </View>
    );

    const hashtagChips = () => {
        return (
            <View style={styles.chipWrapper}>
                {hashTagsList.map((hashtag, index) => (
                    <TouchableOpacity key={index} style={styles.chipContainer}
                        onPress={() => {
                            handleHashTagClick(hashtag)
                        }}
                    >
                        <Text style={styles.chipText}>{hashtag.displayName}</Text>
                    </TouchableOpacity>
                ))}
            </View>
        );
    };

    const handleVideoClick = (video) => {
        console.log("video selected",video)
        GluedInBridge.userDidTapOnFeed('anyType', video, (error, result) => { // change anyType valye accordingly

        })
    };

    return (
        <View style={styles.container}>
            <Text style={styles.label}>Trending</Text>
            <FlatList
                data={videoList}
                renderItem={renderItem}
                keyExtractor={(item) => item.id}
                horizontal
                showsHorizontalScrollIndicator={false}
            />

            <Text style={[styles.label, { marginTop: 16 }]}>HashTags</Text>
            {hashtagChips()}
        </View>
    );
}
export default HomeScreen

const styles = StyleSheet.create({
    container: {
        // flex: 1,
        // justifyContent: 'center',
        padding: 8,
        backgroundColor: '#f5f5f5',
    },
    label: {
        fontSize: 16,
        fontWeight: '600',
        marginBottom: 8,
    },

    button: {
        backgroundColor: '#007bff',
        paddingVertical: 12,
        borderRadius: 4,
        alignItems: 'center',
    },
    imageContainer: {
        marginHorizontal: 4,
    },
    image: {
        width: 130,
        height: 80,
        borderRadius: 10,
    },

    chipWrapper: {
        flexDirection: 'row',
        flexWrap: 'wrap',
        padding: 0,
    },
    chipContainer: {
        backgroundColor: '#007bff',
        borderRadius: 20,
        paddingVertical: 8,
        paddingHorizontal: 8,
        margin: 4,
    },
    chipText: {
        color: 'white',
        fontSize: 12,
    },
});