//
//  ArticleView.swift
//  Horsely
//
//  Created by Saba Dawit on 10/2/20.
//  Copyright © 2020 Saba Dawit. All rights reserved.
//

import SwiftUI

struct ArticleView: View {
     @Binding var showSheetView: Bool
    var body: some View {
        ScrollView{
        VStack{
            VStack{
            Text("Asthma Education")
                .fontWeight(.semibold)
                .font(.system(size: 20))
                .font(.title)
                .padding(.trailing, 20)
                .padding(.leading, 20)
                .padding(.top, 15)
                .padding(.bottom, 15)
            }.frame(minWidth: 0, maxWidth: .infinity)
            .frame(height: 70)
                .background(ColorManager.darkgreen)
            Spacer()
            Text("Create an Action Plan")
                .font(.title)
                .fontWeight(.semibold)
             Text("SABA DAWIT")
                .font(.subheadline).fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 150)
            Text("October 3, 2020")
            .font(.system(size: 12, weight: .bold, design: .default))
            .foregroundColor(.gray)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 150)
            Image("horse2")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Spacer()
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Massa enim nec dui nunc mattis enim. Sit amet volutpat consequat mauris nunc. Risus nec feugiat in fermentum posuere urna. A iaculis at erat pellentesque adipiscing commodo elit at. Proin sed libero enim sed faucibus turpis in eu. Accumsan lacus vel facilisis volutpat. In hac habitasse platea dictumst quisque. Pharetra pharetra massa massa ultricies mi quis. Sed vulputate odio ut enim blandit volutpat maecenas volutpat blandit. Sit amet cursus sit amet dictum sit amet. Vel facilisis volutpat est velit egestas.Elementum sagittis vitae et leo. Arcu dictum varius duis at consectetur lorem donec massa. Ultricies tristique nulla aliquet enim tortor. Ullamcorper eget nulla facilisi etiam. Sed risus ultricies tristique nulla aliquet enim tortor at. Adipiscing elit ut aliquam purus sit amet luctus. Lobortis elementum nibh tellus molestie nunc non blandit massa. Nunc sed augue lacus viverra vitae congue eu. Est placerat in egestas erat imperdiet sed euismod nisi. Adipiscing vitae proin sagittis nisl. Cras ornare arcu dui vivamus arcu felis bibendum. Volutpat sed cras ornare arcu dui vivamus. Tincidunt dui ut ornare lectus sit amet est placerat. Ac felis donec et odio. Ullamcorper a lacus vestibulum sed arcu non. Malesuada bibendum arcu vitae elementum. Rhoncus urna neque viverra justo nec ultrices dui sapien eget. Mi eget mauris pharetra et ultrices neque. Ultricies mi quis hendrerit dolor magna eget. Purus in massa tempor nec feugiat. Cursus mattis molestie a iaculis at. Scelerisque eu ultrices vitae auctor eu augue ut. Augue eget arcu dictum varius duis. Adipiscing vitae proin sagittis nisl rhoncus mattis. A lacus vestibulum sed arcu non odio euismod lacinia. Auctor neque vitae tempus quam pellentesque nec nam aliquam sem. Rhoncus aenean vel elit scelerisque mauris pellentesque pulvinar. Eget felis eget nunc lobortis mattis aliquam faucibus purus in. Fames ac turpis egestas sed tempus. Non diam phasellus vestibulum lorem sed risus ultricies tristique. Lacus laoreet non curabitur gravida. Adipiscing at in tellus integer. In tellus integer feugiat scelerisque varius. Malesuada fames ac turpis egestas. Nibh ipsum consequat nisl vel pretium. Malesuada bibendum arcu vitae elementum. Rhoncus urna neque viverra justo nec ultrices dui sapien eget. Mi eget mauris pharetra et ultrices neque. Ultricies mi quis hendrerit dolor magna eget. Purus in massa tempor nec feugiat. Cursus mattis molestie a iaculis at. Scelerisque eu ultrices vitae auctor eu augue ut. Augue eget arcu dictum varius duis. Adipiscing vitae proin sagittis nisl rhoncus mattis. A lacus vestibulum sed arcu non odio euismod lacinia. Auctor neque vitae tempus quam pellentesque nec nam aliquam sem. Rhoncus aenean vel elit scelerisque mauris pellentesque pulvinar. Eget felis eget nunc lobortis mattis aliquam faucibus purus in. Fames ac turpis egestas sed tempus. Non diam phasellus vestibulum lorem sed risus ultricies tristique. Lacus laoreet non curabitur gravida. Adipiscing at in tellus integer. In tellus integer feugiat scelerisque varius. Malesuada fames ac turpis egestas. Nibh ipsum consequat nisl vel pretium.")
                .padding(.leading, 10)
            .padding(.trailing, 10)
        }
    }
    }
}

