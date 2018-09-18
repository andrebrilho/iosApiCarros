//
//  apiCarrros.swift
//  CarrosApi
//
//  Created by André Brilho on 30/07/2018.
//  Copyright © 2018 André Brilho. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

public class ApiCarrros {
    
    
    static func getCarros(tipoCarro:String, completion:@escaping (([Carro]) -> Void)){
        if let url = URL(string: Constantes.URLBASE + tipoCarro.lowercased() + Constantes.EXTENSIONURL){
            var request = URLRequest(url: url)
            request.timeoutInterval = 0
            request.setValue("application/gzip", forHTTPHeaderField: "Accept-Encoding")
            Alamofire.request(request).responseData(completionHandler: { (response) in
                do {
                    let carroResponse = try JSONDecoder().decode(CarrosResponse.self, from: response.data!)
                    completion(carroResponse.carros.carro)
                } catch{
                    print("erro na requisição ou no parser")
                }
            })
        }
    }
    
    //chamada simples
    static func getCarrosEsportivosAPI(completion:@escaping (([Carro])) -> Void){
        if let urlCarrosEsportes = URL(string: Constantes.URLBASECARROESPORTIVO){
            let requestForCarro = URLRequest(url: urlCarrosEsportes)
            Alamofire.request(requestForCarro).responseData(completionHandler: { (respostaServer) in
                do {
                    let carrosEsportes = try JSONDecoder().decode(CarrosResponse.self, from: respostaServer.data!)
                    completion(carrosEsportes.carros.carro)
                }catch {
                    print("erro na requisição ou no parser")
                }
            })
        }
    }
}
