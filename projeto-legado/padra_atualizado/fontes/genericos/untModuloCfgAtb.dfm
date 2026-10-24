object frmModuloCfgAtb: TfrmModuloCfgAtb
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 215
  Width = 294
  object qryCfgAtb: TUniQuery
    Connection = frmModulo.Database
    SQL.Strings = (
      'SELECT *'
      '  FROM CFGATB'
      ' WHERE ATB_NOMFOR = :NOMFOR'
      '   AND ATB_NOMCAM = :NOMCAM')
    Left = 48
    Top = 24
    ParamData = <
      item
        DataType = ftString
        Name = 'NOMFOR'
        Value = nil
      end
      item
        DataType = ftString
        Name = 'NOMCAM'
        Value = nil
      end>
    object qryCfgAtbATB_NOMFOR: TStringField
      DisplayLabel = 'Nome do Formul'#225'rio'
      FieldName = 'ATB_NOMFOR'
      Size = 50
    end
    object qryCfgAtbATB_NOMCAM: TStringField
      DisplayLabel = 'Nome do Campo'
      FieldName = 'ATB_NOMCAM'
      Size = 30
    end
    object qryCfgAtbATB_DESCAM: TMemoField
      DisplayLabel = 'Instru'#231#245'es'
      FieldName = 'ATB_DESCAM'
      BlobType = ftMemo
    end
    object qryCfgAtbAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
  end
  object dtsCfgAtb: TDataSource
    DataSet = qryCfgAtb
    Left = 104
    Top = 24
  end
end
