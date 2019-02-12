//
//  Contato.m
//  ContatosIP67
//
//  Created by ios8207 on 05/02/19.
//  Copyright © 2019 Caelum. All rights reserved.
//

#import "Contato.h"

@implementation Contato

- (NSString *)description {
    return [NSString stringWithFormat:@"Nome: %@, Telefone: %@, Endereço: %@, Site: %@", self.nome, self.telefone, self.endereco, self.site];
}

- (CLLocationCoordinate2D) coordinate{
    return CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
}

- (NSString *) title {
    return self.nome;
}

- (NSString *) subtitle {
    return self.site;
}

@end
