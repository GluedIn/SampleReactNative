import { DrawerContentScrollView, DrawerItemList } from "@react-navigation/drawer"
import { useNavigation } from "@react-navigation/native"
import { View } from "react-native"

const CustomDrawerComponent = (props) => {

    const navigation = useNavigation()

    return (

        <View style={{ flex: 1, backgroundColor: 'white' }}>
            <DrawerContentScrollView {...props}
                contentContainerStyle={{ flex: 1, backgroundColor: 'white', }}
                scrollEnabled={false}
            >
                <View
                    style={{ backgroundColor: 'white', flex: 1, paddingTop: 10 }}
                >
                    <DrawerItemList {...props} />
                </View>
            </DrawerContentScrollView>
        </View>
    )
}

export default CustomDrawerComponent;