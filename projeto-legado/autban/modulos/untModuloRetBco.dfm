object frmModuloRetBco: TfrmModuloRetBco
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 150
  Width = 215
  object qryRetBco: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT * FROM RETBCO'
      '')
    Constraints = <>
    Left = 24
    Top = 19
    object qryRetBcoRET_CODBCO: TStringField
      FieldName = 'RET_CODBCO'
      Required = True
      Size = 3
    end
    object qryRetBcoRET_CODEMP: TStringField
      FieldName = 'RET_CODEMP'
      Required = True
      Size = 3
    end
    object qryRetBcoRET_CODCLI: TStringField
      FieldName = 'RET_CODCLI'
      Size = 8
    end
    object qryRetBcoRET_CODOCO: TStringField
      FieldName = 'RET_CODOCO'
      Size = 5
    end
    object qryRetBcoRET_DTAOCO: TDateField
      FieldName = 'RET_DTAOCO'
    end
    object qryRetBcoRET_NUMDUP: TStringField
      DisplayWidth = 12
      FieldName = 'RET_NUMDUP'
      Size = 12
    end
    object qryRetBcoRET_PARCEL: TStringField
      FieldName = 'RET_PARCEL'
      Size = 3
    end
    object qryRetBcoRET_ESPDOC: TStringField
      FieldName = 'RET_ESPDOC'
      Size = 2
    end
    object qryRetBcoRET_NOSNUM: TStringField
      FieldName = 'RET_NOSNUM'
      Size = 12
    end
    object qryRetBcoRET_DTAPAG: TDateField
      FieldName = 'RET_DTAPAG'
    end
    object qryRetBcoRET_VALPAG: TFloatField
      FieldName = 'RET_VALPAG'
    end
    object qryRetBcoRET_DESCON: TFloatField
      FieldName = 'RET_DESCON'
    end
    object qryRetBcoRET_JURMOR: TFloatField
      FieldName = 'RET_JURMOR'
    end
    object qryRetBcoRET_DTAVEN: TDateField
      FieldName = 'RET_DTAVEN'
    end
    object qryRetBcoRET_VALDUP: TFloatField
      FieldName = 'RET_VALDUP'
    end
    object qryRetBcoRET_NOMARQ: TStringField
      FieldName = 'RET_NOMARQ'
    end
    object qryRetBcoRET_CODREJ: TStringField
      FieldName = 'RET_CODREJ'
      Size = 2
    end
    object qryRetBcoRET_MOTOCO: TStringField
      FieldName = 'RET_MOTOCO'
    end
    object qryRetBcoRET_DTAARQ: TDateField
      FieldName = 'RET_DTAARQ'
    end
    object qryRetBcoRET_HORARQ: TTimeField
      FieldName = 'RET_HORARQ'
    end
    object qryRetBcoRET_CARTEI: TIntegerField
      FieldName = 'RET_CARTEI'
    end
    object qryRetBcoRET_CONRET: TStringField
      FieldName = 'RET_CONRET'
      Size = 8
    end
    object qryRetBcoRET_OUTCOB: TFloatField
      FieldName = 'RET_OUTCOB'
    end
    object qryRetBcoRET_DUPBAI: TStringField
      FieldName = 'RET_DUPBAI'
      Size = 1
    end
    object qryRetBcoRET_DUPDIV: TStringField
      FieldName = 'RET_DUPDIV'
      Size = 1
    end
    object qryRetBcoRET_MOTDIV: TStringField
      FieldName = 'RET_MOTDIV'
      Size = 40
    end
    object qryRetBcoRET_DTACRE: TDateField
      FieldName = 'RET_DTACRE'
    end
    object qryRetBcoRET_OUTVAL: TFloatField
      FieldName = 'RET_OUTVAL'
    end
    object qryRetBcoRET_TARIFA: TFloatField
      FieldName = 'RET_TARIFA'
    end
    object qryRetBcoRET_VALLAN: TFloatField
      FieldName = 'RET_VALLAN'
    end
    object qryRetBcoRET_CUSCAR: TFloatField
      FieldName = 'RET_CUSCAR'
    end
    object qryRetBcoRET_CARBCO: TStringField
      FieldName = 'RET_CARBCO'
      Size = 3
    end
    object qryRetBcoRET_IOFDES: TFloatField
      FieldName = 'RET_IOFDES'
    end
    object qryRetBcoRET_TXADES: TFloatField
      FieldName = 'RET_TXADES'
    end
    object qryRetBcoRET_DUPDES: TStringField
      FieldName = 'RET_DUPDES'
      Size = 1
    end
    object qryRetBcoRET_JUROPE: TFloatField
      FieldName = 'RET_JUROPE'
    end
    object qryRetBcoRET_CNAB__: TStringField
      FieldName = 'RET_CNAB__'
      Size = 3
    end
    object qryRetBcoRET_TARTED: TFloatField
      FieldName = 'RET_TARTED'
    end
    object qryRetBcoRET_RECPIX: TStringField
      FieldName = 'RET_RECPIX'
      Size = 1
    end
    object qryRetBcoRET_END_ID: TStringField
      FieldName = 'RET_END_ID'
      Size = 50
    end
    object qryRetBcoRET_EMPIMP: TStringField
      FieldName = 'RET_EMPIMP'
      Size = 3
    end
    object qryRetBcoRET_ERRPIX: TStringField
      FieldName = 'RET_ERRPIX'
      Size = 3
    end
    object qryRetBcoRET_QRCODE: TMemoField
      FieldName = 'RET_QRCODE'
    end
  end
  object dtsRetBco: TDataSource
    DataSet = qryRetBco
    Left = 88
    Top = 19
  end
end
