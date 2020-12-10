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
    var number: Int
    var titles = ["What is Equine Asthma?", "What does Equine Asthma look like in a horse?","How is Equine Asthma treated?", "Are there other terms for Equine Asthma? ", "If my horse has mild Equine Asthma, will they go on to develop severe Equine Asthma?", "Is there a cure for Equine Asthma?", "How can I change my horse’s management to help control the signs of Equine Asthma?"]
    var articles = ["Equine Asthma has many similarities to asthma in people. Asthma, in horses and people, is characterized by inflammation (increased numbers of certain white blood cells and mucous) in the lungs. The airways are also narrowed by bronchoconstriction, or spasm of the tiny muscles that surround the lower airways. While some horses may develop a secondary pneumonia, most horses with asthma will NOT have an infection. Some, but not all, horses with mild Equine asthma will develop signs after they recover from a viral infection. Some horses develop signs after breathing in small particles (molds, allergens such as pollen, etc) from the air. The lungs then develop inflammation and bronchoconstriction. Regardless of what first causes asthma in a horse, breathing in dust, mold, pollen, or other airborne particles will continue to make the disease continue.", "Equine Asthma symptoms can range from very mild, to very severe in horses.\nMild Equine Asthma\nMost common in horses <7 years of age, but can be older\nCough with exercise\nProlonged recovery from exercise\nReduced performance\n\nSevere Equine Asthma \nTypically > 7 years of age\nCough at rest\nCough when eating\nIncreased rate and/or effort of breathing\n“Heave line”\nNasal discharge, both nostrils- may range from clear to whitish\nExercise intolerance\nMay lose weight\nSigns are often worse seasonally. It is common for horses in the Southern United States to have signs that are worse in the summer (Summer Pasture Associated Recurrent Airway Obstruction). It is also common for horses in the Northern United States to have signs that are worse in the winter. However, each horse will be variable in terms of their worst season.", "There are two key parts to treating horses with asthma: 1) Environmental Control 2) Medications\nIt is very important that environmental control measures are taken to reduce the amount of airborne particles horses breathe in. Medications will not work nearly as well, or may not work at all, if the environment is not changed.", "Over the years, this disease has been called many different names. The names have changed as equine researchers have come to learn more and more about Asthma in horses. One of the names you may have heard before when referring to mild asthma is: Inflammatory Airway Disease, or IAD. Some of the names you may have head before when referring to the more severe forms of asthma include: heaves (we still use this one!), Chronic Obstructive Pulmonary Disease or COPD, or Recurrent Airway Obstruction or RAO.  The term Equine Asthma is an umbrella term that includes the mild to the severe forms.","Although some horses with mild Equine Asthma will develop severe Equine Asthma later in life, many horses will not progress.", "There is not known cure for Equine Asthma. This is because not one single thing causes asthma. Rather, many things can contribute to the development of asthma, including genetics, environmental exposure to airborne particles, viral infections, etc.","The overall goal for environmental management is to reduce the amount of exposure your horse has to airborne particles including dusts, molds, pollens, etc. Here are some strategies that you can use to reduce exposure to dust:\n1)    Do not allow them to eat from a round bale. Although more economical, round bales have more dust/mold than other types of hay.\n2)    Wet hay before feeding. There are many ways to do this, and several commercial products are available to help. \na.    One of the simplest ways to accomplish wetting the hay is to fill a hay net, place it in a clean muck bucket, and fill the bucket with water. You can let the hay soak for 5-10 min before removing the hay net and letting excess water drain before feeding. (Please note that soaking for longer periods such as 30 min will remove starches and may remove some important water- soluble vitamins from the hay, so talk to your vet about what to do if a longer soak is necessary for your routine). \nb.    Hay steamers are also available commercially, and are excellent at removing airborne dust, molds, and bacteria.\n3)    Remove the horse from the stall when cleaning the stall or replacing bedding. Do this every time.\n4)    Keep the horse house in a stall with good ventilation to the outside, and in a non- dusty barn in in which hay is not stored, and away from areas that may be dusty.\n5)    If your horse is worse in the summer, they may summer from Summer Pasture Associated Recurrent Airway Obstruction. These horses will often need to remain in a stall during warm summer/spring months. This is more commonly encountered in the southern United States, but can also occur in northern United States.\nConversely, many horses in the northern United States will have worse symptoms when housed indoors during winter months. These horses may respond to continual housing outdoors during the winter.\n6)    Avoid dusty arenas, trails, etc. Such conditions can worsen signs rapidly.\n7)    Follow your veterinarian’s recommendations for medical treatment carefully and ask them what signs to look for if your horse has a flare-up."]
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
            Text(titles[number])
                .font(.title)
                .fontWeight(.semibold)
             Text("CLARE RYAN")
                .font(.subheadline).fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 150)
            Text("December 3, 2020")
            .font(.system(size: 12, weight: .bold, design: .default))
            .foregroundColor(.gray)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 150)
            Image("horse2")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Spacer()
            Text(articles[number])
                .padding(.leading, 10)
            .padding(.trailing, 10)
        }
    }
    }
}

