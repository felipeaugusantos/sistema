inherited frmItensSemPro: TfrmItensSemPro
  Left = 294
  Top = 328
  Width = 618
  Height = 269
  Caption = 'Itens com promo'#231#227'o excedida'
  Position = poScreenCenter
  ExplicitWidth = 618
  ExplicitHeight = 269
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 196
    Width = 612
    ExplicitTop = 196
    ExplicitWidth = 612
    inherited btnSair: TBitBtnLocked
      Left = 529
      ExplicitLeft = 529
    end
  end
  object dbgDados: TDBGridCitel [2]
    Left = 0
    Top = 0
    Width = 612
    Height = 196
    Align = alClient
    Ctl3D = False
    DataSource = dtsDados
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'CODITE'
        Title.Caption = 'C'#243'digo'
        Width = 55
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRI'
        Title.Caption = 'Descri'#231#227'o'
        Width = 317
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'QTDLIM'
        Title.Caption = 'Qt. Limite'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALPRO'
        Title.Caption = 'Vr. Promo'#231#227'o'
        Width = 72
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALSPR'
        Title.Caption = 'Vr. Atual'
        Width = 66
        Visible = True
      end>
  end
  inherited pnlStatus: TPanel
    Top = 224
    Width = 612
    ExplicitTop = 224
    ExplicitWidth = 612
    inherited pnlNomeForm: TPanel
      Left = 441
      ExplicitLeft = 441
    end
    inherited pnlInfo: TPanel
      Width = 441
      ExplicitWidth = 441
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 696
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 696
  end
  object dtsDados: TDataSource
    DataSet = cdsDados
    Left = 496
    Top = 144
  end
  object cdsDados: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 552
    Top = 144
    object cdsDadosCODITE: TStringField
      FieldName = 'CODITE'
      Size = 7
    end
    object cdsDadosDESCRI: TStringField
      FieldName = 'DESCRI'
      Size = 70
    end
    object cdsDadosUNIDAD: TStringField
      FieldName = 'UNIDAD'
      Size = 4
    end
    object cdsDadosVALPRO: TFloatField
      FieldName = 'VALPRO'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsDadosVALSPR: TFloatField
      FieldName = 'VALSPR'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsDadosQTDLIM: TFloatField
      FieldName = 'QTDLIM'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsDadosQTDEXC: TFloatField
      FieldName = 'QTDEXC'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsDadosQTDITE: TFloatField
      FieldName = 'QTDITE'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsDadosAUTINC: TStringField
      FieldName = 'AUTINC'
    end
  end
end
