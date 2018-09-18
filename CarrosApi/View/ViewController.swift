//
//  ViewController.swift
//  CarrosApi
//
//  Created by André Brilho on 30/07/2018.
//  Copyright © 2018 André Brilho. All rights reserved.
//

import UIKit
import MBProgressHUD

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    //Variabels
    var carros:[Carro] = []
    var tiposCarros = ["Esportivos" ,"Classicos" ,"Luxo"]
    
    @IBOutlet weak var tbvCarros: UITableView!
    @IBOutlet weak var pickerViewTipoCarros: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbvCarros.dataSource = self
        tbvCarros.delegate = self
        pickerViewTipoCarros.dataSource = self
        pickerViewTipoCarros.delegate = self
        
        //register da celula customizada para exibir o carro
        tbvCarros.register(UINib(nibName: "CarroTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        //call func api
        getCarros()
    }
    
    //Resquest Api, passando como parametro a string de carros que vier do valor da linha do pickerview carros
    func getCarros(){
        let progress = MBProgressHUD.showAdded(to: view, animated: true)
        progress.label.text = Constantes.CARREGANDO
        ApiCarrros.getCarros(tipoCarro: tiposCarros[pickerViewTipoCarros.selectedRow(inComponent: 0)]) { (carros) in
            self.carros = carros
            DispatchQueue.main.async {
                progress.hide(animated: true)
                self.tbvCarros.reloadData()
            }
        }
    }
    
    //Resquest Api para teste
    func getOnluSportsCar(){
        ApiCarrros.getCarrosEsportivosAPI { (carrosEsportes) in
            self.carros = carrosEsportes
            for carros in carrosEsportes {
                print(carros.nome!)
            }
        }
    }
    
    
    //MARK: PickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tiposCarros.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tiposCarros[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        getCarros()
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = tiposCarros[row]
        let myTitle = NSAttributedString(string: title, attributes: [NSAttributedStringKey.font:UIFont(name: "Avenir Light", size: 10.0)!,NSAttributedStringKey.foregroundColor:ColorHex(hex: Constantes.CORDEFAULT)])
        return myTitle
    }
    
    //MARK: TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carros.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CarroTableViewCell{
            cell.carro = carros[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailCarroViewController = storyboard?.instantiateViewController(withIdentifier: "DetalhesViewController") as? DetalhesViewController {
            detailCarroViewController.carro = carros[indexPath.row]
        self.present(detailCarroViewController, animated: true)
    
        }
    }
    
    
}

