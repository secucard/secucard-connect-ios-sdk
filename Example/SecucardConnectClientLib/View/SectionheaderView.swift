//
//  SectionheaderView.swift
//  SecucardConnectClientLib
//
//  Created by Jörn Schmidt on 10.06.15.
//  Copyright (c) 2015 Jörn Schmidt. All rights reserved.
//

import UIKit

class SectionheaderView: UICollectionReusableView {
  
  let label: UILabel = UILabel()
  
  override init(frame: CGRect) {
    
    super.init(frame: frame)

    label.textColor = Constants.textColor
    self.addSubview(label)
    label.snp_makeConstraints { (make) -> Void in
      make.top.height.right.equalTo(self)
      make.left.equalTo(10)
    }

    self.backgroundColor = Constants.brightGreyColor
    
  }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
}
