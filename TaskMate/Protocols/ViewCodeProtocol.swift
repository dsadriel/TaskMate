//
//  ViewCodeProtocol.swift
//  viewCodeLogin
//
//  Created by Adriel de Souza on 02/05/25.
//

protocol ViewCodeProtocol {
    func addSubViews()
    func setupConstraints()
    func setup()
}

extension ViewCodeProtocol {
    func setup() {
        addSubViews()
        setupConstraints()
    }
}
