################################################################################
#
# Copyright 2015 Crown copyright (c)
# Land Information New Zealand and the New Zealand Government.
# All rights reserved
#
# This program is released under the terms of the new BSD license. See the 
# LICENSE file for more information.
#
################################################################################


from PyQt4.QtCore import *
from PyQt4.QtGui import *


class ValidatorList( QObject ):
    
    class Validator( QObject ):
        
        def __init__( self, parent, widget, validator, message ):
            QObject.__init__(self,parent)
            self.widget = widget
            self.validate = validator
            self.message = message
    
    def __init__( self, parent=None ):
        QObject.__init__(self,parent)
        self._parent = parent
        self._validators = []
        
        
    def parent( self ):
        return _self.parent
    
    def setParent( self, parent ):
        self._parent = parent
        
    def addValidator( self, widget, validator, message ):
        validfunc = None
        if not message and widget:
            message = "Error in "+widget.objectName()
        if not message:
            message = "Error in validator "+str(validator)
        if callable(validator):
            validfunc = validator
        else:
            if isinstance( validator, basestring ):
                validator = QRegExp(validator)
            if isinstance( validator, QRegExp ):
                validator = QRegExpValidator(QRegExp(validator),self._parent)
            if isinstance( validator, QValidator ):
                if isinstance(widget,QLineEdit):
                    widget.setValidator( validator )
                    validfunc = lambda : validator.validate(widget.text(),0)[0] == QValidator.Acceptable
        if callable(validfunc):
            self._validators.append(ValidatorList.Validator(self,widget,validfunc,message))
        else:
            raise RuntimeError(str(validator)+" is not a validator for "+widget.objectName())
            
    def validate(self):
        messages = []
        valid = True
        widget = None
        for v in self._validators:
            if not v.validate():
                valid = False
                messages.append(v.message)
                if not widget:
                    widget = v.widget
        return valid, messages, widget