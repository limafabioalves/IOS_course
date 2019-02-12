//
//  ContatosNoMapaViewController.swift
//  ContatosIP67
//
//  Created by ios8207 on 08/02/19.
//  Copyright © 2019 Caelum. All rights reserved.
//

import UIKit
import MapKit

class ContatosNoMapaViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapa: MKMapView!
    
    var contatos: [Contato] = Array()
    let dao:ContatoDao = ContatoDao.sharedInstance()
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapa.delegate = self
        
        self.locationManager.requestWhenInUseAuthorization()
        
        let botaoLocalizacao = MKUserTrackingBarButtonItem(mapView: self.mapa)
        
        self.navigationItem.rightBarButtonItem = botaoLocalizacao

        // Do any additional setup after loading the view.
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil;
        }
        
        let identifier: String = "pino"
        var pino:MKPinAnnotationView
        
        if let reusablePin = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
            pino = reusablePin
        } else {
            pino = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        
        if let contato = annotation as? Contato{
            pino.pinTintColor = UIColor.red
            pino.canShowCallout = true
            
            let frame = CGRect(x: 0.0, y: 0.0, width: 32.0, height: 32.0)
            let imagemContato = UIImageView(frame: frame)
            
            imagemContato.image = contato.foto
            pino.leftCalloutAccessoryView = imagemContato
        }
        
        return pino
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
        //let a = view.annotation?.title
        //mapView.centerCoordinate.latitude = (view.annotation?.coordinate.latitude)!
        //mapView.centerCoordinate.longitude = (view.annotation?.coordinate.longitude)!
        
        mapView.setCenter((view.annotation?.coordinate)!, animated: true)
        
        print("altitude: \(mapView.camera.altitude)")
        if mapView.camera.altitude > 500 {
            mapView.camera.altitude = 500
        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print("mudou a regiao do mapa")
    }
    
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        print("terminou de renderizar o mapa")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.contatos = dao.listaTodos()
        self.mapa.addAnnotations(self.contatos)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.mapa.removeAnnotations(self.contatos)
        self.mapa.camera.altitude = 9874730.73
        self.mapa.setCenter(self.mapa.userLocation.coordinate, animated: false)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
