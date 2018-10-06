//
//  ViewController.swift
//  functionalTable (repaso)
//
//  Created by Eduardo on 6/10/18.
//  Copyright © 2018 Eduardo Jordan Muñoz. All rights reserved.
//

import UIKit



struct Item{
    enum Tipo{
        case fruta,verdura,carne
    }
    let nombre : String
    let tipo: Tipo
    let costoTotal: Int
}

let datos: [Item] = [
    Item(nombre: "Papa", tipo: .verdura, costoTotal: 4),
    Item(nombre: "Pollo", tipo: .carne, costoTotal: 12),
    Item(nombre: "Zanahoria", tipo: .verdura, costoTotal: 5),
    Item(nombre: "Manzana", tipo: .fruta, costoTotal: 7),
    Item(nombre: "Durazno", tipo: .fruta, costoTotal: 6),
    Item(nombre: "Lechuga", tipo: .verdura, costoTotal: 8),
    Item(nombre: "Pescado", tipo: .carne, costoTotal: 9),
    Item(nombre: "Tomate", tipo: .verdura, costoTotal: 7)
]


// Varios array en un array en lo que varian los datos

let datosAnidados: [[Item]] = [
    [Item(nombre: "Papa", tipo: .verdura, costoTotal: 4), Item(nombre: "Zanahoria", tipo: .verdura, costoTotal: 5), Item(nombre: "Lechuga", tipo: .verdura, costoTotal: 8), Item(nombre: "Tomate", tipo: .verdura, costoTotal: 7) ],
    [Item(nombre: "Pollo", tipo: .carne, costoTotal: 12), Item(nombre: "Pescado", tipo: .carne, costoTotal: 9) ],
    [Item(nombre: "Manzana", tipo: .fruta, costoTotal: 7), Item(nombre: "Durazno", tipo: .fruta, costoTotal: 6)]
]



// datos en array con nill

let datosAnidados2: [[Item?]] = [
    [Item(nombre: "Papa", tipo: .verdura, costoTotal: 4), Item(nombre: "Zanahoria", tipo: .verdura, costoTotal: 5), Item(nombre: "Lechuga", tipo: .verdura, costoTotal: 8), Item(nombre: "Tomate", tipo: .verdura, costoTotal: 7) ],
    [Item(nombre: "Pollo", tipo: .carne, costoTotal: 12), Item(nombre: "Pescado", tipo: .carne, costoTotal: 9), nil ],
    [Item(nombre: "Manzana", tipo: .fruta, costoTotal: 7), Item(nombre: "Durazno", tipo: .fruta, costoTotal: 6), nil]
]



class ViewController: UIViewController {
    

    
    
    
    //CREAMOS MODELO DENTRO DE LA CLASE
    
    var model : [Item] = [] {
        didSet {
            // cada vez que recrgemos el tableView too
            tableView.reloadData()
            
            
            
            //Para cambiar el label del total
            //1era forma
//            let values = model.map{ $0.costoTotal }
//            totalLabel.text = "\(values.reduce(0,+)) €"
//
            
            //2da forma
            let total = model.reduce(0) { partial, item -> Int
                in
                return partial + item.costoTotal
            }
            
            totalLabel.text = "\(model.reduce(0, { $0 + $1.costoTotal})) €"
        }
    }
    
    
    
    
    
    //IBOUTLET

    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var totalLabel: UILabel!
    
    
    
    //IBACTION
    @IBAction func showAll(_ sender: Any) {
       // model = datos
       // model = datosAnidados.flatMap {$0}
        
        model = datosAnidados2.flatMap {$0.compactMap{$0}}
        
    }
    
    
    @IBAction func showFruits(_ sender: Any) {
        
    // MANERA FUCIONAL---->>>>
      //  model = datos.filter({ $0.tipo == .fruta })
        
     //   model = datosAnidados.flatMap{$0}.filter({ $0.tipo == .fruta })
        
        model = datosAnidados2.flatMap{$0.compactMap{$0}}.filter({ $0.tipo == .fruta })
        
        // OTRA MANERA DE HACERLO
 
    // MANERA NO FUNCIONAL---->>>
//        var frutas : [Item] = []
//        for item in datos{
//            if item.tipo == .fruta{
//                frutas.append(item)
//            }
//        }
//        model = frutas
     }
    
    
    @IBAction func showVegetables(_ sender: Any) {
        
     //   model = datos.filter{ $0.tipo == .verdura
   //     model = datosAnidados.flatMap{$0}.filter({ $0.tipo == .verdura })
        
        model = datosAnidados2.flatMap{$0.compactMap{$0}.filter{$0.tipo == .verdura}
        
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Asignamos los datos al modelo
     //   model = datos
        // el el caso de los array dentro de arrays // El flat map aplana la data! por asidecirlo
      //  model = datosAnidados.flatMap{$0}
        
        
     //   Para eliminar los nil  del array
        model = datosAnidados2.flatMap{$0.compactMap({$0})}
       
    }


}


//AGREGAMOS EL TABLEVIEW DATASOURCE
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = model[indexPath.row].nombre
        cell.detailTextLabel?.text = "\(model[indexPath.row].costoTotal) €"
        
        return cell
    }
    
    
}
